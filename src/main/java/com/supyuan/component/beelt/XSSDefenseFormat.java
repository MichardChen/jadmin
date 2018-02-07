package com.supyuan.component.beelt;

import org.apache.commons.lang.StringEscapeUtils;
import org.beetl.core.Format;

/**
 *
 *
 * XSSDefenseFormat 使用HTML实体转义<code>string<code>中的字符。
 * * <p>
 * 防止XSS攻击全称跨站脚本攻击
 * </p>
 * 页面使用 ${item.url,xss}
 * @Author 袁旭云【rain.yuan@transn.com】
 * @Date 2017/11/6 14:50
 */
public class XSSDefenseFormat  implements Format {
    @Override
    public Object format(Object o, String s) {
        if (null == o) {
            return null;
        } else {
            return StringEscapeUtils.escapeHtml((String) o);
        }
    }
}
