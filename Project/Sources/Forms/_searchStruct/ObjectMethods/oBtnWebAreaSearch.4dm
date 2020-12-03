// PM: "_searchStruct.oBtnWebAreaSearch" (new LV 19.07.20, 09:25:51)
// Last change: LV 19.07.20, 09:25:51

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		// function commandEditor(myEditorName, myCommand, myP1, myP2)
		// WA EXECUTE JAVASCRIPT FUNCTION(*;"oWebArea";"commandEditor";*;"mergeleft";"findPersistent")
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"commandEditor";*;"mergeleft";"find")
		
End case 

// - EOF -