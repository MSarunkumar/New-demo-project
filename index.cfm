 <cfinclude template="Includes/loginPageValidate.cfm" />
<html>
	 <head>
		 <title> Online Examination Home page </title>
		 <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
	     <link href="assets/css/index.css"  rel="stylesheet">
    </head>
	<body>
        <div id="main-body">
             <div class="upper-bar">
			 	<div id="left-elt">ONLINE EXAM SYSTEM</div>
	            <div id="right-elt">
				  <ul>
					  <li><a href="">Help</a></li>
					  <li><a href="">About us</a></li>
					  <li><a href="">Contact us</a></li>
					  <li><a href="">Login</a></li>
					  <li><a href="view/signup.cfm">Register</a></li>
                   </ul>
			     </div>
			   </div>

             <div class="hat-icon">
               <img src="assets/image/hat.png" width="200px" height="130px">
             </div>

             <div id="serverSideError">
				<cfset VARIABLES.errorArray=["Invalid format Email Id/Password",
				                    "Please enter registered Email Id/Password",
				                    "Please enter correct Email Id/Password",
				                    "Internal problem,Please try again",
				                    "Registered Successfully... !! ",
				                    "Your password has been changed",
				                    "You are blocked by ADMIN",
				                    "Invalid user","You are offline for taking the test"]>
				<cfif isdefined("URL.errID")>
					<cfif URL.errID GTE 1 AND URL.errID LTE 9 >
						<cfoutput>#VARIABLES.errorArray[URL.errID]#</cfoutput>
					</cfif>
					<cfelse>
				</cfif>
            </div>
			<div class="form-area">

            	<div class="form-header"> Login </div>
				<div class="form-image">
                	<img src="assets/image/loginUser.png" width="100px" height="80px">
				</div>

           		<form action= "Controller/loginAction.cfm" onsubmit="return formValidation()" method="POST" id='form'>

					<div class="loginEmail">
                           <div class="labelContainer"> Email Id   </div>
						   <input type="text" id="uid" name="uid" placeholder="Email Id" class="input_box" maxlength="50" onblur="emailValid()">
                           <div id="eid"> </div>
                    </div>

				    <div class="loginPassword">
                           <div class="labelContainer">  Password </div>
					       <input type="Password" id="password" name="password"  class="input_box" placeholder="Password"  maxlength="16" onblur="passwordValid()">
                           <div id="pid"> </div>
				    </div>

				    <input name="login" type="Submit" class="btn" value="Login" >
		            <a href="view/forgotPassword.cfm">Forgot Password ?</a>

                 </form>
	           </div>
          </div>
          <script src="assets/js/login.js" type="text/javascript"></script>
		<cfinclude template="Includes/footer.cfm" />
      </body>
</html>