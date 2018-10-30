<cfinclude template="../../Includes/adminPageValidate.cfm" />
<html>
	<head>
		<title>Make Test</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">

		<cfinclude template = "../../Includes/adminModule.cfm" />
		             <div class="data-container">
	                    <center><h1> Make Test</h1></center>
	                    <div class="serverSideError">
				              <cfset errorArray=["Test time and duration updated successfully"]>
					          <cfif isdefined("URL.errID")>
								<cfif URL.errId EQ 1> <cfoutput>#errorArray[1]#</cfoutput> </cfif>
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
                                 <input type="datetime-local" id="startId" name="start" class="input-box"
								  onblur="startValid()" />
								<div id="stid" class="error"> </div>
							</div>

                            <!--- <div class="container">
								<div class="label-container">Please set the deactivate time of test </div>
                                 <input type="datetime-local" id="endId" name="end" class="input-box"
								        onblur="endValid()" />
							    <div id= "etid" class="error"> </div>
							</div> --->

							<div class="container">
								<div class="label-container">Please enter time duration of test in minutes </div>
                                 <input type="text" id="durId" name="dur" class="input-box" maxlength="3"
								        title="Duration must be less than time difference of start,end  time "
								        onblur="durValid()"/>
							    <div id= "dtid" class="error"> </div>
							</div>


                            <input type="Button" value="Update Test Time" class="btn" name="submit" id="update">
							<input type="Reset" value="Reset" class="btn" name="reset" id="resetBtn">
					    </form>

		             </div>
		  		</div><br>
          </div>
	  <cfinclude template="../../Includes/footer.cfm" />
	  <script src="../../assets/js/makeTest.js" type="text/javascript" ></script>
	  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
	 </body>
</html>
