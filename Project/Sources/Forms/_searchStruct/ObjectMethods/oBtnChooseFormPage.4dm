// OM: "_searchStruct".oBtnChooseFormPage (new LV 22.07.20, 13:13:19)
// Last change: LV 22.07.20, 13:13:19

C_TEXT:C284($vtItems)
C_LONGINT:C283($vlUserChoice)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$vlUserChoice:=0
		$vtItems:=""
		$vtItems:=$vtItems+"1 - Suche in Struktur"+";"
		$vlUserChoice:=Pop up menu:C542($vtItems)
		If ($vlUserChoice>0)
			FORM GOTO PAGE:C247($vlUserChoice)
			OBJECT SET TITLE:C194(*;"oBtnChooseFormPage";String:C10($vlUserChoice))
		End if 
		
End case 

// - EOF -