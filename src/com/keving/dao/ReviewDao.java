package com.keving.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.keving.model.vo.ReviewVo;
import com.keving.util.DBUtil;

public class ReviewDao {

	public Integer queryTotalReviewByRestaurantId(Integer restaurantId) {
		Integer result = 0 ;
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "select count(reviewId) as totalCount from  review where fkRestaurantId = ? and isValid=1 ";
		
		
		try {
			
			
			ps=conn.prepareStatement(sql);
			
			ps.setInt(1, restaurantId);
			
			rs = ps.executeQuery();
			if(rs.next()){
				result = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DBUtil.close(rs, ps, conn);
		}
		
		return result;
	}

	public List<ReviewVo> queryReviewList(Integer restaurantId, Integer pageNum, Integer pageSize) {
		List<ReviewVo> list = new ArrayList<>();
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "select reviewId,userName,content,isLikeIt,r.createDate as reviewDate from review r LEFT JOIN user u on r.fkUserId = u.userId where r.isValid = 1 and r.fkRestaurantId = ? limit ?,?";
			
		
		try {
			ps=conn.prepareStatement(sql);
			
			ps.setInt(1, restaurantId);
			Integer limit = (pageNum - 1) * pageSize;
			ps.setInt(2, limit);
			ps.setInt(3, pageSize);
			
			rs = ps.executeQuery();

			while(rs.next()){
				ReviewVo review = new ReviewVo();
				review.setContent(rs.getString("content"));
				review.setReviewDate(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(rs.getTimestamp("reviewDate")));
				review.setReviewId(rs.getInt("reviewId"));
				review.setUserName(rs.getString("userName"));
				review.setIsLikeIt(rs.getInt("isLikeIt"));
				list.add(review);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DBUtil.close(rs, ps, conn);
		}
		
		return list;
	}

}
