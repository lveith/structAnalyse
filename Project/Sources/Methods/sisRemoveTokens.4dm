//%attributes = {"shared":true}
  // PM: "sisRemoveTokens" (new LV 13.07.20, 14:17:19)
  // $0 - C_TEXT - txtResult
  // $1 - C_TEXT - txtSrc4D
  // Remove tokens
  // Last change: LV 13.07.20, 14:17:19

C_TEXT:C284($txtResult;$0)
C_TEXT:C284($txtSrc4D;$1)
C_COLLECTION:C1488($colLines)
C_TEXT:C284($txtLine;$txtIndent)
C_LONGINT:C283($pos;$length)
C_BOOLEAN:C305($hasIndent)

If (Count parameters:C259>0)
	$txtSrc4D:=$1
Else 
	$txtSrc4D:=""
End if 

$txtResult:=""

$colLines:=New collection:C1472
$colLines:=Split string:C1554($txtSrc4D;Char:C90(13))  // create a code-lines-collection from my method-text

For each ($txtLine;$colLines)
	
	$hasIndent:=Match regex:C1019("^\\t+";$txtLine;1;$pos;$length)
	
	If ($hasIndent)
		$txtIndent:="\t"*$length
	Else 
		$txtIndent:=""
	End if 
	
	  // remove all tokens
	  // - CommentParts in code are correctly ignored: // some comment :C000 is here my pattern...
	  // - StringExpressions in code are correctly ignored: $x:=Replace string(":C000";"")
	$txtResult:=$txtResult+$txtIndent+Parse formula:C1576($txtLine)+Char:C90(13)
	
End for each 

$0:=$txtResult

  // - EOF -
