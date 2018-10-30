/**
 * 
 */

/**
 * 
 */
          
    
         
         
          var o1_Valid = false;
          var o2_Valid = false;
          var o3_Valid = false;
          var o4_Valid = false;
          var a_Valid  = false;
         
          var questionId = $("#questionId").val();         
          var option1; var option2;
          var option3; var option4;
          var ans;
          
          function formValidation() {

             
             
              op1Valid();
              op2Valid();
              op3Valid();
              op4Valid();
              ansValid();
             
              if(option1==option2 ||option1==option3 ||option1==option4||
        	     option2==option3 || option2==option4 ||option3==option4) {
            	  return ShowError("oid4","All options must be unique.");
              }
            	  
              
              
             if ( o1_Valid && o2_Valid && o3_Valid && o4_Valid && a_Valid  )       
                      return true;
                      
             else 
            	      return false;
          }
    
        
    
    //........................................................................... 
          function op1Valid() {

               option1 = document.getElementById("op1").value;
               option1 =  option1.trim();
               o1_Valid = optionValid(option1,"oid1"," Please enter first option");
               
               }
    //...........................................................................
          function op2Valid() {

               option2 = document.getElementById("op2").value;
               option2 =  option2.trim();
               o2_Valid = optionValid(option2,"oid2"," Please enter second option");
               if( o2_Valid){
               if(option1==option2)
            	   o2_Valid=DupError("oid2");
               }
          }
    //.............................................................................    
          function op3Valid() {

               option3 = document.getElementById("op3").value;
               option3 =  option3.trim();
               o3_Valid = optionValid(option3,"oid3"," Please enter third option");
               if( o3_Valid){
               if(option2==option3 )
            	   o3_Valid=DupError("oid3");
               }
          }
    //..............................................................................
          function op4Valid() {

               option4 = document.getElementById("op4").value;
               option4 =  option4.trim();
               o4_Valid = optionValid(option4,"oid4"," Please enter last option");
               if( o4_Valid){
               if(option3==option4)
            	   o4_Valid=DupError("oid4");
               }
          }
    //.............................................................................       
          
          function ansValid() {
               ans = document.getElementById("ansID").value;
              a_Valid = selectValid(ans,"aid","Please choose answer");
              }
          
   //............... Display error message and return [true/false]   ........
          function optionValid(value,id,msg) {
         
        	 if (value == "") {
                   return ShowError(id,msg);
             } 
              else {
                   return done(id);
                  }
         }
     
   //..........  It will remove error message and return true.
         function done(ids) {
              document.getElementById(ids).innerHTML = '';
              return true;
          }
         
   //.............  It will display error message on specified position(based on ids)
          function ShowError(ids, msg) {
              document.getElementById(ids).innerHTML = msg;
              return false;
          }
          
   //............   It will Show Error for duplicate options. 
          function DupError(ids)
          {
        	  document.getElementById(ids)
              .innerHTML = "You have already entered this option";
              return false; 
          }
  //.............  It will validate drop down option [subject/answer]  
          function selectValid(value,ids,msg) {
        	  if(value == "0") {
    			  return ShowError(ids, msg);
    			  }
			   else {
				  return done(ids);
			   }
          }
          
          
          
    
          
          $("#save").click(function () {
        	  
        	  if(formValidation()) {
        		  $.confirm({
					    title: "Confirm ..!!",
						type:"green",
					    content: "Do you want to update these options ?",
					    theme: "material",
					    boxWidth: "35%",
					    useBootstrap: false,
					    buttons: {
					        confirm: function () {
					        	updateOption();
					        },
					        cancel: function () {
			                  
					        }
					    }
					});        		 
        	   }
        	});
          
    //............... it will update options  ....................... 
          function updateOption() {
        	  
        	  $.ajax({
        		 type:"post",
        		 url:"../../Model/addQuestion.cfc?method=updateOption",
        		 data:{        			 
        		       qid:questionId,
        			   op1:option1,
        			   op2:option2,
        			   op3:option3,
        			   op4:option4,
        			   ans:ans
        		      },
        		 datatype:"json",
        		 success:function (res) {
        			 var resp = $.parseJSON(res);
        			 if(resp) {
        				window.location.assign("viewQuestions.cfm?errID=1"); 
        			 }
        			 else {
        				 $(".serverSideError").html("Internal Problem. Please try again.");
        			 }
        		 }
        	  });
          }
        	  
        	  
               
                  
        	  
        	  
          
          
          
         
          