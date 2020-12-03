//%attributes = {}
  // PM: "_doSearchMain" (new LV 13.07.20, 08:16:41)
  // $1 - C_LONGINT - windowReference, recipient of the results (sent by "CALL FORM")
  // $2 - C_OBJECT - obj.run (shared object): | True=run | False=stop |
  // $3 - C_TEXT - regexPattern
  // $4 - C_COLLECTION - kinds: | ["all"] | ["pf", "tf", "pm", "cs", "db", "trig"]
  // MAIN-Start: Search-In-Structure with regex pattern (called as worker)
  // Last change: LV 20.07.20, 18:10:01

C_LONGINT:C283($winRef;$1)
C_OBJECT:C1216($objRun;$2)
C_TEXT:C284($regexPattern;$3)
C_COLLECTION:C1488($kinds;$4)

C_TEXT:C284($srcTxt;$workerName)
C_LONGINT:C283($methodType)
C_COLLECTION:C1488($colMethods)
C_OBJECT:C1216($objItem)
C_DATE:C307($date)
C_TIME:C306($time)
C_TEXT:C284($itemKind)
C_LONGINT:C283($length;$itemCounter)
C_BOOLEAN:C305($break)
C_BOOLEAN:C305($useCachedValuesInProcessVar)
C_REAL:C285($lastTimeStamp)
C_POINTER:C301($ptrMethodsVar;$ptrTimestampVar)
C_REAL:C285(gVarTimestampPf;gVarTimestampTf;gVarTimestampPm;gVarTimestampCs;gVarTimestampDb;gVarTimestampTrig;gVarTimestampAll)
C_COLLECTION:C1488(gVarMethodsPf;gVarMethodsTf;gVarMethodsPm;gVarMethodsCs;gVarMethodsDb;gVarMethodsTrig;gVarMethodsAll)

If (Count parameters:C259>2)
	$winRef:=$1
	$objRun:=$2
	$regexPattern:=$3
	
	If (Count parameters:C259>3)
		$kinds:=$4
	Else 
		$kinds:=New collection:C1472("all")
	End if 
	
	$break:=_doSearchIsBreak ($winRef;$objRun)
	
	  //If ($regexPattern#"")
	  //If (Not(yTestRegex ($winRef;$objRun;$regexPattern)))
	  //$break:=True
	  //CALL FORM($winRef;"_addSearchResult";0;"errorRegex")
	  //End if 
	  //End if 
	
	For each ($itemKind;$kinds) While (Not:C34($break))
		
		Case of 
			: ($itemKind="pf")
				$methodType:=Path project form:K72:3
				$ptrMethodsVar:=->gVarMethodsPf
				$ptrTimestampVar:=->gVarTimestampPf
				
			: ($itemKind="tf")
				$methodType:=Path table form:K72:5
				$ptrMethodsVar:=->gVarMethodsTf
				$ptrTimestampVar:=->gVarTimestampTf
				
			: ($itemKind="pm")
				$methodType:=Path project method:K72:1
				$ptrMethodsVar:=->gVarMethodsPm
				$ptrTimestampVar:=->gVarTimestampPm
				
			: ($itemKind="cs")
				$methodType:=Path class:K72:19
				$ptrMethodsVar:=->gVarMethodsCs
				$ptrTimestampVar:=->gVarTimestampCs
				
			: ($itemKind="db")
				$methodType:=Path database method:K72:2
				$ptrMethodsVar:=->gVarMethodsDb
				$ptrTimestampVar:=->gVarTimestampDb
				
			: ($itemKind="trig")
				$methodType:=Path trigger:K72:4
				$ptrMethodsVar:=->gVarMethodsTrig
				$ptrTimestampVar:=->gVarTimestampTrig
				
			: ($itemKind="all")
				$methodType:=Path all objects:K72:16
				$ptrMethodsVar:=->gVarMethodsAll
				$ptrTimestampVar:=->gVarTimestampAll
				
			Else 
				$methodType:=-99999
				
		End case 
		
		If ($methodType#-99999)
			$lastTimeStamp:=0  // value=0 let load all 'METHOD GET PATHS' and returns current lastTimeStamp
			ARRAY TEXT:C222($arrMethodPaths;0)
			METHOD GET PATHS:C1163($methodType;$arrMethodPaths;$lastTimeStamp;*)
			CALL FORM:C1391($winRef;"_addSearchResult";Size of array:C274($arrMethodPaths);$itemKind+"Max")
			
			$workerName:="sisWorkerSearch"+Uppercase:C13($itemKind[[1]])+Substring:C12($itemKind;2)+"Methods"
			$useCachedValuesInProcessVar:=False:C215
			
			Case of 
				: ($ptrTimestampVar->=0)
				: ($ptrTimestampVar->#$lastTimeStamp)  // take care, deleted methods do not update timestamp, so old maybe sometimes old cache used here
				: ($ptrMethodsVar->=Null:C1517)
				: ($ptrMethodsVar->length=Null:C1517)
				: ($ptrMethodsVar->length<1)
				: (Size of array:C274($arrMethodPaths)#$ptrMethodsVar->length)  // diff length (e.g. when some methods have deleted what does not change timestamp)
				Else 
					$useCachedValuesInProcessVar:=True:C214
			End case 
			
			If ($useCachedValuesInProcessVar)
				$colMethods:=$ptrMethodsVar->
				If ($colMethods.length>0)
					CALL WORKER:C1389($workerName;"_doSearch";$winRef;$objRun;$regexPattern;$colMethods;$itemKind;0)
				End if 
				
			Else 
				
				  //If (Not(Is compiled mode))
				  //// DEBUG
				  //ALERT($itemKind+Char(Carriage return)+String($ptrMethodsVar->length)+" | "+String(Size of array($arrMethodPaths))+Char(Carriage return)+String($ptrTimestampVar->)+" | "+String($lastTimeStamp))
				  //End if 
				
				$colMethods:=New collection:C1472
				ARRAY TO COLLECTION:C1563($colMethods;$arrMethodPaths;"path")
				
				$length:=$colMethods.length
				$itemCounter:=0
				$break:=_doSearchIsBreak ($winRef;$objRun)
				
				For each ($objItem;$colMethods) Until ($break)
					
					$itemCounter:=$itemCounter+1
					
					METHOD GET MODIFICATION DATE:C1170($objItem.path;$date;$time;*)
					$objItem.mod:=String:C10($date;ISO date:K1:8;$time)
					
					$srcTxt:=""
					METHOD GET CODE:C1190($objItem.path;$srcTxt;*)
					$objItem.code:=$srcTxt
					
					Case of 
						: (($itemCounter%100)=0)
							CALL WORKER:C1389($workerName;"_doSearch";$winRef;$objRun;$regexPattern;$colMethods.slice($itemCounter-100;$itemCounter);$itemKind;$itemCounter-100)
							
						: ($itemCounter>=$length)
							CALL WORKER:C1389($workerName;"_doSearch";$winRef;$objRun;$regexPattern;$colMethods.slice($length-($itemCounter%100);$length);$itemKind;$length-($itemCounter%100))
							
					End case 
					
					$break:=_doSearchIsBreak ($winRef;$objRun)
					
				End for each 
				
				$ptrMethodsVar->:=$colMethods
				$ptrTimestampVar->:=$lastTimeStamp
			End if 
			
			  //If ($colMethods.length>0)
			  //CALL WORKER("sisWorkerSearchMainSub_"+$itemKind;"_doSearchMainSub";$winRef;$objRun;$regexPattern;$itemKind;$colMethods)
			  //End if 
			
		End if 
		
		$break:=_doSearchIsBreak ($winRef;$objRun)
		
	End for each 
	
Else 
	KILL WORKER:C1390
	Use (Form:C1466.run)
		Form:C1466.run.run:=False:C215
	End use 
	
End if 

  // - EOF -