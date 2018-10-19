<cfinclude template="../../Includes/adminPageValidate.cfm" />
<html>
	<head>
		<title>Student View</title>
		<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	    <link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet">
	    <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
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
				  <li><a href="#contactUs">Contact us</a></li>
				  <li><a href="#About Us">About us</a></li>
				  <li><a href="#help">Help</a></li>
				  <li id="last-elt">.</li>
		        </ul>
			</div>

			<div class="data-container">
				<center><h1>Students detail </h1></center>
				<div class="serverSideError"></div>


				<cfset variables.student = APPLICATION.viewDetailsObj.getStudents() />

                <table id="tableId" class="cell-border order-column  stripe hover">
                   <thead>
						<tr>
					   	    <th>Name</th>
							<th>Email</th>
							<th>Dob</th>
							<th>Mobile</th>
						    <th>Address Line</th>
						    <th>Status</th>
						 </tr>
					 </thead>
					 <tbody>
						 <cfoutput query="variables.student">
							 <tr>
								 <td>#Name#</td>
								 <td>#email#</td>
								 <td>#DateFormat(dob,"long")#</td>
								 <td>#phone#</td>
								 <td>#address#</td>

								 <td>
									 <cfif  #status# EQ 0>
										 <input type="button" class="actionButton btn-red" id="blockButton" onClick="javascript:getStatus('#email#', this);" value="Block" />
									<cfelse>
										<input type="button" class="actionButton btn-green" id="blockButton" onClick="javascript:getStatus('#email#', this);" value="Unblock" />
									</cfif>

								 </td>

							 </tr>
						 </cfoutput>
					  </tbody>
                  </table>
         		</div><br>
			</div>

	<footer>
		@2018 onlineexam.com/All rights reserved
    </footer>
	<script src="../../assets/js/statusStudent.js" type="text/javascript"></script>
	</body>
</html>