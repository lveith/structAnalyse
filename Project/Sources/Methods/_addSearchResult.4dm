//%attributes = {}
  // PM: "_addSearchResult" (new LV 13.07.20, 09:46:34)
  // $1 - C_LONGINT - currCount
  // $2 - C_TEXT - kind for currCount: | all | pf | tf | pm | cs | db | trig |
  // $3 - C_TEXT - methodPath
  // $4 - C_COLLECTION - colToAdd
  // $5 - C_OBJECT - objMethodPars
  // Add found items transmitted from worker process "_doSearch" by "CALL FORM"
  // Last change: LV 13.07.20, 09:46:34

C_LONGINT:C283($currCount;$1)
C_TEXT:C284($kind;$2)
C_TEXT:C284($methodPath;$3)
C_COLLECTION:C1488($colToAdd;$4)
C_OBJECT:C1216($objMethodPars;$5)

C_TEXT:C284($item)
C_OBJECT:C1216($obj)

If (Count parameters:C259>0)
	$currCount:=$1
	If (Count parameters:C259>1)
		$kind:=$2
	Else 
		$kind:="all"
	End if 
End if 

Case of 
	: ($kind="pf")
		Form:C1466.pfCurrCount:=$currCount
		
	: ($kind="tf")
		Form:C1466.tfCurrCount:=$currCount
		
	: ($kind="pm")
		Form:C1466.pmCurrCount:=$currCount
		
	: ($kind="cs")
		Form:C1466.csCurrCount:=$currCount
		
	: ($kind="db")
		Form:C1466.dbCurrCount:=$currCount
		
	: ($kind="trig")
		Form:C1466.trigCurrCount:=$currCount
		
	: ($kind="all")
		Form:C1466.pfMaxCount:=0
		Form:C1466.pfCurrCount:=0
		Form:C1466.tfMaxCount:=0
		Form:C1466.tfCurrCount:=0
		Form:C1466.pmMaxCount:=0
		Form:C1466.pmCurrCount:=0
		Form:C1466.csMaxCount:=0
		Form:C1466.csCurrCount:=0
		Form:C1466.dbMaxCount:=0
		Form:C1466.dbCurrCount:=0
		Form:C1466.trigMaxCount:=0
		Form:C1466.trigCurrCount:=0
		Form:C1466.allMaxCount:=0
		Form:C1466.allCurrCount:=$currCount
		
	: ($kind="pfMax")
		Form:C1466.pfMaxCount:=$currCount
		
	: ($kind="tfMax")
		Form:C1466.tfMaxCount:=$currCount
		
	: ($kind="pmMax")
		Form:C1466.pmMaxCount:=$currCount
		
	: ($kind="csMax")
		Form:C1466.csMaxCount:=$currCount
		
	: ($kind="dbMax")
		Form:C1466.dbMaxCount:=$currCount
		
	: ($kind="trigMax")
		Form:C1466.trigMaxCount:=$currCount
		
	: ($kind="allMax")
		Form:C1466.pfMaxCount:=0
		Form:C1466.pfCurrCount:=0
		Form:C1466.tfMaxCount:=0
		Form:C1466.tfCurrCount:=0
		Form:C1466.pmMaxCount:=0
		Form:C1466.pmCurrCount:=0
		Form:C1466.csMaxCount:=0
		Form:C1466.csCurrCount:=0
		Form:C1466.dbMaxCount:=0
		Form:C1466.dbCurrCount:=0
		Form:C1466.trigMaxCount:=0
		Form:C1466.trigCurrCount:=0
		Form:C1466.allMaxCount:=$currCount
		
End case 

$CountDone:=Form:C1466.pfCurrCount+Form:C1466.tfCurrCount+Form:C1466.pmCurrCount+Form:C1466.csCurrCount+Form:C1466.dbCurrCount+Form:C1466.trigCurrCount+Form:C1466.allCurrCount
$CountToDo:=Form:C1466.pfMaxCount+Form:C1466.tfMaxCount+Form:C1466.pmMaxCount+Form:C1466.csMaxCount+Form:C1466.dbMaxCount+Form:C1466.trigMaxCount+Form:C1466.allMaxCount
Form:C1466.progressBar:=Int:C8(($CountDone/$CountToDo)*100)

If (($CountDone>=$CountToDo) | ($kind="errorRegex"))
	OBJECT SET RGB COLORS:C628(*;"oSearchMessage";"#929000")
	OBJECT SET VISIBLE:C603(*;"oBtnSearchStop";False:C215)
	OBJECT SET VISIBLE:C603(*;"oSpinner@";False:C215)
	OBJECT SET VISIBLE:C603(*;"oPleaseWait@";False:C215)
	Use (Form:C1466.run)
		Form:C1466.run.run:=False:C215
	End use 
Else 
	OBJECT SET RGB COLORS:C628(*;"oSearchMessage";"#FF40FF")
End if 

If ($kind="errorRegex")
	Form:C1466.message:="ERROR, wrong regex"
	OBJECT SET RGB COLORS:C628(*;"oSearchMessage";"#FF0000")
	BEEP:C151
Else 
	Form:C1466.message:=String:C10($CountDone)+" / "+String:C10($CountToDo)
End if 

If (Count parameters:C259>4)
	$methodPath:=$3
	$colToAdd:=$4
	$objMethodPars:=$5
	
	Case of 
		: ($colToAdd=Null:C1517)
		: (Value type:C1509($colToAdd)#Is collection:K8:32)
		: (Value type:C1509($colToAdd.length)#Is longint:K8:6)
		: ($colToAdd.length<1)
		: (Value type:C1509($colToAdd[0])#Is text:K8:3)
		Else 
			
			For each ($item;$colToAdd)
				$obj:=New object:C1471
				$obj.name:=$methodPath
				  // $obj.found:=$item
				If (Length:C16($item)>2020)
					$obj.found:=$item
				Else 
					$obj.found:=zReplaceRegexG ($item;"(?m)^\\s+")  // remove indents, all white space at beginning of a line (included empty lines removed too)
				End if 
				$obj.modification:=Replace string:C233($objMethodPars.modification;"T";"_")
				
				Case of 
					: ($methodPath="[databaseMethod]/@")
						$obj.type:="method (database)"
						$obj.kind:="method"
					: ($methodPath="[trigger]/@")
						$obj.type:="method (trigger)"
						$obj.kind:="method"
					: ($methodPath="[projectForm]/@/{formMethod}")
						$obj.type:="method (form)"
						$obj.kind:="method"
					: ($methodPath="[tableForm]/@/@/{formMethod}")
						$obj.type:="method (form)"
						$obj.kind:="method"
					: ($methodPath="[projectForm]/@/@")
						$obj.type:="method (formobject)"
						$obj.kind:="method"
					: ($methodPath="[tableForm]/@/@/@")
						$obj.type:="method (formobject)"
						$obj.kind:="method"
					: ($methodPath="[class]/@")
						$obj.type:="method (class)"
						$obj.kind:="method"
					: (($methodPath#"@[@") & ($methodPath#"@]@") & ($methodPath#"@{@") & ($methodPath#"@}@") & ($methodPath#"@(@") & ($methodPath#"@)@") & ($methodPath#"@/@"))
						$obj.type:="method (project)"
						$obj.kind:="method"
					: ($methodPath="form (project)")
						$obj.type:="method (formobject)"
					: ($methodPath="form (table)")
						$obj.type:="form (table)"
					: ($methodPath="table")
						$obj.type:="table"
						$obj.kind:="table"
					: ($methodPath="field (@)")
						$obj.type:="field (@)"
						$obj.kind:="field"
					: ($methodPath="command")
						$obj.type:="command"
					: ($methodPath="constant")
						$obj.type:="constant"
					Else 
						$obj.type:=""
				End case 
				
				If (Match regex:C1019(".*\\S.*";$obj.found))
					$obj.empty:=False:C215
				Else 
					$obj.empty:=True:C214
				End if 
				
				Form:C1466.searchResultsDisplay.push($obj)
				
			End for each 
			
	End case 
	
End if 

  // - EOF -