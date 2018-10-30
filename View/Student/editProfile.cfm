<cfinclude template="../../Includes/studentPageValidate.cfm" />
<html>
	 <head> <title> Edit Profile </title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
		<cfinclude template="../../Includes/studentModule.cfm" />

			<div class="data-container">
				<center><h1><br>Edit Profile <br></h1></center>
				<cfset VARIABLES.dob= DateFormat(SESSION.student.dob, "yyyy-MM-dd") />
                <cfoutput>
				<form  id="form" >
		                <div id="s-name">
							<div class="labelContainer"> Name </div>
							<input type="text" id="name" name="name" value="#SESSION.student.Name#" class="input_box" maxlength="50" onblur="nameValid()">
							<div id="nid" class="err"></div>
					    </div>

		                <div id="s-email">
							<div class="labelContainer"> Email </div>
							<input type="text" id="email" name="email" value="#SESSION.userEmail#"class="input_box" maxlength="50"  disabled="disabled">
					        <div id= "eid" class="err"></div>
						</div>

						<div id="s-dob">
							<div class="labelContainer"> DOB </div>
							<input type="date" id="date" name="date" class="input_box" value="#VARIABLES.dob#" onblur="dobValid()" >
		                    <div id="did" class="err"></div>
					    </div>

		                <div id="s-mobile">
							<div class="labelContainer"> Phone Number </div>
							<input type="text" id="mobile" name="mobile" value="#SESSION.student.phone#" class="input_box" maxlength="10" onblur="mobileValid()">
							<div id="mid" class="err"></div>
						</div>

						<div id="s-address">
							<div class="labelContainer"> Address </div>
							<textarea id="address" name="address"  class="input_box" maxlength="250" onblur="addressValid()">#SESSION.student.address#</textarea>
							<div id="aid" class="err"></div>
					    </div>

						<input type="Button" value="Edit Profile" class="btn" id="editBtn" name="submit">
                </form>
                </cfoutput>
		 		</div>
		</div><br>
	</div>
	 <cfinclude template="../../Includes/footer.cfm" />
	 <script src="../../assets/js/editProfile.js" type="text/javascript"></script>
	</body>
</html>
