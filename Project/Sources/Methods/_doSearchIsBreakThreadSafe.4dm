//%attributes = {}
  // PM: "_doSearchIsBreakThreadSafe" (new LV 19.07.20, 08:35:42)
  // $0 - C_BOOLEAN - Result: True=break | False=noBreak
  // $1 - C_LONGINT - windowReference, recipient of the results (sent by "CALL FORM")
  // $2 - C_OBJECT - obj.run (shared object): | True=run | False=stop |
  // Get workers break signal
  // obj.run (shared object): | True=run | False=stop |
  // Last change: LV 19.07.20, 08:35:42

C_BOOLEAN:C305($break;$0)
C_LONGINT:C283($winRef;$1)
C_OBJECT:C1216($objRun;$2)

$winRef:=$1
$objRun:=$2

Case of 
	: (Process aborted:C672)
		$break:=True:C214
		Use ($objRun)
			$objRun.run:=False:C215
		End use 
		
		  // sorry, windowProcess is not Thread-safe
		  //: (Window process($winRef)=0)  // If the window does not exist, 0 is returned
		  //$break:=True
		  //Use ($objRun)
		  //$objRun.run:=False
		  //End use 
		
	Else 
		$break:=Not:C34($objRun.run)
		
End case 

$0:=$break

  // - EOF -