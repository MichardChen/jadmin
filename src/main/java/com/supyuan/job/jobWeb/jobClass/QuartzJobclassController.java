package com.supyuan.job.jobWeb.jobClass;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.plugin.activerecord.Page;
import com.supyuan.component.base.BaseProjectController;
import com.supyuan.jfinal.component.annotation.ControllerBind;
import com.supyuan.job.jobWeb.job.QuartzJob;
import com.supyuan.util.StrUtils;
import com.supyuan.util.extend.UuidUtils;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yuanxuyun on 2017/4/19.
 */
@ControllerBind(controllerKey = "/quartz/jobclass")
public class QuartzJobclassController extends BaseProjectController {

    public static final String path = "/pages/quartz/jobclass/class_";

    /**
     * 辅助命名
     */
    private int paramscount = 0;

    /**
     * 存放参数的map
     */
    private Map<String, String> params = new HashMap<String, String>();

    /**
     * 存放参数名称 的 Map
     */
    private Map<String, String> paramNamemap = new HashMap<String, String>();

    /**
     * 辅助命名2
     */
    private int paramNamecount = 0;

    /**
     * 列表
     */
    public void list() {
        String sql = "SELECT uids, name, class_all_name AS classAllName, function_name AS functionName, remark";
        String sqlExceptSelect = " FROM job_class t";
        Page<QuartzJobclass> page = QuartzJobclass.dao.paginate(getPaginator(), sql, sqlExceptSelect);
        setAttr("page", page);
        render(path + "list.html");
    }

    public void add() {
        render(path + "add.html");
    }

    /**
     * 删除
     */
    public void del() {
        try {
            String uids = getPara();
            List<QuartzJob> list = new QuartzJob().dao().findByWhere("where jobclass_uids = ?", uids);
            if (list != null && list.size() > 0) {
                setAttr("msg", "操作失败，当前执行类已有对应的job任务。");
            } else {
                Db.tx(new IAtom() {
                    @Override
                    public boolean run() throws SQLException {
                        List<JobClassParam> params = JobClassParam.dao.findByWhere("where jobclass_uids = ?", getPara());
                        for (JobClassParam classParam : params) {
                            classParam.delete();
                        }
                        QuartzJobclass.dao.deleteById(getPara());
                        return true;
                    }
                });
                setAttr("msg", "");
            }
        } catch (Exception e) {
            setAttr("msg", "操作失败" + e.getMessage());
        }
        list();
    }

    public void save() {
        boolean bool = false;
        String uids = getPara();
        QuartzJobclass jobclass = getModel(QuartzJobclass.class);
        if (!StrUtils.isEmpty(uids)) {
            jobclass.update();
        } else {
            jobclass.put("uids", UuidUtils.getUUID2());
            // 验证类全名 以及 方法名称
            QuartzJobClassSvc jobClassSvc = new QuartzJobClassSvc();
            String classAllName = jobclass.get("class_all_name");
            String flag = jobClassSvc.CkeckClassAllName(classAllName);
            String functionName = jobclass.get("function_name");
            if (!"no".equals(flag)) {
                flag = jobClassSvc.ckeckFunctionName(functionName, classAllName);
                if (!"no".equals(flag)) {
                    bool = jobclass.save();
                }
            }
            if (bool) {
                //处理子表
                // 得到 返回值类型 方法名称 参数类型
                Map<String, String> map = jobClassSvc.reflectMethod(classAllName, functionName);
                String methodsName = map.get("methodName");
                String returnTypeName = map.get("returnTypeName");
                while (paramscount < map.size() - 2) {
                    params.put("param" + paramscount, map
                            .get("param" + paramscount));
                    paramscount++;
                }
                paramscount = 0;

                paramNamemap.clear();
                // 得到 参数名称
                Map<String, String> pmmap = jobClassSvc.getParamName(classAllName, methodsName);
                while (paramNamecount < pmmap.size()) {
                    paramNamemap.put("paramName" + paramNamecount, pmmap
                            .get("paramName" + paramNamecount));
                    paramNamecount++;
                }
                paramNamecount = 0;

                //保存方法参数
                System.out.println("><" + jobclass.get("class_all_name"));
                int count = 0;
                while (count < params.size()) {
                    JobClassParam classparam = new JobClassParam();
                    classparam.put("uids", UuidUtils.getUUID2());
                    classparam.put("classparam_state", "1");
                    classparam.put("classparam_type", "1");
                    classparam.put("classparam_name", paramNamemap.get("paramName" + count).toString());
                    classparam.put("return_type", returnTypeName);
                    classparam.put("jobclass_uids", jobclass.get("uids"));
                    classparam.put("param_type", params.get("param" + count).toString());
                    bool = classparam.save();
                    count++;
                }


            }
        }

        renderMessage("保存成功");
        //renderJson();
    }

    /**
     * 查看参数详情
     */
    public void view() {
        String jobclassUids = getPara();
        StringBuffer sbf = new StringBuffer();
        sbf.append("SELECT CLASSPARAM_NAME AS paramName, PARAM_TYPE AS paramType, ");
        sbf.append("RETURN_TYPE AS returnType FROM job_class_param ");
        sbf.append("WHERE JOBCLASS_UIDS = '");
        sbf.append(jobclassUids + "'");
        List<JobClassParam> classparamList = JobClassParam.dao.find(sbf.toString());
        setAttr("classparamList", classparamList);
        render(path + "view.html");
    }
}
