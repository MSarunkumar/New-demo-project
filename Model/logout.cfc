<!---
	--- logout
	--- ------
	---
	--- This is logout cfc.
	---
	--- author: mindfire
	--- date:   9/24/18
	--->
<cfcomponent hint = "This is logout cfc." accessors = "true" output = "false" >


	<cffunction name = "logout" returntype="void" access = "public">
		<!--- delete custom variable from session --->
		<cfset structClear(SESSION) />
		<!--- For logout change cfid and cftoken --->
		<cfset sessionRotate() />
    </cffunction>

</cfcomponent>
