<!---
	--- login
	--- -----
	---
	--- This is login cfc.
	---
	--- author: mindfire
	--- date:   9/24/18
	--->
<cfcomponent hint = "This is login cfc." accessors = "true" output = "false" persistent = "false">

	<!--- Method  1 [it will return password after fetching from ms_student and ms_admin]--->

	<cffunction name = "getPassword" access = "public" output = "false" returntype = "string">
		<cfargument name = "email" required = "yes" type = "string" />

		<cftry>
		      <cfquery name = "LOCAL.fetchPassword">
		        SELECT password
		        FROM   ms_student
		        WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.email#">
	         </cfquery>
		     <cfreturn LOCAL.fetchPassword.password />
		     <cfcatch type = "database">
			 <cfset APPLICATION.loggingObj.doLog("login","getPassword",cfcatch.message,cfcatch.detail) />		       <cfreturn "" />
			 </cfcatch>
		</cftry>
	</cffunction>

 <!--- Method 3 it will return salt from ms_student  --->

     <cffunction name = "getSalt" access = "public" output = "false" returntype = "string">
		<cfargument name = "email" required = "yes" type = "string" />

		<cftry>
		      <cfquery name = "LOCAL.fetchSalt" >
		         SELECT salt
		         FROM   ms_student
		         WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.email#">
	          </cfquery>
		      <cfreturn LOCAL.fetchSalt.salt />
		      <cfcatch type = "database">
			  <cfset APPLICATION.loggingObj.doLog("login","getSalt",cfcatch.message,cfcatch.detail) />			        <cfreturn "" />
			  </cfcatch>
		</cftry>
	</cffunction>

<!--- It will return role of user like [admin/student] --->
    <cffunction name = "getRole" access = "public" output = "false" returntype = "string">
		<cfargument name = "email" required = "yes" type = "string" />
		<cftry>
		      <cfquery name = "LOCAL.fetchRole" >
		         SELECT roles
		         FROM   ms_student
		         WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.email#">
	          </cfquery>
		      <cfreturn LOCAL.fetchRole.roles />
		      <cfcatch type = "database">
		      	<cfset APPLICATION.loggingObj.doLog("login","getRole",cfcatch.message,cfcatch.detail) />
		      	<cfreturn "" />
			 </cfcatch>
		</cftry>
	</cffunction>

<!--- It will return status of student [block / unblock] --->
	<cffunction name = "getStatus" access = "public" output = "false" returntype = "numeric">
			<cfargument name = "email" required = "yes" type = "string" />
			<cftry>
			       <cfquery name = "LOCAL.fetchStatus" >
			         SELECT status
			         FROM   ms_student
			         WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.email#">
		           </cfquery>
			      <cfreturn LOCAL.fetchStatus.status />
			      <cfcatch type = "database">
			       <cfset APPLICATION.loggingObj.doLog("login","getStatus",cfcatch.message,cfcatch.detail) />
			       <cfreturn -1 />
				  </cfcatch>
			</cftry>
	</cffunction>




</cfcomponent>
