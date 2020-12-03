//%attributes = {}
// PM: "collectionTo" (new LV 20.05.20, 08:13:36)
// $1 - C_COLLECTION - SrcCollectionToDumpOut
// $2 - C_TEXT -       DocType | ".html" | ".csv" | ".md" | ".txt" | ".tsv" | ".xml" | ".json" |
// $3 - C_TEXT -       NameOflist for titles and filename (when empty than auto created)
// $4 - C_TEXT -       Timelinetext (when empty than auto created)
// $5 - C_TEXT -       TimelineBefore (optional)
// $6 - C_TEXT -       TimelineAfter (optional)
// $7 - C_COLLECTION - AttributesCollection (optional) with options for building list (if omitted than auto created), see PM: "yColToAttrCreate"
// Dumps out a collection as HTML/CSV/MD/TXT/TSV
// Can used with collectionOfObjects(multicolumn keynamed) or with oneColumn(without keyname) plain collection too.
// By default all key-names used automatically as column-titles
// and by default all keys/columns dumped out in physically order.
// By the optional attributesCollection the titles and the order can customized.
// With the optional attributesCollection you can determine exactly
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
// Last change: LV 20.05.20, 14:13:34

C_COLLECTION:C1488($col;$1)
C_TEXT:C284($docType;$2)
C_TEXT:C284($nameInfo;$3)
C_TEXT:C284($timeInfo;$4)
C_TEXT:C284($timeInfoBefore;$5)
C_TEXT:C284($timeInfoAfter;$6)
C_COLLECTION:C1488($colToAttr;$7)

C_LONGINT:C283($i)
C_TEXT:C284($srcTxt)


If (Count parameters:C259>0)
	$col:=$1.copy()
	
Else   // ok, than use any test data
	$col:=New collection:C1472
	If (True:C214)  // test with collectionOfObjects(multicolumn keynamed)
		$col:=yNewRandomCollection(100)
	Else   // or test with oneColumn(without keyname) plain collection
		// debug to step in here
		For ($i;1;1000)
			$col.push($i)
		End for 
	End if 
End if 

If (Count parameters:C259>1)
	$docType:=$2
End if 

If (Count parameters:C259>2)
	$nameInfo:=$3
Else   // ok, than use any test name
	$nameInfo:="myCollectionA"
End if 

If (Count parameters:C259>3)  // $4 or automatic standard timeInfo
	$timeInfo:=$4
End if 

If (Count parameters:C259>4)
	$timeInfoBefore:=$5
End if 

If (Count parameters:C259>5)
	$timeInfoAfter:=$6
End if 

Case of 
	: (Count parameters:C259>6)
		$colToAttr:=$7
	: (Form:C1466.colKeys=Null:C1517)
		$colToAttr:=yColToAttrCreate($col)
	: (Value type:C1509(Form:C1466.colKeys)#Is collection:K8:32)
		$colToAttr:=yColToAttrCreate($col)
	Else 
		$colToAttr:=Form:C1466.colKeys
End case 

$docType:=collectionToGetDocType($docType)

$timeInfo:=yGetTimeline($timeInfo;$timeInfoBefore;$timeInfoAfter)

Case of 
	: ($docType=".html")
		$srcTxt:=collectionToHtml($col;$nameInfo;$timeInfo;$colToAttr;True:C214)
		
	: ($docType=".csv")
		$srcTxt:=collectionToCsv($col;$nameInfo;$timeInfo;$colToAttr;True:C214)
		
	: ($docType=".md")
		$srcTxt:=collectionToMd($col;$nameInfo;$timeInfo;$colToAttr;True:C214)
		
	: ($docType=".txt")
		$srcTxt:=collectionToTxt($col;$nameInfo;$timeInfo;$colToAttr;True:C214)
		
	: ($docType=".tsv")
		$srcTxt:=collectionToTsv($col;$nameInfo;$timeInfo;$colToAttr;True:C214)
		
	: ($docType=".xml")
		$srcTxt:=collectionToXml($col;$nameInfo;$timeInfo;$colToAttr;True:C214)
		
	: ($docType=".json")
		$srcTxt:=collectionToJson($col;$nameInfo;$timeInfo;$colToAttr;True:C214)
		
	Else   // not supported type
		$srcTxt:="###errror: not supported type!###"
		ALERT:C41("Sorry, type "+$docType+" is not supported!")
		
End case 

Case of 
	: ($srcTxt="###errror: not supported type!###")
	: ($srcTxt="")
		ALERT:C41("Sorry, results empty and it makes no sense to create a empty document!")
		
	Else 
		yCreateOpenTxtDoc($srcTxt;$nameInfo;$docType)
		
End case 

// - EOF -