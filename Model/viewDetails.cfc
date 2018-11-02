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



<!---  Method :  it will return student information   ---------------- --->

	<cffunction name = "getStudents" access = "public"  returntype = "query"  hint = "It will return student info">

		<cftry>
			<cfquery name = "students"  >
			   SELECT  Name,email,dob,phone,address,status
			   FROM    ms_student
			   WHERE   roles = 'student'; <!--- change --->
			</cfquery>
			<cfreturn students/>
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

<!--- ----- Method: it will return active testId       ------>
	<cffunction name = "getActiveTestId" access = "public" returntype = "numeric" hint = "It will return testId">
    	<cfargument name = "test" required = "true"  type ="string" />

	    <cfset LOCAL.getTestTime = getTestStartTime(ARGUMENTS.test) />

	    <cfif LOCAL.getTestTime.testId EQ "" >
			<cfreturn 0 />
		</cfif>
	    <cfset LOCAL.currentTime = DateTimeFormat(now(), "MM d yyyy HH:nn:ss ") />
	    <cfloop query = "LOCAL.getTestTime">
		     <cfset LOCAL.minute = Datediff("n",LOCAL.getTestTime.startTime,LOCAL.currentTime) />
		     <cfif LOCAL.minute LT 10 AND LOCAL.minute GT 0 >
			 	<cfreturn LOCAL.getTestTime.testId />
			 </cfif>
		</cfloop>
        <cfreturn 0 />
		<!--- <cftry>
			<cfquery name = "fetchTime">
				SELECT startTime,duration
				FROM   ms_test
				WHERE  test = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.TEST#">
			</cfquery>
			<cfreturn fetchTime />
			<cfcatch>
				<cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getTimeInfo]viewDetails" />
				<cfreturn queryNew("errID","Integer",{errId=-1}) />
			</cfcatch>
		</cftry> --->

	</cffunction>
<!--- Method : It will return subject and start time  --->
	<cffunction name = "getTestStartTime" access = "private" returntype = "query" hint = "It will return testId and startTime">
		<cfargument name = "subject" required = "true" type = "string" hint = "It will catch subject name">

			<cfquery name = "fetchTestStartTime">
				SELECT testId,startTime
				FROM ms_test
				WHERE test = <cfqueryparam cfsqltype = "cf_sql_varchar" maxlength = "50"
		                            value = "#ARGUMENTS.subject#">
			</cfquery>
			<cfreturn fetchTestStartTime />
	</cffunction>

<!--- Method: It will return test info based on testId --->getTestInfo
	<cffunction name = "getTestInfo" access = "public" returntype = "query" >
		<cfargument name = "testId"  required = "true"  type = "numeric" hint = "It will catch test Id">
		 <cftry>
				<cfquery name = "fetchTestInfo">
					SELECT test,startTime,duration,totalQuestion
					FROM   ms_test
					WHERE  testId = <cfqueryparam cfsqltype = "cf_sql_integer" value = "#ARGUMENTS.testId#">
				</cfquery>
				<cfreturn fetchTestInfo />
				<cfcatch>
					<cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getTestInfo]viewDetails" />
					<cfreturn queryNew("errID","Integer",{errId=-1}) />
				</cfcatch>
			</cftry>

	</cffunction>
<!-------- Method : it will return particular student detail based on Email --->

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


<!------------ Method :  It will show Marks of all students  ---------------------->

	<cffunction name = "getMarks" access = "public" returntype = "query" >

		<cftry>
			<cfquery name = "marks"  >
              SELECT     studentEmail,startDate,endDate,score,totalQuestion,subject,status
              FROM       ms_result
            </cfquery>
            <cfreturn marks />
            <cfcatch type = "database">
              <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getMarks]viewDetails" />
              <cfreturn queryNew("errID","Integer",{errId=-1}) />
			</cfcatch>
        </cftry>
	</cffunction>


<!--- Method : it will return Mark of one student based on Email ---------------->

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


<!--- Method : it will return question count array [active/total  ] for chart  ------------->

	<cffunction name = "quesInfoChart" returntype = "Any" access = "public" >
		<cfargument name = "quecInfo" required = "true" type = "string" />

		<cfset LOCAL.Array = arrayNew(1) />

<!--- -------------------------------------------------------------------------- --->
         <cfif ARGUMENTS.quecInfo EQ "active">
			<cfset LOCAL.activ = getActiveSubject() />
		     <cfloop query = "LOCAL.activ">
                <cfset   arrayAppend(LOCAL.Array,"#LOCAL.activ.active#","true") />
		    </cfloop>
		    <cfreturn LOCAL.Array />
		</cfif>
<!--- -------------------------------------------------------------------------- --->
		<cfif ARGUMENTS.quecInfo EQ "total">
		    <cfset LOCAL.getTotal = getTotalSubject() />
		     <cfloop query = "LOCAL.getTotal">
                <cfset   arrayAppend(LOCAL.Array,"#LOCAL.getTotal.total#","true") />
		    </cfloop>
		    <cfreturn LOCAL.Array />
		</cfif>
<!--- ------------------------------------------------------------------------------->
	</cffunction>


<!--- Method: It will return total question group by subject  ---------------------->
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

	<!--- Method : It will return 0 if student did`n attempt at past of this test else attempt count  --->
	<cffunction name = "isAttemptTest" access = "public" hint = "Check attempt test or not" returntype = "numeric">
		<cfargument name = "testId" required = "true" type = "numeric" />
			<cftry>
				<cfquery name = "LOCAL.isAttempt">
					SELECT COUNT(resultId) AS attemptCount
					FROM ms_result
					WHERE studentEmail = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#SESSION.userEmail#">
					      AND testId = <cfqueryparam cfsqltype = "cf_sql_integer" value = "#ARGUMENTS.testId#">
				</cfquery>
				<cfreturn LOCAL.isAttempt.attemptCount />
				<cfcatch type = "database">
					<cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[isAttemptTest]viewDetails" />
					<cfreturn -1 />
				</cfcatch>

			</cftry>

	</cffunction>

	<!--- Method : It will return scheduled test information  ----------------------->
	<cffunction name = "getSchedule" access = "public"  returntype = "query" hint = "fetch scheduled test info">
		<cftry>
			<cfquery name = "fetchSchedule">
				SELECT test,startTime,duration,totalQuestion
				FROM ms_test
			</cfquery>

			<cfreturn fetchSchedule />
			<cfcatch type = "database">
				<cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getSchedule]viewDetails" />
			    <cfreturn queryNew("errID","Integer",{errId=-1}) />
			</cfcatch>
		</cftry>
	</cffunction>


<!--- Method : it will return question information based on questionId -----------------------  --->

	<cffunction name = "getQuestionInfo"  access = "public"  returntype = "query" hint = "return question info">
		<cfargument name = "id" required = "true" type = "numeric" hint = "It will catch question ID" />
		<cftry>
			<cfquery name = "fetchQuestionInfo">
				SELECT  question,option1,option2,option3,option4,answer,subject
				FROM    ms_question
				WHERE questionId = <cfqueryparam cfsqltype = "cf_sql_integer" value = "#ARGUMENTS.id#" >
			</cfquery>
			<cfreturn fetchQuestionInfo  />
			<cfcatch type = "database">
				<cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getQuestionInfo]viewDetails" />
			    <cfreturn queryNew("errID","Integer",{errId=-1}) />
			</cfcatch>
		</cftry>
	</cffunction>

<!--- Method : It will return total number of active question count of a particular subject --->
	<cffunction  name = "getTotalActiveQuestion" access = "remote" returnformat = "JSON"  returntype = "numeric" hint = "return count active question">
		<cfargument name = "subject" required = "true" type = "string" hint = "Catch subject name " />
		<cftry>
		<cfquery name = "LOCAL.fetch">
			SELECT COUNT(questionId) AS countActiveQuestion
			FROM ms_question
			WHERE subject = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.subject#">
			       AND status = 1
		</cfquery>
		<cfreturn LOCAL.fetch.countActiveQuestion />
		<cfcatch>
			<cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getTotalActiveQuestion]viewDetails" />
			<cfreturn -1 />
		</cfcatch>
		</cftry>
	</cffunction>

<!--- Method: It will return all test start time and duration of particular subject  --->
	<cffunction name = "getTimeDuration" access = "public" returntype = "query" >
		<cfargument name = "subject" required = "true" type = "string"  hint = "It will catch subject name"/>

		<cfquery name = "LOCAL.fetchTime">
			SELECT startTime,duration
			FROM ms_test
			WHERE test = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.subject#">
		</cfquery>
		<cfreturn LOCAL.fetchTime />

	</cffunction>
<!--- Method : It will check student is allowed or not  ---------------  --->
	<cffunction name = "isAllow" access = "public" hint = "check admin allow or not " returntype = "numeric">
		<cfargument name = "testName" required = "true" type = "string" />
			<!--- <cftry> --->
				<cfquery name = "LOCAL.returnIsAllow">
					SELECT status
					FROM ms_result
					WHERE studentEmail = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#SESSION.userEmail#">
					      AND subject = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.testName#">
				</cfquery>
				<cfreturn  LOCAL.returnIsAllow.status />
				<!--- <cfcatch type = "database">
					<cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[isAllow]viewDetails" />
					<cfreturn -1 />
				</cfcatch>

			</cftry> --->

	</cffunction>




</cfcomponent>