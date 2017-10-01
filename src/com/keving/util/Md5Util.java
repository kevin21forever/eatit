package com.keving.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import org.apache.tomcat.util.codec.binary.Base64;

public class Md5Util {
	
	public static String  encode(String msg){
		 try {
			 // 创建 MessageDigest对象, MessageDigest类为应用程序提供信息摘要算法的功能
			MessageDigest messageDigest = MessageDigest.getInstance("md5");
			byte[] bytes = messageDigest.digest(msg.getBytes());
			return Base64.encodeBase64String(bytes) ;
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		 return null;
	}
	
	
	public static void main(String[] args) {
		System.out.println(encode("123456"));
	}

}
