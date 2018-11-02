/**
 * 
 */

$(document).ready(function () {

	var table = $("#tableId").DataTable({
		   "aoColumnDefs": [{
		        "bSortable": false,
		        "aTargets": [-1]               /* Disable sort 1st one, start by the right side */
		    }]
		});
	
		
	//........ It will block the student if it is unblock	
		/*function blockStudent(email,name) {
			alert("block :: " );
			 /*$.ajax({
				 type:"post"
				 url:"../../Model/blockUnblock.cfm?method=blockStudent",
				 data:{email:email},
				 datatype:"json",
				 success:function(res) {
					 let resp = $.parseJSON(res);
					 if(resp) {
						 $("#serverMessage").html(name+" "+"is blocked");
					 }
					 else {
						 $("#serverMessage").html("Internal problem.Please try again..@");
					 }
				 }
				 
			 });
		}*/
   //........ It will block the student if it is unblock		
		/*function unblockStudent(email,name) {
			
			
			if()
			
			 $.ajax({
				 type:"post"
				 url:"../../Model/blockUnblock.cfm?method=unblockStudent",
				 data:{email:email},
				 datatype:"json",
				 success:function(res) {
					 let resp = $.parseJSON(res);
					 if(resp) {
						 $("#serverMessage").html(name+" "+"is unblocked");
					 }
					 else {
						 $("#serverMessage").html("Internal problem.Please try again..@");
					 }
				 }
				 
			 });
			
		}*/		
});


function getStatus(email, _this) {
	
	var value = $(_this).val();
	var current_status = (value === "Block" ? 0 : 1 );
	
	$.ajax({
		type:"post",
		url:"../../Model/blockUnblock.cfc?method=getStatus",
		data:{
			  email:email,
			  status : current_status 
			  },
		datatype:"JSON",
		success:function(data) {
			 var respStatus = $.parseJSON(data);
			 
			 if(respStatus.DONE) {
				 var result = respStatus.DATA;
				 if(result) {
					 $(_this).val("Block");	
				 }
				 else {
					 $(_this).val("Unblock");	
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

            

