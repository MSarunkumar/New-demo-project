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
								<th>Status</th>
								<th>Action</th>
							 </tr>
						 </thead>
						 <tbody>
		                    <cfoutput query = "VARIABLES.marks">
			                    <cfset VARIABLES.scorePer = int(((VARIABLES.marks.score)*100)/VARIABLES.marks.totalQuestion)>
							 <tr>
	                             <td>#studentEmail#</td>
								 <td>#subject#</td>
								 <td align="center">#score#</td>
			                     <td align="center">#totalQuestion#</td>
			                     <td>#startDate#</td>
								 <td>#endDate#</td>
								 <cfif #VARIABLES.scorePer# LT 33>
						           <td id="fail">FAIL</td>
						         <cfelse>
						           <td id="pass">PASS</td>
						         </cfif>
						         <td>
									 <cfif  #status# EQ 1>
										<input type="button" class="allowBtn"  onClick="javascript:getAllowStatus('#studentEmail#','#testId#', this)" value="Allow" />
									<cfelse>
									    <input type="button" class="allowBtn"  onClick="javascript:getAllowStatus('#studentEmail#','#testId#', this)" value="Not Allow" />
									</cfif>
								 </td>
		                      </tr>
							 </cfoutput>
						 </tbody>
	            	</table><br>

				</div>
        	</div><br>
        </div>
		  <cfinclude template="../../Includes/footer.cfm" />
		<script src="../../assets/js/viewMarks.js"></script>
	</body>
</html>