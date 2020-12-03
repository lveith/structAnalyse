//%attributes = {}
  // PM: "yColExtract" (new LV 20.05.20, 23:53:52)
  // $0 - C_COLLECTION - colResult (extracted)
  // $1 - C_COLLECTION - srcCol
  // $2 - C_COLLECTION - colOrgKeys
  // $3 - C_COLLECTION - colRenamedKeys
  // ExtractedCollection:=yColExtract(srcCol;colOrgKeys;colRenamedKeys)
  // Works like a missing feature as this: col.extract(colOrgKeys;colRenamedKeys)
  // Too a missing feature as this with one text-parameter: col.extract(String("\"b\";\"B\"";"\"a\";\"A\""))
  // Last change: LV 20.05.20, 23:53:52

C_COLLECTION:C1488($colResult;$0)
C_COLLECTION:C1488($srcCol;$1)
C_COLLECTION:C1488($colOrgKeys;$2)
C_COLLECTION:C1488($colRenamedKeys;$3)
C_TEXT:C284($formulaStr)
C_LONGINT:C283($i)
C_OBJECT:C1216($objTmp;$formula)

If (Count parameters:C259<3)
	$colResult:=New collection:C1472
	
Else 
	$srcCol:=$1
	$colOrgKeys:=$2
	$colRenamedKeys:=$3
	
	If ($srcCol.length<1)
		$colResult:=New collection:C1472
		
	Else 
		Case of 
			: ($colOrgKeys.length<$colRenamedKeys.length)
				$colRenamedKeys.resize($colOrgKeys.length)
				
			: ($colOrgKeys.length>$colRenamedKeys.length)
				$colOrgKeys.resize($colRenamedKeys.length)
				
		End case 
		
		$formulaStr:="\""
		
		For ($i;0;($colOrgKeys.length-1))
			If ($i<($colOrgKeys.length-1))
				$formulaStr:=$formulaStr+$colOrgKeys[$i]+"\";\""+$colRenamedKeys[$i]+"\";\""
			Else 
				$formulaStr:=$formulaStr+$colOrgKeys[$i]+"\";\""+$colRenamedKeys[$i]
			End if 
		End for 
		
		$formulaStr:=$formulaStr+"\""
		
		$objTmp:=New object:C1471("col";$srcCol)
		$formula:=Formula from string:C1601("This.col.extract("+$formulaStr+")")
		
		$colResult:=$formula.call($objTmp)
		
	End if 
	
End if 

$0:=$colResult

  // - EOF -
