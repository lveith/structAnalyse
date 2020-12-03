//%attributes = {"invisible":true}
  // PM: "a0_justPersonalNoteOrCodingTest" (new LV 19.05.20, 08:20:50)
  // This method is only used as a sticky note, it has no functional meaning
  // Last change: LV 19.05.20, 09:03:12

  // ---- START: Use case example of "collectionTo" ----
C_COLLECTION:C1488($myCollectionToDumpOut)
C_TEXT:C284($docType)
C_TEXT:C284($myListName)
C_TEXT:C284($myTimelineMiddle)
C_TEXT:C284($myTimelineBefore)
C_TEXT:C284($myTimelineAfter)

  // Any collection what you want to dump out with collectionTo
  // ...creating here any test-data for testing collectionTo...
$myCollectionToDumpOut:=New collection:C1472
$myCollectionToDumpOut.push(New object:C1471("a";"a1";"b";"b1";"c";"c1"))
$myCollectionToDumpOut.push(New object:C1471("a";"a2";"b";"b2";"c";"c2"))
$myCollectionToDumpOut.push(New object:C1471("a";"a3";"b";"b3";"c";"c3"))

$docType:=".html"
$myListName:="Place here any name for the list"
$myTimelineMiddle:=""  // if not filled, than created automatically
$myTimelineBefore:=""  // optional
$myTimelineAfter:=""  // optional

C_COLLECTION:C1488($colToAttr)
C_OBJECT:C1216($itemColumn)

  // create a new default colKeysAttr
$colToAttr:=yColToAttrCreate ($myCollectionToDumpOut)

If (True:C214)  // only a example for change default attributes like title, sort (or hide column with active=False)
	For each ($itemColumn;$colToAttr)
		Case of 
			: ($itemColumn.key="a")
				$itemColumn.title:="# A #"  // change default title to individual title
			: ($itemColumn.key="b")
				$itemColumn.title:="# B #"  // change default title to individual title
		End case 
	End for each 
Else 
	  // use default attributes like title, sort (or hide column with active=False)
	  // when its wished to dump out all existing keys from your collection
	  // in phySortOrder and with title=keyname
	  // ...than take standard you get by $colToAttr:=yColToAttrCreate($myCollectionToDumpOut)
	  // ...nothing more to do when no different customs needed
End if 

Case of 
	: (True:C214)  // $docType (like before is set to ".html"
		collectionTo ($myCollectionToDumpOut;$docType;$myListName;$myTimelineMiddle;$myTimelineBefore;$myTimelineAfter;$colToAttr)
		
	: (True:C214)  // alternativ ".csv"
		collectionTo ($myCollectionToDumpOut;".csv";$myListName;$myTimelineMiddle;$myTimelineBefore;$myTimelineAfter;$colToAttr)
		
	: (True:C214)  // alternativ ".md"
		collectionTo ($myCollectionToDumpOut;".md";$myListName;$myTimelineMiddle;$myTimelineBefore;$myTimelineAfter;$colToAttr)
		
	: (True:C214)  // alternativ ".txt"
		collectionTo ($myCollectionToDumpOut;".txt";$myListName;$myTimelineMiddle;$myTimelineBefore;$myTimelineAfter;$colToAttr)
		
	: (True:C214)  // alternativ ".tsv"
		collectionTo ($myCollectionToDumpOut;".tsv";$myListName;$myTimelineMiddle;$myTimelineBefore;$myTimelineAfter;$colToAttr)
		
End case 
  // ---- END: Use case example of "collectionTo" ----

  // - EOF -