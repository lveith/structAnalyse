//%attributes = {}
  // PM: "collectionToJson" (new LV 21.05.20, 09:03:40)
  // $1 - C_COLLECTION - Collection to dump out as JSON
  // $2 - C_TEXT - Name of the list for titles and filename (when empty than auto created)
  // $3 - C_TEXT - Timelinetext (when empty than auto created)
  // $4 - C_COLLECTION - Optional attributesCollection with options for building list (if omitted than auto created), see PM: "yColToAttrCreate"
  // $5 - C_BOOLEAN - isAltCall (optional)
  // Dumps out a collection as JSON
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
  // Last change: LV 21.05.20, 09:03:51

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
Else 
	$timeInfo:=String:C10(Current date:C33;System date long:K1:3)+" "+Lowercase:C14(String:C10(Current time:C178;HH MM AM PM:K7:5))
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

$txtResult:=""

  // C_COLLECTION($colReplace)
  // $colReplace:=New collection
  // $colReplace.push(New object("from";"\"";"to";"\"\""))
  // $colReplace.push(New object("from";"\t";"to";" "))
  // $colReplace.push(New object("from";"\r\n";"to";" "))
  // $colReplace.push(New object("from";"\r";"to";" "))
  // $colReplace.push(New object("from";"\n";"to";" "))

C_COLLECTION:C1488($colReducedKeys;$colReducedKeysHead)
$colReducedKeysHead:=yColKeysCollectionTo ($colToAttr;True:C214)  // Get active items titles
$colReducedKeysHead:=yRgxReplaceInCol ($colReducedKeysHead;"[^a-zA-Z0-9_]";"_")
$colReducedKeys:=yColKeysCollectionTo ($colToAttr;False:C215)  // Get active items keys
$srcTxt:=JSON Stringify:C1217(yColExtract ($col;$colReducedKeys;$colReducedKeysHead);*)

If (Not:C34($isAltCall))
	yCreateOpenTxtDoc ($srcTxt;$nameInfo;".csv")
End if 

$0:=$srcTxt

  // - EOF -