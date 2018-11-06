<cfinclude template="../../Includes/adminPageValidate.cfm" />
<html>
	<head>
		<title>Make Test</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">
		<link href="../../assets/css/datetimepicker.css" rel="stylesheet" type="text/css"/>
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	    <script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
	    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.0/moment-with-locales.min.js"></script>

	    <link href="https://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">

		<cfinclude template = "../../Includes/adminModule.cfm" />
		             <div class="data-container">
	                    <center><h1> Make Test</h1></center>
	                    <div class="serverSideError">
				              <cfset VARIABLES.errorArray=["Test time and duration updated successfully"]>

					          <cfif isdefined("URL.errID")>
								<cfif URL.errId EQ 1> <cfoutput>#VARIABLES.errorArray[1]#</cfoutput> </cfif>
								<cfelse>
							  </cfif>
			             </div>
                         <form id="form" >

							<div class="container">
                                <div class="label-container"> Please select test </div>
                                <select  id="testId"   class="input-box" onChange="testValid()">
                                    <option  value="0"> Choose Test   </option>
									<option  value="Math">    Math	     </option>
									<option  value="English"> English    </option>
									<option  value="Science"> Science    </option>
									<option  value="Computer">Computer   </option>
									<option  value="Physics"> Physics    </option>
									<option  value="Chemistry">Chemistry </option>
									<option  value="Reasoning">Reasoning </option>
								</select>
								<div id="tid" class="error"> </div>
							</div>

							<div class="container">
                                <div class="label-container"> Please set the activate time of test </div>
                                 <div id="picker" class="input-box"> </div>
								 <input type="hidden" id="startId" name="start" />
								<div id="stid" class="error"> </div>
							</div>
							<div class="container">
								<div class="label-container">Please enter time duration of test in minutes </div>
                                 <input type="text" id="durId" name="dur" class="input-box" maxlength="3"
								        title="Duration should be less than 4 digit "
								        onblur="durValid()"/>
							    <div id= "dtid" class="error"> </div>
							</div>
							<div class="container">
								<div class="label-container">Please enter total question </div>
                                 <input type="text" id="queId" name="dur" class="input-box" maxlength="2"
								        title="Total question must be less than or equal to activate question"
								        onblur="queValid()"/>
							    <div id= "qtid" class="error"> </div>
							</div>


                            <input type="Button" value="Update Test Time" class="btn" name="submit" id="update">
							<input type="Reset" value="Reset" class="btn" name="reset" id="resetBtn">
					    </form>

		             </div>
		  		</div><br>
          </div>
	  <cfinclude template="../../Includes/footer.cfm" />
	  <script type="text/javascript" src="../../assets/js/datetimepicker.js"></script>

	  <script src="../../assets/js/makeTest.js" type="text/javascript" ></script>
	  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
	 </body>
</html>
