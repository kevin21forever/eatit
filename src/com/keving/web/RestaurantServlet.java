package com.keving.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.keving.constant.MenuConstant;
import com.keving.model.Restaurant;
import com.keving.model.vo.RestaurantInfo;
import com.keving.model.vo.ResultInfo;
import com.keving.service.RestaurantService;
import com.keving.util.JsonUtil;
import com.keving.util.StringUtil;
@WebServlet("/restaurantServlet")
public class RestaurantServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RestaurantService restaurantService = new RestaurantService();
       
    public RestaurantServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("menu_page", MenuConstant.RESTAURANT_PAGE);
		//得到餐厅ID存到作用域中
		String restaurantId = request.getParameter("id");
		request.setAttribute("restaurantId", restaurantId);
		String action = request.getParameter("action");
		
		if(StringUtil.isEmpty(action)||action.equals("info")){
			// 得到餐厅对象
			Restaurant restaurant = restaurantService.queryRestaurantById(restaurantId);
			// 放到作用域中
			RestaurantInfo restaurantInfo = (RestaurantInfo) request.getSession().getAttribute("restaurantInfo");
			restaurantInfo.setResultObject(restaurant);
			request.getSession().setAttribute("restaurantInfo", restaurantInfo);
			
			request.setAttribute("restaurant", restaurant);
		    // 转发到指定页面
			request.getRequestDispatcher("restaurant.jsp").forward(request, response);
		}else if(action.equals("update")){
			ResultInfo resultInfo = restaurantService.updateRestaurantInfo(request);
			JsonUtil.toJson(resultInfo, response);
		}
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
