<cfinclude template="../../Includes/studentPageValidate.cfm" />

<cfif NOT isDefined("FORM.startTestBtn")>
	<cflocation addtoken="no" url="studentDashboard.cfm" />
</cfif>

<!--- -----------------------------------------------     for multiple device  --->
<cfset VARIABLES.isActive = APPLICATION.viewDetailsObj.getActivity() />
<!--- It is for checking DB error --->
<cfif VARIABLES.isActive EQ -1>
	<cflocation url="studentDashboard.cfm?errId=1" addtoken="no" />
</cfif>
<!---  student is taking the test to another device   --->
<cfif VARIABLES.isActive EQ 1>
	<cflocation url="studentDashboard.cfm?errId=2" addtoken="no" />
</cfif>
<!--- ----------------------------------------------------------------------- --->

<!--- ---------------------------------------------  It will check this test is active or not  --->
<cfset VARIABLES.activeTestId = APPLICATION.viewDetailsObj.getActiveTestId(FORM.subId) />

<!---  Test is active or not    -------------------------- --->
<cfif VARIABLES.activeTestId EQ 0>
	 <cflocation url="studentDashboard.cfm?errId=8" addtoken="no" />
</cfif>
<cfset VARIABLES.testInfo = APPLICATION.viewDetailsObj.getTestInfo(VARIABLES.activeTestId) />
<!--- ---  Check DB error   --->
<cfif isDefined("VARIABLES.testInfo.errID") >
	<cfif VARIABLES.testInfo.errID EQ -1>
		<cflocation url = "studentDashboard.cfm?errID=1" addtoken = "no">
	</cfif>
</cfif>
<!--- ------------------------------------------------------------------------------------ --->


<!--- ------------------   One test for a subject depend on admin if allow for multiple tests  --->
<cfset VARIABLES.isAttempt =  APPLICATION.viewDetailsObj.isAttemptTest(VARIABLES.activeTestId) />

<!--- It is for checking DB error --->
<cfif VARIABLES.isAttempt EQ -1>
	<cflocation url="studentDashboard.cfm?errId=1" addtoken="no" />
</cfif>
<!--- check student is already attempted or not if yes then check admin allow or not  --->

<cfif VARIABLES.isAttempt GT 0>

    <cfset VARIABLES.isAllowed = APPLICATION.viewDetailsObj.isAllow(VARIABLES.activeTestId) />
	<!--- Check DB error  ----  --->
	<cfif VARIABLES.isAllowed EQ -1>
		<cflocation url="studentDashboard.cfm?errId=1" addtoken="no" />
	</cfif>

	<cfif VARIABLES.isAllowed EQ 1>
		<cflocation url="studentDashboard.cfm?errId=4" addtoken="no" />
	</cfif>


 </cfif>


<!--- ------------------------------------------ Get the current time from server and set test duration --->
<cfset VARIABLES.currentTime = APPLICATION.takeTestObj.getCurrentTime() />
<!--- Set the current time in session for tracking the student spent time in test --->
<cfset SESSION.startTime = VARIABLES.currentTime />
<cfset VARIABLES.minute = Datediff("n",VARIABLES.testInfo.startTime,VARIABLES.currentTime) />
<cfset VARIABLES.testDuration = (VARIABLES.testInfo.duration - VARIABLES.minute)/>
<!--- --------------------------------------------------------------------------------------- --->

<!--- It is changing the test activity of student so he can`t give test to another device. --->
<cfset VARIABLES.isChangeActive = APPLICATION.takeTestObj.changeActivity() />
<!--- check DB error --->
<cfif VARIABLES.isChangeActive EQ FALSE>
	<cflocation url="studentDashboard.cfm?errId=1" addtoken="no" />
</cfif>


<html>
	<head>
		<title>    Online Test    </title>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
	    <link rel="stylesheet" href="../../assets/css/test.css">
	    <script type="text/javascript" src="../../assets/js/isOnline.js"></script>
	</head>

	<body>
    	<div id="testBody">
                <div class="upper-bar"> ONLINE EXAM SYSTEM</div>
				<div id="container">
				    <div id="heading">
					 	<cfoutput><div class="timer" data-minutes-left="#VARIABLES.testDuration#"></div>
					 	<div class="name" > Name:&nbsp#SESSION.student.Name#  </div>
					 	<div class="subject">Subject:&nbsp#FORM.subId#</cfoutput></div>
				 	</div><br><br>
				 	<cfoutput>
					 	<input type="hidden" id="subjectName" value="#FORM.subId#">
						<input type="hidden" id="totalQuestion" value="#VARIABLES.testInfo.totalQuestion#">
					    <input type="hidden" id="testId" value="#VARIABLES.activeTestId#">
					</cfoutput>

					<div id="ques" > </div>
                    <div id="btn">
					<input type="button" value="Next" name="nextBtn" id="nextBtn">
		            <input type="hidden" id="answer" name="answer">
					<input type="button" value="Submit Test" id="submitBtn" name="submitBtn">
					</div>
				</div>
		</div>
	 <cfinclude template="../../Includes/footer.cfm" />
	<script type="text/javascript" src="../../assets/js/getQuestion.js"></script>
    <script type="text/javascript" src="../../assets/js/countdownTimer.js"></script>
	</body>
</html>

