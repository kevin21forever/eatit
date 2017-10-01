package com.keving.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;


public class DBUtil {

	/**
	 * 得到数据库连接
	 * @return
	 */
	public static Connection getConnection () {
		Connection connection = null;
		try {
			
			// 1、方式一
			//Class.forName("com.mysql.jdbc.Driver");
			//connection =  DriverManager.getConnection("jdbc:mysql://localhost:3306/shsxt_restaurant", "root", "root");
			 
			// 2、方式2
			// 加载properties文件
			Properties properties = new Properties();
			// 使用class.getClassLoader()所得到的java.lang.ClassLoader的getResourceAsStream()方法 
			// 默认则是从ClassPath根下获取，path不能以'/'开头，最终是由ClassLoader获取资源
			// 先获得文件的输入流，然后通过Properties类的load(InputStream inStream)方法加载到Properties对象中，最后通过Properties对象来操作文件内容
			properties.load(DBUtil.class.getClassLoader().getResourceAsStream("db.properties"));

			// 通过properties.getProperty()方法得到参数的值
			String driver = properties.getProperty("jdbc.driver");
			String url = properties.getProperty("jdbc.url");
			String user = properties.getProperty("jdbc.username");
			String pwd = properties.getProperty("jdbc.password");
			// 加载驱动
			Class.forName(driver);
			// 获取数据库的连接
			connection = DriverManager.getConnection(url, user, pwd);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}
	
	/**
	 * 关闭连接
	 * @param connection
	 */
	public static void closeConnection(Connection connection) {
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 关闭资源
	 * @param resultSet
	 * @param ps
	 * @param connection
	 */
	public static void close(ResultSet resultSet, 
			PreparedStatement preparedStatement, Connection connection) {
		try {
			if (resultSet != null) {
				resultSet.close();
			}
			if (preparedStatement != null) {
				preparedStatement.close();
			}
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public static void main(String[] args) {
		for(int i = 0; i < 100; i++){
			System.out.println("i = " + i + "---" + getConnection());
		}
	}
	
}
