<cfinclude template="../../Includes/adminPageValidate.cfm" />


<html>
	<head>
		<title>Adding Question</title>
		<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
					    <div id="heading"> Add Question</div>

					    <div class="serverSideError">
						    <cfset errorArray = ["Question added successfully ..!!!"] />
						    <cfif isDefined("URL.errID") >
								<cfif URL.errID EQ 1>
									<cfoutput>#errorArray[1]# </cfoutput>
								</cfif>
							<cfelse>
						    </cfif>
					    </div>
			        	<form id="form" >

							<div class="container">
                                <div class="label-container"> Please select subject </div>
                                <select  id="subID" name="subId"   class="input-box" onChange="subValid()">
                                    <option  value="0"> Choose Subject   </option>
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

							<div class="container">
                                <div class="label-container"> Question </div>
								<textarea id="quesId" name="quesId" rows="4" placeholder="Question Description" class="input-box" maxlength="900" onblur="quesValid()"></textarea>
								<div id="qid" class="error"> </div>
							</div>

                            <div class="container">
								<div class="label-container">Option 1:</div>
							    <textarea id="op1" name="op1" placeholder="First Option" class="input-box" maxlength="250" onblur="op1Valid()"></textarea>
							    <div id= "oid1" class="error"> </div>
							</div>

                            <div class="container">
                            	<div class="label-container">Option 2:</div>
                                <textarea id="op2" name="op2" placeholder="Second Option" class="input-box" maxlength="250" onblur="op2Valid()"></textarea>
							    <div id="oid2" class="error"> </div>
                            </div>

							<div class="container">
                            	<div class="label-container">Option 3:</div>
						        <textarea id="op3" name="op3" class="input-box" placeholder="Third Option" maxlength="250" onblur="op3Valid()"></textarea>
							    <div id="oid3" class="error"> </div>
							</div>

							<div class="container">
                            	<div class="label-container">Option 4:</div>
							    <textarea id="op4" name="op4" placeholder="Fourth Option" class="input-box" maxlength="250" onblur="op4Valid()"></textarea>
							    <div id="oid4" class="error"></div>
                             </div>

							<div class="container">
								<div class="label-container">Please select answer</div>
							    <select  id="ansID" name="ansId"   class="input-box" onChange="ansValid()">
									<option  value="0">Choose Answer</option>
									<option  value="1">	Option 1 </option>
									<option  value="2"> Option 2 </option>
							        <option  value="3"> Option 3 </option>
									<option  value="4"> Option 4 </option>
								</select>
								<div id="aid" class="error"></div>
							</div>
                            <input type="Button" value="Add Question" class="btn" name="submit" id="add">
							<input type="Reset" value="Reset" class="btn" name="reset" id="resetBtn">
					    </form><br>
		         </div>
		   </div><br>
	 <footer>
		@2018 onlineexam.com/All rights reserved
     </footer>
	 <script type="text/javascript" src="../../assets/js/addQuestion.js"> </script>
	 </body>
</html>








