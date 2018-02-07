package com.supyuan.job;

import com.supyuan.job.jobWeb.job.QuartzJob;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;

/**
 * Created by yuanxuyun on 2017/4/20.
 */
public interface JobFactoryService {
    /**
     * 根据job添加任务到任务池中
     * @param job
     * @throws Exception
     */
    public void addJob(QuartzJob job) throws Exception;

    /**
     * 获取所有的任务名称
     * @return
     * @throws SchedulerException
     */
    public String[] getJobNames() throws SchedulerException;

    /**
     * 将任务添加到job执行池中
     */
    public void addJobList();

    /**
     * 根据job停止触发器
     * @param job 传入的job任务
     */
    public void parseTrigger(QuartzJob job);

    /**
     * 移除触发器
     * @param job 传入的job任务
     * @return
     */
    public boolean removeTrigger(QuartzJob job);
    /**
     * 重启触发器
     * @param job 传入的job任务
     */
    public void resumeTrigger(QuartzJob job);

    /**
     * 执行触发器
     * @param job
     * @return
     */
    public boolean triggerJob(QuartzJob job);
    /**
     * 获得Scheduler对象
     * @return
     */
    public Scheduler getScheduler();
    /**
     * 更加job删除任务相关
     * @param job
     */
    public void deleteQuartzQorkByJob(QuartzJob job);
    /**
     * 删除关联业务时级联删除规业务对应对应的任务调度数据
     * @param uids 业务主键
     * @param type 标示 值为 0 1 <br>
     * 如果时间规则固定公用的不需要删除掉 那么type的值请传入 0 <br>
     * 如果时间规则跟随业务特定生成的只对当前job有用可以考虑删掉 那么type的值请传入 1
     */
    public void doCascadeJobDelete(String uids, String type);
}
