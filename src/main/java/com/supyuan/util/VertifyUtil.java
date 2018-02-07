package com.supyuan.util;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public final class VertifyUtil {

	public VertifyUtil() {
	}

	public static String getVertifyCode() {
		String[] beforeShuffle = new String[] { "2", "3", "4", "5", "6", "7", "8", "9", "0" };
		List list = Arrays.asList(beforeShuffle);
		Collections.shuffle(list);
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < list.size(); i++) {
			sb.append(list.get(i));
		}
		String afterShuffle = sb.toString();
		String result = afterShuffle.substring(5, 9);
		return result;
	}
}
