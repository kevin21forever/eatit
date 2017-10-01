$(document).ready(function(){
    $("#language-switch").click(function(){
        //$("#language-div").show();
        var language = $(this).attr('data-value');
        if (language == 'zh_CN') {
            language = 'en_US';
        } else {
            language = 'zh_CN';
        }
        setCookie("cookie_language", language, 365*24*60*60*1000);
        location.reload();
    });



    // I18N plugin
    $.extend($, {
        i18n: function() {
            var args = arguments;
            var key = args[0];
            var value = window['I18N'][key];
            if (value) {
                if (args.length > 0) {
                    value = value.replace(/\{(\d+)\}/g, function(m, i) {
                        return args[parseInt(i) + 1];
                    });
                }
                return value;
            } else {
                return key;
            }
        }
    });

    $("#language li").click(function(){
        $("#language li").removeClass("ls-selected");
        $(this).addClass("ls-selected");
        var language = $(this).attr('data-value');
        if (language == 'zh_CN') {
            $("#language-div").next().html("中&nbsp;&nbsp;文");
        } else {
            $("#language-div").next().html("English");
        }
        $("#language").hide();
        setCookie("cookie_language", language, 365*24*60*60*1000);
        location.reload();
    });
});




String.prototype.Trim = function(){ 
	return this.replace(/(^\s*)|(\s*$)/g, ""); 
};

function isEmpty(targetStr) {
	if (targetStr == null || targetStr.trim().length < 1) {
		return true;
	} else {
		return false;
	}
}

//验证是否数字
function isNumber(value) {
	if (isEmpty(value)) {
		return false;
	} else {
		var strP = /^\d+(\.\d+)?$/; //验证是否数字
		return strP.test(value);
	}
}

function isEmail (value) {
	var reg = new RegExp(/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/g);
	if (isEmpty(value)) {
		return false;
	}
	return reg.test(value);
}

function isMobile (value) {
	if (!isEmpty(value)) {
		var reg = new RegExp(/^1[34568]\d{9}$/g);
		return reg.test(value);
	} else {
		return false;
	}
}

rnd.today = new Date();
rnd.seed = rnd.today.getTime();

function rnd() {
	rnd.seed = (rnd.seed * 9301 + 49297) % 233280;
	return rnd.seed / (233280.0);
}
// 随机数
function rand(number) {
	return Math.ceil(rnd() *number);
};

function loadMiddleHeight () {
	var popupHeight = $(".modal-dialog").height(); //获取弹出层高度
	var windowHeight = $(window).height(); //获取当前窗口高度
	var top = (windowHeight - popupHeight)/2;
	return top;
}

function loadMiddleWidth (popupId) {
	var popupWidth =$(".modal-body").width();//获取弹出层宽度
	var windowWidth = $(window).width(); //获取当前窗口宽度
	var left = (windowWidth - popupWidth)/2;
	return left;
}

function showConfirmModal (callback) {
	var modal = $.scojs_modal({target: '#confirm_modal', keyboard: true});
	modal.show();
	closeModalInPad(modal);
	$("#yesDone").bind("click", function(){
		callback();
	});
}