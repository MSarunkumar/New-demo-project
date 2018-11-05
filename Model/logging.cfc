<!---
  --- logging.cfc
  --- ------------
  ---
  --- It will do log the error
  ---
  --- author: mindfire
  --- date:   11/2/18
  --->
<cfcomponent hint="It will log the error and return meaning full value" accessors="true" output="false" persistent="false">

<!--- Method  : It will log all error files and return false --->

	<cffunction  name = "doLog" access = "public"  hint = "It will log and return false">
		<cfargument name = "componentName" required = "true" type = "string" hint = "It will catch component name"/>
		<cfargument name = "functionName" required = "true" type = "string" hint = "It will catch function name"/>
		<cfargument name = "message" required = "true"  type = "string" hint = "It will catch message of error"/>
		<cfargument name = "detail" required = "true" type = "string" />

		<cflog file = "onlineExamErrorLog"
		text = "#ARGUMENTS.message#..#ARGUMENTS.detail#..#now()#...Component Name is : [#ARGUMENTS.componentName#],Function Name is :[#ARGUMENTS.functionName#]" />

	</cffunction>

</cfcomponent>