<cfinclude template="../../Includes/adminPageValidate.cfm" />
<html>
	<head>
		<title>All question PDF</title>

	</head>
	<body>
		<cfset VARIABLES.allQuestion = APPLICATION.viewDetailsObj.getQuestions() />

		<!--- Check DB error   --------------------------------------------------->
		<cfif isDefined("VARIABLES.questions.errID") >
			<cfif VARIABLES.questions.errID EQ -1>
				<cflocation url = "adminDashboard.cfm?errID=1" addtoken = "no" />
			</cfif>
		</cfif>
	    <!--- ------------------------------------------------------------------ --->

    	<cfdocument format = "PDF" overwrite = "true" filename = "questions.pdf">

			<cfoutput>
			<cfdocumentitem type = "header">
				<div style="font-size:25px; font-weight:bold;color:white;background-color:4c4848;padding:10px;">
					Online Exam System </div>
			</cfdocumentitem>

			<h4>Date ::#dateformat(now())#  &nbsp &nbsp &nbsp Time ::#TimeFormat(now(), "HH:nn:ss")#</h4>
			<strong>Note:</strong> Please save in .pdf extension.
			<h4 style="text-align:right">ADMIN</h4><hr>
			</cfoutput>

              <p style="text-align:center;font-size:20px;font-weight:bold;">All Question</p>
			  <p style="text-align:center;font-size:15px;
			  background-color:AliceBlue;padding:5px;margin-left:290px;margin-right:290px">ACTIVE QUESTIONS</p>
			  <p style="text-align:center;font-size:15px;
			  background-color:burlywood;padding:5px;margin-left:290px;margin-right:290px">INACTIVE QUESTIONS</p>
			 <br>
			<table id="questionPDF" cellpadding="0" title="QUESTIONS" cellspacing="0">
		        <tr>
			        <th style=" background-color:#adc7f4;padding:2px 4px ">ID</th>
			        <th style=" background-color:#adc7f4;padding:2px 4px " >QUESTION </th>
			        <th style=" background-color:#adc7f4;padding:2px 4px " >OPTION:1</th>
			        <th style=" background-color:#adc7f4;padding:2px 4px ">OPTION:2</th>
			        <th style=" background-color:#adc7f4;padding:2px 4px ">OPTION:3</th>
			        <th style=" background-color:#adc7f4;padding:2px 4px ">OPTION:4</th>
			        <th style=" background-color:#adc7f4;padding:2px 4px ">ANSWER</th>

				</tr>
				<cfoutput query = "VARIABLES.allQuestion">

					<cfif #VARIABLES.allQuestion.status#>
					<tr style="background-color:AliceBlue;">
					<cfelse>
					<tr style="background-color:burlywood">
					</cfif>
					<td style="border-top: 1px solid black;border-left: 1px solid black;padding:4px 6px ">#VARIABLES.allQuestion.questionId#</td>
					<td style="border-top: 1px solid black;border-left: 1px solid black;padding:4px 6px ">#VARIABLES.allQuestion.question#</td>
					<td style="border-top: 1px solid black;padding:4px 6px;text-align:center">#VARIABLES.allQuestion.option1#</td>
					<td style="border-top: 1px solid black;padding:4px 6px;text-align:center">#VARIABLES.allQuestion.option2#</td>
					<td style="border-top: 1px solid black;padding:4px 6px;text-align:center">#VARIABLES.allQuestion.option3#</td>
					<td style="border-top: 1px solid black;padding:4px 6px;text-align:center">#VARIABLES.allQuestion.option4#</td>
					<td style="border-top: 1px solid black;padding:4px 6px;text-align:center">Option:#VARIABLES.allQuestion.answer#</td>
				</tr>
				</cfoutput>
			</table>


		<cfoutput><cfdocumentitem type = "footer">
	    	<Center><strong>Page #cfdocument.currentPageNumber# of #cfdocument.totalPageCount#</strong></center>
		</cfdocumentitem></cfoutput>

	</cfdocument>
	</body>
</html>
<cfheader name="Content-Disposition" value="attachment;filename=questions.pdf">
<cfcontent type="application/octet-stream" file="#expandPath('.')#/questions.pdf">
