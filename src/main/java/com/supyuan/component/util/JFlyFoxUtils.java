package com.supyuan.component.util;

import com.supyuan.util.Config;
import com.supyuan.util.StrUtils;
import com.supyuan.util.encrypt.DES3Utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class JFlyFoxUtils {
	/**
	 * 管理员
	 */
	public static final int USER_TYPE_ADMIN = 1;
	/**
	 * 普通用户
	 */
	public static final int USER_TYPE_NORMAL = 2;
	/**
	 * 前台用户
	 */
	public static final int USER_TYPE_FRONT = 3;
	/**
	 * 第三方用户
	 */
	public static final int USER_TYPE_THIRD = 4;
	/**
	 * API用户
	 */
	public static final int USER_TYPE_API = 5;
	/**
	 * 其他用户
	 */
	public static final int USER_TYPE_OTHER = 9;
	

	/**
	 * session唯一Key
	 */
	public static final String USER_KEY = "USER_KEY";

	public static final int MENU_ABOUT = 90;
	//这里改成自己的key比较安全
	private static final DES3Utils des = new DES3Utils("flyoffox");

	// admin:1RHFCLt64uOOViCTzgSaww== test:ldKI9edsQVM=
	public static void main(String[] args) {
		String password = "admin123";
		String tmp = passwordEncrypt(password);
		System.out.println(tmp);
		System.out.println(passwordDecrypt(tmp));

		password = "123456";
		tmp = passwordEncrypt(password);
		System.out.println(tmp);
		System.out.println(passwordDecrypt(tmp));
	}

	/**
	 * 编码
	 * 
	 * 2015年2月25日 下午2:22:08 flyfox 369191470@qq.com
	 * 
	 * @param password
	 * @return
	 */
	public static String passwordEncrypt(String password) {
		return des.encryptString(password);
	}

	/**
	 * 解码
	 * 
	 * 2015年2月25日 下午2:22:13 flyfox 369191470@qq.com
	 * 
	 * @param encryptPassword
	 * @return
	 */
	public static String passwordDecrypt(String encryptPassword) {
		return des.decryptString(encryptPassword);
	}

	/**
	 * cookie编码
	 *
	 * 2015年2月25日 下午2:22:08 flyfox 369191470@qq.com
	 *
	 * @param password
	 * @return
	 */
	public static String cookieEncrypt(String password) {
		return des.encryptString(password);
	}

	/**
	 * cookie解码
	 *
	 * 2015年2月25日 下午2:22:13 flyfox 369191470@qq.com
	 *
	 * @param encryptPassword
	 * @return
	 */
	public static String cookieDecrypt(String encryptPassword) {
		return des.decryptString(encryptPassword);
	}

	/**
	 * 默认密码
	 * 
	 * 2015年2月25日 下午2:23:37 flyfox 369191470@qq.com
	 * 
	 * @return
	 */
	public static String getDefaultPassword() {
		String defaultPassword = "123456";
		return passwordEncrypt(defaultPassword);
	}

	/**
	 * 删除侵入脚本
	 * 
	 * 2015年6月20日 下午5:16:21 flyfox 369191470@qq.com
	 * 
	 * @param htmlStr
	 * @return
	 */
	public static String delScriptTag(String htmlStr) {
		Pattern p_script = Pattern.compile("<script[^>]*?>[\\s\\S]*?<\\/script>", 2);
		Matcher m_script = p_script.matcher(htmlStr);
		htmlStr = m_script.replaceAll("");
		Pattern p_style = Pattern.compile("<style[^>]*?>[\\s\\S]*?<\\/style>", 2);
		Matcher m_style = p_style.matcher(htmlStr);
		htmlStr = m_style.replaceAll("");
		return htmlStr.trim();
	}

	
	/**
	 * 是否是后台请求地址
	 * 
	 * 2015年2月27日 上午11:38:37 flyfox 369191470@qq.com
	 * 
	 * @param path
	 * @return
	 */
	public static boolean isBack(String path) {
		// 后台不需要认证页面
		if (path.startsWith("admin/login")  //
				|| path.startsWith("admin/logout") //
				|| path.startsWith("admin/trans")) {
			return false;
		}
		
		return StrUtils.isNotEmpty(path) // 空是首页
				&& (path.startsWith("system/") // 系统管理
				|| path.startsWith("admin/") // 后台管理
				);
	}
}
