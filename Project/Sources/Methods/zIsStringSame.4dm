//%attributes = {}
  // ----------------------------------------------------
  // Anwender (OS): Lutz
  // Datum und Zeit: 30.09.08, 17:14:50
  // ----------------------------------------------------
  // Methode: zIsStringSame
  // Beschreibung
  // Vergleich ob zwei texte identisch sind  (...geht mit Position 100mal schneller als wie Zeichen für Zeichen im ForLoop...)
  // PositionStern, d.h. CaseSensitive und so genau wie eben PositionMitSternIst +TestLengthIdentical
  // Parameter:   zIsStringSame ( text1; text2) ->TRUE wenn Text1+2 identisch !
  // ----------------------------------------------------

C_TEXT:C284($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($StringSameString;$0)

$StringSameString:=False:C215

If (Count parameters:C259>1)
	If (Length:C16($1)=Length:C16($2))
		If (Length:C16($1)>0)
			If (Position:C15($1;$2;*)=1)
				$StringSameString:=True:C214  //string1+2 sind beide gleichen Inhalts (#<>sLeer)
			End if 
		Else 
			$StringSameString:=True:C214  //string1+2 sind beide gleichen Inhalts (=<>sLeer)
		End if 
	End if 
End if 

$0:=$StringSameString

  // - EOF -
