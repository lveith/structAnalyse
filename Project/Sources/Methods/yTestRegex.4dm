//%attributes = {}
  // PM: "yTestRegex" (new LV 25.07.20, 12:39:22)
  // Last change: LV 25.07.20, 12:39:22

C_BOOLEAN:C305($regexIsOk;$0)
C_LONGINT:C283($winRef;$1)
C_OBJECT:C1216($objRun;$2)
C_TEXT:C284($regexPattern;$3)
C_OBJECT:C1216($signal;$4)

C_BOOLEAN:C305($hasFoundOne)
C_LONGINT:C283($startPos;$posFound;$lengthFound)

If (Count parameters:C259>2)
	$winRef:=$1
	$objRun:=$2
	$regexPattern:=$3
	  // $regexPattern:="(?:/\\\\*(?:[^*]|(?:\\\\*+[^*/]))*\\\\*+/)|(?://.*)"
	
	If (Count parameters:C259<4)
		
		If ($regexPattern#"")
			$signal:=New signal:C1641("Dies ist mein erstes Signal")
			CALL WORKER:C1389("sisTestRegex";"yTestRegex";$winRef;$objRun;$regexPattern;$signal)
			$signaled:=$signal.wait(0.25)  //max. 1/5 Sekunde warten
			If ($signaled)
				  //ALERT("myworker hat die Arbeit beendet. Ergebnis: "+String($signal.myresult))
				$regexIsOk:=Bool:C1537($signal.myresult)
			Else 
				KILL WORKER:C1390("sisTestRegex")
				  //ALERT("myworker hat nicht unter 1/5 sek. beendet")
				$regexIsOk:=False:C215
			End if 
			
		Else 
			$regexIsOk:=True:C214  // not ok regexPattern be empty, but empty is always catched by Error#0
		End if 
		
		$0:=$regexIsOk
		
		KILL WORKER:C1390("sisTestRegex")
		
	Else 
		$signal:=$4
		
		$currErrMethode:=Method called on error:C704
		ON ERR CALL:C155("onErrMaybeRegex")
		Error:=0
		
		  // $hasFoundOne:=Match regex($regexPattern;"")
		  // Example following regexPattern can result in a infinite loop with ICU-matchRegex:
		  // $regexPattern:="(?:/\\\\*(?:[^*]|(?:\\\\*+[^*/]))*\\\\*+/)|(?://.*)"
		  // $srcText:="  //%attributes = {\"lang\":\"en\"} comment added and reserved by 4D."
		$srcText:="abc\rdef"
		
		$startPos:=1  // Default=1
		$hasFoundOne:=Match regex:C1019($regexPattern;$srcText;$startPos;$posFound;$lengthFound)
		
		ON ERR CALL:C155($currErrMethode)
		
		Use ($signal)
			$signal.myresult:=(Error=0)  //Ergebnis zurückgeben
		End use 
		$signal.trigger()  // Die Arbeit ist beendet
		
		If (Error#0)
			Error:=0
		End if 
		
		KILL WORKER:C1390
		
	End if 
	
End if 

  // - EOF -