package com.supyuan.component.plugin.spring;

import com.supyuan.util.Constants;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * SpringCtxHolder 单例初始化Spring的ApplicationContext
 *
 * @Author 袁旭云【rain.yuan@transn.com】
 * @Date 2017/5/16 22:41
 */
public class SpringCtxHolder {
    private static ApplicationContext applicationContext;

    static {
        if(Constants.SPRING) {
            System.out.println("启用spring支持......");
            applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
        }
    }

    /**
     * 获取ApplicationContext实例
     *
     * @return
     */
    public static synchronized ApplicationContext getApplicationContext() {
        if(Constants.SPRING) {
            if (null == applicationContext) {
                applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
            }
        }
        return applicationContext;
    }
}
