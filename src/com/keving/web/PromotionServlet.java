package com.keving.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.keving.constant.MenuConstant;
import com.keving.model.Promotion;
import com.keving.model.vo.RestaurantInfo;
import com.keving.model.vo.ResultInfo;
import com.keving.service.PromotionService;
import com.keving.util.JsonUtil;
import com.keving.util.Page;
import com.keving.util.StringUtil;

@WebServlet("/promotionServlet")
public class PromotionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PromotionService promotionService = new PromotionService();
	
       
    public PromotionServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("menu_page", MenuConstant.PROMOTION_PAGE);
		String aa = request.getParameter("id");
		
		String action = request.getParameter("action");
		
		if(StringUtil.isEmpty(action)||action.equals("info")){
			//促销列表   查
			promotionInfo(request,response);
		}else if(action.equals("toCreate")){
			request.getRequestDispatcher("promotion-create.jsp").forward(request, response);
		}else if(action.equals("saveOrUpdate")){
			saveOrUpdate(request,response);
		}else if(action.equals("toUpdate")){
			toUpdate(request,response);
		}else if(action.equals("delete")){
			delete(request,response);
		}else if(action.equals("isActive")){
			isActive(request,response);
		}
		
	}

	private void isActive(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		//获取参数
		String restaurantId = request.getParameter("id");
		String promotionId = request.getParameter("promotionId");
		String isActive = request.getParameter("isActive");
		request.setAttribute("restaurantId", restaurantId);
		
		//调用service层，返回resultInfo
		ResultInfo resultInfo = promotionService.isActive(restaurantId,promotionId,isActive);
		
		//传给前台
		JsonUtil.toJson(resultInfo, response);
		
		
		
	}

	private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//获取参数
		String restaurantId = request.getParameter("id");
		request.setAttribute("restaurantId", restaurantId);
		String promotionId =request.getParameter("promotionId");
		
		
		//删除
		ResultInfo resultInfo = promotionService.deletePromotion(restaurantId,promotionId);
		
		//将数据传回前台
		JsonUtil.toJson(resultInfo, response);
		
	}

	private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//得到promotionId
		String promotionId = request.getParameter("promotionId");
		
		String restaurantId = request.getParameter("id");
		request.setAttribute("restaurantId", restaurantId);
		//得到促销对象
		Promotion promotion=promotionService.queryPromotionById(promotionId);  
				
		//存到域对象
		request.setAttribute("promotion", promotion);
		
		
		//进入修改页面
		request.getRequestDispatcher("promotion-update.jsp").forward(request, response);
		
		
	}

	private void saveOrUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
	//获取参数
		String promotionType = request.getParameter("promotionType");
		String promotionName = request.getParameter("promotionName");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String content = request.getParameter("content");
		String isActive = request.getParameter("isActive");
		String restaurantId = request.getParameter("id");
		request.setAttribute("restaurantId", restaurantId);
		String promotionId = request.getParameter("promotionId");
		
		//修改
		ResultInfo resultInfo = promotionService.saveOrUpdatePromtion(promotionType,
				promotionName,startDate,endDate,content,isActive,restaurantId,promotionId);
		
				
		//传给前台
			JsonUtil.toJson(resultInfo, response);
	}

	private void promotionInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RestaurantInfo restaurantInfo = (RestaurantInfo) request.getSession().getAttribute("restaurantInfo");
		
		String restaurantid = request.getParameter("id");
		request.setAttribute("restaurantId", restaurantid);
		if(restaurantInfo == null){
			return;
		}
		//得到餐厅id
		Integer restaurantId  = restaurantInfo.getRestaurantId();
		
		String pageNum = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");
				
		Page<Promotion> page = promotionService.findPromotionByPage(restaurantId,pageNum,pageSize);
		
		request.setAttribute("page", page);
		
		request.getRequestDispatcher("promotion.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
