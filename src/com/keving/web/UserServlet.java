package com.keving.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.keving.constant.MenuConstant;
import com.keving.model.User;
import com.keving.model.vo.RestaurantInfo;
import com.keving.model.vo.ResultInfo;
import com.keving.service.RestaurantService;
import com.keving.service.UserService;
import com.keving.util.JsonUtil;
import com.keving.util.StringUtil;

@WebServlet("/userServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();
	private RestaurantService restaurantService = new RestaurantService();
       
    public UserServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String action = request.getParameter("action");
		
		if(StringUtil.isEmpty(action)){
			response.sendRedirect("login.jsp");
		}else if(action.equals("login")){
			//用户登录
			ResultInfo resultInfo = userLogin(request,response);
			JsonUtil.toJson(resultInfo, response);
		}else if(action.equals("logOut")){
			//用户退出
			userLogOut(request,response);
		}else if(action.equals("toUpdate")){
			//进入修改页面
			toUpdate(request,response);
		}else if(action.equals("updateUser")){
			//修改用户信息
			updateUser(request,response);
		}else  if(action.equals("autoLogin")){
			//自动登录
			autoLogin(request,response);
		}
		
		
		
		
		
		
		
	}

	private void autoLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ResultInfo resultInfo = userLogin(request,response);
		if(resultInfo != null && resultInfo.getResultCode()==1){
			String currentUrl = request.getParameter("currentUrl");
			
			String currentParams = request.getParameter("currentParams");
			if(!"null".equals(currentParams)){
				
				if(StringUtil.isNotEmpty(currentParams))
				{
					currentParams = currentParams.replaceAll("-", "&");
				}
			}
			response.sendRedirect(currentUrl+"?"+currentParams);
			
			
		}else{
			response.sendRedirect("login.jsp");
		}
		
	}

	private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		//获得参数email  username password
		String email = request.getParameter("email");
		String userName = request.getParameter("userName");
		String newPassword = request.getParameter("newPassword");
		
		ResultInfo resultInfo = userService.updateUser(email, userName, newPassword);

		//存到session
		request.getSession().setAttribute("userInfo", resultInfo);
		
		//传给前台
		JsonUtil.toJson(resultInfo, response);
		
		
		
	}

	private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("menu_page",MenuConstant.USER_PAGE);
		
		String restaurantId = request.getParameter("id");
		
		request.setAttribute("restaurantId", restaurantId);
		//从session中获取用户信息
		ResultInfo resultInfo = (ResultInfo) request.getSession().getAttribute("userInfo");
		
		if(resultInfo  != null && resultInfo.getResultObject() != null ){
			
			User user = (User) resultInfo.getResultObject();
			request.setAttribute("user", user);
			request.getRequestDispatcher("editself.jsp").forward(request, response);
		}
			
	
		
		
	}

	private void userLogOut(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 清空session
		request.getSession().setAttribute("userInfo", null);
		request.getSession().invalidate(); // 销毁会话
		// 清空cookie
		Cookie[] cookie = request.getCookies();
		if (cookie != null && cookie.length >0) {
			for (Cookie cookie2 : cookie) {
				if (cookie2.getName().equals("userInfo")) {
							cookie2.setMaxAge(0);
							response.addCookie(cookie2);
						}
					}
				}
				response.sendRedirect("login.jsp");
		
		
		
	}

	private ResultInfo userLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String isRememberPwd = request.getParameter("isRememberPwd");
		
		
		ResultInfo resultInfo = userService.userLogin(email,password);
		
		if (resultInfo.getResultCode() == 1) {
			
			// 是否免登录
			if (StringUtil.isNotEmpty(isRememberPwd) && isRememberPwd.equals("1")) {
				// 存Cookie
				String value = email + "-" + password;
				Cookie cookie = new Cookie("userInfo", value);
				cookie.setPath(request.getContextPath());
				cookie.setMaxAge(60*60*24*3); // 设置为3天失败，单位秒
				response.addCookie(cookie);
			}
			User user = (User)resultInfo.getResultObject();
			// 如果登录成功，查询用户管理的餐厅
			RestaurantInfo restaurantInfo = restaurantService.queryRestaurantByUserId(user.getUserId(), null);
			// 判断是否查询到数据
			if (restaurantInfo != null) {
				
				resultInfo.setResultID(restaurantInfo.getRestaurantId());
				// 存到session
				request.getSession().setAttribute("restaurantInfo", restaurantInfo);
			}
			
		}
		// 存session
		request.getSession().setAttribute("userInfo", resultInfo);
		
		return resultInfo;
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
