package com.keving.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.keving.dao.PromotionDao;
import com.keving.model.Promotion;
import com.keving.model.vo.ResultInfo;
import com.keving.util.Page;
import com.keving.util.StringUtil;

public class PromotionService {
	private PromotionDao promotionDao = new PromotionDao();
	private Logger logger = LoggerFactory.getLogger(PromotionService.class);
	

	public Page<Promotion> findPromotionByPage(Integer restaurantId, String pageNumStr, String pageSizeStr) {
		//参数非空
		if(restaurantId == null || restaurantId == 0 ){
			return null;
		}
		
		
		//设置pagenum
		Integer pageNum = 1;
		if(StringUtil.isNotEmpty(pageNumStr)){
			pageNum = Integer.parseInt(pageNumStr);
		}
		
		//设置pagesize
		Integer pageSize = 2;
		if(StringUtil.isNotEmpty(pageSizeStr)){
			pageNum = Integer.parseInt(pageSizeStr);
		}
		
		//查询总记录
		int totalCount = promotionDao.querypromotionTotalCount(restaurantId);
		
		if(totalCount<1){
			return null;
		}
			
		//查询集合
		List<Promotion> promotionList = promotionDao.queryPromotionByPage(restaurantId ,pageNum,pageSize);
		
		//创建page对象
		Page<Promotion> page = new Page<>(pageNum,pageSize,totalCount);
		
		page.setDatas(promotionList);
		
		
		return page;
	}


	public Promotion queryPromotionById(String promotionId) {
		//非空校验
		if(StringUtil.isEmpty(promotionId)){
			return null;
			
		}
		
		
		Promotion promotion  = promotionDao.queryPromotionById(promotionId); 
				
		return promotion;
		
	}


	public ResultInfo deletePromotion(String restaurantId, String promotionId) {
		ResultInfo resultInfo = new ResultInfo();
		
		//参数判断
		if(StringUtil.isEmpty(restaurantId)){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("餐停ID不能为空");
			return resultInfo ;
		}
		
		if(StringUtil.isEmpty(promotionId)){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("promotionId");
			return resultInfo ;
		}
		
		//查找promotion是否存在
		Promotion promotion = promotionDao.queryPromotionById(promotionId);
		if(promotion == null ){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("数据不存在");
			return resultInfo ;
		}
		
		
		Integer code = promotionDao.deletePromotion(restaurantId,promotionId);
		
		
		if(code != 1){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("删除失败");
			return resultInfo;
		}
		
		resultInfo.setResultCode(1);
		return resultInfo;
	}


	public ResultInfo saveOrUpdatePromtion(String promotionType, String promotionName, String startDate, String endDate,
			String content, String isActive, String restaurantId, String promotionId) {
		ResultInfo resultInfo = new ResultInfo();
		logger.info("在{}saveOrUpdatePromtion中restaurantId"+restaurantId,new SimpleDateFormat("yyyy-MM-dd HH:ss:mm").format(new Date()) );
		if(StringUtil.isEmpty(restaurantId)){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("参数错误");
			return resultInfo;
		}
		
		

		logger.info("promotionType"+promotionType);
		if(StringUtil.isEmpty(promotionType)){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("促销类型不为空");
			return resultInfo;
		}
		
		
		logger.info("promotionName"+promotionName);
		if(StringUtil.isEmpty(promotionName)){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("促销名称不为空");
			return resultInfo;
		}
		
		logger.info("startDate"+startDate);
		if(StringUtil.isEmpty(startDate)){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("活动开始时间不能为空");
			return resultInfo;
		}
		
		
		logger.info("endDate"+endDate);
		if(StringUtil.isEmpty(endDate)){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("活动结束时间不能为空");
			return resultInfo;
		}
		
		logger.info("content"+content);
		if(StringUtil.isEmpty(content)){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("促销内容不能为空");
			return resultInfo;
		}
		
		
		logger.info("isActive"+isActive);
		if(StringUtil.isEmpty(isActive)){
			isActive = "0";
		}
		
		//修改  或 新增
		Integer code = promotionDao.saveOrUpdatePromotion(promotionId, restaurantId,  promotionName,
				 promotionType,  isActive,  startDate,  endDate,  content);

		if(code != 1){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("操作失败！！！！！！！！");
			return resultInfo;
		}
		
		resultInfo.setResultCode(1);
		
		
		return resultInfo;
	}


	public ResultInfo isActive(String restaurantId, String promotionId, String isActive) {
		ResultInfo resultInfo = new ResultInfo();
		
		//参数校验
		if(StringUtil.isEmpty(restaurantId)||StringUtil.isEmpty(promotionId)||StringUtil.isEmpty(isActive)){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("参数异常");
			return resultInfo;
		}
		
		//DAO层实现
		Integer result = promotionDao.isActive(Integer.parseInt(restaurantId),Integer.parseInt(promotionId),Integer.parseInt(isActive)); 
		
		//根据返回值判断并传参数
		if(result != 1){
			resultInfo.setResultCode(0);
			resultInfo.setResultMessage("操作失败,联系管理员");
			return resultInfo;
		
		}
		
		resultInfo.setResultCode(1);
		resultInfo.setResultMessage("success！");
		
		return resultInfo;
	}

}
