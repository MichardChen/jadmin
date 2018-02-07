package com.supyuan.job.jobWeb.jobLog;


import com.supyuan.jfinal.base.BaseModel;
import com.supyuan.jfinal.component.annotation.ModelBind;

/**
 * Created by yuanxuyun on 2017/4/21.
 */
@ModelBind(table = "job_log", key = "uids")
public class JobLog extends BaseModel<JobLog> {
    public static final JobLog dao = new JobLog();
}
