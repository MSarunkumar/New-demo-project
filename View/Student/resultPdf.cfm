<cfinclude template="../../Includes/studentPageValidate.cfm" />

<html>
	<head>
		<title>Result PDF</title>
	</head>
	<body>
		<cfset 	VARIABLES.mark = APPLICATION.viewDetailsObj.getMark() />

		<!--- Check DB error   --------------------------------------------------->
			<cfif isDefined("VARIABLES.mark.errID") >
				<cfif VARIABLES.questions.errID EQ -1>
					<cflocation url = "studentDashboard.cfm?errID=1" addtoken = "no" />
				</cfif>
			</cfif>
		<!--- ------------------------------------------------------------------ --->
		<cfdocument format = "PDF" overwrite = "true" filename = "onlineExamSystemResult.pdf">

			<cfoutput>
			<cfdocumentitem type="header">
			<div style="font-size:25px; font-weight:bold;color:white;background-color:4c4848;padding:10px;">
					Online Exam System </div>
			</cfdocumentitem>
		    <h4>Date ::#dateformat(now())#  &nbsp &nbsp &nbsp Time ::#TimeFormat(now(), "HH:nn:ss")#</h4>
			<strong>Note:</strong> Please save your result in .pdf extension.
			<h4 style="text-align:right">#SESSION.student.name#</h4><hr>
			<center><p style="font-size:25px;font-weigth:bold">Score Card </p></center>

			</cfoutput>

			<table id="resultPDF" cellpadding="0" title="RESULT" cellspacing="0" width:"1200" >
		        <tr>
			        <th style=" background-color:#adc7f4;padding:1px 1px;" >TEST NAME </th>
			        <th style=" background-color:#adc7f4;padding:3px 4px; ">SCORE </th>
			        <th style=" background-color:#adc7f4;padding:3px 4px;  ">TOTAL QUESTION</th>
			        <th style=" background-color:#adc7f4;padding:3px 4px;  ">START TIME</th>
			        <th style=" background-color:#adc7f4;padding:3px 4px;  ">TIME SPENT</th>
			        <th style=" background-color:#adc7f4;padding:1px 1px;  "> STATUS</th>
				</tr>
				<cfoutput query="VARIABLES.mark">
					<cfset VARIABLES.scorePer = int(((VARIABLES.mark.score)*100)/VARIABLES.mark.totalQuestion)>
					<cfset VARIABLES.startTime = VARIABLES.mark.startDate />
					<cfset VARIABLES.date= DateFormat(VARIABLES.startTime, "mm-dd-yyyy") />
                    <cfset VARIABLES.time=TimeFormat(VARIABLES.startTime, "HH:MM:ss") />


			        <tr>
			            <td style="border-top: 1px solid black;border-left: 1px solid black;text-align:left;
			                       padding:0px 0px ;border-bottom: 1px solid black;">#VARIABLES.mark.subject#</td>
						<td style="border-top: 1px solid black;padding:4px 6px ;border-bottom: 1px solid black;">#VARIABLES.scorePer#%</td>
						<td style="border-top: 1px solid black;padding:4px 6px;text-align:center;border-bottom: 1px solid black;">#VARIABLES.mark.totalQuestion#</td>
						<td style="border-top: 1px solid black;padding:4px 6px;text-align:center;border-bottom: 1px solid black;">#VARIABLES.date# #VARIABLES.time#</td>
						<td style="border-top: 1px solid black;padding:4px 6px;text-align:center;
						           border-bottom: 1px solid black;">#dateDiff("s","#VARIABLES.mark.startDate#","#VARIABLES.mark.endDate#")#</td>
						<cfif #VARIABLES.scorePer# LT 33>
						<td style="border-top: 1px solid black;padding:4px 6px;border-right: 1px solid black;
						border-bottom: 1px solid black;text-align:center;color:orangeRed;">FAIL</td>
						<cfelse>
						<td style="border-top: 1px solid black;padding:4px 6px;border-right: 1px solid black;
						border-bottom: 1px solid black; text-align:center;color:0232ed;">PASS</td>
						</cfif>
					</tr>
				</cfoutput>
			</table>

			<cfoutput>
			<cfdocumentitem type="footer">
		    	<Center><strong>Page #cfdocument.currentPageNumber# of #cfdocument.totalPageCount#</strong></center>
			</cfdocumentitem>
			</cfoutput>
		</cfdocument>


	</body>
</html>
<cfheader name="Content-Disposition" value="attachment;filename=onlineExamSystemResult.pdf">
<cfcontent type="application/octet-stream" file="#expandPath('.')#/onlineExamSystemResult.pdf">
