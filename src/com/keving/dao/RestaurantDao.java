package com.keving.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.keving.model.Restaurant;
import com.keving.util.DBUtil;

public class RestaurantDao {

	public List<Restaurant> queryRestaurantByUserId(Integer userId) {
		List<Restaurant> restaurants =new ArrayList<>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DBUtil.getConnection();
			String sql = "select restaurantId,restaurantName from restaurant r inner join restaurantownership rs on r.restaurantId = rs.fkRestaurantId where rs.fkUserId = ?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, userId);
			resultSet = preparedStatement.executeQuery();
			while(resultSet.next()) {
				Restaurant restaurant = new Restaurant();
				restaurant.setRestaurantId(resultSet.getInt("restaurantId"));
				restaurant.setRestaurantName(resultSet.getString("restaurantName"));
				restaurants.add(restaurant);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(resultSet, preparedStatement, connection);
		}
		
		return restaurants;
	}

	/**
	 * 通过餐厅ID查询餐厅对象
	 * @param restaurantId
	 * @return
	 */
	public Restaurant queryRestaurantById(String restaurantId) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		Restaurant restaurant = null;
		try {
			// 打开连接
			connection = DBUtil.getConnection();
			// 写sql
			String sql = "select restaurantId,restaurantName,address ,cuisine,avgPrice,"
					+ " telephone,website,isHasWiFi, isHasSeat,createDate,"
					+ " updateDate ,isValid  from restaurant where restaurantId = ? and isValid= 1";
			// 预编译
			preparedStatement = connection.prepareStatement(sql);
			// 传参数
			preparedStatement.setInt(1, Integer.parseInt(restaurantId));
			// 执行查询
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				restaurant = new Restaurant();
				restaurant.setRestaurantId(resultSet.getInt("restaurantId"));
				restaurant.setRestaurantName(resultSet.getString("restaurantName"));
				restaurant.setAddress(resultSet.getString("address"));
				restaurant.setWebsite(resultSet.getString("website"));
				restaurant.setAvgPrice(resultSet.getString("avgPrice"));
				restaurant.setCuisine(resultSet.getString("cuisine"));
				restaurant.setCreateDate(resultSet.getDate("createDate"));
				restaurant.setUpdateDate(resultSet.getDate("updateDate"));
				restaurant.setTelephone(resultSet.getString("telephone"));
				restaurant.setIsHasWiFi(resultSet.getInt("isHasWiFi"));
				restaurant.setIsHasSeat(resultSet.getInt("isHasSeat"));
				restaurant.setIsValid(resultSet.getInt("isValid"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(resultSet, preparedStatement, connection);
		}
		return restaurant;
	}

	
	/**
	 * 修改餐厅信息
	 * @param restaurant
	 * @return
	 */
	public Integer updateRestaurantInfo(Restaurant restaurant) {
		Integer code =0;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = DBUtil.getConnection();
			String sql = "update restaurant set restaurantName = ?, address = ?, cuisine = ?, "
					+ "avgPrice = ?, telephone = ?, website = ?, isHasWiFi = ?, isHasSeat = ?,"
					+ "updateDate = now() where restaurantId = ?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, restaurant.getRestaurantName());
			preparedStatement.setString(2, restaurant.getAddress());
			preparedStatement.setString(3, restaurant.getCuisine());
			preparedStatement.setString(4, restaurant.getAvgPrice());
			preparedStatement.setString(5, restaurant.getTelephone());
			preparedStatement.setString(6, restaurant.getWebsite());
			preparedStatement.setInt(7, restaurant.getIsHasWiFi());
			preparedStatement.setInt(8, restaurant.getIsHasSeat());
			preparedStatement.setInt(9, restaurant.getRestaurantId());
			// 执行修改
			int row = preparedStatement.executeUpdate();
			if (row > 0) { // 修改成功
				code =1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(null, preparedStatement, connection);
		}
		return code;
	}
	

}
