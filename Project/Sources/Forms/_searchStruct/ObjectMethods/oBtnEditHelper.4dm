  // PM: "_searchStruct".oBtnEditHelper (new LV 30.07.20, 16:55:03)
  // Last change: LV 30.07.20, 16:55:03

C_TEXT:C284($toggleSearchState)
C_LONGINT:C283($vlUserChoice)
C_TEXT:C284($vtItems;$elDistinct;$tmpTxt)
C_COLLECTION:C1488($colMenuItems;$colMenuItemsVal)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		Case of 
			: (Form:C1466.toggleSearch=Null:C1517)
				$toggleSearchState:="queryString"
				
			: (Form:C1466.toggleSearch>0)
				$toggleSearchState:="regex"
				
			Else 
				$toggleSearchState:="queryString"
				
		End case 
		
		$colMenuItems:=New collection:C1472
		$colMenuItemsVal:=New collection:C1472
		
		If ($toggleSearchState="regex")
			  // "regex" 
			
			$colMenuItems.push("All Lines(wholeLine as one foundEntry) which contains \"search\": CodeLineStart...search...codeLineEnd")
			$colMenuItemsVal.push("(?im)^.*search.*$")
			
			$colMenuItems.push("All Lines(wholeLine as one foundEntry) which contains separated word \"search\": CodeLineStart...search...codeLineEnd")
			$colMenuItemsVal.push("(?im)^.*\\bsearch\\b.*$")
			
			$colMenuItems.push("Whole method document content as one foundEntry which contains \"search\"")
			$colMenuItemsVal.push("^[\\D\\d]*search[\\D\\d]*$")
			
			$colMenuItems.push("Whole method document content as one foundEntry which contains separated word \"search\"")
			$colMenuItemsVal.push("^[\\D\\d]*\\bsearch\\b[\\D\\d]*$")
			
			  // $colMenuItems.push("All Multiline-Comment-Blocks(one wholeMultilineBlock as one foundEntry): /*...*/")
			  // $colMenuItemsVal.push("(?im)^\\s*((/\\*)[\\D\\d]*(\\*/)).*$")
			
			  // $colMenuItems.push("All Blocks(one wholeMultilineBlock as one foundEntry): If...End if")
			  // $colMenuItemsVal.push("(?im)^\\s*If \\(.*$[\\D\\d]*^\\s*End if\\s*$")
			
			  // $colMenuItems.push("All Blocks(one wholeMultilineBlock as one foundEntry): Use...End use")
			  // $colMenuItemsVal.push("(?im)^\\s*Use \\(.*$[\\D\\d]*^\\s*End use\\s*$")
			
			$vtItems:=""
			For each ($elDistinct;$colMenuItems)
				$vtItems:=$vtItems+Char:C90(1)+$elDistinct
			End for each 
			
			If (Length:C16($vtItems)>0)
				$vlUserChoice:=0
				$vlUserChoice:=Pop up menu:C542($vtItems)
				If (($vlUserChoice>0) & ($vlUserChoice<=$colMenuItems.length))
					Form:C1466.filterString:=$colMenuItemsVal[$vlUserChoice-1]
				End if 
			End if 
			
		Else 
			  // "queryString" 
			
			If ((Form:C1466.txtQuery=Null:C1517) | (Form:C1466.txtQuery=""))
				$colMenuItems.push("name = '@'")
				$colMenuItems.push("found = '@'")
				$colMenuItems.push("modification >= '2020-01-31_00:00@'")
				$colMenuItems.push("type = 'method (project)'")
				
			Else 
				$colMenuItems.push("AND name = '@'")
				$colMenuItems.push("AND found = '@'")
				$colMenuItems.push("AND modification >= '2020-01-31_00:00@'")
				$colMenuItems.push("AND type = 'method (project)'")
				
				$colMenuItems.push("OR name = '@'")
				$colMenuItems.push("OR found = '@'")
				$colMenuItems.push("OR modification >= '2020-01-31_00:00@'")
				$colMenuItems.push("OR type = 'method (project)'")
				
			End if 
			
			
			$vtItems:=""
			For each ($elDistinct;$colMenuItems)
				$vtItems:=$vtItems+Char:C90(1)+$elDistinct
			End for each 
			
			If (Length:C16($vtItems)>0)
				$vlUserChoice:=0
				$vlUserChoice:=Pop up menu:C542($vtItems)
				If (($vlUserChoice>0) & ($vlUserChoice<=$colMenuItems.length))
					If ((Form:C1466.txtQuery=Null:C1517) | (Form:C1466.txtQuery="") | (Substring:C12(Form:C1466.txtQuery;Length:C16(Form:C1466.txtQuery))=Char:C90(Carriage return:K15:38)))
						Form:C1466.txtQuery:=Form:C1466.txtQuery+$colMenuItems[$vlUserChoice-1]
					Else 
						Form:C1466.txtQuery:=Form:C1466.txtQuery+Char:C90(Carriage return:K15:38)+$colMenuItems[$vlUserChoice-1]
					End if 
				End if 
			End if 
			
		End if 
		
End case 

  // - EOF -