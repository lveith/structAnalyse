// OM: "_searchStruct".oBtnImport4DSearchResultsInfo (new LV 20.07.20, 12:50:24)
// Last change: LV 20.07.20, 12:50:24

C_TEXT:C284($txtMessage)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$txtMessage:="Just alternative to the button 'Search' (live)\r\r"
		$txtMessage:=$txtMessage+"Click button 'Import' to load a 4D-search-in-structure result export.txt."
		$txtMessage:=$txtMessage+" After this is done 4Ds searchPrefs from txt-file can viewed with button '?'"
		
		Case of 
			: (Form:C1466.importAttributes=Null:C1517)
			: (Value type:C1509(Form:C1466.importAttributes)#Is object:K8:27)
			: (OB Is empty:C1297(Form:C1466.importAttributes))
			Else 
				$txtMessage:=JSON Stringify:C1217(Form:C1466.importAttributes;*)
		End case 
		
		ALERT:C41($txtMessage)
		
End case 

// - EOF -
