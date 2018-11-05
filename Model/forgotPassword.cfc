<!---
	--- forgotPassword
	--- --------------
	---
	--- This is for send link and reset password .
	---
	--- author: mindfire
	--- date:   9/21/18
	--->
<cfcomponent hint = "This is for sending a link and reset password" accessors = "true"
             output = "false" persistent = "false">

<!--- Method : Check Email from ms_password return recordcount -------------- --->

	<cffunction name = "emailExist" returntype = "numeric" access = "public" hint = "It will return no. of record">
		<cfargument name = "email" hint = "It will catch the email" required = "true" type = "string" />
        <cftry>
		      <cfquery name = "LOCAL.checkEmail" >
	            SELECT pid
	            FROM   ms_password
	            WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.email#">
              </cfquery>
              <cfreturn LOCAL.checkEmail.RecordCount>
		      <cfcatch>
 			  <cfset APPLICATION.loggingObj.doLog("forgotPassword","emailExist",cfcatch.message,cfcatch.detail) />
			  <cfreturn -1 />
		      </cfcatch>
		</cftry>
	</cffunction>

<!---------------- Method : It store the details of sended Link like[Email,guid,time] ----------->

	<cffunction name = "submitData" access = "public" returntype = "boolean" >
		<cfargument name = "email" required = "true" type = "string" hint = "It will catch email" />
		<cfargument name = "guid"  required = "true" type = "string" hint = "It will catch guid"  />
    	<cfset LOCAL.currentTime = DateTimeFormat(now(), "MM d yyyy HH:nn:ss ") />
        <cftry>
			   <cfquery name = "LOCAL.insertData" >
	             INSERT  INTO  ms_password (email,guids,times)
                         VALUES (
                        <cfqueryparam value = "#ARGUMENTS.email#"   cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#ARGUMENTS.guid#"    cfsqltype = "cf_sql_char">,
						<cfqueryparam value = "#LOCAL.currentTime#" cfsqltype = "cf_sql_timestamp">
						)
               </cfquery>
               <cfreturn TRUE />
		       <cfcatch type = "database">
		       	  <cfset APPLICATION.loggingObj.doLog("forgotPassword","submitData",cfcatch.message,cfcatch.detail) />
		         <cfreturn FALSE />
			   </cfcatch>
		</cftry>
	</cffunction>

<!--- Method : It will return the send time of link from ms_password table --------------------->

	<cffunction name = "getTime" returntype = "string" access = "public" hint = "It will return time">
		<cfargument name = "guid" hint = "It will catch guid" required = "true" type = "string" />
         <cftry>
		        <cfquery name = "LOCAL.timeQuery">
		          SELECT times
		          FROM   ms_password
		          WHERE  guids = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.guid#">
                </cfquery>
                <cfreturn LOCAL.timeQuery.times>
                <cfcatch type = "database">
		           <cfset APPLICATION.loggingObj.doLog("forgotPassword","getTime",cfcatch.message,cfcatch.detail) />
                  <cfreturn "" />
				</cfcatch>
		  </cftry>
	</cffunction >

<!----------- Method : It will send email with Link  -------------------------------->
		<cffunction name = "sendEmail" access = "public" hint = "Send email with guid">

			<cfargument name = "from"  required = "true" type = "string">
			<cfargument name = "to"    required = "true" type = "string">
		    <cfargument name = "guid"  required = "true" type = "string">


		   	<cfmail from = "#ARGUMENTS.from#" to = "#ARGUMENTS.to#" subject = "Recover Password " type = "html">
               <h3>
                Hello,
                        This is for Reset password link from Online exam system.
                        Please Click on following link within one hrs,after one hrs it will be expired.
                </h3>
                   <h2>Link</h2>
                  <a href = "http://172.16.9.95:5000/OnlineExam2/View/resetPassword.cfm?id=#ARGUMENTS.guid#">Please Click here</a>
            </cfmail>
		</cffunction>


<!---------      Method : It will do update the password    ------------------------------------------>

	<cffunction name = "resetPassword" access = "public" returntype = "boolean">
		<cfargument name = "id"   required = "true" type = "string" />
	    <cfargument name = "pass" required = "true" type = "string" />
	    <cfargument name = "salt" required = "true" type = "string" />
        <cftry>
              <cfquery name = "reset">
	           	UPDATE ms_student
		        SET    password = <cfqueryparam cfsqltype = "cf_sql_char"     value = "#ARGUMENTS.pass#">,
		               salt = <cfqueryparam cfsqltype = "cf_sql_char"         value = "#ARGUMENTS.salt#">
		        WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar"     value = "#ARGUMENTS.id#">
	          </cfquery>
	          <cfreturn TRUE />
              <cfcatch type = "database">
		      	<cfset APPLICATION.loggingObj.doLog("forgotPassword","resetPassword",cfcatch.message,cfcatch.detail) />
		      	<cfreturn FALSE />
			  </cfcatch>
		</cftry>

	</cffunction>

  <!------------------      Method : It will return GUID     ------------------------>

	<cffunction name = "getGuid" access = "public" returntype = "string">
		<cfquery name = "guid" >
		 SELECT Newid() as id;
		</cfquery>

		<cfreturn guid.id />
	</cffunction>

   <!----------------    Method : It will return email based on guid   -------------->
	<cffunction name = "getEmail" access = "public" returntype = "string">
		<cfargument name = "guid" required = "true" type = "string">
		<cftry>
	        <cfquery name = "LOCAL.returnEmail">
	       	   SELECT email
		       FROM   ms_password
		       WHERE  guids = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.guid#">
	         </cfquery>
	         <cfreturn LOCAL.returnEmail.email />
	         <cfcatch type = "database">
	           <cfset APPLICATION.loggingObj.doLog("forgotPassword","getEmail",cfcatch.message,cfcatch.detail) />
		       <cfreturn  "" />
			 </cfcatch>
		</cftry>
	</cffunction>


</cfcomponent>
