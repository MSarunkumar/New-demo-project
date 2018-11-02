<cfinclude template="../Includes/signupPageValidate.cfm" />
<html>
	 <head>
		 <title> Recover Password </title>
		 <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
	     <link href="../assets/css/index.css"  rel="stylesheet">
     </head>
     <body>
		<div id="main-body">
             <cfinclude template="../Includes/upperBar.cfm" />
             <div id="serverSideError">
		     	<cfset VARIABLES.errorArray=[ "Not registered Email Id",
		     	                    "Please enter valid format",
		                            "Link has been send to your email.Please open that within 1 hrs.",
		                            "Internal problem. Please try again"]>
				<cfif isdefined("URL.errID")>
					<cfif URL.errID GTE 1 AND URL.errID LTE 4 >
						<cfoutput>#VARIABLES.errorArray[URL.errID]#</cfoutput>
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
          <cfinclude template="../Includes/footer.cfm" />
	</body>
</html>
