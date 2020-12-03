//%attributes = {"shared":true}
// PM: "sisCoverStringsWholeContent" (new LV 23.07.20, 17:03:59)
// $0 - C_TEXT - Result text whith covered content inner doubleQuoteStrings
// $1 - C_TEXT - srcTxt (any 4D srcCodeText)
// Cover Strings in doubleQuotes (whole content inner strings)
// Example: sisCoverStringsWholeContent("var:=\"abc\"+Timestamp") -> "var:=\"⬝⬝⬝\"+Timestamp"
// Last change: LV 23.07.20, 17:04:10

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
			$srcTxt:=Change string:C234($srcTxt;"\""+("⬝"*($lengthFound-2))+"\"";$posFound)
			$start:=$posFound+$lengthFound
		Else 
			$result:=False:C215
		End if 
	Until (Not:C34($result))
End if 

$0:=$srcTxt

// - EOF -