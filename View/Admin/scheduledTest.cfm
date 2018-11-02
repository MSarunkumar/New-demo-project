<cfinclude template="../../Includes/adminPageValidate.cfm" />
<html>
	<head>
		<title>Scheduled Test</title>
		<cfinclude template = "../../Includes/adminModule.cfm" />
			<div class="data-container">
		                <center><h1>Time table of tests</h1></center>
		                <cfset VARIABLES.schedule = APPLICATION.viewDetailsObj.getSchedule() />
		                <cfset VARIABLES.currentTime = #DateTimeFormat(now(), "MM d yyyy HH:nn:ss ")# />

                         <!--- Check DB Error -------------------------------------------- --->
						<cfif isDefined("VARIABLES.schedule.errID") >
						<cfif VARIABLES.schedule.errID EQ -1>
							<cflocation url = "adminDashboard.cfm?errID=1" addtoken = "no">
						</cfif>

						</cfif>

		                <table id="tableId" class="cell-border order-column  stripe hover">
							<thead>
								<tr>
									<th> Test Name </th>
									<th> Start time </th>
									<th> Total Question </th>
									<th> Duration </th>
									<th> Status </th>

								 </tr>
							 </thead>
							 <tbody>
			                    <cfoutput query = "VARIABLES.schedule">
				                 <cfset VARIABLES.sec = Datediff("s",VARIABLES.schedule.startTime,VARIABLES.currentTime) />
								 <tr>
		                             <td align="center">#test#</td>
									 <td align="center">#startTime#</td>
									 <td align="center">#totalQuestion#</td>
				                     <td align="center">#duration#</td>
				                      <cfif VARIABLES.sec GT 600>
									 <td align="center"> Deactive</td>
									</cfif>
									 <cfif VARIABLES.sec LT 600 AND VARIABLES.sec GT 0>
									 <td align="center" id="activeId"> Active</td>
									</cfif>
									<cfif VARIABLES.sec LTE 0>
									 <td align="center"> Upcoming</td>
									</cfif>

			                      </tr>
								 </cfoutput>
							 </tbody>
		            	</table><br>

		             </div>
		  		</div><br>
          </div>
	  <cfinclude template="../../Includes/footer.cfm" />
     <script src="../../assets/js/scheduledTest.js" type="text/javascript"></script>
	 </body>
</html>
