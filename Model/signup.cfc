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
				<cfquery name = "checkEmail">
				   SELECT email
				   FROM   ms_student
				   WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.email#">
				</cfquery>

				<cfreturn checkEmail.RecordCount />

		        <cfcatch type = "database">
				<cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..fun[emailExist]signup.cfc" />
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
        	<cfquery name = "insertQuery" >
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
			<cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..fun[submitDetail]signup.cfc" />
			<cfreturn FALSE />
			</cfcatch>

		</cftry>

	</cffunction>


</cfcomponent>
