package com.supyuan.news;

import com.jfinal.plugin.activerecord.Page;
import com.supyuan.component.base.BaseProjectController;
import com.supyuan.jfinal.component.annotation.ControllerBind;
import com.supyuan.jfinal.component.db.SQLUtils;
import com.supyuan.util.StrUtils;

/**
 * 角色
 * 
 * @author flyfox 2014-4-24
 */
@ControllerBind(controllerKey = "/news")
public class NewsController extends BaseProjectController {

	private static final String path = "/pages/news/news_";

	public void index() {
		list();
	}
	
	public void list() {
		
		News model = getModelByAttr(News.class);

		SQLUtils sql = new SQLUtils(" from t_news t where 1=1 ");
		if (model.getAttrValues().length != 0) {
			sql.setAlias("t");
			// 查询条件
			sql.whereLike("news_title", model.getStr("news_title"));
		}
		
		// 排序
		String orderBy = getBaseForm().getOrderBy();
		if (StrUtils.isEmpty(orderBy)) {
			sql.append(" order by top_flg desc,id desc");
		} /*else {
			sql.append(" order by ").append(orderBy);
		}*/

		String sqlSelect = "select * ";

		Page<News> page = News.dao.paginate(getPaginator(), sqlSelect, //
				sql.toString().toString());

		// 下拉框
		setAttr("page", page);
		setAttr("attr", model);
		render(path + "list.html");
	}
}
