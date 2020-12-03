//%attributes = {}
  // PM: "yCreateOpenTxtDoc" (new LV 20.05.20, 21:50:16)
  // $0 - C_BOOLEAN - Result successfully executed
  // $1 - C_TEXT - SrcTxt for document to create and open
  // $2 - C_TEXT - FileName
  // $2 - C_TEXT - DocType | ".html" | ".csv" | ".md" | ".txt" | ".tsv" | ".xml" | ".json" | 
  // Create and open a text document
  // Last change: LV 20.05.20, 21:50:16

C_BOOLEAN:C305($result;$0)
C_TEXT:C284($srcTxt;$1)
C_TEXT:C284($fileName;$2)
C_TEXT:C284($docType;$3)

C_TEXT:C284($prevErrorMethod)
C_LONGINT:C283($prevOK)

$result:=False:C215  // init

If (Count parameters:C259>0)
	$srcTxt:=$1
	If (Count parameters:C259>1)
		$fileName:=$2
		If (Count parameters:C259>2)
			$docType:=$3
		End if 
	End if 
End if 

$docType:=collectionToGetDocType ($docType)

$prevErrorMethod:=Method called on error:C704
$prevOK:=OK

OK:=0  // init
ON ERR CALL:C155("onErrDocument")

$docRef:=Create document:C266($fileName+$docType)  // set OK=1 when created successfully
If (OK=1)  // If document has been created successfully
	CLOSE DOCUMENT:C267($docRef)
	If (OK=1)  // just if method "onErrDocument" not set OK=0
		TEXT TO DOCUMENT:C1237(Document;$srcTxt)
		If (OK=1)  // just if method "onErrDocument" not set OK=0
			OPEN URL:C673(Document)
			If (OK=1)  // just if method "onErrDocument" not set OK=0
				$result:=True:C214
			Else 
				ALERT:C41("Error: Any problem by Open document!")
			End if 
		Else 
			ALERT:C41("Error: Any problem by Write document!")
		End if 
	Else 
		ALERT:C41("Error: Any problem by Create/Close document!")
	End if 
Else 
	ALERT:C41("Error: Any problem by Create document!")
End if 

ON ERR CALL:C155($prevErrorMethod)  // set back to previous value
OK:=$prevOK  // set back to previous value

$0:=$result

  // - EOF -