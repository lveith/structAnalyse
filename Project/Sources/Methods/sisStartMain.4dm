//%attributes = {"shared":true}
  // PM: "sisStartMain" (new LV 13.07.20, 08:10:25)
  // $1 - C_TEXT - calledByMethodName (do not use this, normally only for intern use to selfLaunch)
  // Starts the tool 'SIS | Search-In-Structure' in own process with own dialog.
  // With this method you can start the SIS-Tool with own code,
  // but normally you use the macroMenu to start the tool without own coding (macro use same method to start SIS).
  // Last change: LV 13.07.20, 08:10:25

C_TEXT:C284($calledBy;$1)
C_LONGINT:C283($winRef)
C_LONGINT:C283($processId)

If (Count parameters:C259>0)
	$calledBy:=$1
Else 
	$calledBy:=""
End if 

If ($calledBy#Current method name:C684)  // isSelfLauched
	  // Start the process (if it does not exist) or bring it to the front (if it is already running)
	$processId:=New process:C317(Current method name:C684;0;"sisAnalyserMain";Current method name:C684;*)
	If ($processId#0)
		SHOW PROCESS:C325($processId)
		BRING TO FRONT:C326($processId)
	End if 
	
Else 
	$winRef:=Open form window:C675("_searchStruct")
	
	If (True:C214)
		SET WINDOW TITLE:C213("SIS - Search in structure - displays only analysis results without making any changes")
	Else 
		$info4D:=yGet4DVersionShortname 
		If (Version type:C495 ?? 64 bit version:K5:25)
			$info4D:=$info4D+"(64bit)"
		Else 
			$info4D:=$info4D+"(32bit)"
		End if 
		If (Is compiled mode:C492)
			$info4D:=$info4D+" compiled"
		Else 
			$info4D:=$info4D+" interpreted"
		End if 
		
		SET WINDOW TITLE:C213("structAnalyse | "+$info4D)
	End if 
	
	DIALOG:C40("_searchStruct")
	CLOSE WINDOW:C154($winRef)
	
End if 

  // - EOF -