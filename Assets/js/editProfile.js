/**
 * 
 */         
          var n_Valid  = false;
          var d_Valid  = false;
          var m_Valid  = false;
          var a_Valid  = false;
         
          var name = "";   var mobile;
          var address = ""; var dob ;
         
          function formValidation() {
             
              nameValid();    
              mobileValid();
              addressValid();
              dobValid();
             
             if (d_Valid && n_Valid  && m_Valid && a_Valid ) { 	 
                   return true;
               }                  
             else 
            	   return false;
          }
        
        //...................................................  Name Validation 
          function nameValid() {
                  name = document.getElementById("name").value;
                  name=name.trim();
                  
               if (name == "") {
                  n_Valid = ShowError("nid", "Please enter your name");
              } 
               else if (ValidAlpha(name)) {
                   n_Valid = ShowError("nid", "Please enter alphabets only");
               } 
               
             else {
            	  document.getElementById("name").value =name.replace(/ {2,}/g, ' ');
                  n_Valid = done("nid");
              }
			}
          
       //..............................................................................   mobile1 Validation
          function mobileValid() {
                  mobile = document.getElementById("mobile")
                  .value;
              mobile=mobile.trim();
              var regmob = /^\d{10}$/;
              if (mobile == "" )   {
                  m_Valid = ShowError("mid", " Please enter your mobile ");
              }
              else if(mobile == "0000000000"){
            	  m_Valid = ShowError("mid", " Please enter valid mobile "); 
              }
              else if (!regmob.test(mobile)) {
                  m_Valid = ShowError("mid", " Please enter only 10 digits");
              }
              else {

                  m_Valid = done("mid");
              }
          }
        
          
        //.........................................................................     Address validation 
          function addressValid() {
                 address = document.getElementById("address")
                  .value;
              address = address.trim();

              if (address == "") {
                  a_Valid = ShowError("aid", "Please enter your address  ");
              } else {
                  document.getElementById("address").value = address.replace(/ {2,}/g, ' ');
                    a_Valid = done("aid");
              }
          }
          
          //................................................  DOB  validation
          function dobValid()
          {
        	    dob = document.getElementById("date")
        			   .value;
        	   
        	   var str=dob.split("-");
        	   var today = new Date();
        	   var firstDate = Date.UTC(today.getFullYear(),today.getMonth()+1,today.getDate());
        	   var secondDate = Date.UTC(str[0],str[1],str[2]);
        	   var diff = (firstDate.valueOf()  - secondDate.valueOf())/(24*60*60*1000);
        	       
        	   if (dob == "") {
                   d_Valid = ShowError("did", "Please select your DOB ");
               } else if(diff < 0){
            	   d_Valid = ShowError("did", "Please don`t select future date ");
                    }
               else{
                     d_Valid = done("did");
                 }
        	 }
         
          //.....................................   It will remove error message
          function done(ids) {
              document.getElementById(ids).innerHTML = '';
              return true;
          }
          //.............  It will display error message on specified position(based on ids)
          function ShowError(ids, msg) {
              document.getElementById(ids)
                  .innerHTML = msg;
              return false;
          }
          //...................  It will Validate,allow Alphabets only
          function ValidAlpha(input) {
              var regtext = /^[a-zA-Z ]+$/g;
              if (regtext.test(input))
                  return false;
              else
                  return true;
          }
          
    //..................  Server Side Validation  ............    
          
          	$("#editBtn").click( function () {
          
        		if(formValidation()) {
        	     $.ajax({
				 type: "Post" ,
				 url:  "../../Validation/validations.cfc?method=editProfileValid" ,
				 data:{
					   name:name,
					   date:dob,
					   mobile:mobile,
					   address:address
				       },
				 
				 datatype: "json",
				 success:function(res) {
					        var res = $.parseJSON(res);
					        console.log(res);
					        if(res) {
					        	$.confirm({
	          					    title: "Confirm ..!!",
	          						type:"green",
	          					    content: "Do you want update your profile  ?",
	          					    theme: 'material',
	          					    boxWidth: "35%",
	          					    useBootstrap: false,
	          					    buttons: {
	          					        confirm: function () {
	          					       
	          					        	 updateProfile();
	          					        },
	          					        cancel: function () {
	          			                  
	          					        }
	          					    }
	          					  });
					        	
					        	}
					        else {
					        	$("#serverError").html("Invalid details");
					        }
					        
					      }
        	     });
        		}
          	}); 
          	
          	
          	//.......................................   it will update the profile of student  
            function updateProfile() {
            	   $.ajax({
            		   type:"post",
            		   url:"../../Model/signup.cfc?method=updateProfile",
            		   data:{
            			   name:name,
						   dob:dob,
						   phone:mobile,
						   address:address						   
				          },
            	        datatype:"JSON",
            	        success:function(res) {
            	        	
            	        	var res = $.parseJSON(res);
            	        	if(res) {           	        		
            	        		window.location.assign("studentDashboard.cfm?errId=7");	
            	        	}
            	        	else {
            	        	    
            	        	    $("#serverError").html("Internal problem. Please try again");
            	        	}
            	         }
            		 
            	   });
            }          