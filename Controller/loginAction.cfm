<html>
	<head>
		<title>Login Action</title>
	</head>
	<body>
		<!---  <cfdump var = "#FORM#"> --->
		<cfif isDefined("FORM.login") >

			   <cfset VARIABLES.valid = TRUE />

			   <!------  It will check email formate    ----------->
			   <cfif NOT isValid("regex", trim(FORM.uid),"^([a-zA-Z0-9_\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$")>
				         <cfset VARIABLES.valid = FALSE />
			   </cfif>

			   <!------- It will check password formate ----------------------->
			   <cfif NOT (len(FORM.password) GTE 8 AND refind('[A-Z]',FORM.password)
				     AND refind('[a-z]',FORM.password) AND refind('[0-9]',FORM.password)
				     AND refind('[!@##$&* = -{}<>,.:;|?""''~]',FORM.password ) )>
                         <cfset VARIABLES.valid = FALSE />
				</cfif>

				<!--- If email/password formate is good than go to if block  --->
			    <cfif  VARIABLES.valid EQ TRUE >

				    <cfset VARIABLES.record = APPLICATION.signupObj.emailExist(FORM.uid) />
				    <!---   <cfdump var = "#VARIABLES.record#"><cfabort>   --->

				    <cfif VARIABLES.record EQ -1>
					   <cflocation url = "../index.cfm?errID=4" addToken = "no" />
				    </cfif>

				    <cfif VARIABLES.record EQ 1 >

                            <cfset VARIABLES.pass = APPLICATION.loginObj.getPassword(FORM.uid) />

							<cfset VARIABLES.salt = APPLICATION.loginObj.getSalt(FORM.uid) />
	                        <cfset VARIABLES.hashedPassword = Hash(FORM.password & VARIABLES.salt, "SHA-512") />

							<cfif compare(VARIABLES.hashedPassword,VARIABLES.pass) EQ 0>
								    <cfset VARIABLES.role = APPLICATION.loginObj.getRole(FORM.uid) />

								    <cfset SESSION.userEmail = FORM.uid>

								    <cfif VARIABLES.role EQ "student">
								        <cfset VARIABLES.status = APPLICATION.loginObj.getStatus(FORM.uid) />

									    <cfif VARIABLES.status EQ 0 >
										  <cflocation url = "../index.cfm?errID=7" addToken = "no" />
										</cfif>

										<cfif VARIABLES.status EQ -1 >
										  <cflocation url = "../index.cfm?errID=4" addToken = "no" />
										</cfif>

									    <cfset SESSION.student = "valid">
										<cflocation url = "../view/student/studentDashboard.cfm" addToken = "no" />
									<cfelse>
									    <cfif VARIABLES.role EQ "admin">

									    <cfset SESSION.admin = "valid">
									      <cflocation url = "../view/admin/adminDashboard.cfm" addToken = "no" />
									    <cfelse>
									      <cflocation url = "../index.cfm?errID=8" addToken = "no" />
										</cfif>

									</cfif>
							  <cfelse >
								    <cflocation url = "../index.cfm?errID=3" addToken = "no" />
							  </cfif>
					  <cfelse>
                            <cflocation url = "../index.cfm?errID=2" addToken = "no" />
				      </cfif>
			  <cfelse>
				      <cflocation url = "../index.cfm?errID=1" addToken = "no" />
			  </cfif>
		  <cfelse>
			  <cflocation url = "../error/error.cfm" addToken = "no" />
		  </cfif>
	</body>
</html>
