<cfinclude template="../../Includes/studentPageValidate.cfm" />
<html>
	<head>

		<title> Scheduled Tests</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet">
        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
		<cfinclude template="../../Includes/studentModule.cfm" />

				<div class="data-container">
		     		<center><h1>Scheduled Tests</h1></center>
	                <cfset VARIABLES.schedule = APPLICATION.viewDetailsObj.getSchedule() />
	                <cfset VARIABLES.currentTime = #DateTimeFormat(now(), "MM d yyyy HH:nn:ss ")# />

                         <!--- Check DB error  ------------------------- --->
						<cfif isDefined("VARIABLES.schedule.errID") >

						<cfif VARIABLES.schedule.errID EQ -1>
							<cflocation url = "studentDashboard.cfm?errID=1" addtoken = "no">
						</cfif>

						</cfif>
                        <!--- ------------------------------------------ --->
		                <table id="tableId" class="cell-border order-column  stripe hover">
							<thead>
								<tr>
									<th>Test Name </th>
									<th>Start time </th>
									<th>Duration </th>
									<th>Status</th>
								 </tr>
							 </thead>
							 <tbody>
			                    <cfoutput query = "VARIABLES.schedule">
								<cfset VARIABLES.sec = Datediff("s",VARIABLES.schedule.startTime,VARIABLES.currentTime) />
								<cfif VARIABLES.sec LT 600>
								<tr>
		                             <td align="center">#test#</td>
									 <td align="center">#startTime#</td>
				                     <td align="center">#duration#</td>
									 <cfif VARIABLES.sec LT 600 AND VARIABLES.sec GT 0>
									 <td align="center" id="activeId"> Active</td>
									</cfif>
									<cfif VARIABLES.sec LTE 0>
									 <td align="center"> Upcoming</td>
									</cfif>
			                      </tr>
			                      </cfif>
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
