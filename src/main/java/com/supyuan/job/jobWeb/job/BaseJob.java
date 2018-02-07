package com.supyuan.job.jobWeb.job;

import com.jfinal.log.Log;
import com.supyuan.job.jobWeb.jobLog.JobLog;
import com.supyuan.util.DateUtils;
import com.supyuan.util.extend.UuidUtils;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.StatefulJob;

import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.Map;

/**
 * 所有job的父类<br>
 * Job 多线程  StatefulJob 控制并发的<br>
 * execute方法通过反射机制执行web界面中配置的方法及参数值，并且执行后写入执行日志
 * Created by yuanxuyun on 2017/4/21.
 */
public class BaseJob implements StatefulJob {

    protected static final Log logger = Log.getLog(BaseJob.class);
    private Class jobClass;

    public BaseJob() {
        jobClass = this.getClass();
    }

    @Override
    public void execute(JobExecutionContext arg0) throws JobExecutionException {
        JobDataMap map = arg0.getMergedJobDataMap();
        String functionName = map.getString("functionName");
        JobLog quartzLog = new JobLog();
        quartzLog.put("begintimes", System.currentTimeMillis());
        quartzLog.put("content", map.getString("jobContent"));
        quartzLog.put("job_content", map.getString("jobContent"));

        quartzLog.put("uids", UuidUtils.getUUID2());
        String zxMess = "执行失败";
        String remark = "执行失败";

        if (arg0.getNextFireTime() != null) {
            quartzLog.put("type", "0");
            String nDate = DateUtils.format(arg0.getNextFireTime(), "yyyy-MM-dd HH:mm:ss");
            quartzLog.put("nextruntime", nDate);
        } else {
            quartzLog.put("type", "1");
            quartzLog.put("nextruntime", null);
        }

        quartzLog.put("jobuids", map.getString("jobUids"));
        try {
            // 根据job class和方法名称获得对应方法的参数个数，及参数名称，参数类型
            Date date = new Date();
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss:SSS");
            String time = format.format(date);
            zxMess = "执行" + jobClass.getCanonicalName() + "类中的" + functionName
                    + "方法;参数值分别为：";
            remark = "[" + time + "]执行\n" + jobClass.getCanonicalName() + "类中的\n" + functionName
                    + "方法;参数值分别为：\n";
            Map<String, String> paramsMap = GetParamUtil.getParamsMap(jobClass.getCanonicalName(), functionName);

            Class[] paramsClass = new Class[Integer.parseInt(paramsMap.get("paramsNum").toString())];
            Object[] paramsValueObj = new Object[Integer.parseInt(paramsMap.get("paramsNum").toString())];
            paramsMap.remove("paramsNum");
            int i = 0;
            for (String str : paramsMap.keySet()) {
                String paramsType = paramsMap.get(str);
                Class c = Class.forName(paramsType);
                paramsClass[i] = c;
                // Object obj=map.get(str);
                Object obj = null;
                if (paramsType.equals("java.lang.Integer")
                        || paramsType.equals("java.lang.Byte")
                        || paramsType.equals("java.lang.Boolean")
                        || paramsType.equals("java.lang.Short")
                        || paramsType.equals("java.lang.Long")
                        || paramsType.equals("java.lang.Float")
                        || paramsType.equals("java.lang.Double")) {
                    Method castMethod = c.getDeclaredMethod("valueOf", String.class);
                    obj = castMethod.invoke(null, map.get(str).toString());
                } else {
                    if (paramsType.equals("java.lang.Character")
                            || paramsType.equals("java.math.BigDecimal")) {
                        Constructor intArgsConstructor = c.getConstructor(new Class[]{String.class});
                        obj = intArgsConstructor.newInstance(new Object[]{map.get(str).toString()});
                    } else {
                        obj = c.newInstance();
                        obj = map.get(str);
                    }
                }


                zxMess += " " + str + ":" + obj;
                remark += " " + str + ":" + obj;
                paramsValueObj[i] = obj;
                i++;
            }
            quartzLog.put("job_classandfunction", zxMess);
            Method method = jobClass.getDeclaredMethod(functionName,
                    paramsClass);
            method.invoke(jobClass.newInstance(), paramsValueObj);

            quartzLog.put("endtimes", System.currentTimeMillis());
            quartzLog.put("state", "1");// 执行成功
            String ip = getLocalIP();
            if (ip != null && !"".equals(ip)) {
                quartzLog.put("run_ip", ip);
            }
            quartzLog.put("remark", remark + " 执行成功！");
            logger.debug(remark + " 执行成功！");
            //logger.database(quartzLog);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            quartzLog.put("job_classandfunction", zxMess);
            quartzLog.put("endtimes", System.currentTimeMillis());
            quartzLog.put("state", "0");// 执行失
            String ip = getLocalIP();
            if (ip != null && !"".equals(ip)) {
                quartzLog.put("run_ip", ip);
            }

            //String emsg = getStackMsg(e);
            logger.error("\n" + remark + "\n执行失败！");
            logger.error(e.getMessage(), e);
            //logger.database(quartzLog);
            quartzLog.put("remark", remark + "  执行失败！");
            //e.printStackTrace();

        } finally {
            quartzLog.save();
            //logDAO.saveOrUpdate(quartzLog);
        }
    }

    /**
     * 判断当前系统是否windows
     *
     * @return
     */
    public static boolean isWindowsOS() {
        boolean isWindowsOS = false;
        String osName = System.getProperty("os.name");
        if (osName.toLowerCase().indexOf("windows") > -1) {
            isWindowsOS = true;
        }
        return isWindowsOS;
    }

    /**
     * 取当前系统站点本地地址 linux下 和 window下可用 add by RWW
     *
     * @return
     */
    public static String getLocalIP() {
        String sIP = "";
        InetAddress ip = null;
        try {
            // 如果是Windows操作系统
            if (isWindowsOS()) {
                ip = InetAddress.getLocalHost();
            } else {// 如果是Linux操作系统
                boolean bFindIP = false;
                Enumeration<NetworkInterface> netInterfaces = (Enumeration<NetworkInterface>) NetworkInterface
                        .getNetworkInterfaces();
                while (netInterfaces.hasMoreElements()) {
                    if (bFindIP) {
                        break;
                    }
                    NetworkInterface ni = (NetworkInterface) netInterfaces.nextElement();
                    // ----------特定情况，可以考虑用ni.getName判断
                    // 遍历所有ip
                    Enumeration<InetAddress> ips = ni.getInetAddresses();
                    while (ips.hasMoreElements()) {
                        ip = (InetAddress) ips.nextElement();
                        if (ip.isSiteLocalAddress() && !ip.isLoopbackAddress() // 127.开头的都是lookback地址
                                && ip.getHostAddress().indexOf(":") == -1) {
                            bFindIP = true;
                            break;
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (null != ip) {
            sIP = ip.getHostAddress();
        }
        return sIP;
    }

    private static String getStackMsg(Throwable e) {

        StringBuffer sb = new StringBuffer(e.getClass().getName() + "\n");
        StackTraceElement[] stackArray = e.getStackTrace();
        for (int i = 0; i < stackArray.length; i++) {
            StackTraceElement element = stackArray[i];
            sb.append("\tat" + element.toString() + "\n");
        }
        return sb.toString();
    }
}
