<cfinclude template="../../Includes/adminPageValidate.cfm" />

 <html>
	<head>
		<title>Adding Question</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">

		<cfinclude template = "../../Includes/adminModule.cfm" />

					<div class="data-container">
					    <div id="heading"> Edit Question</div>
					    <div class="serverSideError"></div>

					    <cfif NOT isDefined("URL.quesId")>
						    <cflocation url="adminDashboard.cfm"  addtoken="no" />
						</cfif>

					    <cfset VARIABLES.questionInfo = APPLICATION.viewDetailsObj.getQuestionInfo(URL.quesId) />

						<cfif VARIABLES.questionInfo.RecordCount EQ 0>
							<cflocation url="adminDashboard.cfm" addtoken="no" />
						</cfif>
			        	<cfoutput>
			        	<form id="form" >

							<div class="container">
                                <div class="label-container">Subject </div>
                                 <input type="text"  value="#VARIABLES.questionInfo.subject#"
								                     class="input-box" disabled="disabled">
							</div>
                            <input type="hidden" id="questionId" value="#URL.quesId#">
							<div class="container">
                                <div class="label-container"> Question </div>
								<textarea id="quesId" name="quesId" rows="4" class="input-box" maxlength="900"
								 onblur="quesValid()" disabled="disabled">#VARIABLES.questionInfo.question#</textarea>
								<div id="qid" class="error"> </div>
							</div>

                            <div class="container">
								<div class="label-container">Option 1:</div>
							    <textarea id="op1" name="op1" class="input-box" maxlength="250"
							       onblur="op1Valid()">#VARIABLES.questionInfo.option1#</textarea>
							    <div id= "oid1" class="error"> </div>
							</div>

                            <div class="container">
                            	<div class="label-container">Option 2:</div>
                                <textarea id="op2" name="op2"  class="input-box" maxlength="250"
								 onblur="op2Valid()">#VARIABLES.questionInfo.option2#</textarea>
							    <div id="oid2" class="error"> </div>
                            </div>

							<div class="container">
                            	<div class="label-container">Option 3:</div>
						        <textarea id="op3" name="op3" class="input-box" maxlength="250"
						         onblur="op3Valid()">#VARIABLES.questionInfo.option3#</textarea>
							    <div id="oid3" class="error"> </div>
							</div>

							<div class="container">
                            	<div class="label-container">Option 4:</div>
							    <textarea id="op4" name="op4"  class="input-box" maxlength="250"
							     onblur="op4Valid()">#VARIABLES.questionInfo.option4#</textarea>
							    <div id="oid4" class="error"></div>
                            </div>

							<div class="container">
								<div class="label-container">Please select answer</div>
							    <select  id="ansID" name="ansId" value="1"  class="input-box" onChange="ansValid()">
								    <!--- It is for showing answer --->
								<cfloop from="1" to="4" index="i" >
									<cfoutput>
									<cfif i EQ  VARIABLES.questionInfo.answer>
										<cfif VARIABLES.questionInfo.answer EQ i><option  value="#i#" selected> Option #i# </option></cfif>
									<cfelse>
									 <option  value="#i#" > Option #i#  </option>
									 </cfif>
									</cfoutput>
								</cfloop>

								</select>
								<div id="aid" class="error"></div>
							</div>
                            <input type="Button" value="Save changes" class="btn" name="submit" id="save">

					    </form><br></cfoutput>
		         </div>
		   </div><br>

     <cfinclude template="../../Includes/footer.cfm" />
	 <script type="text/javascript" src="../../assets/js/editQuestion.js"> </script>
	 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
	 </body>
</html>









