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

 
 function getAllowStatus(email,subject, _this) {
		
		var value = $(_this).val();
		var current_status = (value === "ALLOW" ? 0 : 1 );
		
		$.ajax({
			type:"post",
			url:"../../Model/blockUnblock.cfc?method=getAllowStatus",
			data:{
				  studentEmailId:email,
				  subject:subject
				 
				  },
			datatype:"JSON",
			success:function(data) {
				 var respStatus = $.parseJSON(data);
				 
				 if(respStatus.DONE) {
					 var result = respStatus.DATA;
					 if(result) {
						 $(_this).val("Not Allow");	
					 }
					 else {
						 $(_this).val("Allow");	
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

	            

