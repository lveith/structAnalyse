  // OM: "_searchStruct".oBtnGetUses (new LV 26.07.20, 11:34:26)
  // Get Projectmethods who uses the currSel/currSelMarked/currItemMarked Projectmethod(/s)
  // Last change: LV 26.07.20, 11:34:26

C_TEXT:C284($vtItems)
C_LONGINT:C283($vlUserChoice)
C_OBJECT:C1216($colItem)
C_COLLECTION:C1488($colToUse)
C_TEXT:C284($srcTxt)
C_COLLECTION:C1488($colUsesMethods;$colProjMethods)
C_TEXT:C284($colPMethodItem)
C_DATE:C307($date)
C_TIME:C306($time)
C_TEXT:C284($regexPattern)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$vtItems:=""
		If (Form:C1466.soCurrEl=Null:C1517)
			$vtItems:=$vtItems+Char:C90(1)+"Search methods usedBy current marked item (0)"
		Else 
			$vtItems:=$vtItems+Char:C90(1)+"Search methods usedBy current marked item (1) '"+String:C10(Form:C1466.soCurrEl.name)+"'"
		End if 
		$vtItems:=$vtItems+Char:C90(1)+"Search methods usedBy current marked selection ("+String:C10(Form:C1466.soCurrSel.length)+")"
		$vtItems:=$vtItems+Char:C90(1)+"Search methods usedBy current selection ("+String:C10(Form:C1466.searchResultsDisplay.length)+")"
		If (Length:C16($vtItems)>0)
			$vlUserChoice:=0
			$vlUserChoice:=Pop up menu:C542($vtItems)
			
			Case of 
				: ($vlUserChoice=1)  // Search methods usedBy current marked item
					$colToUse:=New collection:C1472(Form:C1466.soCurrEl)
					If (Form:C1466.soCurrEl=Null:C1517)
						BEEP:C151
						$vlUserChoice:=-5
					End if 
					
				: ($vlUserChoice=2)  // Search methods usedBy current marked selection
					$colToUse:=Form:C1466.soCurrSel
					Case of 
						: (Form:C1466.soCurrSel.length<1)
							BEEP:C151
							$vlUserChoice:=-5
							
						: (Form:C1466.soCurrSel.length>10)
							CONFIRM:C162("Attention, to detect all calls of "+String:C10(Form:C1466.soCurrSel.length)+" choosen methods can take maybe some time")
							If (OK#1)
								ALERT:C41("Operation canceled")
								$vlUserChoice:=-6
							End if 
							
					End case 
					
				: ($vlUserChoice=3)  // Search methods usedBy current selection
					$colToUse:=Form:C1466.searchResultsDisplay
					Case of 
						: (Form:C1466.searchResultsDisplay.length<1)
							BEEP:C151
							$vlUserChoice:=-5
							
						: (Form:C1466.searchResultsDisplay.length>10)
							CONFIRM:C162("Attention, to detect all calls of "+String:C10(Form:C1466.searchResultsDisplay.length)+" choosen methods can take maybe some time")
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
					
					$colUsesMethods:=New collection:C1472
					$colProjMethods:=zGetProjMethods 
					
					  //For ($i;1;8)
					  //$colProjMethods.combine($colProjMethods.copy())
					  //End for 
					  //BEEP
					
					$regexPattern:=$colProjMethods.join(")|(")
					$regexPattern:="(?<!(\\$)|(<>))\\b(("+$regexPattern  // LV 07.08.2020 18:30
					$regexPattern:=$regexPattern+"))\\b"
					
					Form:C1466.searchResultsDisplay:=New collection:C1472
					Form:C1466.searchResults:=Form:C1466.searchResultsDisplay
					
					For each ($colItem;$colToUse)
						$srcTxt:=sisStripComments ($colItem.found)
						$colUsesMethods.combine(zMatchRegexG ($srcTxt;$regexPattern))
						
						  //For each ($colPMethodItem;$colProjMethods)
						  //If (Position($colPMethodItem;$srcTxt)>0)
						  //$colUsesMethods.push($colPMethodItem)
						  //End if 
						  //End for each 
						
					End for each 
					
					$colUsesMethods:=$colUsesMethods.distinct()  // LV 07.08.2020 18:30
					
					For each ($colPMethodItem;$colUsesMethods)
						
						METHOD GET MODIFICATION DATE:C1170($colPMethodItem;$date;$time;*)
						METHOD GET CODE:C1190($colPMethodItem;$srcTxt;*)
						
						$obj:=New object:C1471
						$obj.name:=$colPMethodItem
						$obj.found:=$srcTxt
						$obj.modification:=Replace string:C233(String:C10($date;ISO date:K1:8;$time);"T";"_")
						$obj.type:="method (project)"
						$obj.kind:="method"
						
						If (Match regex:C1019(".*\\S.*";$obj.found))
							$obj.empty:=False:C215
						Else 
							$obj.empty:=True:C214
						End if 
						
						Form:C1466.searchResultsDisplay.push($obj)
						
					End for each 
					
			End case 
		End if 
		
End case 

  // - EOF -