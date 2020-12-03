//%attributes = {"shared":true}
  // PM: "sisGetUniqueStringColFromTxt" (new LV 13.07.20, 14:21:27)
  // $0 - C_COLLECTION - colResult
  // $1 - C_TEXT - srcTxt
  // Get unique stringCollection from text
  // Last change: LV 13.07.20, 14:21:27

C_COLLECTION:C1488($colResult;$0)
C_TEXT:C284($srcTxt;$1)
C_TEXT:C284($regexFilter)  // Bei Bedarf regex Steuerzeichen deaktivieren/maskieren mit "\\", also doppelt wg. 4D den Backslash mit Backslash maskieren und verbleibender Backslash ist für regex. Beispiel: "a-z0-9_\\-\\." also nur "abcdefghijklmnopqrstuvwxyz0123456789_-." oder z.B. "a-zA-Z" für Klein+Gross
C_BOOLEAN:C305($result)
C_LONGINT:C283($start;$posFound;$lengthFound)

If (Count parameters:C259>0)
	$srcTxt:=$1
Else 
	$srcTxt:=""
End if 

$regexFilter:="\"(?:\\\\?.)*?\""
$colResult:=New collection:C1472

If (Length:C16($srcTxt)>0)
	$start:=1
	Repeat 
		$result:=Match regex:C1019($regexFilter;$srcTxt;$start;$posFound;$lengthFound)
		If (($result) & ($posFound>0) & ($lengthFound>0))
			If ($lengthFound>2)  // ...more than empty string ""
				$colResult.push(Substring:C12($srcTxt;$posFound;$lengthFound))
			End if 
			$start:=$posFound+$lengthFound
		Else 
			$result:=False:C215
		End if 
	Until (Not:C34($result))
	$colResult:=$colResult.distinct()
End if 

$0:=$colResult

  // - EOF -