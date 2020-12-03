//%attributes = {}
  // PM: "collectionToGetDocType" (new LV 20.05.20, 22:20:43)
  // $0 - C_TEXT - docType qualified for "collectionTo" |".html"|".csv"|".md"|".txt"|".tsv"|".xml"|".json"|
  // $1 - C_TEXT - docType
  // Get a document type qualified for "collectionTo"
  // Last change: LV 20.05.20, 22:20:43

C_TEXT:C284($0)
C_TEXT:C284($docType;$1)

If (Count parameters:C259>0)
	$docType:=$1
End if 

Case of 
	: ($docType=".html")  // ok
	: ($docType=".csv")  // ok
	: ($docType=".md")  // ok
	: ($docType=".txt")  // ok
	: ($docType=".tsv")  // ok
	: ($docType=".xml")  // ok
	: ($docType=".json")  // ok
		
	: ($docType="html")  // adjust
		$docType:=".html"
		
	: ($docType="csv")  // adjust
		$docType:=".csv"
		
	: ($docType="md")  // adjust
		$docType:=".md"
		
	: ($docType="txt")  // adjust
		$docType:=".txt"
		
	: ($docType="tsv")  // adjust
		$docType:=".tsv"
		
	: ($docType="xml")  // adjust
		$docType:=".xml"
		
	: ($docType="json")  // adjust
		$docType:=".json"
		
	Else 
		$docType:=".html"  // adjust by default
		
End case 

$0:=$docType

  // - EOF -