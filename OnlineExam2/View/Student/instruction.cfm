<cfinclude template="../../Includes/studentPageValidate.cfm" />

<html>
	<head>
		<title> Test Instruction </title>
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

				<div id="ins" >
					<img src="../../assets/image/instructions.jpg" height="100px" width="100px">
				</div>
				<div class="textIns">
					<h1>Instructions:</h1>

					1.&nbsp Once You start the test, you can not pause/resume.<br><br>

					2.&nbsp You can not go to previous questions,So please try to attempt in one go.<br><br>

					3.&nbsp Once you start the test. Don`t press refresh button otherwise your score will not be acceptted.
					  and you have to login again for taking the test.<br><br>



				<form action="takeTest.cfm" onSubmit="return subValid() " method="post">
					<div class="container">
						<div class="label-container"> Please select test </div>
						<select  id="subId" name="subId"   class="input-box" onChange="subValid()">
							<option  value="0"> Choose Test      </option>
							<option  value="Math">    Math	     </option>
							<option  value="English"> English    </option>
							<option  value="Science"> Science    </option>
							<option  value="Computer">Computer   </option>
							<option  value="Physics"> Physics    </option>
							<option  value="Chemistry">Chemistry </option>
							<option  value="Reasoning">Reasoning </option>
						</select>
						<div id="sid" class="error"> </div>
					</div>
			    <div id="test">
			    <input type="Submit" id="btn" name="startTestBtn" value="Start Test" class="btn" >
			   </div>
		    </form><br>
	      </div><br>
	      </div><br>
    </div>
    <footer>
		@2018 onlineexam.com/All rights reserved
    </footer>
    <script type="text/javascript" src="../../assets/js/instruction.js"></script>
	</body>
</html>
