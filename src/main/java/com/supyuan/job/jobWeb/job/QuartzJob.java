package com.supyuan.job.jobWeb.job;


import com.supyuan.jfinal.base.BaseModel;
import com.supyuan.jfinal.component.annotation.ModelBind;

/**
 * Created by yuanxuyun on 2017/4/20.
 */
@ModelBind(table = "job", key = "uids")
public class QuartzJob extends BaseModel<QuartzJob> {
    public static final QuartzJob dao = new QuartzJob();
}
