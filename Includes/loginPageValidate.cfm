<cfheader name="expires" value="#now()#">
<cfheader name="pragma" value="no-cache">
<cfheader name="cache-control" value="no-cache, no-store, must-revalidate">


<cfif  structKeyExists(SESSION, "admin")>
	<cflocation  url="view/admin/adminDashboard.cfm" addtoken="no">
</cfif>

<cfif structKeyExists(SESSION,"student")>
	<cflocation  url="view/student/studentDashboard.cfm" addtoken="no">
</cfif>
