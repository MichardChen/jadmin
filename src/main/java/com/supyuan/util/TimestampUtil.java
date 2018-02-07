package com.supyuan.util;

import java.util.Calendar;
import java.util.HashMap;

public class TimestampUtil {
	
	public static long getTimestampByOffsetDay(int day){
			
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DAY_OF_MONTH, day);
			calendar.set(Calendar.HOUR_OF_DAY, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.MILLISECOND, 0);
			
			return calendar.getTimeInMillis();
		}

	public static HashMap<String, Object> getTodayTimestamp(){
		
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		
		hashMap.put("startTime", getTimestampByOffsetDay(0));
		hashMap.put("endTime", getTimestampByOffsetDay(1));
		
		return hashMap;
	}

	public static HashMap<String, Object> getWeekTimestamp() {
	
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
	
		Calendar calendar = Calendar.getInstance();
	
		hashMap.put("startTime",getTimestampByOffsetDay(0 - calendar.get(Calendar.DAY_OF_WEEK) + 2));
		hashMap.put("endTime",getTimestampByOffsetDay(calendar.getMaximum(Calendar.DAY_OF_WEEK)- calendar.get(Calendar.DAY_OF_WEEK) + 1));
	
		return hashMap;
	}

	public static HashMap<String, Object> getMonthTimestamp() {
	
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
	
		Calendar calendar = Calendar.getInstance();
	
		hashMap.put("startTime",getTimestampByOffsetDay(0 - calendar.get(Calendar.DAY_OF_MONTH) + 1));
		hashMap.put("endTime",getTimestampByOffsetDay(calendar.getMaximum(Calendar.DAY_OF_MONTH)- calendar.get(Calendar.DAY_OF_MONTH)));
	
		return hashMap;
	}
}
