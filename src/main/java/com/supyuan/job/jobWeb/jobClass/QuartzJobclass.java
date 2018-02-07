package com.supyuan.job.jobWeb.jobClass;


import com.supyuan.jfinal.base.BaseModel;
import com.supyuan.jfinal.component.annotation.ModelBind;

/**
 * 执行类
 * Created by yuanxuyun on 2017/4/19.
 */
@ModelBind(table = "job_class", key = "uids")
public class QuartzJobclass extends BaseModel<QuartzJobclass> {
    public static final QuartzJobclass dao = new QuartzJobclass();
}
