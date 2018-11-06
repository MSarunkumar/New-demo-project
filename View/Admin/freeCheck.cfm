<html>
	<head>
	    <link href="../../assets/css/datetimepicker.css" rel="stylesheet" type="text/css"/>
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	    <script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
	    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.0/moment-with-locales.min.js"></script>
	    <script src="../../assets/js/datetimepicker.js" type="text/javascript"></script>
	    <link href="https://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
	    <title>Beautiful Datetime Picker Demo</title>
	</head>
	<body>
	    <div id="picker"> </div>
	    <input type="hidden" id="result" />
		<input type = "button" id="btn" value="ccccc">

		<script src="../../assets/js/setTestTime.js"  type="text/javascript"></script>
	</body>
</html>


<!--- <cfset VARIABLES.currentTime = DateTimeFormat(now(), "MM d yyyy HH:nn:ss ") />
<cfdump var="#VARIABLES.currentTime#"><br><br>

<cfset VARIABLES.timeDuration = APPLICATION.viewDetailsObj.getTimeDuration('Math') />
<cfset VARIABLES.currentTime = #DateTimeFormat(now(), "MM d yyyy HH:nn:ss ")# />

	 <cfloop query = "VARIABLES.timeDuration">
        	<cfset VARIABLES.timeDiff =  Datediff("n",VARIABLES.timeDuration.startTime,VARIABLES.currentTime) />
                 <cfdump var="#VARIABLES.timeDiff#">
		    <cfif VARIABLES.timeDuration.duration GTE VARIABLES.timeDiff >
				<cfoutput>false</cfoutput>
			</cfif>
		</cfloop> --->

<!--- <html>
	<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	</head>


	<body>
	<script>
		getActiveQuestionIdArr('Math');
        var totalTestQuestion = 5;
	function getActiveQuestionIdArr(subject) {
		 $.ajax({
	         type: "Post"  ,
	         url: "../../Model/takeTest.cfc?method=getActiveQuestionIdArr" ,
	         data:{
	        	    subject:subject },
	         datatype: "json",

	         success:function(res)
	              {
	        	     activeQuestionIdArr = $.parseJSON(res);
					 totalActiveQuestion=activeQuestionIdArr.length;
                      document.write(activeQuestionIdArr);
                      console.log(activeQuestionIdArr);
	        	     console.log(activeQuestionIdArr.length);
	        	     if(activeQuestionIdArr.length == 0) {
	        	    	 document.write("error");
	        	     }
	        	     else{

	        	     getRandomArray();
	        	     }

	              }
	          });
	    }
	    function getRandomArray() {
		var randomQuestionIdArr = [] ;

		while(randomQuestionIdArr.length < totalTestQuestion) {

			var randomNumber = Math.floor(Math.random()*totalActiveQuestion) ;

		    if(randomQuestionIdArr.indexOf(randomNumber) > -1)
		    	continue;

		    randomQuestionIdArr[randomQuestionIdArr.length] = randomNumber;

		}
		document.write("<br> "+randomQuestionIdArr);
	}

	</script>
	</body>

</html> --->