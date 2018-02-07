package com.supyuan.news;

import com.supyuan.component.base.BaseProjectModel;
import com.supyuan.jfinal.component.annotation.ModelBind;

@ModelBind(table = "t_news")
public class News extends BaseProjectModel<News> {

	private static final long serialVersionUID = 1L;
	public static final News dao = new News();
}
