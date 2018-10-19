<html>
	<head>
		<title>
			Logout Action
		</title>
	</head>
	 <body>
        <cfset VARIABLES.logout = APPLICATION.logoutObj.logout() />
        <cflocation addtoken = "no" url = "../index.cfm" />
     </body>
</html>