<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String action = request.getParameter("action");
  	// 从作用域中获取到转发前的url
    String currentPageUrl = request.getAttribute("currentPageUrl").toString();
    String currentURL = currentPageUrl + "?id=";
    
%>    
    
    
<div class="btn-group pull-right">
    <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
        <i class="icon-tint cfff"></i>
        
         <c:if test="${menu_page != 'USER_PAGE'}"> 
        <span class="hidden-phone cfff pd-l-5 font16">
    
        	
		<c:if test="${restaurantInfo != null && restaurantInfo.resultObject != null }">${restaurantInfo.resultObject.restaurantName}</c:if>	
			
        </span>
       
        <span class="caret"></span>
        
         </c:if>
    </a>
        <ul class="dropdown-menu" >
        <c:if test="${menu_page != 'USER_PAGE'}"> 
    	<c:if test="${restaurantInfo != null && restaurantInfo.resultList != null }">
    		<c:forEach items="${restaurantInfo.resultList }" var= "item">
    			<li>
	                <a href="<%=currentURL %>${item.restaurantId}">
	                <i class="icon-blank"></i>
	              		 ${item.restaurantName}
	                </a>
	            </li>
    		</c:forEach>
    	</c:if>
    </c:if>
    </ul>
    
</div> 

<script type="text/javascript">
/**
 * 获取地址栏的参数
 */
function UrlSearch() {
   var name,value; 
   var str = location.href; //取得整个地址栏
   var num = str.indexOf("?"); // 得到"?"所在的位置
   str = str.substr(num + 1); // 取得所有参数   stringvar.substr(start [, length ]

   var arr = str.split("&"); //通过"&"分割各个参数放到数组里
   for(var i = 0;i < arr.length; i++){ 
	    num = arr[i].indexOf("="); // 得到"="所在位置
	    if(num > 0){ 
		     name = arr[i].substring(0,num); // 参数名,从开始到"="的所在位置,不包含"=
		     value = arr[i].substr(num + 1); // 参数值,从"="的所在位置到最后,不包含"="
		     this[name] = value;
	    } 
    } 
} 
var path = window.location.pathname;
var Request = new UrlSearch(); //实例化
var id = Request.id;
var url = path + "?action=info&id=" + id;
</script>