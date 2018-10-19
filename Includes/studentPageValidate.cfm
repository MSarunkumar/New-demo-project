<cfheader name="expires" value="#now()#">
<cfheader name="pragma" value="no-cache">
<cfheader name="cache-control" value="no-cache, no-store, must-revalidate">

<cfif NOT structKeyExists(SESSION, "student")>
       <cflocation addtoken="no" url="../../index.cfm" />
</cfif>
