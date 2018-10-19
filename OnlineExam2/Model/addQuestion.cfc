<!---
  --- addQuestion
  --- -----------
  ---
  --- It will add the question in DB.
  ---
  --- author: mindfire
  --- date:   9/25/18
  --->
<cfcomponent hint = "It will add the question in DB." accessors = "true" output = "false" persistent = "false">

<!--- -----   Method: It will submit the question in ms_question table --->
	<cffunction name = "submitQuestion" access = "remote" hint="It will submit the question/answer with subject"
                                        returntype = "boolean"  returnformat="JSON">
			<cfargument name = "sub"  required = "true" type = "string"  />
			<cfargument name = "ques" required = "true" type = "string"  />
			<cfargument name = "op1"  required = "true" type = "string"  />
			<cfargument name = "op2"  required = "true" type = "string"  />
			<cfargument name = "op3"  required = "true" type = "string"  />
			<cfargument name = "op4"  required = "true" type = "string"  />
			<cfargument name = "ans"  required = "true" type = "numeric" />

	    <cftry>
			 <cfquery name = "submitQues" >
		      INSERT INTO ms_question (question,option1,option2,option3,option4,answer,subject)
	                 VALUES (
				            <cfqueryparam value = "#ARGUMENTS.ques#" cfsqltype = "cf_sql_varchar">,
	                        <cfqueryparam value = "#ARGUMENTS.op1#"  cfsqltype = "cf_sql_varchar">,
	                        <cfqueryparam value = "#ARGUMENTS.op2#"  cfsqltype = "cf_sql_varchar">,
							<cfqueryparam value = "#ARGUMENTS.op3#"  cfsqltype = "cf_sql_varchar">,
							<cfqueryparam value = "#ARGUMENTS.op4#"  cfsqltype = "cf_sql_varchar">,
							<cfqueryparam value = "#ARGUMENTS.ans#"  cfsqltype = "cf_sql_integer">,
							<cfqueryparam value = "#ARGUMENTS.sub#"  cfsqltype = "cf_sql_varchar">
					       )
	        </cfquery>
			<cfreturn TRUE />

			<cfcatch type = "database">
			<cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..fun[submitQuestion]addQuestion.cfc">
			<cfreturn FALSE />
			</cfcatch>
		</cftry>

	</cffunction>


</cfcomponent>