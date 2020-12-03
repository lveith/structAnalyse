// PM: "_searchStruct.oBtnWebAreaSearch" (new LV 19.07.20, 09:25:51)
// Last change: LV 19.07.20, 09:25:51

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		// function commandEditor(myEditorName, myCommand, myP1, myP2)
		If (Macintosh option down:C545 | Windows Alt down:C563 | Shift down:C543)
			WA EXECUTE JAVASCRIPT FUNCTION:C1043(*; "oWebArea"; "commandEditor"; *; "mergeleft"; "findPersistent")
		Else 
			WA EXECUTE JAVASCRIPT FUNCTION:C1043(*; "oWebArea"; "commandEditor"; *; "mergeleft"; "find")
		End if 
		
End case 

// - EOF -