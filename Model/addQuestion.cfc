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
	<cffunction name = "submitQuestion" access = "remote" hint = "It will submit the question/answer with subject"
                                        returntype = "boolean"  returnformat = "JSON">
			<cfargument name = "sub"  required = "true" type = "string"  />
			<cfargument name = "ques" required = "true" type = "string"  />
			<cfargument name = "op1"  required = "true" type = "string"  />
			<cfargument name = "op2"  required = "true" type = "string"  />
			<cfargument name = "op3"  required = "true" type = "string"  />
			<cfargument name = "op4"  required = "true" type = "string"  />
			<cfargument name = "ans"  required = "true" type = "numeric" />

	    <cftry>
			 <cfquery name = "LOCAL.submitQues" >
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

				<cfset APPLICATION.loggingObj.doLog("addQuestion","submitQuestion",cfcatch.message,cfcatch.detail) />
				<cfreturn FALSE />
			</cfcatch>
		</cftry>

	</cffunction>
	<!--- Method : It will update the question information which id edit by admin --->
	<cffunction name = "updateOption" access = "remote" returntype = "boolean" hint = "update question"
				returnformat = "JSON">
        <cfargument name = "qid"  required = "true" type = "numeric"  />
		<cfargument name = "op1"  required = "true" type = "string"  />
		<cfargument name = "op2"  required = "true" type = "string"  />
		<cfargument name = "op3"  required = "true" type = "string"  />
		<cfargument name = "op4"  required = "true" type = "string"  />
		<cfargument name = "ans"  required = "true" type = "numeric" />
		<cftry>
			<cfquery name = "LOCAL.doUpdateOpion">
				UPDATE  ms_question
					SET
			            option1 = <cfqueryparam value = "#ARGUMENTS.op1#"  cfsqltype = "cf_sql_varchar">,
			            option2 = <cfqueryparam value = "#ARGUMENTS.op2#"  cfsqltype = "cf_sql_varchar">,
						option3 = <cfqueryparam value = "#ARGUMENTS.op3#"  cfsqltype = "cf_sql_varchar">,
					    option4 = <cfqueryparam value = "#ARGUMENTS.op4#"  cfsqltype = "cf_sql_varchar">,
						answer =  <cfqueryparam value = "#ARGUMENTS.ans#"  cfsqltype = "cf_sql_integer">

				WHERE questionId = <cfqueryparam cfsqltype = "cf_sql_integer"  value = "#ARGUMENTS.qid#">

			</cfquery>
			<cfreturn TRUE />
			<cfcatch type="database">
				<cfset APPLICATION.loggingObj.doLog("addQuestion","updateOption",cfcatch.message,cfcatch.detail) />
				<cfreturn FALSE />
			</cfcatch>
		</cftry>
	</cffunction>


</cfcomponent>