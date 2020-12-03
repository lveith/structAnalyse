//%attributes = {"preemptive":"capable"}
  // PM: "_doSearch" (new LV 13.07.20, 08:16:41)
  // $1 - C_LONGINT - windowReference, recipient of the results (sent by "CALL FORM")
  // $2 - C_OBJECT - obj.run (shared object): | True=run | False=stop |
  // $3 - C_TEXT - regexPattern
  // $4 - C_COLLECTION - colMethods [{path: myMethodPath, mod: myMethodModificationStamp, code: myMethodCode}, ...]
  // $5 - C_TEXT - kind for currCount: | all | pf | tf | pm | cs | db | trig |
  // $6 - C_LONGINT - currCount for | all | pf | tf | pm | cs | db | trig |
  // Search-In-Structure with regex pattern (called as worker)
  // Last change: LV 13.07.20, 08:16:41

C_LONGINT:C283($winRef;$1)
C_OBJECT:C1216($objRun;$2)
C_TEXT:C284($regexPattern;$3)
C_COLLECTION:C1488($colMethods;$4)
C_TEXT:C284($kind;$5)
C_LONGINT:C283($currCount;$6)

C_COLLECTION:C1488($colResult)
C_OBJECT:C1216($objMethodPars;$itemMethod)
C_BOOLEAN:C305($break)
C_TEXT:C284($currErrMethode)
C_LONGINT:C283($startCount)
C_LONGINT:C283($startPos)

If (Count parameters:C259>5)
	$winRef:=$1
	$objRun:=$2
	$regexPattern:=$3
	$colMethods:=$4
	$kind:=$5
	$currCount:=$6
	
	$startCount:=$currCount
	
	$currErrMethode:=Method called on error:C704
	ON ERR CALL:C155("onErrMaybeRegex")
	
	Error:=0
	$break:=_doSearchIsBreakThreadSafe ($winRef;$objRun)
	
	For each ($itemMethod;$colMethods) While (($break=False:C215) & (Error=0))
		
		$currCount:=$currCount+1
		
		If ($regexPattern="")
			$colResult:=New collection:C1472($itemMethod.code)
			
		Else 
			$startPos:=1  // Default=1
			
			Case of 
				: (($objRun.wholeContent) & ($objRun.ignoreCmts))
					If (Match regex:C1019($regexPattern;zReplaceRegexG (sisStripComments ($itemMethod.code);"(?m)^\\s*\r");$startPos))
						$colResult:=New collection:C1472($itemMethod.code)
					Else 
						$colResult:=New collection:C1472  // nothing found
					End if 
					
				: ($objRun.wholeContent)
					If (Match regex:C1019($regexPattern;$itemMethod.code;$startPos))
						$colResult:=New collection:C1472($itemMethod.code)
					Else 
						$colResult:=New collection:C1472  // nothing found
					End if 
					
				: ($objRun.ignoreCmts)
					$colResult:=zMatchRegexG (zReplaceRegexG (sisStripComments ($itemMethod.code);"(?m)^\\s*\r");$regexPattern)
					
				Else 
					$colResult:=zMatchRegexG ($itemMethod.code;$regexPattern)
					
			End case 
			
			  // $colResult:=zMatchRegexG_webArea($regexPattern;$itemMethod.code;"g")
			
			  //C_OBJECT($signal)
			  //$signal:=New signal("firstSignal")
			  //CALL FORM($winRef;"zMatchRegexG_webArea";$regexPattern;$itemMethod.code;"g";$signal)
			  //$signaled:=$signal.wait(9)  // max. 9 seconds wait
			  //If ($signaled)
			  //$colResult:=$signal.colResult
			  //Else 
			  //$colResult:=New collection
			  //End if 
			
		End if 
		
		If ($colResult.length>0)
			
			$objMethodPars:=New object:C1471
			$objMethodPars.modification:=$itemMethod.mod
			
			CALL FORM:C1391($winRef;"_addSearchResult";$currCount;$kind;$itemMethod.path;$colResult;$objMethodPars)
			
		Else 
			If ((($currCount%1000)=0) | (($currCount-$startCount)>=$colMethods.length))  // Just to avoid permanently blocking the recipient, not every counter step message is  transmitted
				CALL FORM:C1391($winRef;"_addSearchResult";$currCount;$kind)
			End if 
			
		End if 
		
		$break:=_doSearchIsBreakThreadSafe ($winRef;$objRun)
		
	End for each 
	
	If (Error#0)
		Use ($objRun)
			$objRun.run:=False:C215
		End use 
		CALL FORM:C1391($winRef;"_addSearchResult";0;"errorRegex")
	End if 
	
	ON ERR CALL:C155($currErrMethode)
	
Else 
	KILL WORKER:C1390
	Use ($objRun)
		$objRun.run:=False:C215
	End use 
	
End if 

  // - EOF -