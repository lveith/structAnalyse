//%attributes = {}
  // PM: "colMapJoin"
  // colResult:=col.map("colMapJoin";rowPrefix;rowSuffix;cellPrefix;cellSuffix;cellSeparator;colReplace;colKeys)
  // Debug-Note: To do stop col.map() loop set $1.stop:=True
  // Changed: 17.05.20, 17:01:06

C_OBJECT:C1216($1)  // col-item itself
C_TEXT:C284($2)  // rowPrefix
C_TEXT:C284($3)  // rowSuffix
C_TEXT:C284($4)  // cellPrefix
C_TEXT:C284($5)  // cellSuffix
C_TEXT:C284($6)  // cellSeparator
C_COLLECTION:C1488($7)  // collection of txtFragments to replace [{"from","<","to","&lt;"},{"from",">","to","&gt;"}] 
C_COLLECTION:C1488($8)  // collection of property names (keys)
C_COLLECTION:C1488($9)  // collection of alternativ titles for properties
C_LONGINT:C283($i;$length)
C_OBJECT:C1216($obj)
C_TEXT:C284($txt)
C_BOOLEAN:C305($doReplace)

Case of 
	: (Count parameters:C259<7)
		$doReplace:=False:C215
	: ($7.length<1)
		$doReplace:=False:C215
	Else 
		$doReplace:=True:C214
End case 

$1.result:=$2

If (Count parameters:C259>7)
	$length:=$8.length-1
	
	If (Count parameters:C259>8)
		$prevPar4:=$4
	End if 
	
	For ($i;0;$length)
		
		Case of 
			: (Value type:C1509($1.value[$8[$i]])=Is collection:K8:32)
				$txt:=JSON Stringify:C1217($1.value[$8[$i]];*)
			: (Value type:C1509($1.value[$8[$i]])=Is object:K8:27)
				$txt:=JSON Stringify:C1217($1.value[$8[$i]];*)
			: (Value type:C1509($1.value[$8[$i]])=Is pointer:K8:14)
				Case of 
					: (Value type:C1509($1.value[$8[$i]]->)=Is collection:K8:32)
						$txt:=JSON Stringify:C1217($1.value[$8[$i]]->;*)
					: (Value type:C1509($1.value[$8[$i]]->)=Is object:K8:27)
						$txt:=JSON Stringify:C1217($1.value[$8[$i]]->;*)
					Else 
						$txt:=String:C10($1.value[$8[$i]]->)
				End case 
			Else 
				$txt:=String:C10($1.value[$8[$i]])
		End case 
		
		If ($doReplace)
			For each ($obj;$7)
				$txt:=Replace string:C233($txt;$obj.from;$obj.to)
			End for each 
		End if 
		
		If (Count parameters:C259>8)
			If ($i<$length)
				$1.result:=$1.result+Replace string:C233($4;"###+keytitle+###";$9[$i])+$txt+$5+$6
			Else 
				$1.result:=$1.result+Replace string:C233($4;"###+keytitle+###";$9[$i])+$txt+$5
			End if 
			
		Else 
			If ($i<$length)
				$1.result:=$1.result+$4+$txt+$5+$6
			Else 
				$1.result:=$1.result+$4+$txt+$5
			End if 
			
		End if 
		
	End for 
	
Else 
	
	Case of 
		: (Value type:C1509($1.value)=Is collection:K8:32)
			$txt:=JSON Stringify:C1217($1.value;*)
		: (Value type:C1509($1.value)=Is object:K8:27)
			$txt:=JSON Stringify:C1217($1.value;*)
		Else 
			$txt:=String:C10($1.value)
	End case 
	
	If ($doReplace)
		For each ($obj;$7)
			$txt:=Replace string:C233($txt;$obj.from;$obj.to)
		End for each 
	End if 
	$1.result:=$1.result+$4+$txt+$5+$6
	
End if 

$1.result:=$1.result+$3

  // - EOF -