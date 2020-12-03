// OM: "_searchStruct".oOpenToEdit (new LV 13.07.20, 13:11:49)
// Last change: LV 13.07.20, 13:11:49

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Form:C1466.soCurrEl=Null:C1517)
				BEEP:C151
			: (OB Is empty:C1297(Form:C1466.soCurrEl))
				BEEP:C151
			: (Not:C34(OB Is defined:C1231(Form:C1466.soCurrEl)))
				BEEP:C151
			: (Form:C1466.soCurrEl.type=Null:C1517)
				BEEP:C151
			: (Form:C1466.soCurrEl.type#"method (@")
				BEEP:C151
			: (Form:C1466.soCurrEl.name=Null:C1517)
				BEEP:C151
			: (Length:C16(Form:C1466.soCurrEl.name)>0)
				METHOD OPEN PATH:C1213(Form:C1466.soCurrEl.name;*)
				
		End case 
		
End case 

// - EOF -