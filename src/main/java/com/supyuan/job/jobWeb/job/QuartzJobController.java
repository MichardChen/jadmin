package com.supyuan.job.jobWeb.job;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.plugin.activerecord.Page;
import com.supyuan.component.base.BaseProjectController;
import com.supyuan.jfinal.component.annotation.ControllerBind;
import com.supyuan.job.JobFactoryServiceImpl;
import com.supyuan.job.jobWeb.jobClass.JobClassParam;
import com.supyuan.job.jobWeb.jobClass.QuartzJobclass;
import com.supyuan.job.jobWeb.jobClass.QuartzParamValue;
import com.supyuan.util.DateUtils;
import com.supyuan.util.StrUtils;
import com.supyuan.util.extend.UuidUtils;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Created by yuanxuyun on 2017/4/20.
 */
@ControllerBind(controllerKey = "/quartz/jobs")
public class QuartzJobController extends BaseProjectController {
    public static final String path = "/pages/quartz/jobs/job_";

    public void list() {
        String sql = "SELECT uids, job_name AS jobName, ( SELECT name FROM job_class WHERE uids = t.JOBCLASS_UIDS" +
                " ) AS jobclassUids, t.to_quartztimes AS quartztimes, job_state AS jobState , CREATE_DATE AS " +
                "createDate, REMARK AS remark, JOB_CONTENT as jobContent ";
        String sqlExceptSelect = " from job t";
        Page<QuartzJob> page = QuartzJob.dao.paginate(getPaginator(), sql, sqlExceptSelect);
        setAttr("page", page);
        render(path + "list.html");

    }

    public void add() {
        /**
         * 1拿到所有触发器
         * 2拿到所有执行类
         * 3去新增页面
         */
        //String tSql = "select UIDS as uids,TRIGGER_NAME as triggerName from job_trigger";
        //List<QuartzTrigger> triggeList = QuartzTrigger.dao.find(tSql);
        String cSql = "select UIDS as uids,name from job_class";
        List<QuartzJobclass> jobclassLsit = QuartzJobclass.dao.find(cSql);
        //setAttr("triggeList", triggeList);
        setAttr("jobclassLsit", jobclassLsit);
        render(path + "add.html");
    }

    /**
     * 保存或者修改
     */
    public void save() {
        //保持事物一致性
        Db.tx(new IAtom() {
            @Override
            public boolean run() throws SQLException {
                String uids = getPara();
                if (!StrUtils.isEmpty(uids) && "pValue".equals(uids)) {
                    //更新 执行类的参数值
                    Map<String, String[]> map = getParaMap();
                    String uidsArr[] = map.get("model.uids");
                    String valueArr[] = map.get("model.paramvalue_value");
                    if (uidsArr != null) {
                        for (int i = 0, k = uidsArr.length; i < k; i++) {
                            QuartzParamValue paramValue = getModel(QuartzParamValue.class);
                            paramValue.put("uids", uidsArr[i]);
                            paramValue.put("paramvalue_value", valueArr[i]);
                            paramValue.update();
                        }
                    }
                } else {
                    QuartzJob job = getModel(QuartzJob.class);
                    uids = UuidUtils.getUUID2();
                    job.put("uids", uids);
                    String create_time = DateUtils.timestampToDate(System.currentTimeMillis(), "yyyy-MM-dd HH:mm:ss");
                    job.put("create_date", create_time);
                    boolean bol = job.save();
                    //开始保存 执行类的参数值
                    String jobclassUids = job.get("jobclass_uids");
                    //获取任务执行类的参数
                    String sql = "select * from job_class_param where JOBCLASS_UIDS ='" + jobclassUids + "'";
                    List<JobClassParam> classparamList = JobClassParam.dao.find(sql);
                    for (int i = 0, k = classparamList.size(); i < k; i++) {
                        //执行类的参数值 初始数据
                        QuartzParamValue paramValue = new QuartzParamValue();
                        uids = UuidUtils.getUUID2();
                        paramValue.put("uids", uids);
                        paramValue.put("paramvalue_name", classparamList.get(i).get("classparam_name"));
                        paramValue.put("param_uids", classparamList.get(i).get("uids"));
                        paramValue.put("job_uids", job.get("uids"));
                        paramValue.put("state", "1");
                        paramValue.put("paramvalue_value", "0");
                        paramValue.save();
                    }

                }
                renderMessage("保存成功");
                return true;
            }
        });

    }

    /**
     * 编辑
     */
    public void edit() {
        String uids = getPara();
        String sql = "SELECT uids, job_name AS jobName, ( SELECT name FROM job_class WHERE uids = " +
                "t.JOBCLASS_UIDS ) AS cName, t.to_quartztimes AS quartztimes  FROM job t where t.uids ='" + uids + "'";
        QuartzJob job = QuartzJob.dao.findFirst(sql);
        //获取 job_param_value job执行类参数表数据
        sql = "select uids, PARAMVALUE_NAME as pName, PARAMVALUE_VALUE as pValue from job_param_value " +
                "where JOB_UIDS ='" + uids + "'";
        List<QuartzParamValue> values = QuartzParamValue.dao.find(sql);
        setAttr("job", job);
        setAttr("values", values);
        render(path + "edit.html");
    }

    /**
     * 加入job到任务池中
     */
    public void addJob() {
        JSONObject json = new JSONObject();
        String uids = getPara();
        try {
            QuartzJob quartzJob = QuartzJob.dao.findById(uids);
            JobFactoryServiceImpl factoryService = new JobFactoryServiceImpl();
            factoryService.addJob(quartzJob);
            quartzJob.set("job_state", "0");
            quartzJob.update();
            //Db.update("UPDATE job set JOB_STATE = '0' WHERE UIDS ='"+quartzJob.get("UIDS")+"'");
            json.put("msg", "任务启动成功!");
            renderJson(json.toJSONString());
        } catch (Exception e) {
            json.put("msg", "任务启动失败!" + e.getMessage());
            renderJson(json.toJSONString());
        }

    }

    /**
     * 停用
     */
    public void stopJobs() {
        JSONObject json = new JSONObject();
        String uids = getPara();
        try {
            QuartzJob quartzJob = QuartzJob.dao.findById(uids);
            JobFactoryServiceImpl factoryService = new JobFactoryServiceImpl();
            factoryService.removeTrigger(quartzJob);
            quartzJob.set("job_state", "1");
            quartzJob.update();
            //Db.update("UPDATE job set JOB_STATE = '1' WHERE UIDS ='"+quartzJob.get("UIDS")+"'");
            json.put("msg", "停用成功!");
            renderJson(json.toJSONString());
        } catch (Exception e) {
            json.put("msg", "停用失败!" + e.getMessage());
            renderJson(json.toJSONString());
        }
    }

    /**
     * 执行一次
     */
    public void runJobsOnce() {
        JSONObject json = new JSONObject();
        String uids = getPara();
        try {
            QuartzJob quartzJob = QuartzJob.dao.findById(uids);
            JobFactoryServiceImpl factoryService = new JobFactoryServiceImpl();
            factoryService.triggerJob(quartzJob);
            json.put("msg", "执行成功!");
            renderJson(json.toJSONString());
        } catch (Exception e) {
            json.put("msg", "执行失败!" + e.getMessage());
            renderJson(json.toJSONString());
        }
    }

    /**
     * 刪除数据
     */
    public void deleteJob() {
        JSONObject json = new JSONObject();
        try {
            //保持事物一致性
            Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    String uids = getPara();
                    QuartzJob quartzJob = QuartzJob.dao.findById(uids);
                    JobFactoryServiceImpl factoryService = new JobFactoryServiceImpl();
                    factoryService.deleteQuartzQorkByJob(quartzJob);
                    return true;
                }
            });
            json.put("msg", "删除成功!");
            renderJson(json.toJSONString());
        } catch (Exception e) {
            json.put("msg", "删除失败!" + e.getMessage());
            renderJson(json.toJSONString());
        }
    }

}
