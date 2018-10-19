<cfif NOT isDefined("URL.id")>
	<cflocation  url = "../error/error.cfm" addtoken = "no">
<cfelse>
	<cfset VARIABLES.currentTime = #DateTimeFormat(now(), "MM d yyyy HH:nn:ss ")# />

	<cfset VARIABLES.times = APPLICATION.FP.getTime(URL.id) />

	<cfif  VARIABLES.times EQ "">
		<cflocation  url = "badRequest.cfm" addtoken = "no" />
	</cfif>

	<cfset VARIABLES.sec = Datediff("s",VARIABLES.times,VARIABLES.currentTime) />
	<cfset VARIABLES.hours = int(VARIABLES.sec/3600) />
	<cfif  VARIABLES.hours GT 10>
		<cfoutput>
			<h1>
				The Link has been Expired.
				<a href="../index.cfm"> Go Back </a>
			</h1>
		</cfoutput>
	<cfelse>
		<cfset VARIABLES.email = APPLICATION.FP.getEmail(URL.id) />

		<html>
			<head>
				<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
				<link href="../assets/css/index.css"  rel="stylesheet">
				<title>Reset Password</title>
			</head>
			<body>
				<div id="main-body">
		            <div class="upper-bar">
		            	 <div id="left-elt">ONLINE EXAM SYSTEM</div>
					</div>
				    <div class="hat-icon">
		               <img src="../assets/image/hat.png" width="200px" height="130px">
                    </div>
					<cfset errorArray = ["Please enter valid format of password"]>
					<cfif isdefined("URL.errID")>
					    <cfif URL.errId EQ 1>
						   <cfoutput>#errorArray[1]#</cfoutput>
					    </cfif>
				    </cfif>
					<div class="form-area">
						<div class="form-header"> Reset Password </div>
						<div class="form-image">
		            	<img src="../assets/image/loginUser.png" width="100px" height="80px">
						</div>
							<form action="../Controller/resetPasswordAction.cfm" onsubmit="return formValidation()" method="POST" id='form'>
		                        <div class="password">
									<div class="labelContainer"> New Password </div>
									<input type="Password" id="password" name="password"  class="input_box" maxlength="16" placeholder="Enter password" onblur="rpassword()">
									<div id="pid"></div>
								</div>
		                            <cfoutput><input type="hidden" name="email" value="#VARIABLES.email#" ></cfoutput>
								<div class="confirm-password">
								    <div class="labelContainer"> Confirm-Password </div>
								    <input type="Password" id="cpassword" name="cpassword"  class="input_box" maxlength="16" placeholder="Re-enter password" onblur="rcpassword()">
								    <div id="cpid"></div>
								</div>
		                           <input name="resetPassword" type="Submit" value="Reset Password" id="btn" class="btn" >
							</form>
		            </div>
		     	</div>
			<footer>
				@2018 onlineexam.com/All rights reserved
			</footer>
			<script type="text/javascript" src="../assets/js/resetPassword.js"> </script>
			</body>
		</html>
	</cfif>
</cfif>


