<cfinclude template="../../Includes/studentPageValidate.cfm" />
<cfif NOT isDefined("FORM.startTestBtn")>
	<cflocation addtoken="no" url="studentDashboard.cfm" />
</cfif>
 <!--- <cfif  structKeyExists(SESSION,"startTest") >
	   <cflocation addtoken="no" url="studentDashboard.cfm?errId=2" />
</cfif> --->

<!--- --------------------------------------------------------------------------- --->
<cfset VARIABLES.isActive = APPLICATION.viewDetailsObj.getActivity() />
<!--- It is for checking DB error --->
<cfif VARIABLES.isActive EQ -1>
	<cflocation url="studentDashboard.cfm?errId=1" addtoken="no" />
</cfif>
<!--- Check student is taking the test to another device --->
<cfif VARIABLES.isActive EQ 1>
	<cflocation url="studentDashboard.cfm?errId=2" addtoken="no" />
</cfif>

<!--- ---------------------------------------------------------------------------- --->
<cfset VARIABLES.isAttempt =  APPLICATION.viewDetailsObj.isAttemptTest(FORM.subId) />
<!--- It is for checking DB error --->
<cfif VARIABLES.isAttempt EQ -1>
	<cflocation url="studentDashboard.cfm?errId=1" addtoken="no" />
</cfif>
<!--- Student can attempt a particular test only one time ------------ --->
<cfif VARIABLES.isAttempt GT 0>
	 <cflocation url="studentDashboard.cfm?errId=4" addtoken="no" />
</cfif>
<!--- ------------------------------------------------------------------------------ --->

<!--- Check for test is active or not  --->
<cfset VARIABLES.isStarted =  APPLICATION.viewDetailsObj.getTimeInfo(FORM.subId) />
<cfset VARIABLES.currentTime = #DateTimeFormat(now(), "MM d yyyy HH:nn:ss ")# />

<cfset VARIABLES.seconds = Datediff("s",VARIABLES.currentTime,VARIABLES.isStarted.startTime) />
<cfif VARIABLES.seconds GT 0>
	<!--- Test will active on next time  --->
	<cflocation url="studentDashboard.cfm?errId=5" addtoken="no" />
</cfif>
<cfset VARIABLES.minutes = Datediff("n",VARIABLES.currentTime,VARIABLES.isStarted.endTime) >

<cfif VARIABLES.minutes LT VARIABLES.isStarted.duration >
	<!--- End active test  --->
	<cflocation url="studentDashboard.cfm?errId=6" addtoken="no" />
</cfif>
<!--- --------------------------------------------------------------------------------------- --->


<!--- It is changing the test activity of student so he can`t give test to another device. --->
<cfset VARIABLES.isChangeActive = APPLICATION.takeTestObj.changeActivity() />

<cfif VARIABLES.isChangeActive EQ FALSE>
	<cflocation url="studentDashboard.cfm?errId=1" addtoken="no" />
</cfif>
<cfset SESSION.startTime = #DateTimeFormat(now(), "MM d yyyy HH:nn:ss ")# />
<cfset SESSION.startTest = "true" />
<html>
	<head>
		<title>    Online Test    </title>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
	    <link rel="stylesheet" href="../../assets/css/test.css">
	    <script type="text/javascript" src="../../assets/js/isOnline.js"></script>
	</head>
	<cfset VARIABLES.time = VARIABLES.isStarted.duration />
	<body>
    	<div id="testBody">
                <div class="upper-bar"> ONLINE EXAM SYSTEM</div>
				<div id="container">
				    <div id="heading">
					 	<cfoutput><div class="timer" data-minutes-left="#VARIABLES.time#"></div></cfoutput>
					 	<div class="name" > Name:&nbsp<cfoutput>#SESSION.student.Name#</cfoutput>  </div>
					 	<div class="subject">Subject:&nbsp<cfoutput>#FORM.subId#</cfoutput></div>
				 	</div><br><br>

				 	<cfset VARIABLES.subject = FORM.subId />
				 	<cfoutput><input type="hidden" id="subjectName" value="#VARIABLES.subject#"></cfoutput>

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

