  // OM: "_searchStruct.oBtnSetRowHeight" (new LV 15.07.20, 09:51:01)
  // Last change: LV 15.07.20, 09:51:01

C_TEXT:C284($vtItems)
C_LONGINT:C283($vlUserChoice)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$vtItems:=""
		$vtItems:=$vtItems+Char:C90(1)+"1 Line"
		$vtItems:=$vtItems+Char:C90(1)+"2 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"3 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"4 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"5 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"6 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"7 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"8 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"9 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"10 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"11 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"12 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"13 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"14 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"15 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"16 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"17 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"18 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"19 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"20 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"21 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"22 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"23 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"24 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"25 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"26 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"27 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"28 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"29 Lines"
		$vtItems:=$vtItems+Char:C90(1)+"30 Lines"
		If (Length:C16($vtItems)>0)
			$vlUserChoice:=0
			$vlUserChoice:=Pop up menu:C542($vtItems)
			If ($vlUserChoice>0)
				  // LISTBOX SET ROW HEIGHT(*;"oColSearchResultsDisplay";$vlUserChoice)
				  // LISTBOX SET AUTO ROW HEIGHT(*;"oColSearchResultsDisplay";lk row min height;$vlUserChoice;lk lines)
				  // LISTBOX SET AUTO ROW HEIGHT(*;"oColSearchResultsDisplay";lk row max height;$vlUserChoice;lk lines)
				LISTBOX SET ROWS HEIGHT:C835(*;"oColSearchResultsDisplay";$vlUserChoice;lk lines:K53:23)
				
			Else 
				BEEP:C151  // signal nothing choosed
				
			End if 
		End if 
		
End case 

  // - EOF -