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
//.........................................................................
        var isSubmit = false;
		var score = 0;
		var num = 0;
		var subjectName = $("#subjectName").val();
		var totalQ = $("#totalQuestion").val();
		var testIdentifier = $("#testId").val();
		var totalQuestion = parseInt(totalQ,10);
		
		
		getQuestionId(totalQuestion);
	     
		console.log(totalQuestion);
	    console.log("hiii");
	    
	   $("#nextBtn").click( function () {
			
		if ( $("#answer").val() != undefined ) {
	    	if (totalQuestion != 1) {
               if ($("#answer").val() == $("input[name='radioBtn']:checked").val()) {
                  score = score+1;
                }
	    	}
		}
            //....   it is for disabled Next button and change the color of submit 
            //       button  at last question     ...................
		
		if (totalQuestion == 1) {
		     $("#nextBtn").attr("disabled","disabled").css("background-color", "#abafba");
		     $("#submitBtn").css("background-color", "#e80b28");
		}			
		else {
			 totalQuestion = totalQuestion-1;
		     getQuestionId(totalQuestion);
		}
	});
	
	//..............  It is fetching the questions with options and answer based 
	//                on question Id.   ..................
	
	function nextQuestion(questionId) {
		 num=num+1;           // This variable  is showing question number. 
	      $.ajax({
	         type: "Post"  ,
	         url: "../../Model/takeTest.cfc?method=getQuestions" ,
	         data:{qid:questionId },
	         datatype: "json",
	         
	         success:function(res)
	              {
	        	    var res = $.parseJSON(res);
	                if(res.DATA[0][0] == -1) {
	                	window.location.assign("studentDashboard.cfm?errId=1");	
	            	}	                
	                else {	            	  
	                $("#ques").html("Question &nbsp"+num+":&nbspof "+totalQ+" ::&nbsp" +res.DATA[0][0]);
	                   for (i = 1; i < 5; i++) {
	                $('<br><br><input type="radio" name="radioBtn" value = '+i+'>&nbsp' + res.DATA[0][i] +'</input>').appendTo('#ques');
	                	}
	                $("#answer").val(res.DATA[0][5]);
	                }
	            }
	        });
	     }
	
	function submitScore() {
		
		 if(! isSubmit)
	     {
		//............................   It is for calculating score of last question 
	         if ($("#answer").val() != undefined ) {
	        	if ($("#answer").val() == $("input[name='radioBtn']:checked").val()) {
	                        score = score+1;
	             }
	    	 }
	    //............................   It will submit the score  
	         
	         $.ajax({
		         type: "Post"  ,
		         url: "../../Model/takeTest.cfc?method=submitScore" ,
		         data:{ score:parseInt(score),
		        	    totalQuestion:parseInt(totalQ),
		        	    subject:subjectName,
		        	    testId:testIdentifier
		        	    },
		         
		         datatype: "json",
		         success:function(res) { 
                        var submitRes = $.parseJSON(res);
                        if (submitRes) {
                        	isSubmit = true;
			        	    window.location.assign("studentDashboard.cfm?errId=3");
		        	    }
		        	    else {
		        	        window.location.assign("studentDashboard.cfm?errId=1");
		        	    }
		        	  }
	         });
	   }
	else {
		 window.location.assign("studentDashboard.cfm");		 
		 }
	}
	
	function getQuestionId(tq) {
		//....  It will fetch question Id based on subject and total number of question 
		 
			 $.ajax({
		         type: "Post"  ,
		         url: "../../Model/takeTest.cfc?method=getQuestionId" ,
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

	//.........This function calls when time will be over .
	
	$(function(){
		  $(".timer").startTimer( {
		    onComplete: function(element) {
		       submitScore();
		    }
		  }).click(function() { 
			  //.......... it will fire, when some one click on timer
		     });
	});



/*window.onbeforeunload = function () {
    window.setTimeout(function () { 
    	
    	if( ! isSubmit) { 
    		submitScore();	
    	}
    	if(isSubmit) {
    		window.location.assign("studentDashboard.cfm?errId=3");  
    		}
        
    }, 0);
    window.onbeforeunload = null;  
                                    
    return 'Press "Stay On Page" to go to online exam system!';      
}*/