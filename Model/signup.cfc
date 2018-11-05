<!---
	--- signup
	--- ------
	---
	--- author: mindfire
	--- date:   9/20/18
	--->
<cfcomponent accessors = "true" output = "false" persistent = "false">

<!---Method: [emailExist] function will check, user already registered or not,based on recordcount. if recordcount
		   Equal to one that means user exist with this email. --->

	<cffunction name = "emailExist" returntype = "numeric" access = "remote" hint = "It will return no. of record"
				returnformat="JSON" >
		<cfargument name = "email" hint = "It will catch the email" required = "true" type = "string" />

			<cftry>
				<cfquery name = "LOCAL.checkEmail">
				   SELECT email
				   FROM   ms_student
				   WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.email#">
				</cfquery>

				<cfreturn LOCAL.checkEmail.RecordCount />

		        <cfcatch type = "database">
				 <cfset APPLICATION.loggingObj.doLog("signup","emailExist",cfcatch.message,cfcatch.detail) />
				<cfreturn -1 />
		        </cfcatch>
			</cftry>

    </cffunction >




   <!---Method: [submitDetail] function will submit the detial of singup form at ms_student table in demoProject DB --->

    <cffunction name = "submitDetail" returntype = "boolean" access = "remote" hint = "It will store the student detail"
	            returnformat="JSON">
		<cfargument name = "name"     required = "true" type = "string"   />
		<cfargument name = "email"    required = "true" type = "string"   />
		<cfargument name = "dob"      required = "true" type = "date"     />
		<cfargument name = "phone"    required = "true" type = "numeric"  />
		<cfargument name = "address"  required = "true" type = "string"   />
		<cfargument name = "password" required = "true" type = "string"   />


		<cfset LOCAL.salt = Hash(GenerateSecretKey("AES"), "SHA-512") />
	    <cfset LOCAL.hashedPassword = Hash(ARGUMENTS.password & LOCAL.salt, "SHA-512") />

		<cftry>
        	<cfquery name = "LOCAL.insertQuery" >
	     	INSERT  INTO  ms_student (Name,email,dob,phone,address,password,salt)
         	VALUES  (
	            <cfqueryparam value = "#ARGUMENTS.name#"        cfsqltype = "cf_sql_varchar" >,
	            <cfqueryparam value = "#ARGUMENTS.email#"       cfsqltype = "cf_sql_varchar" >,
	            <cfqueryparam value = "#ARGUMENTS.dob#"         cfsqltype = "cf_sql_date"    >,
				<cfqueryparam value = "#ARGUMENTS.phone#"       cfsqltype = "cf_sql_bigint"  >,
				<cfqueryparam value = "#ARGUMENTS.address#"     cfsqltype = "cf_sql_varchar" >,
				<cfqueryparam value = "#LOCAL.hashedPassword#"  cfsqltype = "cf_sql_char"    >,
				<cfqueryparam value = "#LOCAL.salt#"            cfsqltype = "cf_sql_char"    >
				 )
			</cfquery>

			<cfreturn TRUE />

			<cfcatch type = "database">
				 <cfset APPLICATION.loggingObj.doLog("signup","submitDetail",cfcatch.message,cfcatch.detail) />
				<cfreturn FALSE />
			</cfcatch>

		</cftry>

	</cffunction>

	<!--- Method : It will update the student infor  --->
    <cffunction name = "updateProfile" access = "remote" returnformat = "JSON" returntype = "boolean">
		<cfargument name = "name"     required = "true" type = "string"   />
		<cfargument name = "dob"      required = "true" type = "date"     />
		<cfargument name = "phone"    required = "true" type = "numeric"  />
		<cfargument name = "address"  required = "true" type = "string"   />
		<cftry>
			<cfquery name="LOCAL.doUpdate">
				UPDATE ms_student
				SET		Name = <cfqueryparam value = "#ARGUMENTS.name#"        cfsqltype = "cf_sql_varchar" >,
		                dob = <cfqueryparam value = "#ARGUMENTS.dob#"         cfsqltype = "cf_sql_date"    >,
					    phone = <cfqueryparam value = "#ARGUMENTS.phone#"       cfsqltype = "cf_sql_bigint"  >,
					    address = <cfqueryparam value = "#ARGUMENTS.address#"     cfsqltype = "cf_sql_varchar" >
				WHERE email = <cfqueryparam cfsqltype = "cf_sql_varchar" maxlength = "50"
				                   value = "#SESSION.userEmail#">
			</cfquery>
			<cfreturn TRUE />
			<cfcatch>
				 <cfset APPLICATION.loggingObj.doLog("signup","updateProfile",cfcatch.message,cfcatch.detail) />
				<cfreturn FALSE />
			</cfcatch>
        </cftry>
	</cffunction>

</cfcomponent>
