// OM: "_searchStruct".oBtnImport4DSearchResults (new LV 13.07.20, 17:13:35)
// Last change: LV 13.07.20, 17:13:35

C_TIME:C306($vhDocRef)
C_TEXT:C284($tmpTxt)
C_COLLECTION:C1488($col)
C_TEXT:C284($name; $type; $kind; $found; $line)
C_DATE:C307($date)
C_TIME:C306($time)
C_TEXT:C284($modification)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Use (Form:C1466.run)
			Form:C1466.run.run:=True:C214
		End use 
		OBJECT SET VISIBLE:C603(*; "oSpinnerImport"; True:C214)
		OBJECT SET VISIBLE:C603(*; "oPleaseWait"; True:C214)
		
		Form:C1466.searchResultsDisplay:=New collection:C1472
		
		$vhDocRef:=Open document:C264(""; "TEXT"; Read mode:K24:5)  // Open a TEXT document
		If (OK=1)  // If the document was opened
			RECEIVE PACKET:C104($vhDocRef; $tmpTxt; "}"+Char:C90(Line feed:K15:40)+Char:C90(Line feed:K15:40))
			Case of 
				: (Length:C16($tmpTxt)<2)
				: ($tmpTxt#"{@")
				Else 
					$tmpTxt:=$tmpTxt+"}"
					Form:C1466.importAttributes:=JSON Parse:C1218($tmpTxt)
			End case 
			
			ARRAY TEXT:C222($arrMethodPaths; 0)
			METHOD GET PATHS:C1163(Path all objects:K72:16; $arrMethodPaths; *)
			
			Repeat   // Loop until no more data
				RECEIVE PACKET:C104($vhDocRef; $tmpTxt; Char:C90(Line feed:K15:40))  // reads until it encounters a carriage return
				Case of 
					: (Length:C16($tmpTxt)<2)
					: (Position:C15(Char:C90(Tab:K15:37); $tmpTxt)<1)
					Else 
						$col:=Split string:C1554($tmpTxt; Char:C90(Tab:K15:37))
						If ($col.length>0)
							$type:=$col[0]
							Case of 
								: ($type="projectMethod")
									$type:="method (project)"
								: ($type="objectMethod")
									$type:="method (formobject)"
								: ($type="formMethod")
									$type:="method (form)"
								: ($type="databaseMethod")
									$type:="method (database)"
								: ($type="trigger")
									$type:="method (trigger)"
								: ($type="class")
									$type:="method (class)"
							End case 
						Else 
							$type:=""
						End if 
						If ($col.length>1)
							$name:=$col[1]
						Else 
							$name:=""
						End if 
						If ($col.length>2)
							$kind:=$col[2]
						Else 
							$kind:=""
						End if 
						If ($col.length>3)
							$found:=$col[3]
						Else 
							$found:=""
						End if 
						If ($col.length>4)
							$line:=$col[4]
						Else 
							$line:=""
						End if 
						$modification:=""
						If (($name#"") & ($type="method (@)"))
							If (Find in array:C230($arrMethodPaths; $name)>0)
								METHOD GET MODIFICATION DATE:C1170($name; $date; $time; *)
								$modification:=Replace string:C233(String:C10($date; ISO date:K1:8; $time); "T"; "_")
							End if 
						End if 
						Form:C1466.searchResultsDisplay.push(New object:C1471("name"; $name; "found"; $found; "modification"; $modification; "type"; $type; "kind"; $kind; "line"; $line))
				End case 
			Until (OK=0)
			CLOSE DOCUMENT:C267($vhDocRef)  // Close the document
			Form:C1466.searchResults:=Form:C1466.searchResultsDisplay
		End if 
		
		Use (Form:C1466.run)
			Form:C1466.run.run:=False:C215
		End use 
		OBJECT SET VISIBLE:C603(*; "oSpinnerImport"; False:C215)
		OBJECT SET VISIBLE:C603(*; "oPleaseWait@"; False:C215)
		
End case 

// - EOF -
