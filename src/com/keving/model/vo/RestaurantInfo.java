package com.keving.model.vo;

import java.util.List;

import com.keving.model.Restaurant;

import lombok.Data;

/**
 * 餐厅的封装类对象类
 */
@Data
public class RestaurantInfo {

	private Integer restaurantId; // 当前餐厅ID
	private Restaurant resultObject; // 当前餐厅对象
	private List<Restaurant> resultList; // 餐厅集合
	
}
