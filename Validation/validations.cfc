<!---
	--- NewCFComponent
	--- --------------
	---
	--- This is for validation (server side).
	---
	--- author: mindfire
	--- date:   10/5/18
	--->
<cfcomponent hint = "This is for new registration validation." accessors = "true" output = "false" persistent = "false">

<!-------------------------- Method: for signup form validation  ----------------->

	<cffunction  name = "signupValid" access = "remote" hint = "This is for signup validation"
				                  returntype = "boolean" returnformat = "JSON" >

		    <cfargument name = "name"      required = "true"  type = "string"  />
		    <cfargument name = "email"     required = "true"  type = "string"  />
		    <cfargument name = "date"      required = "true"  type = "date"    />
		    <cfargument name = "mobile"    required = "true"  type = "numeric" />
		    <cfargument name = "password"  required = "true"  type = "string"  />
		    <cfargument name = "cpassword" required = "true"  type = "string"  />
		    <cfargument name = "address"   required = "true"  type = "string"  />


	                <cfset  LOCAL.valid = TRUE />

				    <cfif NOT isValid("regex", trim(ARGUMENTS.name), "[A-Za-z ]+") >
							<cfset LOCAL.valid = FALSE />
					</cfif>

			        <cfif NOT isValid("regex", trim(ARGUMENTS.email),"^([a-zA-Z0-9_\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$")>
				    	 <cfset LOCAL.valid = FALSE />
				    </cfif>

				     <!--- Check future date --->

		      		<cfset LOCAL.todayDate = DateFormat(now(), "mm/dd/yyyy") />
		      		<cfset LOCAL.studentDob = ARGUMENTS.date />
					<cfif DateCompare(LOCAL.todayDate,LOCAL.studentDob) EQ -1>
					  		<cfset LOCAL.valid = FALSE />
					</cfif>

				    <cfif (NOT isValid("regex", trim(ARGUMENTS.mobile),"[0-9]{10}") OR ARGUMENTS.mobile EQ 0)>
					  		<cfset LOCAL.valid = FALSE />
				    </cfif>

				    <cfif NOT (len(ARGUMENTS.password) GTE 8 AND refind('[A-Z]',ARGUMENTS.password)
					        AND refind('[a-z]',ARGUMENTS.password) AND refind('[0-9]',ARGUMENTS.password)
					        AND refind('[!@##$&* = -{}<>,.:;|?""''~]',ARGUMENTS.password ) )>
					      	<cfset LOCAL.valid = FALSE />
				    </cfif>

				    <cfif compare(trim(ARGUMENTS.password),trim(ARGUMENTS.cpassword))>
					   		<cfset LOCAL.valid = FALSE />
				    </cfif>

				    <cfif (len(trim(ARGUMENTS.address)) LTE 0) >
					   		<cfset LOCAL.valid = FALSE />
				    </cfif>

			<cfreturn LOCAL.valid />
	</cffunction>


<!-------------------- Method: for question and answers validation  ---------------------->
	<cffunction name = "questionValid" access = "remote" hint = "It will check question and option [empty/duplicates]"
			                           returntype="boolean" returnformat="JSON">

			<cfargument name = "sub"   required = "true"  type = "string"  />
		    <cfargument name = "ques"  required = "true"  type = "string"  />
		    <cfargument name = "op1"   required = "true"  type = "string"  />
		    <cfargument name = "op2"   required = "true"  type = "string"  />
		    <cfargument name = "op3"   required = "true"  type = "string"  />
		    <cfargument name = "op4"   required = "true"  type = "string"  />
		    <cfargument name = "ans"   required = "true"  type = "string"  />

				<cfset LOCAL.valid = TRUE />
			 		<cfif (len( trim(ARGUMENTS.ques)) GTE 900) OR ((len( trim(ARGUMENTS.ques))) LT 1 ) >
						<cfset LOCAL.valid = FALSE />
			        </cfif>
			        <cfif (len( trim(ARGUMENTS.op1)) GTE 250) OR ((len( trim(ARGUMENTS.op1))) LT 1 ) >
				        <cfset LOCAL.valid = FALSE />
			        </cfif>
			        <cfif (len( trim(ARGUMENTS.op2)) GTE 250) OR ((len( trim(ARGUMENTS.op2))) LT 1 ) >
				        <cfset LOCAL.valid = FALSE />
			        </cfif>
			        <cfif (len( trim(ARGUMENTS.op3)) GTE 250) OR ((len( trim(ARGUMENTS.op3))) LT 1 ) >
				        <cfset LOCAL.valid = FALSE />
			        </cfif>
			        <cfif (len( trim(ARGUMENTS.op4)) GTE 250) OR ((len( trim(ARGUMENTS.op4))) LT 1 ) >
				        <cfset LOCAL.valid = FALSE />
			        </cfif>
			        <cfif (trim(ARGUMENTS.op1) EQ trim(ARGUMENTS.op2)) OR (trim(ARGUMENTS.op1) EQ trim(ARGUMENTS.op3))OR
			              (trim(ARGUMENTS.op1) EQ trim(ARGUMENTS.op4)) OR (trim(ARGUMENTS.op2) EQ trim(ARGUMENTS.op3))OR
			              (trim(ARGUMENTS.op2) EQ trim(ARGUMENTS.op4)) OR (trim(ARGUMENTS.op3) EQ trim(ARGUMENTS.op4))>
				        <cfset LOCAL.valid = FALSE />
			       </cfif>
			       <cfif (ARGUMENTS.sub EQ "0" ) OR (ARGUMENTS.ans EQ "0")>
			            <cfset LOCAL.valid = FALSE />
			       </cfif>

				<cfreturn LOCAL.valid />
	</cffunction>



		<!-------      Method for login form validation   ------>
</cfcomponent>
