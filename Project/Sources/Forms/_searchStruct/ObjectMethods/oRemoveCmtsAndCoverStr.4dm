  // PM: "_searchStruct".oRemoveCmtsAndCoverStr (new LV 23.07.20, 16:13:12)
  // Last change: LV 23.07.20, 16:13:12

C_TEXT:C284($vtItems)
C_LONGINT:C283($vlUserChoice)
C_OBJECT:C1216($colItem)
C_COLLECTION:C1488($colToUse)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$vtItems:=""
		$vtItems:=$vtItems+Char:C90(1)+"Cover strings (and remove comments) in marked selection ("+String:C10(Form:C1466.soCurrSel.length)+")"
		$vtItems:=$vtItems+Char:C90(1)+"Cover strings (and remove comments) in current selection ("+String:C10(Form:C1466.searchResultsDisplay.length)+")"
		$vtItems:=$vtItems+Char:C90(1)+"Cover strings (and remove comments) in whole selection ("+String:C10(Form:C1466.searchResults.length)+")"
		If (Length:C16($vtItems)>0)
			$vlUserChoice:=0
			$vlUserChoice:=Pop up menu:C542($vtItems)
			
			Case of 
				: ($vlUserChoice=1)  // Cover strings in marked selection
					$colToUse:=Form:C1466.soCurrSel
					
				: ($vlUserChoice=2)  // Cover strings in current selection
					$colToUse:=Form:C1466.searchResultsDisplay
					
				: ($vlUserChoice=3)  // Cover strings in whole selection
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
						$colItem.found:=sisStripComments ($colItem.found)
						$colItem.found:=zReplaceRegexG ($colItem.found;"(?m)^\\s*\r")  // remove all empty lines
						$colItem.found:=sisCoverStringsWholeContent ($colItem.found)
						
						If (Match regex:C1019("[\\D\\d]*\\S[\\D\\d]*";$colItem.found))
							$colItem.empty:=False:C215
						Else 
							$colItem.empty:=True:C214
						End if 
					End for each 
					
					  // redraw new content
					Case of 
						: (Form:C1466.soCurrEl=Null:C1517)
						: (Form:C1466.soCurrEl.found=Null:C1517)
						: (Value type:C1509(Form:C1466.soCurrEl.found)#Is text:K8:3)
						Else 
							  // insertInEditor(myEditorName, mySrc)
							If (Length:C16(Form:C1466.soCurrEl.found)>3555)  // for larger text set first to empty, to not see lastText until insertion is finished
								WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"insertInEditor";*;"mergeleft";"...please wait until loaded...")
							End if 
							WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"insertInEditor";*;"mergeleft";Form:C1466.soCurrEl.found)
							  // regenerate all indents needs full parse whole document
							  // function selectAllEditor(myEditorName)
							WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"selectAllEditor";*;"mergeleft")
							  // function myIndentAuto(myEditorName)
							WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"myIndentAuto";*;"mergeleft")
							  // function setCursorAtStart(myEditorName)
							WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"setCursorAtStart";*;"mergeleft")
					End case 
					
					  // refresh listbox by simulate a winResize
					RESIZE FORM WINDOW:C890(1;1)
					RESIZE FORM WINDOW:C890(-1;-1)
					
					
			End case 
		End if 
		
End case 

  // - EOF -