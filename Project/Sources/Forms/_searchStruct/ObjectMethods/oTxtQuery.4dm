  // Method: LB_Test1.oTxtQuery

C_LONGINT:C283($vlDstElem;$vlSrcElem;$vlPID)
C_POINTER:C301($vpSrcObj)
C_TEXT:C284($tmpTxt)

Case of 
	: (Form event code:C388=On Drop:K2:12)
		  // Get the information about the drag and drop source object
		_O_DRAG AND DROP PROPERTIES:C607($vpSrcObj;$vlSrcElem;$vlPID)
		  // Get the destination element number
		$vlDstElem:=Drop position:C608
		
		Case of 
			: (OBJECT Get pointer:C1124(Object named:K67:5;"oListboxStructObjects")=$vpSrcObj)
				If (Form:C1466.txtQuery=Null:C1517)
					Form:C1466.txtQuery:=""
				End if 
				Case of 
					: (Form:C1466.soCurrEl=Null:C1517)
					: (OB Is empty:C1297(Form:C1466.soCurrEl))
					: (Not:C34(OB Is defined:C1231(Form:C1466.soCurrEl)))
					: (Form:C1466.soCurrEl.name=Null:C1517)
					: (Form:C1466.soCurrEl.type=Null:C1517)
					: (Form:C1466.soCurrEl.id=Null:C1517)
					: (Form:C1466.soCurrEl.type="command")
						$tmpTxt:="content = '@"+Form:C1466.soCurrEl.name+":"+Form:C1466.soCurrEl.id+"@'"
						Form:C1466.txtQuery:=Insert string:C231(Form:C1466.txtQuery;$tmpTxt;$vlDstElem+1)
						
					: (Form:C1466.soCurrEl.type="constant")
						$tmpTxt:="content = '@"+Form:C1466.soCurrEl.name+":"+Form:C1466.soCurrEl.id+"@'"
						Form:C1466.txtQuery:=Insert string:C231(Form:C1466.txtQuery;$tmpTxt;$vlDstElem+1)
						
					: (Form:C1466.soCurrEl.type="table")
						$tmpTxt:="content = '@"+Form:C1466.soCurrEl.name+":"+Form:C1466.soCurrEl.id+"@'"
						Form:C1466.txtQuery:=Insert string:C231(Form:C1466.txtQuery;$tmpTxt;$vlDstElem+1)
						
					: (Form:C1466.soCurrEl.type="field (@")
						$tmpTxt:="content = '@"+Form:C1466.soCurrEl.content+"@'"
						Form:C1466.txtQuery:=Insert string:C231(Form:C1466.txtQuery;$tmpTxt;$vlDstElem+1)
						
				End case 
		End case 
		
	: (OBJECT Get pointer:C1124(Object named:K67:5;"oTxtContent")=$vpSrcObj)
		  // $0:=True
		
	: (OBJECT Get pointer:C1124(Object named:K67:5;"oAttributes")=$vpSrcObj)
		  // $0:=True
		
End case 
