package com.keving.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

public class JsonUtil {
	
	/**
	 * 将对象转换成JSON字符串放到response中
	 * 传递JSON数据类型给Ajax回调函数方法
	 * @param result
	 * @param response
	 * @throws IOException
	 */
	public static void toJson(Object result, HttpServletResponse response) throws IOException {
		response.setContentType("application/json;charset=utf-8");
		// 获取response的输出流,这个流是字符流用来向jsp界面输出字符串的
		PrintWriter pw = response.getWriter();
		Gson gson = new Gson();
		// 将object转换为JSON字符串
		String json = gson.toJson(result);
		// 输出
		pw.write(json);
		// 刷新
		pw.flush();
		// 关闭
		pw.close();
	}

}
