package com.keving.util;

/**
 * 字符串的帮助类
 */
public class StringUtil {

	/**
	 * 判断字符串是否为空
	 * @param str
	 * @return
	 */
	public static boolean isEmpty(String str) {
		if (str != null  && !"".equals(str.trim())) {
			return false;
		}
		return true;
	}
	
	/**
	 * 判断字符串是否不为空
	 * @param str
	 * @return
	 */
	public static boolean isNotEmpty (String str) {

		if (str != null && !"".equals(str.trim())) {
			return true;
		}
		return false;
	}
}
