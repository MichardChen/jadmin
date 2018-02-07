package com.supyuan.system.auth;

import com.supyuan.component.base.BaseProjectModel;
import com.supyuan.jfinal.component.annotation.ModelBind;

/**
 * SysAuth
 *
 * @Author 袁旭云【rain.yuan@transn.com】
 * @Date 2017/11/29 15:30
 */
@ModelBind(table = "sys_auth")
public class SysAuth extends BaseProjectModel<SysAuth> {

    private static final long serialVersionUID = 20171129153232L;
    public static final SysAuth dao = new SysAuth();
}
