package com.keving.util;

import java.util.List;

import lombok.Data;

@Data	
public class Page<T> {

	private Integer pageNum;//当前页
	private Integer pageSize;//每页记录数
	private Integer total;//总记录数
	private Integer totalPages;// 总页数
	private Integer firstPage;//首页
	private Integer endPage;//末页
	private Integer prePage;//上一页
	private Integer nextPage;//下一页
	private Integer navStartPage;// 导航开始页
	private Integer navEndPage;//导航结束页
	private List<T>  datas;//当前页记录
	
	
	public Page(Integer pageNum, Integer pageSize, Integer total) {
		
		this.pageNum = pageNum;
		this.pageSize = pageSize;
		this.total = total;
		
		this.totalPages = (total+pageSize-1)/pageSize;
		
		//指定首页，尾页
		this.firstPage = 1;
		this.endPage = totalPages;
		
		//上下页
		this.prePage = (pageNum-1)<=0?1:(pageNum-1);
		this.nextPage = (pageNum+1)>totalPages?totalPages:(pageNum+1);
		
		//首尾导航页
		this.navStartPage = pageNum-5;
		this.navEndPage = pageNum+4;
		
		//导航页修正
		if(this.navStartPage<0){
			this.navStartPage = 1;
			this.navEndPage = (this.navStartPage+9)>totalPages?totalPages:(this.navStartPage+9);
		}
		
		if(this.navEndPage>totalPages){
			this.navEndPage = totalPages;
			this.navStartPage = (this.navEndPage-9)<0?1:(this.navEndPage-9);
		}
		
	}
	
	
}
