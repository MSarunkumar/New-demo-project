<cfinclude template="../../Includes/studentPageValidate.cfm" />


<html>
	<head>
		<title> Student Result </title>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
		<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
		<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
        <link rel="stylesheet" href="../../assets/css/onlineExam.css">
		<script src="../../assets/js/viewQuestions.js" type="text/javascript"></script>

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
		        	<center><h1>Your Result</h1></center>

			 		<cfset LOCAL.mark = APPLICATION.viewDetailsObj.getMark() />
					<table id="tableId" class="cell-border order-column  stripe hover">
						<thead>
							<tr>
							   <th>Test           </th>
							   <th>Score          </th>
							   <th>Total Questions</th>
							   <th>Start Time     </th>
							   <th>End Time	      </th>
		                    </tr>
						</thead>

						<tbody>
							<cfoutput query="mark">
								<tr>
									<td>#Subject#      </td>
									<td>#score#	       </td>
									<td>#totalQuestion#</td>
									<td>#startDate#    </td>
									<td>#endDate#      </td>
								</tr>
							</cfoutput>
						</tbody>
					</table>
	        	</div>
			</div><br>
		</div>
	<footer>
		@2018 onlineexam.com/All rights reserved
	</footer>
    </body>
</html>
