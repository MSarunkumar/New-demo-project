<cfinclude template="../Includes/signupPageValidate.cfm" />
<html>
	<head>
		 <title> Registration Form </title>
 		 <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
         <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">
	     <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
         <link href="../assets/css/index.css"  rel="stylesheet">
	</head>
	<body>
		<div id="signup-main-body">
			<cfinclude template="../Includes/upperBar.cfm" />
			<div id="serverError">  </div>


            <div id="form-area-signup">
		   		<div class="form-header"> New Registration </div>

				<form  id="form" >
		                <div id="s-name">
							<div class="labelContainer"> Name </div>
							<input type="text" id="name" name="name" placeholder="Full Name" class="input_box" maxlength="50" onblur="nameValid()">
							<div id="nid" class="err"></div>
					    </div>

		                <div id="s-email">
							<div class="labelContainer"> Email </div>
							<input type="text" id="email" name="email" placeholder="abc@mindfiresolutions.com" class="input_box" maxlength="50" onblur="emailValid()">
					        <div id= "eid" class="err"></div>
						</div>

						<div id="s-dob">
							<div class="labelContainer"> DOB </div>
							<input type="date" id="date" name="date" class="input_box" onblur="dobValid()">
		                    <div id="did" class="err"></div>
					    </div>

		                <div id="s-mobile">
							<div class="labelContainer"> Phone Number </div>
							<input type="text" id="mobile" name="mobile" class="input_box" maxlength="10" onblur="mobileValid()">
							<div id="mid" class="err"></div>
						</div>

						<div id="s-address">
							<div class="labelContainer"> Address </div>
							<textarea id="address" name="address" placeholder="Address" class="input_box" maxlength="250" onblur="addressValid()"></textarea>
							<div id="aid" class="err"></div>
					    </div>

						<div id="s-password">
							<div class="labelContainer"> Password </div>
							<input type="Password" id="password" name="password"  placeholder="Minimum 8 character" class="input_box" maxlength="16" onblur="passwordValid()">
							<div id="pid" class="err"></div>
		                </div>

						<div id="s-cpassword">
							<div class="labelContainer"> Confirm-Password </div>
						    <input type="Password" id="cpassword" name="cpassword" placeholder="Re-enter password" class="input_box" maxlength="16" onblur="cpasswordValid()">
						    <div  id="cpid" class="err"></div>
						</div>

						<input type="Button" value="Register" class="btn" id="btn" name="submit">
                </form>
	                <h4 id="mandatory">
							[All fields are mandatory]
					</h4>
		 		</div> <br>
		    <cfinclude template="../Includes/footer.cfm" />
			</div>
	  <script type="text/javascript" src="../assets/js/signup.js"> </script>
	</body>
</html>
