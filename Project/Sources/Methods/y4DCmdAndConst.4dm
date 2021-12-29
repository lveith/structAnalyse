//%attributes = {}
  // PM: "y4DCmdAndConst" (new LV 19.05.2020)
  // $0 - C_COLLECTION - ResultCol
  // $1 - C_BOOLEAN - withCmdList
  // $2 - C_BOOLEAN - withConstList
  // Returns a collection of 4D commands and constants
  // Last change: LV 20.12.2021

C_COLLECTION:C1488($resultCol;$0)
C_BOOLEAN:C305($withCmdList;$1)  // optional
C_BOOLEAN:C305($withConstList;$2)  // optional

C_TEXT:C284($type)
C_TEXT:C284($id;$info1;$commandName;$theme;$constantToken)
C_LONGINT:C283($i;$ii;$iii;$pos;$threadsafe;$commandNum;$constantNum;$constantThemeNum)
C_TEXT:C284($xml_Struct_Ref)
C_LONGINT:C283($numAttributes)
C_TEXT:C284($cmdTxt;$cmdValKind;$cmdNo;$lastCmdNo;$lastCmdTxt)
C_LONGINT:C283($iiiiii;$iiiii;$iiii)
C_OBJECT:C1216($objAppPath)
C_TEXT:C284($txtAttr)
C_OBJECT:C1216($attributes)

$withCmdList:=True:C214
$withConstList:=True:C214

If (Count parameters:C259>0)
	$withCmdList:=$1
	If (Count parameters:C259>1)
		$withConstList:=$2
	End if 
End if 

$resultCol:=New collection:C1472

  // ---- 4D-Commands -----
If ($withCmdList)
	ARRAY LONGINT:C221($arrCmdNo;0)
	
	$objAppPath:=Path to object:C1547(Application file:C491)
	
	If ($objAppPath#Null:C1517)
		If ($objAppPath.parentFolder#Null:C1517)
			If (Length:C16($objAppPath.parentFolder)>0)
				  // "Macintosh HD:Applications:4D v17 R5.236426:"
				  // + "4D.app:Contents:Resources:en.lproj:4DSyntaxEN.xlf"
				If (Test path name:C476($objAppPath.parentFolder+"4D.app"+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Resources"+Folder separator:K24:12+"en.lproj"+Folder separator:K24:12+"4DSyntaxEN.xlf")=Is a document:K24:1)
					$xml_Struct_Ref:=DOM Parse XML source:C719($objAppPath.parentFolder+"4D.app"+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Resources"+Folder separator:K24:12+"en.lproj"+Folder separator:K24:12+"4DSyntaxEN.xlf")
				Else 
					$xml_Struct_Ref:=DOM Parse XML source:C719(Get 4D folder:C485(Current resources folder:K5:16)+"4D"+Folder separator:K24:12+"4DSyntaxEN.xlf")
				End if 
				
				If (OK=1)
					ARRAY LONGINT:C221($arrType;0)
					ARRAY TEXT:C222($arrNodeRefs;0)
					DOM GET XML CHILD NODES:C1081($xml_Struct_Ref;$arrType;$arrNodeRefs)
				Else   // ... do not know where file "4DSyntaxEN.xlf" can found
					ARRAY LONGINT:C221($arrType;0)
					ARRAY TEXT:C222($arrNodeRefs;0)
				End if 
				For ($i;1;Size of array:C274($arrType))
					Case of 
						: ($arrType{$i}=XML ELEMENT:K45:20)
							DOM GET XML ELEMENT NAME:C730($arrNodeRefs{$i};$type)
							Case of 
								: ($type="file")
									ARRAY LONGINT:C221($arrType2;0)
									ARRAY TEXT:C222($arrNodeRefs2;0)
									DOM GET XML CHILD NODES:C1081($arrNodeRefs{$i};$arrType2;$arrNodeRefs2)
									For ($iii;1;Size of array:C274($arrType2))
										Case of 
											: ($arrType2{$iii}=XML ELEMENT:K45:20)
												DOM GET XML ELEMENT NAME:C730($arrNodeRefs2{$iii};$type)
												Case of 
													: ($type="body")
														ARRAY LONGINT:C221($arrType3;0)
														ARRAY TEXT:C222($arrNodeRefs3;0)
														DOM GET XML CHILD NODES:C1081($arrNodeRefs2{$iii};$arrType3;$arrNodeRefs3)
														For ($iiii;1;Size of array:C274($arrType3))
															Case of 
																: ($arrType3{$iiii}=XML ELEMENT:K45:20)
																	DOM GET XML ELEMENT NAME:C730($arrNodeRefs3{$iiii};$type)
																	Case of 
																		: ($type="group")
																			ARRAY LONGINT:C221($arrType4;0)
																			ARRAY TEXT:C222($arrNodeRefs4;0)
																			DOM GET XML CHILD NODES:C1081($arrNodeRefs3{$iiii};$arrType4;$arrNodeRefs4)
																			For ($iiiii;1;Size of array:C274($arrType4))
																				Case of 
																					: ($arrType4{$iiiii}=XML ELEMENT:K45:20)
																						DOM GET XML ELEMENT NAME:C730($arrNodeRefs4{$iiiii};$type)
																						Case of 
																							: ($type="trans-unit")
																								  // <file datatype="x-STR#" original="undefined" source-language="en" target-language="en" product-version="v17 R5">
																								  //       <body>
																								  //         <group resname="4D syntax">
																								  //             <trans-unit resname="cmd1" id="1">
																								  //                 <target>Sum ( series {; attributePath} ) -&gt; Real</target>
																								  //             </trans-unit>
																								  //             <trans-unit resname="desc1" id="1">
																								  //                 <target>returns the sum (total of all values) for series.</target>
																								  //             </trans-unit>
																								$numAttributes:=DOM Count XML attributes:C727($arrNodeRefs4{$iiiii})
																								For ($ii;1;$numAttributes)
																									DOM GET XML ATTRIBUTE BY INDEX:C729($arrNodeRefs4{$iiiii};$ii;$attribName;$attribValue)
																									Case of 
																										: ($attribName="id")
																											$cmdNo:=$attribValue  // command number
																										: ($attribName="resname")
																											$cmdValKind:=$attribValue  // commandsyntax="cmd1" or description="desc1"
																									End case 
																								End for 
																								ARRAY LONGINT:C221($arrType5;0)
																								ARRAY TEXT:C222($arrNodeRefs5;0)
																								DOM GET XML CHILD NODES:C1081($arrNodeRefs4{$iiiii};$arrType5;$arrNodeRefs5)
																								For ($iiiiii;1;Size of array:C274($arrType5))
																									Case of 
																										: ($arrType5{$iiiiii}=XML ELEMENT:K45:20)
																											DOM GET XML ELEMENT NAME:C730($arrNodeRefs5{$iiiiii};$type)
																											Case of 
																												: ($type="target")
																													DOM GET XML ELEMENT VALUE:C731($arrNodeRefs5{$iiiiii};$cmdTxt)
																													Case of 
																														: ($cmdValKind="cmd@")  // command syntax
																															$lastCmdTxt:=$cmdTxt
																															$lastCmdNo:=$cmdNo
																															
																														: ($cmdValKind="desc@")  // command description
																															If ($lastCmdNo=$cmdNo)
																																$attributes:=New object:C1471("threadsafe";Null:C1517)
																																$threadsafe:=-9
																																$theme:=""
																																$commandName:=Command name:C538(Num:C11($cmdNo);$threadsafe;$theme)
																																If (OK=1)  //command number exists for "Command name"
																																	$attributes.threadsafe:=$threadsafe
																																	$contents:=$commandName+":C"+$cmdNo
																																	
																																Else   // command number did not exists for "Command name"
																																	$pos:=Position:C15("(";$lastCmdTxt)
																																	If ($pos>1)
																																		$commandName:=Substring:C12($lastCmdTxt;1;$pos-1)
																																	Else 
																																		$commandName:=$lastCmdTxt
																																	End if 
																																	Case of 
																																		: ($commandName="collection.@")
																																			$threadsafe:=1
																																			$attributes.threadsafe:=$threadsafe
																																			$theme:="Collections"
																																		: ($commandName="formula.call@")
																																			$threadsafe:=1
																																			$attributes.threadsafe:=$threadsafe
																																			$theme:="Formulas"
																																		: ($commandName="formula.apply@")
																																			$threadsafe:=1
																																			$attributes.threadsafe:=$threadsafe
																																			$theme:="Formulas"
																																		: ($commandName="dataStore.getRequestLog@")
																																			$threadsafe:=0
																																			$attributes.threadsafe:=$threadsafe
																																			$theme:="ORDA - DataStore"
																																	End case 
																																	$contents:=$commandName
																																	
																																End if 
																																$id:="C"+$cmdNo
																																$attributes.cmdSyntax:=$lastCmdTxt
																																$attributes.cmdDesc:=$cmdTxt
																																If (($commandName#"") & ($commandName#"_4D"))
																																	  // $txtAttr:=JSON Stringify($attributes;*)
																																	If ($attributes.threadsafe=Null:C1517)
																																		$txtAttr:="?"
																																	Else 
																																		$txtAttr:=String:C10(Num:C11(Bool:C1537($attributes.threadsafe ?? 0));"True;False;False")
																																	End if 
																																	$resultCol.push(New object:C1471("column1";$resultCol.length+1;"column2";$commandName;"column3";$id;"column4";"command";"column5";$theme;"column6";$contents;"column7";$txtAttr;"column8";$attributes.cmdSyntax;"column9";$attributes.cmdDesc))
																																	APPEND TO ARRAY:C911($arrCmdNo;Num:C11($cmdNo))
																																End if 
																															End if 
																															
																													End case 
																											End case 
																									End case 
																								End for 
																						End case 
																				End case 
																			End for 
																	End case 
															End case 
														End for 
												End case 
										End case 
									End for 
									
									
							End case 
					End case 
				End for 
				DOM CLOSE XML:C722($xml_Struct_Ref)
				
			End if 
		End if 
	End if 
	$commandNum:=0
	Repeat 
		$commandNum:=$commandNum+1
		$pos:=Find in array:C230($arrCmdNo;$commandNum)
		If ($pos<1)
			$threadsafe:=-9
			$theme:=""
			$commandName:=Command name:C538($commandNum;$threadsafe;$theme)
			If (OK=1)  //command number exists
				If (Length:C16($commandName)>0)  //command is not disabled
					  // If ($threadsafe ?? 0)  //if the first bit is set to 1
					  // $info1:="threadsafe=True"
					  // Else 
					  // $info1:="threadsafe=False"
					  // End if 
					$id:="C"+String:C10($commandNum)
					$contents:=$commandName+":C"+String:C10($commandNum)
					If (($commandName#"") & ($commandName#"_4D"))
						  // $attributes:=New object("threadsafe";$threadsafe)
						  // $txtAttr:=JSON Stringify($attributes;*)
						  // $attributes.threadsafe:=$threadsafe
						  // $attributes.cmdSyntax:=$lastCmdTxt
						  // $attributes.cmdDesc:=$cmdTxt
						$resultCol.push(New object:C1471("column1";$resultCol.length+1;"column2";$commandName;"column3";$id;"column4";"command";"column5";$theme;"column6";$contents;"column7";String:C10(Num:C11(Bool:C1537($threadsafe ?? 0));"True;False;False");"column8";"";"column9";""))
					End if 
					
				Else 
					// If ($threadsafe ?? 0)  //if the first bit is set to 1
					// $info1:="threadsafe=True"
					// Else 
					// $info1:="threadsafe=False"
					// End if 
					$id:="C"+String:C10($commandNum)
					$commandName:=Parse formula:C1576(":"+$id)
					$contents:=$commandName+":C"+String:C10($commandNum)
					If (($commandName#"") & ($commandName#"_4D"))
						// $attributes:=New object("threadsafe";$threadsafe)
						// $txtAttr:=JSON Stringify($attributes;*)
						// $attributes.threadsafe:=$threadsafe
						// $attributes.cmdSyntax:=$lastCmdTxt
						// $attributes.cmdDesc:=$cmdTxt
						$resultCol.push(New object:C1471("column1"; $resultCol.length+1; "column2"; $commandName; "column3"; $id; "column4"; "command"; "column5"; "Used only 4D intern (disabled)"; "column6"; $contents; "column7"; "?"; "column8"; ""; "column9"; "Command is disabled (only 4D intern usage)"))
					End if 
					
				End if 
			End if 
		End if 
	Until (OK=0)  //end of existing commands
End if 

  // ---- 4D-Constants -----
If ($withConstList)
	$constantThemeNum:=0
	$constantNum:=0
	Repeat 
		$constantThemeNum:=$constantThemeNum+1
		Repeat 
			$constantNum:=$constantNum+1
			$constantToken:="xy:K"+String:C10($constantThemeNum)+":"+String:C10($constantNum)
			$constantName:=Parse formula:C1576($constantToken)
			If ((Length:C16($constantName)>0) & ($constantName#("‘k"+String:C10($constantThemeNum)+";"+String:C10($constantNum)+"‘")) & ($constantName#(":K"+String:C10($constantThemeNum)+" : "+String:C10($constantNum))))
				$contents:=$constantName+":K"+String:C10($constantThemeNum)+":"+String:C10($constantNum)
				Case of 
					: ($constantThemeNum=1)
						$theme:="Date Display Formats"
					: ($constantThemeNum=2)
						$theme:="Form Events"
					: ($constantThemeNum=3)
						$theme:="Trigger Events"
					: ($constantThemeNum=4)
						$theme:="Standard System Signatures"
					: ($constantThemeNum=5)
						$theme:="4D Environment"
					: ($constantThemeNum=6)
						$theme:="Picture Display Formats"
					: ($constantThemeNum=7)
						$theme:="Time Display Formats"
					: ($constantThemeNum=8)
						$theme:="Field and Variable Types"
					: ($constantThemeNum=9)
						$theme:="Platform Interface"
					: ($constantThemeNum=10)
						$theme:="Days and Months"
					: ($constantThemeNum=11)
						$theme:="Colors"
					: ($constantThemeNum=12)
						$theme:="Function Keys"
					: ($constantThemeNum=13)
						$theme:="Process State"
					: ($constantThemeNum=14)
						$theme:="Font Styles"
					: ($constantThemeNum=15)
						$theme:="ASCII Codes"
					: ($constantThemeNum=16)
						$theme:="Events (Modifiers)"
					: ($constantThemeNum=17)
						$theme:="Events (What)"
					: ($constantThemeNum=18)
						$theme:="Resources Properties"
					: ($constantThemeNum=19)
						$theme:="Queries"
					: ($constantThemeNum=20)
						$theme:="Pasteboard"
					: ($constantThemeNum=21)
						$theme:="TCP Port Numbers"
					: ($constantThemeNum=22)
						$theme:="BLOB"
					: ($constantThemeNum=23)
						$theme:="SET RGB COLORS"
					: ($constantThemeNum=24)
						$theme:="System Documents"
					: ($constantThemeNum=25)
						$theme:="Platform Properties"
					: ($constantThemeNum=26)
						$theme:="Find Window"
					: ($constantThemeNum=27)
						$theme:="Windows"
					: ($constantThemeNum=28)
						$theme:="Hierarchical Lists"
					: ($constantThemeNum=29)
						$theme:="Database Engine"
					: ($constantThemeNum=30)
						$theme:="Math"
					: ($constantThemeNum=31)
						$theme:="Communications"
					: ($constantThemeNum=32)
						$theme:="ISO Latin Character Entities"
					: ($constantThemeNum=33)
						$theme:="SCREEN DEPTH"
					: ($constantThemeNum=34)
						$theme:="Open Window"
					: ($constantThemeNum=35)
						$theme:="Expressions"
					: ($constantThemeNum=36)
						$theme:="Process Type"
					: ($constantThemeNum=37)
						$theme:="Database Parameters"
					: ($constantThemeNum=38)
						$theme:="Log Events"
					: ($constantThemeNum=39)
						$theme:="Open Form Window"
					: ($constantThemeNum=40)
						$theme:="Euro Currencies"
					: ($constantThemeNum=41)
						$theme:="System Folder"
					: ($constantThemeNum=42)
						$theme:="Form Objects (Properties)"
					: ($constantThemeNum=43)
						$theme:="Form Area"
					: ($constantThemeNum=44)
						$theme:="Is License Available"
					: ($constantThemeNum=45)
						$theme:="XML"
					: ($constantThemeNum=46)
						$theme:="Web Services (Server)"
					: ($constantThemeNum=47)
						$theme:="Print Options"
					: ($constantThemeNum=48)
						$theme:="Web Services (Client)"
					: ($constantThemeNum=49)
						$theme:="SQL"
					: ($constantThemeNum=50)
						$theme:="Form Parameters"
					: ($constantThemeNum=51)
						$theme:="Relations"
					: ($constantThemeNum=52)
						$theme:="Dictionaries (These constants correspond to numbers for \"Cordial\" dictionaries, which are no longer supported)"
					: ($constantThemeNum=53)
						$theme:="List Box"
					: ($constantThemeNum=54)
						$theme:="Backup and Restore"
					: ($constantThemeNum=55)
						$theme:="Picture Compression"
					: ($constantThemeNum=56)
						$theme:="Menu Item Properties"
					: ($constantThemeNum=57)
						$theme:="Data File Maintenance"
					: ($constantThemeNum=58)
						$theme:="Index Type"
					: ($constantThemeNum=59)
						$theme:="Value for Associated Standard Action"
					: ($constantThemeNum=60)
						$theme:="System Format"
					: ($constantThemeNum=61)
						$theme:="Picture Transformation"
					: ($constantThemeNum=62)
						$theme:="Web Area"
					: ($constantThemeNum=64)
						$theme:="PHP"
					: ($constantThemeNum=65)
						$theme:="Multistyle Text Attributes"
					: ($constantThemeNum=66)
						$theme:="Digest Type"
					: ($constantThemeNum=67)
						$theme:="Form Objects (Access)"
					: ($constantThemeNum=68)
						$theme:="Picture Metadata Names"
					: ($constantThemeNum=69)
						$theme:="Picture Metadata Values"
					: ($constantThemeNum=70)
						$theme:="Listbox Footer Calculation"
					: ($constantThemeNum=71)
						$theme:="HTTP Client"
					: ($constantThemeNum=72)
						$theme:="Design Object Access"
					: ($constantThemeNum=73)
						$theme:="Web Server"
					: ($constantThemeNum=74)
						$theme:="Database Events"
					: ($constantThemeNum=75)
						$theme:="Shortcut and Associated Keys"
					: ($constantThemeNum=76)
						$theme:="Standard Action"
					: ($constantThemeNum=78)
						$theme:="Multistyle Text"
					: ($constantThemeNum=79)
						$theme:="Form Object Types"
					: ($constantThemeNum=80)
						$theme:="Font Type List"
					: ($constantThemeNum=81)
						$theme:="4D Write Pro"
					: ($constantThemeNum=82)
						$theme:="Graph Parameters"
					: ($constantThemeNum=83)
						$theme:="LDAP"
					: ($constantThemeNum=84)
						$theme:="Cache Management"
					: ($constantThemeNum=85)
						$theme:="Objects and collections"
					: ($constantThemeNum=86)
						$theme:="Strings"
					: ($constantThemeNum=88)
						$theme:="Formulas"
					: ($constantThemeNum=89)
						$theme:="4D View Pro Constants"
					Else 
						$theme:=""
				End case 
				If ($constantName="TIFF JBIGB&W")
					$result:="value=9"
				Else 
					$formula:=Formula from string:C1601($contents)
					$result:="value="+String:C10($formula.call())
				End if 
				$resultCol.push(New object:C1471("column1";$resultCol.length+1;"column2";$constantName;"column3";"K"+String:C10($constantThemeNum)+":"+String:C10($constantNum);"column4";"constant";"column5";$theme;"column6";$contents;"column7";$result))
			Else 
				Case of 
					: ($constantThemeNum=81)
						If ($constantNum>300)
							$constantName:=""
						End if 
					: (($constantThemeNum=68) | ($constantThemeNum=69))
						If ($constantNum>200)
							$constantName:=""
						End if 
					Else 
						If ($constantNum>100)
							$constantName:=""
						End if 
				End case 
			End if 
		Until ((Length:C16($constantName)<1) | ($constantNum>32766))
		$constantNum:=0
	Until ($constantThemeNum>99)
End if 

$0:=$resultCol

  // - EOF -
