<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>

<link rel="stylesheet" href="statics/chosen/docsupport/style.css">
      <link rel="stylesheet" href="statics/chosen/docsupport/prism.css">
      <link rel="stylesheet" href="statics/chosen/chosen.css">


<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<meta name="keyword" content="">
<!-- <link rel="shortcut icon" href="statics/img/favicon.png"> -->


<!-- Bootstrap core CSS -->
<link href="statics/css/bootstrap.min.3.css" rel="stylesheet">
<link href="statics/css/bootstrap-reset.css" rel="stylesheet">
<!--external css-->
<!--<link href="/assets/font-awesomestatics/css/font-awesome.css" rel="stylesheet" />-->
<link href="statics/assets/font-customer/style.css" rel="stylesheet" />

<link href="statics/css/toastr.css" rel="stylesheet"/>

<!-- Custom styles for this template -->
<link href="statics/css/style.css" rel="stylesheet">
<link href="statics/css/style-responsive.css" rel="stylesheet" />



<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">



<title>餐厅详情</title>
    <style type="text/css" media="all">
        /* fix rtl for demo */
       .chosen-rtl .chosen-drop { left: -9000px; }
    </style>
<%@include file="header.jsp" %>

<%@include file="frame.jsp"%>










<body>


<section id="container">

       <!--main content start-->
      <section id="main-content">
          <section class="wrapper">
             <div class="row">
                <div class="col-lg-12 clearfix">
                 <!-- <#include 'include/restaurantlist.ftl'>-->
                </div>
              </div>
              <!-- page start-->

              <div class="row">
                  <div class="col-lg-5">
                      <section class="panel">
                          <header class="panel-heading">
                              	基本信息
                          </header>
                          <div class="panel-body"> 
                              <input type="hidden" id="restaurantId" value="<c:if test='${!empty restaurant && !empty restaurant.restaurantId}'>${restaurant.restaurantId}</c:if>" />
<!--                               <input type="hidden" id="resultCode" value="200" />
                              <input type="hidden" id="resultMessage" value="" />     --> 
                             <div class="form-group">
                                  <label for="">名称</label>
                                  <input type="text" class="form-control" id="restaurantName" placeholder="餐厅名称"  maxlength="50" 
                                  value="<c:if test='${!empty restaurant && !empty restaurant.restaurantName}'>${restaurant.restaurantName}</c:if>">
                              </div>
                                 
                              <div class="form-group mylocation" >
                                  <label for="">地址</label>
                                  <input type="text" class="form-control" id="address1" placeholder="餐厅地址"  maxlength="100"  
                                  value="<c:if test='${!empty restaurant && !empty restaurant.address}'>${restaurant.address}</c:if>">
                              </div>
                              <div class="form-group">
                                      <label for="">菜系</label>
                                      <select data-placeholder="选择菜系..." class="chosen-select-cuisine form-control m-bot15 "  >
                                             <c:choose>
											    <c:when test="${!empty restaurant &&  !empty restaurant.cuisine}">
											        <option value="湘菜" <c:if test='${"湘菜" == restaurant.cuisine}'>selected</c:if> >湘菜</option>
		                                            <option value="川菜" <c:if test='${"川菜" == restaurant.cuisine}'>selected</c:if> >川菜</option>
		                                            <option value="本帮菜" <c:if test='${"本帮菜" == restaurant.cuisine}'>selected</c:if> >本帮菜</option>
		                                            <option value="徽菜" <c:if test='${"徽菜" == restaurant.cuisine}'>selected</c:if> >徽菜</option>
											    </c:when>
											    <c:otherwise>
											        <option value="湘菜" >湘菜</option>
		                                            <option value="川菜" >川菜</option>
		                                            <option value="本帮菜" >本帮菜</option>
		                                            <option value="徽菜" >徽菜</option>
											    </c:otherwise>
											</c:choose>
                                      </select>
                              </div>

                              <div class="form-group">
                                  <label for="">人均价格</label>
                                  <select data-placeholder="选择人均价格..." class="chosen-select-avgPrice form-control m-bot15 "  >
   										<c:choose>
										    <c:when test="${!empty restaurant && !empty restaurant.avgPrice}">
										        <option value="¥" <c:if test='${"¥" == restaurant.avgPrice}'>selected</c:if> >0 ~ ¥100</option>
	                                            <option value="¥¥" <c:if test='${"¥¥" == restaurant.avgPrice}'>selected</c:if> >¥100 ~ ¥200</option>
	                                            <option value="¥¥¥" <c:if test='${"¥¥¥" == restaurant.avgPrice}'>selected</c:if> >¥200 ~ ¥300</option>
	                                            <option value="¥¥¥¥" <c:if test='${"¥¥¥¥" == restaurant.avgPrice}'>selected</c:if> >¥300以上</option>
										    </c:when>
										    <c:otherwise>
										        <option value="¥" >0 ~ ¥100</option>
	                                            <option value="¥¥" >¥100 ~ ¥200</option>
	                                            <option value="¥¥¥" >¥200 ~ ¥300</option>
	                                            <option value="¥¥¥¥" >¥300以上</option>
										    </c:otherwise>
										</c:choose>
                                  </select>
                              </div>
                                  <div class="form-group">
                                      <label for="">电话</label>
                                      <input type="tel" class="form-control" id="telephone" placeholder="" maxlength="20" value="<c:if test='${!empty restaurant && !empty restaurant.telephone}'>${restaurant.telephone }</c:if>">
                                  </div>
                                  <div class="form-group">
                                      <label for="">网站</label>
                                      <input type="text" class="form-control" id="website" placeholder="" maxlength="80" value="<c:if test='${!empty restaurant && !empty restaurant.website}'>${restaurant.website }</c:if>">
                                  </div>
                              <div class="form-group">
                                  <label for="" class="block" >便利设施</label>
        						 <c:choose>
									    <c:when test="${!empty restaurant &&  !empty restaurant.isHasWiFi && restaurant.isHasWiFi == 1}">
									    	<input type="checkbox" id="isHasWiFi" checked>&nbsp;&nbsp;WiFi
									    </c:when>
									    <c:otherwise>
									    	<input type="checkbox" id="isHasWiFi" >&nbsp;&nbsp;WiFi
									    </c:otherwise>
								  </c:choose>
								  <c:choose>
									    <c:when test="${!empty restaurant &&  !empty restaurant.isHasSeat && restaurant.isHasSeat == 1}">
									    	<input type="checkbox" id="isHasSeat" checked>&nbsp;&nbsp;室外有座
									    </c:when>
									    <c:otherwise>
									    	<input type="checkbox" id="isHasSeat" >&nbsp;&nbsp;室外有座
									    </c:otherwise>
								  </c:choose>						  
                              </div>
                              
                              <button id="submitBtn" type="button" class="btn btn-success" >保存</button>
                      </section>
                  </div>
                  
                  
 <%--    <%@include file="map.jsp" %>     拖动功能   滚动条放大缩小    --%>
 <%--    map2   显示经纬度等信息 --%>  
 
               <%@include file="map2.jsp"    %> 
               
         <%--           <%@include file="map3.jsp" %>          lisa的 功能好，但是页面显示有问题    --%>
                  
           
              </div>

              <!-- page end-->
          </section>
      </section>
      <!--main content end-->
    
    
    <!--footer start-->

<%@include file="copyright.jsp" %>
    <!--footer end-->
</section>



<%@include file="footer.jsp" %>

 <script src="statics/chosen/chosen.jquery.js" type="text/javascript"></script>
  <script src="statics/chosen/docsupport/prism.js" type="text/javascript" charset="utf-8"></script>

  <script src="statics/js/restaurant/restaurant.js" type="text/javascript" charset="utf-8"></script>


  
  <script type="text/javascript">
  var longitude = 121.2418457;
  var latitude = 31.0191499;
  // 得到当前位置坐标
  if(navigator.geolocation) {
	    navigator.geolocation.getCurrentPosition(
	        function (position) {  
	            longitude = position.coords.longitude;  
	            latitude = position.coords.latitude;  
	            console.log(longitude)
	            console.log(latitude)
	            },
	            function (e) {
	             var msg = e.code;
	             var dd = e.message;
	             console.log(msg)
	             console.log(dd)
	        }
	      ) 
	}
  
 /*  // 初始化地图
  var map = mapInit("mapdiv");
  // 地图撒点
  addmarker(latitude, longitude, null, map);
  map.setFitView();
  
 */

  
  </script>
  
  </body>
</html>