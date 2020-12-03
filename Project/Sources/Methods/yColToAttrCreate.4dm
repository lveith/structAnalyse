//%attributes = {}
  // PM: "yColToAttrCreate" (new LV 18.05.20, 21:36:06)
  // $0 - C_COLLECTION - colResult
  // $1 - C_COLLECTION - colBase
  // Creates a additional attributes collection with default values
  // to use it with collectionTo() html/csv/md/txt.
  // ----- Example-1 -----
  // $colToAttr:=yColToAttrCreate ($collToDumpOutAsHtmlTable)
  // For each ($item;$colToAttr)
  //   Case of 
  //     : ($item.key="column1")
  //       $item.title:="No."// change the column-title in output (default key=title)
  //       $item.active:=True // this column is for output (default true)
  //       $item.sort:=14 // changes order in which columns should be arranged in output (default physically order)
  //     : ($item.key="column2")
  //       $item.active:=False  // do not output this key as column
  //   End case 
  // End for each 
  // collectionToHtml ($collToDumpOutAsHtmlTable;"myListOfAnything";"";$colToAttr)
  // ----- colBase -----
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
  // ----- colResult -----
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
  // Last change: LV 19.05.20, 09:15:07

C_COLLECTION:C1488($colResult;$0)
C_COLLECTION:C1488($colBase;$1)
C_COLLECTION:C1488($colKeys)
C_TEXT:C284($colKeysItem)

$colResult:=New collection:C1472

If (Count parameters:C259>0)
	$colBase:=$1
	
	If ($colBase.length>0)
		If (Value type:C1509($colBase[0])=Is object:K8:27)
			$colKeys:=OB Keys:C1719($colBase[0])
			For each ($colKeysItem;$colKeys)
				  // $colResult.push(New object("active";True;"key";$colKeysItem;"sort";($colResult.length+1)*10;"title";OBJECT Get title(*;"oColumnHead"+$colKeysItem[[Length($colKeysItem)]])))
				$colResult.push(New object:C1471("active";True:C214;"key";$colKeysItem;"sort";($colResult.length+1)*10;"title";$colKeysItem))
			End for each 
		End if 
	End if 
	
End if 

$0:=$colResult

  // - EOF -
