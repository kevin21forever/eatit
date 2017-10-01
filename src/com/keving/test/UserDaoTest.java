package com.keving.test;

import static org.junit.Assert.*;

import org.junit.Test;

import com.keving.dao.UserDao;
import com.keving.model.User;

public class UserDaoTest {

	@Test
	public void test() {
		UserDao userDao = new UserDao();
		User user = new User();
		user = userDao.queryUserByEmail("lisa@stark.com");
		System.out.println(user);
		
	}

}
