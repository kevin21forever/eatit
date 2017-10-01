package com.keving.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.keving.constant.MenuConstant;
import com.keving.model.vo.ReviewVo;
import com.keving.service.ReviewService;
import com.keving.util.Page;

@WebServlet("/reviewServlet")
public class ReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private ReviewService reviewService = new ReviewService();
	
	
    public ReviewServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String aa = (String) request.getAttribute("menu_page");
		request.setAttribute("menu_page", MenuConstant.REVIEW_PAGE);
		String bb = (String) request.getAttribute("menu_page");
		
		String restaurantId = request.getParameter("id");
		request.setAttribute("restaurantId", restaurantId);
		String pageNum  = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");
		
		Page<ReviewVo> page = reviewService.findReviewListByPage(restaurantId,pageNum,pageSize);
		
		request.setAttribute("page", page);
		
		request.getRequestDispatcher("review.jsp").forward(request, response);
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
