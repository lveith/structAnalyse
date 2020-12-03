//%attributes = {}
  // PM: "_sisToggleSearch" (new LV 13.07.20, 15:53:13)
  // Last change: LV 13.07.20, 15:53:13

If (Form:C1466.toggleSearch=Null:C1517)
	OBJECT SET VISIBLE:C603(*;"oFilterString";False:C215)
	OBJECT SET VISIBLE:C603(*;"oChooseFilterItem";False:C215)
	OBJECT SET VISIBLE:C603(*;"oChooseFilterType";False:C215)
	OBJECT SET VISIBLE:C603(*;"oBtnEscapeAll";False:C215)
	OBJECT SET VISIBLE:C603(*;"oUseWholeContent";False:C215)
	OBJECT SET VISIBLE:C603(*;"oUseIgnoreComment";False:C215)
	
	OBJECT SET VISIBLE:C603(*;"oTxtQuery";True:C214)
Else 
	If (Form:C1466.toggleSearch>0)
		OBJECT SET VISIBLE:C603(*;"oFilterString";True:C214)
		OBJECT SET VISIBLE:C603(*;"oChooseFilterItem";True:C214)
		OBJECT SET VISIBLE:C603(*;"oChooseFilterType";True:C214)
		OBJECT SET VISIBLE:C603(*;"oBtnEscapeAll";True:C214)
		OBJECT SET VISIBLE:C603(*;"oUseWholeContent";True:C214)
		OBJECT SET VISIBLE:C603(*;"oUseIgnoreComment";True:C214)
		OBJECT SET VISIBLE:C603(*;"oTxtQuery";False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*;"oFilterString";False:C215)
		OBJECT SET VISIBLE:C603(*;"oChooseFilterItem";False:C215)
		OBJECT SET VISIBLE:C603(*;"oChooseFilterType";False:C215)
		OBJECT SET VISIBLE:C603(*;"oBtnEscapeAll";False:C215)
		OBJECT SET VISIBLE:C603(*;"oUseWholeContent";False:C215)
		OBJECT SET VISIBLE:C603(*;"oUseIgnoreComment";False:C215)
		OBJECT SET VISIBLE:C603(*;"oTxtQuery";True:C214)
	End if 
End if 

  // - EOF -