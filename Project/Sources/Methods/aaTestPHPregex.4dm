//%attributes = {}

  // This example removes unnecessary spaces from a string 
C_TEXT:C284($myString)
$myString:="foo       o        bar"

$start:=Milliseconds:C459
$bool:=PHP Execute:C1058("";"preg_replace";$myString;"/\\s\\s+/";" ";$myString)
$stop:=Milliseconds:C459
ALERT:C41("php (PCRE)\r"+String:C10($stop-$start))  // what a huge of time it needs to PHP Execute :-( only for to remove doubleWhiteSpace in this small exampleText
  // needs 1000 times more than with use icu(cmd 'Match regex') or with 4Dwebarea and javacript regex
  // this php regex is absolutly useless for to do one million regex executions in a loop

ALERT:C41($myString)
  //The string is now 'foo o bar' without repeated spaces