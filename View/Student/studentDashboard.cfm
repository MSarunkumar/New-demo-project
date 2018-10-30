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
			 <cfset errorArray=["Internal problem.Please try again",
				                "Your test is already started.
				                 So please complete that before starting a new test.[Or login again]",
				                "Your score successfully submited.Please check your result.@.. [GOOD LUCK]",
				                "You have already attempted this test.You can attempt one test only for a subject",
				                "Please wait,Test will be active at","Test has been deactivate.You late more than 10 minute"
				                , "Profile updated successfully"]>
				<cfif isdefined("URL.errID")>
					<cfif URL.errId EQ 1> <cfoutput>#errorArray[1]#</cfoutput> </cfif>
					<cfif URL.errId EQ 2> <cfoutput>#errorArray[2]#</cfoutput> </cfif>
					<cfif URL.errId EQ 3> <cfoutput>#errorArray[3]#</cfoutput> </cfif>
					<cfif URL.errId EQ 4> <cfoutput>#errorArray[4]#</cfoutput> </cfif>
					<cfif URL.errId EQ 5>
						<cfoutput>#errorArray[5]#&nbsp::&nbsp#SESSION.isStarted.startTime# </cfoutput> </cfif>
					<cfif URL.errId EQ 6><cfoutput>#errorArray[6]#</cfoutput> </cfif>
					<cfif URL.errId EQ 7><cfoutput>#errorArray[7]#</cfoutput> </cfif>
				<cfelse>
				</cfif>
			 </div>

		     <div class="testIcon">
				 <a href="instruction.cfm">
			     <img src="../../assets/icon/takeTest.png" height="135px" width="270px;">
			     </a>
			</div>
		     <div class="resultIcon">
				 <a href="viewMark.cfm">
			     <img src="../../assets/icon/checkResult.png" height="135px" width="270px;">
				 </a>
			</div>
			 <div class="testIcon">
				 <a href="Profile.cfm">
			     <img src="../../assets/icon/viewProfile.png" height="135px" width="270px;">
				 </a>
			</div>
			 <div class="resultIcon">
				 <a href="scheduledTest.cfm">
			     <img src="../../assets/icon/viewTests.png" height="135px" width="270px;">
				 </a>
			</div>
			</div>
		</div><br>
	</div>
	 <cfinclude template="../../Includes/footer.cfm" />
	</body>
</html>
