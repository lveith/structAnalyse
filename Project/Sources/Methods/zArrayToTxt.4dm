//%attributes = {}
  // PM "zArrayToTxt" (neu LV 14.02.2020)
  // $0 - $resultTxt - Ergebnistext (Quell-Array umgewandelt als Text)
  // $1 - C_POINTER - Pointer auf Quell-Array das in Text umgewandelt werden soll
  // $2 - C_TEXT - Trennzeichen zwischen den ArrayElementen im Ergebnistext (Default CR, es kann aber beliebiger Text vorgegeben werden wie auch Leer)
  // $3 - C_BOOLEAN - True="ignore null or empty array elements" | Default=False="list all array elements in result text"
  // Hilfsroutine um "onTheFly" im Ausdruck ein ARRAY in TEXT umzuwandeln
  // Unspezifische Umwandlung z.B. ohne besondere/individuelle Formatierung oder sonstige individuelle Umformungsregeln.
  // Kann u.a. dort eingesetzt werden wo man einfach nur eine billige Textinterpretation auf die Schnelle benötigt
  // z.B. Alert("Fehlerliste:"+Char(13)+Char(13)+zArrayToTxt(->$arr))
  // oder z.B. für debugHilfsProtokoll mit: SET TEXT TO PASTEBOARD(zArrayToTxt(->$arr))
  // oder z.B. diversen LogTxtExport ...usw...
  // Da die Umwandlung TxtToArray mit Hilfe dieser Methode als ein Ausdruck im Code formuliert werden kann, eignet
  // sich diese auch für diversen Einsatz überall dort wo man Formeln/Ausdruck angeben kann ...eben fix Txt als Ergenis im Ausdruck braucht.
  // Egal ob nun als EW-Formel in diversen Codes
  // oder UserFormel in quickReport/writePro/viewPro/VMFormelEditor...etc...
  // Da die Methode u.a. für Einsatz in Formeln gedacht ist, gilt
  // "Bitte NICHT löschen auch wenn scheinbar ohne sichtbaren Aufrufer"
  // ---- Folgende ArrayTypen sind erlaubt ----
  // + ARRAY TEXT        => "ab\rcd\ref"
  // + ARRAY LONGINT     => "1\r2\r3"
  // + ARRAY REAL        => "1.1\r2.2\r3.3"
  // + ARRAY INTEGER     => "1\r2\r3"
  // + ARRAY BOOLEAN     => "true\rfalse\rtrue"
  // + ARRAY OBJECT      => "[object Object]\r[object Object]\r[object Object]"
  // + ARRAY PICTURE     => "[object Object]\r[object Object]\r[object Object]"
  // + ARRAY DATE        => "2020-02-12\r2020-02-13\r2020-02-14"
  // + ARRAY TIME        => "36539\r36539\r36539"
  // ---- Folgende ArrayTypen sind NICHT erlaubt ----
  // - ARRAY BLOB
  // - ARRAY POINTER
  // S.a. Doku: https://doc.4d.com/4Dv18/4D/18/Type-conversions-between-collections-and-4D-arrays.300-4505851.en.html
  // Letzte Änderung: LV 14.02.2020, 18:02

C_TEXT:C284($resultTxt;$0)
C_POINTER:C301($ptrToArr;$1)
C_TEXT:C284($separator;$2)
C_BOOLEAN:C305($ignoreNullOrEmpty;$3)
C_COLLECTION:C1488($tmpCol)
C_LONGINT:C283($type)

ARRAY TEXT:C222($tmpArr;0)

$resultTxt:=""
$ptrToArr:=->$tmpArr
$separator:=Char:C90(13)
$ignoreNullOrEmpty:=False:C215
$tmpCol:=New collection:C1472
$type:=Is null:K8:31

If (Count parameters:C259>0)
	$ptrToArr:=$1
	$type:=Type:C295($ptrToArr->)
	If (Count parameters:C259>1)
		$separator:=$2
	End if 
End if 

Case of 
	: (Is nil pointer:C315($ptrToArr))
	: (($type#Text array:K8:16) & ($type#LongInt array:K8:19) & ($type#Real array:K8:17) & ($type#Integer array:K8:18) & ($type#Boolean array:K8:21) & ($type#Object array:K8:28) & ($type#Picture array:K8:22) & ($type#Date array:K8:20) & ($type#Time array:K8:29))
		
	Else 
		ARRAY TO COLLECTION:C1563($tmpCol;$ptrToArr->)
		
		If ($ignoreNullOrEmpty)
			$resultTxt:=$tmpCol.join($separator;ck ignore null or empty:K85:5)
		Else 
			$resultTxt:=$tmpCol.join($separator)
		End if 
		
		$0:=$resultTxt
End case 

  // - EOF -