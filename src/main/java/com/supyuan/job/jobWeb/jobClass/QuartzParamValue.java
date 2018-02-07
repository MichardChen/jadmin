package com.supyuan.job.jobWeb.jobClass;


import com.supyuan.jfinal.base.BaseModel;
import com.supyuan.jfinal.component.annotation.ModelBind;

/**
 * job执行类参数值
 * Created by yuanxuyun on 2017/4/20.
 */
@ModelBind(table = "job_param_value", key = "uids")
public class QuartzParamValue extends BaseModel<QuartzParamValue> {
    public static final QuartzParamValue dao = new QuartzParamValue();
}
