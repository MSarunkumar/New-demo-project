/**
 * 
 */

 function subValid() {
	          var value = document.getElementById("subId").value;
        	  if(value == "0") {
        		  document.getElementById("sid").innerHTML ="Please choose test" ;
    			  return false;
    			  }
			   else {
				  document.getElementById("sid").innerHTML="";
				  return true;
			   }
          }