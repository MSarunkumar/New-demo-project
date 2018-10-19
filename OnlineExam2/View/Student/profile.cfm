<cfinclude template="../../Includes/studentPageValidate.cfm" />

<html>
	<head>
		<title> Student Profile</title>
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
					  <li id="user-img"><img src="../../assets/image/student.svg" height="50px" width="50px"><br>
					   <cfoutput>#SESSION.student.Name#</cfoutput>
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
		     		<center><h1>Your   Profile</h1></center>
	                <div id="profile-container">
	                   <cfoutput>
						    Name ::&nbsp &nbsp #SESSION.student.Name# <br><br>
				            Mobile ::&nbsp #SESSION.student.phone# <br><br>
				            Email ::&nbsp &nbsp #SESSION.student.email# <br><br>
				            Address ::&nbsp &nbsp #SESSION.student.address# <br><br>
	                    </cfoutput>
                    </div>
                 </div>
		    </div><br>
		</div>

	<footer>
		@2018 onlineexam.com/All rights reserved
	</footer>
	</body>
</html>
