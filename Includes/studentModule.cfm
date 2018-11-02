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
					  <li><a href="scheduledTest.cfm">View Tests</a></li>
					  <li><a href="instruction.cfm">Take Test</a></li>
					  <li><a href="viewMark.cfm">Check Result</a></li>
					  <li><a href="#About us">Abouts us</a></li>
					  <li><a href="#Contact us">Contact us</a></li>
					  <li><a href="#Help">Help</a></li>

		        	</ul>
				</div>