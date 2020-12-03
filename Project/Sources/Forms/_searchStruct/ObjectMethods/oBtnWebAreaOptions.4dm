// OM: "_searchStruct".oBtnWebAreaOptions (new LV 17.07.20, 13:11:49)
// Last change: LV 17.07.20, 13:11:49

C_TEXT:C284($vtItems)
C_LONGINT:C283($vlUserChoice)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$vtItems:=""
		$vtItems:=$vtItems+Char:C90(1)+"Show Toolbar1"
		$vtItems:=$vtItems+Char:C90(1)+"Show Toolbar2"
		$vtItems:=$vtItems+Char:C90(1)+"Show Toolbar3"
		$vtItems:=$vtItems+Char:C90(1)+"Show all Toolbars"
		$vtItems:=$vtItems+Char:C90(1)+"Hide Toolbar1"
		$vtItems:=$vtItems+Char:C90(1)+"Hide Toolbar2"
		$vtItems:=$vtItems+Char:C90(1)+"Hide Toolbar3"
		$vtItems:=$vtItems+Char:C90(1)+"Hide all Toolbars"
		$vtItems:=$vtItems+Char:C90(1)+"Set editable ON"
		$vtItems:=$vtItems+Char:C90(1)+"Set editable OFF"
		$vtItems:=$vtItems+Char:C90(1)+"Set LineNumbers ON"
		$vtItems:=$vtItems+Char:C90(1)+"Set LineNumbers OFF"
		$vtItems:=$vtItems+Char:C90(1)+"Set LineWrap ON"
		$vtItems:=$vtItems+Char:C90(1)+"Set LineWrap OFF"
		$vtItems:=$vtItems+Char:C90(1)+"showTrailingSpace ON"
		$vtItems:=$vtItems+Char:C90(1)+"showTrailingSpace OFF"
		$vtItems:=$vtItems+Char:C90(1)+"Set styleActiveLine ON"
		$vtItems:=$vtItems+Char:C90(1)+"Set styleActiveLine OFF"
		// $vtItems:=$vtItems+Char(1)+"Open web inspector"
		
		If (Length:C16($vtItems)>0)
			$vlUserChoice:=0
			$vlUserChoice:=Pop up menu:C542($vtItems)
			Case of 
				: ($vlUserChoice=1)  // "Show Toolbar1"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"myToolbarOn";*;"myToolbar1")
					
				: ($vlUserChoice=2)  // "Show Toolbar2"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"myToolbarOn";*;"myToolbar2")
					
				: ($vlUserChoice=3)  // "Show Toolbar3"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"myToolbarOn";*;"myToolbar3")
					
				: ($vlUserChoice=4)  // "Show all Toolbars"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"myToolbarOn";*;"xy")
					
					
				: ($vlUserChoice=5)  // "Hide Toolbar1"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"myToolbarOff";*;"myToolbar1")
					
				: ($vlUserChoice=6)  // "Hide Toolbar2"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"myToolbarOff";*;"myToolbar2")
					
				: ($vlUserChoice=7)  // "Hide Toolbar3"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"myToolbarOff";*;"myToolbar3")
					
				: ($vlUserChoice=8)  // "Hide all Toolbars"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"myToolbarOff";*;"xy")
					
					
				: ($vlUserChoice=9)  // "Set editable ON"
					// function mySetEditorOption(myEditorOptionName, myEditorOptionValue)
					// mySetEditorOption("readOnly", false)
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"mySetEditorOption";*;"readOnly";False:C215)
					
				: ($vlUserChoice=10)  // "Set editable OFF"
					// function mySetEditorOption(myEditorOptionName, myEditorOptionValue)
					// mySetEditorOption("readOnly", true)
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"mySetEditorOption";*;"readOnly";True:C214)
					
				: ($vlUserChoice=11)  // "Set LineNumbers ON"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"mySetEditorOption";*;"lineNumbers";True:C214)
					
				: ($vlUserChoice=12)  // "Set LineNumbers OFF"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"mySetEditorOption";*;"lineNumbers";False:C215)
					
				: ($vlUserChoice=13)  // "Set LineWrap ON"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"mySetEditorOption";*;"lineWrapping";True:C214)
					
				: ($vlUserChoice=14)  // "Set LineWrap OFF"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"mySetEditorOption";*;"lineWrapping";False:C215)
					
				: ($vlUserChoice=15)  // "showTrailingSpace ON"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"mySetEditorOption";*;"showTrailingSpace";True:C214)
					
				: ($vlUserChoice=16)  // "showTrailingSpace OFF"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"mySetEditorOption";*;"showTrailingSpace";False:C215)
					
				: ($vlUserChoice=17)  // "Set styleActiveLine ON"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"mySetEditorOption";*;"styleActiveLine";True:C214)
					
				: ($vlUserChoice=18)  // "Set styleActiveLine OFF"
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"mySetEditorOption";*;"styleActiveLine";False:C215)
					
					// : ($vlUserChoice=19)  // "Open web inspector"
					// WA OPEN WEB INSPECTOR(*;"oWebArea")  // crashes always when call from this object method onClicked (in last v18R4 test)
					
			End case 
			
		End if 
		
End case 

// - EOF -