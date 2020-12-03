//%attributes = {}
  // PM: "_doSearchMainSub" (new LV 13.07.20, 08:16:41)
  // $1 - C_LONGINT - windowReference, recipient of the results (sent by "CALL FORM")
  // $2 - C_OBJECT - obj.run (shared object): | True=run | False=stop |
  // $3 - C_TEXT - regexPattern
  // $4 - C_TEXT - itemKind: | "pf" | "tf" | "pm" | "cs" | "db" | "trig" | "all" |
  // $5 - C_COLLECTION - colMethods [{path: myMePath1}, {path: myMePath2}, ...]
  // MAIN-Start: Search-In-Structure with regex pattern (called as worker)
  // Last change: LV 13.07.20, 08:16:41

C_LONGINT:C283($winRef;$1)
C_OBJECT:C1216($objRun;$2)
C_TEXT:C284($regexPattern;$3)
C_TEXT:C284($itemKind;$4)
C_COLLECTION:C1488($colMethods;$5)

C_TEXT:C284($srcTxt;$workerName)
C_OBJECT:C1216($objItem)
C_DATE:C307($date)
C_TIME:C306($time)
C_BOOLEAN:C305($break)
C_LONGINT:C283($length;$itemCounter)

If (Count parameters:C259>4)
	$winRef:=$1
	$objRun:=$2
	$regexPattern:=$3
	$itemKind:=$4
	$colMethods:=$5
	
	$length:=$colMethods.length
	
	$workerName:="sisWorkerSearch"+Uppercase:C13($itemKind[[1]])+Substring:C12($itemKind;2)+"Methods"
	
	$itemCounter:=0
	
	$break:=_doSearchIsBreak ($winRef;$objRun)
	
	For each ($objItem;$colMethods) Until ($break)
		
		$itemCounter:=$itemCounter+1
		
		If ($objItem.mod=Null:C1517)
			METHOD GET MODIFICATION DATE:C1170($objItem.path;$date;$time;*)
			$objItem.mod:=String:C10($date;ISO date:K1:8;$time)
		End if 
		
		If ($objItem.code=Null:C1517)
			$srcTxt:=""
			METHOD GET CODE:C1190($objItem.path;$srcTxt;*)
			$objItem.code:=$srcTxt
		End if 
		
		Case of 
			: (($itemCounter%100)=0)
				CALL WORKER:C1389($workerName;"_doSearch";$winRef;$objRun;$regexPattern;$colMethods.slice($itemCounter-100;$itemCounter);$itemKind;$itemCounter-100)
				
			: ($itemCounter>=$length)
				CALL WORKER:C1389($workerName;"_doSearch";$winRef;$objRun;$regexPattern;$colMethods.slice($length-($itemCounter%100);$length);$itemKind;$length-($itemCounter%100))
				
		End case 
		
		$break:=_doSearchIsBreak ($winRef;$objRun)
		
	End for each 
	
Else 
	KILL WORKER:C1390
	Use (Form:C1466.run)
		Form:C1466.run.run:=False:C215
	End use 
	
End if 

  // - EOF -