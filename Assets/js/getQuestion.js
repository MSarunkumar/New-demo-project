/**
 * 
 */
//......  It will block browser backward action  
if(document.referrer != 'http://localhost:5000/') {
	  history.pushState(null, null, '');
	  window.addEventListener('popstate', function () {
	  history.pushState(null, null, '');
	   });
}
//......................................................................

$(document).ready(function () {
		var score = 0;
		var totalQ = 0;
		var num = 0;
		var subjectName = $("#subjectName").val();
		
		getTotalQuestion(subjectName);
		
	      
	$("#nextBtn").click( function () {
		
		if ( $("#answer").val() != undefined ) {
	    	if (totalQuestion != 1){
               if ($("#answer").val() == $("input[name='radioBtn']:checked").val()) {
                 score = score+1;
                }
	    	  }
		    }
            //....   it is for removing Next button and change the color of submit 
            //         button  at last question ...............................
		if (totalQuestion == 1) {
		     $("#nextBtn").attr("disabled","disabled");
		     $("#submitBtn").css("background-color", "#e80b28");
		   }
			
		else {
			totalQuestion = totalQuestion-1;
		    getQuestionId(totalQuestion);
		 }
	});
	
	//..............  It is fetching the questions with options and answer based 
	//                  on question Id.   ..................
	
	function nextQuestion(questionId) {
		 num=num+1;           // This variable  is showing question number. 
	      $.ajax({
	         type: "Post"  ,
	         url: "/OnlineExam2/Model/takeTest.cfc?method=getQuestions" ,
	         data:{qid:questionId },
	         datatype: "json",
	         
	         success:function(res)
	              {
	        	    var res = $.parseJSON(res);
	        	    
	                if(res.DATA[0][0] == -1) {
	                	window.location.assign("studentDashboard.cfm?errId=1");	
	            	}
	                
	              else {
	            	  
	                $("#ques").html("<br>Question &nbsp"+num+":&nbspof "+totalQ+" ::&nbsp" +res.DATA[0][0]);
	                   for (i = 1; i < 5; i++) {
	                $('<br><br><input type="radio" name="radioBtn" value = '+i+'>&nbsp' + res.DATA[0][i] +'</input>').appendTo('#ques');
	                	}
	                $("#answer").val(res.DATA[0][5]);
	              }
	            }
	        });
	     }
	
	function submitScore() {
		//.........       It is for calculating score of last question 
	     
	         if ($("#answer").val() != undefined ) {
	        	if ($("#answer").val() == $("input[name='radioBtn']:checked").val()) {
	                        score = score+1;
	                        }
	    	          }
	    //..............   It will submit the score  
	         
	         $.ajax( {
		         type: "Post"  ,
		         url: "/OnlineExam2/Model/takeTest.cfc?method=submitScore" ,
		         data:{ score:parseInt(score),
		        	    totalQuestion:parseInt(totalQ),
		        	    subject:subjectName
		        	    },
		         
		         datatype: "json",
		         success:function(res)
		              { 
                        var submitRes = $.parseJSON(res);
                        if (submitRes) {
			        	    window.location.assign("studentDashboard.cfm?errId=3");
		        	    }
		        	    else {
		        	        window.location.assign("studentDashboard.cfm?errId=1");
		        	    }
		        	  }
		           });
                }
	
	function getQuestionId(tq) {
		//....  It will fetch question Id based on subject and total number of question 
		 
			 $.ajax({
		         type: "Post"  ,
		         url: "/OnlineExam2/Model/takeTest.cfc?method=getQuestionId" ,
		         data:{ qno: tq,
		        	    sub:subjectName
		        	    },
		         datatype: "json",
		         
		         success:function(res)
		              {
		        	     questionId = $.parseJSON(res);
		        	     if(questionId == -1) {
		        	    	 window.location.assign("studentDashboard.cfm?errId=1");
		        	     }
		        	     nextQuestion(questionId);
		              }
		          });
		    }	
	  function getTotalQuestion(subjectName) {
		 //....... It will fetch total number of question based on subject
		  
			 $.ajax( {
		         type: "Post"  ,
		         url: "/OnlineExam2/Model/takeTest.cfc?method=totalQuestion" ,
		         data:{sub:subjectName},
		         datatype: "json",
		         success:function(res)
		              {
		        	  totalQuestion = $.parseJSON(res);
		        	  
		        	  if (totalQ === 0) {
		    	    	  totalQ = totalQuestion;
		    	    	  }
		        	  if (totalQuestion == -1) {
		        		  window.location.assign("studentDashboard.cfm?errId=1");  
		        	  }
		        	  getQuestionId(totalQuestion);
		              }
		        });
            }
	
	$("#submitBtn").click( function () {
		$.confirm({
		    title: "Confirm...!!",
			type:"green",
		    content: "Do you want to submit the test ?",
		    theme: 'material',
		    boxWidth: "35%",
		    useBootstrap: false,
		    buttons: {
		        confirm: function () {
		        	submitScore();
		        },
		        cancel: function () {
                  
		        }
		    }
		});
	  });
});
	//.........This function calls when time will be over .
	
	$(function(){
		  $(".timer").startTimer({
		    onComplete: function(element) {
		       submitScore();
		    }
		  }).click(function() { 
			  //.......... it will fire, when some one click on timer
		  });
		});



/*window.onbeforeunload = function () {
    window.setTimeout(function () { 
    	if(isSubmit) { 
    		
    	}
    	else {
    		window.location.assign("../../Controller/logoutAction.cfm");
    	}
        
    }, 0);
    window.onbeforeunload = null;  
                                    
    return 'Press "Stay On Page" to go to BBC website!';
       
}*/
	


