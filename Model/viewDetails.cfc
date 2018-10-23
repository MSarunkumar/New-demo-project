<!---
  --- viewDetails
  --- -----------
  ---
  --- It will fetch the data and return to calling function.
  ---
  --- author: mindfire
  --- date:   9/25/18
  --->
<cfcomponent hint = "It will fetch the data and return to calling function." accessors = "true" output = "false" persistent = "false">



<!---  Method : ---- it will return student information  --->

	<cffunction name = "getStudents" access = "remote"  returntype = "query" >

		<cftry>
			<cfquery name = "students"  >
			   SELECT  Name,email,dob,phone,address,status
			   FROM    ms_student
			   WHERE   roles like 'student';
			 </cfquery>

			<cfreturn students />
			<cfcatch type = "database">
			  <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getStudents]viewDetails" />
              <cfreturn queryNew("errID","Integer",{errId=-1}) />
			</cfcatch>
    	 </cftry>
	</cffunction>



<!---  Method :  it will return all question information  --------------------->

	<cffunction name = "getQuestions" access = "public" returntype = "query" >
		 <cftry>
             <cfquery name = "question"  >
               SELECT    questionId,question,option1,option2,option3,option4,answer,subject,status
               FROM      ms_question
             </cfquery>
             <cfreturn question />
             <cfcatch type = "database">
               <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getQuestions]viewDetails" />
               <cfreturn queryNew("errID","Integer",{errId=-1}) />
			</cfcatch>
		</cftry>
	</cffunction>



<!-------------- Method : it will return particular student detail based on Email --->

	<cffunction name = "getStudent" access = "public" returntype = "query" >
		<cfargument name = "email" required = "yes" type = "string" >
		<cftry>
			<cfquery name = "student"  >
              SELECT    Name,email,dob,phone,address
              FROM      ms_student
              WHERE     email = <cfqueryparam cfsqltype = "cf_sql_varchar" maxlength = "50"
	                            value = "#ARGUMENTS.email#">
			</cfquery>
         	<cfreturn student />
        	<cfcatch type = "database">
         	  <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getStudent]viewDetails" />
              <cfreturn queryNew("errID","Integer",{errId=-1}) />
		 	</cfcatch>
		</cftry>

	</cffunction>

<!------------ Method :  It will show Marks of all students  ------------------------->

	<cffunction name = "getMarks" access = "public" returntype = "query" >

		<cftry>
			<cfquery name = "marks"  >
              SELECT     studentEmail,startDate,endDate,score,totalQuestion,subject
              FROM       ms_result
            </cfquery>
            <cfreturn marks />
            <cfcatch type = "database">
              <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getMarks]viewDetails" />
              <cfreturn queryNew("errID","Integer",{errId=-1}) />
			</cfcatch>
        </cftry>
	</cffunction>


<!--- Method : it will return Mark of one student based on Email --->
	<cffunction name = "getMark" access = "public" returntype = "query" >

		<cftry>
			<cfquery name = "mark"  >
			  SELECT    startDate,endDate,score,totalQuestion,subject
			  FROM      ms_result
			  WHERE     studentEmail = <cfqueryparam cfsqltype = "cf_sql_varchar" maxlength = "50"
			                   value = "#SESSION.userEmail#">
			</cfquery>
			<cfreturn mark />
			<cfcatch type = "database">
			  <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getMark]viewDetails" />
			  <cfreturn queryNew("errID","Integer",{errId=-1}) />
			</cfcatch>
		</cftry>
	</cffunction>

<!--- Method : it will return activity of student [he is taking the test or not ]  --->
	<cffunction name = "getActivity" access = "public" hint = "Return active column value [0/1]"
				returntype = "numeric" output = "false" >

		<cftry>
			<cfquery name = "fetchActivity">
				SELECT active
				FROM   ms_student
				WHERE  email = <cfqueryparam cfsqltype = "cf_sql_varchar" maxlength = "50"
			                                 value = "#SESSION.userEmail#">
			</cfquery>
			<cfreturn  fetchActivity.active />
			<cfcatch type = "database">
				<cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getActivity]viewDetails" />
			    <cfreturn -1/>
			</cfcatch>
		</cftry>

	</cffunction>
<!--- Method : it will return question count array [active/total  ]--->
	<cffunction name = "quesInfoChart" returntype = "Any" access = "public" >
		<cfargument name = "quecInfo" required = "true" type = "string" />

		<cfset LOCAL.Array = arrayNew(1) />


         <cfif ARGUMENTS.quecInfo EQ "active">
			<cfset LOCAL.activ = getActiveSubject() />

		     <cfloop Query = "LOCAL.activ">
                <cfset   arrayAppend(LOCAL.Array,"#activ.active#","true") />
		    </cfloop>

		    <cfreturn LOCAL.Array />
		</cfif>

		<cfif ARGUMENTS.quecInfo EQ "total">
		    <cfset LOCAL.getTotal = getTotalSubject() />
		     <cfloop Query = "LOCAL.getTotal">
                <cfset   arrayAppend(LOCAL.Array,"#getTotal.total#","true") />
		    </cfloop>
		    <cfreturn LOCAL.Array />
		</cfif>

	</cffunction>

	<!--- Method: It will return total question group by subject  --->
	<cffunction name = "getTotalSubject" access = "private" hint = "Return total question group by subject"
				returntype = "Query" output = "false" >

		<cftry>
			<cfquery name = "fetchTotal">
				SELECT   COUNT(status) as total
                FROM     ms_question
                GROUP BY subject
				ORDER BY subject
			</cfquery>
			<cfreturn  fetchTotal />
			<cfcatch type = "database">
				<cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getActivity]viewDetails" />
			    <cfreturn queryNew("errID","Integer",{errId=-1}) />
			</cfcatch>
		</cftry>

	</cffunction>
	<!--- Method :It will return total active question group by subject    ------- --->
	<cffunction name = "getActiveSubject" access = "private" hint = "Return total active question group by subject"
				returntype = "Query" output = "false" >

		<cftry>
			<cfquery name = "fetchActive">
				SELECT COUNT(status) as active
                FROM ms_question
                WHERE status = 1
                GROUP BY subject,status
				ORDER BY subject
			</cfquery>
			<cfreturn  fetchActive />
			<cfcatch type = "database">
				<cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getActivity]viewDetails" />
			    <cfreturn queryNew("errID","Integer",{errId=-1}) />
			</cfcatch>
		</cftry>

	</cffunction>






</cfcomponent>