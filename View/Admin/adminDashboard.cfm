<cfinclude template="../../Includes/adminPageValidate.cfm" />
<html>
	<head>
		<title>Admin Dashboard</title>
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
						  <li id="user-img"><img src="../../assets/image/admin.png" height="50px" width="50px;">
							<br>ADMIN
						  </li>
						  <li><a href="adminDashboard.cfm">Dashboard</a></li>
						  <li><a href="viewStudents.cfm">Students</a></li>
						  <li><a href="viewMarks.cfm">Results</a></li>
						  <li><a href="viewQuestions.cfm">Questions</a></li>
						  <li><a href="addQuestion.cfm">Add Question</a></li>
						  <li><a href="#About Us">About us</a></li>
						  <li><a href="#contactUs">Contact us</a></li>
						  <li><a href="#help">Help</a></li>
						  <li id="last-elt">.</li>
				        </ul>
					 </div>

		             <div class="data-container">
	                    <center><h1> admin dashboard</h1></center>
		             </div>
		  		</div><br>
          </div>
	 <footer>
		@2018 onlineexam.com/All rights reserved
     </footer>
	 </body>
</html>
