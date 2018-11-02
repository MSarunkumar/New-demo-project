<cfinclude template="../../Includes/studentPageValidate.cfm" />


<html>
	<head>
		<title> Student Result </title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet">
		<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
		<cfinclude template="../../Includes/studentModule.cfm" />

				<div class="data-container">
					<cfset VARIABLES.mark = APPLICATION.viewDetailsObj.getMark() />
					<!--- Check DB error ---------------------------------------------- --->
					<cfif isDefined("VARIABLES.mark.errID") >
						<cfif VARIABLES.mark.errID EQ -1>
							<cflocation url = "studentDashboard.cfm?errID=1" addtoken = "no" />
						</cfif>
					<cfelse>
					</cfif>
                    <!--- ----------------------------------------------------------- --->
		        	<center><h1>Your Result</h1></center>

					<table id="tableId" class="cell-border order-column  stripe hover">
						<thead>
							<tr>
							   <th> Test </th>
							   <th> Score </th>
							   <th> Total Questions </th>
							   <th> Start Time </th>
							   <th> End Time </th>
		                    </tr>
						</thead>

						<tbody>
							<cfoutput query="VARIABLES.mark">
								<tr>
									<td> #Subject# </td>
									<td> #score# </td>
									<td> #totalQuestion# </td>
									<td> #startDate# </td>
									<td> #endDate# </td>
								</tr>
							</cfoutput>
						</tbody>
					</table>
					<a href="resultPdf.cfm"><input type="button" id="resultBtn" value="Download Result"></a>
	        	</div>
			</div><br>
		</div>
	 <cfinclude template="../../Includes/footer.cfm" />
	<script src="../../assets/js/viewMark.js" type="text/javascript"></script>
    </body>
</html>
