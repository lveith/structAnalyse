//%attributes = {}
  // PM: "colFiMatchRegex" (neu LV 21.05.20, 10:01:48)
  // $1 - C_OBJECT - je ein Element der Collection, wird von Automatik col.filter() geliefert:
  //               - $1.value: Elementwert
  //               - $1.stop: Breaks/Stops Loop (boolean, optional)
  //               - $1.result: Ergebnis (boolean): True=ElementMatchesRegExpr | False=ElementNotMatchesRegExpr(somit nicht in resultCollection)
  // $2 - C_TEXT - indivPar, wird in dieser Methdoe als objPropName erwartet
  // $3 - C_TEXT - indivPar, wird in dieser Methode der regExprString erwartet nachdem objProp gefiltert werden soll
  // Filtert colZeilen mit RegExprMuster auf Übereinstimmung im gewünschten objPropValue(colZelle/colSpalte)
  // Vor Aufruf der Methode muss OK und Error auf 0 gesetzt werden und onErrCall= ON ERR CALL("yErrCallNum")
  // Z.B.: collection.filter("colFiMatchRegex";objItemNameToFilter;regExprFilter) -> newFilteredCol
  // Z.B.: New collection(New object("id";"1:";"name";"A")).filter("colFiMatchRegex";objItemNameToFilter;regExprFilter) -> newFilteredCol
  // Z.B.: $newFilteredCol:=$orgCol.filter("colFiMatchRegex";$objItemNameToFilter;$regExprFilter)
  // Diese Methode wird meistens mit "Methodenname" als String aufgerufen,
  // somit ist ggf. keine direkte PM-Reference als Aufruf zu sehen
  // (die Suche nach Text/TextInAnführungszeichen zeigt ggf. mehr Verwendungsorte)
  // (die Methode kann aber auch volldynamisch aufgerufen werden ohne das man MethodenNameString im Code sieht)
  // Hinweis: Diese Funktion ändert nicht die ursprüngliche Collection!
  // Diese Methode ist absolut "Neutral" nur im Einsatz als col.function("methodName";objItemNameToFilter;regExprFilter)
  // Vorsicht, würde man diese Methode direkt als PM aufrufen z.B.: colFiMatchRegex(obj;objItemNameToFilter;regExprFilter)
  // ...dann würde sie aktiv das $1-Object im Original Ändern, weil $1.value/$1.stop/$1.result Schreibweise ein objEintrag erzeugt und/oder ändert.
  // Somit ist diese Methode ausschliesslich nur für den Einsatz als col.function() zu verwenden (wo sie absolutNeutral ist und das PM-NamensPräfix "z" zurrecht verdient)!
  // Es folgt ein vollständiges mustergültiges Anwendungs-Beispiel:
  // ---
  //    C_COLLECTION($orgCol;$newFilteredCol)
  //    C_TEXT($currErrMethode)
  //    $orgCol:=New collection()
  //    $orgCol.push(New object("id";"1a";"name";"A"))
  //    $orgCol.push(New object("id";"2b";"name";"B"))
  //    $orgCol.push(New object("id";"c3";"name";"C"))
  //    OK:=0
  //    Error:=0
  //    $currErrMethode:=Method called on error  // store onErrCall
  //    ON ERR CALL("yErrCallNum")  // set own special onErrCall
  //      // Example 'beginWith' a Digit (RegExpr must fully equal occur with whole value)
  //    $newFilteredCol:=$orgCol.filter("colFiMatchRegex";"id";"\\d+[\\d\\D]*")  // -> [{id:1a,name:A},{id:2b,name:B}] 
  //      // Example 'endsWith' a Digit (RegExpr must fully equal occur with whole value)
  //    $newFilteredCol:=$orgCol.filter("colFiMatchRegex";"id";"[\\d\\D]*\\d+")  // -> [{id:c3,name:C}] 
  //      // Example 'contains' a Digit (RegExpr must fully equal occur with whole value)
  //    $newFilteredCol:=$orgCol.filter("colFiMatchRegex";"id";"[\\d\\D]*\\d+[\\d\\D]*")  // -> [{id:1a,name:A},{id:2b,name:B},{id:c3,name:C}] 
  //    ON ERR CALL($currErrMethode)  // restore onErrCall
  // ---
  // 4DDoku: https://doc.4d.com/4Dv17R5/4D/17-R5/collectionfilter.305-4128638.de.html
  //  collection.filter(MethodenName{; param}{; param2 ; ... ; paramN}) -> resultCollection
  //  MethodenName empfängt folgende Parameter:
  //  - in $1.value: Elementwert zum Filtern
  //  - in $2: param
  //  - in $N...: param2...paramN
  //  MethodenName setzt folgende Parameter:
  //  - $1.result (boolean): wahr, wenn der Elementwert zur Filterbedingung passt und behalten werden soll.
  //  - $1.stop (boolean, optional): wahr, um Aufruf der Methode zu stoppen. Der zurückgegebene Wert ist der letzte bewertete Wert.
  // Letzte Änderung: LV 21.05.20, 10:01:33

C_OBJECT:C1216($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

If (Error#0)  // Error muss vor Ausführung auf 0 gesetzt werden (hier wird es nachgeholt, falls es vor MethodenAufruf vergessen wurde!)
	Error:=0
End if 

If (OK#0)  // OK muss vor Ausführung auf 0 gesetzt werden (hier wird es nachgeholt, falls es vor MethodenAufruf vergessen wurde!)
	OK:=0
End if 

If (Value type:C1509($1.value)=Is object:K8:27)
	If (Value type:C1509(OB Get:C1224($1.value;$2))=Is text:K8:3)
		$1.result:=Match regex:C1019($3;OB Get:C1224($1.value;$2))
	End if 
End if 

If ((Error#0) | (OK#0) | (Shift down:C543))
	  // Den Filter-Loop über alle collection-items hier Abbrechen weil er zu lange dauert oder Fehler wirft!
	  // U.a. ShiftDown ist hier nur einfacher Notausschalter um versehentliche endlos Läufe abzubrechen
	  // Wird diese Methode falsch angesteuert kann es zu Problemen kommen die man hier abfangen kann
	  // Wichtig auch ist das die regExpr nach 4D/ICU regelgerecht ist und auch sonst die regExpr günstig formuliert ist und kein scheinbar endlosLoop beinhaltet.
	  // See docu "Using ICU Regular Expressions": http://userguide.icu-project.org/strings/regexp   (look to part "Performance Tips")
	$1.stop:=True:C214
	ALERT:C41("Error in regExpression, filtering stops now")
End if 

  // - EOF -