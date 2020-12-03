  // OM: "_searchStruct".oTrace
  // ...just some  debug helping codes (or for scripting own experiments onTheFly)...

C_TEXT:C284($searchString;$txt)
C_LONGINT:C283($i;$start;$stop)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		TRACE:C157
		Case of 
				
			: (False:C215)
				$searchString:="name = 'z@' OR name = 'y@'"
				Form:C1466.searchResultsDisplay:=Form:C1466.searchResultsDisplay.query($searchString)
				
			: (False:C215)
				Use (Form:C1466.run)
					Form:C1466.run.run:=False:C215
				End use 
				
			: (False:C215)
				$txt:=""
				For ($i;1;1000)
					$txt:=$txt+"$x:="+String:C10($i)+" // test\r"
				End for 
				
				C_COLLECTION:C1488($colResultICU;$colResultJS)
				C_BOOLEAN:C305($hasFoundOne)
				C_LONGINT:C283($startPos;$posFound;$lengthFound)
				$startPos:=1  // Default=1
				$regexPattern:="[\\d]"
				
				$start:=Milliseconds:C459
				$colResultICU:=zMatchRegexG ($txt;$regexPattern)
				$stop:=Milliseconds:C459
				ALERT:C41("icuMatchRegex\r"+String:C10($stop-$start))
				
				$start:=Milliseconds:C459
				$colResultJS:=zMatchRegexG_webArea ($regexPattern;$txt;"g")
				$stop:=Milliseconds:C459
				ALERT:C41("javascript4DWebArea\r"+String:C10($stop-$start))
				
				TRACE:C157
				
			: (False:C215)
				
			: (False:C215)
				
		End case 
		
End case 

  // - EOF -