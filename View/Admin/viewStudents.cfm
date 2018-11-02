<cfinclude template="../../Includes/adminPageValidate.cfm" />
<html>
	<head>
		<title>Student View</title>
		<cfinclude template = "../../Includes/adminModule.cfm" />

			<div class="data-container">
				<center><h1>Students detail </h1></center>
				<div class="serverSideError"></div>

				<cfset VARIABLES.student = APPLICATION.viewDetailsObj.getStudents() />
				<!--- Check DB error ----------------------- --->
                <cfif isDefined("VARIABLES.student.errID") >
					<cfif VARIABLES.student.errID EQ -1>
						<cflocation url = "adminDashboard.cfm?errID=1" addtoken = "no">
					</cfif>
				</cfif>
				<!--- -------------------------------------- --->
                <table id="tableId" class="cell-border order-column  stripe hover">
                   <thead >
						<tr>
					   	    <th>Name</th>
							<th>Email</th>
							<th>Dob</th>
							<th>Mobile</th>
						    <th>Address Line</th>
						    <th>Action</th>
						 </tr>
					 </thead>
					 <tbody id="dataTableBody">
						 <cfoutput query="VARIABLES.student">
							 <tr>
								 <td>#Name#</td>
								 <td>#email#</td>
								 <td>#DateFormat(dob,"long")#</td>
								 <td>#phone#</td>
								 <td>#address#</td>

								 <td>
									 <cfif  #status# EQ 0>
										<input type="button" class="actionButton btn-green" id="unblockButton" onClick="javascript:getStatus('#email#', this)" value="Unblock" />
									<cfelse>
									    <input type="button" class="actionButton btn-red" id="blockButton" onClick="javascript:getStatus('#email#', this)" value="Block" />
									</cfif>

								 </td>

							  </tr>
						    </cfoutput>
					  </tbody>
                  </table>
         		</div><br>
			</div>

	 <cfinclude template="../../Includes/footer.cfm" />
	<script src="../../assets/js/statusStudent.js" type="text/javascript"></script>
	</body>
</html>