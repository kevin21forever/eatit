<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 
 
 
 <!--header start-->
<header class="header">
    <div class="sidebar-toggle-box">
        <div data-original-title="切换导航" data-placement="right" class="icon-bon-paragraph-justify tooltips font24" id="mobileMenu"></div>
    </div>
    <!--logo start-->
    	<a class="logo"><span class="icon-bon-logo font36"></span></a>
    <!--logo end-->

    <style>
        .new-pro {
            background-color: #04cce5;
            transform: skew(-20deg);
            height: 90px;
            width: 300px;
            margin: -25px 0 0 44px;
            padding: 10px 5px;
            box-sizing: border-box;
            box-shadow: 0 0 1px 3px rgba(0,0,0,.2) inset;
            cursor: pointer;
        }

        .new-pro-text{
            transform: skew(20deg);
        }
        .npt-line{
            border-right: 2px solid #fff;
            height: 70px;
        }
    </style>

    <div class="top-nav ">
        <!--message info-->
        <ul class="nav pull-left top-menu notify-row">
           <!-- <#include 'include/systemMsg.ftl'> -->
        </ul>
        <!--search & user info start-->

<%@include file="loginout.jsp" %>



<%@include file="restaurantlist.jsp" %>




        <!--search & user info end-->
    </div>
</header>
<!--header end-->   
    
<%@include file="sidebar.jsp" %>  