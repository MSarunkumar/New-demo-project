<cfinclude template="../../Includes/studentPageValidate.cfm" />
<cfset SESSION.student = APPLICATION.viewDetailsObj.getStudent(SESSION.userEmail) />
<cfif isDefined("SESSION.student.errID") >
	<cfif SESSION.student.errID EQ -1>
		<cflocation url = "../../index.cfm?errID=4" addtoken = "no">
	</cfif>
</cfif>
<html>
	<head>
		<title> Student Dashboard</title>
		<cfinclude template="../../Includes/studentModule.cfm" />

			<div class="data-container">
			     <center><h1><br>Welcome:&nbsp <cfoutput>#SESSION.student.Name#</cfoutput><br></h1></center>

			     <div class="serverSideError">
				 <cfset VARIABLES.errorArray=["Internal problem.Please try again",
					                "Your test is already started.
					                 So please complete that before starting a new test.[Or login again]",
					                "Your score successfully submited.Please check your result.",
					                "You have already attempted this test.You can attempt one test only for a subject",
					                "Please wait,Test will be active.","Test has been deactivate."
					                , "Profile updated successfully","There is no test of this subject for you"]>
					<cfif isdefined("URL.errID")>
						<cfif URL.errID GTE 1 AND URL.errID LTE 8 >
							<cfoutput>#VARIABLES.errorArray[URL.errID]#</cfoutput>
						</cfif>
					<cfelse>
					</cfif>
				 </div>
			     <div class="testIcon">
					 <a href="scheduledTest.cfm">
				     <img src="../../assets/icon/viewTests.png" height="135px" width="270px;">
					 </a>
				</div>
			     <div class="resultIcon">
				     <a href="instruction.cfm">
				     <img src="../../assets/icon/takeTest.png" height="135px" width="270px;">
				     </a>

				</div>
				 <div class="testIcon">
					 <a href="viewMark.cfm">
				     <img src="../../assets/icon/checkResult.png" height="135px" width="270px;">
					 </a>

				</div>
				 <div class="resultIcon">
					 <a href="Profile.cfm">
				     <img src="../../assets/icon/viewProfile.png" height="135px" width="270px;">
					 </a>
				</div>
			</div>
		</div><br>
	</div>
	 <cfinclude template="../../Includes/footer.cfm" />
	</body>
</html>
