<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    

<%@include file="header.jsp" %>


     <title>优惠促销</title>
    
  </head>
  <body>
  <section id="container" >
  
  <%@include file="frame.jsp" %>
  

<%@include file="sidebar.jsp" %>
      <!--main content start-->
      <section id="main-content">
          <div class="wrapper">
              <div class="row">
                  <div class="col-lg-12 clearfix">
                      <p class="font30 pull-left">促销管理</p>
                  </div>
              </div>
                <div class="row">
                  <div class="col-lg-12">
                    <c:if test="${page == null || page.datas == null || page.datas.size() == 0}">
                          <div class="panel pd-t-50 pd-b-40">
                          <div class="row">
                              <div class="col-lg-4">
                                  <img src="statics/img/introduce/index.jpg" class="img-block" />
                              </div>
                              <div class="col-lg-8 c757575">
                                  <p class="font28 font-bold">优惠促销</p>
                                  <p class="lh-2 font16">
						                                       升级版后台商户可选择9种精准优惠类型，<br>
										并同时上线两个优惠促销，<br>
										符合条件时会出现在首页人气热评榜；<br>
										其优惠也将显示在首页【优惠】按钮中，<br>
										当顾客搜索此优惠内容时，<br>
										商户将呈现在搜索列表中，<br>
										增加商户的曝光率和点击率<br><br>
										
										免费版后台商户可选择单种“优惠促销”类型；<br>
										并最多上线一个优惠促销，<br>
										顾客点击进入商户详情页面，<br>
										可以查看到优惠促销的内容。
                                  </p>
                                  <button type="button" onclick="toCreate(<c:if test="${!empty restaurantInfo && !empty restaurantInfo.restaurantId}">${restaurantInfo.restaurantId}</c:if>)" class="btn btn-success mg-b-10">
                                      <a href="#" class="cfff">
                                          <i class="icon-bon-plus"></i>&nbsp;创建促销</a>
                                  </button>
                              </div>
                          </div>
                    </c:if>
                    
                     <c:if test="${page != null && page.datas!= null && page.datas.size() > 0}">
                          <div class="panel">

                                <header class="panel-heading">
                                  <button type="button" onclick="toCreate(<c:if test="${!empty restaurantInfo && !empty restaurantInfo.restaurantId}">${restaurantInfo.restaurantId}</c:if>);" class="btn btn-success mg-b-10">
                                      <a href="#" class="cfff"><i class="icon-bon-plus"></i>&nbsp;创建促销</a>
                                  </button>
                              </header>
                              <input type="hidden"  id="restaurantId" value="<c:if test="${!empty restaurantInfo && !empty restaurantInfo.restaurantId}">${restaurantInfo.restaurantId}</c:if>" />
                              <table class="table table-striped table-advance table-hover">
                              <thead>
                              <tr>
                                  <th>活动名称</th>
                                  <th>活动类型</th>
                                  <th>开始时间</th>
                                  <th>结束时间</th>
                                  <th>活动状态</th>
                                  <th>操作</th>
                              </tr>
                              </thead>
                              <tbody>
                              	<c:forEach items="${page.datas}" var="item">
                                  <tr>
                                      <td>${item.promotionName}</td>
                                      <td>
                                    	 <c:choose>
										    <c:when test="${!empty item.promotionType && item.promotionType == 1 }">
										       	优惠促销
										    </c:when>
										    <c:when test="${!empty item.promotionType && item.promotionType == 2 }">
										       	欢乐时光
										    </c:when>
										    <c:when test="${!empty item.promotionType && item.promotionType == 3 }">
										       	女士之夜
										    </c:when>
										    <c:when test="${!empty item.promotionType && item.promotionType == 4 }">
										       	开怀畅饮
										    </c:when>
										    <c:when test="${!empty item.promotionType && item.promotionType == 5 }">
										       	特别活动
										    </c:when>
										    <c:when test="${!empty item.promotionType && item.promotionType == 6 }">
										       	精选套餐
										    </c:when>
										</c:choose>                                   
                                      </td>
                                      <td>${item.startDate}</td>
                                      <td>${item.endDate}</td>
                                      <td>
                                          <div class="make-switch switch-small" promotion-id="${item.promotionId}"  id="mySwitch${item.promotionId}" >
                                              <input type="checkbox" <c:if test="${item.isActive != null && item.isActive == 1 }"> checked </c:if>  >
                                          </div>
                                      </td>
                                      <td>
                                          <button class="btn btn-success btn-xs" onclick="toUpdate(${restaurantInfo.restaurantId},${item.promotionId})"><i class="icon-bon-pencil"></i></button>
                                            &nbsp; &nbsp; &nbsp;
                                          <button onclick="deletePromotion(${item.promotionId},${restaurantInfo.restaurantId},this,'${item.promotionName}')"  class="btn btn-danger btn-xs"><i class="icon-bon-bin "></i></button>
                                      </td>
                                  </tr>
                                </c:forEach>
                              </tbody>
                          </table>
                          </c:if>
                          
                   <c:if test="${page != null }"> 
	                <ul class="pagination pagination-lg">
	                	<c:if test="${page.pageNum==page.totalPages}">
		                    <li>
		                    	<a href="promotionServlet?action=info&id=${restaurantId }&pageNum=1" class="active">首页</a>
		                    </li>
	                    </c:if>
	                    <c:if test="${page.pageNum!=1 && page.pageNum>1}">
		                    <li>
		                        <a href="promotionServlet?action=info&id=${restaurantId }&pageNum=${page.pageNum-1}">上一页</a>
		                    </li>
	                    </c:if>
	                    <c:forEach begin="${page.navStartPage}" end="${page.navEndPage}" var="p">
		                    <li <c:if test="${page.pageNum==p }">class="active"</c:if>>
		                    	<a href="promotionServlet?action=info&id=${restaurantId }&pageNum=${p}">${p }</a>
		                    </li>
	                    </c:forEach>
	                    <c:if test="${page.pageNum<page.totalPages && page.pageNum>1 }">
		                    <li>
		                    	<a href="promotionServlet?action=info&id=${restaurantId }&pageNum=${page.pageNum+1}">下一页</a>
		                    </li>
	                    </c:if>
	                    <c:if test="${page.pageNum==1}">
		                    <li>
		                        <a href="promotionServlet?action=info&id=${restaurantId }&pageNum=${page.totalPages}" class="active">末页</a>
		                    </li>
	                    </c:if>
	                </ul>
                </c:if>
                      </div>
                  </div>
              </div>
          </section>
      </section>
      <!--main content end-->
      <!--footer start-->
  
<%@include file="copyright.jsp" %>
  </section>

  

<%@include file="footer.jsp" %>


<script type="text/javascript" src="statics/js/restaurant/bootstrap-switch-promotion.js"></script>
<script type="text/javascript" src="statics/js/restaurant/promotion.js"></script>



  </body>
