package com.supyuan.util;

import java.util.Properties;

public class PropertiesUtil {

	private static PropertiesUtil instance;
	
	private Properties properties;
	
	public PropertiesUtil(String fileName) {
		initConfig(fileName);
	}

	public static PropertiesUtil getInstance()
	{
		if(instance == null)
		{
			instance = new PropertiesUtil("pay.properties");
		}
		return instance;
	}
	
	public void initConfig(String fileName) {
		try {
			properties = new Properties();
			ClassLoader cl = Thread.currentThread().getContextClassLoader();
			properties.load(cl.getResourceAsStream(fileName));
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public String getProperties(String key)
	{
		return properties.getProperty(key);
	}
}
