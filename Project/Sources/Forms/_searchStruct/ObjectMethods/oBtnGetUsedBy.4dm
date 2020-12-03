  // OM: "_searchStruct".oBtnGetUsedBy (new LV 26.07.20, 11:34:26)
  // Get Projectmethods who uses the currSel/currSelMarked/currItemMarked Projectmethod(/s)
  // Last change: LV 26.07.20, 11:34:26

C_TEXT:C284($vtItems)
C_LONGINT:C283($vlUserChoice)
C_OBJECT:C1216($colItem)
C_COLLECTION:C1488($colToUse)
C_TEXT:C284($filterString)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$vtItems:=""
		If (Form:C1466.soCurrEl=Null:C1517)
			$vtItems:=$vtItems+Char:C90(1)+"Search methods uses current marked item (0)"
		Else 
			$vtItems:=$vtItems+Char:C90(1)+"Search methods uses current marked item (1) '"+String:C10(Form:C1466.soCurrEl.name)+"'"
		End if 
		$vtItems:=$vtItems+Char:C90(1)+"Search methods uses current marked selection ("+String:C10(Form:C1466.soCurrSel.length)+")"
		$vtItems:=$vtItems+Char:C90(1)+"Search methods uses current selection ("+String:C10(Form:C1466.searchResultsDisplay.length)+")"
		If (Length:C16($vtItems)>0)
			$vlUserChoice:=0
			$vlUserChoice:=Pop up menu:C542($vtItems)
			
			Case of 
				: ($vlUserChoice=1)  // Search methods uses current marked item
					$colToUse:=New collection:C1472(Form:C1466.soCurrEl)
					If (Form:C1466.soCurrEl=Null:C1517)
						BEEP:C151
						$vlUserChoice:=-5
					End if 
					
				: ($vlUserChoice=2)  // Search methods uses current marked selection
					$colToUse:=Form:C1466.soCurrSel
					Case of 
						: (Form:C1466.soCurrSel.length<1)
							BEEP:C151
							$vlUserChoice:=-5
							
						: (Form:C1466.soCurrSel.length>10)
							CONFIRM:C162("Attention, the search of any callers of one of the "+String:C10(Form:C1466.soCurrSel.length)+" choosen methods can take some time")
							If (OK#1)
								ALERT:C41("Operation canceled")
								$vlUserChoice:=-6
							End if 
							
					End case 
					
				: ($vlUserChoice=3)  // Search methods uses current selection
					$colToUse:=Form:C1466.searchResultsDisplay
					Case of 
						: (Form:C1466.searchResultsDisplay.length<1)
							BEEP:C151
							$vlUserChoice:=-5
							
						: (Form:C1466.searchResultsDisplay.length>10)
							CONFIRM:C162("Attention, the search of any callers of one of the "+String:C10(Form:C1466.searchResultsDisplay.length)+" choosen methods can take some time")
							If (OK#1)
								ALERT:C41("Operation canceled")
								$vlUserChoice:=-6
							End if 
							
					End case 
					
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
					
					$filterString:=""
					For each ($colItem;$colToUse)
						If ($colItem.type="method (project)")
							$filterString:=$filterString+"("+$colItem.name+")|"
						End if 
					End for each 
					If ($filterString="")
						BEEP:C151
					Else 
						$filterString:=Substring:C12($filterString;1;Length:C16($filterString)-1)
						$filterString:="(?<!(\\$)|(<>))\\b("+$filterString  // LV 07.08.2020 18:30
						$filterString:=$filterString+")\\b"
						_sisStartSearchMain ($filterString;True:C214;True:C214)
					End if 
					
			End case 
		End if 
		
End case 

  // - EOF -