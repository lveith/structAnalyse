  // OM: "_searchStruct".oColSearchResultsDisplay (new LV 24.07.20, 19:07:04)
  // Last change: LV 24.07.20, 19:07:04

C_TEXT:C284($txtContent;$methodName)

Case of 
	: (Form event code:C388=On Selection Change:K2:29)
		
		Case of 
			: (Form:C1466.soCurrEl=Null:C1517)
				$txtContent:=""
			: (Value type:C1509(Form:C1466.soCurrEl.found)#Is text:K8:3)
				$txtContent:=""
			Else 
				$txtContent:=Form:C1466.soCurrEl.found
		End case 
		
		Case of 
			: (Form:C1466.soCurrEl=Null:C1517)
				$methodName:=""
			: (Value type:C1509(Form:C1466.soCurrEl.name)#Is text:K8:3)
				$methodName:=""
			Else 
				$methodName:=Form:C1466.soCurrEl.name
		End case 
		
		  // Enhanced call method, to first let redraw the listbox after the event onSelectionChange
		  // new marked row must draw immediately and can not wait until maybe a very big txtContent is ready submitted to webarea
		CALL WORKER:C1389("sisWorkerInsertText";"sisInsertTextInCodeMirrorPane";$txtContent;$methodName;Current form window:C827)
		
	: (Form event code:C388=On Header Click:K2:40)
		Case of 
			: (FORM Event:C1606=Null:C1517)
			: (FORM Event:C1606.columnName=Null:C1517)
			: (Value type:C1509(FORM Event:C1606.columnName)#Is text:K8:3)
			: (FORM Event:C1606.columnName#"oColumnFound")
			: (Value type:C1509(FORM Event:C1606.column)#Is real:K8:4)
			Else 
				
				If (Pop up menu:C542("ordered in ascending order;ordered in descending order")=2)
					Form:C1466.searchResultsDisplay:=Form:C1466.searchResultsDisplay.orderBy("found desc")
				Else 
					Form:C1466.searchResultsDisplay:=Form:C1466.searchResultsDisplay.orderBy("found asc")
				End if 
				
				
		End case 
		
End case 

  // - EOF -