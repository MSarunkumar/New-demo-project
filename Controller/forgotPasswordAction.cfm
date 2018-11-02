<html>
	<head>
		<title>
		Forgot Password Action
		</title>
	</head>
	<body>
			 <!--- <cfdump var = "#FORM#" abort="true"> --->
		<cfif isDefined("FORM.send") >

			<cfset VARIABLES.valid = TRUE />
			<!---    Check email format    --------------------------->
			<cfif NOT isValid("regex", trim(FORM.uid),"^([a-zA-Z0-9_\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$")>
				<cfset VARIABLES.valid = FALSE />
			</cfif>

			<cfif VARIABLES.valid EQ TRUE >

	    		<cfset VARIABLES.record = APPLICATION.signupObj.emailExist(FORM.uid) />

				<cfif VARIABLES.record EQ 0>
					<cflocation url = "../view/forgotPassword.cfm?errId=1" addToken = "no" />
				<cfelse>
                     <cfset SESSION.passwordId = FORM.uid />
			  		 <cfset VARIABLES.emailExist = APPLICATION.forgotPasswordObj.emailExist(FORM.uid) />

					 <cfif VARIABLES.emailExist EQ -1>
						<cflocation url="../view/forgotPassword.cfm?errId=4">
					 </cfif>

			         <cfset VARIABLES.guid = APPLICATION.forgotPasswordObj.getGuid() />
 <!--- -----------------------------------------------------------------------         --->
			         <cfset VARIABLES.submitStatus = APPLICATION.forgotPasswordObj.submitData(FORM.uid,VARIABLES.guid) />
                        <cfif VARIABLES.submitStatus EQ FALSE>
					     <cflocation url = "../view/forgotPassword.cfm?errId=4" addtoken = "no" />
					 </cfif>
<!--- ---------------------------------------------------------------------------- ---->
                     <cfset VARIABLES.mail = APPLICATION.forgotPasswordObj.sendEmail("arunyc2@gmail.com",FORM.uid,VARIABLES.guid) />
           			 <cflocation url = "../view/forgotPassword.cfm?errId=3" addToken = "no" />
				</cfif>
		    <cfelse>
				<cflocation url = "../view/forgotPassword.cfm?errId=2" addToken = "no" />
			</cfif>
		<cfelse>
			<cflocation url = "../error/error.cfm" addToken = "no" />
		</cfif>
	</body>
</html>

