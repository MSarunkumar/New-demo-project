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
		      <cfquery name = "checkEmail" >
	            SELECT pid
	            FROM   ms_password
	            WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.email#">
              </cfquery>
              <cfreturn checkEmail.RecordCount>
		      <cfcatch>
	            <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..fun[emailExist]FP">
	            <cfreturn -1 />
		      </cfcatch>
		</cftry>
	</cffunction>

<!---
Method : if user want to resend link than we have to delete previouse record,So it will Delete the stored record

	<cffunction name = "deleteRecord" access = "public" hint = "It will delete the record" returntype = "boolean">
		<cfargument name = "email" hint = "It will catch the email" required = "true" type = "string" />
        <cftry>
			  <cfquery name = "delete">
		         DELETE
		         FROM   ms_password
		         WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.email#">
              </cfquery>
			  <cfreturn TRUE />
              <cfcatch type = "database">
			     <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..fun[deleteEmail]FP" />
			     <cfreturn FALSE />
			  </cfcatch>
		</cftry>
	</cffunction >
 --->

<!---------------- Method : It store the details of sended Link like[Email,guid,time] ----------->

	<cffunction name = "submitData" access = "public" returntype = "boolean" >
		<cfargument name = "email" required = "true" type = "string" hint = "It will catch email" />
		<cfargument name = "guid"  required = "true" type = "string" hint = "It will catch guid"  />
    	<cfset var currentTime = #DateTimeFormat(now(), "MM d yyyy HH:nn:ss ")# />
        <cftry>
			   <cfquery name = "insertData" >
	             INSERT  INTO  ms_password (email,guids,times)
                         VALUES (
                        <cfqueryparam value = "#ARGUMENTS.email#"   cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#ARGUMENTS.guid#"    cfsqltype = "cf_sql_char">,
						<cfqueryparam value = "#LOCAL.currentTime#" cfsqltype = "cf_sql_timestamp">
						)
               </cfquery>
               <cfreturn TRUE />
		       <cfcatch type = "database">
		       	 <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..fun[emailExist]FP">
		         <cfreturn FALSE />
			   </cfcatch>
		</cftry>
	</cffunction>

<!--- Method : It will return the send time of link from ms_password table --------------------->

	<cffunction name = "getTime" returntype = "string" access = "public" hint = "It will return time">
		<cfargument name = "guid" hint = "It will catch guid" required = "true" type = "string" />
         <cftry>
		        <cfquery name = "timeQuery">
		          SELECT times
		          FROM   ms_password
		          WHERE  guids = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.guid#">
                </cfquery>
                <cfreturn timeQuery.times>
                <cfcatch type = "database">
		          <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..fun[getTime]FP">
                  <cfreturn "" />
				</cfcatch>
		  </cftry>
	</cffunction >

<!----------- Method : It will send email with Link  -------------------------------->
		<cffunction name = "sendEmail" access = "public">
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
		      	<cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..fun[resetPassword]FP">
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
	        <cfquery name = "returnEmail">
	       	   SELECT email
		       FROM   ms_password
		       WHERE  guids = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.guid#">
	         </cfquery>
	         <cfreturn returnEmail.email />
	         <cfcatch type = "database">
	           <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..fun[getEmail]FP">
		       <cfreturn  "" />
			 </cfcatch>
		</cftry>
	</cffunction>


</cfcomponent>
