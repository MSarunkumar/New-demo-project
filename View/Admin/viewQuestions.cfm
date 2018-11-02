<cfinclude template="../../Includes/adminPageValidate.cfm" />
<html>
	<head>
		<title>Question View</title>

		<cfinclude template = "../../Includes/adminModule.cfm" />

				<div class="data-container">
					<center><h1>Question View </h1></center>
					<div class="serverSideError">
						<cfset VARIABLES.errorArray=["Options updated successfully"]>
				        <cfif isdefined("URL.errID")>
							<cfif URL.errId EQ 1> <cfoutput>#VARIABLES.errorArray[URL.errID]#</cfoutput> </cfif>
							<cfelse>
						 </cfif>
					</div>
	                <cfset VARIABLES.questions = APPLICATION.viewDetailsObj.getQuestions() />

	                <cfif isDefined("VARIABLES.questions.errID") >
					<cfif VARIABLES.questions.errID EQ -1>
						<cflocation url = "adminDashboard.cfm?errID=1" addtoken = "no" />
					</cfif>
					</cfif>

	                <table id="tableId" class="cell-border order-column  stripe hover">
						<thead>
							<tr>
                                <th>Subject</th>
								<th>Question</th>
								<th>Option1</th>
								<th>Option2</th>
								<th>Option3</th>
								<th>Option4</th>
								<th>Answer</th>
								<th>Action</th>
								<th>Action</th>
 							</tr>
						 </thead>
						 <tbody>
							 <cfoutput query="VARIABLES.questions">
								 <tr>
									 <td>#subject#</td>
									 <td>#question#</td>
									 <td>#option1#</td>
									 <td>#option2#</td>
									 <td>#option3#</td>
									 <td>#option4#</td>
									 <td>#answer#</td>
									 <td >
								    <cfif  #status# EQ 1>
										<input type="button" class="actionButton btn-red " id="unblockButton" onClick="javascript:getQuestionStatus('#questionId#', this);" value="Inactive" />
									<cfelse>
										<input type="button" class="actionButton btn-green " id="blockButton" onClick="javascript:getQuestionStatus('#questionId#', this);" value="Active" />
									</cfif>
									</td>
									<td>
										<a href="editQuestion.cfm?quesId=#questionId#"><input type="button" class="actionButton btn-green " id="editButton" onClick="" value="Edit" /></a>
									</td>
								 </tr>
							 </cfoutput>
						 </tbody>
					</table><br><br>
				 <a href="questionPdf.cfm"><button id="resultBtn">Download Pdf of all questions</button></a>
                 <br><br><br>
				</div>
			</div><br>
	    </div>
	    <cfinclude template="../../Includes/footer.cfm" />
	<script src="../../assets/js/viewQuestions.js" type="text/javascript" ></script>
	</body>
</html>