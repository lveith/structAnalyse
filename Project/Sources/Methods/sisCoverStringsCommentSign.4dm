//%attributes = {"shared":true,"preemptive":"capable"}
// PM: "sisCoverStringsCommentSign" (new LV 13.07.20, 14:03:06)
// $0 - C_TEXT - Result text
// $1 - C_TEXT - srcTxt
// Cover Strings in doubleQuotes (just comment sign "//" inner strings)
// Example: sisCoverStringsWholeContent("var:=\"a//b\"+Timestamp") -> "var:=\"a⬝⬝b\"+Timestamp"
// Last change: LV 23.07.20, 17:06:12

C_TEXT:C284($0)
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

If (Length:C16($srcTxt)>0)
	$start:=1
	Repeat 
		$result:=Match regex:C1019($regexFilter;$srcTxt;$start;$posFound;$lengthFound)
		If (($result) & ($posFound>0) & ($lengthFound>0))
			$srcTxt:=Change string:C234($srcTxt;Replace string:C233(Substring:C12($srcTxt;$posFound;$lengthFound);"//";"◊◊");$posFound)  // cover code-comment prefix
			$start:=$posFound+$lengthFound
		Else 
			$result:=False:C215
		End if 
	Until (Not:C34($result))
End if 

$0:=$srcTxt

// - EOF -