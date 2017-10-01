package com.keving.test;

import java.util.List;

import org.junit.Test;

import com.keving.dao.RestaurantDao;
import com.keving.model.Restaurant;

public class RestaurantDaoTest {

	@Test
	public void test() {
		RestaurantDao userDao = new RestaurantDao();
		Restaurant user = new Restaurant();
		List<Restaurant> restaurants = (List<Restaurant> ) userDao.queryRestaurantByUserId(8);
		System.out.println(restaurants);
	}

}
