package com.keving.test;

import org.junit.Test;

import com.keving.util.StringUtil;

public class StringUtilTest {

	@Test
	public void test() {
		String str= "  " ;
		System.out.println((str != null && !"".equals(str.trim())) );
		if(StringUtil.isNotEmpty(str)){
			System.out.println("hello");
		}
		
		System.out.println("==============");
		System.out.println(!StringUtil.isEmpty(str)==StringUtil.isNotEmpty(str));
	}

}
