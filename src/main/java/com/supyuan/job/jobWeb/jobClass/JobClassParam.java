package com.supyuan.job.jobWeb.jobClass;


import com.supyuan.jfinal.base.BaseModel;
import com.supyuan.jfinal.component.annotation.ModelBind;

/**
 * 执行类参数信息
 * Created by yuanxuyun on 2017/4/20.
 */
@ModelBind(table = "job_class_param", key = "uids")
public class JobClassParam extends BaseModel<JobClassParam> {
    public static final JobClassParam dao = new JobClassParam();
}
