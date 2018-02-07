package com.supyuan.job.jobWeb.jobLog;

import com.jfinal.plugin.activerecord.Page;
import com.supyuan.component.base.BaseProjectController;
import com.supyuan.jfinal.component.annotation.ControllerBind;

/**
 * jobLogController 执行日志
 *
 * @Author 袁旭云【rain.yuan@transn.com】
 * @Date 2017/6/4 11:13
 */
@ControllerBind(controllerKey = "/quartz/log")
public class jobLogController extends BaseProjectController {
    public static final String path = "/pages/quartz/log/log_";

    public void list() {
        System.out.println(System.currentTimeMillis());
        String sql = "SELECT uids, begintimes,endtimes, state, remark, nextruntime, run_ip ";
        String sqlExceptSelect = " FROM job_log t ORDER BY t.begintimes DESC";
        Page<JobLog> page = JobLog.dao.paginate(getPaginator(), sql, sqlExceptSelect);
        setAttr("page", page);
        render(path + "list.html");
    }
}
