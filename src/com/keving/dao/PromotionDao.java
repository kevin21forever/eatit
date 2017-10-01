package com.keving.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.keving.model.Promotion;
import com.keving.util.DBUtil;
import com.keving.util.StringUtil;

public class PromotionDao {
	
	Logger logger = LoggerFactory.getLogger(PromotionDao.class);

	//根据餐厅id  查询促销记录数
	public int querypromotionTotalCount(Integer restaurantId) {
		int totalCount = 0 ;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		
		try {
		String sql = "select count(promotionId) as totalCount from promotion where isValid = 1 and fkRestaurantId = ?";
		logger.info("sql;;;;"+sql);
		    conn = DBUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, restaurantId);
			rs = ps.executeQuery();
			
			while(rs.next()){
				totalCount  = rs.getInt(1);
				logger.info("得到餐停促销的总记录数totalcount    "+totalCount);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DBUtil.close(rs, ps, conn);
		}
		return totalCount;
	}
	

	
	public List<Promotion> queryPromotionByPage(Integer restaurantId ,Integer pageNum,Integer pageSize){
		List<Promotion> promotionList= new ArrayList<>();
		Connection conn = null ;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DBUtil.getConnection();
			String sql = "select * from promotion where isValid =1 and fkRestaurantId = ? limit ?,? ";
			logger.info("sql    "+sql);
			ps = conn.prepareStatement(sql);
			ps.setInt(1, restaurantId);
			Integer num = (pageNum-1)*pageSize;
			ps.setInt(2, num);
			ps.setInt(3, pageSize);
			
			rs = ps.executeQuery();
			
			while(rs.next()){
				Promotion promotion = new Promotion();
				promotion.setContent(rs.getString("content"));
				promotion.setCreateDate(rs.getDate("createDate"));
				promotion.setEndDate(rs.getDate("endDate"));
				promotion.setFkRestaurantId(rs.getInt("fkRestaurantId"));
				promotion.setIsValid(rs.getInt("isValid"));
				promotion.setPromotionId(rs.getInt("promotionId"));
				promotion.setPromotionName(rs.getString("promotionName"));
				promotion.setPromotionType(rs.getInt("promotionType"));
				promotion.setStartDate(rs.getDate("startDate"));
				promotion.setUpdateDate(rs.getDate("updateDate"));
				promotion.setIsActive(rs.getInt("isActive"));
				logger.info("在 {} queryPromotionByPage     "+promotion,new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
				promotionList.add(promotion);
			
			}

			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DBUtil.close(rs, ps, conn);
		}
		
		return promotionList ;
		
		
	
		
		
	
		
	}


	//通过promotionId 查询促销对象
	public Promotion queryPromotionById(String promotionId) {
		Promotion promotion =  null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select * from promotion where isValid = 1 and promotionId =? ";
		logger.info("sql queryPromotionById "+sql );
		
		try {
			conn = DBUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(promotionId));
			rs = ps.executeQuery();
			while(rs.next()){
				promotion = new Promotion();
				promotion.setPromotionId(rs.getInt("promotionId"));
				promotion.setContent(rs.getString("content"));
				promotion.setEndDate(rs.getDate("endDate"));
				promotion.setFkRestaurantId(rs.getInt("fkRestaurantId"));
				promotion.setIsActive(rs.getInt("isActive"));
				promotion.setIsValid(rs.getInt("isValid"));
				promotion.setPromotionName(rs.getString("promotionName"));
				promotion.setPromotionType(rs.getInt("promotionType"));
				promotion.setStartDate(rs.getDate("startDate"));
				
				logger.info("queryPromotionById   promotion  "+promotion);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.close(rs, ps, conn);
		}

		
		return promotion;
		
	}



	public Integer deletePromotion(String restaurantId, String promotionId) {
		Integer code = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		
		try {
			conn = DBUtil.getConnection();
			String sql = "update promotion set isValid = 0 ,updateDate = now() where fkRestaurantId = ? and promotionId =? ";        
			logger.info("deletePromotion   sql "+sql);
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(restaurantId));
			ps.setInt(2, Integer.parseInt(promotionId));
			
			
			int num = ps.executeUpdate();
			
			if(num>0){
				code = 1;
				
				logger.info("deletePromotion    查询结果  "+num+"==========="+code);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(null, ps, conn);
		}
		
		return code;
	}



	public Integer saveOrUpdatePromotion(String promotionId, String restaurantId, String promotionName,
			String promotionType, String isActive, String startDate, String endDate, String content) {
		Integer code = 0;
		Connection conn = null;
		PreparedStatement ps  = null;
	
		
		try {
			conn = DBUtil.getConnection();
			String sql ="";
			if(StringUtil.isEmpty(promotionId)){//新增
				sql = "insert into promotion(promotionName,fkRestaurantId,promotionType,startDate,endDate,content,isActive,createDate,updateDate,isValid) values (?,?,?,?,?,?,?,now(),now(),1)";
			}else{//修改
				sql = "update promotion set fkRestaurantId = ?, promotionName = ?,"
						+ " promotionType = ?, isActive =?, startDate = ?, endDate = ?,"
						+ " content = ?, updateDate = now() where promotionId = ?";
			}
			
			logger.info("saveorupdate    sql : "+sql);
			
			ps = conn.prepareStatement(sql);
			
			
			
			if (StringUtil.isEmpty(promotionId)) { // 添加
				ps.setString(1, promotionName);
				ps.setInt(2, Integer.parseInt(restaurantId));
				ps.setInt(3, Integer.parseInt(promotionType));
				ps.setString(4, startDate);
				ps.setString(5, endDate);
				ps.setString(6, content);
				ps.setInt(7, Integer.parseInt(isActive));
			} else { // 修改
				ps.setInt(1, Integer.parseInt(restaurantId));
				ps.setString(2, promotionName);
				ps.setInt(3, Integer.parseInt(promotionType));
				ps.setInt(4, Integer.parseInt(isActive));
				ps.setString(5, startDate);
				ps.setString(6, endDate);
				ps.setString(7, content);
				ps.setInt(8, Integer.parseInt(promotionId));
			}
			
			int num  = ps.executeUpdate();
			logger.info("saveorupdate   返回的结果：   "+num);
			
			if(num>0){
				code = 1;
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.close(null, ps, conn);
		}
		
		return code;
	}



	public Integer isActive(int restaurantId, int promotionId, int isActive) {
		Integer result = 0 ;
		Connection conn = null;
		PreparedStatement ps =null ;
		
		
		try {
			conn = DBUtil.getConnection();
			String sql = "update promotion set isActive = ? where isValid = 1 and  fkRestaurantId = ? and promotionId = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(2, restaurantId);
			ps.setInt(3, promotionId);
			ps.setInt(1, isActive);
			
			int num = ps.executeUpdate();
			
			if(num>0){
				result = 1 ;
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(null, ps, conn);
		}
		
		return result;
	}
	
	
	
	
	

}
