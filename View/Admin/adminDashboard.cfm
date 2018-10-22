<cfinclude template="../../Includes/adminPageValidate.cfm" />
<html>
	<head>
		<title>Admin Dashboard</title>
		<cfinclude template = "../../Includes/adminModule.cfm" />


		             <div class="data-container">
	                    <center><h1> admin dashboard</h1></center>
	                    <div class="serverSideError">
				              <cfset errorArray=["Internal problem.Please try again"]>
					          <cfif isdefined("URL.errID")>
								<cfif URL.errId EQ 1> <cfoutput>#errorArray[1]#</cfoutput> </cfif>
								<cfelse>
							  </cfif>
			             </div>
			             <center><h2> Active/Inactive Questions chart</h2><center>
			             <cfchart format="jpg" scalefrom="0"   scaleto="10" show3d="Yes" chartwidth="850"
			                      chartheight="350" dataBackgroundColor="##b5deff">


							<cfchartseries type="cone"  serieslabel="Active Question" seriescolor="##2ef739">
								<cfchartdata item="English"   value="8">
								<cfchartdata item="Math"      value="8">
								<cfchartdata item="Science"   value="9">
								<cfchartdata item="Computer"  value="8">
								<cfchartdata item="Chemistry" value="5">
								<cfchartdata item="Physics"   value="9">
								<cfchartdata item="Reasoning" value="9">
							</cfchartseries>
							<cfchartseries type="cone"  serieslabel="Inactive Question" seriescolor="##ff2369">
								<cfchartdata item="English"   value="3">
								<cfchartdata item="Math"      value="6">
								<cfchartdata item="Science"   value="2">
								<cfchartdata item="Computer"  value="4">
								<cfchartdata item="Chemistry" value="2">
								<cfchartdata item="Physics"   value="1">
								<cfchartdata item="Reasoning" value="3">
							</cfchartseries>

						</cfchart>

		             </div>
		  		</div><br>
          </div>
	  <cfinclude template="../../Includes/footer.cfm" />
	 </body>
</html>
