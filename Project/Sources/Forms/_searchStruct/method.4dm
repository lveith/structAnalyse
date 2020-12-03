  // FM: "_searchStruct" (new LV 13.07.20, 15:54:44)
  // Last change: LV 13.07.20, 15:54:44

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		Form:C1466.searchResultsDisplay:=New collection:C1472
		
		Form:C1466.useCommand:=0
		Form:C1466.useConstant:=0
		Form:C1466.useTable:=0
		Form:C1466.useField:=0
		Form:C1466.useProjectform:=1
		Form:C1466.useTableform:=1
		Form:C1466.useProjectmethod:=1
		Form:C1466.useClassmethod:=0
		Form:C1466.useDatabasemethod:=1
		Form:C1466.useTriggermethod:=1
		
		Form:C1466.txtQuery:=""
		
		Form:C1466.progressBar:=0
		Form:C1466.message:=""
		
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
		
		Form:C1466.importAttributes:=New object:C1471
		
		Form:C1466.wholeContent:=False:C215
		Form:C1466.ignoreComment:=False:C215
		
		  // toggleSearch: "regexSearch" | "colQueryString"
		  // startDefault = "regexSearch" = 1
		  // alternativ   = "colQueryString" = 0
		Form:C1466.toggleSearch:=1
		_sisToggleSearch 
		
		Form:C1466.filterString:="(?im)^.*search.*$"  // default regex pattern
		
		  // options for regex pattern interpretation
		  // 1 = contains the regexPattern
		  // 2 = equal with regexPattern
		  // 3 = beginWith with regexPattern
		  // 4 = endWith with regexPattern
		C_POINTER:C301($ptrChooseFilterType)
		$ptrChooseFilterType:=OBJECT Get pointer:C1124(Object named:K67:5;"oChooseFilterType")
		$ptrChooseFilterType->:=2  // set default: 2 = equal with regexPattern
		
		  // CodeMirror
		WA SET PREFERENCE:C1041(*;"oWebArea";WA enable Web inspector:K62:7;True:C214)
		WA OPEN URL:C1020(*;"oWebArea";Get 4D folder:C485(Current resources folder:K5:16)+"HTML_Docs"+Folder separator:K24:12+"cm"+Folder separator:K24:12+"codemirror-5.54.0"+Folder separator:K24:12+"mp"+Folder separator:K24:12+"readOnly4Dmain.html")
		
		  // Not for use in compiled mode
		If (Is compiled mode:C492)
			OBJECT SET VISIBLE:C603(*;"oBtnChooseFormPage";False:C215)
			OBJECT SET VISIBLE:C603(*;"oTrace";False:C215)
		End if 
		
		Form:C1466.run:=New shared object:C1526
		Use (Form:C1466.run)
			Form:C1466.run.run:=False:C215
		End use 
		
		  // load as default, all methods with whole content of each method as one found item
		_sisStartSearchMain ("")
		OBJECT SET VISIBLE:C603(*;"oPleaseWait@";True:C214)
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (Process aborted:C672)
			sisKillAllWorkers 
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Unload:K2:2)
		sisKillAllWorkers 
		
End case 

  // - EOF -