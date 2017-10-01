package com.keving.service;

import java.util.List;

import com.keving.dao.ReviewDao;
import com.keving.model.vo.ReviewVo;
import com.keving.util.Page;
import com.keving.util.StringUtil;

public class ReviewService {
	
	private ReviewDao reviewDao = new ReviewDao();

	public Page<ReviewVo> findReviewListByPage(String restaurantIdStr, String pageNumStr, String pageSizeStr) {
		
		if(StringUtil.isEmpty(restaurantIdStr)){
			return null;
		}
		
		Integer restaurantId = Integer.parseInt(restaurantIdStr);
		
//		设置pageNum
		Integer pageNum = 1;
		if(StringUtil.isNotEmpty(pageNumStr)){
			pageNum = Integer.parseInt(pageNumStr);
		}
		
//		设置pageSize
		Integer pageSize = 1;
		if(StringUtil.isNotEmpty(pageSizeStr)){
			pageSize = Integer.parseInt(pageSizeStr);
		}
		
		
//		查询总记录数
		Integer totalcount = reviewDao.queryTotalReviewByRestaurantId(restaurantId);
		
		
//		查询餐厅评论集合
		List<ReviewVo> reviewVos = reviewDao.queryReviewList(restaurantId,pageNum,pageSize);
		
		
		
//		创建page对象
		Page<ReviewVo> page = new Page<>(pageNum,pageSize,totalcount);
		
		page.setDatas(reviewVos);
		
		return page;
		
		
	}

}
