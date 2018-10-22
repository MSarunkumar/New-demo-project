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
