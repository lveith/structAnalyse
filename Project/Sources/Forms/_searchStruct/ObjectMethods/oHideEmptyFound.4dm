// OM: "_searchStruct.oHideEmptyFound" (new LV 13.07.20, 14:50:49)
// Last change: LV 13.07.20, 14:50:49

C_TEXT:C284($vtItems)
C_LONGINT:C283($vlUserChoice)
C_OBJECT:C1216($colItem)
C_COLLECTION:C1488($colToUse)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$vtItems:=""
		$vtItems:=$vtItems+Char:C90(1)+"Hide empty found in marked selection ("+String:C10(Form:C1466.soCurrSel.length)+")"
		$vtItems:=$vtItems+Char:C90(1)+"Hide empty found in current selection ("+String:C10(Form:C1466.searchResultsDisplay.length)+")"
		$vtItems:=$vtItems+Char:C90(1)+"Hide empty found in whole selection ("+String:C10(Form:C1466.searchResults.length)+")"
		If (Length:C16($vtItems)>0)
			$vlUserChoice:=0
			$vlUserChoice:=Pop up menu:C542($vtItems)
			
			Case of 
				: ($vlUserChoice=1)  // Hide empty found in marked selection
					$colToUse:=Form:C1466.soCurrSel
					
				: ($vlUserChoice=2)  // Hide empty found in current selection
					$colToUse:=Form:C1466.searchResultsDisplay
					
				: ($vlUserChoice=3)  // Hide empty found in whole selection
					$colToUse:=Form:C1466.searchResults
					
				Else 
					BEEP:C151
					
			End case 
			
			Case of 
				: ($vlUserChoice<1)
					BEEP:C151
					
				: ($vlUserChoice>3)
					BEEP:C151
					
				: ($colToUse=Null:C1517)
					BEEP:C151
					
				: ($colToUse.length<1)
					BEEP:C151
					
				Else 
					For each ($colItem;$colToUse)
						If (Match regex:C1019("[\\D\\d]*\\S[\\D\\d]*";$colItem.found))
							$colItem.empty:=False:C215
						Else 
							$colItem.empty:=True:C214
						End if 
					End for each 
					Form:C1466.searchResultsDisplay:=Form:C1466.searchResultsDisplay.query("empty = false")
					// refresh listbox by simulate a winResize
					RESIZE FORM WINDOW:C890(1;1)
					RESIZE FORM WINDOW:C890(-1;-1)
			End case 
		End if 
		
End case 

// - EOF -