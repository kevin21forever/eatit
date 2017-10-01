package com.keving.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.keving.model.User;
import com.keving.model.vo.RestaurantInfo;
import com.keving.model.vo.ResultInfo;
import com.keving.service.RestaurantService;

@WebServlet("/indexServlet")
public class IndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private RestaurantService restaurantService = new RestaurantService();
	
    public IndexServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String restaurantId = request.getParameter("id");
		request.setAttribute("restaurantId", restaurantId);
		ResultInfo resultInfo = (ResultInfo)request.getSession().getAttribute("userInfo");
		User user = (User)resultInfo.getResultObject();
		RestaurantInfo restaurantInfo = restaurantService.queryRestaurantByUserId(user.getUserId(), restaurantId);
		request.getSession().setAttribute("restaurantInfo", restaurantInfo);
		request.setAttribute("menu_page", "INDEX_PAGE");
		request.getRequestDispatcher("index.jsp").forward(request, response);
		
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
