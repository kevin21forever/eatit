package com.keving.model;

import java.util.Date;

import lombok.Data;

@Data
public class Review {
	private Integer reviewId;
	private Integer fkUserId; // user表中的userId
	private Integer fkRestaurantId;
	private String content;
	private Integer isLikeIt; // 是否喜欢这家餐厅 (0=不喜欢，1=喜欢)
	private Date createDate;
	private Date updateDate;
	private Integer isValid; // 评论是否有效 (0=无效，1=有效)
}
