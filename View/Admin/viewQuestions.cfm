<cfinclude template="../../Includes/adminPageValidate.cfm" />
<html>
	<head>
		<title>Question View</title>
		<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
		<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
		<link href="../../assets/css/onlineExam.css" rel="stylesheet">
		<script src="../../assets/js/viewQuestions.js" type="text/javascript" ></script>
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
					  <li id="user-img"><img src="../../assets/image/admin.png" height="50px" width="50px">
						<br>ADMIN
					  </li>
					  <li><a href="adminDashboard.cfm">Dashboard</a></li>
					  <li><a href="viewStudents.cfm">Students</a></li>
					  <li><a href="viewMarks.cfm">Results</a></li>
					  <li><a href="viewQuestions.cfm">Questions</a></li>
					  <li><a href="addQuestion.cfm">Add Question</a></li>
					  <li><a href="#contactUs">Contact us</a></li>
					  <li><a href="#About Us">About us</a></li>
					  <li><a href="#help">Help</a></li>
					  <li id="last-elt">.</li>
			        </ul>
				</div>

				<div class="data-container">
					<center><h1>Question View </h1><center>
	                <cfset LOCAL.questions = APPLICATION.viewDetailsObj.getQuestions() />
	                <table id="tableId" class="cell-border order-column  stripe hover">
						<thead>
							<tr>
                                <th>Subject</th>
								<th>Question</th>
								<th>Option1</th>
								<th>Option2</th>
								<th>Option3</th>
								<th>Option4</th>
								<th>Answer</th>
 							</tr>
						 </thead>
						 <tbody>
							 <cfoutput query="LOCAL.questions">
								 <tr>
									 <td>#subject#</td>
									 <td>#question#</td>
									 <td>#option1#</td>
									 <td>#option2#</td>
									 <td>#option3#</td>
									 <td>#option4#</td>
									 <td>#answer#</td>

								 </tr>
							 </cfoutput>
						 </tbody>
					</table><br><br>
				</div>
			</div><br>
	    </div>
	    <footer>
		 	@2018 onlineexam.com/All rights reserved
        </footer>
	</body>
</html>