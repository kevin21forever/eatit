package com.keving.test;


import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.keving.util.DBUtil;

public class DBUtilTest {

	@Test
	public void test() {
		Logger logger = LoggerFactory.getLogger(DBUtilTest.class);
		DBUtil.getConnection();
		logger.debug("{}",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		logger.info("info....");	
		logger.error("error....");		
		logger.warn("warn....");	
	}

}
