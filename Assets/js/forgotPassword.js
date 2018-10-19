/**
 * 
 */
              var e_Valid = false;
          
          function formValidation() {
                  emailValid();
              if (e_Valid) return true;
              else  return false;
              }
          //...................................................  email Validation 
          function emailValid() {

              var email = document.getElementById("uid")
                  .value;

              
           
              var regemail=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

              if((email.trim()) == "" ){
            	  e_Valid = ShowError("eid", " Please enter your Email  ");
              }
              else if (!regemail.test(email)) {
                  e_Valid = ShowError("eid", " Please enter valid Email  ");

              } else {
                   e_Valid = done("eid");
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
         
         