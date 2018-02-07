package com.supyuan.util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


/**
 * 日期操作辅助类
 * 
 * @author ChenDang
 * @version $Id: DateUtil.java, v 0.1 2016年3月28日 上午8:58:11 ShenHuaJie Exp $
 */
public final class DateUtil {
	private DateUtil() {
	}

	static String PATTERN = "yyyy-MM-dd";

	/**
	 * 格式化日期
	 * 
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static final String format(Date date) {
		return format(date, PATTERN);
	}
	
	public static final String formatYM(Date date) {
		return format(date, "yyyy-MM");
	}

	/**
	 * 格式化日期
	 * 
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static final String format(Date date, String pattern) {
		if (date == null) {
			return null;
		}
		if (pattern == null) {
			return format(date);
		}
		return new SimpleDateFormat(pattern).format(date);
	}

	/**
	 * 获取日期
	 * 
	 * @return
	 */
	public static final String getDate() {
		return format(new Date());
	}

	/**
	 * 获取日期时间
	 * 
	 * @return
	 */
	public static final String getDateTime() {
		return format(new Date(), "yyyy-MM-dd HH:mm:ss");
	}
	
	public static final String getDateTimeNO() {
		return format(new Date(), "yyyyMMdd");
	}

	/**
	 * 获取日期
	 * 
	 * @param pattern
	 * @return
	 */
	public static final String getDateTime(String pattern) {
		return format(new Date(), pattern);
	}

	/**
	 * 日期计算
	 * 
	 * @param date
	 * @param field
	 * @param amount
	 * @return
	 */
	public static final Date addDate(Date date, int field, int amount) {
		if (date == null) {
			return null;
		}
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(field, amount);
		return calendar.getTime();
	}

	/**
	 * 字符串转换为日期:不支持yyM[M]d[d]格式
	 * 
	 * @param date
	 * @return
	 */
	public static final Date stringToDate(String date) {
		if (date == null) {
			return null;
		}
		String separator = String.valueOf(date.charAt(4));
		String pattern = "yyyyMMdd";
		if (!separator.matches("\\d*")) {
			pattern = "yyyy" + separator + "MM" + separator + "dd";
			if (date.length() < 10) {
				pattern = "yyyy" + separator + "M" + separator + "d";
			}
		} else if (date.length() < 8) {
			pattern = "yyyyMd";
		}
		pattern += " HH:mm:ss.SSS";
		pattern = pattern.substring(0, Math.min(pattern.length(), date.length()));
		try {
			return new SimpleDateFormat(pattern).parse(date);
		} catch (ParseException e) {
			return null;
		}
	}

	/**
	 * 间隔天数
	 * 
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static final Integer getDayBetween(Date startDate, Date endDate) {
		Calendar start = Calendar.getInstance();
		start.setTime(startDate);
		start.set(Calendar.HOUR_OF_DAY, 0);
		start.set(Calendar.MINUTE, 0);
		start.set(Calendar.SECOND, 0);
		start.set(Calendar.MILLISECOND, 0);
		Calendar end = Calendar.getInstance();
		end.setTime(endDate);
		end.set(Calendar.HOUR_OF_DAY, 0);
		end.set(Calendar.MINUTE, 0);
		end.set(Calendar.SECOND, 0);
		end.set(Calendar.MILLISECOND, 0);

		long n = end.getTimeInMillis() - start.getTimeInMillis();
		return (int) (n / (60 * 60 * 24 * 1000l));
	}

	/**
	 * 间隔月
	 * 
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static final Integer getMonthBetween(Date startDate, Date endDate) {
		if (startDate == null || endDate == null || !startDate.before(endDate)) {
			return null;
		}
		Calendar start = Calendar.getInstance();
		start.setTime(startDate);
		Calendar end = Calendar.getInstance();
		end.setTime(endDate);
		int year1 = start.get(Calendar.YEAR);
		int year2 = end.get(Calendar.YEAR);
		int month1 = start.get(Calendar.MONTH);
		int month2 = end.get(Calendar.MONTH);
		int n = (year2 - year1) * 12;
		n = n + month2 - month1;
		return n;
	}

	/**
	 * 间隔月，多一天就多算一个月
	 * 
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static final Integer getMonthBetweenWithDay(Date startDate, Date endDate) {
		if (startDate == null || endDate == null || !startDate.before(endDate)) {
			return null;
		}
		Calendar start = Calendar.getInstance();
		start.setTime(startDate);
		Calendar end = Calendar.getInstance();
		end.setTime(endDate);
		int year1 = start.get(Calendar.YEAR);
		int year2 = end.get(Calendar.YEAR);
		int month1 = start.get(Calendar.MONTH);
		int month2 = end.get(Calendar.MONTH);
		int n = (year2 - year1) * 12;
		n = n + month2 - month1;
		int day1 = start.get(Calendar.DAY_OF_MONTH);
		int day2 = end.get(Calendar.DAY_OF_MONTH);
		if (day1 <= day2) {
			n++;
		}
		return n;
	}

	public static final Timestamp getNowTimestamp() {
		return new Timestamp(System.currentTimeMillis());
	}

	public static final Timestamp getVertifyCodeExpireTime() {
		Timestamp now = new Timestamp(System.currentTimeMillis());
		long time = now.getTime();
		// 十分钟后,加600秒
		long secondTime = time + 1000 * 60 * 10;
		return new Timestamp(secondTime);
	}

	public static final Timestamp getAccessTokenExpireTime() {
		return new Timestamp(TimestampUtil.getTimestampByOffsetDay(30));
	}

	public static final Timestamp formatStringForTimestamp(String str) {

		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		format.setLenient(false);
		try {
			Timestamp ts = new Timestamp(format.parse(str).getTime());
			return ts;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static final String formatTimestampForDate(Timestamp date) {

		if(date == null){
			return null;
		}
		
		return format(new Date(date.getTime()), "yyyy-MM-dd");
	}
	
	/**
     * 某一年某个月的每一天
     */
    public static List<String> getMonthFullDay(int year,int month){
    	int day = 1;
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<String> fullDayList = new ArrayList<String>();
        if(day <= 0 ) day = 1;
        Calendar cal = Calendar.getInstance();// 获得当前日期对象
        cal.clear();// 清除信息
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month - 1);// 1月从0开始
        cal.set(Calendar.DAY_OF_MONTH, day);// 设置为1号,当前日期既为本月第一天
        
        Calendar calendar = Calendar.getInstance();
        int count = calendar.get(Calendar.DAY_OF_MONTH);
        for (int j = 0; j <= (count-1);) {
            if(sdf.format(cal.getTime()).equals(getLastDay(year, month)))
                break;
            cal.add(Calendar.DAY_OF_MONTH, j == 0 ? +0 : +1);
            j++;
            fullDayList.add(sdf.format(cal.getTime()));
        }
        return fullDayList;
    }
    
    public static String getLastDay(int year,int month){
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month);
        cal.set(Calendar.DAY_OF_MONTH, 0);
        return sdf.format(cal.getTime());
    }
    
    public static String formatYMD(Timestamp time){
    	if(time == null){
    		return null;
    	}else{
    		/*String month = StringUtil.toString(time.getMonth());
    		String day = StringUtil.toString(time.getDay());
    		if(time.getMonth() < 10){
    			month = "0"+month;
    		}
    		if(time.getDay() < 10){
    			day = "0"+day;
    		}
    		return time.getYear()+"年"+month+"月"+day+"日";*/
    		Date date = stringToDate(formatTimestampForDate(time));
    		SimpleDateFormat formatter = new SimpleDateFormat("yyyy年MM月dd日");
    	    return formatter.format(date);
    	}
    }
    
    public static String formatMD(Timestamp time){
    	if(time == null){
    		return null;
    	}else{
    		/*String month = StringUtil.toString(time.getMonth());
    		String day = StringUtil.toString(time.getDay());
    		if(time.getMonth() < 10){
    			month = "0"+month;
    		}
    		if(time.getDay() < 10){
    			day = "0"+day;
    		}
    		return time.getYear()+"年"+month+"月"+day+"日";*/
    		Date date = stringToDate(formatTimestampForDate(time));
    		SimpleDateFormat formatter = new SimpleDateFormat("MM月dd日");
    	    return formatter.format(date);
    	}
    }
    
    public static String formatDateYMD(Date time){
    	
    	if(time == null){
    		return null;
    	}else{
    		/*String month = StringUtil.toString(time.getMonth());
    		String day = StringUtil.toString(time.getDay());
    		if(time.getMonth() < 10){
    			month = "0"+month;
    		}
    		if(time.getDay() < 10){
    			day = "0"+day;
    		}
    		return time.getYear()+"年"+month+"月"+day+"日";*/
    		SimpleDateFormat formatter = new SimpleDateFormat("yyyy年MM月dd日");
    	    return formatter.format(time);
    	}
    }
    
    public static String getLastDayByNum(int day){
    	Calendar theCa = Calendar.getInstance();
    	theCa.setTime(new Date());
    	theCa.add(theCa.DATE, -day);
    	return format(theCa.getTime(),"yyyy-MM-dd");
    }
    
    public static List<String> getMonthFullDayByNum(int day){
    	//今天
    	List<String> fullDayList = new ArrayList<String>();
    	for(int i=day;i>=0;i--){
    		Calendar theCa = Calendar.getInstance();
        	theCa.setTime(new Date());
    		theCa.add(theCa.DATE, -i);
    		String d = format(theCa.getTime(),"yyyy-MM-dd");
    		fullDayList.add(d);
    	}
        return fullDayList;
    }
    
    public static String getFirstDayByMonth(){
    	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");  
        // 获取前月的第一天  
        Calendar cale = Calendar.getInstance();  
        cale.add(Calendar.MONTH, 0);  
        cale.set(Calendar.DAY_OF_MONTH, 1);  
        return format.format(cale.getTime());
    }
}
