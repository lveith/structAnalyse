//%attributes = {"shared":true}
  // PM: "sisGetFormKeywords" (new LV 13.07.20, 14:25:48)
  // $0 - C_TEXT - txtResult
  // $1 - C_TEXT - srcTxt (json text form properties)
  // Get form keywords
  // Last change: LV 13.07.20, 14:25:48

C_TEXT:C284($txtResult;$0)
C_TEXT:C284($srcTxt;$1)
C_COLLECTION:C1488($colResult)

If (Count parameters:C259>0)
	$srcTxt:=$1
Else 
	$srcTxt:=""
End if 

If (Length:C16($srcTxt)>0)
	$txtResult:=""
	$colResult:=New collection:C1472
	  // $regexFilter:="\"dataSource\"\\: \"[^\\r]*\""
	$regexFilter:="Source\"\\: \"[^\\r]*\""
	$start:=1
	Repeat 
		$result:=Match regex:C1019($regexFilter;$srcTxt;$start;$posFound;$lengthFound)
		If (($result) & ($posFound>0) & ($lengthFound>0))
			If ($lengthFound>2)  // ...more than empty string ""
				$colResult.push(Substring:C12($srcTxt;$posFound+10;$lengthFound-11))
			End if 
			$start:=$posFound+$lengthFound
		Else 
			$result:=False:C215
		End if 
	Until (Not:C34($result))
	$colResult:=$colResult.distinct()
	$txtResult:=$colResult.join("\r";ck ignore null or empty:K85:5)
	
	$txtResult:=Replace string:C233($txtResult;"<>";"◊◊")  // cover ip-vars prefix
	
	$txtResult:=Replace string:C233($txtResult;"@";"")
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
	
	$txtResult:=Replace string:C233($txtResult;"◊◊";"<>")  // re-cover ip-vars prefix
	$colResult.combine(Split string:C1554($txtResult;"\r";sk ignore empty strings:K86:1+sk trim spaces:K86:2))
	$colResult:=$colResult.distinct()
	$txtResult:=$colResult.join("\r";ck ignore null or empty:K85:5)
	
End if 

$0:=$txtResult

  // - EOF -