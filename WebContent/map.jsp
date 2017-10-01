<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    
     <div class="col-lg-7" id="mapmap">
                      <section class="panel">
                          <header class="panel-heading">
                           		地图Amap
                          </header>
                          <div class="panel-body">
                              <div class="bg-ccc" id="mapdiv" style="height:350px;"></div>
                           
                          <p class="text-center pd-t-10 pd-b-10">如果标注不正确，请直接拖动修改</p>
                          </div>
          

    
  <script src="http://webapi.amap.com/maps?v=1.3&key=5a24883e65d127ea6d2a5df6c7d8b2ec"></script>
  <script  src="statics/js/amap.js"></script>
  <script src="statics/js/restaurant/restaurant.js" type="text/javascript" charset="utf-8"></script>
    
   <!--引入UI组件库（1.0版本） -->
<script src="//webapi.amap.com/ui/1.0/main.js"></script> 
    <script type="text/javascript">
    var longitude = 121.2450457; 
    var latitude = 31.0170499;
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
    
    // 初始化地图
    var map = mapInit("mapdiv");
    // 地图撒点
    addmarker(latitude, longitude, null, map);

    map.setFitView();
    
    
    
    
    
    
    
    
    
   /*   AMapUI.loadUI(['misc/PositionPicker'], function(PositionPicker) {
        var map = new AMap.Map('mapdiv', {
        	resizeEnable: true,
        	center: [longitude, latitude],
            zoom: 16,
            scrollWheel: false
        })
        var positionPicker = new PositionPicker({
            mode: 'dragMap',
            map: map
        });

        positionPicker.on('success', function(positionResult) {
            document.getElementById('lnglat').innerHTML = positionResult.position;
            document.getElementById('address').innerHTML = positionResult.address;
            document.getElementById('nearestJunction').innerHTML = positionResult.nearestJunction;
            document.getElementById('nearestRoad').innerHTML = positionResult.nearestRoad;
            document.getElementById('nearestPOI').innerHTML = positionResult.nearestPOI;
        });
        positionPicker.on('fail', function(positionResult) {
            document.getElementById('lnglat').innerHTML = ' ';
            document.getElementById('address').innerHTML = ' ';
            document.getElementById('nearestJunction').innerHTML = ' ';
            document.getElementById('nearestRoad').innerHTML = ' ';
            document.getElementById('nearestPOI').innerHTML = ' ';
        });
        var onModeChange = function(e) {
            positionPicker.setMode(e.target.value)
        }
        var startButton = document.getElementById('start');
        var stopButton = document.getElementById('stop');
        var dragMapMode = document.getElementsByName('mode')[0];
        var dragMarkerMode = document.getElementsByName('mode')[1];
        AMap.event.addDomListener(startButton, 'click', function() {
            positionPicker.start(map.getBounds().getSouthWest())
        })
        AMap.event.addDomListener(stopButton, 'click', function() {
            positionPicker.stop();
        })
        AMap.event.addDomListener(dragMapMode, 'change', onModeChange)
        AMap.event.addDomListener(dragMarkerMode, 'change', onModeChange);
        positionPicker.start();
        map.panBy(0, 1);

        map.addControl(new AMap.ToolBar({
            liteStyle: true
        }))
    });

    
    
    
    
 */

 
  


  
  </script>