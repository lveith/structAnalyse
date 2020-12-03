  // OM: LB_Test1.oBtnSearchStop

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Use (Form:C1466.run)
			Form:C1466.run.run:=False:C215
		End use 
		OBJECT SET VISIBLE:C603(*;"oBtnSearchStop";False:C215)
		OBJECT SET VISIBLE:C603(*;"oSpinner@";False:C215)
		OBJECT SET VISIBLE:C603(*;"oPleaseWait@";False:C215)
		
End case 

  // - EOF -