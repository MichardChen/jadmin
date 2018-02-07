package com.supyuan.modules.admin.person;

import com.alibaba.fastjson.JSONObject;
import com.supyuan.component.base.BaseProjectController;
import com.supyuan.component.util.JFlyFoxUtils;
import com.supyuan.jfinal.component.annotation.ControllerBind;
import com.supyuan.system.user.SysUser;
import com.supyuan.system.user.UserCache;
import com.supyuan.util.StrUtils;

/**
 * 个人信息
 * 
 * 2015年3月10日 下午5:36:22 jhh
 */
@ControllerBind(controllerKey = "/person")
public class PersonController extends BaseProjectController {

	public static final String path = "/pages/admin/person/";

	public void index() {
		SysUser user = (SysUser) getSessionUser();
		setAttr("model", user);
		// TODO 用户信息展示
		setAttr("user", user);
		// 活动目录
		setAttr("folders_selected", "person");
		render(path + "show_person.html");
	}

	/**
	 * 个人信息保存
	 */
	public void save() {
		JSONObject json = new JSONObject();
		json.put("status", 2);// 失败

		SysUser user = (SysUser) getSessionUser();
		int userid = user.getInt("userid");
		SysUser model = getModel(SysUser.class);

		if (userid != model.getInt("userid")) {
			json.put("msg", "提交数据错误！");
			renderJson(json.toJSONString());
			return;
		}

		// 第三方用户不需要密码
		if (user.getInt("usertype") != 4) {
			String oldPassword = getPara("old_password");
			String newPassword = getPara("new_password");
			String newPassword2 = getPara("new_password2");
			if (!user.getStr("password").equals(JFlyFoxUtils.passwordEncrypt(oldPassword))) {
				json.put("msg", "密码错误！");
				renderJson(json.toJSONString());
				return;
			}
			if (StrUtils.isNotEmpty(newPassword) && !newPassword.equals(newPassword2)) {
				json.put("msg", "两次新密码不一致！");
				renderJson(json.toJSONString());
				return;
			} else if (StrUtils.isNotEmpty(newPassword)) { // 输入密码并且一直
				model.set("password", JFlyFoxUtils.passwordEncrypt(newPassword));
			}
		}

		if (StrUtils.isNotEmpty(model.getStr("email")) && model.getStr("email").indexOf("@") < 0) {
			json.put("msg", "email格式错误！");
			renderJson(json.toJSONString());
			return;
		}

		// 日志添加
		model.put("update_id", getSessionUser().getUserID());
		model.put("update_time", getNow());
		
		model.update();
		UserCache.init(); // 设置缓存
		SysUser newUser = SysUser.dao.findById(userid);
		setSessionUser(newUser); // 设置session
		json.put("status", 1);// 成功

		renderJson(json.toJSONString());
	}
	
	/**
	 * 设置主题
	 */
	public void theme() {
		String theme = getPara();
		
		JSONObject json = new JSONObject();
		json.put("status", 2);// 失败

		if (StrUtils.isEmpty(theme)) {
			json.put("msg", "提交数据错误！");
			renderJson(json.toJSONString());
			return;
		}
		
		SysUser user = (SysUser) getSessionUser();
		int userid = user.getUserid();
		SysUser model = SysUser.dao.findById(userid);

		// 日志添加
		model.put("update_id", getSessionUser().getUserID());
		model.put("update_time", getNow());
		model.set("theme", theme);
		model.update();
		
		UserCache.init(); // 设置缓存
		
		setSessionUser(model); // 设置session
		
		json.put("status", 1);// 成功
		renderJson(json.toJSONString());
	}
}
