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
		<cfset structClear(SESSION) />
<!--- For logout --->
		<cfset sessionRotate()/>
    </cffunction>

</cfcomponent>
