package com.keving.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Restaurant {

	private Integer restaurantId; // 餐厅ID
	private String restaurantName; // 餐厅名称
	private String address; // 餐厅地址
	private String telephone; // 餐厅电话
	private String cuisine; // 菜系
	private String avgPrice; // 人均价格
	private String website; // 网址
	private Integer isHasWiFi; // 是否有wifi 1=有 0=没有
	private Integer isHasSeat; // 是否有座 1=有 0=没有
	private Date createDate;
	private Date updateDate;
	private Integer isValid;
	
	
}
