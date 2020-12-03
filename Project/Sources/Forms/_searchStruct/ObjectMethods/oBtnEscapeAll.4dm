  // OM: LB_Test1.oBtnEscapeAll

Case of 
	: (Form:C1466.filterString=Null:C1517)
	: (Length:C16(Form:C1466.filterString)<1)
	Else 
		  // Escape all Chars which use as Regular Expression Operators
		  // . ^ $ * + - ? ( ) [ ] { } \ |
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;"\\";"\\\\")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;".";"\\.")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;"^";"\\^")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;"$";"\\$")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;"*";"\\*")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;"+";"\\+")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;"-";"\\-")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;"?";"\\?")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;"(";"\\(")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;")";"\\)")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;"[";"\\[")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;"]";"\\]")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;"{";"\\{")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;"}";"\\}")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;"|";"\\|")
		Form:C1466.filterString:=Replace string:C233(Form:C1466.filterString;":";"\\:")
		
End case 
