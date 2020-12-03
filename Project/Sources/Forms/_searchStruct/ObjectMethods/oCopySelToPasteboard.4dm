// OM: "_searchStruct".oCopySelToPasteboard (new LV 13.07.20, 13:54:36)
// Last change: LV 13.07.20, 13:54:36

C_TEXT:C284($tmpTxt;$name)
C_TEXT:C284($vtItems)
C_LONGINT:C283($vlUserChoice)
C_OBJECT:C1216($colItem)
C_COLLECTION:C1488($colToUse;$colNewSorted)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$vtItems:=""
		$vtItems:=$vtItems+Char:C90(1)+"Copy marked selection ("+String:C10(Form:C1466.soCurrSel.length)+") into pasteboard"
		$vtItems:=$vtItems+Char:C90(1)+"Copy current selection ("+String:C10(Form:C1466.searchResultsDisplay.length)+") into pasteboard"
		$vtItems:=$vtItems+Char:C90(1)+"Copy whole selection ("+String:C10(Form:C1466.searchResults.length)+") into pasteboard"
		$vtItems:=$vtItems+Char:C90(1)+"only names, copy marked selection ("+String:C10(Form:C1466.soCurrSel.length)+") into pasteboard"
		$vtItems:=$vtItems+Char:C90(1)+"only names, copy current selection ("+String:C10(Form:C1466.searchResultsDisplay.length)+") into pasteboard"
		$vtItems:=$vtItems+Char:C90(1)+"only names, copy whole selection ("+String:C10(Form:C1466.searchResults.length)+") into pasteboard"
		If (Length:C16($vtItems)>0)
			$vlUserChoice:=0
			$vlUserChoice:=Pop up menu:C542($vtItems)
			
			Case of 
				: ($vlUserChoice=1)  // Copy marked selection
					$colToUse:=Form:C1466.soCurrSel
					
				: ($vlUserChoice=2)  // Copy current selection
					$colToUse:=Form:C1466.searchResultsDisplay
					
				: ($vlUserChoice=3)  // Copy whole selection
					$colToUse:=Form:C1466.searchResults
					
				: ($vlUserChoice=4)  // only names, copy marked selection
					$colToUse:=Form:C1466.soCurrSel
					
				: ($vlUserChoice=5)  // only names, copy current selection
					$colToUse:=Form:C1466.searchResultsDisplay
					
				: ($vlUserChoice=6)  // only names, copy whole selection
					$colToUse:=Form:C1466.searchResults
					
				Else 
					BEEP:C151
					
			End case 
			
			Case of 
				: ($vlUserChoice<1)
					BEEP:C151
					
				: ($vlUserChoice>6)
					BEEP:C151
					
				: ($colToUse=Null:C1517)
					BEEP:C151
					
				: ($colToUse.length<1)
					BEEP:C151
					
				Else 
					// METHOD RESOLVE PATH("[databaseMethod]/onStartup";$methodType;$tablePtr;$objectName;$formObjectName)
					
					$tmpTxt:=""
					
					$colNewSorted:=$colToUse.orderBy("name, found")
					
					If ($vlUserChoice<4)
						For each ($colItem;$colNewSorted)
							Case of 
								: ($colItem.type="form (project)")
									$tmpTxt:=$tmpTxt+"// FO: "+$colItem.name+Char:C90(Carriage return:K15:38)
								: ($colItem.type="form (table)")
									$tmpTxt:=$tmpTxt+"// FO: "+$colItem.name+Char:C90(Carriage return:K15:38)
								: ($colItem.type="method (project)")
									$tmpTxt:=$tmpTxt+"// PM: "+Char:C90(Double quote:K15:41)+$colItem.name+Char:C90(Double quote:K15:41)+"  # "+zReplaceRegexG($colItem.found;"\r[\\D\\d]*")+Char:C90(Carriage return:K15:38)
								: ($colItem.type="method (database)")
									$tmpTxt:=$tmpTxt+"// DBM: "+$colItem.name+"  # "+zReplaceRegexG($colItem.found;"\r[\\D\\d]*")+Char:C90(Carriage return:K15:38)
								: ($colItem.type="method (trigger)")
									$tmpTxt:=$tmpTxt+"// TRM: "+$colItem.name+"  # "+zReplaceRegexG($colItem.found;"\r[\\D\\d]*")+Char:C90(Carriage return:K15:38)
								: ($colItem.type="method (form)")
									$name:=Replace string:C233($colItem.name;"/{formMethod}";Char:C90(Double quote:K15:41);1)
									If ($name="[tableForm]/@")
										$name:=Replace string:C233($name;"[tableForm]/";"[";1)
										$name:=Replace string:C233($name;"/";"];"+Char:C90(Double quote:K15:41);1)
									Else 
										$name:=Replace string:C233($name;"[projectForm]/";Char:C90(Double quote:K15:41);1)
									End if 
									$tmpTxt:=$tmpTxt+"// FM: "+$name+"  # "+zReplaceRegexG($colItem.found;"\r[\\D\\d]*")+Char:C90(Carriage return:K15:38)
								: ($colItem.type="method (formobject)")
									$name:=$colItem.name
									If ($name="[tableForm]/@")
										$name:=Replace string:C233($name;"[tableForm]/";"[";1)
										$name:=Replace string:C233($name;"/";"];"+Char:C90(Double quote:K15:41);1)
										$name:=Replace string:C233($name;"/";Char:C90(Double quote:K15:41)+".";1)
									Else 
										$name:=Replace string:C233($name;"[projectForm]/";Char:C90(Double quote:K15:41);1)
										$name:=Replace string:C233($name;"/";Char:C90(Double quote:K15:41)+".";1)
									End if 
									$tmpTxt:=$tmpTxt+"// OM: "+$name+"  # "+zReplaceRegexG($colItem.found;"\r[\\D\\d]*")+Char:C90(Carriage return:K15:38)
								: ($colItem.type="table")
									$tmpTxt:=$tmpTxt+"// Table: "+$colItem.name+Char:C90(Carriage return:K15:38)
								: ($colItem.type="field (@)")
									$tmpTxt:=$tmpTxt+"// Field: "+$colItem.name+Char:C90(Carriage return:K15:38)
								: ($colItem.type="command")
									$tmpTxt:=$tmpTxt+"// Command: "+$colItem.name+Char:C90(Carriage return:K15:38)
								: ($colItem.type="constant")
									$tmpTxt:=$tmpTxt+"// Constant: "+$colItem.name+Char:C90(Carriage return:K15:38)
								Else 
									$tmpTxt:=$tmpTxt+"// ??: "+$colItem.name+Char:C90(Carriage return:K15:38)
							End case 
						End for each 
						
					Else 
						ARRAY TEXT:C222($aNames;0)
						For each ($colItem;$colNewSorted)
							If (Find in array:C230($aNames;$colItem.name)<1)
								Case of 
									: ($colItem.type="form (project)")
										$tmpTxt:=$tmpTxt+"// FO: "+$colItem.name+Char:C90(Carriage return:K15:38)
									: ($colItem.type="form (table)")
										$tmpTxt:=$tmpTxt+"// FO: "+$colItem.name+Char:C90(Carriage return:K15:38)
									: ($colItem.type="method (project)")
										$tmpTxt:=$tmpTxt+"// PM: "+Char:C90(Double quote:K15:41)+$colItem.name+Char:C90(Double quote:K15:41)+Char:C90(Carriage return:K15:38)
									: ($colItem.type="method (database)")
										$tmpTxt:=$tmpTxt+"// DBM: "+$colItem.name+Char:C90(Carriage return:K15:38)
									: ($colItem.type="method (trigger)")
										$tmpTxt:=$tmpTxt+"// TRM: "+$colItem.name+Char:C90(Carriage return:K15:38)
									: ($colItem.type="method (form)")
										$name:=Replace string:C233($colItem.name;"/{formMethod}";Char:C90(Double quote:K15:41);1)
										If ($name="[tableForm]/@")
											$name:=Replace string:C233($name;"[tableForm]/";"[";1)
											$name:=Replace string:C233($name;"/";"];"+Char:C90(Double quote:K15:41);1)
										Else 
											$name:=Replace string:C233($name;"[projectForm]/";Char:C90(Double quote:K15:41);1)
										End if 
										$tmpTxt:=$tmpTxt+"// FM: "+$name+Char:C90(Carriage return:K15:38)
									: ($colItem.type="method (formobject)")
										$name:=$colItem.name
										If ($name="[tableForm]/@")
											$name:=Replace string:C233($name;"[tableForm]/";"[";1)
											$name:=Replace string:C233($name;"/";"];"+Char:C90(Double quote:K15:41);1)
											$name:=Replace string:C233($name;"/";Char:C90(Double quote:K15:41)+".";1)
										Else 
											$name:=Replace string:C233($name;"[projectForm]/";Char:C90(Double quote:K15:41);1)
											$name:=Replace string:C233($name;"/";Char:C90(Double quote:K15:41)+".";1)
										End if 
										$tmpTxt:=$tmpTxt+"// OM: "+$name+Char:C90(Carriage return:K15:38)
									: ($colItem.type="table")
										$tmpTxt:=$tmpTxt+"// Table: "+$colItem.name+Char:C90(Carriage return:K15:38)
									: ($colItem.type="field (@)")
										$tmpTxt:=$tmpTxt+"// Field: "+$colItem.name+Char:C90(Carriage return:K15:38)
									: ($colItem.type="command")
										$tmpTxt:=$tmpTxt+"// Command: "+$colItem.name+Char:C90(Carriage return:K15:38)
									: ($colItem.type="constant")
										$tmpTxt:=$tmpTxt+"// Constant: "+$colItem.name+Char:C90(Carriage return:K15:38)
									Else 
										$tmpTxt:=$tmpTxt+"// ??: "+$colItem.name+Char:C90(Carriage return:K15:38)
								End case 
								APPEND TO ARRAY:C911($aNames;$colItem.name)
							End if 
						End for each 
						
					End if 
					
					SET TEXT TO PASTEBOARD:C523($tmpTxt)
					ALERT:C41("Done successfully, the result with ("+String:C10($colNewSorted.length)+") entries is on the pasteboard")
					
			End case 
		End if 
		
End case 

// - EOF -