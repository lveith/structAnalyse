// OM: "_searchStruct.oWebArea" (new LV 17.07.20, 10:42:47)
// Last change: LV 17.07.20, 10:42:47

C_TEXT:C284($styles)

Case of 
	: (Form event code:C388=On End URL Loading:K2:47)
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"setBodyBGColor";*;"#3e3e79")
		
		$styles:="body > article {"
		$styles:=$styles+"background-color: transparent !important;"
		$styles:=$styles+"color: white;"
		$styles:=$styles+"}"
		// insertAnyStyles(myCSS, myID)
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"insertAnyStyles";*;$styles;"mySpecStylesBg1")
		
		//$styles:=".cDefaultClosed {"
		//$styles:=$styles+"overflow: hidden !important;"
		//$styles:=$styles+"padding-bottom: 3px !important;"
		//$styles:=$styles+"}"
		
		// insertAnyStyles(myCSS, myID)
		// WA EXECUTE JAVASCRIPT FUNCTION(*;"oWebArea";"insertAnyStyles";$resultBool;$styles;"mySpecStyles1")
		
		// setEditorHeight(myEditorName, myHeight)
		// WA EXECUTE JAVASCRIPT FUNCTION(*;"oWebArea";"setEditorHeight";$resultBool;"merge";"calc";"3")
		
		// function mySetEditorOption(myEditorOptionName, myEditorOptionValue)
		// mySetEditorOption("readOnly", true)
		// WA EXECUTE JAVASCRIPT FUNCTION(*;"oWebArea";"mySetEditorOption";*;"readOnly";True)
		// execute with timeDelay, to let codemirror create editor panels before
		C_TEXT:C284($funcResult)
		$funcResult:=WA Evaluate JavaScript:C1029(*;"oWebArea";"(function(){ setTimeout(function(){ mySetEditorOption(\"readOnly\", true); }, 650); })();")
		
End case 

// - EOF -