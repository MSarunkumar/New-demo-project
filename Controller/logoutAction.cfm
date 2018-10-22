<html>
	<head>
		<title>
			Logout Action
		</title>
	</head>
	 <body>
		<cfif isDefined("SESSION.userEmail") >
		<cfset VARIABLES.testStatus = APPLICATION.viewDetailsObj.getActivity() />
		<cfif  VARIABLES.testStatus EQ 1>
			<cfset  APPLICATION.takeTestObj.changeActivity() />
		</cfif>
		</cfif>
        <cfset APPLICATION.logoutObj.logout() />
        <cflocation addtoken = "no" url = "../index.cfm" />
     </body>
</html>