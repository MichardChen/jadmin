package com.supyuan.job.jobWeb.job;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javassist.ClassClassPath;
import javassist.ClassPool;
import javassist.CtClass;
import javassist.CtMethod;
import javassist.Modifier;
import javassist.NotFoundException;
import javassist.bytecode.CodeAttribute;
import javassist.bytecode.LocalVariableAttribute;
import javassist.bytecode.MethodInfo;

/**
 * 工具类： 通过类全名 方法名称 得到参数个数 参数名称
 * 
 * @author 袁旭云
 * 
 */
public class GetParamUtil {

	/**
	 * 枚举存放基本数据类对应的整形
	 * 
	public enum DataTypes {
		Integer, Byte, Boolean, Short, Character, Long, Float, Double
	}*/
	
	/**
	  * 通过反射 取得类里面的方法的返回值 参数类型
	 * 
	 * @param classFullName
	 * 				类全名（包扩包名）
	 * @param methodName
	 * 				方法名称
	 * @return map 
	 * 			包含方法名 返回值类型 参数 的 map
	 */
	@SuppressWarnings("unchecked")
	public static Map reflectMethod(String classFullName, String methodName) {
		int count = 0;
		Map<String, String> map =null;
		// 类全名存在
		if (CkeckClassAllName(classFullName).equals("ok")) {
			// 方法名存在
			if (ckeckFunctionName(classFullName, methodName).equals("ok")) {
				try {
					map = new HashMap<String, String>();
					// 先清空
					map.clear();

					Class<?> cls = Class.forName(classFullName);

					// 获取自定义的方法 得到的是一个数组
					Method[] md = cls.getDeclaredMethods();
					for (Method m : md) {
						// 获取参数类型
						Class<?>[] cl = m.getParameterTypes();
						// 根据指定方法名得到其参数等信息
						if (m.getName().equals(methodName)) {
							// 方法名称
							map.put("methodName", m.getName());
							// 返回值类型
							map.put("returnTypeName", m.getReturnType()
									.getName());
							for (Class cs : cl) {
								// 参数类型
								map.put("paramType" + count, cs.getName());
								count++;
							}
						}// end if
					}// end for
				} catch (ClassNotFoundException e) {
					System.out.println("java.lang.ClassNotFoundException:"
							+ e.getMessage());
				}
			}
			if (ckeckFunctionName(classFullName, methodName).equals("no")) {
				System.out.println("找不到自定义的方法!");
			}
		}
		return map;
	}

	/**
	 * 使用javaassist的反射方法获取方法的参数名
	 * 
	 * @param classFullName
	 * 				类全名（包扩包名）
	 * @param methodName
	 * 				方法名称
	 * @return paramNamemap 
	 * 				包含参数名称 的 Map
	 */
	@SuppressWarnings("unchecked")
	public static Map getParamName(String classFullName, String methodName) {
		Map<String, String> paramNamemap =null;
		Class clazz;
		try {
			paramNamemap = new LinkedHashMap<String, String>();
			paramNamemap.clear();// 先清空
			clazz = Class.forName(classFullName);
			ClassPool pool = ClassPool.getDefault();
			//ClassPool pool = ClassPool.getDefault();
			// 注意 因为是web应用 此处必须这么写 否侧 会找不到 classFullName 报异常
			// 参见
			// http://topic.csdn.net/u/20110318/17/924ee7a8-2abf-42db-ae0d-01509554efeb.html
			ClassClassPath classPath = new ClassClassPath(clazz);
			pool.insertClassPath(classPath);
			//pool.insertClassPath(new ClassClassPath(clazz));
			// System.out.println("this.getClass()"+this.getClass());
			CtClass cc = pool.get(clazz.getName());
			CtMethod cm = cc.getDeclaredMethod(methodName);
			// 使用javaassist的反射方法获取方法的参数名
			MethodInfo methodInfo = cm.getMethodInfo();
			CodeAttribute codeAttribute = methodInfo.getCodeAttribute();
			LocalVariableAttribute attr = (LocalVariableAttribute) codeAttribute
					.getAttribute(LocalVariableAttribute.tag);
			if (attr == null) {
				// exception 此处暂时 不处理
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
	 * 根据 类全名（包括包名）和 方法名称 返回 参数个数 参数名称 参数类型 paramsNum 参数个数 params +数字 参数
	 * 
	 * @param beanName
	 *            类全名（包括包名）
	 * @param functionName
	 *            方法名称
	 * @return map 参数个数 参数名称 参数类型 的 map
	 */
	@SuppressWarnings("unchecked")
	public static Map getParamsMap(String beanName, String functionName) {
		Map<String, String> paramsMap = null;
		Map<String, String> maps = reflectMethod(beanName, functionName);
		Map<String, String> map = getParamName(beanName, functionName);

		// System.out.println("方法名称："+maps.get("methodName"));
		// System.out.println("返回值类型："+maps.get("returnTypeName"));
		// int paramscount =0;
		// while(paramscount < maps.size()-2){
		// System.out.print("参数名称"+map.get("paramName"+paramscount));
		// System.out.println("参数类型"+maps.get("paramType"+paramscount));
		// paramscount++;
		// }
		if(maps != null)
		{
			paramsMap = new LinkedHashMap<String, String>();
			// 参数个数  
			paramsMap.put("paramsNum", String.valueOf(maps.size() - 2));
			int paramscounts = 0;
			while (paramscounts < maps.size() - 2) {
				// 参数名称 参数类型
				// paramsMap.put("params" + paramscounts, map.get("paramName"
				// + paramscounts)
				// + ":" + maps.get("paramType" + paramscounts));
				// 基本类型转换为封转类型
				if (maps.get("paramType" + paramscounts).toString().equals("int")) {
					maps.put("paramType" + paramscounts, "java.lang.Integer");
				}
				if (maps.get("paramType" + paramscounts).toString().equals("byte")) {
					maps.put("paramType" + paramscounts, "java.lang.Byte");
				}
				if (maps.get("paramType" + paramscounts).toString().equals(
						"boolean")) {
					maps.put("paramType" + paramscounts, "java.lang.Boolean");
				}
				if (maps.get("paramType" + paramscounts).toString().equals("short")) {
					maps.put("paramType" + paramscounts, "java.lang.Short");
				}
				if (maps.get("paramType" + paramscounts).toString().equals("char")) {
					maps.put("paramType" + paramscounts, "java.lang.Character");
				}
				if (maps.get("paramType" + paramscounts).toString().equals("long")) {
					maps.put("paramType" + paramscounts, "java.lang.Long");
				}
				if (maps.get("paramType" + paramscounts).toString().equals("float")) {
					maps.put("paramType" + paramscounts, "java.lang.Float");
				}
				if (maps.get("paramType" + paramscounts).toString()
						.equals("double")) {
					maps.put("paramType" + paramscounts, "java.lang.Double");
				}
	
				paramsMap.put(map.get("paramName" + paramscounts), maps
						.get("paramType" + paramscounts));
				paramscounts++;
			}
		}
		return paramsMap;
	}

	/**
	 * 方法是否存在
	 * 
	 * @param classFullName
	 *            类全名
	 * @param classAllName
	 *            方法名
	 * @return
	 * @return String 返回 ok or no
	 */
	public static String ckeckFunctionName(String classFullName,
			String methodName) {
		String flag = "no";
		Class<?> cls;
		try {
			// 先清空
			// map.clear();
			cls = Class.forName(classFullName);
			// 获取自定义的方法 得到的是一个数组
			Method[] md = cls.getDeclaredMethods();
			for (Method m : md) {
				// 获取参数类型
				Class<?>[] cl = m.getParameterTypes();
				// 根据指定方法名得到其参数等信息
				if (m.getName().equals(methodName)) {
					flag = "ok";
				}// end if
			}// end for
		} catch (ClassNotFoundException e) {
		}
		return flag;
	}

	/**
	 * 检测类全名是否存在
	 * 
	 * @param classAllName
	 *            类全名
	 * @return String 返回 ok or no
	 */
	public static String CkeckClassAllName(String classAllName) {
		String flag = "no";
		try {
			Class<?> cls = Class.forName(classAllName);
			if (cls != null) {
				flag = "ok";
			}
		} catch (ClassNotFoundException e) {
			System.out.println("找不到类:" + e.getMessage());
		}
		return flag;
	}

	public static void main(String[] args) {
		//getParamName("com.sgepit.framework.base.quartzWeb.job.TestJob", "hello");
		// byte java.lang.Byte
		// boolean java.lang.Boolean
		// short java.lang.Short

		// char java.lang.Character

		// int java.lang.Integer

		// long java.lang.Long

		// float java.lang.Float

		// double java.lang.Double

	}
}
