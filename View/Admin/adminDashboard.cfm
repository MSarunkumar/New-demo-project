<cfinclude template="../../Includes/adminPageValidate.cfm" />
<html>
	<head>
		<title>Admin Dashboard</title>
		<cfinclude template = "../../Includes/adminModule.cfm" />


		             <div class="data-container">
	                    <center><h1> admin dashboard</h1></center>
	                    <div class="serverSideError">
				              <cfset VARIABLES.errorArray=["Internal problem.Please try again"]>
					          <cfif isdefined("URL.errID")>
								<cfif URL.errId EQ 1> <cfoutput>#VARIABLES.errorArray[URL.errID]#</cfoutput> </cfif>
								<cfelse>
							  </cfif>
			             </div>
			             <center><h2> Total/Active Questions chart</h2><center>
			             <cfset VARIABLES.activeQues = APPLICATION.viewDetailsObj.quesInfoChart("active") />
			             <cfset VARIABLES.totalQues = APPLICATION.viewDetailsObj.quesInfoChart("total") />



			             <cfchart format = "jpg" scalefrom = "0"   scaleto = "25" show3d = "Yes" chartwidth = "850"
			                      chartheight = "350" dataBackgroundColor = "b5deff">



							<cfchartseries type = "cone"  serieslabel = "Total Question " seriescolor = "##2ef739">
								<cfchartdata item = "Chemistry"     value = "#VARIABLES.totalQues[1]#" >
								<cfchartdata item = "Computer"      value = "#VARIABLES.totalQues[2]#">
								<cfchartdata item = "English"       value = "#VARIABLES.totalQues[3]#">
								<cfchartdata item = "Math"          value = "#VARIABLES.totalQues[4]#">
								<cfchartdata item = "Physics"       value = "#VARIABLES.totalQues[5]#">
								<cfchartdata item = "Reasoning"     value = "#VARIABLES.totalQues[6]#">
								<cfchartdata item = "Science"       value = "#VARIABLES.totalQues[7]#">
							</cfchartseries>
							<cfchartseries type = "cone"  serieslabel = "Active Question" seriescolor = "##ff2369">
								<cfchartdata item = "Chemistry"     value = "#VARIABLES.activeQues[1]#">
								<cfchartdata item = "Computer"      value = "#VARIABLES.activeQues[2]#">
								<cfchartdata item = "English"       value = "#VARIABLES.activeQues[3]#">
								<cfchartdata item = "Math"          value = "#VARIABLES.activeQues[4]#">
								<cfchartdata item = "Physics"       value = "#VARIABLES.activeQues[5]#">
								<cfchartdata item = "Reasoning"     value = "#VARIABLES.activeQues[6]#">
								<cfchartdata item = "Science"       value = "#VARIABLES.activeQues[7]#">
							</cfchartseries>

						</cfchart>

		             </div>
		  		</div><br>
          </div>
	  <cfinclude template="../../Includes/footer.cfm" />
	 </body>
</html>
