<cfinclude template="../../Includes/adminPageValidate.cfm" />
<html>
		<head>
			<title>Result View</title>
            <cfinclude template = "../../Includes/adminModule.cfm" />


				<div class="data-container">
					<center><h1>Result of all students </h1></center>

					<cfset VARIABLES.marks = APPLICATION.viewDetailsObj.getMarks() />
					<cfif isDefined("VARIABLES.marks.errID") >
					<cfif VARIABLES.marks.errID EQ -1>
						<cflocation url = "adminDashboard.cfm?errID=1" addtoken = "no">
					</cfif>
					</cfif>

	                <table id="tableId" class="cell-border order-column  stripe hover">
						<thead>
							<tr>
								<th>Student Email </th>
								<th>Test</th>
								<th>Score</th>
								<th>Total Questions</th>
								<th>Start Time</th>
								<th>End Time</th>
							 </tr>
						 </thead>
						 <tbody>
		                    <cfoutput query = "VARIABLES.marks">
							 <tr>
	                             <td>#studentEmail#</td>
								 <td>#subject#</td>
								 <td align="center">#score#</td>
			                     <td align="center">#totalQuestion#</td>
			                     <td>#startDate#</td>
								 <td>#endDate#</td>
		                      </tr>
							 </cfoutput>
						 </tbody>
	            	</table><br>

				</div>
        	</div><br>
        </div>
		  <cfinclude template="../../Includes/footer.cfm" />
		<script src="../../assets/js/viewMark.js"></script>
	</body>
</html>