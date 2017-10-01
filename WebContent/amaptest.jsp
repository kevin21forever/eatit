
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
    <!-- 原始地址：//webapi.amap.com/ui/1.0/ui/misc/PositionPicker/examples/positionPicker.html -->
    <base href="//webapi.amap.com/ui/1.0/ui/misc/PositionPicker/examples/" />
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>拖拽选址</title>
    <style>
    /* html, */
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
    
    #right {
        color: #444;
        background-color: #f8f8f8;
        width: 30%;
        float: left;
        height: 100%;
    }
    
    #start,
    #stop,
    #right input {
        margin: 4px;
        margin-left: 15px;
    }
    
    .title {
        width: 100%;
        background-color: #dadada
    }
    
    button {
        border: solid 1px;
        margin-left: 15px;
        background-color: #dadafa;
    }
    
    .c {
        font-weight: 600;
        padding-left: 15px;
        padding-top: 4px;
    }
    
    #lnglat,
    #address,
    #nearestJunction,
    #nearestRoad,
    #nearestPOI,
    .title {
        padding-left: 15px;
    }
    </style>
</head>


    <div id="mapdiv" class="map" tabindex="0"></div>
    <div id='right'>
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
            <div class='title'>选址结果</div>
            <div class='c'>经纬度:</div>
            <div id='lnglat'></div>
            <div class='c'>地址:</div>
            <div id='address'></div>
            <div class='c'>最近的路口:</div>
            <div id='nearestJunction'></div>
            <div class='c'>最近的路:</div>
            <div id='nearestRoad'></div>
            <div class='c'>最近的POI:</div>
            <div id='nearestPOI'></div>
        </div> 
    </div>
    <script type="text/javascript" src='//webapi.amap.com/maps?v=1.3&key=5a24883e65d127ea6d2a5df6c7d8b2ec&plugin=AMap.ToolBar'></script>
    <!-- UI组件库 1.0 -->
    <script src="//webapi.amap.com/ui/1.0/main.js?v=1.0.10"></script>
    <script type="text/javascript">
    AMapUI.loadUI(['misc/PositionPicker'], function(PositionPicker) {
        var map = new AMap.Map('mapdiv', {
        	center: [121.2450457, 31.0170499],//地图中心点
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
    </script>


</html>