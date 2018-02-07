package com.supyuan.rest;

import com.supyuan.component.base.BaseProjectController;
import com.supyuan.jfinal.component.annotation.ControllerBind;

/**
 * 角色
 * 
 * @author flyfox 2014-4-24
 */
@ControllerBind(controllerKey = "/rest")
public class RestController extends BaseProjectController {

	public void index() {
		renderText("test==========");
	}
}
