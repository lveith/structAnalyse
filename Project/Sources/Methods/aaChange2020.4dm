//%attributes = {"invisible":true}
// PM: "aaChange2020" (new LV 15.07.20, 09:47:32)
// Last change: LV 15.07.20, 09:47:32


//Case of 
//: ($yColToAttrCreate=True)
//: (<>yColToAttrCreate=True)
//: (99>yColToAttrCreate($col).length)
//: (Count parameters>6)
//$colToAttr:=$7
//: (Form.colKeys=Null)
//$colToAttr:=yColToAttrCreate($col)
//: (Value type(Form.colKeys)#Is collection)
//$colToAttr:=yColToAttrCreate($col)
//Else 
//$colToAttr:=Form.colKeys
//End case 






//C_COLLECTION($col)
//$col:=New collection(0;1;2;3;4;5;6;7;8;9)
//$col.remove(3;2)  // $col=["a","b","c","g","h"]
//  //$col.remove(3)  // $col=["a","b","c","e","f","g","h"]
//  //$col.remove(-8;1)  // $col=["b","c","g","h"]
//  //$col.remove(-3;1)  // $col=["b","g","h"]
//IDLE

//C_REAL($lastTimeStamp)
//$lastTimeStamp:=0

//C_REAL(gVarLastTimeStamp)

//ARRAY TEXT($arrMethodPaths;0)
//METHOD GET PATHS(Path project method;$arrMethodPaths;gVarLastTimeStamp;*)

//IDLE

// ==========================================

// REGEX equal for only "SEARCH" Button to load any Datas
// Do not forget copy&paste without "// "

// Every whole method document as one foundEntry (to filter with queries more detailed, just a workaround later this are buttons)
// ^[\D\d]*$

// Whole method document content as one foundEntry which contains "search"
// ^[\D\d]*search[\D\d]*$

// Whole method document content as one foundEntry which contains separated word "search"
// ^[\D\d]*\bsearch\b[\D\d]*$

// All Multiline-Comment-Blocks(one wholeMultilineBlock as one foundEntry): /*...*/
// (?im)^\s*((/\*)[\D\d]*(\*/)).*$

// All Blocks(one wholeMultilineBlock as one foundEntry): If...End if
// (?im)^\s*If \(.*$[\D\d]*^\s*End if\s*$

// All Blocks(one wholeMultilineBlock as one foundEntry): Use...End use
// (?im)^\s*Use \(.*$[\D\d]*^\s*End use\s*$

// All Lines(wholeLine as one foundEntry) which contains separated word "search": CodeLineStart...search...codeLineEnd
// (?im)^.*\bsearch\b.*$

// All Lines(wholeLine as one foundEntry) which contains "search": CodeLineStart...search...codeLineEnd
// (?im)^.*search.*$

// All 3xChars+"search"+3xChars (every string-match as one foundEntry e.g. "a cSearch 2_")
// ...search...

// All Comments and Comment-Blocks, "//..." or "/* ....\r.... */" (but do not respect nested cmt-blocks in cmt-blocks
// ((?:\/\*(?:[^*]|(?:\*+[^*\/]))*\*+\/)|(?:\/\/.*))

// 2.Versuch:
// All Blocks(one wholeMultilineBlock as one foundEntry): If...End if
// (?s)If \((.*?)End if

// ----- word boundary -----

// Note: Do not forget, char '$' (localVarPrefix) is a nonWordChar, same as "<>" (ipVarPrefix)
// ...if searching with '\b' (word boundary) use with/without flag 'w' (UREGEX_UWORD controls the behavior of \b in a pattern)

// All Lines(wholeLine as one foundEntry) which contains "call" as a word boundary: CodeLineStart...<call>...codeLineEnd
// E.g. matches word boundaries like exist inside: '$func.call()', '$1.call()', '(call)', '($call)', 'ON ERR CALL', 'CALL WORKER', 'On Outside Call', 'CALL FORM'
// E.g. did NOT machtches when 'call' is not a separated word boundary: 'Method called on error'
// (?im)^.*\b(call)\b.*$

// All Lines(wholeLine as one foundEntry) which contains "call" as a word boundary(flag=w): CodeLineStart...<call>...codeLineEnd
// E.g. matches word boundaries like exist inside: '$1.call()', '(call)', '($call)', 'ON ERR CALL', 'CALL WORKER', 'On Outside Call', 'CALL FORM'
// E.g. did NOT machtches when 'call' is not a separated word boundary: 'Method called on error', '$func.call()'
// (?imw)^.*\b(call)\b.*$

// All Lines(wholeLine as one foundEntry) which contains "call" as a beginWith word boundary: CodeLineStart...<call>...codeLineEnd
// E.g. matches word boundaries like exist inside: '$func.call()', 'Method called on error', '$1.call()', '(call)', '($call)', 'ON ERR CALL', 'CALL WORKER', 'On Outside Call', 'CALL FORM'
// E.g. did NOT machtches when 'call' is not a beginWith separated word boundary: 'myCall'
// (?im)^.*\b(call).*$

// All Lines(wholeLine as one foundEntry) which contains "call" as a beginWith word boundary(flag=w): CodeLineStart...<call>...codeLineEnd
// E.g. matches word boundaries like exist inside: 'Method called on error', '$1.call()', '(call)', '($call)', 'ON ERR CALL', 'CALL WORKER', 'On Outside Call', 'CALL FORM'
// E.g. did NOT machtches when 'call' is not a beginWith separated word boundary: '$func.call()', 'myCall'
// (?imw)^.*\b(call).*$

// ==========================================

// Search regex method-lines with localvar error: $vara$varb
// (?m)^.*\$\w*\$.*$

// Find regex highlight localvar with error: $vara$varb
// /\$\w*\$\w*/

// -------------

// Search regex method-lines with localvars äöüß: $varÄpfel
// (?im)^.*\$\w*[äöüß]+.*$

// ==========================================



//C_TEXT($itemKind)
//C_COLLECTION($kinds)
//$kinds:=New collection("a";"b";"c")
//$break:=False
//For each ($itemKind;$kinds) While (Not($break))
//ALERT($itemKind)
//$break:=True
//End for each 

/* ===
comment-line-1
comment-line-2
comment-line-3
/* ---
nested cmt-block
nested-line-2
--- */
comment-line-4
comment-line-5
comment-line-6
=== */


IDLE:C311  // vorspann _doSearch

// Match regex("(?i)^[\\D\\d]*\\b((ab)|(cd))\\b[\\D\\d]*$";"ab cd")

// - EOF -