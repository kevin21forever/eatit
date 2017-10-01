//基本地图加载

function mapInit(objId) {
    var mapObj = new AMap.Map(objId, {
        view: new AMap.View2D({
            rotation:0
        }),

        lang: "zh_en"
    });
    mapObj.clearMap();
    mapObj.plugin(["AMap.ToolBar"],function(){   
        //加载工具条
        var tool = new AMap.ToolBar({
        	offset:new AMap.Pixel(10,20)
        });
        //tool.hideRuler();
        mapObj.addControl(tool);   
    });
    return mapObj;
}

/**
 * 添加marker&infowindow
 * @param lngX 纬度
 * @param latY 经度
 * @param content infowindow的内容
 * @param mapObj 地图对象
 */
var mar = null;
var marker = new Array();
var windowsArr = new Array();
var dragEnd ;
function addmarker(lngX, latY, content, mapObj) {
    var markerOption = {
        map: mapObj,
        position:new AMap.LngLat(latY, lngX),
        draggable:true

        //content:'<div class="map-maker"></div>'
    };
    mar = new AMap.Marker(markerOption);
    dragEnd = function(e) {
        var position = mar.getPosition();
        y = position.getLng();
        x = position.getLat();
    }
    AMap.event.addListener(mar,"dragend",dragEnd);
}

