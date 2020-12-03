//%attributes = {}
  // PM: "collectionToXml" (new LV 20.05.20, 17:28:12)
  // $1 - C_COLLECTION - Collection to dump out as XML
  // $2 - C_TEXT - Name of the list for titles and filename (when empty than auto created)
  // $3 - C_TEXT - Timelinetext (when empty than auto created)
  // $4 - C_COLLECTION - attributesCollection (optional) with options for building list (if omitted than auto created), see PM: "yColToAttrCreate"
  // $5 - C_BOOLEAN - isAltCall (optional)
  // Dumps out a collection as XML
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
  // Last change: LV 20.05.20, 17:28:12

C_TEXT:C284($srcTxt;$0)
C_COLLECTION:C1488($col;$1)
C_TEXT:C284($nameInfo;$2)
C_TEXT:C284($timeInfo;$3)
C_COLLECTION:C1488($colToAttr;$4)
C_BOOLEAN:C305($isAltCall;$5)

C_LONGINT:C283($i)
C_TIME:C306($docRef)
C_TEXT:C284($srcTxtStart;$srcTxtEnd)
C_COLLECTION:C1488($colHeadRow;$colBodyRow;$colKeys;$colKeysHead)
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
		$col:=yNewRandomCollection (100)
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
	$timeInfo:=yGetTimeline ($timeInfo)
End if 

Case of 
	: (Count parameters:C259>3)
		$colToAttr:=$4
	: (Form:C1466.colKeys=Null:C1517)
		$colToAttr:=yColToAttrCreate ($col)
	: (Value type:C1509(Form:C1466.colKeys)#Is collection:K8:32)
		$colToAttr:=yColToAttrCreate ($col)
	Else 
		$colToAttr:=Form:C1466.colKeys
End case 

C_TEXT:C284($lineBreak)
If (Is macOS:C1572)
	$lineBreak:=Char:C90(Line feed:K15:40)
Else 
	$lineBreak:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
End if 

$srcTxtStart:=""
$srcTxtStart:=$srcTxtStart+"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>"+$lineBreak
$srcTxtStart:=$srcTxtStart+"<listroot>"+$lineBreak
$srcTxtStart:=$srcTxtStart+"<metainfo>"+$lineBreak
$srcTxtStart:=$srcTxtStart+"<listtitle>Collection: "+$nameInfo+"</listtitle>"+$lineBreak
$srcTxtStart:=$srcTxtStart+"<timeline>"+$timeInfo+"</timeline>"+$lineBreak
$srcTxtStart:=$srcTxtStart+"</metainfo>"+$lineBreak
$srcTxtStart:=$srcTxtStart+"<list>"+$lineBreak

$srcTxtEnd:=""
$srcTxtEnd:=$srcTxtEnd+"</list>"+$lineBreak
$srcTxtEnd:=$srcTxtEnd+"</listroot>"

$txtResult:=""

C_COLLECTION:C1488($colReplace)
$colReplace:=New collection:C1472
$colReplace.push(New object:C1471("from";"&";"to";"&amp;"))  // "&" must be first one in collection !!!
$colReplace.push(New object:C1471("from";"<";"to";"&lt;"))
$colReplace.push(New object:C1471("from";">";"to";"&gt;"))
$colReplace.push(New object:C1471("from";"\"";"to";"&quot;"))
$colReplace.push(New object:C1471("from";"\t";"to";" "))
$colReplace.push(New object:C1471("from";"\r\n";"to";" "))
$colReplace.push(New object:C1471("from";"\r";"to";" "))
$colReplace.push(New object:C1471("from";"\n";"to";" "))

$headRowTxt:=""
$colKeysHead:=yColKeysCollectionTo ($colToAttr;True:C214)  // Get active items titles
If (False:C215)
	If ($colKeysHead.length>0)
		$rowPrefix:="<item>"+$lineBreak
		$rowSuffix:="</item>"+$lineBreak
		$cellPrefix:=""
		$cellSuffix:=""
		$cellSeparator:=""
		$rowSeparator:=""
		$headRowTxt:=$rowPrefix+$cellPrefix+$colKeysHead.join($cellSuffix+$cellSeparator+$cellPrefix)+$cellSuffix+$rowSuffix+$rowSeparator
	End if 
End if 

$bodyRowsTxt:=""
$colKeys:=yColKeysCollectionTo ($colToAttr;False:C215)  // Get active items keys
$rowPrefix:="<item>"+$lineBreak
$rowSuffix:="</item>"+$lineBreak
$cellPrefix:="<itemprop key=\"###+keytitle+###\">"
$cellSuffix:="</itemprop>"+$lineBreak
$cellSeparator:=""
$rowSeparator:=""
If ($colKeys.length>0)
	$colBodyRow:=$col.map("colMapJoin";$rowPrefix;$rowSuffix;$cellPrefix;$cellSuffix;$cellSeparator;$colReplace;$colKeys;$colKeysHead)
Else 
	$colBodyRow:=$col.map("colMapJoin";$rowPrefix;$rowSuffix;$cellPrefix;$cellSuffix;$cellSeparator;$colReplace)
End if 
$bodyRowsTxt:=$colBodyRow.join($rowSeparator)

$srcTxt:=$srcTxtStart+$headRowTxt+$bodyRowsTxt+$srcTxtEnd

If (Not:C34($isAltCall))
	yCreateOpenTxtDoc ($srcTxt;$nameInfo;".xml")
End if 

$0:=$srcTxt

  // - EOF -