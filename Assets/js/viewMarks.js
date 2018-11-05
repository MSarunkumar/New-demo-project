/**
 * 
 */
/**
 * 
 */$(document).ready(function () {
var table = $("#tableId").DataTable({
	   "aoColumnDefs": [{
	        "bSortable": false,
	        "aTargets": [-1,-2]               /* 1st one, start by the right side */
	    }]
	});
});

 
 function getAllowStatus(email,testId, _this) {
		
		var value = $(_this).val();
		var current_status = (value === "ALLOW" ? 0 : 1 );
		
		$.ajax({
			type:"post",
			url:"../../Model/blockUnblock.cfc?method=getAllowStatus",
			data:{
				  studentEmailId:email,
				  testId:testId
				 
				  },
			datatype:"JSON",
			success:function(data) {
				 var respStatus = $.parseJSON(data);
				 
				 if(respStatus.DONE) {
					 var result = respStatus.DATA;
					 if(result) {
						 $(_this).val("Allow");				 
					 }
					 else {
						 $(_this).val("Not Allow");							 
					 }
					
				 }
				 else {
					 $(".serverSideError").html("Internal problem.Please try again");
				 }
				 
			}
			
		});
	}

	            

