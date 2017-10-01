package com.keving.service;

import com.keving.dao.UserDao;
import com.keving.model.User;
import com.keving.model.vo.ResultInfo;
import com.keving.util.Md5Util;
import com.keving.util.StringUtil;

public class UserService {
	
	private UserDao userDao = new UserDao();

	public ResultInfo userLogin(String email, String password) {
		ResultInfo resultInfo = new ResultInfo();
			
		//非空校验
		if (StringUtil.isEmpty(email)) {
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("用户邮箱不能为空！");
			return resultInfo;
		}
		if (StringUtil.isEmpty(password)) {
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("用户密码不能为空！");
			return resultInfo;
		}
		
		// 通过邮箱从数据库获取用户对象
		User user = userDao.queryUserByEmail(email);
		
		// 判断用户对象是否为空
		if (user == null) {
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("用户不存在！");
			return resultInfo;
		}
		
		// 得到数据库的用户密码
		String pwd = user.getPassword();
		
		// 判断密码是否相等
		if (!Md5Util.encode(password).equals(pwd)) {
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("用户密码不正确！");
			return resultInfo;
		}	
	
		
		
		resultInfo.setResultCode(1);
		resultInfo.setResultMessage("Success");
		resultInfo.setResultID(user.getUserId());
		resultInfo.setResultObject(user);
		
		return resultInfo;
		
		
	}

	public ResultInfo updateUser(String email,String userName,String newPassword) {
		ResultInfo resultInfo = new ResultInfo();
		String password = null;
		
		//邮箱，用户名非空判断
		if(StringUtil.isEmpty(email)){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("用户邮箱不为空");
			return resultInfo;
		}
		
		if(StringUtil.isEmpty(userName)){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("用户名不为空");
			return resultInfo;
		}
		
		
		User user = userDao.queryUserByEmail(email);
		
		if(user == null){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("用户不存在");
			return resultInfo;
		}
		
		if(StringUtil.isNotEmpty(newPassword)){
			
			//密码MD5加密后存入数据库
			 password = Md5Util.encode(newPassword);
			
		}else{
			password = null;
		}
		//修改用户信息
		int result = userDao.updateUser(email,userName,password);
		
		if(result != 1){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("用户修改失败！！！");
			return resultInfo;
		}
		
		
		user.setUserName(userName);
		user.setPassword(newPassword);
		resultInfo.setResultObject(user);
		resultInfo.setResultCode(1);
		resultInfo.setResultMessage("用户信息修改成功");
		
		return resultInfo;
		
	}

}
