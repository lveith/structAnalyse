// OM: "_searchStruct".oBtnWebAreaTheme (new LV 17.07.20, 13:11:49)
// Last change: LV 17.07.20, 13:11:49

C_TEXT:C284($vtItems)
C_LONGINT:C283($vlUserChoice)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		C_TEXT:C284($vtItems)
		ARRAY TEXT:C222($aThemes;64)
		$aThemes{1}:="default"
		$aThemes{2}:="3024-day"
		$aThemes{3}:="3024-night"
		$aThemes{4}:="4d"
		$aThemes{5}:="abcdef"
		$aThemes{6}:="ambiance"
		$aThemes{7}:="ayu-dark"
		$aThemes{8}:="ayu-mirage"
		$aThemes{9}:="base16-dark"
		$aThemes{10}:="base16-light"
		$aThemes{11}:="bespin"
		$aThemes{12}:="blackboard"
		$aThemes{13}:="cobalt"
		$aThemes{14}:="colorforth"
		$aThemes{15}:="darcula"
		$aThemes{16}:="dracula"
		$aThemes{17}:="duotone-dark"
		$aThemes{18}:="duotone-light"
		$aThemes{19}:="eclipse"
		$aThemes{20}:="elegant"
		$aThemes{21}:="erlang-dark"
		$aThemes{22}:="gruvbox-dark"
		$aThemes{23}:="hopscotch"
		$aThemes{24}:="icecoder"
		$aThemes{25}:="idea"
		$aThemes{26}:="isotope"
		$aThemes{27}:="lesser-dark"
		$aThemes{28}:="liquibyte"
		$aThemes{29}:="lucario"
		$aThemes{30}:="material-palenight"
		$aThemes{31}:="material-ocean"
		$aThemes{32}:="material-darker"
		$aThemes{33}:="material"
		$aThemes{34}:="mbo"
		$aThemes{35}:="mdn-like"
		$aThemes{36}:="midnight"
		$aThemes{37}:="monokai"
		$aThemes{38}:="moxer"
		$aThemes{39}:="neat"
		$aThemes{40}:="neo"
		$aThemes{41}:="night"
		$aThemes{42}:="nord"
		$aThemes{43}:="oceanic-next"
		$aThemes{44}:="panda-syntax"
		$aThemes{45}:="paraiso-dark"
		$aThemes{46}:="paraiso-light"
		$aThemes{47}:="pastel-on-dark"
		$aThemes{48}:="railscasts"
		$aThemes{49}:="rubyblue"
		$aThemes{50}:="seti"
		$aThemes{51}:="shadowfox"
		$aThemes{52}:="solarized dark"
		$aThemes{53}:="solarized light"
		$aThemes{54}:="the-matrix"
		$aThemes{55}:="tomorrow-night-bright"
		$aThemes{56}:="tomorrow-night-eighties"
		$aThemes{57}:="ttcn"
		$aThemes{58}:="twilight"
		$aThemes{59}:="vibrant-ink"
		$aThemes{60}:="xq-dark"
		$aThemes{61}:="xq-light"
		$aThemes{62}:="yeti"
		$aThemes{63}:="yonce"
		$aThemes{64}:="zenburn"
		
		For ($i;1;Size of array:C274($aThemes))
			$vtItems:=$vtItems+$aThemes{$i}+";"
		End for 
		
		If (Length:C16($vtItems)>0)
			$vlUserChoice:=0
			$vlUserChoice:=Pop up menu:C542($vtItems)
			If (($vlUserChoice>0) & ($vlUserChoice<=Size of array:C274($aThemes)))
				// function myChangeThemeSet(myThemeName)
				// function myChangeTheme(myThemeName)
				// function setSelectedOptionByValue(mySelectBoxId, myValue)
				WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"setSelectedOptionByValue";*;"myThemeChooser";$aThemes{$vlUserChoice})
				WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"myChangeTheme";*;$aThemes{$vlUserChoice})
				WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"mySetEditorOption";*;"lineNumbers";True:C214)  // just to refresh left stripe width (themes can contain diff widths)
				WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"oWebArea";"mySetEditorOption";*;"lineNumbers";False:C215)  // just to refresh left stripe width (themes can contain diff widths)
			End if 
			
		End if 
		
End case 

// - EOF -