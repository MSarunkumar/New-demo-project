          
          var password = '';
          var n_Valid  = false;
          var e_Valid  = false;
          var d_Valid  = false;
          var m_Valid  = false;
          var a_Valid  = false;
          var p_Valid  = false;
          var cp_valid = false;
        
          var name = "";  var email = ""; var mobile;
          var address = ""; var dob ;var cpassword="";
          document.getElementById("cpassword").disabled = true;

          function formValidation() {

             
              nameValid();
              emailValid();
              passwordValid();
              mobileValid();
              addressValid();
              dobValid();
              cpasswordValid();
             
             if (d_Valid && n_Valid && e_Valid && p_Valid && m_Valid && a_Valid ) { 	 
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
          //............................................................                             Email Validation 
          function emailValid() {

                email = document.getElementById("email")
                  .value;
              email=email.trim();
              var regemail = /^([a-zA-Z0-9_\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
              
              
              if (email == "") {
                  e_Valid = ShowError("eid", " Please enter your Email  ");

              } 
              else if (!regemail.test(email)) {
                  e_Valid = ShowError("eid", " Please enter Valid Email  ");
                }
              else {

                  e_Valid = done("eid");
              }
          }
          //...........................................................................              password Validation 
          function passwordValid() {
              password = document.getElementById("password")
                  .value;
              password=password.trim();
              var lowerCaseLetters = /[a-z]/g;
              var upperCaseLetters = /[A-Z]/g;
              var specialLetters = /[!@##$&*=-{}<>,.:;|?""''~"]/g;
              var numberLetters = /[0-9]/g;

              if (password == "") {
                  p_Valid = ShowError("pid", "Please enter Password");
              }
              else if (password.length < 8) {
                  p_Valid = ShowError("pid", "Please enter more than 8 characters");
              }
              else if (!((password.match(lowerCaseLetters)) && (password.match(upperCaseLetters)) &&
                      (password.match(numberLetters)) && (password.match(specialLetters)))) {
                  p_Valid = ShowError("pid", "Please enter [0-9,a-z,A-Z,specialChar]");

              } else {
            	  document.getElementById("cpassword").disabled = false;
                 p_Valid = done("pid");
                 
               }

          }
          
          //.......................................................................................   mobile1 Validation
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
        
          
          //...............................................     Address validation 
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
          //....................................... confirm-password
          function cpasswordValid() {
               cpassword = document.getElementById("cpassword")
                  .value;
              if (password != cpassword) {
                  cp_Valid = ShowError("cpid", "Does not match Confirm-Password ");

              } else {
                  cp_Valid = done("cpid");
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
          
          	$("#btn").click( function () {
        		if(formValidation()) {
        	     $.ajax({
				 type: "Post" ,
				 url:  "../Validation/validations.cfc?method=signupValid" ,
				 data:{
					   name:name,
				       email:email,
					   date:dob,
					   mobile:mobile,
					   password:password,
					   cpassword:cpassword,
					   address:address
				       },
				 
				 datatype: "json",
				 success:function(res) {
					        var res = $.parseJSON(res);
					        if(res) {
					        	 checkEmail();
					        	}
					        else {
					        	$("#serverError").html("Invalid details");
					        }
					        
					      }
        	     });
        		}
          	}); 
          	
          	//.............. It will check email registered or not ......
          	function checkEmail() {
          		$.ajax({
          			type:"post",
          			url:"../Model/signup.cfc?method=emailExist",
          			data:{email:email},
          			datatype:"json",
          			success:function(res) {
          				
          				var res = $.parseJSON(res);
          				if(res == 0) {
          					$.confirm({
          					    title: "Confirm ..!!",
          						type:"green",
          					    content: "Do you want to submit your detail ?",
          					    theme: 'material',
          					    boxWidth: "35%",
          					    useBootstrap: false,
          					    buttons: {
          					        confirm: function () {
          					        	submitDetail();
          					        },
          					        cancel: function () {
          			                  
          					        }
          					    }
          					});
          					
          				}
          				else if(res == -1){
          					$("#serverError").html("Internal problem. Please try again");	
          				}
          				else {
          					 $("#serverError").html("Email already registered");
          				}
          			}
          			
          		});
          		
          	}
          	
          	
          	//................   it will submit detail of user   ......................
            function submitDetail() {
            	   $.ajax({
            		   type:"post",
            		   url:"../Model/signup.cfc?method=submitDetail",
            		   data:{
            			   name:name,
            		       email:email,
						   dob:dob,
						   phone:mobile,
						   address:address,
						   password:password
						   
				          },
            	        datatype:"JSON",
            	        success:function(res) {
            	        	
            	        	var res = $.parseJSON(res);
            	        	if(res) {           	        		
            	        		window.location.assign("../index.cfm?errId=5");	
            	        	}
            	        	else {
            	        	    
            	        	    $("#serverError").html("Internal problem. Please try again");
            	        	}
            	         }
            		 
            	   });
            }
          	
          	
          
         
          
          
          
          