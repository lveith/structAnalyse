//%attributes = {}
  // PM: yNewRandomCollection

C_COLLECTION:C1488($colResult;$0)  // [{"column1", 1, "column2", 98}, {"column1", 2, "column2", 73}]
C_LONGINT:C283($length;$1)  // $colResult.length
C_COLLECTION:C1488($keys;$2)  // New collection("column1";"column2")
C_TEXT:C284($counterKey;$3)  // "column1"
C_TEXT:C284($keysItem)
C_OBJECT:C1216($objNew)
C_BOOLEAN:C305($useCounterKey)

$useCounterKey:=False:C215

If (Count parameters:C259>0)
	$length:=$1
	If (Count parameters:C259>1)
		$keys:=$2
		If (Count parameters:C259>2)
			$counterKey:=$3
			$useCounterKey:=True:C214
		End if 
	Else 
		$keys:=New collection:C1472("column1";"column2";"column3";"column4";"column5")
		$counterKey:="column1"
		$useCounterKey:=True:C214
	End if 
Else 
	$length:=1000  // Default for $colResult.length
	$keys:=New collection:C1472("column1";"column2";"column3";"column4";"column5")
	$counterKey:="column1"
	$useCounterKey:=True:C214
End if 

$colResult:=New collection:C1472

For ($i;1;$length)
	$objNew:=New object:C1471
	For each ($keysItem;$keys)
		Case of 
			: ($useCounterKey=False:C215)
				$objNew[$keysItem]:=String:C10(Random:C100)
				
			: ($counterKey=$keysItem)
				$objNew[$keysItem]:=$colResult.length+1
				
			Else 
				$objNew[$keysItem]:=String:C10(Random:C100)
				
		End case 
	End for each 
	$colResult.push($objNew)
End for 

$0:=$colResult

  // - EOF -