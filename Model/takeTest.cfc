<!---
	--- takeTest
	--- --------
	---
	--- It is for getting question at test time.
	---
	--- author: mindfire
	--- date:   9/26/18
	--->
<cfcomponent hint = "It is for getting question at test time." accessors = "true" output = "false" persistent = "false">

	<!--- Method 1  will return question with options and answer --->


	<cffunction name = "getQuestions" returntype = "query" access = "remote" returnformat = "JSON">
		<cfargument name = "qid" type = "any" required = "yes">

		<cfset LOCAL.qd = LSParseNumber(qid) />

		<cftry>
	        <cfquery name = "fetchQuestion">
		        SELECT    question,option1,option2,option3,option4,answer
		        FROM      ms_question
		        WHERE     questionId = <cfqueryparam cfsqltype = "cf_sql_integer" value = "#LOCAL.qd#">
	        </cfquery>
	        <cfreturn fetchQuestion />
	        <cfcatch type = "database">
		        <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getQuestions]takeTest" />
	            <cfreturn queryNew("errID","Integer",{errId=-1}) />
			</cfcatch>
		</cftry>

	</cffunction>


	<!---    Method   It will return questionId based on total no. of question and active state   --->

	<cffunction name = "getQuestionId" returntype = "numeric" access = "remote" returnformat = "JSON">
		<cfargument name = "qno" type = "numeric" required = "true" hint="It will catch no. of question">
		<cfargument name = "sub" type = "string"  required = "true" hint="It will catch subject">
		<cftry>
	       <cfquery name = "getId" >
	          SELECT TOP 1 questionId AS qid
                     FROM  ( SELECT DISTINCT TOP #ARGUMENTS.qno# questionId FROM ms_question
				          WHERE (subject = <cfqueryparam value = "#ARGUMENTS.sub#" cfsqltype = "cf_sql_varchar">
				                 AND status = 1)
                             ORDER BY questionId DESC) bb
                             ORDER BY questionId
               </cfquery>
	        <cfreturn getId.qid  />
	        <cfcatch type = "database">
	           <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[getQuestionId]takeTest" />
               <cfreturn -1 />
			</cfcatch>
		</cftry>
     </cffunction>


	<!--- Method:  it will submit the result of test --- --->

	<cffunction name = "submitScore" access = "remote" returntype = "boolean"  returnformat = "JSON">
        <cfargument name = "score" required = "true"   type = "numeric" hint = "It will catch score"/>
		<cfargument name = "totalQuestion" required = "true"   type = "numeric" hint = "Total question in test"/>
		<cfargument name = "subject" required = "true"   type = "string" hint = "Test name"/>
		<cfargument name = "testId" required = "true" type = "numeric" hint = "It will catch testId" />

		<cfset LOCAL.currentTime = #DateTimeFormat(now(), "MM d yyyy HH:nn:ss")# />
        <cftry>
			<cfquery name = "submitResult" >
	         INSERT INTO ms_result (studentEmail,startDate,endDate,score,totalQuestion,subject,testId)
                    VALUES(
	                  <cfqueryparam value = "#SESSION.userEmail#"       cfsqltype = "cf_sql_varchar" >,
		              <cfqueryparam value = "#SESSION.startTime#"       cfsqltype = "cf_sql_timestamp" >,
		              <cfqueryparam value = "#LOCAL.currentTime#"       cfsqltype = "cf_sql_timestamp" >,
		              <cfqueryparam value = "#ARGUMENTS.score#"         cfsqltype = "cf_sql_integer" >,
		              <cfqueryparam value = "#ARGUMENTS.totalQuestion#" cfsqltype = "cf_sql_integer" >,
		              <cfqueryparam value = "#ARGUMENTS.subject#"       cfsqltype = "cf_sql_varchar" >,
		              <cfqueryparam value = "#ARGUMENTS.testId#"        cfsqltype = "cf_sql_integer" >
                      )
	        </cfquery>
	        <!--- Change the activity of student --->
	        <cfset LOCAL.isChangeActive = APPLICATION.takeTestObj.changeActivity() />
	        <cfif LOCAL.isChangeActive EQ FALSE >
		       <cfreturn FALSE />
	        </cfif>

            <cfreturn TRUE />
	        <cfcatch type = "database">
	           <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..#now()#..fun[submitScore]takeTest" />
               <cfreturn FALSE />
		    </cfcatch>
		</cftry>

  </cffunction>


	<!--- Method:  It will return total number of questions based on subject    --->

	<cffunction name = "totalQuestion" access = "remote" returntype = "numeric" returnformat = "JSON">
		<cfargument name = "sub" required = "true" type = "string" hint = "It will catch subject name">
		<cftry>
		   <cfquery name = "totalNo">
               SELECT COUNT(questionId) AS total
               FROM   ms_question
               WHERE  (subject = <cfqueryparam value = "#ARGUMENTS.sub#" cfsqltype = "cf_sql_varchar">
                               AND status = 1)
           </cfquery>
	       <cfreturn totalNo.total>
	       <cfcatch type = "database"   >
		       <cflog file = "onlineExamErrorLog" text = "#cfcatch.message# #cfcatch.detail#..fun[totalQuestion]takeTest" />
               <cfreturn -1 />
		   </cfcatch>
		</cftry>
	</cffunction>

<!---  Method : It will update the value of active in ms_student table  -------------------------->
 	<cffunction name = "changeActivity" access = "public" hint = "Update active column in table" returntype = "boolean">
		<cftry>
			<cfquery name = "updateActive">
              UPDATE ms_student
			  SET  active = CASE
			                   WHEN active = 1 THEN 0
			                   ELSE 1
			                END
			  WHERE email = <cfqueryparam cfsqltype = "cf_sql_varchar" maxlength = "50"
			                              value = "#SESSION.userEmail#">

			</cfquery>
			<cfreturn TRUE />
			<cfcatch type = "database">
			  <cflog file = "onlineExamErrorLog" text="#cfcatch.message# #cfcatch.detail#..fun[changeActivity]takeTest" />
			  <cfreturn FALSE />
			</cfcatch>
		</cftry>

	</cffunction>

	<!---  Method : It will return info about user is online or not    ------------------------------- --->
	<cffunction name = "isOnline" access = "remote" returnformat = "JSON" returntype = "string">

		 <cfif structKeyExists(SESSION,"student")>
		   <cfreturn "online" />
		 </cfif>

		 <cfreturn "offline" />

	</cffunction>

	<!---        Method : It will update test time  --------------------------->

	<cffunction name ="updateTestTime" access = "remote" returntype = "boolean" returnformat = "JSON">
		<cfargument name = "testName" required = "true" type = "string" />
		<cfargument name = "startTime" required = "true" type = "date"  />
		<cfargument name = "duration"  required = "true" type = "numeric" />
		<cfargument name = "totalQuestion" required = "true" type = "numeric" />
		<cftry>
			<cfquery name = "doUpdateTestTime">
				INSERT INTO  ms_test (test,startTime,duration,totalQuestion)
				       VALUES (
				       <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.testName#">,
				       <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#ARGUMENTS.startTime#"> ,
				       <cfqueryparam cfsqltype = "cf_sql_integer" value = "#ARGUMENTS.duration#">,
			           <cfqueryparam cfsqltype = "cf_sql_integer" value = "#ARGUMENTS.totalQuestion#">
			           )
			</cfquery>
	        <cfreturn TRUE />
	        <cfcatch type="database">
		      <cflog file = "onlineExamErrorLog" text="#cfcatch.message# #cfcatch.detail#..fun[updateTestTime]takeTest" />
			  <cfreturn FALSE />
			</cfcatch>
		</cftry>

	</cffunction>

<!--- Method :  Two test can not be overlap of same subject if overlap return false else true   --->
	<cffunction name = "isOverlap" access = "remote" returnformat = "JSON" returntype = "boolean" hint = "return true if overlap">
		<cfargument name = "subject" required = "true" type = "string" hint = "It will catch subject name"/>
		<cfargument name = "startTime" required = "true" type = "date" hint = "It will catch start time" />
		<cfargument name = "duration" required = "true" type = "numeric" hint = "It will catch duration of test"/>

		<cfset LOCAL.dbTimeDuration = APPLICATION.viewDetailsObj.getTimeDuration(ARGUMENTS.subject) />

		<!--- If admin set the test first time so no need of check time limit return true --->
		<cfif LOCAL.dbTimeDuration.RecordCount EQ 0><cfreturn TRUE /></cfif>

		<!--- Getting formate so we can take currect difference of datetime --->
        <cfset LOCAL.currentStartTime = DateTimeFormat(ARGUMENTS.startTime, "MM d yyyy HH:nn:ss ") />

		<!--- Check each test time so they can not overlap --->
		<cfloop query = "LOCAL.dbTimeDuration">

		   <cfset LOCAL.dbStartTime = DateTimeFormat(LOCAL.dbTimeDuration.startTime, "MM d yyyy HH:nn:ss ") />
		   <cfset LOCAL.minuteDiff =  Datediff("n",LOCAL.dbStartTime,LOCAL.currentStartTime ) />

		   <cfif LOCAL.minuteDiff EQ 0> <cfreturn FALSE/></cfif>
           <!--- If difference is +ve means future time from db test --->
		   <cfif LOCAL.minuteDiff GT 0>
		        <cfif LOCAL.dbTimeDuration.duration GTE LOCAL.minuteDiff >
					<cfreturn  FALSE/>
			    </cfif>
			</cfif>

			<!---If difference is -ve means past time from db test  --->
			<cfif LOCAL.minuteDiff LT 0>
				<cfif abs(LOCAL.minuteDiff) LTE ARGUMENTS.duration>
					<cfreturn FALSE />
				</cfif>
			</cfif>
		</cfloop>
        <!--- ----------------------------------------------------- --->
		<cfreturn TRUE />
	</cffunction>

	<!--- Method : Get current time  --->
	<cffunction  name = "getCurrentTime" access = "public"  returntype = "date">
	   <cfreturn DateTimeFormat(now(), "MM d yyyy HH:nn:ss ") />
	</cffunction>

</cfcomponent>
