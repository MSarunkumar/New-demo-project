<cfinclude template="../../Includes/studentPageValidate.cfm" />
<cfset SESSION.student = APPLICATION.viewDetailsObj.getStudent(SESSION.userEmail) />
<html>
	<head>
		<title> Student Dashboard</title>
		<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
		<link href="../../assets/css/onlineExam.css" rel="stylesheet">
	</head>

	<body>
	<div id="main-body">
        <div class="upper-bar">
			<div id="left-elt"> ONLINE EXAM SYSTEM </div>
            <div id="right-elt">
              <a href="../../Controller/logoutAction.cfm" >
		        <img src="../../assets/icon/logout1.png" align="right" width="50px" height="50px" title="LOGOUT">
		      </a>
            </div>
		</div>
		<div class="grid-container">
			<div class="side-bar">
				<ul>
				  <li id="user-img"><img src="../../assets/image/student.svg" height="50px" width="50px;">
				  <br><cfoutput>#SESSION.student.Name#</cfoutput>
				  </li>
				  <li><a href="studentDashboard.cfm">Dashboard</a></li>
				  <li><a href="profile.cfm">Profile</a></li>
				  <li><a href="viewMark.cfm">Result</a></li>
				  <li><a href="instruction.cfm">Take Test</a></li>
				  <li><a href="#About us">Abouts us</a></li>
				  <li><a href="#Contact us">Contact us</a></li>
				  <li><a href="#Help">Help</a></li>
				  <li id="last-elt">.</li>
		        </ul>
			</div>

			<div class="data-container">
		     <center><h1><br>Welcome:&nbsp <cfoutput>#SESSION.student.Name#</cfoutput><br></h1></center>
		     <div class="serverSideError">
			 <cfset errorArray=["Internal problem.Please try again",
				                "Your test is already started.
				                So please complete that before starting a new test."]>
				<cfif isdefined("URL.errID")>
					<cfif URL.errId EQ 1> <cfoutput>#errorArray[1]#</cfoutput> </cfif>
					<cfif URL.errId EQ 2> <cfoutput>#errorArray[2]#</cfoutput> </cfif>
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
	<footer>
		@2018 onlineexam.com/All rights reserved
    </footer>
	</body>
</html>
