package com.supyuan.job;

import com.jfinal.log.Log;
import com.supyuan.job.jobWeb.job.QuartzJob;
import com.supyuan.job.jobWeb.jobClass.QuartzJobclass;
import com.supyuan.job.jobWeb.jobClass.QuartzParamValue;
import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;

import java.util.List;
import java.util.TimeZone;


/**
 * Created by yuanxuyun on 2017/4/20.
 */
public class JobFactoryServiceImpl implements JobFactoryService {
    protected static final Log logger = Log.getLog(JobFactoryService.class);
    private Scheduler scheduler = null;

    public JobFactoryServiceImpl() {
        try {
            if (scheduler == null) {
                SchedulerFactory schedulerFactory = new StdSchedulerFactory();
                scheduler = schedulerFactory.getScheduler();
            }
            scheduler.start();

        } catch (SchedulerException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    @Override
    public void addJob(QuartzJob job) throws Exception {
        String jobclassUids = job.get("jobclass_uids");
        //String triggerUids = job.get("TRIGGER_UIDS");
        String jobUids = job.get("uids") + "";
        QuartzJobclass runClass = QuartzJobclass.dao.findById(jobclassUids);
        // 先查找是否已经存在
        JobDetail detail;
        try {
            detail = scheduler.getJobDetail(jobUids, Scheduler.DEFAULT_GROUP);


            if (detail == null) {// 任务不存在

                Class<?> JobClass = null;
                //QuartzTrigger quartzTrigger = QuartzTrigger.dao.findById(triggerUids);

                // 若不存在如下处理
                String classAllname = runClass.get("class_all_name");
                JobClass = Class.forName(classAllname);
                // 1、创建JobDetial对象
                JobDetail jobDetail = new JobDetail();
                jobDetail.setJobClass(JobClass);
                jobDetail.setName(jobUids);
                jobDetail.setGroup(Scheduler.DEFAULT_GROUP);
                // 设置执行类的参数值
                String sql = "select * from job_param_value where JOB_UIDS ='" + jobUids + "'";
                List<QuartzParamValue> paramValues = QuartzParamValue.dao.find(sql);
                JobDataMap jobDataMap = new JobDataMap();
                jobDataMap.put("functionName", runClass.get("function_name"));
                jobDataMap.put("jobContent", job.get("job_content"));

                jobDataMap.put("jobUids", jobUids);
                if (paramValues != null && paramValues.size() > 0) {
                    for (QuartzParamValue value : paramValues) {
                        String paramName = value.get("paramvalue_name");
                        String paramValue = value.get("paramvalue_value");
                        jobDataMap.put(paramName, paramValue);
                    }

                }
                jobDetail.setJobDataMap(jobDataMap);
                // scheduler.addJob(jobDetail, true);

                // 2、创建Trigger对象
                CronTrigger trigger = new CronTrigger(jobUids, Scheduler.DEFAULT_GROUP);
                // 设置触发时间
                TimeZone tz = TimeZone.getTimeZone("Etc/GMT-8");
                trigger.setTimeZone(tz);
                //获得时间规则
                //QuartzTimes times = QuartzTimes.dao.findById(quartzTrigger.get("TIMES_UIDS"));
                trigger.setCronExpression(job.get("to_quartztimes") + "");
                scheduler.scheduleJob(jobDetail, trigger);
                if (scheduler.isShutdown()) {
                    scheduler.start();
                }

            } else {
                // 如果任务已经存在,重启任务
                resumeTrigger(job);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.debug("名为：" + job.get("job_name") + " 的JOB初始化加载触发器失败！此job可能不执行！");
            logger.error("error:" + e.getStackTrace());
        }

    }

    @Override
    public String[] getJobNames() throws SchedulerException {
        return scheduler.getJobNames(Scheduler.DEFAULT_GROUP);
    }

    @Override
    public void addJobList() {
        //查询出所有启用状态的job
        List<QuartzJob> jobs = QuartzJob.dao.find("select * from job where JOB_STATE ='0'");
        try {
            if (jobs != null) {
                for (QuartzJob job : jobs) {
                    this.addJob(job);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public void parseTrigger(QuartzJob job) {
        System.out.println("***************停止触发器***************");
        try {
            scheduler.pauseTrigger(job.get("uids") + "", Scheduler.DEFAULT_GROUP);
        } catch (SchedulerException e) {
            e.printStackTrace();
            logger.error("error:" + e.getStackTrace());
        }
    }

    @Override
    public boolean removeTrigger(QuartzJob job) {
        System.out.println("***************移除触发器***************");
        try {
            parseTrigger(job);
            //System.out.println("####>> " + scheduler.unscheduleJob(job.get("uids") + "", Scheduler.DEFAULT_GROUP));
            return scheduler.unscheduleJob(job.get("uids") + "", Scheduler.DEFAULT_GROUP);
        } catch (SchedulerException e) {
            e.printStackTrace();
            logger.error("error" + e.getStackTrace());
        }
        return false;
    }

    @Override
    public void resumeTrigger(QuartzJob job) {
        System.out.println("***************重启触发器***************");
        try {
            scheduler.resumeTrigger(job.get("uids") + "", Scheduler.DEFAULT_GROUP);
        } catch (SchedulerException e) {
            e.printStackTrace();
            logger.error("error" + e.getStackTrace());
        }
    }

    @Override
    public boolean triggerJob(QuartzJob job) {
        try {
            scheduler.triggerJob(job.get("uids") + "", Scheduler.DEFAULT_GROUP);
            return true;
        } catch (SchedulerException e) {
            e.printStackTrace();
            logger.error("error" + e.getStackTrace());
        }
        return false;
    }

    @Override
    public Scheduler getScheduler() {
        return this.scheduler;
    }

    @Override
    public void deleteQuartzQorkByJob(QuartzJob job) {
        this.removeTrigger(job);
        System.out.println("***************删除job数据***************");
        //先删除参数列表
        String sql = "select * from job_param_value where JOB_UIDS ='" + job.get("uids") + "'";
        List<QuartzParamValue> paramValues = QuartzParamValue.dao.find(sql);
        for (QuartzParamValue paramValue : paramValues) {
            paramValue.delete();
        }
        //再删除当前任务
        job.delete();
    }

    @Override
    public void doCascadeJobDelete(String uids, String type) {
        logger.debug("暂不实现");
    }
}
