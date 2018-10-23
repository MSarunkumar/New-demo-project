/**
 * 
 */

isTestOnline();

function isTestOnline() {
	 $.ajax( {
         type: "Post"  ,
         url: "/OnlineExam2/Model/takeTest.cfc?method=isOnline" ,
         datatype: "json",
         success:function(res)
              { 
                var submitRes = $.parseJSON(res);
                if (submitRes == "offline") {
                	 window.location.assign("../../index.cfm?errId=9");	
                }  
        	  }
           });
		 setTimeout( isTestOnline, 1000);	
	}
