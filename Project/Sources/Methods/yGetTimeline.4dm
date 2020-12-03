//%attributes = {}
  // PM: "yGetTimeline" (new LV 20.05.20, 14:25:12)
  // $0 - C_TEXT - Result text
  // $1 - C_TEXT - Timelinetext (when empty than auto created)
  // $2 - C_TEXT - TimelineBefore (optional)
  // $3 - C_TEXT - TimelineAfter (optional)
  // Description
  // Last change: LV 20.05.20, 14:25:12

C_TEXT:C284($txtResult;$0)
C_TEXT:C284($timeInfo;$1)
C_TEXT:C284($timeInfoBefore;$2)
C_TEXT:C284($timeInfoAfter;$3)

$txtResult:=""

If (Count parameters:C259>0)
	$timeInfo:=$1
Else 
	$timeInfo:=""
End if 

If (Count parameters:C259>1)
	$timeInfoBefore:=$2
Else 
	$timeInfoBefore:=""
End if 

If (Count parameters:C259>2)
	$timeInfoAfter:=$3
Else 
	$timeInfoAfter:=""
End if 

If ($timeInfo="")
	$timeInfo:=String:C10(Current date:C33;System date long:K1:3)+" "+Lowercase:C14(String:C10(Current time:C178;HH MM AM PM:K7:5))
End if 

If (Count parameters:C259>1)
	Case of 
		: (($timeInfoBefore#"") & ($timeInfoAfter#""))
			$txtResult:=$timeInfoBefore+" "+$timeInfo+" "+$timeInfoAfter
			
		: ($timeInfoBefore#"")
			$txtResult:=$timeInfoBefore+" "+$timeInfo
			
		: ($timeInfoAfter#"")
			$txtResult:=$timeInfo+" "+$timeInfoAfter
			
		Else 
			$txtResult:=$timeInfo
			
	End case 
	
Else   // else try use formVars
	Case of 
		: ((Form:C1466.beforeTimeline=Null:C1517) | (Form:C1466.afterTimeline=Null:C1517))
			$txtResult:=$timeInfo
			
		: ((Form:C1466.beforeTimeline#"") & (Form:C1466.afterTimeline#""))
			$txtResult:=Form:C1466.beforeTimeline+" "+$timeInfo+" "+Form:C1466.afterTimeline
			
		: (Form:C1466.beforeTimeline#"")
			$txtResult:=Form:C1466.beforeTimeline+" "+$timeInfo
			
		: (Form:C1466.afterTimeline#"")
			$txtResult:=$timeInfo+" "+Form:C1466.afterTimeline
			
		Else 
			$txtResult:=$timeInfo
			
	End case 
	
End if 

$0:=$txtResult

  // - EOF -