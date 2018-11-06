/**
 * 
 */
          var t_Valid  = false;
          var st_Valid = false;
          var d_Valid = false;  
          var q_Valid = false;
          var test; var startT;         
          var durationT; var queNum;          
          var readyStartTime = "" ;
          var totalQuestion;
          
          
          
          function formValidation() {

              testValid();
              startValid();
              durValid();
              queValid();
              
              if (t_Valid && st_Valid  && d_Valid && q_Valid ) {      
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
    //..............................................          Validate total number of question in test
          function queValid() {
        	  queNum = document.getElementById("queId").value;
        	  queNum = queNum.trim();
              var reg = /^\d{1,2}$/;
              if (queNum == "" || queNum == "0") {
                  q_Valid = ShowError("qtid", " Please enter total question ");
              }
              else if (!reg.test(queNum)) {
            	  q_Valid = ShowError("qtid", " Please enter only digits");
              }
              else {
            	        q_Valid = done("qtid");
              }
              
           }
                    
   //..........................................   It will remove error message and return true.
         function done(ids) {
              document.getElementById(ids).innerHTML = '';
              return true;
          }
         
   //......................................       It will display error message on specified position(based on ids)
          function ShowError(ids, msg) {
              document.getElementById(ids).innerHTML = msg;
              return false;
          }
         
  //........................................       It will validate drop down test option  
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
      //....................................................  
          $("#update").click(function() {
        	  
        	  if(formValidation()) {
        		  
        		  $.ajax({
        				type:"Post"  ,
        		        url: "../../Model/viewDetails.cfc?method=getTotalActiveQuestion" ,
        		        data:{  
        		        	 subject:test
        		       	     },
        		        datatype: "json",
        		        success:function(res) { 
        		        	 totalQuestion = $.parseJSON(res);
        		        	 //. if active question in less than admin enter total number of question 
        		        	   if(totalQuestion < queNum) {
        		        		   q_Valid = ShowError("qtid", " Please enter total question less than active question");    
        	                   }
        		        	   else if(totalQuestion == -1) {
        		        		   $(".serverSideError").html("Internal Problem. Please try again.");
        		        	   }
        		        	   else {
        		        		   getStartTimeFormat();
        		        	   }
        		            }
                        });
        	  }
          });
          
          
          
          
     //.......................   getStartTimeFormat ................
          function getStartTimeFormat() {      
        	  $.ajax({
  				type: "Post"  ,
  		        url: "../../Validation/validations.cfc?method=getDateTimeFormat" ,
  		        data:{  
  		        	   time:startT  
  		       	     },
  		        datatype: "json",
  		        success:function(res) { 
  		                readyStartTime = $.parseJSON(res);
  		                isTestOverlap();
  		           }
        	    });
        	 }
        	  
       //..............................................   Two test can not be overlap 
          function isTestOverlap() {
        	  $.ajax({
         		 type:"post",
         		 url:"../../Model/takeTest.cfc?method=isOverlap",
         		 data:{
         			    subject: test,
 		        	    startTime:readyStartTime,
 		        	    duration:durationT
         		      },
         		 datatype:"json",
         		 success:function (res) {

         			 var resp = $.parseJSON(res);
         			 console.log(resp);
         			 if(resp) {
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
         			 else {
         				 $("#stid").html("Two test can not be overlap");
         			 }
         		 }
         	  });
        	  
          }      
    //...........         it will update the test time and duration      ....................... 
    			        	   
          function updateTestTime() {
        	  
        	  $.ajax({
        		 type:"post",
        		 url:"../../Model/takeTest.cfc?method=updateTestTime",
        		 data:{
        			    testName: test,
		        	    startTime:readyStartTime,
		       	        duration:durationT,
		       	        totalQuestion:queNum
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


			$(document).ready(function () {
				$("#picker").dateTimePicker();
			})