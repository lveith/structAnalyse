//%attributes = {}
// PM: "zMatchRegexG" (new LV 21.05.20, 09:04:46)
// $0 - C_COLLECTION - if ($4=False) rsultCollection with found strings; else if ($4=True) rsultCollection with strings+positions+lengths
// $1 - C_TEXT - String in which search will be done
// $2 - C_TEXT - Regular expression
// $3 - C_LONGINT - Position in $srcTxt where search will start (Default=1)
// $4 - C_BOOLEAN - FALSE=ResultCollectionWithStrings or TRUE=ResultCollectionWithStrings+Pos+Length. (Default is FALSE)
// zMatchRegexG (srcTxt;regexPattern{;startPos{;withPosLengthResults}}) -> resultCollection with strings or with strings+postions+lengths
// This method always return all occurrences  (like regex-modifier "g"=global) and gives never any info about capture groups,
// ...for other usecases it is better to built another function
// UseExamples:
// - $resultCollection:=zMatchRegexG ("abc123xy98";"\\d")  // -> ["1","2","3","9","8"]
// - $resultCollection:=zMatchRegexG ("abc123xy98";"\\d+")  // -> ["123","98"]
// - $resultCollection:=zMatchRegexG ("abc123xy98";"\\d+";7)  // -> ["98"]
// - $resultCollection:=zMatchRegexG ("abc123xy98";"\\d+";1;True)  // -> [{strings:["123","98"]},{positions:[4,9]},{lengths:[3,2]}]
// - $resultCollection:=zMatchRegexG ("Dog called happyDog";"(HAPPY){0,1}(?i)DOG")  // -> ["Dog","Dog"]
// - $resultCollection:=zMatchRegexG ("Dog called happyDog";"(happy){0,1}(?i)DOG")  // -> ["Dog","happyDog"]
// - $resultCollection:=zMatchRegexG ("abc123 \r\n\t xy98";"\\p{C}")  // -> ["\r","\n","\t"] // find all cntrl-codes (not only CR, LF or TAB)
// - $resultCollection:=zMatchRegexG ("abc123 \r\n\t xy98";"[:cntrl:]")  // -> ["\r","\n","\t"] // find all cntrl-codes (not only CR, LF or TAB)
// - $resultCollection:=zMatchRegexG ("Dog called happyDog";"(?i)(HAPPY){0,1}DOG")  // -> ["Dog","happyDog"]
// - $resultCollection:=zMatchRegexG ("ABC123abc98";"abc")  // -> [abc]
// - $resultCollection:=zMatchRegexG ("ABCSS123abcß98";"(?i:abcss)")  // -> [ABCSS,abcß]
// - $resultCollection:=zMatchRegexG ("ABC123abc98";"(?-i:abc)")  // -> [abc]
// - $resultCollection:=zMatchRegexG ("aBxy123aBxY";"(?i)abxy")  // -> [aBxy,aBxY]
// - $resultCollection:=zMatchRegexG ("aBxy123aBxY";"(?i:ab)(?-i:xy)")  // -> [aBxy]
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
// Letzte Änderung: LV 21.05.20, 09:04:46

C_COLLECTION:C1488($colFoundStrings;$0)
C_TEXT:C284($srcTxt;$1)
C_TEXT:C284($regexPattern;$2)
C_LONGINT:C283($startPos;$3)
C_BOOLEAN:C305($withPosAndLength;$4)

C_BOOLEAN:C305($boolResult)
C_LONGINT:C283($posFound;$lengthFound)
C_COLLECTION:C1488($colFoundPos;$colFoundLength)

$startPos:=1  // Default=1

If (Count parameters:C259>0)
	$srcTxt:=$1
	If (Count parameters:C259>1)
		$regexPattern:=$2
		If (Count parameters:C259>2)
			$startPos:=$3
			If (Count parameters:C259>3)
				$withPosAndLength:=$4
			End if 
		End if 
	End if 
End if 

$colFoundStrings:=New collection:C1472
If ($withPosAndLength)
	$colFoundPos:=New collection:C1472
	$colFoundLength:=New collection:C1472
End if 

If ((Length:C16($srcTxt)>0) & (Length:C16($regexPattern)>0) & ($startPos>0) & ($startPos<=Length:C16($srcTxt)))
	Repeat 
		$boolResult:=Match regex:C1019($regexPattern;$srcTxt;$startPos;$posFound;$lengthFound)
		If (($boolResult) & ($posFound>0) & ($lengthFound>0))
			$colFoundStrings.push(Substring:C12($srcTxt;$posFound;$lengthFound))
			If ($withPosAndLength)
				$colFoundPos.push($posFound)
				$colFoundLength.push($lengthFound)
			End if 
			$startPos:=$posFound+$lengthFound
		Else 
			$boolResult:=False:C215
		End if 
	Until (Not:C34($boolResult) | Process aborted:C672)
End if 

If ($withPosAndLength)
	$0:=New collection:C1472(New object:C1471("strings";$colFoundStrings);New object:C1471("positions";$colFoundPos);New object:C1471("lengths";$colFoundLength))
Else 
	$0:=$colFoundStrings
End if 

// - EOF -