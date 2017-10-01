

/**
 * 登录
 */
$("#submitBtn").click(function(){
	
	
	//用户邮箱非空判断
	var email = $("#email").val();
	if (isEmpty(email)) {
		 toastr["error"]("用户邮箱不能为空！");	
		 $("#email").focus();
		 return;
	}
	
	//密码非空判断
	var password = $("#password").val();
	if (isEmpty(password)) {
		 toastr["error"]("用户密码不能为空！");
		 $("#password").focus();
		 return;
	}
	
	// 是否记住密码 0=不是，1=是
	var isRememberPwd = 0;
    if ($('#isRememberPwd').attr('checked')) {
    	isRememberPwd = 1;
    }
	
	$.ajax({
		type:"post",
		url:"userServlet",
		data: {"action": "login","email":email, "password":password, "isRememberPwd":isRememberPwd},
		success:function(data){
			if (data == null) {
				toastr["error"]("系统异常！");
				return;
			}
			if (data.resultCode != 1) {//登录失败
				toastr["error"](data.resultMessage);
				return;
			} else {
				toastr.success("登录成功！");
				console.log("登录成功！");
				setTimeout(function(){
	                //这里的代码将在1000ms(1s后执行)
					window.location.href = "indexServlet?id=" + data.resultID;
				},10);
				
			}
		}
	});
	
});