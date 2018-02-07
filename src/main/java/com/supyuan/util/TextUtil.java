package com.supyuan.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Random;
import java.util.UUID;

public class TextUtil {

	public static final SimpleDateFormat TIME_STANDARD = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public static final SimpleDateFormat TIME_DAY = new SimpleDateFormat("yyyy-MM-dd");
	
	public static final SimpleDateFormat ORDER_TIME_DAY = new SimpleDateFormat("yyyyMMdd");
	
	public static String dateFormat(Timestamp ts) {
		return TIME_DAY.format(ts);
	}

	public static boolean isEmpty(String input) {
		if (input == null)
			return true;
		if (input.trim().length() == 0)
			return true;
		return false;
	}
	
	public static boolean isNotEmpty(String input) {
		if (input == null)
			return false;
		if (input.trim().length() == 0)
			return false;
		return true;
	}

	public static String randomInteger() {
		Random random = new Random();
		int number = random.nextInt(999999);
		while (number <= 99999) 
		{
			number = random.nextInt(999999);
		}
		return String.valueOf(number);
	}

	public static String getRandomNumberString(int length) {
	    String base = "0123456789";   
	    Random random = new Random();   
	    StringBuffer sb = new StringBuffer();   
	    for (int i = 0; i < length; i++) {   
	        int number = random.nextInt(base.length());   
	        sb.append(base.charAt(number));   
	    }   
	    return sb.toString();
	}  

	public static String getRandomString(int length) {
	    String base = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";   
	    Random random = new Random();   
	    StringBuffer sb = new StringBuffer();   
	    for (int i = 0; i < length; i++) {   
	        int number = random.nextInt(base.length());   
	        sb.append(base.charAt(number));   
	    }   
	    return sb.toString();   
	}

	public static String generateUUID() {
		return UUID.randomUUID().toString().replace("-", "");
	}
}
