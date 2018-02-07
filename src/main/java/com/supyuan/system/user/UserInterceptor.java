package com.supyuan.system.user;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.supyuan.component.base.BaseProjectController;
import com.supyuan.component.util.JFlyFoxUtils;
import com.supyuan.jfinal.base.BaseController;
import com.supyuan.jfinal.base.SessionUser;
import com.supyuan.jfinal.component.util.Attr;
import com.supyuan.system.auth.SysAuth;
import com.supyuan.system.menu.SysMenu;
import com.supyuan.util.Config;
import com.supyuan.util.StrUtils;
import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * 用户认证拦截器
 *
 * @author flyfox 2014-2-11
 */
public class UserInterceptor implements Interceptor {

    private static final Log log = Log.getLog(UserInterceptor.class);

    public void intercept(Invocation ai) {

        Controller controller = ai.getController();

        if(ai.getControllerKey().contains("/rest")){
			ai.invoke();
		}
        
        HttpServletRequest request = controller.getRequest();
        String referrer = request.getHeader("referer");
        String site = "http://" + request.getServerName();
        log.warn("####IP:" + request.getRemoteAddr() + "\t port:" + request.getRemotePort() + "\t 请求路径:"
                + request.getRequestURI());
        if (referrer == null || !referrer.startsWith(site)) {
            log.warn("####非法的请求");
        }

        String tmpPath = ai.getActionKey();

        if (tmpPath.startsWith("/")) {
            tmpPath = tmpPath.substring(1, tmpPath.length());
        }
        if (tmpPath.endsWith("/")) {
            tmpPath = tmpPath.substring(0, tmpPath.length() - 1);
        }


        // 每次访问获取session，没有可以从cookie取~
        SysUser user = null;
        if (controller instanceof BaseProjectController) {
            user = (SysUser) ((BaseProjectController) controller).getSessionUser();
        } else {
            user = controller.getSessionAttr(Attr.SESSION_NAME);
        }

        //修复未登录情况时，直接前往某个路由报错问题
        if ((user == null || user.getUserid() <= 0) && (tmpPath.indexOf("/") > -1 || "home".equals(tmpPath))) {
            controller.redirect("/logout");
            return;
        }

        if (JFlyFoxUtils.isBack(tmpPath)) {

            if (user == null || user.getUserid() <= 0) {
                controller.redirect("/trans");
                return;
            }
            // TODO 这里展示控制第三方用户和前端用户不能登录后台
            int usertype = user.getInt("usertype");
            if (usertype == 4 // 第三方用户
                    || usertype == 3) { // 前端用户
                controller.redirect("/trans/auth");
                return;
            }

            // TODO 判断url是否有权限
            if (!urlAuth(controller, tmpPath)) {
                controller.redirect("/trans/auth");
                return;
            }

			/*String pathInfo = request.getServletPath();
            if(!StringUtils.isNotBlank(pathInfo)) {
				pathInfo = request.getRequestURI();
			}*/

        }

        // TODO 判断功能操作是否有权限
        if (!uriAuth(user, tmpPath, controller)) {

            String script = "history.back();";
            controller.setAttr("script", script);
            controller.render("/pages/template/message.html");

            return;
        }


        ai.invoke();
    }

    /**
     * 判断Url是否有权限
     * <p>
     * 2016年12月18日 上午12:12:51
     *
     * @param controller
     * @param tmpPath
     * @return
     */
    protected boolean urlAuth(Controller controller, String tmpPath) {
        List<SysMenu> list = controller.getSessionAttr("nomenu");
        // nomenuList 应该是size等于0，而不是空
        if (list == null) {
            return false;
        }

        for (SysMenu sysMenu : list) {
            String url = sysMenu.getStr("url");
            if (StrUtils.isEmpty(url)) {
                continue;
            }
            if (tmpPath.startsWith(url)) {
                return false;
            }
        }

        return true;
    }

    /**
     * 权限验证
     *
     * @param user
     * @param tmpPath
     * @return
     */
    protected boolean uriAuth(SysUser user, String tmpPath, Controller controller) {
        SysAuth userAuth = SysAuth.dao.findFirstByWhere("WHERE webapp_id = ? AND uri = ?", 99, tmpPath);
        boolean has = false;
        if (null != userAuth && !"T".equalsIgnoreCase(userAuth.getStr("is_halt"))) {
            Integer userId = 1;
            Integer webappId = 99;
            if (null != user) {
                userId = user.getUserID();
            }

            String sql = "SELECT t.* FROM sys_auth_user t WHERE t.webapp_id = ?  AND t.user_id = ?";
            Record rd = Db.findFirst(sql, webappId, userId);

            if (null != rd) {
                String cacheString = rd.getStr("cache_string");
                if (userId == 1 && "*".equals(cacheString)) {
                    has = true;
                } else if (StringUtils.isNotBlank(cacheString)) {
                    cacheString = ",".concat(cacheString).concat(",");
                    if (cacheString.indexOf(",".concat(Long.toString(userAuth.getInt("id")).concat(","))) != -1) {
                        has = true;
                    }
                }
            }
        } else {
            has = true;
        }
        if (!has) {
            controller.setAttr("msg", "[" + userAuth.getStr("descript") + "]" + "权限不足!");
            return false;
        }

        return true;
    }

}
