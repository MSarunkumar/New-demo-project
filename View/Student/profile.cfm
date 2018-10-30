<cfinclude template="../../Includes/studentPageValidate.cfm" />
<html>
	<head>
		<title> Student Profile</title>
		<cfinclude template="../../Includes/studentModule.cfm" />

				<div class="data-container">
		     		<center><h1>Your   Profile</h1></center>
		     		<div id="editProfile">
                    <a href="editProfile.cfm">
						<img src="../../assets/icon/editProfile.png" height="110" width="110" title="Edit Profile"></a>
					</div>

	                <div id="profile-container">
	                   <cfoutput>
						    Name ::&nbsp &nbsp #SESSION.student.Name# <br>
				            Mobile ::&nbsp #SESSION.student.phone# <br>
				            Email ::&nbsp &nbsp #SESSION.student.email# <br>
				            Address ::&nbsp  #SESSION.student.address# <br><br>
	                    </cfoutput>
                    </div>


					<!---      Carousel tutorials     --------------------------------------- --->
					<div class="tutorials">
					  <p>You can visit on following tutorials for improving your knowledge.</p>
					  <a href="https://www.w3schools.com/">
					  <img class="mySlides " src="../../assets/image/w3school.png" width="850px" height="300px"></a>
					  <a href="https://www.indiabix.com/">
					  <img class="mySlides " src="../../assets/image/indiabix.png" width="850px" height="300px"></a>
					  <a href="https://www.udemy.com/">
					  <img class="mySlides " src="../../assets/image/udemy.jpg" width="850px" height="300px"></a>
                      <a href="https://www.geeksforgeeks.org/">
					  <img class="mySlides " src="../../assets/image/geeksforgeeks.png" width="850px" height="300px"></a>
					</div>
					<!--- --------------------------------------------------------------- --->
                 </div>
		    </div><br>
		</div>

	 <cfinclude template="../../Includes/footer.cfm" />
	<script src="../../assets/js/profile.js" type="text/javascript"></script>
	</body>
</html>
