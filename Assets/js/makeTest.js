/**
 * 
 */
          var t_Valid  = false;
          var st_Valid = false;
          //var et_Valid = false;
          var d_Valid = false;
         
          var test; var startT;
          //var endT; 
          var durationT;
          var readyStartTime = "" ;
          //var readyEndTime = ""; 
          
          
          function formValidation() {

              testValid();
              startValid();
             // endValid();
              durValid();
              
              if (t_Valid && st_Valid  && d_Valid ) {      
                   return true;
              }    
              else 
            	   return false;
           }
    //............................................................ Test Name  validation     
          function testValid() {
        	  test = document.getElementById("testId").value;
              t_Valid = selectValid(test,"tid","Please choose test name");
              }
        
    //............................................................. start time  validation 
          function startValid() {
        	  startT = document.getElementById("startId").value;
        	  startT = startT.trim();
        	  if(startT == "") {
        		  st_Valid = ShowError("stid" , "Please choose activate time of test");
        	  }
              else {
            	  st_Valid = done("stid");
              }
              
           }
    //.............................................................  end time  validation
         /* function endValid() {
        	  endT = document.getElementById("endId").value;
        	  endT = endT.trim();
        	  if(endT == "") {
        		  et_Valid = ShowError("etid" , "Please choose deactivate time of test");
        	  }
              else {
            	  et_Valid = done("etid");
              }
           }*/
   //..............................................................  Test duration validation
          function durValid() {
        	  durationT = document.getElementById("durId").value;
        	  durationT = durationT.trim();
              var reg = /^\d{1,3}$/;
              if (durationT == "" || durationT == "0") {
                  d_Valid = ShowError("dtid", " Please enter test duration ");
              }
              else if (!reg.test(durationT)) {
            	  d_Valid = ShowError("dtid", " Please enter only digits");
              }
              else {
            	        d_Valid = done("dtid");
              }
              
           }
            
   //....................................................  It will remove error message and return true.
         function done(ids) {
              document.getElementById(ids).innerHTML = '';
              return true;
          }
         
   //......................................  It will display error message on specified position(based on ids)
          function ShowError(ids, msg) {
              document.getElementById(ids).innerHTML = msg;
              return false;
          }
         
  //........................................  It will validate drop down test option  
          function selectValid(value,ids,msg) {
        	  if(value == "0") {
    			  return ShowError(ids, msg);
    			  }
			   else {
				  return done(ids);
			   }
          }     
          
  //.................. server side validations .......................
          
     /*     $("#update").click(function() {
        	  
        	  if(formValidation()) {
        		  
	    		  $.ajax({
	    				type: "Post"  ,
	    		        url: "/OnlineExam2/Validation/validations.cfc?method=makeTestValid" ,
	    		        data:{  
	    		        	   startTime:startT,
	    		       	       endTime:endT,
	    		       	       duration:durationT
	    		       	     },
	    		        
	    		        datatype: "json",
	    		        success:function(res)
	    		             { 
	    		               var resp = $.parseJSON(res);
	    		               if (resp.length) {
		    		               if (resp[0] == 1) {
		    		            	   $("#etid").html("Interval time must be 1 hrs of activation");
		    		            	  }   
		    		               if (resp[0] == 2 || resp[1] == 2) {		    		            	 
		    		            	   $("#dtid").html("Time duration must be less than interval time ");
		    		            	  }
	    		                }
	    		                else {
	    		            	   getStartTimeFormat(startT);
	    		            	  
	    			        	 
	    		                 }
	    		                 
	    		             }		   	    
	        		    });        			      
        		}
          });
          */
          
     //.......................   getStartTimeFormat ................
         
          
          $("#update").click(function() {
        	  
        	  if(formValidation()) {
        	  $.ajax({
  				type: "Post"  ,
  		        url: "/OnlineExam2/Validation/validations.cfc?method=getDateTimeFormat" ,
  		        data:{  
  		        	   time:startT  
  		       	     },
  		        datatype: "json",
  		        success:function(res) { 
  		                readyStartTime = $.parseJSON(res);
  		              $.confirm({
  					    title: "Confirm ..!!",
  						type:"green",
  					    content: "Do you want to update test time ?",
  					    theme: "material",
  					    boxWidth: "35%",
  					    useBootstrap: false,
  					    buttons: {
  					        confirm: function () {
  					        	updateTestTime();
  					        },
  					        cancel: function () {
  			                  
  					        }
  					      }
 	       	          });
  		               
  		           }
        	    });
        	 }
        	  
          });
          
     //................  getEndTimeFormat  ..............................
       /*   function getEndTimeFormat(endT) {
        	  $.ajax({
  				type: "Post"  ,
  		        url: "/OnlineExam2/Validation/validations.cfc?method=getDateTimeFormat" ,
  		        data:{  
  		        	   time:endT  
  		       	     },
  		        datatype: "json",
  		        success:function(res)
  		             { 
  		               readyEndTime = $.parseJSON(res);
  		             $.confirm({
 					    title: "Confirm ..!!",
 						type:"green",
 					    content: "Do you want to update test time ?",
 					    theme: "material",
 					    boxWidth: "35%",
 					    useBootstrap: false,
 					    buttons: {
 					        confirm: function () {
 					        	updateTestTime();
 					        },
 					        cancel: function () {
 			                  
 					        }
 					      }
	       	              });
  		                
  		             }
        	  });
        	  
          }*/
          
    //...........         it will update the test time and duration      ....................... 
    			        	   
          function updateTestTime() {
        	  
        	  $.ajax({
        		 type:"post",
        		 url:"/OnlineExam2/Model/takeTest.cfc?method=updateTestTime",
        		 data:{
        			    testName: test,
		        	    startTime:readyStartTime,
		       	       // endTime:readyEndTime,
		       	        duration:durationT
        		      },
        		 datatype:"json",
        		 success:function (res) {
        			 var resp = $.parseJSON(res);
        			 if(resp) {
        				window.location.assign("makeTest.cfm?errID=1"); 
        			 }
        			 else {
        				 $(".serverSideError").html("Internal Problem. Please try again.");
        			 }
        		 }
        	  });
          }

