//%attributes = {"shared":true}
  // PM: "sisGetCodeKeywords" (new LV 13.07.20, 14:28:02)
  // $0 - C_TEXT - txtResult
  // $1 - C_TEXT - srcTxt (4D code text)
  // Get code keywords
  // Last change: LV 13.07.20, 14:28:02

C_TEXT:C284($txtResult;$0)
C_TEXT:C284($srcTxt;$1)
C_COLLECTION:C1488($col;$colStrings;$colDates;$colTimes)

If (Count parameters:C259>0)
	$srcTxt:=$1
Else 
	$srcTxt:=""
End if 

If (Length:C16($srcTxt)>0)
	$txtResult:=sisStripComments ($srcTxt)
	$txtResult:=Replace string:C233($txtResult;"\t";"";*)  // replace hardcoded tabs (line indent) ...not the covered one "\t" in Strings
	$txtResult:=Replace string:C233($txtResult;"\\\r";"";*)  // replace "Entry on several lines"
	$txtResult:=Replace string:C233($txtResult;"  \r";"\r")  // remove 2x trailing spaces
	$txtResult:=Replace string:C233($txtResult;" \r";"\r")  // remove 1x trailing spaces
	$txtResult:=Replace string:C233($txtResult;"\r\r";"\r")  // remove empty lines
	$txtResult:=Replace string:C233($txtResult;"\r\r";"\r")  // remove empty lines
	If ($txtResult="\r@")
		$txtResult:=Substring:C12($txtResult;2)
	End if 
	If ($txtResult="@\r")
		$txtResult:=Substring:C12($txtResult;1;Length:C16($txtResult)-1)
	End if 
	
	$txtResult:=Replace string:C233($txtResult;"@";"")
	$colStrings:=sisStripStrings (->$txtResult)
	$colDates:=sisStripDates (->$txtResult)
	$colTimes:=sisStripTimes (->$txtResult)
	
	$txtResult:=Replace string:C233($txtResult;"<>";"◊◊")  // cover ip-vars prefix
	
	$txtResult:=Replace string:C233($txtResult;">>";"\r")  // Bit Operatoren
	$txtResult:=Replace string:C233($txtResult;"<<";"\r")  // Bit Operatoren
	$txtResult:=Replace string:C233($txtResult;"^|";"\r")  // Bit Operatoren
	$txtResult:=Replace string:C233($txtResult;"??";"\r")  // Bit Operatoren
	$txtResult:=Replace string:C233($txtResult;"?+";"\r")  // Bit Operatoren
	$txtResult:=Replace string:C233($txtResult;"?-";"\r")  // Bit Operatoren
	$txtResult:=Replace string:C233($txtResult;"(";"\r")
	$txtResult:=Replace string:C233($txtResult;")";"\r")
	$txtResult:=Replace string:C233($txtResult;";";"\r")
	$txtResult:=Replace string:C233($txtResult;".";"\r.")
	$txtResult:=Replace string:C233($txtResult;":=";"\r")
	$txtResult:=Replace string:C233($txtResult;"->";"\r")
	$txtResult:=Replace string:C233($txtResult;"*+";"\r")  // Bildoperatoren
	$txtResult:=Replace string:C233($txtResult;"*/";"\r")  // Bildoperatoren
	$txtResult:=Replace string:C233($txtResult;"+";"\r")  // Numerische Operatoren
	$txtResult:=Replace string:C233($txtResult;"-";"\r")  // Numerische Operatoren
	$txtResult:=Replace string:C233($txtResult;"*";"\r")  // Numerische Operatoren
	$txtResult:=Replace string:C233($txtResult;"%";"\r")  // Numerische Operatoren
	$txtResult:=Replace string:C233($txtResult;"^";"\r")  // Numerische Operatoren
	$txtResult:=Replace string:C233($txtResult;"/";"\r")  // Numerische Operatoren
	$txtResult:=Replace string:C233($txtResult;"\\";"\r")  // Numerische Operatoren
	$txtResult:=Replace string:C233($txtResult;">=";"\r")
	$txtResult:=Replace string:C233($txtResult;"<=";"\r")
	$txtResult:=Replace string:C233($txtResult;">";"\r")
	$txtResult:=Replace string:C233($txtResult;"<";"\r")
	$txtResult:=Replace string:C233($txtResult;"=";"\r")
	$txtResult:=Replace string:C233($txtResult;"#";"\r")
	$txtResult:=Replace string:C233($txtResult;"|";"\r")
	$txtResult:=Replace string:C233($txtResult;"&";"\r")
	$txtResult:=Replace string:C233($txtResult;"{";"\r")
	$txtResult:=Replace string:C233($txtResult;"}";"\r")
	$txtResult:=Replace string:C233($txtResult;"[[";"\r")
	$txtResult:=Replace string:C233($txtResult;"]]";"\r")
	$txtResult:=Replace string:C233($txtResult;"\r: \r";"\r")
	$txtResult:=Replace string:C233($txtResult;"\r\"\"\r";"\r")
	$txtResult:=Replace string:C233($txtResult;"\r\" \"\r";"\r")
	$txtResult:=Replace string:C233($txtResult;"\r\"\r";"\r")
	$txtResult:=Replace string:C233($txtResult;"\r\" \r";"\r")
	
	$col:=Split string:C1554($txtResult;"\r";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	$col:=$col.distinct()
	$txtResult:=$col.join("\r";ck ignore null or empty:K85:5)
	$txtResult:=Replace string:C233($txtResult;"\r\"\r";"\r")
	$txtResult:=Replace string:C233($txtResult;"\r\"\"\r";"\r")
	If ($txtResult="\"\r@")
		$txtResult:=Substring:C12($txtResult;3)
	End if 
	
	If ($colStrings.length>0)
		$txtResult:=$txtResult+"\r"+$colStrings.join("\r";ck ignore null or empty:K85:5)
	End if 
	If ($colDates.length>0)
		$txtResult:=$txtResult+"\r"+$colDates.join("\r";ck ignore null or empty:K85:5)
	End if 
	If ($colTimes.length>0)
		$txtResult:=$txtResult+"\r"+$colTimes.join("\r";ck ignore null or empty:K85:5)
	End if 
	
	$txtResult:=Replace string:C233($txtResult;"◊◊";"<>")  // re-cover ip-vars prefix
	
End if 

$0:=$txtResult

  // - EOF -
