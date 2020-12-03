  // PM: "_searchStruct".oFilterTypes (new LV 29.07.20, 16:07:27)
  // Last change: LV 29.07.20, 16:07:27

C_LONGINT:C283($vlUserChoice)
C_TEXT:C284($vtItems;$elDistinct;$tmpTxt)
C_COLLECTION:C1488($colDistinct)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Form:C1466.searchResultsDisplay=Null:C1517)
				BEEP:C151
			: (Form:C1466.searchResultsDisplay.length<1)
				BEEP:C151
				
			Else 
				$colDistinct:=Form:C1466.searchResultsDisplay.distinct("type";ck diacritical:K85:3)
				$vtItems:=""
				For each ($elDistinct;$colDistinct)
					$vtItems:=$vtItems+Char:C90(1)+$elDistinct
				End for each 
				
				If (Length:C16($vtItems)>0)
					$vlUserChoice:=0
					$vlUserChoice:=Pop up menu:C542($vtItems)
					If ($vlUserChoice>0)
						$tmpTxt:="type = '"+$colDistinct[$vlUserChoice-1]+"'"
						Form:C1466.searchResultsDisplay:=Form:C1466.searchResultsDisplay.query($tmpTxt)
						  //Case of 
						  //: (Form.txtQuery=Null)
						  //Form.txtQuery:=$tmpTxt
						  //: (Length(Form.txtQuery)<1)
						  //Form.txtQuery:=$tmpTxt
						  //: (Form.txtQuery=("@"+Char(Carriage return)))
						  //Form.txtQuery:=Form.txtQuery+$tmpTxt
						  //: (Form.txtQuery#"@ ")
						  //Form.txtQuery:=Form.txtQuery+" "+$tmpTxt
						  //Else 
						  //Form.txtQuery:=Form.txtQuery+$tmpTxt
						  //End case 
						
					End if 
				End if 
		End case 
		
End case 

  // - EOF -
