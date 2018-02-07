package com.supyuan.system.auth;

import com.jfinal.plugin.activerecord.Page;
import com.supyuan.component.base.BaseProjectController;
import com.supyuan.jfinal.component.annotation.ControllerBind;
import com.supyuan.jfinal.component.db.SQLUtils;
import com.supyuan.system.department.DepartmentSvc;
import com.supyuan.system.department.SysDepartment;
import com.supyuan.system.user.SysUser;
import com.supyuan.util.StrUtils;

import java.util.List;

/**
 * SysAuthController
 *
 * @Author 袁旭云【rain.yuan@transn.com】
 * @Date 2017/11/29 15:30
 */
@ControllerBind(controllerKey = "/system/sysauth")
public class SysAuthController extends BaseProjectController {

    private static final String path = "/pages/system/auth/auth_";

    public void index() {
        list();
    }

    public void list() {
        SysAuth model = getModelByAttr(SysAuth.class);

        SQLUtils sql = new SQLUtils(" from sys_auth t where 1=1 ");
        if (model.getAttrValues().length != 0) {
            sql.setAlias("t");
            // 查询条件
            String isHalt = this.getPara("attr.is_halt");
            if (!StrUtils.isEmpty(isHalt) && !"-1".equals(isHalt)) {
                sql.whereLike("is_halt", isHalt);
            }

            String descript = this.getPara("attr.descript");
            if (!StrUtils.isEmpty(descript)) {
                sql.whereLike("descript", descript);
            }

        }
        // 排序
        String orderBy = getBaseForm().getOrderBy();
        if (StrUtils.isEmpty(orderBy)) {
            sql.append(" order by t.id desc ");
        } else {
            sql.append(" order by ").append(orderBy);
        }

        Page<SysAuth> page = SysAuth.dao.paginate(getPaginator(),
                "select t.* ", sql.toString().toString());

        // 下拉框
        setAttr("page", page);
        setAttr("attr", model);
        render(path + "list.html");
    }

    public void add() {
        render(path + "add.html");
    }

    public void view() {
        SysAuth model = SysAuth.dao.findById(getPara());
        setAttr("model", model);
        render(path + "view.html");
    }

    public void delete() {
        String pid = getPara();
        SysAuth model = new SysAuth();
        model.deleteById(pid);

        list();
    }

    public void edit() {
        SysAuth model = SysAuth.dao.findById(getPara());
        setAttr("model", model);
        render(path + "edit.html");
    }

    public void save() {
        String pid = getPara();
        try {

            SysAuth model = getModel(SysAuth.class);

            if (pid != null && !"0".equals(pid)) { // 更新
                model.set("modify_datetime", System.currentTimeMillis());
                model.update();
            } else { // 新增
                model.put("create_datetime", System.currentTimeMillis());
                model.save();
            }

            renderMessage("保存成功");

        } catch (Exception e) {
            log.error(e.getMessage(), e);
            renderMessageByFailed("操作失败");
        }

    }

}
