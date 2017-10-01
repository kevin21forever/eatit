package com.keving.model.vo;

import lombok.Data;

@Data
public class ReviewVo {
	private Integer reviewId;
	private String content;
	private Integer isLikeIt; // 是否喜欢这家餐厅 (0=不喜欢，1=喜欢)
	private String userName;
	private String reviewDate;
}
