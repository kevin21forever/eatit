<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
        <ul class="nav pull-right top-menu">
            <!-- user login dropdown start-->
        	

<li class="dropdown" >
    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
        <i class="icon-user"></i>
        <span class="username">${userInfo.resultObject.userName }</span>
        <b class="caret"></b>
    </a>
    <ul class="dropdown-menu extended logout">
        <div class="log-arrow-up"></div>
        <li><a href="userServlet?action=logOut"><i class="icon-key"></i>退出</a></li>
    </ul>
</li>
            <!-- user login dropdown end -->
        </ul>
        

