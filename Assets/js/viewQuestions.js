/**
 * 
 */

$(document).ready(function () {
var table = $("#tableId").DataTable({
	   "aoColumnDefs": [{
	        "bSortable": false,
	        "aTargets": [-1,-2]               /* 1st one, start by the right side */
	    }]
	});
});


//......................   it will get questionId and do action on that... 

function getQuestionStatus(questionId, _this) {
	
	var value = $(_this).val();
	var current_status = (value === "Active" ? 1 : 0);
	$.ajax({
		type:"post",
		url:"../../Model/blockUnblock.cfc?method=getQuestionStatus",
		data:{
			  questionId:questionId,
			  status : current_status 
			  },
		datatype:"JSON",
		success:function(data) {
			 var respStatus = $.parseJSON(data);
			 console.log(respStatus);
			 if(respStatus.DONE) {
				 var result = respStatus.DATA;
				 if(result) {
					 $(_this).val("Active");	
				 }
				 else {
					 $(_this).val("Inactive");	
				 }
				 $(_this).toggleClass("btn-red");
				 $(_this).toggleClass("btn-green");
			 }
			 else {
				 $(".serverSideError").html("Internal problem.Please try again");
			 }
			 
		}
		
	});
}
