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
		      <cfquery name = "fetchPassword">
		        SELECT password
		        FROM   ms_student
		        WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.email#">
	         </cfquery>
		     <cfreturn fetchPassword.password />
		     <cfcatch type = "database">
		       <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..fun[getPassword]login">
		       <cfreturn "FALSE" />
			 </cfcatch>
		</cftry>
	</cffunction>

 <!--- Method 3 it will return salt from ms_student or ms_admin --->

     <cffunction name = "getSalt" access = "public" output = "false" returntype = "string">
		<cfargument name = "email" required = "yes" type = "string" />

		<cftry>
		      <cfquery name = "fetchSalt" >
		         SELECT salt
		         FROM   ms_student
		         WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.email#">
	          </cfquery>
		      <cfreturn fetchSalt.salt />
		      <cfcatch type = "database">
		        <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..fun[getSalt]]login">
		        <cfreturn "FALSE" />
			  </cfcatch>
		</cftry>
	</cffunction>

<!--- It will return role of user like [admin/student] --->
    <cffunction name = "getRole" access = "public" output = "false" returntype = "string">
		<cfargument name = "email" required = "yes" type = "string" />
		<cftry>
		       <cfquery name = "fetchRole" >
		         SELECT roles
		         FROM   ms_student
		         WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.email#">
	           </cfquery>
		      <cfreturn fetchRole.roles />
		      <cfcatch type = "database">
		       <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..fun[getRole]]login">
		       <cfreturn "FALSE" />
			 </cfcatch>
		</cftry>
	</cffunction>
<!--- It will return status of student [block / unblock] --->
	<cffunction name = "getStatus" access = "public" output = "false" returntype = "numeric">
			<cfargument name = "email" required = "yes" type = "string" />
			<cftry>
			       <cfquery name = "fetchStatus" >
			         SELECT status
			         FROM   ms_student
			         WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.email#">
		           </cfquery>
			      <cfreturn fetchStatus.status />
			      <cfcatch type = "database">
			       <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..fun[getRole]]login" />
			       <cfreturn -1 />
				  </cfcatch>
			</cftry>
	</cffunction>




</cfcomponent>
