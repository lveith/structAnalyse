  // OM: "_searchStruct".oBtnQuerySelection (new LV 23.07.20, 16:29:52)
  // Last change: LV 23.07.20, 16:29:52

C_BOOLEAN:C305($useRegexFilter)
C_TEXT:C284($filterItemName;$filterString)
C_TEXT:C284($currErrMethode)
C_POINTER:C301($ptrChooseFilterItem;$ptrChooseFilterType)
C_LONGINT:C283($item)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Form:C1466.searchResultsDisplay=Null:C1517)
				BEEP:C151
			: (Form:C1466.searchResultsDisplay.length<1)
				BEEP:C151
			Else 
				$useRegexFilter:=False:C215
				$ptrChooseFilterItem:=OBJECT Get pointer:C1124(Object named:K67:5;"oChooseFilterItem")
				$ptrChooseFilterType:=OBJECT Get pointer:C1124(Object named:K67:5;"oChooseFilterType")
				Case of 
					: (Form:C1466.toggleSearch=Null:C1517)
					: (Form:C1466.toggleSearch<1)
					: (Form:C1466.filterString=Null:C1517)
						BEEP:C151
					: (Length:C16(Form:C1466.filterString)<1)
						BEEP:C151
					: (Is nil pointer:C315($ptrChooseFilterItem))
						BEEP:C151
					: (($ptrChooseFilterItem->)<1)
						BEEP:C151
					: (Is nil pointer:C315($ptrChooseFilterType))
						BEEP:C151
					: (($ptrChooseFilterType->)<1)
						BEEP:C151
					Else 
						$useRegexFilter:=True:C214
						$item:=$ptrChooseFilterItem->
						$filterItemName:=$ptrChooseFilterItem->{$item}
						$filterString:=Form:C1466.filterString
						Case of 
							: (($ptrChooseFilterType->)=1)  // contains the regexPattern
								If ($filterString#"[\\d\\D]*@[\\d\\D]*")
									$filterString:="[\\d\\D]*"+$filterString+"[\\d\\D]*"
								End if 
							: (($ptrChooseFilterType->)=2)  // equal with regexPattern
							: (($ptrChooseFilterType->)=3)  // beginWith with regexPattern
								If ($filterString#"@[\\d\\D]*")
									$filterString:=$filterString+"[\\d\\D]*"
								End if 
							: (($ptrChooseFilterType->)=4)  // endWith with regexPattern
								If ($filterString#"[\\d\\D]*@")
									$filterString:="[\\d\\D]*"+$filterString
								End if 
						End case 
				End case 
				If (($useRegexFilter) & (Length:C16($filterItemName)>0))
					OK:=0
					Error:=0
					$currErrMethode:=Method called on error:C704
					ON ERR CALL:C155("yErrCallNum")
					Form:C1466.searchResultsDisplay:=Form:C1466.searchResultsDisplay.filter("zMatchRegexColFunc";$filterItemName;$filterString)
					ON ERR CALL:C155($currErrMethode)
				Else 
					Case of 
						: (Form:C1466.txtQuery=Null:C1517)
							BEEP:C151
						: (Length:C16(Form:C1466.txtQuery)<2)
							BEEP:C151
						Else 
							Form:C1466.searchResultsDisplay:=Form:C1466.searchResultsDisplay.query(Form:C1466.txtQuery)
					End case 
				End if 
				
		End case 
		
End case 

  // - EOF -