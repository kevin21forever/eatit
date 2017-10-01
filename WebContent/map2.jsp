<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
    <!-- 原始地址：//webapi.amap.com/ui/1.0/ui/misc/PositionPicker/examples/positionPicker.html -->
    <!--  <base href="//webapi.amap.com/ui/1.0/ui/misc/PositionPicker/examples/" />  -->
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">

    <style>
/*      html,
    body {
        height: 100%;
        margin: 0;
        width: 100%;
        padding: 0;
        overflow: hidden;
        font-size: 13px;
    }
    
    .map {
        height: 100%;
        width: 70%;
        float: left;
    }
 */

     .c {
        font-weight: 600;
        padding-left: 15px;
        padding-top: 0px;
        display:inline-block;
    }

    
	.cc{
		
		display:inline-block;
	}
	.d{
		padding-top: 0px;
		
	}
    

    </style>
</head>
    
    
     <div class="col-lg-7" id="mapmap"   style="height:650px"> 
                      <section class="panel">
                          <header class="panel-heading">
                           		地图Amap
                          </header>
                          <div class="panel-body"> 
                              <div class="bg-ccc" id="mapdiv" style="height:350px;"></div>
                          </div>  
                          
                           <p class="text-center pd-t-10 pd-b-10">如果标注不正确，请直接拖动修改</p>
       <div style="display:none" >
            <div class='title'>选择模式</div>
            <input type='radio' name='mode' value='dragMap' checked>拖拽地图模式</input>
            </br>
            <input type='radio' name='mode' value='dragMarker'>拖拽Marker模式</input>
        </div>
        <div style="display:none">
            <button id='start'>开始选点</button>
            <button id='stop'>关闭选点</button>
        </div>
        <div>
            <div  class='title' style="display:none">选址结果</div>
            <div class ="d">
            <div class='c'>经纬度:</div>
            <div class="cc" id='lnglat'></div>
            </div >
            <div class ="d">
            <div class='c'>地址:</div>
            <div class="cc" id='address'></div>
            </div>
            <div class ="d">
            <div class='c'>最近的路口:</div>
            <div class="cc" id='nearestJunction'></div>
            </div>
            <div class ="d">
            <div class='c'>最近的路:</div>
            <div class="cc" id='nearestRoad'></div>
            </div>
            <div class ="d">
            <div class='c'>最近的POI:</div>
            <div class="cc" id='nearestPOI'></div>
            </div>
        </div> 
                 
  
        </div> 
       

    
  <script  src="http://webapi.amap.com/maps?v=1.3&key=5a24883e65d127ea6d2a5df6c7d8b2ec&plugin=AMap.ToolBar"></script>
  <script  src="statics/js/amap.js"></script>
  <script src="statics/js/restaurant/restaurant.js" type="text/javascript" charset="utf-8"></script>
    

    <!-- UI组件库 1.0 -->
    <script src="//webapi.amap.com/ui/1.0/main.js?v=1.0.10"></script>

    <script type="text/javascript">
/*   
    // 先获取到当前餐厅的地址
    var address =  document.getElementById('address').value;
    AMap.plugin('AMap.Geocoder',function(){
        var geocoder = new AMap.Geocoder({
        	
        });
        
        
     // 通过地址得到经纬度
         geocoder.getLocation(address,function(status,result){
           if(status=='complete' && result.geocodes.length){
             console.log(result.geocodes[0].location);
             var lng = result.geocodes[0].location.lng;
        	 var lat = result.geocodes[0].location.lat;
        	 console.log(lng + "," +lat);
        	 // 调用拖拽事件
        	 getPositionPicker(lng, lat);
           }
         });
         
     
       // 通过经纬度或取到地址
         var lnglatXY=[121.611945, 31.253899];//地图上所标点的坐标
         geocoder.getAddress(lnglatXY, function(status, result) {
             if (status === 'complete' && result.info === 'OK') {
                //获得了有效的地址信息:
                //即，result.regeocode.formattedAddress
            	 console.log(result.regeocode.formattedAddress);
             }else{
                //获取地址失败
             }
         });  

    });
    

/**
 * 地图拖拽事件
 */
/* function getPositionPicker (lng, lat) {
    // 参考的API：http://lbs.amap.com/api/javascript-api/reference-amap-ui/other/positionpicker
    // 拖拽选址Demo:http://lbs.amap.com/api/javascript-api/example/amap-ui-positionpicker/position-picker
    
   //加载PositionPicker，loadUI的路径参数为模块名中 'ui/' 之后的部分
    AMapUI.loadUI(['misc/PositionPicker'], function(PositionPicker) {
        var map = new AMap.Map('container', {
            zoom: 16,
            scrollWheel: false,
            center: [lng,lat]
        });
        
        
        var positionPicker = new PositionPicker({
        	//设定为拖拽地图模式，可选'dragMap'(拖拽地图)、'dragMarker'(拖拽点)，默认为'dragMap'
            mode: 'dragMap',
            map:map //指定地图对象,依赖地图对象
        });

        // 事件绑定、结果处理等
        // 绑定事件处理函数
        // 当拖拽结束后，拖拽选址组件会进行服务查询获得所选位置的地址、周边信息等数据，如果获取成功，将触发success事件，否则将触发fail事件。
        // 创建完拖拽选址组件的对象之后，我们需要为其绑定success和fail事件
        positionPicker.on('success', function(positionResult) {
            document.getElementById('address').value = positionResult.address;
        });
        positionPicker.on('fail', function(positionResult) {
        	// 海上或海外无法获得地址信息
            document.getElementById('address').value = '';
        });
        var onModeChange = function(e) {
            positionPicker.setMode(e.target.value)
        }
        // 开启拖拽选址
        positionPicker.start();
        map.panBy(0, 1);

        map.addControl(new AMap.ToolBar({
            liteStyle: true
        }))
    });
} 
 */
    
 
 
 
 
 
 
 
 
 
 
 
 
 
//先获取到当前餐厅的地址
 var address =  document.getElementById('address1').value;

 AMap.plugin('AMap.Geocoder',function(){
     var geocoder = new AMap.Geocoder({
     	
     });
        
  // 通过地址得到经纬度
      geocoder.getLocation(address,function(status,result){
        if(status=='complete' && result.geocodes.length){
          console.log(result.geocodes[0].location);
          var lng = result.geocodes[0].location.lng;
     	 var lat = result.geocodes[0].location.lat;
     	 console.log(lng + "," +lat);
     	 // 调用拖拽事件
     	 getPositionPicker(lng, lat);
        }
      });
      
  
    // 通过经纬度或取到地址
   /*    var lnglatXY=[121.611945, 31.253899];//地图上所标点的坐标 */
      geocoder.getAddress(lnglatXY, function(status, result) {
          if (status === 'complete' && result.info === 'OK') {
             //获得了有效的地址信息:
             //即，result.regeocode.formattedAddress
         	 console.log(result.regeocode.formattedAddress);
          }else{
             //获取地址失败
          }
      });  

 });
	
	 
function  getPositionPicker(lng, lat){   
    AMapUI.loadUI(['misc/PositionPicker'], function(PositionPicker) {
    	 console.log(lng + "," +lat+"skdgfkshfsdkfhksdfhkshfirgre");

        var map = new AMap.Map('mapdiv', {
        	
        	center: [lng, lat],//地图中心点
            zoom: 16,
            scrollWheel: false
        })
        var positionPicker = new PositionPicker({
            mode: 'dragMap',
            map: map
        });

        positionPicker.on('success', function(positionResult) {
        	document.getElementById('address1').value = positionResult.address;
        	document.getElementById('address').value = positionResult.address;
            document.getElementById('lnglat').innerHTML = positionResult.position;
            document.getElementById('address').innerHTML = positionResult.address;
            document.getElementById('nearestJunction').innerHTML = positionResult.nearestJunction;
            document.getElementById('nearestRoad').innerHTML = positionResult.nearestRoad;
            document.getElementById('nearestPOI').innerHTML = positionResult.nearestPOI;
        });
        
        positionPicker.on('fail', function(positionResult) {
            document.getElementById('lnglat').innerHTML = ' ';
            document.getElementById('address').innerHTML = '1111 ';
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
	
}; 
  </script>