//%attributes = {}
  // PM: "_sisStartSearchMain" (new LV 22.07.20, 10:14:24)
  // Last change: LV 22.07.20, 10:14:24

C_TEXT:C284($filterString;$1)
C_BOOLEAN:C305($ignoreComments;$2)
C_BOOLEAN:C305($wholeContent;$3)
C_COLLECTION:C1488($kinds)

If (Count parameters:C259>0)
	$filterString:=$1
Else 
	$filterString:=Form:C1466.filterString
End if 

If (Count parameters:C259>1)
	$ignoreComments:=$2
Else 
	$ignoreComments:=Bool:C1537(Form:C1466.ignoreComment)
End if 

If (Count parameters:C259>2)
	$wholeContent:=$3
Else 
	$wholeContent:=Bool:C1537(Form:C1466.wholeContent)
End if 

Form:C1466.importAttributes:=New object:C1471
Form:C1466.searchResultsDisplay:=New collection:C1472
Form:C1466.searchResults:=Form:C1466.searchResultsDisplay
Form:C1466.message:=""
Form:C1466.progressBar:=0
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
Form:C1466.allCurrCount:=0

OBJECT SET VISIBLE:C603(*;"oBtnSearchStop";True:C214)
OBJECT SET VISIBLE:C603(*;"oPleaseWait";True:C214)
If ($filterString="")
	OBJECT SET VISIBLE:C603(*;"oSpinnerLoad";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"oSpinnerSearch";True:C214)
End if 

$kinds:=New collection:C1472
If (Form:C1466.useDatabasemethod>0)
	$kinds.push("db")
	Form:C1466.dbMaxCount:=1  // defaultValue=1, wait until received real max-count value
End if 
If (Form:C1466.useTriggermethod>0)
	$kinds.push("trig")
	Form:C1466.trigMaxCount:=1  // defaultValue=1, wait until received real max-count value
End if 
If (Form:C1466.useProjectform>0)
	$kinds.push("pf")
	Form:C1466.pfMaxCount:=1  // defaultValue=1, wait until received real max-count value
End if 
If (Form:C1466.useProjectmethod>0)
	$kinds.push("pm")
	Form:C1466.pmMaxCount:=1  // defaultValue=1, wait until received real max-count value
End if 
If (Form:C1466.useTableform>0)
	$kinds.push("tf")
	Form:C1466.tfMaxCount:=1  // defaultValue=1, wait until received real max-count value
End if 
If (Form:C1466.useClassmethod>0)
	$kinds.push("cs")
	Form:C1466.csMaxCount:=1  // defaultValue=1, wait until received real max-count value
End if 

Use (Form:C1466.run)
	Form:C1466.run.run:=True:C214
	Form:C1466.run.ignoreCmts:=$ignoreComments
	Form:C1466.run.wholeContent:=$wholeContent
End use 
CALL WORKER:C1389("sisWorkerSearchMain";"_doSearchMain";Current form window:C827;Form:C1466.run;$filterString;$kinds)

  // - EOF -
