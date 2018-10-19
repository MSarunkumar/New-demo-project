<cfinclude template="../Includes/signupPageValidate.cfm" />
<html>
	 <head>
		 <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
	     <link href="../assets/css/index.css"  rel="stylesheet">
	     <title>
				Recover Password
		 </title>
     </head>
     <body>
		<div id="main-body">
             <div class="upper-bar">
                <div id="left-elt"> ONLINE EXAM SYSTEM </div>
		        <div id="right-elt">
					  <ul>
						  <li><a href="">Help</a></li>
						  <li><a href=""> About us</a></li>
						  <li><a href=""> Contact us</a></li>
						  <li><a href="../index.cfm"> Login</a></li>
						  <li><a href="signup.cfm">Register</a></li>
					  </ul>
				</div>
			  </div>

		     <div class="hat-icon">
               <img src="../assets/image/hat.png" width="200px" height="130px">
             </div>
             <div id="serverSideError">
		     	<cfset errorArray=[ "Not registered Email Id",
		     	                    "Please enter valid format",
		                            "Link has been send to your email.Please open that within 10 hrs.",
		                            "Internal problem. Please try again"]>
				<cfif isdefined("URL.errID")>
				    <cfif URL.errId EQ 1>
					   <cfoutput>#errorArray[1]#</cfoutput>
				    </cfif>
				    <cfif URL.errId EQ 2>
					   <cfoutput>#errorArray[2]#</cfoutput>
				    </cfif>
				    <cfif URL.errId EQ 3>
					   <cfoutput>#errorArray[3]#</cfoutput>
				    </cfif>
				    <cfif URL.errId EQ 4>
					   <cfoutput>#errorArray[4]#</cfoutput>
				    </cfif>
		         <cfelse>
			     </cfif>
		      </div>
			 <div class="form-area">
				<div class="form-header"> Recover Password </div>

				<div class="form-image">
                	<img src="../assets/image/loginUser.png" width="100px" height="80px">
				</div>

           		<form action= "../Controller/forgotPasswordAction.cfm" onsubmit="return formValidation()" method="POST" id="form">
					<div class="loginEmail">
						<div class="labelContainer">Email Id</div>
					    <input type="text" id= "uid" name="uid" placeholder="Email Id" class="input_box" maxlength="50" onblur="emailValid()">
					    <div id="eid"> </div>
					 </div>

					 <input name="send" type="Submit" class="btn" value="Send" >
                </form>
			</div>

          </div>
          <script src="../assets/js/forgotPassword.js" type="text/javascript"></script>
          <footer>
		    @2018 onlineexam.com/All rights reserved
          </footer>
	</body>
</html>
