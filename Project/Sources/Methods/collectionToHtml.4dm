//%attributes = {}
// PM: "collectionToHtml" (new LV 19.05.20, 10:07:41)
// $1 - C_COLLECTION - Collection to dump out as HTML-Table
// $2 - C_TEXT - Name of the list for titles and filename (when empty than auto created)
// $3 - C_TEXT - Timelinetext (when empty than auto created)
// $4 - C_COLLECTION - attributesCollection (optional) with options for building list (if omitted than auto created), see PM: "yColToAttrCreate"
// $5 - C_BOOLEAN - isAltCall (optional)
// Dumps out a collection as HTML-Table
// Can used with collectionOfObjects(multicolumn keynamed) or with oneColumn(without keyname) plain collection too.
// By default all key-names used automatically as column-titles
// and by default all keys/columns dumped out in physically order.
// By the optional attributesCollection($4) the titles and the order can customized.
// With the optional attributesCollection($4) you can determine exactly
// which of the columns should be output (key->active),
// which title they should have (key->title)
// and in which order the columns should be arranged (key->sort).
// Every key in your collectionToDumpOut need a entry in attributesCollection,
// The attr[x].key value is physically keyname in your collectionToDumpOut
// and the attr[x].title value is a virtual name to used as column-title.
// To have a attributesCollection is optional,
// but when a attributesCollection is passed than it must be correct and must completely (yColToAttrCreate prepared a correct pattern).
// ----- colBase (plain example) -----
// [
//   "Aa",
//   "Bb",
//   "Cc",
//   "Dd"
// ]
// ----- colBase (multicolumn keynamed example) -----
// [
//   {
//     a: "Ax",
//     b: "Bx"
//   },
//   {
//     a: "Ay",
//     b: "By"
//   }
// ]
// ----- attributesCollection -----
// [
//   {
//     key: "a",
//     title: "a",
//     active: true,
//     sort: 10
//   },
//   {
//     key: "b",
//     title: "b",
//     active: true,
//     sort: 20
//   }
// ]
// --------------------
// Last change: LV 21.05.20, 15:44:57

C_TEXT:C284($srcTxt;$0)
C_COLLECTION:C1488($col;$1)
C_TEXT:C284($nameInfo;$2)
C_TEXT:C284($timeInfo;$3)
C_COLLECTION:C1488($colToAttr;$4)
C_BOOLEAN:C305($isAltCall;$5)

C_LONGINT:C283($i)
C_TEXT:C284($srcTxtStart;$srcTxtEnd)
C_COLLECTION:C1488($colBodyRow;$colKeys;$colKeysHead)
C_TEXT:C284($headRowTxt;$bodyRowsTxt;$rowPrefix;$rowSuffix;$cellPrefix;$cellSuffix;$cellSeparator;$rowSeparator)

If (Count parameters:C259>4)
	$isAltCall:=$5
Else 
	$isAltCall:=False:C215
End if 

If (Count parameters:C259>0)
	$col:=$1.copy()
Else   // ok, than use any test data
	$col:=New collection:C1472
	If (True:C214)
		$col:=yNewRandomCollection(100)
	Else 
		For ($i;1;1000)
			$col.push($i)
		End for 
	End if 
End if 

If (Count parameters:C259>1)
	$nameInfo:=$2
Else   // ok, than use any test name
	$nameInfo:="myCollectionA"
End if 

If (Count parameters:C259>2)  // $3 or automatic standard timeInfo
	$timeInfo:=$3
End if 
If (Not:C34($isAltCall))
	$timeInfo:=yGetTimeline($timeInfo)
End if 

Case of 
	: (Count parameters:C259>3)
		$colToAttr:=$4
	: (Form:C1466.colKeys=Null:C1517)
		$colToAttr:=yColToAttrCreate($col)
	: (Value type:C1509(Form:C1466.colKeys)#Is collection:K8:32)
		$colToAttr:=yColToAttrCreate($col)
	Else 
		$colToAttr:=Form:C1466.colKeys
End case 


$srcTxtStart:=""
$srcTxtStart:=$srcTxtStart+"<!DOCTYPE html>"
$srcTxtStart:=$srcTxtStart+"<html>"
$srcTxtStart:=$srcTxtStart+"<head>"
$srcTxtStart:=$srcTxtStart+"<meta charset=\"UTF-8\">"
$srcTxtStart:=$srcTxtStart+"<title>Collection: "+$nameInfo+"</title>"
$srcTxtStart:=$srcTxtStart+"<style type=\"text/css\">"

If (True:C214)  // styleTheme-1
	$srcTxtStart:=$srcTxtStart+"html, body, table {width: auto !important; margin: 0; padding: 0; color: #000; font-family: Tahoma, Verdana, Helvetica, Arial, sans-serif; font-size: 12px;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML {background-color: #f6f6f6;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .header {position: fixed; width: 100%; box-shadow: 1px 0px 5px rgb(0, 0, 20); border: 0px; background: rgba(0, 0, 139, 0.7); color: white; padding: 0; margin: 0; font-size: 16px; font-weight: bold;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .header > .headerContent {padding: 10px;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .header .timeLine {font-size: 10px; color: lightgrey;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .content {width: auto !important; height: calc(100vh - 60px) !important; overflow: auto !important; overflow: visible !important; padding: 0; margin: 0; padding-top: 60px;}"
	$srcTxtStart:=$srcTxtStart+".collectionHeadLine > th {background-color: rgb(51, 151, 129); color: white; font-weight: bold;}"
	$srcTxtStart:=$srcTxtStart+".collectionLine {background-color: #dfdfdf;}"
	$srcTxtStart:=$srcTxtStart+".collectionLine:nth-child(even){background-color: #f2f2f2}"
	$srcTxtStart:=$srcTxtStart+".collectionTable > thead {overflow: overlay !important;}"
	$srcTxtStart:=$srcTxtStart+".collectionTable > thead > tr > th {position: sticky !important; top: 60px !important; background-color: rgba(51, 151, 129, 0.67) !important; padding-top: 8px; padding-right: 8px; padding-bottom: 8px; padding-left: 8px;}"
	$srcTxtStart:=$srcTxtStart+".collectionTable > tbody > tr > td {padding-top: 8px; padding-right: 8px; padding-bottom: 8px; padding-left: 8px;}"
	
Else   // styleTheme-2
	$srcTxtStart:=$srcTxtStart+"html,body,table {width: auto !important; margin: 0; padding: 0; color: #000; font-family: Tahoma, Verdana, Helvetica, Arial, sans-serif; font-size: 12px;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML {background-color: #f6f6f6;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .header {position: fixed; width: 100%; box-shadow: 1px 0px 5px rgb(0, 0, 20); top: 0; left: 0; border: 0px; background: rgba(0, 0, 139, 0.7); color: white; padding: 0; font-size: 16px; font-weight: bold;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .header > .headerContent {padding: 10px;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .header .timeLine {font-size: 10px; color: lightgrey;}"
	$srcTxtStart:=$srcTxtStart+"body.collectionToHTML > .content {width: auto !important; overflow: overlay; padding: 10px; margin-top: 60px;}"
	$srcTxtStart:=$srcTxtStart+".collectionHeadLine > th {background-color: rgb(51, 151, 129); color: white; font-weight: bold;}"
	$srcTxtStart:=$srcTxtStart+".collectionLine {background-color: #dfdfdf;}"
	$srcTxtStart:=$srcTxtStart+".collectionLine:nth-child(even){background-color: #f2f2f2}"
	$srcTxtStart:=$srcTxtStart+".collectionTable > thead > tr > th {padding-top: 8px; padding-right: 8px; padding-bottom: 8px; padding-left: 8px;}"
	$srcTxtStart:=$srcTxtStart+".collectionTable > tbody > tr > td {padding-top: 8px; padding-right: 8px; padding-bottom: 8px; padding-left: 8px;}"
	
End if 

$srcTxtStart:=$srcTxtStart+"</style>"
$srcTxtStart:=$srcTxtStart+"</head>"
$srcTxtStart:=$srcTxtStart+"<body class=\"collectionToHTML\">"
$srcTxtStart:=$srcTxtStart+"<div class=\"header\"><div class=\"headerContent\">Collection: "+$nameInfo+"<br><i class=\"timeLine\">"+$timeInfo+"</i><br></div></div>"
$srcTxtStart:=$srcTxtStart+"<div class=\"content\">"
$srcTxtStart:=$srcTxtStart+"<table class=\"collectionTable\">"

$srcTxtEnd:=""
$srcTxtEnd:=$srcTxtEnd+"</tbody>"
$srcTxtEnd:=$srcTxtEnd+"</table>"
$srcTxtEnd:=$srcTxtEnd+"</div>"
$srcTxtEnd:=$srcTxtEnd+"</body>"
$srcTxtEnd:=$srcTxtEnd+"</html>"

$txtResult:=""

C_COLLECTION:C1488($colReplace)
$colReplace:=New collection:C1472
$colReplace.push(New object:C1471("from";"&";"to";"&amp;"))  // "&" must be first one in collection !!!
$colReplace.push(New object:C1471("from";"<";"to";"&lt;"))
$colReplace.push(New object:C1471("from";">";"to";"&gt;"))
$colReplace.push(New object:C1471("from";"\"";"to";"&quot;"))
$colReplace.push(New object:C1471("from";" ";"to";"&nbsp;"))
$colReplace.push(New object:C1471("from";"\t";"to";"&nbsp;"))
$colReplace.push(New object:C1471("from";"\r\n";"to";"<br>"))
$colReplace.push(New object:C1471("from";"\r";"to";"<br>"))
$colReplace.push(New object:C1471("from";"\n";"to";"<br>"))

$headRowTxt:=""
$colKeysHead:=yColKeysCollectionTo($colToAttr;True:C214)  // Get active items titles
If ($colKeysHead.length>0)
	$rowPrefix:="<thead><tr class=\"collectionHeadLine\">"
	$rowSuffix:="</tr></thead><tbody>"
	$cellPrefix:="<th>"
	$cellSuffix:="</th>"
	$cellSeparator:=""
	$rowSeparator:=""
	$headRowTxt:=$rowPrefix+$cellPrefix+$colKeysHead.join($cellSuffix+$cellSeparator+$cellPrefix)+$cellSuffix+$rowSuffix+$rowSeparator
End if 
If ($headRowTxt="")
	$headRowTxt:="<tbody>"
End if 

$bodyRowsTxt:=""
$colKeys:=yColKeysCollectionTo($colToAttr;False:C215)  // Get active items keys
$rowPrefix:="<tr class=\"collectionLine\">"
$rowSuffix:="</tr>"
$cellPrefix:="<td>"
$cellSuffix:="</td>"
$cellSeparator:=""
$rowSeparator:=""
If ($colKeys.length>0)
	$colBodyRow:=$col.map("colMapJoin";$rowPrefix;$rowSuffix;$cellPrefix;$cellSuffix;$cellSeparator;$colReplace;$colKeys)
Else 
	$colBodyRow:=$col.map("colMapJoin";$rowPrefix;$rowSuffix;$cellPrefix;$cellSuffix;$cellSeparator;$colReplace)
End if 
$bodyRowsTxt:=$colBodyRow.join($rowSeparator)

$srcTxt:=$srcTxtStart+$headRowTxt+$bodyRowsTxt+$srcTxtEnd

If (Not:C34($isAltCall))
	yCreateOpenTxtDoc($srcTxt;$nameInfo;".html")
End if 

$0:=$srcTxt

// - EOF -