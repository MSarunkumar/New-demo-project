<cfdocument format = "PDF" overwrite = "true" >
    <cfset 	VARIABLES.mark = APPLICATION.viewDetailsObj.getMark() />
	<cfoutput>
	<cfdocumentitem type="header">
		<center><strong>Online Exam System</strong></center>
	</cfdocumentitem>
    <h4>Date ::#dateformat(now())#</h4>
    <h4>Time ::#TimeFormat(now(), "HH:nn:ss")#</h4>

	<strong>Note:</strong> Please save your result in .pdf extension.
	<hr>
	<center><h2>#SESSION.student.name# :: Result</h2></center>
	</cfoutput>
	<cfoutput query="VARIABLES.mark">
		<table border="1px" cellpadding="5px" cellspacing="5px"  class="resultTbl">
			<thead>
				<tr align="center">

				   <th>Total score          </th>
				   <th>Total questions in test</th>
				   <th>Start Time </th>
				   <th>Total time spent in seconds</th>

                 </tr>
			</thead>
            <hr>#Subject# test result
			<tbody>
				<tr align="center">

				   <td>#score#	       </td>
				   <td>#totalQuestion#</td>
				   <td>#startDate#</td>
				   <td>#dateDiff("s", "#startDate#" , "#endDate#") #  </td>

				</tr>
			</tbody>
		</table>
    </cfoutput>
	<cfoutput>
	<cfdocumentitem type="footer">
    	<Center><strong>Page #cfdocument.currentPageNumber# of #cfdocument.totalPageCount#</strong></center>
	</cfdocumentitem>
	</cfoutput>
</cfdocument>
