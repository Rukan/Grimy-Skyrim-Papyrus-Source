scriptname AHZConfigMenu extends SKI_ConfigBase


GlobalVariable Property AHZBottomWidgetXPercent  Auto  
GlobalVariable Property AHZBottomWidgetYPercent  Auto  
GlobalVariable Property AHZSideWidgetXPercent  Auto  
GlobalVariable Property AHZSideWidgetYPercent  Auto  
GlobalVariable Property AHZShowBottomWidget  Auto  
GlobalVariable Property AHZShowIngredientWidget  Auto
GlobalVariable Property AHZShowEffectsWidget  Auto
GlobalVariable Property AHZShowInventoryCount  Auto  
GlobalVariable Property AHZInventoryWidgetYPercent  Auto  
GlobalVariable Property AHZInventoryWidgetXPercent  Auto  
GlobalVariable Property AHZBottomWidgetRightAligned  Auto  
GlobalVariable Property AHZInventoryWidgetRightAligned  Auto  
GlobalVariable Property AHZEffectsWidgetStyle  Auto  
GlobalVariable Property AHZIngredientsWidgetStyle  Auto  
GlobalVariable Property AHZShowWeightClass  Auto  
GlobalVariable Property AHZShowBooksRead  Auto  
GlobalVariable Property AHZActivationMode  Auto 
GlobalVariable Property AHZToggleState Auto 
GlobalVariable Property AHZHotKey  Auto  
GlobalVariable Property AHZShowBookSkill  Auto  
GlobalVariable Property AHZShowTargetWeight  Auto 
GlobalVariable Property AHZHotkeyToggles  Auto  

Quest Property AHZMainQuestREF  Auto  

; Default wiget positions for the sliders
float Property DefaultBottomXPercent  = 98.0 autoReadOnly
float Property DefaultBottomYPercent  = 100.0 autoReadOnly
float Property DefaultSideXPercent  = 80.0 autoReadOnly
float Property DefaultSideYPercent  = 68.0 autoReadOnly
float Property DefaultInventoryXPercent  = 2.0 autoReadOnly
float Property DefaultInventoryYPercent  = 100.0 autoReadOnly
int Property DefaultEffectsStyle = 2 autoReadOnly
int Property DefaultIngredientsStyle = 0 autoReadOnly

string[] Property WidgetStyles Auto
string[] Property AlignmentStyles Auto
string[] Property ActivationModes Auto

; SCRIPT VERSION ----------------------------------------------------------------------------------
;
; NOTE:
; This is an example to show you how to update scripts after they have been deployed.
;
; History
;
; 1 - Initial version
; 2 - Cleanup, no actual changes to menu
; 3 - Added widget positioning options
; 4 - Added the option to show the inventory count
; 5 - Created separate pages for each widget

int function GetVersion()
	return 7
endFunction


; PRIVATE VARIABLES -------------------------------------------------------------------------------

; --- Version 1 ---

; Lists

; OIDs (T:Text B:Toggle S:Slider M:Menu, C:Color, K:Key)
int			_toggle1OID_B				; Show Player Data Widget
int			_toggle2OID_B				; Show Target Data Widget (Ingredients)
int			_toggle3OID_B				; Show Target Data Widget (Effects)
int			_toggle4OID_B				; Uninstall
int			_toggle5OID_B				; Show Target Inventory
int			_toggle8OID_B				; Show Books Read
int			_toggle9OID_B				; Show Armor Weight Class
int			_toggle10OID_B				; Show Book Skill
int			_toggle11OID_B				; Show Target Weight with Player's Weight
int			_toggle12OID_B				; Hotkey Toggles

int			_sliderSideX_OID_S
int			_sliderSideY_OID_S
int			_sliderBottomX_OID_S
int			_sliderBottomY_OID_S
int			_sliderInventoryX_OID_S
int			_sliderInventoryY_OID_S

int			_ingredientStyleOID_M;
int			_effectsStyleOID_M;
int         _bottomAlignmentOID_M;
int         _inventoryAlignmentOID_M;
int         _activationModeOID_M;

int 		_activationKeyMapOID_K;

;Private variables
bool 		_uninstallMod			= false


; INITIALIZATION ----------------------------------------------------------------------------------

; @overrides SKI_ConfigBase
event OnConfigInit()
	Pages = new string[5]
	Pages[0] = "General"
	Pages[1] = "Player's Data"
	Pages[2] = "Target's Data"
	Pages[3] = "Target's Count"
	Pages[4] = "Presets"

	WidgetStyles = new String[4]
	WidgetStyles[0] = "Bullets"
	WidgetStyles[1] = "Vertical Bar"
	WidgetStyles[2] = "Vertical Bar With BG"
	WidgetStyles[3] = "Text Only"

	AlignmentStyles = new String[3]
	AlignmentStyles[0] = "Left"
	AlignmentStyles[1] = "Right"
	AlignmentStyles[2] = "Center"	

	ActivationModes = new String[5]
	ActivationModes[0] = "Auto - Always"
	ActivationModes[1] = "Auto - No Combat"
	ActivationModes[2] = "Hotkey Only"		

endEvent

event OnConfigOpen()
	Pages = new string[5]
	Pages[0] = "General"
	Pages[1] = "Player's Data"
	Pages[2] = "Target's Data"
	Pages[3] = "Target's Count"
	Pages[4] = "Presets"
	_uninstallMod = false;
endEvent

event OnConfigClose()
	if (_uninstallMod == true)
		(AHZMainQuestREF as AHZMainQuest).Unregister()
		Stop()
	else
		(AHZMainQuestREF as AHZMainQuest).UpdateSettings(false)
	endIf
endEvent

; @implements SKI_QuestBase
event OnVersionUpdate(int a_version)
	{Called when a version update of this script has been detected}
	OnConfigInit()							
endEvent


; EVENTS ------------------------------------------------------------------------------------------

; @implements SKI_ConfigBase
event OnPageReset(string a_page)
	{Called when a new page is selected, including the initial empty page}
	
	if (a_page == "")
		LoadCustomContent("exported/AHZmoreHUDLogo.dds", 150,100)
		return
	else
		UnloadCustomContent()
		SetCursorFillMode(TOP_TO_BOTTOM)
	endif

	if (a_page == "General")
		AddHeaderOption("Activation Options")
		_activationModeOID_M 	= AddMenuOption("Activation Mode", ActivationModes[AHZActivationMode.GetValueInt()])
		_activationKeyMapOID_K 	= AddKeyMapOption("Activation HotKey",AHZHotKey.GetValueInt(),  OPTION_FLAG_WITH_UNMAP);
		_toggle12OID_B			= AddToggleOption("  HotKey Toggles", AHZHotkeyToggles.GetValueInt())
		AddEmptyOption()

		AddHeaderOption("Widget Extras")		
		_toggle8OID_B			= AddToggleOption("Show Books Read", AHZShowBooksRead.GetValueInt())
		_toggle9OID_B			= AddToggleOption("Show Armor Weight Class", AHZShowWeightClass.GetValueInt())
		_toggle10OID_B			= AddToggleOption("Show Book Skill", AHZShowBookSkill.GetValueInt())
		AddEmptyOption()

		SetCursorPosition(1)
		AddHeaderOption("Maintenance")	
		_toggle4OID_B			= AddToggleOption("Uninstall", _uninstallMod)
	elseif (a_page == "Player's Data")
		AddHeaderOption("Player's Data Widget")
		_toggle1OID_B			= AddToggleOption("Visible", AHZShowBottomWidget.GetValueInt())
		_bottomAlignmentOID_M 	= AddMenuOption("  Alignment", AlignmentStyles[AHZBottomWidgetRightAligned.GetValueInt()])
		AddEmptyOption()
		_toggle11OID_B			= AddToggleOption("Display target weight with carry weight", AHZShowTargetWeight.GetValueInt())

		SetCursorPosition(1)
		AddHeaderOption("Position")
		_sliderBottomX_OID_S 	= AddSliderOption("X Position", AHZBottomWidgetXPercent.GetValue(), "{2}%")
		_sliderBottomY_OID_S 	= AddSliderOption("Y Position", AHZBottomWidgetYPercent.GetValue(), "{2}%")
	elseif (a_page == "Target's Data")
		AddHeaderOption("Target's Data Widget")
		_toggle2OID_B			= AddToggleOption("Show Ingredient Effects", AHZShowIngredientWidget.GetValueInt())
		_toggle3OID_B			= AddToggleOption("Show Other Effects", AHZShowEffectsWidget.GetValueInt())
		AddEmptyOption()
		AddHeaderOption("Widget Style")
		_ingredientStyleOID_M = AddMenuOption(" Ingredients", WidgetStyles[AHZIngredientsWidgetStyle.GetValueInt()])
		_effectsStyleOID_M = AddMenuOption(" Other Effects", WidgetStyles[AHZEffectsWidgetStyle.GetValueInt()])

		SetCursorPosition(1)
		AddHeaderOption("Position")		
		_sliderSideX_OID_S 		= AddSliderOption("X Position", AHZSideWidgetXPercent.GetValue(), "{2}%")
		_sliderSideY_OID_S 		= AddSliderOption("Y Position", AHZSideWidgetYPercent.GetValue(), "{2}%")			
	elseif ((a_page == "Target's Inventory") || (a_page == "Target's Count"))
		AddHeaderOption("Target's Count Widget")
		_toggle5OID_B 			= AddToggleOption("Visible", AHZShowInventoryCount.GetValueInt())
		_inventoryAlignmentOID_M = AddMenuOption("  Alignment", AlignmentStyles[AHZInventoryWidgetRightAligned.GetValueInt()])

		AddEmptyOption()

		SetCursorPosition(1)
		AddHeaderOption("Position")	
		_sliderInventoryX_OID_S = AddSliderOption("X Position", AHZInventoryWidgetXPercent.GetValue(), "{2}%")
		_sliderInventoryY_OID_S = AddSliderOption("Y Position", AHZInventoryWidgetYPercent.GetValue(), "{2}%")
	else
		AddHeaderOption("Presets")
		AddTextOptionST("FISS_SAVE_PRESET","Save Preset","GO!")
		AddTextOptionST("FISS_LOAD_PRESET","Load Preset","GO!")
	endif

endEvent

; @implements SKI_ConfigBase
event OnOptionSelect(int a_option)
	{Called when the user selects a non-dialog option}
	
	; Toggle books read
	if (a_option == _toggle8OID_B)
		ToggleGlobalInt(AHZShowBooksRead)
		SetToggleOptionValue(_toggle8OID_B, AHZShowBooksRead.GetValueInt())
	endif

	; Toggle weight class
	if (a_option == _toggle9OID_B)
		ToggleGlobalInt(AHZShowWeightClass)
		SetToggleOptionValue(_toggle9OID_B, AHZShowWeightClass.GetValueInt())
	endif

	; Toggle book skill
	if (a_option == _toggle10OID_B)
		ToggleGlobalInt(AHZShowBookSkill)
		SetToggleOptionValue(_toggle10OID_B, AHZShowBookSkill.GetValueInt())
	endif

	; Toggle Target+Players Weight
	if (a_option == _toggle11OID_B)
		ToggleGlobalInt(AHZShowTargetWeight)
		SetToggleOptionValue(_toggle11OID_B, AHZShowTargetWeight.GetValueInt())
	endif

	; Hotkey Toggles
	if (a_option == _toggle12OID_B)
		ToggleGlobalInt(AHZHotkeyToggles)
		SetToggleOptionValue(_toggle12OID_B, AHZHotkeyToggles.GetValueInt())
	endif

	; Toggle bottom widget
	if (a_option == _toggle1OID_B)
		ToggleGlobalInt(AHZShowBottomWidget)
		SetToggleOptionValue(_toggle1OID_B, AHZShowBottomWidget.GetValueInt())
	endif
	
	; Toggle Inventory Count
	if (a_option == _toggle5OID_B)
		ToggleGlobalInt(AHZShowInventoryCount)
		SetToggleOptionValue(_toggle5OID_B, AHZShowInventoryCount.GetValueInt())
	endif

	; Toggle side widget for ingredient effects
	if (a_option == _toggle2OID_B)
		ToggleGlobalInt(AHZShowIngredientWidget)
		SetToggleOptionValue(_toggle2OID_B, AHZShowIngredientWidget.GetValueInt())
	endif	
	
	; Toggle side widget for effects
	if (a_option == _toggle3OID_B)
		ToggleGlobalInt(AHZShowEffectsWidget)
		SetToggleOptionValue(_toggle3OID_B, AHZShowEffectsWidget.GetValueInt())
	endif	

	; Toggle uninstall
	if (a_option == _toggle4OID_B)
		_uninstallMod = !_uninstallMod
		if (_uninstallMod == true)
			if (ShowMessage("Are you sure you want to remove the mod?", true))
			else
				_uninstallMod = false
			endIf
		endif
		SetToggleOptionValue(_toggle4OID_B, _uninstallMod)
	endif		

endEvent

; @implements SKI_ConfigBase
event OnOptionSliderOpen(int a_option)
	{Called when the user selects a slider option}

	if (a_option == _sliderBottomX_OID_S)
		SetSliderDialogStartValue(AHZBottomWidgetXPercent.GetValue())
		SetSliderDialogDefaultValue(DefaultBottomXPercent)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(0.01)
	endIf

	if (a_option == _sliderBottomY_OID_S)
		SetSliderDialogStartValue(AHZBottomWidgetYPercent.GetValue())
		SetSliderDialogDefaultValue(DefaultBottomYPercent)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(0.01)
	endIf	

	if (a_option == _sliderSideX_OID_S)
		SetSliderDialogStartValue(AHZSideWidgetXPercent.GetValue())
		SetSliderDialogDefaultValue(DefaultSideXPercent)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(0.01)
	endIf		

	if (a_option == _sliderSideY_OID_S)
		SetSliderDialogStartValue(AHZSideWidgetYPercent.GetValue())
		SetSliderDialogDefaultValue(DefaultSideYPercent)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(0.01)
	endIf	

	if (a_option == _sliderInventoryX_OID_S)
		SetSliderDialogStartValue(AHZInventoryWidgetXPercent.GetValue())
		SetSliderDialogDefaultValue(DefaultInventoryXPercent)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(0.01)
	endIf		

	if (a_option == _sliderInventoryY_OID_S)
		SetSliderDialogStartValue(AHZInventoryWidgetYPercent.GetValue())
		SetSliderDialogDefaultValue(DefaultInventoryYPercent)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(0.01)
	endIf				
endEvent

; @implements SKI_ConfigBase
event OnOptionSliderAccept(int a_option, float a_value)

	if (a_option == _sliderBottomX_OID_S)
		AHZBottomWidgetXPercent.SetValue(a_value)
		SetSliderOptionValue(a_option, a_value, "{2}%")
	endIf

	if (a_option == _sliderBottomY_OID_S)
		AHZBottomWidgetYPercent.SetValue(a_value)
		SetSliderOptionValue(a_option, a_value, "{2}%")
	endIf	

	if (a_option == _sliderSideX_OID_S)
		AHZSideWidgetXPercent.SetValue(a_value)
		SetSliderOptionValue(a_option, a_value, "{2}%")
	endIf		

	if (a_option == _sliderSideY_OID_S)
		AHZSideWidgetYPercent.SetValue(a_value)
		SetSliderOptionValue(a_option, a_value, "{2}%")
	endIf	

	if (a_option == _sliderInventoryX_OID_S)
		AHZInventoryWidgetXPercent.SetValue(a_value)
		SetSliderOptionValue(a_option, a_value, "{2}%")
	endIf		

	if (a_option == _sliderInventoryY_OID_S)
		AHZInventoryWidgetYPercent.SetValue(a_value)
		SetSliderOptionValue(a_option, a_value, "{2}%")
	endIf	
endEvent

; @implements SKI_ConfigBase
event OnOptionMenuOpen(int a_option)
	{Called when the user selects a menu option}
	if (a_option == _ingredientStyleOID_M)
		SetMenuDialogStartIndex(AHZIngredientsWidgetStyle.GetValueInt())
		SetMenuDialogDefaultIndex(DefaultIngredientsStyle)
		SetMenuDialogOptions(WidgetStyles)
	endIf

	if (a_option == _effectsStyleOID_M)
		SetMenuDialogStartIndex(AHZEffectsWidgetStyle.GetValueInt())
		SetMenuDialogDefaultIndex(DefaultEffectsStyle)
		SetMenuDialogOptions(WidgetStyles)
	endIf	

	if (a_option == _bottomAlignmentOID_M)
		SetMenuDialogStartIndex(AHZBottomWidgetRightAligned.GetValueInt())
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(AlignmentStyles)
	endif

	if (a_option == _inventoryAlignmentOID_M)
		SetMenuDialogStartIndex(AHZInventoryWidgetRightAligned.GetValueInt())
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(AlignmentStyles)
	endif

	if (a_option == _activationModeOID_M)
		SetMenuDialogStartIndex(AHZActivationMode.GetValueInt())
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(ActivationModes)
	endif

endEvent

; @implements SKI_ConfigBase
event OnOptionMenuAccept(int a_option, int a_index)
	{Called when the user accepts a new menu entry}

	if (a_option == _ingredientStyleOID_M)
		AHZIngredientsWidgetStyle.SetValueInt(a_index)
		SetMenuOptionValue(a_option, WidgetStyles[a_index])
	endIf

	if (a_option == _effectsStyleOID_M)
		AHZEffectsWidgetStyle.SetValueInt(a_index)
		SetMenuOptionValue(a_option, WidgetStyles[a_index])
	endIf	

	if (a_option == _bottomAlignmentOID_M)
		AHZBottomWidgetRightAligned.SetValueInt(a_index)
		SetMenuOptionValue(a_option, AlignmentStyles[a_index])		
	endif	

	if (a_option == _inventoryAlignmentOID_M)
		AHZInventoryWidgetRightAligned.SetValueInt(a_index)
		SetMenuOptionValue(a_option, AlignmentStyles[a_index])		
	endif	

	if (a_option == _activationModeOID_M)
		AHZActivationMode.SetValueInt(a_index)
		SetMenuOptionValue(a_option, ActivationModes[a_index])		
	endif	
endEvent

; @implements SKI_ConfigBase
event OnOptionDefault(int a_option)
	{Called when resetting an option to its default value}
	if (a_option == _activationKeyMapOID_K)
		AHZHotKey.SetValueInt(-1);
		SetKeymapOptionValue(a_option, -1)
	endif
endEvent

; @implements SKI_ConfigBase
event OnOptionColorOpen(int a_option)
	{Called when a color option has been selected}
endEvent

; @implements SKI_ConfigBase
event OnOptionColorAccept(int a_option, int a_color)
	{Called when a new color has been accepted}
endEvent

; @implements SKI_ConfigBase
event OnOptionKeyMapChange(int a_option, int a_keyCode, string a_conflictControl, string a_conflictName)
	{Called when a key has been remapped}

	if (a_option == _activationKeyMapOID_K)

		bool continue = true

		if (a_conflictControl != "" && a_keyCode != -1)
			string msg

			if (a_conflictName != "")
				msg = "This key is already mapped to:\n'" + a_conflictControl + "'\n(" + a_conflictName + ")\n\nAre you sure you want to continue?"
			else
				msg = "This key is already mapped to:\n'" + a_conflictControl + "'\n\nAre you sure you want to continue?"
			endIf

			continue = ShowMessage(msg, true, "$Yes", "$No")
		endIf

		if (continue)
			AHZHotKey.SetValueInt(a_keyCode);
			SetKeymapOptionValue(a_option, a_keyCode)
		endIf
	endIf
endEvent

; @implements SKI_ConfigBase
event OnOptionHighlight(int a_option)
	{Called when the user highlights an option}
	
	; TODO: localization
	if (a_option == _toggle8OID_B)
		SetInfoText("If selected, shows an icon indicating if a targeted book has been read.")
	endif

	if (a_option == _toggle9OID_B)
		SetInfoText("If selected, shows the armor weight class for the targeted armor.")
	endif

	if (a_option == _toggle10OID_B)
		SetInfoText("If selected, shows the skill that a skill book teaches.")
	endif

	if (a_option == _toggle11OID_B)
		SetInfoText("If selected, shows the target's weight + the player's weight.")
	endif

	if (a_option == _toggle12OID_B)
		SetInfoText("If selected, The activation key toggles the widgets on and off.  Otherwise the activtion key activates the widgets while being held down")
	endif

	if (a_option == _toggle1OID_B)
		SetInfoText("If selected, shows the bottom bar that shows player damage, armor rating, weight, and gold.")
	endif		
	
	if (a_option == _toggle2OID_B)
		SetInfoText("If selected, shows the ingredient effects when targetting an object that can be harvested or an ingredient.")
	endif		
	
	if (a_option == _toggle3OID_B)
		SetInfoText("If selected, shows the effects when targetting an object such as enchanted items, scrolls, spell tomes, potions, and food.")
	endif

	if (a_option == _toggle5OID_B)
		SetInfoText("If selected, shows the current number of items in the player's inventory that match the targeted object. (Only when the player has more than one")
	endif	

	if (a_option == _sliderBottomX_OID_S)
		SetInfoText("Sets the X position of the bottom widget, 0% Left, 100% Right")
	endIf

	if (a_option == _sliderBottomY_OID_S)
		SetInfoText("Sets the y position of the bottom widget, 0% Top, 100% Bottom")
	endIf	

	if (a_option == _sliderSideX_OID_S)
		SetInfoText("Sets the X position of the ingredient widget, 0% Left, 100% Right")
	endIf		

	if (a_option == _sliderSideY_OID_S)
		SetInfoText("Sets the y position of the ingredient widget, 0% Top, 100% Bottom")
	endIf

	if (a_option == _sliderInventoryX_OID_S)
		SetInfoText("Sets the X position of the Inventory count widget, 0% Left, 100% Right")
	endIf		

	if (a_option == _sliderInventoryY_OID_S)
		SetInfoText("Sets the y position of the Inventory count widget, 0% Top, 100% Bottom")
	endIf

	if (a_option == _ingredientStyleOID_M)
		SetInfoText("Sets the style of the ingredient widget")
	endIf

	if (a_option == _effectsStyleOID_M)
		SetInfoText("Sets the style of the effects widget")
	endIf	

	if (a_option == _bottomAlignmentOID_M)
		SetInfoText("Sets alignment for the player's data widget: Left, Right, or Center")
	endif

	if (a_option == _inventoryAlignmentOID_M)
		SetInfoText("Sets alignment for the inventory's count widget: Left, Right, or Center")
	endif

	if (a_option == _activationKeyMapOID_K)
		SetInfoText("Sets the hotkey used to activate the widgets")
	endif

	if (a_option == _activationModeOID_M)
		SetInfoText("Sets the activation mode for the widgets:\nAuto-Always: Shows the widgets automatically when targetting an object,   Auto-No Combat: Shows the widgets automatically when targetting an object when the player is not in combat,   Hotkey Only: Only shows the widgets when toggled with the hotkey")
	endif

endEvent

; Private Functions ------------------------------------------------------------------------------------------
Function ToggleGlobalInt(GlobalVariable var)
	{Utility function to toggle global variables}
	if (var.GetValueInt() > 0)
		var.SetValueInt(0)
	else
		var.SetValueInt(1)
	endif	
EndFunction

; ---------------------GRIMY BUNYIP EDITS---------------------
IMPORT FISSFactory


STATE FISS_SAVE_PRESET
	EVENT OnSelectST()
		IF ShowMessage("Are you sure you want to save your current settings to a preset?")
			FISS_SAVE()
		ENDIF
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Saves your MoreHUD settings to a FISS xml file.")
	ENDEVENT
ENDSTATE

STATE FISS_LOAD_PRESET
	EVENT OnSelectST()
		IF ShowMessage("Are you sure you want load a preset?")
			FISS_LOAD()
			ShowMessage("Done Loading Preset")
		ENDIF
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Loads your MoreHUD settings from a FISS xml file if one exists.")
	ENDEVENT
ENDSTATE

FUNCTION FISS_LOAD()
	FISSInterface fiss = FISSFactory.getFISS()
	If !fiss
		debug.MessageBox("FISS not installed. Saving disabled")
		return
	endif
	
	fiss.beginLoad("MoreHUD.xml")

	IF fiss.loadBool("fissExists")
		AHZActivationMode.SetValueInt(fiss.loadInt("AHZActivationMode"))
		AHZIngredientsWidgetStyle.SetValueInt(fiss.loadInt("AHZIngredientsWidgetStyle"))
		AHZEffectsWidgetStyle.SetValueInt(fiss.loadInt("AHZEffectsWidgetStyle"))
		AHZBottomWidgetRightAligned.SetValueInt(fiss.loadInt("AHZBottomWidgetRightAligned"))
		AHZInventoryWidgetRightAligned.SetValueInt(fiss.loadInt("AHZInventoryWidgetRightAligned"))

		AHZHotKey.SetValueInt(fiss.loadInt("AHZHotKey"))
		AHZHotkeyToggles.SetValueInt(fiss.loadInt("AHZHotkeyToggles"))

		AHZShowBooksRead.SetValueInt(fiss.loadInt("AHZShowBooksRead"))
		AHZShowWeightClass.SetValueInt(fiss.loadInt("AHZShowWeightClass"))
		AHZShowBookSkill.SetValueInt(fiss.loadInt("AHZShowBookSkill"))
		AHZShowBottomWidget.SetValueInt(fiss.loadInt("AHZShowBottomWidget"))

		AHZShowIngredientWidget.SetValueInt(fiss.loadInt("AHZShowIngredientWidget"))
		AHZShowEffectsWidget.SetValueInt(fiss.loadInt("AHZShowEffectsWidget"))

		AHZShowInventoryCount.SetValueInt(fiss.loadInt("AHZShowInventoryCount"))

		AHZBottomWidgetXPercent.SetValue(fiss.loadFloat("AHZBottomWidgetXPercent"))
		AHZBottomWidgetYPercent.SetValue(fiss.loadFloat("AHZBottomWidgetYPercent"))

		AHZSideWidgetXPercent.SetValue(fiss.loadFloat("AHZSideWidgetXPercent"))
		AHZSideWidgetYPercent.SetValue(fiss.loadFloat("AHZSideWidgetYPercent"))

		AHZInventoryWidgetXPercent.SetValue(fiss.loadFloat("AHZInventoryWidgetXPercent"))
		AHZInventoryWidgetYPercent.SetValue(fiss.loadFloat("AHZInventoryWidgetYPercent"))
	ENDIF
	
	string loadResult = fiss.endLoad()
	IF loadResult != ""
		debug.Trace(loadResult)
	ENDIF
ENDFUNCTION

FUNCTION FISS_SAVE()
	FISSInterface fiss = FISSFactory.getFISS()
	If !fiss
		debug.MessageBox("FISS not installed. Saving disabled")	
		return
	endif
	
	fiss.beginSave("MoreHUD.xml","MoreHUD")
	
	fiss.saveBool("fissExists",true)
	fiss.saveInt("AHZActivationMode", AHZActivationMode.GetValueInt() )
	fiss.saveInt("AHZIngredientsWidgetStyle", AHZIngredientsWidgetStyle.GetValueInt() )
	fiss.saveInt("AHZEffectsWidgetStyle", AHZEffectsWidgetStyle.GetValueInt() )
	fiss.saveInt("AHZBottomWidgetRightAligned", AHZBottomWidgetRightAligned.GetValueInt() )
	fiss.saveInt("AHZInventoryWidgetRightAligned", AHZInventoryWidgetRightAligned.GetValueInt() )

	fiss.saveInt("AHZHotKey", AHZHotKey.GetValueInt() )
	fiss.saveInt("AHZHotkeyToggles", AHZHotkeyToggles.GetValueInt() )

	fiss.saveInt("AHZShowBooksRead", AHZShowBooksRead.GetValueInt() )
	fiss.saveInt("AHZShowWeightClass", AHZShowWeightClass.GetValueInt() )
	fiss.saveInt("AHZShowBookSkill", AHZShowBookSkill.GetValueInt() )
	fiss.saveInt("AHZShowBottomWidget", AHZShowBottomWidget.GetValueInt() )

	fiss.saveInt("AHZShowIngredientWidget", AHZShowIngredientWidget.GetValueInt() )
	fiss.saveInt("AHZShowEffectsWidget", AHZShowEffectsWidget.GetValueInt() )

	fiss.saveInt("AHZShowInventoryCount", AHZShowInventoryCount.GetValueInt() )

	fiss.saveFloat("AHZBottomWidgetXPercent", AHZBottomWidgetXPercent.GetValue() )
	fiss.saveFloat("AHZBottomWidgetYPercent", AHZBottomWidgetYPercent.GetValue() )

	fiss.saveFloat("AHZSideWidgetXPercent", AHZSideWidgetXPercent.GetValue() )
	fiss.saveFloat("AHZSideWidgetYPercent", AHZSideWidgetYPercent.GetValue() )

	fiss.saveFloat("AHZInventoryWidgetXPercent", AHZInventoryWidgetXPercent.GetValue() )
	fiss.saveFloat("AHZInventoryWidgetYPercent", AHZInventoryWidgetYPercent.GetValue() )
	
	string saveResult = fiss.endSave()
	
	IF saveResult != ""
		debug.Trace(saveResult)
	ENDIF
ENDFUNCTION
