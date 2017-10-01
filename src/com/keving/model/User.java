package com.keving.model;

import java.sql.Date;

import lombok.Data;

@Data
public class User {
	
	private Integer userId; // 用户ID
	private String email; // 用户邮箱
	private String userName; // 用户名称
	private String password; // 用户密码
	private Date createDate; // 创建时间
	private Date updateDate; // 修改时间
	private Integer isValid; // 用户是否有效 0=无效，1=有效
	
	
}
