$(function(){

});

/**
 * 进入创建页面
 * @param restaurantId
 */
function toCreate(restaurantId) {
	if (restaurantId == null ||restaurantId == "" || restaurantId == 0) {
		toastr["error"]("系统异常！");
		console.log("餐厅ID不能为空！");
		return;
	}
	window.location.href = "promotionServlet?action=toCreate&id=" + restaurantId;
}

/**
 * 进入修改页面
 * @param restaurantId
 * @param promotionId
 */
function toUpdate (restaurantId, promotionId) {
	if (restaurantId == null ||restaurantId == "" || restaurantId == 0) {
		toastr["error"]("系统异常！");
		console.log("餐厅ID不能为空！");
		return;
	}
	if (promotionId == null ||promotionId == "" || promotionId == 0) {
		toastr["error"]("系统异常！");
		console.log("promotionId不能为空！");
		return;
	}
	window.location.href = "promotionServlet?action=toupdate&id=" + restaurantId + "&promotionId=" + promotionId;
}

function deletePromotion (promotionId,restaurantId,_this,promotionName) {
	if (restaurantId == null ||restaurantId == "" || restaurantId == 0) {
		toastr["error"]("系统异常！");
		console.log("餐厅ID不能为空！");
		return;
	}
	if (promotionId == null ||promotionId == "" || promotionId == 0) {
		toastr["error"]("系统异常！");
		console.log("promotionId不能为空！");
		return;
	}
	
	 $(_this).confirm({
         'title' : '删除促销',
         'message' : '你确定要删除促销活动"' + promotionName + '" ?',
         'template': '<div id="flagmodal" class="modal confirm-modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true"><div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button><h4 class="modal-title" id="myLargeModalLabel">Large modal</h4></div><div class="modal-body"><p class="modal-body-content" ></p></div><div class="modal-footer"><button type="button" class="btn btn-default" name="cancelBtn" id="cancel" data-dismiss="modal">取消</button><button type="button" class="btn btn-danger confirm-btn" name="confirmBtn" id="confirmBtnDealDelete">确定</button></div></div></div></div>',
         'action' : function(){
          $("#confirmBtnDealDelete").attr('disabled',true); // 按钮不可用
          $.ajax({
		    	type:"post",
		    	url:"promotionServlet",
		    	data:{"action":"delete","id":restaurantId,"promotionId":promotionId},
		    	dateType:"json",
		    	success:function(data){
		    		$('#flagmodal').modal('hide');
		    		console.log(data);
					if (data == null) {
						toastr["error"]("系统异常！");
						console.log("系统异常！");
						return;
					}
					if (data.resultCode != 1) {
						toastr["error"](data.resultMessage);
						console.log(data.resultMessage);
						return;
					} else {
						
						toastr["success"]("删除成功！");
						console.log("删除成功！");
						setTimeout(function(){
			                //这里的代码将在1000ms(1s后执行)
							window.location.reload();
    					},1000);
					}
		    	}
		    });
         }
     });
}


/**
 * 创建或修改促销
 */
$("#submitButton").click(function(data){
	
	// 餐厅ID
    var restaurantId = $("#restaurantId").val();
    if (restaurantId == null || restaurantId == ""){
        toastr["error"]("参数异常！");
        console.log("参数异常！");
        return ;
    }
	// 促销类型
	var chosenSelectPromotionType = $(".chosen-select-promotionType");
    var promotionType = chosenSelectPromotionType.val() ;
    if (promotionType == null || promotionType == ""){
        toastr["error"]("请选择促销活动类型！");
        console.log("请选择促销活动类型！");
        return ;
    }
    // 促销名称
    var promotionName = $("#promotionName").val();
    if (promotionName == null || promotionName == ""){
        toastr["error"]("名称不能为空！");
        console.log("名称不能为空！");
        return ;
    }
    
    // 促销开始时间
    var startDate = $("#startDate").val();
    if (startDate == null || startDate == ""){
        toastr["error"]("开始时间不能为空！");
        console.log("开始时间不能为空！");
        return ;
    }
    
    // 促销结束时间
    var endDate = $("#endDate").val();
    if (endDate == null || endDate == ""){
        toastr["error"]("结束时间不能为空！");
        console.log("结束时间不能为空！");
        return ;
    }
    
    // 促销内容
    var content = $("#content").val();
    if (content == null || content == ""){
        toastr["error"]("内容不能为空！");
        console.log("内容不能为空！");
        return ;
    }
	
	// 促销活动的ID
    var promotionId = $("#promotionId").val();
  
    
    if (promotionId == null || promotionId == "") { // 添加
    	
    	// 是否确定创建的提示
        $(this).confirm({
            'title': "创建促销活动",
            'message': "你确定要创建一个新的促销活动吗？",
            'template': '<div id="flagmodal" class="modal confirm-modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true"><div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button><h4 class="modal-title" id="myLargeModalLabel">Large modal</h4></div><div class="modal-body"><p class="modal-body-content" ></p></div><div class="modal-footer"><button type="button" class="btn btn-default" name="cancelBtn" data-dismiss="modal">取消</button><button type="button" class="btn btn-danger confirm-btn" name="confirmBtn">确定</button></div></div></div></div>',
            'action': function (data) {
    			    $.ajax({
    			    	type:"post",
    			    	url:"promotionServlet",
    			    	data:{"action":"saveOrUpdate","promotionType":promotionType,"promotionName":promotionName,"startDate":startDate,"endDate":endDate,"content":content, "isActive":isActiveStatus,"id":restaurantId},
    			    	dateType:"json",
    			    	success:function(data){
    			    		$('#flagmodal').modal('hide');
    			    		console.log(data);
    						if (data == null) {
    							toastr["error"]("系统异常！");
    							console.log("系统异常！");
    							return;
    						}
    						if (data.resultCode != 1) {
    							toastr["error"](data.resultMessage);
    							console.log(data.resultMessage);
    							return;
    						} else {
    							toastr["success"]("创建成功！");
    							console.log("创建成功！");
    							setTimeout(function(){
    				                //这里的代码将在1000ms(1s后执行)
    								window.location.href = "promotionServlet?action=info&id="+restaurantId;
    	    					},1000);
    						}
    			    	}
    			    });
            }
        });
    	
    	
    } else {
    	
      // 活动打开还是关闭
      if ($("#isActive").attr("checked")) {
    	 isActiveStatus = 1;
      }
      // 是否确定修改的提示
        $(this).confirm({
            'title': "修改促销活动",
            'message': "你确定要修改此促销活动吗？",
            'template': '<div id="flagmodal" class="modal confirm-modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true"><div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button><h4 class="modal-title" id="myLargeModalLabel">Large modal</h4></div><div class="modal-body"><p class="modal-body-content" ></p></div><div class="modal-footer"><button type="button" class="btn btn-default" name="cancelBtn" data-dismiss="modal">取消</button><button type="button" class="btn btn-danger confirm-btn" name="confirmBtn">确定</button></div></div></div></div>',
            'action': function () {
    			    $.ajax({
    			    	type:"post",
    			    	url:"promotionServlet",
    			    	data:{"action":"saveOrUpdate","promotionType":promotionType,"promotionName":promotionName,"startDate":startDate,"endDate":endDate,"content":content,"isActive":isActiveStatus,"id":restaurantId,"promotionId":promotionId},
    			    	dateType:"json",
    			    	success:function(data){
    			    		$('#flagmodal').modal('hide');
    			    		console.log(data);
    						if (data == null) {
    							toastr["error"]("系统异常！");
    							console.log("系统异常！");
    							return;
    						}
    						if (data.resultCode != 1) {
    							toastr["error"](data.resultMessage);
    							console.log(data.resultMessage);
    							return;
    						} else {
    							toastr["success"]("修改成功！");
    							console.log("修改成功！");
    							setTimeout(function(){
    				                //这里的代码将在1000ms(1s后执行)
    								window.location.href = "promotionServlet?action=info&id="+restaurantId;
    				            },1000);
    						}
    			    	}
    			    });
            }
        });
        
    }
    
    
});

/**
 * 进入修改页面
 * @param restaurantId
 */
function toUpdate(restaurantId, promotionId) {
	if (restaurantId == null ||restaurantId == "" || restaurantId == 0) {
		toastr["error"]("系统异常！");
		console.log("餐厅ID不能为空！");
		return;
	}
	if (promotionId == null ||promotionId == "" || promotionId == 0) {
		toastr["error"]("系统异常！");
		console.log("PromotionId不能为空！");
		return;
	}
	window.location.href = "promotionServlet?action=toUpdate&id=" + restaurantId + "&pId=" + promotionId;
}

/**
 * 计算剩余输入文字的数量
 */
function calNum() {
    $('#numLabel').html($('#content').val().length);
}


/**
 * 打开状态按钮
 * @returns
 */
function dealOn(e,_this){
	isActiveStatus = 1;

	var target = $(e.currentTarget);
    var promotionId = target.parent().parent().attr("promotion-id");
    $(_this).confirm({
        'title' : '打开促销',
        'message' : '你确定打开这个促销活动？',
        'template': '<div id="myModal' + promotionId +'"  class="modal confirm-modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true"><div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button><h4 class="modal-title" id="myLargeModalLabel">Large modal</h4></div><div class="modal-body"><p class="modal-body-content" ></p></div><div class="modal-footer"><button type="button" class="btn btn-default" name="cancelBtn" data-dismiss="modal">取消</button><button type="button" class="btn btn-danger confirm-btn" name="confirmBtn" id="confirmBtnDealOff">确定</button></div></div></div></div>',
        'action' : function(){
        	$.ajax({
        		type:"post",
        		url:"promotionServlet",
        		data:{"action":"isActive","promotionId":promotionId,"id":$("#restaurantId").val(),"isActive":isActiveStatus},
        		dataType:"",
        		success:function(data){
        			if (data != null && data.resultCode ==1) {
        				$("#confirmBtnDealOff").attr('disabled',true); // 按钮不可用
                        $('#myModal'+ promotionId).modal('hide');
                        toastr["success"]("success");
                        $('#mySwitch' + promotionId).bootstrapSwitch("setOn");
                        setTimeout(function(){
                            //这里的代码将在1000ms(1s后执行)
                        	window.location.reload();
                        },1000);
                        return true;
        			} else {
        				toastr["error"](data.message);
                        return false;
        			}
        		}
        	});
        }
    });

   
}
    
/**
 * 关闭状态按钮
 * @param id
 * @param _this
 * @returns
 */
	function dealOff(e,_this){
		
		isActiveStatus = 0;
		
		var target = $(e.currentTarget);
	    var promotionId = target.parent().parent().attr("promotion-id");
	    $(_this).confirm({
	        'title' : '关闭促销',
	        'message' : '你确定关闭这个促销活动？',
	        'template': '<div id="myModal' + promotionId +'"  class="modal confirm-modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true"><div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button><h4 class="modal-title" id="myLargeModalLabel">Large modal</h4></div><div class="modal-body"><p class="modal-body-content" ></p></div><div class="modal-footer"><button type="button" class="btn btn-default" name="cancelBtn" data-dismiss="modal">取消</button><button type="button" class="btn btn-danger confirm-btn" name="confirmBtn" id="confirmBtnDealOff">确定</button></div></div></div></div>',
	        'action' : function(){
	        	$.ajax({
	        		type:"post",
	        		url:"promotionServlet",
	        		data:{"action":"isActive","promotionId":promotionId,"id":$("#restaurantId").val(),"isActive":isActiveStatus},
	        		dataType:"",
	        		success:function(data){
	        			if (data != null && data.resultCode ==1) {
	        				$("#confirmBtnDealOff").attr('disabled',true); // 按钮不可用
	                        $('#myModal'+ promotionId).modal('hide');
	                        toastr["success"]("success");
	                        $('#mySwitch' + promotionId).bootstrapSwitch("sefOff");
	                        setTimeout(function(){
	                            //这里的代码将在1000ms(1s后执行)
	                        	window.location.reload();
	                        },1000);
	                        return true;
	        			} else {
	        				toastr["error"](data.message);
	                        return false;
	        			}
	        		}
	        	});     
	            
	        }
	    });
	
	}





