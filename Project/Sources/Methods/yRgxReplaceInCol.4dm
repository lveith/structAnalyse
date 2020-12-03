//%attributes = {}
  // PM: "yRgxReplaceInCol" (new LV 21.05.20, 09:48:23)
  // $0 - C_COLLECTION - colResult | $1.copy() with replaced content
  // $1 - C_COLLECTION - colSrc
  // $2 - C_TEXT       - rgxPattern
  // $3 - C_TEXT       - newStr (Replacement string)
  // Replace in a collection of text-items with rgxPattern
  // Last change: LV 21.05.20, 09:48:23

C_COLLECTION:C1488($0)
C_COLLECTION:C1488($colSrc;$1)
C_TEXT:C284($rgxPattern;$2)
C_TEXT:C284($newStr;$3)
C_LONGINT:C283($i)

If (Count parameters:C259>0)
	$colSrc:=$1.copy()
	If (Count parameters:C259>1)
		$rgxPattern:=$2
		If (Count parameters:C259>2)
			$newStr:=$3
		End if 
	End if 
End if 

For ($i;0;($colSrc.length-1))
	$colSrc[$i]:=yReplaceRegexG ($colSrc[$i];$rgxPattern;$newStr)
End for 

$0:=$colSrc

  // - EOF -