//%attributes = {}
  // PM: "_doSearchMethodGetPaths" (new LV 18.07.20, 21:56:34)
  // Last change: LV 18.07.20, 21:56:34

C_TEXT:C284($result;$0)

Case of 
	: ($itemKind="pf")
		$methodType:=Path project form:K72:3
		
	: ($itemKind="tf")
		$methodType:=Path table form:K72:5
		
	: ($itemKind="pm")
		$methodType:=Path project method:K72:1
		
	: ($itemKind="cs")
		$methodType:=Path class:K72:19
		
	: ($itemKind="db")
		$methodType:=Path database method:K72:2
		
	: ($itemKind="trig")
		$methodType:=Path trigger:K72:4
		
	: ($itemKind="all")
		$methodType:=Path all objects:K72:16
		
	Else 
		$methodType:=-99999
		
End case 

If ($methodType#-99999)
	C_REAL:C285($lastTimeStamp)
	$lastTimeStamp:=0
	ARRAY TEXT:C222($arrMethodPaths;0)
	METHOD GET PATHS:C1163($methodType;$arrMethodPaths;$lastTimeStamp;*)
	
	$colMethods:=New collection:C1472
	ARRAY TO COLLECTION:C1563($colMethods;$arrMethodPaths;"path")
	
	$break:=False:C215
	
	For each ($objItem;$colMethods) Until ($break)
		
		METHOD GET MODIFICATION DATE:C1170($objItem.path;$date;$time;*)
		$objItem.mod:=String:C10($date;ISO date:K1:8;$time)
		
		$srcTxt:=""
		METHOD GET CODE:C1190($objItem.path;$srcTxt;*)
		$objItem.code:=$srcTxt
		
		If (Process aborted:C672)
			$break:=True:C214
		End if 
		
	End for each 
	
End if 

$result:=$0

  // - EOF -