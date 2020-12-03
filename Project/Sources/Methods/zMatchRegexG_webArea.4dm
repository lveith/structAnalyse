//%attributes = {}
  // PM: "zMatchRegexG_webArea" (new LV 25.07.20, 16:25:12)
  // C_COLLECTION - C_TEXT - colResult
  // $1 - C_TEXT - regexPattern
  // $2 - C_TEXT - srcTxt
  // $3 - C_TEXT - flags
  // MatchRegex(G=FlagGlobal) execute in webArea with javascript
  // Last change: LV 25.07.20, 16:25:12

C_COLLECTION:C1488($colResult;$0)
C_TEXT:C284($regexPattern;$1)
C_TEXT:C284($srcTxt;$2)
C_TEXT:C284($flags;$3)
C_OBJECT:C1216($signal;$4)

If (Count parameters:C259>0)
	$regexPattern:=$1
	If (Count parameters:C259>1)
		$srcTxt:=$2
		If (Count parameters:C259>2)
			$flags:=$3
		End if 
	End if 
End if 

  // function myGetMatchRegex(myRegExPattern, mySrcTxt, flags)
WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"myGetMatchRegex";$colResult;$regexPattern;$srcTxt;$flags)
  // Note: Command not thread-safe "WA EXECUTE JAVASCRIPT FUNCTION"

If ($colResult=Null:C1517)
	$colResult:=New collection:C1472
End if 

If (Count parameters:C259>3)
	$signal:=$4
	$colResult:=$colResult.copy(ck shared:K85:29;$colResult)
	Use ($colResult)
		Use ($signal)
			$signal.colResult:=$colResult  // return result
			  // collection is not allowed value type in a sharec object
		End use 
	End use 
	$signal.trigger()  // work is done
	
Else 
	$0:=$colResult
	
End if 

  // - EOF -