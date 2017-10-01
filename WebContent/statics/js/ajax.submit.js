AjaxSubmitUtil = {
		ajaxSubmit:function (url, data, dataType, sucfunc, errfunc) {
			$.ajax({
				type:"post",
				url: url,  
				data: data,
				dataType:dataType,
				success:function (req){
					if(req.loginovertime=='loginovertime'){
						$.scojs_message('Time out, please login again.', $.scojs_message.TYPE_ERROR);
						window.location.reload();
						return;
					}
					sucfunc(req);
				},
				error:function (){
					if (typeof errfunc == 'function') {
						errfunc();
						return;
					} else {
						$.scojs_message("System error, please refresh again.", $.scojs_message.TYPE_ERROR);
						return;
					}
				},
				complete: function (XHR, TS) { 
					XHR = null; 
				}
			});	
		},
		
		ajaxSubmitRemote: function (url, data, sucfunc) {
			$.ajax({
				type: 'get',
				dataType: "jsonp",
				jsonp: "callback",//传递给请求处理程序或页面的，用以获得jsonp回调函数名的参数名(默认为:callback)
				//jsonpCallback:"success_jsonpCallback",//自定义的jsonp回调函数名称，默认为jQuery自动生成的随机函数名
				url: url,
				data:data,
				success:function(req){
					if(req.loginovertime=='loginovertime'){
						$.scojs_message('Time out, please login again.', $.scojs_message.TYPE_ERROR);
						window.location.reload();
						return;
					}
					sucfunc(req);
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					$.scojs_message(XMLHttpRequest.status + ": oops! There was a problem with our system, please try again.", $.scojs_message.TYPE_ERROR);
					return;
				}
			});
		}
};