//%attributes = {"shared":true,"preemptive":"capable"}
  // PM: "sisStripComments" (new LV 13.07.20, 14:00:35)
  // $0 - C_TEXT - txtResult
  // $1 - C_TEXT - srcTxt
  // Strip comments
  // Last change: LV 13.07.20, 14:00:35

C_TEXT:C284($txtResult;$0)
C_TEXT:C284($srcTxt;$1)
C_TEXT:C284($regexFilter)  // Bei Bedarf regex Steuerzeichen deaktivieren/maskieren mit "\\", also doppelt wg. 4D den Backslash mit Backslash maskieren und verbleibender Backslash ist für regex. Beispiel: "a-z0-9_\\-\\." also nur "abcdefghijklmnopqrstuvwxyz0123456789_-." oder z.B. "a-zA-Z" für Klein+Gross
C_BOOLEAN:C305($result)
C_LONGINT:C283($start;$posFound;$lengthFound)
C_TEXT:C284($srcTxtCoveredStrings)

If (Count parameters:C259>0)
	$srcTxt:=$1
Else 
	$srcTxt:=""
End if 

$regexFilter:="\\/\\/(?!@).*"
$txtResult:=""

If (Length:C16($srcTxt)>0)
	$srcTxtCoveredStrings:=sisCoverStringsCommentSign ($srcTxt)
	$start:=1
	Repeat 
		$result:=Match regex:C1019($regexFilter;$srcTxtCoveredStrings;$start;$posFound;$lengthFound)
		If (($result) & ($posFound>0) & ($lengthFound>0))
			$txtResult:=$txtResult+Substring:C12($srcTxt;$start;$posFound-$start)
			$start:=$posFound+$lengthFound
		Else 
			$txtResult:=$txtResult+Substring:C12($srcTxt;$start)
			$result:=False:C215
		End if 
	Until (Not:C34($result))
End if 

$0:=$txtResult

  // - EOF -