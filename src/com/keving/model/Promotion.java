package com.keving.model;

import java.util.Date;

import lombok.Data;

@Data
public class Promotion {

	private Integer promotionId; // 活动ID
	private Integer fkRestaurantId; // 餐厅ID
	private String promotionName; // 活动名称
	private Integer promotionType; // 促销类型
	private Date startDate; // 促销开始时间
	private Date endDate; // 促销结束时间
	private Integer isActive; // 活动是否上线 (0=未上线,1=已上线)
	private String content; // 促销活动内容
	private Date createDate;
	private Date updateDate;
	private Integer isValid;
	
	

	
	
}
