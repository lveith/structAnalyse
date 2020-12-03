//%attributes = {}
  // PM: "sisInsertTextInCodeMirrorPane" (new LV 24.07.20, 19:02:49)
  // $1 - C_TEXT - txtContent (source code of the method)
  // $2 - C_TEXT - methodName
  // $1 - C_LONGINT - windowReference, recipient of the results (sent by "CALL FORM")
  // Inserts text in CodeMirrorPane in the webarea of current-form-window
  // Special:
  // Method ensures decoupled call and execution, to first let redraw the listbox after the event onSelectionChange
  // new marked row must draw immediately and can not wait until maybe a very big txtContent is ready submitted to webarea
  // - Step1(OM-Listbox): If(Form event code=On Selection Change) -> CALL WORKER("sisWorkerInsertText";"sisInsertTextInCodeMirrorPane")
  // - Step2(PM-sisInsertTextInCodeMirrorPane): CALL FORM(Current form window;"sisInsertTextInCodeMirrorPane")
  // - Step3(PM-sisInsertTextInCodeMirrorPane): WA EXECUTE JAVASCRIPT FUNCTION(*;"oWebArea";"insertInEditor")
  // Last change: LV 24.07.20, 19:02:49

C_TEXT:C284($txtContent;$1)
C_TEXT:C284($methodName;$2)
C_LONGINT:C283($winRef;$3)

If (Count parameters:C259>0)
	$txtContent:=$1
	If (Count parameters:C259>1)
		$methodName:=$2
	End if 
End if 

If (Count parameters:C259>2)
	  // called from form-object-method inner onSelectionsChange event
	$winRef:=$3
	CALL FORM:C1391($winRef;"sisInsertTextInCodeMirrorPane";$txtContent;$methodName)
	
Else 
	  // called from worker process 
	
	  // insertInEditor(myEditorName, mySrc)
	If (Length:C16($txtContent)>3555)  // for larger text set first to empty, to not see lastText until insertion is finished
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"insertInEditor";*;"mergeleft";"...please wait until method "+Form:C1466.soCurrEl.name+" (countChars="+String:C10(Length:C16($txtContent);"###,###,###,###,##0")+") is loaded...")
	End if 
	WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"insertInEditor";*;"mergeleft";$txtContent)
	
	  // regenerate all indents needs full parse whole document
	  // -- Just log-methods with comments and no code expression inside
	  // name = 'aa@Change@'
	  // OR name = 'aa@Unref_LAY@'
	  // OR name = 'aa@Deleted_Methods@'
	  // OR name = 'aa@Launched_Methods@'
	  // -- Just compiler methods with normally no block indents
	  // name = 'Compiler_@'
	Case of 
		: (Length:C16($txtContent)<14)  // less than 14chars can not be a multiline codeblock with indents
		: (Length:C16($txtContent)>2020)  // to big needs more than two seconds to full parsed whole document
		: (Position:C15(Char:C90(Carriage return:K15:38);$txtContent;*)<1)  // no return means can not have block indents
		: ($methodName="Compiler_@")  // do not full parse whole document from start to end with regenerate all indents for big compiler-methods
		: ($methodName="aa@Change@")  // just a log
		: ($methodName="aa@Unref_LAY@")  // just log/refInfo
		: ($methodName="aa@Deleted_Methods@")  // just a log
		: ($methodName="aa@Launched_Methods@")  // just log/refInfo
		Else 
			  // function selectAllEditor(myEditorName)
			WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"selectAllEditor";*;"mergeleft")
			  // function myIndentAuto(myEditorName)
			WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"myIndentAuto";*;"mergeleft")
			  // function setCursorAtStart(myEditorName)
			WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"setCursorAtStart";*;"mergeleft")
			
	End case 
	  //C_TEXT($funcResult)
	  //$funcResult:=WA Evaluate JavaScript(*;"oWebArea";"(function(){ dv.edit.setCursor({line: null, ch: null}); })();")  // set cursor to nowhere
	
End if 


  // - EOF -
