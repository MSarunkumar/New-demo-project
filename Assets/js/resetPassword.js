          
          var p_Valid = false;
          var c_Valid = false;
         
          function formValidation() {

              rpassword();
              rcpassword();
           
              if (p_Valid &&  c_Valid )
            	 return true;
              else   
            	 return false;
            }
 
          function rpassword() {
        	  var  password = document.getElementById("password").value;
              p_Valid = passwordValid("pid",password);      
          }
          
          
          
          function rcpassword() {
        	 var  cpassword = document.getElementById("cpassword").value;
                    c_Valid = passwordValid("cpid",cpassword);  
                if(((document.getElementById("password").value)
                  		  .localeCompare(document.getElementById("cpassword").value)))
                    	c_Valid = ShowError("cpid","Does not match confirm-password") ;
                    else c_Valid = done("cpid");
                    	
          }
    
          //................................................   password Validation 
        function passwordValid(ids,password) {
              
        	  var lowerCaseLetters = /[a-z]/g;
              var upperCaseLetters = /[A-Z]/g;
              var specialLetters = /[~!@#$%^&*()_+<>:"?;'/{}[=]|"]/g;
              var numberLetters = /[0-9]/g;

              if (password.length < 8) {
                   ShowError(ids, "Please enter more than 8 characters");
                   return false;
              } else if (!((password.match(lowerCaseLetters)) && (password.match(upperCaseLetters)) &&
                      (password.match(numberLetters)) && (password.match(specialLetters)))) {
                ShowError(ids, "Password must contain [0-9,a-z,A-Z,specialChar]");
                    return false;
              } else {

                  done(ids);
                  return true;
                  }
              }

      //.....................................   It will remove error
      function done(ids) {
          document.getElementById(ids).innerHTML = "";
          return true;
      }
      //......................................  It will display error message on specified position(based on ids)
      function ShowError(ids, msg) {
          document.getElementById(ids)
              .innerHTML = msg;
          return false;
      }
     
     