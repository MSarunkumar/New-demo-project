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
				                "Your score successfully submited.Please check your result.@.. [GOOD LUCK]"
				                 ]>
				<cfif isdefined("URL.errID")>
					<cfif URL.errId EQ 1> <cfoutput>#errorArray[1]#</cfoutput> </cfif>
					<cfif URL.errId EQ 2> <cfoutput>#errorArray[2]#</cfoutput> </cfif>
					<cfif URL.errId EQ 3> <cfoutput>#errorArray[3]#</cfoutput> </cfif>
				<cfelse>
				</cfif>
			 </div>
		     <div id="testIcon">
				 <a href="instruction.cfm">
			     <img src="../../assets/icon/takeTest.png" height="150px" width="400px;"><br>
			     </a>
			</div><br>
		     <div id="resultIcon">
				 <a href="viewMark.cfm">
			     <img src="../../assets/icon/checkResult.png" height="150px" width="400px;">
				 </a>
			</div>
			</div>
		</div><br>
	</div>
	 <cfinclude template="../../Includes/footer.cfm" />
	</body>
</html>
