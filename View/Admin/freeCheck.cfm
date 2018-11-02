
<cfset VARIABLES.currentTime = DateTimeFormat(now(), "MM d yyyy HH:nn:ss ") />
<cfdump var="#VARIABLES.currentTime#"><br><br>

<cfset VARIABLES.timeDuration = APPLICATION.viewDetailsObj.getTimeDuration('Math') />
<cfset VARIABLES.currentTime = #DateTimeFormat(now(), "MM d yyyy HH:nn:ss ")# />

	 <cfloop query = "VARIABLES.timeDuration">
        	<cfset VARIABLES.timeDiff =  Datediff("n",VARIABLES.timeDuration.startTime,VARIABLES.currentTime) />
                 <cfdump var="#VARIABLES.timeDiff#">
		    <cfif VARIABLES.timeDuration.duration GTE VARIABLES.timeDiff >
				<cfoutput>false</cfoutput>
			</cfif>
		</cfloop>