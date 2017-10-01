<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
<%@include file="header.jsp" %>

       <title>账号管理</title>
  </head>
  <body>
  <section id="container" >
     
<%@include file="frame.jsp"%>



      <!--main content start-->
      <section id="main-content">
          <section class="wrapper">
              <div class="row">
                  <div class="col-lg-12 clearfix">
                      <p class="pull-left font30">编辑信息 </p>
                    
                  </div>
                </div>
                <div class="row">
                  <div class="col-lg-12">
                      <section class="panel">
                          <div class="panel-body">
                                  <div class="form-group">
                                      <label class="font16 font-bold">用户邮箱</label>
                                      <input type="email" class="form-control" id="email" placeholder="" value='<c:if test="${user != null && user.email != null }">${user.email}</c:if>' readonly="readonly">
                                  </div>
                                  <div class="form-group">
                                      <label class="font16 font-bold">用户名称</label>
                                      <input type="text" class="form-control" id="username" placeholder=""  value='<c:if test="${user != null && user.userName != null }">${user.userName}</c:if>'>
                                  </div>
                                  
                                  <div class="form-group">
                                      <label class="font16 font-bold">设置新密码</label>
                                      <input  type="password" class="form-control" id="password" placeholder="">
                                  </div>
                                  <div class="form-group">
                                      <label class="font16 font-bold">重复新密码</label>
                                      <input  type="password" class="form-control" id="repeatpassword" placeholder="">
                                  </div>
                                  
                                  <div class="form-group">
                                      <label class="font16 font-bold">管理的餐厅</label>
                                      <c:if test="${restaurantInfo != null && restaurantInfo.resultList != null}">
                                      <c:forEach items="${restaurantInfo.resultList}" var="temp" >
									            <div class="checkbox">
	                                              <label>
	                                                ${temp.restaurantName}
	                                              </label>
	                                            </div>
	                                            </c:forEach>
	        </c:if>
                                  </div>
                                  <button type="submit" id='submitBtn' class="btn btn-success" ">修改</button>
                                  <a href="userServlet?action=toUpdate&id=${restaurantId }">取消</a>

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
  <script>

      //owl carousel

      $(document).ready(function() {
          $("#owl-demo").owlCarousel({
              navigation : true,
              slideSpeed : 300,
              paginationSpeed : 400,
              singleItem : true,
			  autoPlay:true

          });
      });

      //custom select box

      $(function(){
          $('select.styled').customSelect();
      });
        


      $("#submitBtn").click(function() {

          var userName = $("#username").val();
          var email = $('#email').val();
          if (email == null || email == "") {
              toastr["error"]("用户邮箱不能为空!");
              return;
          }
          if (userName == null || userName == "") {
              toastr["error"]("用户名称不能为空!");
     		  $("#userName").focus();
              return;
          }

          var password = $('#password').val();
          var repeatpassword = $('#repeatpassword').val();
          if ( password != '' || repeatpassword != '' ){
              if ( password == ''){
                  toastr["error"]("新密码不能为空!");
                  return;
              }
              if ( password.length < 6 || password.length > 16){
                  toastr["error"]("新密码长度不能小于六位且不能大于16位!");
                  return;
              }
              if ( repeatpassword == ''){
                  toastr["error"]("重复新密码不能为空!");
                  return;
              }
              if ( repeatpassword.length <6 || repeatpassword.length > 16){
                  toastr["error"]("复新密码长度不能小于六位且不能大于16位!");
                  return;
              }
              if ( password != repeatpassword ){
                  toastr["error"]("新密码和重复新密码不一致！");
                  return;
              }
          }
          
          $(this).confirm({
              'title' : '修改信息',
              'message' : "你确定要修改信息吗？",
              'action' : function(){
            	  
            	  $.ajax({
              		type: "post",
              		url: "userServlet",
              		data: {"action": "updateUser", "email": email, "userName": userName, "newPassword": password},
              		success : function (data) {
              			$('#flagmodal').modal('hide');
              			if (data == null) {
              				toastr["error"]("系统异常！");
              				return;
              			}
              			if (data.resultCode != 1) {
              				toastr["error"](data.resultMessage);
              				console.log(data.resultMessage);
              				return;
              			} else {
              				
              				// 如果修改了密码就要重新登录
              				if (password != null && password != "") {
              					toastr["success"]("修改成功！ 密码已变动,请重新登录！");
                  				console.log("修改成功！ 密码已变动,请重新登录！");
              					setTimeout(function(){
        			                //这里的代码将在1000ms(1s后执行)
              						window.location.href = "userServlet?action=logOut";
            					},1000);
              					return;
              				} else {
              					toastr["success"]("修改成功！");
                  				console.log("修改成功！");
                  				$('#password').val('');
                  	            $('#repeatpassword').val('');
              				}
              			}
              		}
              	});

              },
              template: '<div class="modal confirm-modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true"><div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button><h4 class="modal-title" id="myLargeModalLabel">Large modal</h4></div><div class="modal-body"><p class="modal-body-content" ></p></div><div class="modal-footer"><button type="button" class="btn btn-default" name="cancelBtn" data-dismiss="modal">取消</button><button type="button"  class="btn btn-danger confirm-btn" name="confirmBtn" data-dismiss="modal">确定</button></div></div></div></div>'
          });
          
 });

  </script>

  </body>
</html>
