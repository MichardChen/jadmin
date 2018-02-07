package com.supyuan.system.department;

import java.util.List;

import com.jfinal.plugin.activerecord.Page;
import com.supyuan.component.base.BaseProjectController;
import com.supyuan.jfinal.component.annotation.ControllerBind;
import com.supyuan.jfinal.component.db.SQLUtils;
import com.supyuan.system.user.SysUser;
import com.supyuan.util.StrUtils;
import com.supyuan.util.extend.HtmlUtils;

/**
 * 部门
 * 
 * @author flyfox 2014-4-24
 */
@ControllerBind(controllerKey = "/system/department")
public class DepartmentController extends BaseProjectController {

	private static final String path = "/pages/system/department/department_";

	public void index() {
		list();
	}
	
	public void list() {
		SysDepartment model = getModelByAttr(SysDepartment.class);

		SQLUtils sql = new SQLUtils(" from sys_department t "
				+ " left join sys_department p on t.parent_id = p.id  where 1=1 ");
		if (model.getAttrValues().length != 0) {
			sql.setAlias("t");
			// 查询条件
			sql.whereLike("name", model.getStr("name"));
		}

		// 排序
		String orderBy = getBaseForm().getOrderBy();
		if (StrUtils.isEmpty(orderBy)) {
			sql.append(" order by t.sort,t.id desc ");
		} else {
			sql.append(" order by ").append(orderBy);
		}

		Page<SysDepartment> page = SysDepartment.dao.paginate(getPaginator(), "select t.*,p.name as parentName ", //
				sql.toString().toString());

		// 下拉框
		setAttr("page", page);
		setAttr("attr", model);

		List<SysDepartment> departments = SysDepartment.dao.find("select * from sys_department order by sort,id ");
		setAttr("departments", departments);

		render(path + "list.html");
	}

	public void add() {
		// 获取页面信息,设置目录传入
		SysDepartment model = SysDepartment.dao.findById(getParaToInt());
		setAttr("selectParentDepartments", new DepartmentSvc().selectDepart(model == null ? 0 : model.getId()));
				
		render(path + "add.html");
	}

	public void view() {
		SysDepartment model = SysDepartment.dao.findById(getParaToInt());
		setAttr("model", model);
		
		SysDepartment department = SysDepartment.dao.findById(model.getParentId());
		model.put("parentName", department != null ? department.getName() : null);
		
		render(path + "view.html");
	}

	public void delete() {
		boolean bol = true;

		SysDepartment model = new SysDepartment();
		// 删除前先验证是否存在子节点 以及 是否存在关联用户
		List<SysDepartment> departmentList = model.findByWhere("where parent_id =?", getParaToInt());
		SysUser user = new SysUser();
		List<SysUser> userList = user.findByWhere("where departid =?", getParaToInt());
		if(departmentList != null && departmentList.size()>0){
			bol = false;
		}
		if(bol && userList != null && userList.size()>0){
			bol = false;
		}
		if(bol){
			// 日志添加
			Integer userid = getSessionUser().getUserID();
			String now = getNow();
			model.put("update_id", userid);
			model.put("update_time", now);
			model.deleteById(getParaToInt());
			list();
		} else {
			renderMessageByFailed("删除失败，有子节点或节点下有关联用户");
		}

	}

	public void edit() {
		SysDepartment model = SysDepartment.dao.findById(getParaToInt());
		setAttr("model", model);
		
		// 下拉框
		setAttr("selectParentDepartments", new DepartmentSvc().selectDepart(model.getParentId(), model.getId()));
				
		render(path + "edit.html");
	}

	public void save() {
		Integer pid = getParaToInt();
		SysDepartment model = getModel(SysDepartment.class);

		// 日志添加
		Integer userid = getSessionUser().getUserID();
		String now = getNow();
		model.set("update_id", userid);
		model.set("update_time", now);

		if (pid != null && pid > 0) { // 更新
			model.update();
		} else { // 新增
			model.remove("id");
			model.set("create_id", userid);
			model.set("create_time", now);
			model.save();
		}
		renderMessage("保存成功");
	}

}
