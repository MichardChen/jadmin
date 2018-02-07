package com.supyuan.job.jobWeb.jobClass;

import com.supyuan.jfinal.base.BaseService;
import javassist.*;
import javassist.bytecode.CodeAttribute;
import javassist.bytecode.LocalVariableAttribute;
import javassist.bytecode.MethodInfo;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by yuanxuyun on 2017/4/19.
 */
public class QuartzJobClassSvc extends BaseService {

    /**
     * 包含方法名 返回值类型 参数 的 Map
     */
    private Map<String, String> map = new HashMap<String, String>();

    /**
     * 包含参数名称 的 Map
     */
    private Map<String, String> paramNamemap = new HashMap<String, String>();

    /**
     * 通过反射 取得类里面的方法的返回值 参数类型
     *
     * @param classFullName
     * @param methodName
     * @return map 包含方法名 返回值类型 参数 的 map
     */
    @SuppressWarnings("unchecked")
    public Map reflectMethod(String classFullName, String methodName) {
        int count = 0;
        try {
            //先清空
            map.clear();
            Class<?> cls = Class.forName(classFullName);
            //获取自定义的方法 得到的是一个数组
            Method[] md = cls.getDeclaredMethods();
            for (Method m : md) {
                //获取参数类型
                Class<?>[] cl = m.getParameterTypes();
                //根据指定方法名得到其参数等信息
                if (m.getName().equals(methodName)) {
                    map.put("methodName", m.getName());
                    map.put("returnTypeName", m.getReturnType().getName());
                    String param = null;
                    for (Class cs : cl) {
                        param = cs.getName();
                        //基本类型转换为封转类型
                        if (cs.getName().equals("int")) {
                            param = "java.lang.Integer";
                        }
                        if (cs.getName().equals("byte")) {
                            param = "java.lang.Byte";
                        }
                        if (cs.getName().equals("boolean")) {
                            param = "java.lang.Boolean";
                        }
                        if (cs.getName().equals("short")) {
                            param = "java.lang.Short";
                        }
                        if (cs.getName().equals("char")) {
                            param = "java.lang.Character";
                        }
                        if (cs.getName().equals("long")) {
                            param = "java.lang.Long";
                        }
                        if (cs.getName().equals("float")) {
                            param = "java.lang.Float";
                        }
                        if (cs.getName().equals("double")) {
                            param = "java.lang.Double";
                        }

                        map.put("param" + count, param);
                        count++;
                    }
                }//end if
            }//end for
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("您输入的类全名不存在,请核对后再输入方法名称!");
        }
        return map;
    }

    /**
     * 使用javaassist的反射方法获取方法的参数名
     *
     * @param classFullName
     * @param methodName
     * @return paramNamemap 包含参数名称 的 Map
     */
    @SuppressWarnings("unchecked")
    public Map getParamName(String classFullName, String methodName) {

        Class clazz;
        paramNamemap.clear();//先清空
        try {
            clazz = Class.forName(classFullName);
            ClassPool pool = ClassPool.getDefault();
            //注意 因为是web应用 此处必须这么写 否侧 会找不到 classFullName 报异常
            //参见  http://topic.csdn.net/u/20110318/17/924ee7a8-2abf-42db-ae0d-01509554efeb.html
            pool.insertClassPath(new ClassClassPath(this.getClass()));
            CtClass cc = pool.get(clazz.getName());
            CtMethod cm = cc.getDeclaredMethod(methodName);
            //使用javaassist的反射方法获取方法的参数名
            MethodInfo methodInfo = cm.getMethodInfo();
            CodeAttribute codeAttribute = methodInfo.getCodeAttribute();
            LocalVariableAttribute attr = (LocalVariableAttribute) codeAttribute.getAttribute(LocalVariableAttribute.tag);
            if (attr == null) {
                //exception  此处暂时 不处理
            }
            String[] paramNames = new String[cm.getParameterTypes().length];
            int pos = Modifier.isStatic(cm.getModifiers()) ? 0 : 1;
            for (int i = 0; i < paramNames.length; i++)
                paramNames[i] = attr.variableName(i + pos);
            for (int i = 0; i < paramNames.length; i++) {
                paramNamemap.put("paramName" + i, paramNames[i]);
            }

        } catch (NotFoundException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return paramNamemap;
    }

    /**
     * 检测类全名是否存在
     *
     * @param classAllName 类全名
     * @return String 返回 ok or no
     */
    public String CkeckClassAllName(String classAllName) {
        String flag = "no";
        try {
            Class<?> cls = Class.forName(classAllName);
            if (cls != null) {
                flag = "ok";
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("您输入的类全名不存在,请核对后重新输入!");
        }
        return flag;
    }

    /**
     * 方法是否存在
     *
     * @param classFullName 类全名
     * @param functionName  方法名
     * @return String 返回 ok or no
     */
    @SuppressWarnings("unchecked")
    public String ckeckFunctionName(String functionName, String classFullName) {
        String flag = "ok";
        Map mp = reflectMethod(classFullName, functionName);
        if (mp.size() == 0) {
            flag = "no";
            System.out.println("您输入的方法名不存在,请核对后重新输入!");
        }
        return flag;
    }

    /**
     * 验证数据是否存在
     *
     * @param fnName   方法名称
     * @param fullName 类全名
     * @return String 返回 ok or no
     */
    @SuppressWarnings("unchecked")
    public String ckeckSave(String fnName, String fullName, String newId, String tags) {
        String flag = "ok";
        //当前执行的是 inserted
        if (tags.equals("inserted")) {
            /*//根据 类全名 和 方法名 得到list
            String queryString = "from QuartzJobclass q where q.functionName= '" + fnName + "' and q.classAllname = '" + fullName + "'";
            List checkName = getDao().find(queryString);
            if (checkName.size() > 0) {
                flag = "no";//不存在
            }*/
        } else {
            //此处暂时 不处理
        }
        return flag;
    }
}
