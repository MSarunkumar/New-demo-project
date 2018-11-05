/**
 * 
 */

isTestOnline();

function isTestOnline() {
	 $.ajax( {
         type: "Post"  ,
         url: "../../Model/takeTest.cfc?method=isOnline" ,
         datatype: "json",
         success:function(res)
              { 
                var submitRes = $.parseJSON(res);
                if (submitRes == "offline") {
                	 window.location.assign("../../Controller/logoutAction.cfm");	
                }  
        	  }
           });
		 setTimeout( isTestOnline, 1000);	
	}
