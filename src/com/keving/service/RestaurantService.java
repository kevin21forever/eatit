package com.keving.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.keving.dao.RestaurantDao;
import com.keving.model.Restaurant;
import com.keving.model.vo.RestaurantInfo;
import com.keving.model.vo.ResultInfo;
import com.keving.util.StringUtil;

public class RestaurantService {

	private RestaurantDao restaurantDao = new RestaurantDao();

	public RestaurantInfo queryRestaurantByUserId(Integer userId, String restaurantId) {
		RestaurantInfo restaurantInfo = new RestaurantInfo();
		// 参数的非空判断
		if (userId == null || userId == 0) {
			return null;
		}
		// 通过用户ID去数据库查询餐厅集合
		List<Restaurant> restaurants = restaurantDao.queryRestaurantByUserId(userId);
		if (restaurants != null && restaurants.size() > 0) {
			restaurantInfo.setResultList(restaurants);
			if (StringUtil.isNotEmpty(restaurantId)) {
				for (Restaurant restaurant : restaurants) {
					Integer id = restaurant.getRestaurantId();
					if (Integer.parseInt(restaurantId) == id) {
						restaurantInfo.setRestaurantId(id);
						restaurantInfo.setResultObject(restaurant);
						break;
					}
				}
			} else {
				restaurantInfo.setResultObject(restaurants.get(0));//null
				restaurantInfo.setRestaurantId(restaurants.get(0).getRestaurantId());//null
			}
			
		}
		
		return restaurantInfo;
	}

	
	
	public Restaurant queryRestaurantById(String restaurantId) {
		if (StringUtil.isEmpty(restaurantId)) {
			return null;
		}
		Restaurant restaurant = restaurantDao.queryRestaurantById(restaurantId);
		return restaurant;
	}

	
	/**
	 * 修改餐厅信息
	 * @param request
	 * @return
	 */
	public ResultInfo updateRestaurantInfo(HttpServletRequest request) {
		ResultInfo resultInfo = new ResultInfo();
		// 得到参数
		String restaurantId = request.getParameter("id");
		
		if (StringUtil.isEmpty(restaurantId)) {
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("餐厅ID不能为空！");
			return resultInfo;
		}
		
		
		// 通过餐厅ID查询餐厅对象
		Restaurant restaurant = restaurantDao.queryRestaurantById(restaurantId);
		// 判断餐厅是否存在
		if (restaurant == null) {
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("餐厅不存在！");
			return resultInfo;
		}		


		// 餐厅名称
		String restaurantName = request.getParameter("restaurantName");
		if (StringUtil.isEmpty(restaurantName)) {
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("餐厅名称不能为空！");
			return resultInfo;
		}
		restaurant.setRestaurantName(restaurantName);
		
		// 餐厅地址
		String address = request.getParameter("address");
		if (StringUtil.isEmpty(address)) {
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("餐厅地址不能为空！");
			return resultInfo;
		}
		restaurant.setAddress(address);
		
		// 菜系
		String cuisine = request.getParameter("cuisine");
		if (StringUtil.isEmpty(cuisine)) {
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("菜系不能为空！");
			return resultInfo;
		}
		restaurant.setCuisine(cuisine);
		
		// 人均价格
		String avgPrice = request.getParameter("avgPrice");
		if (StringUtil.isEmpty(avgPrice)) {
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("人均价格不能为空！");
			return resultInfo;
		}
		restaurant.setAvgPrice(avgPrice);		
		
		// 是否有WiFi
		String isHasWiFiStr = request.getParameter("isHasWiFi");
		if (StringUtil.isNotEmpty(isHasWiFiStr) && isHasWiFiStr.equals("1")) {
			restaurant.setIsHasWiFi(1);
		} else {
			restaurant.setIsHasWiFi(0);
		}
		// 是否室外有座
		String isHasSeatStr = request.getParameter("isHasSeat");
		if (StringUtil.isNotEmpty(isHasSeatStr) && isHasSeatStr.equals("1")) {
			restaurant.setIsHasSeat(1);
		} else {
			restaurant.setIsHasSeat(0);
		}

		
		// 修改用户信息
		Integer code = restaurantDao.updateRestaurantInfo (restaurant);
		if (code != 1) {
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("修改失败！");
			return resultInfo;
		}
		
		resultInfo.setResultCode(1);
		resultInfo.setResultMessage("Success!");
		resultInfo.setResultObject(restaurant);
		
		return resultInfo;
		
		
		
	}
	
	
}
