<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>>
<html>



<%@include file="header.jsp" %>

<%@include file="frame.jsp"%>









<head>

    <title>首页</title>
</head>
<body>
<section id="container">

    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <div class="row">
                <div class="col-lg-12 clearfix">
                    <p class="pull-left font30"><c:if test="${restaurantInfo != null && restaurantInfo.resultObject != null}">${restaurantInfo.resultObject.restaurantName }</c:if></p>
                </div>
            </div>
            <div class="row state-overview">
                <div class="col-lg-2 col-sm-4">
                    <section class="text-center">
                        <div class="easy-pie-chart percentage" style="padding-top: 34px;" data-percent="80%" data-size="130">
                            <p class="p">好评率</p>
                            <span class="h percent">80</span>
                        </div>

                        <h5 class="data-circle-status">
                              <p class="up">+5%<span class="icon-bon-arrow-up2"></span></p>
                        </h5>
                        <h5 class="data-circle-compare">上次登录：75%</h5>
                    </section>
                </div>
                <div class="col-lg-2 col-sm-4">
                    <section class="text-center">

                        <div class="data-circle">
                            <p class="p">投票数</p>
                            <p class="count2 h">
                            109
                            </p>
                        </div>

                        <h5 class="data-circle-status">
                                <p class="up">+ 5<span class="icon-bon-arrow-up2"></span></p>
                                
                        </h5>
                        <h5 class="data-circle-compare">上次登录：104</h5>
                    </section>
                </div>
                
                <div class="col-lg-2 col-sm-4">
                    <section class="text-center">

                        <div class="data-circle">
                            <p class="p">评论数</p>
                            <p class="count3 h">
                            345
                            </p>
                        </div>

                        <h5 class="data-circle-status">
                                <p class="up">+ 10<span class="icon-bon-arrow-up2"></span></p>
                        </h5>
                        <h5 class="data-circle-compare">上次登录：340</h5>
                    </section>
                </div>
                
                <div class="col-lg-2 col-sm-4">
                    <section class="text-center">

                        <div class="data-circle">
                            <p class="p">最爱数</p>
                            <p class="count4 h">
                            12
                            </p>
                        </div>

                        <h5 class="data-circle-status">
                                <p class="up">+ 2<span class="icon-bon-arrow-up2"></span></p>
                        </h5>
                        <h5 class="data-circle-compare">上次登录：10</h5>
                    </section>
                </div>
                
                <div class="col-lg-2 col-sm-4">
                    <section class="text-center">

                        <div class="data-circle">
                            <p class="p">心愿单</p>
                            <p class="count5 h">
                            168
                            </p>
                        </div>

                        <h5 class="data-circle-status">
                               <p class="down">- 3<span class="icon-bon-arrow-down2"></span></p>
                        </h5>
                        <h5 class="data-circle-compare">上次登录：165</h5>
                    </section>
                </div>
                
             
            </div>
            <div class="row pd-t-20">
                <!-- 浏览量排行榜图表 -->
                <div class="col-lg-6">
                    <div class="panel radar-border">
                        <p class="font18 text-center pd-t-15 pd-b-20">流量排行榜</p>
                        <div id="pageViewRank" class="page-view-rank-wrap">
                            <div class="page-view-rank">
                                <span class="icon-bon-arrow-right2 current-range font18" id="currentRange"></span>
                                <span class="pvr-range-t font18">100%</span>
                                <span class="pvr-range-b font18">0%</span>
                            </div>
                            <p class="page-view-text font16" id="pageViewText">今日浏览量超过了80%的商家</p>
                        </div>
                    </div>
                </div>
                <!-- 雷达图 -->
                <div class="col-lg-6">
                    <div class="panel radar-border">
                        <div id="myRadar"></div>
                    </div>
                </div>
            </div>

        <!--促销收益跟踪-->
            <div class="row">
                <div class="col-lg-12 clearfix">
                    <section class="panel">
                        <table class="table table-striped table-advance table-hover">
                            <thead>
                            <tr>
                                <th colspan="6" class="font18">优惠促销</th>
                            </tr>
                            </thead>
                       
                            <tr class="text-center">
                                <td>1</td>
                                <td><img  src="http://image.indulgesmart.com/icon/generic-promo.png" style="width:20px;height:20px;"  /></td>
                                <td>优惠促销</td>
                                <td><button class="btn btn-success btn-xs" onclick="createPromo()">创建优惠</button></td>
                                <td><button class="btn btn-success" data-toggle="modal" data-target=".how-to-improve-pro">如何提高</button></td>
                            </tr>
                      
                        </table>
                    </section>
                </div>
            </div>

            <!-- 最新评论 -->
            <!--state overview end-->
          
            </div>
        </section>
    </section>
    <!--main content end-->
    
    
    <!--footer start-->

<%@include file="copyright.jsp" %>
    <!--footer end-->
</section>



<%@include file="footer.jsp" %>



<script src="statics/js/count.js"></script>
<script src="statics/js/is/reviewresponse.js?v="></script>
<script src="statics/js/jqueryeasypiechart/jquery.easypiechart.js"></script>
<script src="statics/js/highCharts/highcharts.js"></script>
<script src="statics/js/highCharts/highcharts-more.js"></script>
<script src="statics/js/highCharts/exporting.js"></script>

<script lang="javascript" type="text/javascript">
 $(document).ready(function () {

     //好评率
     var barColor = '#00D1E7';
     var trackColor = '#fff';
     var size = 100;
     $('.percentage').easyPieChart({
         barColor: barColor,
         trackColor: trackColor,
         scaleColor: false,
         lineCap: 'butt',
         lineWidth: 6,
         size: size
     });
     
     countUp2(109);
     countUp3(345);
     countUp4(12);
     countUp5(168);
     countUp(80);
     
     // 浏览量排行榜图表
     $('#pageViewText').css('top',(20)+'%')
     $('#currentRange').css('top',(20)+'%')
     $('#currentRangeData').html(20)
     
     
     //雷达图
     var mydata = []; // 数据表的数据集合
     // 添加到数组
     mydata.push(80);
     mydata.push(45);
     mydata.push(64);
     mydata.push(87);
     mydata.push(76);


     $('#myRadar').highcharts({
         credits: {
             enabled:false // 禁用版权信息
         },
         exporting: {
             enabled:false //禁用打印按钮
         },
         chart: {
             polar: true,
             type: 'line'
         },
         title: {
             text: '本商户关键指标诊断图(%)',
             x: 0,
             y:20
         },
         pane: {
             size: '90%'
         },
         xAxis: {
             categories: ['好评率', '投票数', '评论数' ,'心愿单', '最爱数'],
             tickmarkPlacement: 'off',
             lineWidth: 0
         },
         yAxis: {
             gridLineInterpolation: 'polygon',
             lineWidth: 0,
             max:100, // 定义Y轴 最大值
             min:0,// 定义最小值
             tickInterval:25, // 刻度值
//             title: {
//                 text: '%'
//             },
//             enabled: false
         },
         tooltip: {
             enabled:false
//             shared: true,
//             pointFormat: '<span style="color:{series.color}">{series.name}: <b>{point.y}</b><br/>'
         },
         legend: {
             enabled: false
         },
         series: [{
             name: ' ',
             data: mydata,
             pointPlacement: 'on'
         }]
     });
     
     
 });   
</script>
</body>
</html>