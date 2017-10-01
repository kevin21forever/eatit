package com.keving.test;

import org.junit.Before;
import org.junit.Test;

import com.keving.dao.ReviewDao;

public class ReviewDaoTest {

	@Before
	public void init(){
		
	}
	
	@Test
	public void test() {
		ReviewDao rd = new ReviewDao();
		System.out.println(rd.queryTotalReviewByRestaurantId(1));
	}

}
