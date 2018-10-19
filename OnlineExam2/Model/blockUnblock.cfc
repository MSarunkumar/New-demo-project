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

<!--- Method : It will return the status the of student after doing Block/Unblock.  --->
		<cffunction name = "getStatus" access = "remote" returnType = "struct" returnFormat = "JSON">
			<cfargument name = "email"  required = "true" type = "string"  hint = "It will catch email">
			<cfargument name = "status"  required = "true" type = "numeric"  hint = "It will catch staus">

			<cfset LOCAL.result = structNew()>
			<cfset LOCAL.result.done = "false" />
			<cfset LOCAL.result.data = "" />
			<cfif ARGUMENTS.status>
				<cfset LOCAL.success = blockStudent(ARGUMENTS.email) />
			<cfelse>
				<cfset LOCAL.success = unblockStudent(ARGUMENTS.email) />
			</cfif>
            <cfif NOT LOCAL.success >
				<cfset LOCAL.result.done = "false" />
                <cfreturn LOCAL.result />
			</cfif>
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
	<cffunction name = "blockStudent" access = "private" hint = "It will set the status 0"
		                 returntype = "boolean">
		<cfargument name = "email" required = "true" type = "string" hint="It will catch email"/>
	    <cftry>
		    <cfquery name="doBlock">
			  UPDATE ms_student
			  SET    status = 0
			  WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" maxlength="50"
	                             value = "#ARGUMENTS.email#">
			</cfquery>

			<cfreturn TRUE />
			<cfcatch>
			  <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getStatus]" />
              <cfreturn FALSE />
			</cfcatch>

		</cftry>

	</cffunction>


<!------ Method : It will unblock the student [update status 0 to 1] -------------------->
	<cffunction name = "unblockStudent" access = "private" hint = "It will set the status 1"
		                 returntype = "boolean">
		<cfargument name = "email" required = "true" type = "string" hint="It will catch email"/>
	    <cftry>
		    <cfquery name="doUnblock">
			  UPDATE ms_student
			  SET    status = 1
			  WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" maxlength="50"
	                             value = "#ARGUMENTS.email#">
			</cfquery>
			<cfreturn TRUE />
			<cfcatch>
			  <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getStatus]" />
              <cfreturn FALSE />
			</cfcatch>

		</cftry>

	</cffunction>

</cfcomponent>