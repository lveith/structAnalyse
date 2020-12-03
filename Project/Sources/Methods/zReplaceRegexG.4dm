//%attributes = {}
  // PM: "zReplaceRegexG" (neu LV 15.08.2019)
  // $0 - C_TEXT - Ergebnis-Text (also Quelltext mit Ersetzungen)
  // $1 - C_TEXT - Quell-Text (Textquelle in der Ersetzungen vorgenommen werde sollen)
  // $2 - C_TEXT - regexPattern - Bei Bedarf regex Steuerzeichen deaktivieren/maskieren mit "\\", also doppelt wg. 4D den Backslash mit Backslash maskieren und verbleibender Backslash ist für regex. Beispiel: "a-z0-9_\\-\\." also nur "abcdefghijklmnopqrstuvwxyz0123456789_-." oder z.B. "a-zA-Z" für Klein+Gross
  // $3 - C_TEXT - replaceWithText - Text mit dem Fundstücke ersetzt werden sollen
  // $4 - C_LONGINT - startPos(optional; default=1; ; MIN=1 bis MAX=Length(srcTxt) anderfalls $0:=srcTxt) im srcText ab dem Match/Replace beginnen soll
  // $5 - C_LONGINT - maxLength(optional; default without limit) maximale Länge von resultText($0) (u.a. Absicherung des patterns endlos lange Ergebnisse zu zeugen)
  // zReplaceRegexG (srcTxt;regexPattern{;replaceWithText{;startPos{;maxLength}}}) -> resultTxt
  // This method replace all occurrences (like regex-modifier "g"=global)
  // ...for other usecases it is better to built another function
  // UseExamples:
  // - $resultTxt:=zReplaceRegexG ("abc123xy98";"\\d")  // -> "abcxy"
  // - $resultTxt:=zReplaceRegexG ("abc123xy98";"\\D")  // -> "12398"
  // - $resultTxt:=zReplaceRegexG ("1a2bc123xy98";"\\D";"z")  // -> "1z2zz123zz98"
  // - $resultTxt:=zReplaceRegexG ("abc123 \r\n\t xy98";"\\p{C}")  // -> "abc123  xy98" // replaces all cntrl-codes (not only CR, LF or TAB)
  // - $resultTxt:=zReplaceRegexG ("abc123 \r\n\t xy98";"[:cntrl:]")  // -> "abc123  xy98" // replaces all cntrl-codes (not only CR, LF or TAB)
  // - $resultTxt:=zReplaceRegexG ("ABCSS123abcß98";"(?i:abcss)")  // -> "12398"
  // - $resultTxt:=zReplaceRegexG ("ABC123abc98";"(?-i:abc)")  // -> "ABC12398"
  // - $resultTxt:=zReplaceRegexG ("aBxy123aBxY";"(?i)abxy")  // -> "123"
  // - $resultTxt:=zReplaceRegexG ("aBxy123aBxY";"(?i:ab)(?-i:xy)")  // -> "123aBxY"
  // Tip: if you need regex-flags/-modifiers for example case-insensitive use "(?i)" in your regex-pattern ...possible flags (?ismwx-ismwx) ...not (g for global)
  // - (?ismwx-ismwx: ... )Flag settings. Evaluate the parenthesized expression with the specified flags enabled or "-" disabled.
  // - (?ismwx-ismwx)Flag settings. Change the flag settings. Changes apply to the portion of the pattern following the setting. For example, (?i) changes to a case insensitive match.
  // - i - CASE_INSENSITIVE - If set, matching will take place in a case-insensitive manner.
  // - x - COMMENTS - If set, allow use of white space and #comments within patterns
  // - s - DOTALL - If set, a "." in a pattern will match a line terminator in the input text. By default, it will not. Note that a carriage-return / line-feed pair in text behave as a single line terminator, 
  // - m - MULTILINE - Control the behavior of "^" and "$" in a pattern. By default these will only match at the start and end, respectively, of the input text. If this flag is set, "^" and "$" will also match at the start and end of each line within the input text.
  // - w - UWORD - Controls the behavior of \b in a pattern. If set, word boundaries are found according to the definitions of word found in Unicode UAX 29, Text Boundaries.
  // See docu "Using ICU Regular Expressions": http://userguide.icu-project.org/strings/regexp
  // Infos about 4D Command "Match regex"
  // - $posFound and $lengthFound must declare before. Both as Longint or both as LongintArray
  // - if $posFound and $lengthFound is undefined, this results in Error 48 "Syntax error"
  // - if parameter 5 is specified as asterix, occurrence must begin on startpos, otherwise occurrence can begin on/after startpos
  // - if parameter 3 (start<1) or start>(Length(aString)+1), results in Error 304(xbox) "U_INDEX_OUTOFBOUNDS_ERROR"
  // Remember, "Match regex" can be used in three ways:
  // - 1.Way) Parameter 4+5 as Longint (only find first occurrence)
  // - 2.Way) Parameter 4+5 as LongintArray (only find first occurrence with additionally pos+length of capture groups)
  // - 3.Way) Only with two parameters to get boolResult only (plus complete equality!): Match regex ($regexPattern;$srcTxt)
  // Letzte Änderung: LV 17.08.2019, 08:30

C_TEXT:C284($resultTxt;$0)
C_TEXT:C284($srcTxt;$1)
C_TEXT:C284($regexPattern;$2)
C_TEXT:C284($replTxt;$3)
C_LONGINT:C283($startPos;$4)
C_LONGINT:C283($maxLength;$5)

C_BOOLEAN:C305($boolResult;$doLimitLength)
C_LONGINT:C283($posFound;$lengthFound)

$startPos:=1  // Default 1 entspricht BeginnBeiErstenZeichen im $srcTxt
$maxLength:=-1  // Default -1 entspricht OhneLängenLimit für Ergebnis $resultTxt
$doLimitLength:=False:C215  // False=OhneLängenLimit; True=MitLängenLimit für Ergebnis $resultTxt
$regexPattern:=""
$replTxt:=""
$resultTxt:=""
$srcTxt:=""

If (Count parameters:C259>0)
	$srcTxt:=$1
	If (Count parameters:C259>1)
		$regexPattern:=$2
		If (Count parameters:C259>2)
			$replTxt:=$3
			If (Count parameters:C259>3)
				$startPos:=$4
				If (Count parameters:C259>4)
					$maxLength:=$5
					$doLimitLength:=($maxLength>0)
				End if 
			End if 
		End if 
	End if 
End if 

If ((Length:C16($srcTxt)>0) & (Length:C16($regexPattern)>0) & ($startPos>0) & ($startPos<=Length:C16($srcTxt)))
	Repeat 
		$boolResult:=Match regex:C1019($regexPattern;$srcTxt;$startPos;$posFound;$lengthFound)
		If (($boolResult) & ($posFound>0) & ($lengthFound>0))
			$resultTxt:=$resultTxt+Substring:C12($srcTxt;$startPos;$posFound-$startPos)+$replTxt
			If ($doLimitLength)
				If (Length:C16($resultTxt)>=$maxLength)
					$resultTxt:=Substring:C12($resultTxt;1;$maxLength)
					$boolResult:=False:C215
				Else 
					$startPos:=$posFound+$lengthFound
				End if 
			Else 
				$startPos:=$posFound+$lengthFound
			End if 
		Else 
			$resultTxt:=$resultTxt+Substring:C12($srcTxt;$startPos)  // get whole rest of srcText. When nothing found than the rest is whole srcText
			$boolResult:=False:C215
		End if 
	Until (Not:C34($boolResult))
	
Else 
	$resultTxt:=$srcTxt  // Suche mit diesen Aufrufparameter nicht möglich, in dem Fall ist $resultTxt($0) immer gleich $srcTxt zurückzugeben weil es keine Matches für einen Replace geben kann
	
End if 

$0:=$resultTxt

  // - EOF -