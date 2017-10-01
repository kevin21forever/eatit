package com.keving.filter;

import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.keving.model.Restaurant;
import com.keving.model.vo.RestaurantInfo;
import com.keving.model.vo.ResultInfo;
import com.keving.util.StringUtil;



/**
 * 用户非法请求过滤
 */
@WebFilter(urlPatterns="/*")
public class NoAccessFilter implements Filter {

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain chain) throws IOException, ServletException {
		/**
		 * 1.合法请求
		 *    登录,注册,退出   放行
		 * 2.合法资源（静态资源）
		 *   图片，css js 放心   login.jsp,register.jsp  放行
		 * 3.非法请求过滤
		 *    判断用户是否登录
		 *       登录  用户操作合法  放行（执行servlet 相关方法）
		 *       未登录  用户操作非法 跳转到登录页面执行登录操作
		 */
		HttpServletRequest request = (HttpServletRequest) arg0;
		HttpServletResponse response = (HttpServletResponse) arg1;
		
		String restauarntId = request.getParameter("id");
		
		RestaurantInfo restaurantInfo = (RestaurantInfo) request.getSession().getAttribute("restaurantInfo");
		if (restaurantInfo != null) {
			List<Restaurant> restaurants = restaurantInfo.getResultList();
			if (restaurants != null && restaurants.size() > 0) {
				if (StringUtil.isNotEmpty(restauarntId)) {
					for (Restaurant restaurant : restaurants) {
						Integer id = restaurant.getRestaurantId();
						if (Integer.parseInt(restauarntId) == id) {
							restaurantInfo.setRestaurantId(id);
							restaurantInfo.setResultObject(restaurant);
							break;
						}
					}
				} 		
			}
		}
		
		
		
		 
		String url = request.getRequestURI();// 用户请求的资源  /eatit/loginl.jsp     
	//	StringBuffer aaa = request.getRequestURL();    http://localhost:8080/eatit/loginl.jsp
		// 把转发前的url放到作用域中
		request.setAttribute("currentPageUrl", url);
	
		// 静态资源  login register 执行放行
		if(url.contains("/statics") || url.contains("login.jsp")
				||url.contains("amaptest.jsp") 
				){
			chain.doFilter(request, response);
			return;
		}
		
		// 合法请求执行放行处理
		String action = request.getParameter("action");
		if(!StringUtil.isEmpty(action)){
			if(action.equals("login") || action.equals("logOut") || action.equals("autoLogin")){
				chain.doFilter(request, response);
				return;
			}
		}
		
		  /**
		   * 获取session 中userInfo	
		   *   userInfo 非空  用户已登录
		   *   userInfo 空  用户未登录
		   */
			HttpSession session=request.getSession();
			ResultInfo messageModel=(ResultInfo) session.getAttribute("userInfo");
			if(null==messageModel){
				response.sendRedirect(request.getContextPath()+"/login.jsp");
				return;
			}
			chain.doFilter(request, response);
		}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
