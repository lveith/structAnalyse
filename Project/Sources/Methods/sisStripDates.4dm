//%attributes = {"shared":true}
  // PM: "sisStripDates" (new LV 13.07.20, 14:06:41)
  // $0 - C_TEXT - colResult
  // $1 - C_POINTER - ptrSrcTxt
  // Strip dates
  // Last change: LV 13.07.20, 14:06:41

C_COLLECTION:C1488($colResult;$0)
C_POINTER:C301($ptrSrcTxt;$1)
C_TEXT:C284($regexFilter;$txtResult)  // Bei Bedarf regex Steuerzeichen deaktivieren/maskieren mit "\\", also doppelt wg. 4D den Backslash mit Backslash maskieren und verbleibender Backslash ist für regex. Beispiel: "a-z0-9_\\-\\." also nur "abcdefghijklmnopqrstuvwxyz0123456789_-." oder z.B. "a-zA-Z" für Klein+Gross
C_BOOLEAN:C305($result)
C_LONGINT:C283($start;$posFound;$lengthFound)

$regexFilter:="\\!(?:\\\\?.)*?\\!"
$colResult:=New collection:C1472

If (Count parameters:C259>0)
	$ptrSrcTxt:=$1
	
	If (Length:C16($ptrSrcTxt->)>0)
		$start:=1
		Repeat 
			$result:=Match regex:C1019($regexFilter;$ptrSrcTxt->;$start;$posFound;$lengthFound)
			If (($result) & ($posFound>0) & ($lengthFound>0))
				$txtResult:=$txtResult+Substring:C12($ptrSrcTxt->;$start;$posFound-$start)
				If ($lengthFound>2)  // ...more than empty string ""
					$colResult.push(Substring:C12($ptrSrcTxt->;$posFound;$lengthFound))
				End if 
				$start:=$posFound+$lengthFound
			Else 
				$txtResult:=$txtResult+Substring:C12($ptrSrcTxt->;$start)
				$result:=False:C215
			End if 
		Until (Not:C34($result))
		$colResult:=$colResult.distinct()
		$ptrSrcTxt->:=$txtResult
	End if 
End if 

$0:=$colResult

  // - EOF -