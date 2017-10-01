package com.keving.model.vo;

import lombok.Data;

/**
 * 返回的封装类
 */
@Data
public class ResultInfo {
	
	private Integer resultCode; // 状态码 1=成功，0=失败
	private String resultMessage;  // 消息提示
	private Object resultObject; // 返回的对象
	private Integer resultID; // 返回的ID
	
}
