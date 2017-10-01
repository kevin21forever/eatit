<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<base href="http://localhost:8080/eatit/">
    <title>登录</title>
    <link rel="shortcut icon" href="statics/img/favicon.png">
	

<%@include file="header.jsp" %>
    <style>
        html,body{
            width: 100%;
            height: 100%;
        }
    </style>
</head>

<body class="login-body">

   <div class="container">
     <div class="form-signin" >
         <img src="statics/img/logo.png" class="form-bonapp-logo">
         <h2 class="form-signin-heading">立刻登录</h2>
         <div class="login-wrap">
             <input type="text" class="form-control" placeholder="用户邮箱" id="email" value="lisa@stark.com">
             <input type="password" class="form-control" placeholder="用户密码" id="password" value="123456">
              <label class="checkbox">
                <input type="checkbox" id="isRememberPwd" style="margin-left: 0;position: relative;cursor: pointer" name="isRemenmberPwd">&nbsp;记住密码
            </label>
             <button class="btn btn-success btn-block"  id="submitBtn">登录</button>
            <!--  <input type="submit" class="btn btn-success btn-block"  value="登录"/> -->
         </div>
     </div>
   </div>



<%@include file="footer.jsp" %>

<%@include file="copyright.jsp" %>
<script type="text/javascript" src="statics/js/restaurant/login.js"></script>    
 
</body>
</html>