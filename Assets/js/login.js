          
          var e_Valid = false;
          var p_Valid = false;
          function formValidation() {

              emailValid();
              passwordValid();
              
              if (e_Valid &&  p_Valid  )  return true;
              else                        return false;
              }
          //...................................................  email Validation 
          function emailValid() {

              var email = document.getElementById("uid")
                  .value;

              var regemail = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
              if((email.trim()) == "" ){
            	  e_Valid = ShowError("eid", " Please enter your Email  ");
              }
              else if (!regemail.test(email)) {
                  e_Valid = ShowError("eid", " Please enter valid Email  ");

              } else {
                   e_Valid = done("eid");
              }
          }
          //...........................................................................              password Validation 
          function passwordValid() {
              password = document.getElementById('password')
                  .value;

              var lowerCaseLetters = /[a-z]/g;
              var upperCaseLetters = /[A-Z]/g;
              var specialLetters = /[~!@#$%^&*()_+<>:"?;'/{}[=]|"]/g;
              var numberLetters = /[0-9]/g;

              if (password.length < 8) {
                  p_Valid = ShowError("pid", "Please enter your password");
              } else if (!((password.match(lowerCaseLetters)) && (password.match(upperCaseLetters)) &&
                      (password.match(numberLetters)) && (password.match(specialLetters)))) {
                  p_Valid = ShowError("pid", "Please enter valid password");

              } else {

                  p_Valid = done("pid");
                  }
              }
         
          //.....................................   It will remove error
          function done(ids) {
              document.getElementById(ids).innerHTML = '';
              return true;
          }
          //......................................  It will display error message on specified position(based on ids)
          function ShowError(ids, msg) {
              document.getElementById(ids)
                  .innerHTML = msg;
              return false;
          }
         
         