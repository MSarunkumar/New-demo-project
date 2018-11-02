<!---
  --- blockUnblock
  --- ------------
  ---
  --- It is for blocking and unblocking actions.
  ---
  --- author: mindfire
  --- date:   10/17/18
  --->
<cfcomponent hint = "It is for blocking and unblocking actions." accessors = "true"
             output = "false" persistent = "false">

<!--- Method : It will return the status of the student after doing Block/Unblock action.  --->
		<cffunction name = "getStatus" access = "remote" returnType = "struct" returnFormat = "JSON" >
			<cfargument name = "email"  required = "true" type = "string"   hint = "It will catch email" />
			<cfargument name = "status" required = "true" type = "numeric"  hint = "It will catch staus" />

			<cfset LOCAL.result = structNew() />
			<cfset LOCAL.result.done = "false" />
			<cfset LOCAL.result.data = "" />

		    <cfset LOCAL.success = toggleBlock(ARGUMENTS.email) />
             <!--- Check DB Error ------------------------->
            <cfif NOT LOCAL.success >
				<cfset LOCAL.result.done = "false" />
                <cfreturn LOCAL.result />
			</cfif>
			<!--- -------------------------------------- --->
		    <cftry>
		    	<cfquery name = "fetchStatus">
                  SELECT status
				  FROM   ms_student
				  WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" maxlength="50"
	                             value = "#ARGUMENTS.email#">
				</cfquery>
				<cfset LOCAL.result.done = "true" />
				<cfset LOCAL.result.data = fetchStatus.status />

				<cfcatch type = "database">
                  <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getStatus]" />
			      <cfset LOCAL.result.done = "false" />
				</cfcatch>
			</cftry>
			<cfreturn LOCAL.result />
		</cffunction>

<!-------- Method : It will block the student [update status 1 to 0] ----------------->
	<cffunction name = "toggleBlock" access = "public" hint = "It will set the status 0"
		                             returntype = "boolean">
		<cfargument name = "email" required = "true" type = "string" hint = "It will catch email" />
	    <cftry>
		    <cfquery name = "doBlockUnblock">
			  UPDATE ms_student
			  SET    status = CASE
				                  WHEN status = 1 THEN 0
				                  ELSE 1
			                  END

			  WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" maxlength = "50"
	                             value = "#ARGUMENTS.email#">
			</cfquery>

			<cfreturn TRUE />
			<cfcatch>
			  <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[toggleBlock] blockUnblock" />
              <cfreturn FALSE />
			</cfcatch>

		</cftry>

	</cffunction>



	<!--- Method : It will perform action on question [Active/Inactive] ------------------------->
	<cffunction name = "getQuestionStatus" access = "remote" returnType = "struct" returnFormat = "JSON">
			<cfargument name = "questionId"  required = "true" type = "numeric"  hint = "It will catch questionId">
			<cfargument name = "status"      required = "true" type = "numeric"  hint = "It will catch staus">

			<cfset LOCAL.result = structNew()>

			<cfset LOCAL.result.done = "false" />
			<cfset LOCAL.result.data = "" />

		    <cfset LOCAL.success = toggleActive(ARGUMENTS.questionId) />

            <cfif NOT LOCAL.success >
				<cfset LOCAL.result.done = "false" />
                <cfreturn LOCAL.result />
			</cfif>

		    <cftry>
		    	<cfquery name = "fetchStatus">
                  SELECT status
				  FROM   ms_question
				  WHERE  questionId = <cfqueryparam cfsqltype = "cf_sql_integer" value = "#ARGUMENTS.questionId#">
				</cfquery>
				<cfset LOCAL.result.done = "true" />
				<cfset LOCAL.result.data = fetchStatus.status />

				<cfcatch type = "database">
                  <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getQuestionStatus].blockUnblock" />
			      <cfset LOCAL.result.done = "false" />
				</cfcatch>
			</cftry>
			<cfreturn LOCAL.result />
		</cffunction>

<!--- ------    Method : It will do activate/deactivate questions for test  ------------>
	<cffunction name = "toggleActive" access = "private" hint = "It will do toggle the status of question"
		                              returntype = "boolean">
		<cfargument name = "questionId" required = "true" type = "numeric" hint = "It will catch questionId"/>
	    <cftry>
		    <cfquery name="doToggle">
			  UPDATE ms_question
			  SET    status = CASE
				                  WHEN status = 1 THEN 0
				                  ELSE 1
			                  END
			  WHERE questionID = <cfqueryparam cfsqltype = "cf_sql_integer" value = "#ARGUMENTS.questionId#">

			</cfquery>
			<cfreturn TRUE />
			<cfcatch>
			  <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[toggleActive] blockUnblock" />
              <cfreturn FALSE />
			</cfcatch>
		</cftry>

	</cffunction>

<!--- Method : It will alloe for multiple test for a subject --->
	<cffunction name = "getAllowStatus" access = "remote" returnType = "struct" returnFormat = "JSON">
			<cfargument name = "studentEmailId"  required = "true" type = "string"  hint = "It will catch student emailId">
			<cfargument name = "subject"      required = "true" type = "string"  hint = "It will catch subject name">

			<cfset LOCAL.resultStatus = structNew()>

			<cfset LOCAL.resultStatus.done = "false" />
			<cfset LOCAL.resultStatus.data = "" />

		    <cfset LOCAL.success = toggleAllow(ARGUMENTS.studentEmailId,ARGUMENTS.subject) />
			<!--- check DB error --->
            <cfif NOT LOCAL.success >
				<cfset LOCAL.resultStatus.done = "false" />
                <cfreturn LOCAL.resultStatus />
			</cfif>

		    <cftry>
		    	<cfquery name = "LOCAL.fetchAllowStatus">
                  SELECT status
				  FROM   ms_result
				  WHERE  studentEmail = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.studentEmailId#">
						AND subject = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.subject#">
				</cfquery>
				<cfset LOCAL.resultStatus.done = "true" />
				<cfset LOCAL.resultStatus.data = LOCAL.fetchAllowStatus.status />

				<cfcatch type = "database">
                  <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getAllowStatus].blockUnblock" />
			      <cfset LOCAL.resultStatus.done = "false" />
				</cfcatch>
			</cftry>
			<cfreturn LOCAL.resultStatus />
		</cffunction>

<!--- ------    Method : It will do allow/notAllow for multiple test  ------------>
	<cffunction name = "toggleAllow" access = "private" hint = "It will do toggle the status of allow"
		                              returntype = "boolean">
		<cfargument name = "studentEmail" required = "true" type = "string" hint = "It will catch student email"/>
	    <cfargument name = "subject" required = "true" type = "string" hint = "It will catch subject name"/>
	    <cftry>
		    <cfquery name="doToggle">
			  UPDATE ms_result
			  SET    status = CASE
				                  WHEN status = 1 THEN 0
				                  ELSE 1
			                  END
			  WHERE studentEmail = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.studentEmail#">
						AND subject = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.subject#">

			</cfquery>
			<cfreturn TRUE />
			<cfcatch>
			  <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[toggleAllow] blockUnblock" />
              <cfreturn FALSE />
			</cfcatch>
		</cftry>

	</cffunction>


</cfcomponent>