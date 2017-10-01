<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    

<%@include file="header.jsp"%>




    
    <title>优惠促销</title>

        <link rel="stylesheet" type="text/css" href="statics/assets/bootstrap-datepicker/css/datepicker.css" />
        <link rel="stylesheet" type="text/css" href="statics/assets/bootstrap-daterangepicker/daterangepicker.css" />
        <link rel="stylesheet" type="text/css" href="statics/assets/bootstrap-timepicker/compiled/timepicker.css" />
        <link rel="stylesheet" type="text/css" href="statics/assets/bootstrap-datetimepicker/css/datetimepicker.css" />
        <link rel="stylesheet" type="text/css" href="statics/assets/bootstrap-daterangepicker/daterangepicker-bs3.css" />
        <link rel="stylesheet" href="statics/chosen/docsupport/style.css">
        <link rel="stylesheet" href="statics/chosen/docsupport/prism.css">
        <link rel="stylesheet" href="statics/chosen/chosen.css">
        <script type='text/javascript' src='statics/js/spin.min.js'></script>
        <style>
            #mask{
                position: fixed;
                width: 100%;
                height: 100%;
                background: rgba(51,51,51,0.6);
                top: 0;
                right: 0;
                -webkit-user-select: none;
                -webkit-tap-highlight-color: rgba(0,0,0,0);
                z-index: 999;
                display: none;
            }
            #global_mask{
                position: fixed;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,.6);
                z-index: 9999;
                top: 0;
                right: 0;
                -webkit-user-select: none;
                -webkit-tap-highlight-color: rgba(0,0,0,0);
                display: none;
            }
            #global_loading {
                width: 24px;
                height: 24px;
                position:absolute;
            }
            .has-switch {
                border-radius: 30px;
                -webkit-border-radius: 30px;
                display: inline-block;
                cursor: pointer;
                line-height: 1.231;
                overflow: hidden;
                position: relative;
                text-align: left;
                width: 80px;
                -webkit-mask: url('statics/img/mask.png') 0 0 no-repeat;
                mask: url('statics/img/mask.png') 0 0 no-repeat;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                -o-user-select: none;
                user-select: none;
            }
            .has-switch.deactivate {
                opacity: 0.5;
                filter: alpha(opacity=50);
                cursor: default !important;
            }
            .has-switch.deactivate label,
            .has-switch.deactivate span {
                cursor: default !important;
            }
            .has-switch > div {
                width: 162%;
                position: relative;
                top: 0;
            }
            .has-switch > div.switch-animate {
                -webkit-transition: left 0.25s ease-out;
                -moz-transition: left 0.25s ease-out;
                -o-transition: left 0.25s ease-out;
                transition: left 0.25s ease-out;
                -webkit-backface-visibility: hidden;
            }
            .has-switch > div.switch-off {
                left: -63%;
            }
            .has-switch > div.switch-off label {
                background-color: #7f8c9a;
                border-color: #bdc3c7;
                -webkit-box-shadow: -1px 0 0 rgba(255, 255, 255, 0.5);
                -moz-box-shadow: -1px 0 0 rgba(255, 255, 255, 0.5);
                box-shadow: -1px 0 0 rgba(255, 255, 255, 0.5);
            }
            .has-switch > div.switch-on {
                left: 0%;
            }
            .has-switch > div.switch-on label {
                background-color: #41cac0;
            }
            .has-switch input[type=checkbox] {
                display: none;
            }
            .has-switch span {
                cursor: pointer;
                font-size: 14.994px;
                font-weight: 700;
                float: left;
                height: 29px;
                line-height: 19px;
                margin: 0;
                padding-bottom: 6px;
                padding-top: 5px;
                position: relative;
                text-align: center;
                width: 50%;
                z-index: 1;
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                box-sizing: border-box;
                -webkit-transition: 0.25s ease-out;
                -moz-transition: 0.25s ease-out;
                -o-transition: 0.25s ease-out;
                transition: 0.25s ease-out;
                -webkit-backface-visibility: hidden;
            }
            .has-switch span.switch-left {
                border-radius: 30px 0 0 30px;
                background-color: #2A3542;
                color: #41cac0;
                border-left: 1px solid transparent;
            }
            .has-switch span.switch-right {
                border-radius: 0 30px 30px 0;
                background-color: #bdc3c7;
                color: #ffffff;
                text-indent: 7px;
            }
            .has-switch span.switch-right [class*="fui-"] {
                text-indent: 0;
            }
            .has-switch label {
                border: 4px solid #2A3542;
                border-radius: 50%;
                -webkit-border-radius: 50%;
                float: left;
                height: 29px;
                margin: 0 -21px 0 -14px;
                padding: 0;
                position: relative;
                vertical-align: middle;
                width: 29px;
                z-index: 100;
                -webkit-transition: 0.25s ease-out;
                -moz-transition: 0.25s ease-out;
                -o-transition: 0.25s ease-out;
                transition: 0.25s ease-out;
                -webkit-backface-visibility: hidden;
            }
            .switch-square {
                border-radius: 6px;
                -webkit-border-radius: 6px;
                -webkit-mask: url('statics/img/mask.png') 0 0 no-repeat;
                mask: url('statics/img/mask.png') 0 0 no-repeat;
            }
            .switch-square > div.switch-off label {
                border-color: #7f8c9a;
                border-radius: 6px 0 0 6px;
            }
            .switch-square span.switch-left {
                border-radius: 6px 0 0 6px;
            }
            .switch-square span.switch-left [class*="fui-"] {
                text-indent: -10px;
            }
            .switch-square span.switch-right {
                border-radius: 0 6px 6px 0;
            }
            .switch-square span.switch-right [class*="fui-"] {
                text-indent: 5px;
            }
            .switch-square label {
                border-radius: 0 6px 6px 0;
                border-color: #41cac0;
            }
            .line-h-34{
                line-height: 34px;
            }
        </style>
  </head>
  <body>

  <section id="container" >
     

<%@include file="frame.jsp" %>

    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <div class="row">
                <div class="col-lg-12 clearfix">
                    <p class="font30 pull-left">促销 - 创建一个促销活动</p>
                <!--<#include 'include/restaurantlist.ftl'>-->
                </div>
            </div>
              <div class="row">
                  <div class="col-lg-12">
                    <section class="panel">
                        <div class="panel-body">
                               <div class="form-group">
                               <label class="font16 font-bold">促销类型</label>
                               
                               <select id="type" name="type" data-placeholder="选择优惠促销类型..." class="chosen-select-promotionType form-control m-bot15 "  >
							        <option value="" >请选择优惠促销类型</option>
							        <option value="1" >优惠促销</option>
							        <option value="2" >欢乐时光</option>
							        <option value="3" >女士之夜</option>
							        <option value="4" >开怀畅饮</option>
							        <option value="5" >特别活动</option>
							        <option value="6" >精选套餐</option>
		                       </select>   
                               
                          </div>
 <input type="hidden"  id="restaurantId" value="<c:if test="${!empty restaurantInfo && !empty restaurantInfo.restaurantId}">${restaurantInfo.restaurantId }</c:if>" />
                                <div class="form-group">
                                    <label class="font16 font-bold">促销名称</label>
                                    <input type="input" name='promotionName' class="form-control" id="promotionName" placeholder='请输入最具吸引力的标题，如“48元三道菜商务午餐”' />
                                </div>
                                
                                <div class="form-group">
                                    <label class="font16 font-bold">促销开始时间 </label>
                                    <input size="16" type="text"   id="startDate" readonly="" class="form-control" placeholder="选择时间" size="16">
                                </div>
                                <div class="form-group">
                                    <label class="font16 font-bold">促销结束时间 </label>
                                    <input size="16" type="text"   id="endDate"  readonly="" class="form-control" placeholder="选择时间" size="16">
                                </div>


                               <div class="form-group">
								<label class="font16 font-bold">促销内容</label>
								<textarea class="form-control"  onkeyup="calNum()"  style="height:150px;resize:none" name="content" id="content"   rows=4 maxlength="1000"></textarea>
						    	<p class="text-right mg-t-10 mg-b-10">最多可输入1000个字，当前输入字数:<label id="numLabel">0</label></p>
                               </div>
                               
                               <div class="form-group" >
                               	<label class="font16 font-bold">状态</label>
                               	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                               	<input type="checkbox"  data-toggle="switch" />
                             </div>
                             <button type="button"  id="submitButton"  class="btn btn-success">保存</button>
                             &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                             <a href="promotionServlet?action=info&id=${restaurantInfo.restaurantId }">取消</a>
                               
                       </div>
               
                   </section>
                </div>
            </div>

        </section>
    </section>
    <!--main content end-->
    <!--footer start-->
<%@include file="copyright.jsp" %>
    <!--footer end-->
</section>


<%@include file="footer.jsp" %>


<script type="text/javascript" src="statics/assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="statics/assets/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="statics/assets/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
<script type="text/javascript" src="statics/js/restaurant/bootstrap-switch-promotion-advance.js"></script>
<script src="statics/chosen/chosen.jquery.js" type="text/javascript"></script>
<script src="statics/chosen/docsupport/prism.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="statics/js/restaurant/promotion.js"></script>


<script>
$(function(){
	// 初始化下拉框选择器
	initSelector();
	
	// 时间选择器初始化
	$("#startDate").datepicker({
	        format: "yyyy-mm-dd",
	        autoclose: true
    });
    $("#endDate").datepicker({
        format: "yyyy-mm-dd",
        autoclose: true
    });
    
    // checkbox按钮初始化
    $('select.styled').customSelect();
    $("[data-toggle='switch']").wrap('<div class="switch" />').parent().bootstrapSwitch();

});

/**
 * 初始化下拉框选择器
 * @returns
 */
function initSelector() {
	var config = {
	      '.chosen-select-promotionType'           : {max_selected_options: 2}, // 优惠促销类型
	      '.chosen-select-no-results': {no_results_text:'Oops, nothing found!'},
	}
	for (var selector in config) {
	    $(selector).chosen(config[selector]);
	}
}

var isActiveStatus = 0; // 默认是关闭状态

function dealOn(){
	isActiveStatus = 1;
    return true;
}

function dealOff(id,_this){
	isActiveStatus = 0;
    return true;
}



</script>

  </body>
</html>
