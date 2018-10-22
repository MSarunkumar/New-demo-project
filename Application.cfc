<cfcomponent hint = "This is Application cfc for Online Exam System Project" accessors = "true"
	output = "false" persistent = "false">

	<cfset THIS.name = "onlineExam13" />
	<cfset THIS.applicationTimeout = CreateTimeSpan(0, 2,0, 0) />
	<cfset THIS.sessionManagement = TRUE />
	<cfset THIS.sessionTimeout = CreateTimeSpan(0, 0,1, 0) />
    <cfset THIS.datasource = "demoProject" />

	<!--------------- Method [ OnApplicationStart ] -------------->

	<cffunction name = "OnApplicationStart" access = "public" returntype = "boolean" output = "false"
		        hint = "Fires when the application start">
		<cffile action = "write" file = "D:/Errors/project.txt" output = "Application has been started,all errors in project " />
          <cfset APPLICATION.signupObj = CreateObject("component", "Model.signup")               />
		  <cfset APPLICATION.loginObj = CreateObject("component", "Model.login")                 />
		  <cfset APPLICATION.logoutObj = CreateObject("component", "Model.logout")               />
          <cfset APPLICATION.takeTestObj = CreateObject("component", "Model.takeTest")           />
          <cfset APPLICATION.viewDetailsObj = CreateObject("component", "Model.viewDetails")     />
		  <cfset APPLICATION.blockUnblockObj = CreateObject("component", "Model.blockUnblock")   />

		<cfreturn TRUE />
	</cffunction>

	<!---       Method [ onSessionStart ]     --->

	<cffunction name = "OnSessionStart" access = "public" returntype = "boolean" output = "false" >


		<cfreturn TRUE />
	</cffunction>

	<!---       Method [ onRequestStart ]     --->

	<cffunction name = "OnRequestStart" access = "public" returntype = "boolean" output = "false"
		        hint = "Fires when the user request to next page" >



		<cfreturn TRUE />
	</cffunction>

	<!---   Method [onMissingTemplate]   --->

  	<cffunction name = "onMissingTemplate" access = "public" >
	<cfargument  name = "targetPage" type = "string" required = "true" />

		<cftry>
		        <cflog type = "error" text = "Missing template: #Arguments.targetPage#">

			    <cfoutput><center>
				<h1>
					#Arguments.targetPage# could not be found.
				</h1>
			    <h3>
				You requested a non-existent ColdFusion page.
				<br>
				Please check the URL/Go Back
			    </h3></center>
		        </cfoutput>
		        <cfreturn TRUE />
		     <cfcatch>
			    <cfreturn FALSE />
		     </cfcatch>
		</cftry>
	</cffunction>





<!--- Method [onRequest] --->
	 <cffunction name = "OnRequest" access = "public" returntype = "void" output = "true"
		                            hint = "Fires after pre page processing is complete.">
		 <cfargument name = "TargetPage" type = "string" required = "TRUE"/>
         <cfinclude template = "#ARGUMENTS.TargetPage#" />

		<cfreturn />
	</cffunction>
<!--- Method [OnRequestEnd] --->

	<cffunction name = "OnRequestEnd" access = "public" returntype = "void" output = "true"
		                              hint = "Fires after the page processing is complete.">

		<cfreturn />
	</cffunction>

<!--- Method [OnSessionEnd] --->

	<cffunction name = "OnSessionEnd" access = "public" returntype = "void" output = "true"
		hint = "Fires when the session is terminated.">

        <cfset VARIABLES.testStatus = APPLICATION.viewDetailsObj.getActivity() />
		<cfif  VARIABLES.testStatus EQ 1>
			<cfset  APPLICATION.takeTestObj.changeActivity() />
		</cfif>

		<cfreturn />
	</cffunction>

<!--- Method [OnApplicationEnd] --->
	<cffunction name = "OnApplicationEnd" access = "public" returntype = "void" output = "true"
		hint = "Fires when the application is terminated.">
		<cfargument name = "ApplicationScope" type = "struct" required = "FALSE"
			default = "#StructNew()#" />

	    <cflog file = "#This.Name#" type = "Information"
			text = "Application #Arguments.ApplicationScope.applicationname# Ended" >
		<cfreturn />
	</cffunction>

	<!--- Method [OnError] --->
	 <cffunction name = "OnError" access = "public" returntype = "void" output = "true"
		                          hint = "Fires when an exception occures that is not caught by a try/catch.">
		<cfargument name = "Exception" type = "any" required = "true" />
		<cfargument type = "String" name = "EventName" required = "true"/>
		    <!------------------- Log all errors. --------------------->

         <cflog file = "#This.Name#" type = "error"
            text = "Event Name: #ARGUMENTS.Eventname#"  />

		 <cflog file = "#This.Name#" type = "error"
            text = "Message: #ARGUMENTS.Exception.message#" />


			<!--- Display an error message if there is a page context. --->
            <cfif NOT (ARGUMENTS.EventName IS "onSessionEnd") OR
                      (ARGUMENTS.EventName IS "onApplicationEnd")>
                       <cfoutput>
                              <h2>An unexpected error occurred.</h2>
                              <p>Please provide the following information to technical support:</p>
                              <p>Error Event: #Arguments.EventName#</p>
                              <p>Error details:<br>
                              <cfdump var = #ARGUMENTS.Exception#></p>
                         </cfoutput>
               </cfif>

		<cfreturn />
	</cffunction>

</cfcomponent>
