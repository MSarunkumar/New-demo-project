<cfinclude template="../../Includes/studentPageValidate.cfm" />

<html>
	<head>
		<title> Test Instruction </title>
		<cfinclude template="../../Includes/studentModule.cfm" />

			<div class="data-container">

				<div id="ins" >
					<img src="../../assets/image/instructions.jpg" height="100px" width="100px">
				</div>
				<div class="textIns">
					<h1>Instructions:</h1>

					1.&nbsp Once You start the test, you can not pause/resume.<br><br>

					2.&nbsp You can not go to previous questions,So please try to attempt in one go.<br><br>

					3.&nbsp Once you start the test. Don`t press refresh button otherwise your score will be submit immediately.
					 <br><br>



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
     <cfinclude template="../../Includes/footer.cfm" />
    <script type="text/javascript" src="../../assets/js/instruction.js"></script>
	</body>
</html>
