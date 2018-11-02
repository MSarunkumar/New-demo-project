<html>
	<head>
		<title>
			Reset Password Action
		</title>
	</head>
	<body>

		<cfif isDefined("FORM.resetPassword") >

			<cfset VARIABLES.valid = TRUE />
			<!-----   Check the format of password  ----->
            <cfif NOT (len(FORM.password) GTE 8 AND refind('[A-Z]',FORM.password)
				  AND refind('[a-z]',FORM.password) AND refind('[0-9]',FORM.password)
				  AND refind('[!@##$&* = -{}<>,.:;|?""''~]',FORM.password ) )>
				<cfset VARIABLES.valid = FALSE />
			</cfif>

			<cfif compare(FORM.password,FORM.cpassword) NEQ 0 >
				<cfset VARIABLES.valid = FALSE />
			</cfif>
            <cfif VARIABLES.valid EQ TRUE >
<!--- ------------------------------------------------------------------------------------------- --->
                <cfset VARIABLES.salt = Hash(GenerateSecretKey("AES"), "SHA-512") />
	            <cfset VARIABLES.hashedPassword = Hash(FORM.password & VARIABLES.salt, "SHA-512") />
<!--- ------------------------------------------------------------------------------------------- --->
                <cfset VARIABLES.updateStatus = APPLICATION.forgotPasswordObj.resetPassword(FORM.email,VARIABLES.hashedPassword,VARIABLES.salt) />
				<cfif VARIABLES.updateStatus EQ FALSE>
				 <cflocation url="../index.cfm?errId=4" addtoken="no" />
			    </cfif>
                <cflocation url="../index.cfm?errId=6" addtoken="no" />
			<cfelse>
				<cflocation url="../view/resetPassword.cfm?errId=1" addtoken="no" />
			</cfif>
			<cfelse>
			    <cflocation url = "../error/error.cfm" addToken = "no" />
		</cfif>
	</body>
</html>



