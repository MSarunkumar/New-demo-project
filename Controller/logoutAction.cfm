<html>
	<head>
		<title>Logout Action</title>
	</head>
	 <body>

		 <!--- Allow to student for taking the exam. --->
		<cfif isDefined("SESSION.userEmail") >
		<cfset VARIABLES.testStatus = APPLICATION.viewDetailsObj.getActivity() />
		<!--- check student active or not if active then do deactivate so he can take exam --->
			<cfif  VARIABLES.testStatus EQ 1>
				<cfset  APPLICATION.takeTestObj.changeActivity() />
			</cfif>
		</cfif>

        <cfset APPLICATION.logoutObj.logout() />

        <cflocation addtoken = "no" url = "../index.cfm" />
     </body>
</html>