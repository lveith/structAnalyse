//%attributes = {}
  // PM: "collectionToTsv" (new LV 20.05.20, 08:53:55)
  // $1 - C_COLLECTION - Collection to dump out as TSV (tab separated values)
  // $2 - C_TEXT - Name of the list for titles and filename (when empty than auto created)
  // $3 - C_TEXT - Timelinetext (when empty than auto created)
  // $4 - C_COLLECTION - Optional attributesCollection with options for building list (if omitted than auto created), see PM: "yColToAttrCreate"
  // $5 - C_BOOLEAN - isAltCall (optional)
  // Dumps out a collection as TSV (tab separated values)
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
  // Last change: LV 20.05.20, 08:54:06

C_COLLECTION:C1488($col;$1)
C_TEXT:C284($nameInfo;$2)
C_TEXT:C284($timeInfo;$3)
C_COLLECTION:C1488($colToAttr;$4)
C_BOOLEAN:C305($isAltCall;$5)

C_LONGINT:C283($i)
C_TIME:C306($docRef)
C_TEXT:C284($srcTxt)
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
		For ($i;1;1000)
			$col:=yNewRandomCollection (100)
		End for 
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
If (False:C215)  // ...set it to true if a title is wished...
	$srcTxtStart:=$srcTxtStart+$nameInfo+$lineBreak
	$srcTxtStart:=$srcTxtStart+$timeInfo+$lineBreak
	$srcTxtStart:=$srcTxtStart+$lineBreak
End if 

$srcTxtEnd:=""

$txtResult:=""

C_COLLECTION:C1488($colReplace)
$colReplace:=New collection:C1472
$colReplace.push(New object:C1471("from";"\"";"to";"'"))
$colReplace.push(New object:C1471("from";"\t";"to";" "))
$colReplace.push(New object:C1471("from";"\r\n";"to";" "))
$colReplace.push(New object:C1471("from";"\r";"to";" "))
$colReplace.push(New object:C1471("from";"\n";"to";" "))

$headRowTxt:=""
$colKeysHead:=yColKeysCollectionTo ($colToAttr;True:C214)  // Get active items titles
If ($colKeysHead.length>0)
	$rowPrefix:=""
	$rowSuffix:=""
	$cellPrefix:="\""
	$cellSuffix:="\""
	$cellSeparator:=Char:C90(Tab:K15:37)
	$rowSeparator:=$lineBreak
	$headRowTxt:=$rowPrefix+$cellPrefix+$colKeysHead.join($cellSuffix+$cellSeparator+$cellPrefix)+$cellSuffix+$rowSuffix+$rowSeparator
End if 

$bodyRowsTxt:=""
$colKeys:=yColKeysCollectionTo ($colToAttr;False:C215)  // Get active items keys
$rowPrefix:=""
$rowSuffix:=""
$cellPrefix:="\""
$cellSuffix:="\""
$cellSeparator:=Char:C90(Tab:K15:37)
$rowSeparator:=$lineBreak
If ($colKeys.length>0)
	$colBodyRow:=$col.map("colMapJoin";$rowPrefix;$rowSuffix;$cellPrefix;$cellSuffix;$cellSeparator;$colReplace;$colKeys)
Else 
	$colBodyRow:=$col.map("colMapJoin";$rowPrefix;$rowSuffix;$cellPrefix;$cellSuffix;$cellSeparator;$colReplace)
End if 
$bodyRowsTxt:=$colBodyRow.join($rowSeparator)

$srcTxt:=$srcTxtStart+$headRowTxt+$bodyRowsTxt+$srcTxtEnd

If (Not:C34($isAltCall))
	yCreateOpenTxtDoc ($srcTxt;$nameInfo;".tsv")
End if 

$0:=$srcTxt

  // - EOF -