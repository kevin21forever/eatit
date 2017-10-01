$(function(){
	
	// 初始化下拉框选择器
	initSelector();
	
	// 错误信息加载
	errorMessage ();
	
});


/**
 * 修改餐厅信息
 */
$("#submitBtn").click(function(data){
	// 餐厅ID
	var restaurantId = $("#restaurantId").val();
	if (restaurantId == null || restaurantId == "") {
		 toastr["error"]("餐厅ID不能为空！");
		 console.log("餐厅ID不能为空！");
		 $("#restaurantId").focus();
		 return;
	}
	
	// 餐厅名称
	var restaurantName = $("#restaurantName").val();
	if (restaurantName == null || restaurantName == "") {
		 toastr["error"]("餐厅名称不能为空！");
		 console.log("餐厅名称不能为空！");
		 $("#restaurantName").focus();
		 return;
	}
	
	// 餐厅地址
	var address = $("#address1").val();
	if (address == null || address == "") {
		 toastr["error"]("餐厅地址不能为空！");
		 console.log("餐厅地址不能为空！");
		 $("#address").focus();
		 return;
	}
	
	// 菜系
	var chosenSelectCuisine = $(".chosen-select-cuisine");
    var cuisine = chosenSelectCuisine.val() ;
    if (cuisine == null || cuisine == ""){
        toastr["error"]("请选择菜系！");
        console.log("请选择菜系！");
        return ;
    }
    
    // 人均价格
	var chosenSelectAvgPrice = $(".chosen-select-avgPrice");
    var avgPrice = chosenSelectAvgPrice.val() ;
    if (avgPrice == null || avgPrice == ""){
        toastr["error"]("请选择人均价格！");
        console.log("请选择人均价格！");
        return ;
    }
    var telephone = $("#telephone").val();
    var website = $("#website").val();
    
    var isHasWiFi = 0;
    if ($('#isHasWiFi').attr('checked')) {
    	isHasWiFi = 1;
    }
    var isHasSeat = 0;
    if ($('#isHasSeat').attr('checked')) {
    	isHasSeat = 1;
    }
    
    // 是否确定修改的提示
    $(this).confirm({
        'title': "修改餐厅信息",
        'message': "你确定要修改餐厅信息吗？",
        'template': '<div id="flagmodal" class="modal confirm-modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true"><div class="modal-dialog modal-lg"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button><h4 class="modal-title" id="myLargeModalLabel">Large modal</h4></div><div class="modal-body"><p class="modal-body-content" ></p></div><div class="modal-footer"><button type="button" class="btn btn-default" name="cancelBtn" data-dismiss="modal">取消</button><button type="button" class="btn btn-danger confirm-btn" name="confirmBtn">确定</button></div></div></div></div>',
        'action': function () {
        	$.ajax({
        		type: "post",
        		url: "restaurantServlet",
        		data: {"action": "update", "id": restaurantId, "restaurantName": restaurantName, "address": address, "cuisine": cuisine, "avgPrice": avgPrice, "telephone": telephone, "website": website, "isHasSeat": isHasSeat, "isHasWiFi": isHasWiFi},
        		success : function (data) {
        			console.log("success");
        			
        			$('#flagmodal').modal('hide');
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
        				location.reload();       
        			}
        		}
        	});
        }
    });
    
});





/**
 * 初始化下拉框选择器
 * @returns
 */
function initSelector() {
	var config = {
	      '.chosen-select-cuisine'           : {max_selected_options: 1}, // 菜系下拉框选择器
	      '.chosen-select-avgPrice'           : {max_selected_options: 1}, // 人均价格下拉框选择器
	      '.chosen-select-no-results': {no_results_text:'Oops, nothing found!'},
	}
	for (var selector in config) {
	    $(selector).chosen(config[selector]);
	}
}

/**
 * 错误信息加载
 */
function errorMessage () {
	// 错误信息加载
	var resultCode = $("#resultCode").val();
	if (resultCode != null && resultCode == 0) {
		var resultMessage = $("#resultMessage").val();
		toastr["error"](resultMessage);
		console.log(resultMessage);
	}
}









