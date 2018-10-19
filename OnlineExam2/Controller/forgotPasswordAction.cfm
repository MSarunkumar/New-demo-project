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
			<!---    Check email format    --->
			<cfif NOT isValid("regex", trim(FORM.uid),"^([a-zA-Z0-9_\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$")>
				<cfset VARIABLES.valid = FALSE />
			</cfif>

			<cfif VARIABLES.valid EQ TRUE >

	    		<cfset VARIABLES.record = APPLICATION.signupObj.emailExist(FORM.uid) />

				<cfif VARIABLES.record EQ 0>
					<cflocation url = "../view/forgotPassword.cfm?errId=1" addToken = "no" />
				<cfelse>
                     <cfset SESSION.passwordId = FORM.uid />
                     <cfset APPLICATION.FP = CreateObject("component", "OnlineExam2.Model.forgotPassword") />

			  		 <cfset VARIABLES.emailExist = APPLICATION.FP.emailExist(FORM.uid) />

					 <cfif VARIABLES.emailExist EQ -1>
						<cflocation url="../view/forgotPassword.cfm?errId=4">
					 </cfif>
<!---  It will delete record if already exist    -------------------------------------->
	                 <cfif VARIABLES.emailExist NEQ 0>
				     	<cfset VARIABLES.delete = APPLICATION.FP.deleteRecord(FORM.uid) />
<!---  It is for catch block [record deleted or not] --------------------------------->
				     	<cfif VARIABLES.delete EQ FALSE>
					       <cflocation url="../view/forgotPassword.cfm?errId=4">
					    </cfif>
				     </cfif>

			         <cfset VARIABLES.guid = APPLICATION.FP.getGuid() />
<!---  ---------------------------------------------------------------------------- --->
			         <cfset VARIABLES.submitStatus = APPLICATION.FP.submitData(FORM.uid,VARIABLES.guid) />
                        <cfif VARIABLES.submitStatus EQ FALSE>
					     <cflocation url="../view/forgotPassword.cfm?errId=4">
					 </cfif>
<!--- ---------------------------------------------------------------------------- ---->
                     <cfset VARIABLES.mail = APPLICATION.FP.sendEmail("arunyc2@gmail.com",FORM.uid,VARIABLES.guid) />
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

