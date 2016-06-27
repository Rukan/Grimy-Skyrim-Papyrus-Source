scriptname iHUDSkyUIConfigMenuScript extends SKI_ConfigBase

GlobalVariable Property iHUDEnabled Auto
GlobalVariable Property iHUDCrosshairOnActivate auto
GlobalVariable Property iHUDCrosshairOnSpell auto
GlobalVariable Property iHUDCrosshairOnRanged auto
GlobalVariable Property iHUDCrosshairOnMelee auto
GlobalVariable Property iHUDCrosshairAlwaysVisible Auto

GlobalVariable Property iHUDWidgetActiveEffectsOnKey Auto
GlobalVariable Property iHUDWidgetActiveEffectsOnCombat Auto
GlobalVariable Property iHUDWidgetActiveEffectsOnAlways Auto

GlobalVariable Property iHUDWidgetLinkAll Auto

GlobalVariable Property iHUDSneakMeterEnabled Auto

GlobalVariable Property iHUDCrosshairAlpha Auto

GlobalVariable Property iHUDCompassAlpha Auto
GlobalVariable Property iHUDShoutMeterHide Auto

GlobalVariable Property iHUDEnemyHealthEnabled Auto

GlobalVariable Property iHUDStaminaAlpha Auto
GlobalVariable Property iHUDMagickaAlpha Auto
GlobalVariable Property iHUDHealthAlpha Auto

GlobalVariable Property iHUDForceCrosshairEnabled Auto
GlobalVariable Property iHUDMagickaFastFade auto
GlobalVariable Property iHUDStaminaFastFade auto
GlobalVariable Property iHUDHealthFastFade auto

GlobalVariable Property iHUDKey Auto
GlobalVariable Property iHUDKeyActionToggle Auto

GlobalVariable Property iHUDUpdateDelay auto


iHUDControlScript Property iHUDControl Auto
iHUDEnemyHealthScript Property iHUDEnemyHealth Auto
iHUDKeyScript Property iHUDKeyController Auto

; OIDs (T:Text B:Toggle S:Slider M:Menu, C:Color, K:Key)
int			_myTextOID_T
int			_myToggle_S
int			_mySliderOID_S
int			_myMenuOID_S
int			_myColorOID_S
int			_myKeyOID_S

int _compassAlpha_S
int _crosshairAlpha_S
int _magickaAlpha_S
int _healthAlpha_S
int _staminaAlpha_S
int _pollDelay_S

int _active_B
int _stealthMeterEnabled_B
int _enemyHealthMeterEnabled_B
int _shoutMeterHide_B
int _forceCrosshairHidden_B
int _magickaFastFade_B
int _healthFastFade_B
int _staminaFastFade_B
int _widgetActiveEffectsToggle_B
int _widgetActiveEffectsCombat_B
int _widgetActiveEffectsAlways_B
int _widgetLinkALL_B

int _crosshairAlwaysVisible_B
int _crosshairActivateOnActivate_B
int _crosshairActivateOnMelee_B
int _crosshairActivateOnMissile_B
int _crosshairActivateOnSpell_B

int _toggleHotkey_K
int _toggleHotkeyActionToggle_B

String[] enabledStates

; State

; ...

; INITIALIZATION ----------------------------------------------------------------------------------


event OnConfigInit()
	setPages()
endEvent

Function setPages()
	Pages = new String[4]
	pages[0] = "Activation"
	pages[1] = "Options"
	pages[2] = "Transparencies"
	pages[3] = "Presets"
EndFunction

Function toggle(GlobalVariable value)
	if value.getValueInt() == 0
		value.setValueInt(1)
	else
		value.setValueInt(0)
	endIf
EndFunction

; @implements SKI_ConfigBase
event OnPageReset(string a_page)
	setPages()
	
	SetCursorFillMode(TOP_TO_BOTTOM)
	if (a_page == "Activation")
		_active_B = AddToggleOption("iHUD Active", iHUDEnabled.getValueInt())
		
		if (iHUDEnabled.getValueInt() == 1)
			AddEmptyOption()
			
			AddHeaderOption("Compass Activation")
			_toggleHotkey_K = AddKeyMapOption("iHUD hotkey", iHUDKey.getValueInt())
			_toggleHotkeyActionToggle_B = AddToggleOption("Key press toggles", iHUDKeyActionToggle.getValueInt())
			
			AddEmptyOption()
			
			AddHeaderOption("SkyUI Active Effects")
			_widgetActiveEffectsAlways_B = AddToggleOption("Active Effects ALWAYS On", iHUDWidgetActiveEffectsOnAlways.getValueInt())
			_widgetActiveEffectsToggle_B = AddToggleOption("Active Effects on key", iHUDWidgetActiveEffectsOnKey.getValueInt(), iHUDWidgetActiveEffectsOnAlways.getValueInt())	
			
			_widgetActiveEffectsCombat_B = AddToggleOption("Active Effects on combat", iHUDWidgetActiveEffectsOnCombat.getValueInt(),iHUDWidgetActiveEffectsOnAlways.getValueInt())
			
			AddEmptyOption()
			_widgetLinkALL_B = AddToggleOption("Link ALL SkyUI Widgets", iHUDWidgetLinkAll.getValueInt())	
			

			
			SetCursorPosition(1)
			
			AddHeaderOption("Crosshair Activation")	
			_crosshairAlwaysVisible_B  = AddToggleOption("Crosshair ALWAYS ON", iHUDCrosshairAlwaysVisible.getValueInt())
			
			_crosshairActivateOnActivate_B  = AddToggleOption("When looking at activatable", iHUDCrosshairOnActivate.getValueInt(), iHUDCrosshairAlwaysVisible.getValueInt())
			
			_crosshairActivateOnMelee_B  = AddToggleOption("Wielding melee weapon", iHUDCrosshairOnMelee.getValueInt(), iHUDCrosshairAlwaysVisible.getValueInt())
			
			_crosshairActivateOnMissile_B  = AddToggleOption("Wielding ranged weapon", iHUDCrosshairOnRanged.getValueInt(), iHUDCrosshairAlwaysVisible.getValueInt())
			
			_crosshairActivateOnSpell_B  = AddToggleOption("Wielding spell", iHUDCrosshairOnSpell.getValueInt(), iHUDCrosshairAlwaysVisible.getValueInt())
		endif		
	elseif (a_page == "Options" && iHUDEnabled.getValueInt() == 1)	
		_stealthMeterEnabled_B = AddToggleOption("Stealth indicator enabled", iHUDSneakMeterEnabled.getValueInt())
		_enemyHealthMeterEnabled_B = AddToggleOption("Enemy health indicator enabled", iHUDEnemyHealthEnabled.getValueInt())
		_shoutMeterHide_B = AddToggleOption("Hide shout meter with compass", iHUDShoutMeterHide.getValueInt())

		AddEmptyOption()	
		_forceCrosshairHidden_B = AddToggleOption("Force crosshair to hide", iHUDForceCrosshairEnabled.getValueInt())
		
		AddEmptyOption()	
		_magickaFastFade_B = AddToggleOption("Enable fast fade of magicka", iHUDMagickaFastFade.getValueInt())		
		_healthFastFade_B = AddToggleOption("Enable fast fade of health", iHUDHealthFastFade.getValueInt())		
		_staminaFastFade_B = AddToggleOption("Enable fast fade of stamina", iHUDStaminaFastFade.getValueInt())	

		AddEmptyOption()	
		_pollDelay_S = AddSliderOption("Refresh Rate", iHUDUpdateDelay.getValue(), "{2} s")		
	elseif (a_page == "Transparencies" && iHUDEnabled.getValueInt() == 1)
		_compassAlpha_S	= AddSliderOption("Compass", iHUDCompassAlpha.getValueInt())
		AddEmptyOption()	
		
		_crosshairAlpha_S	= AddSliderOption("Crosshair", iHUDCrosshairAlpha.getValueInt())
		AddEmptyOption()	
		
		_magickaAlpha_S	= AddSliderOption("Magicka", iHUDMagickaAlpha.getValueInt())
		_healthAlpha_S	= AddSliderOption("Health", iHUDHealthAlpha.getValueInt())
		_staminaAlpha_S	= AddSliderOption("Stamina", iHUDStaminaAlpha.getValueInt())
	ELSEIF (a_page == "Presets")
		savePreset_T = AddTextOption("Save Preset","GO!")
		loadPreset_T = AddTextOption("Load Preset","GO!") 
	endif
endEvent

; @implements SKI_ConfigBase
event OnOptionHighlight(int a_option)
	IF (a_option == savePreset_T )
		SetInfoText("Saves your iHUD settings to a FISS xml file")
	ELSEIF (a_option == loadPreset_T )
		SetInfoText("Loads your iHUD settings from FISS xml if one exists.\nRunning SkyTweak's FISS load function will also instruct iHUD to load its settings as well.")
	ENDIF
endEvent

; @implements SKI_ConfigBase
event OnOptionSelect(int a_option)
	string page = CurrentPage

	if (a_option == _active_B)
		toggle(iHUDEnabled)
		SetToggleOptionValue(a_option, iHUDEnabled.getValueInt())
		
		if iHUDEnabled.getValueInt()
			iHUDKeyController.reset()
			iHUDControl.reset()
		else
			iHUDKeyController.deactivate()
			iHUDControl.deactivate()
		endif
		
		ForcePageReset()
	elseif (a_option == _toggleHotkeyActionToggle_B)
		toggle(iHUDKeyActionToggle)
		SetToggleOptionValue(a_option, iHUDKeyActionToggle.getValueInt())
	elseif (a_option == _crosshairAlwaysVisible_B)
		toggle(iHUDCrosshairAlwaysVisible)
		SetToggleOptionValue(a_option, iHUDCrosshairAlwaysVisible.getValueInt())	

		SetOptionFlags(_crosshairActivateOnActivate_B, iHUDCrosshairAlwaysVisible.getValueInt())
		SetOptionFlags(_crosshairActivateOnMelee_B, iHUDCrosshairAlwaysVisible.getValueInt())
		SetOptionFlags(_crosshairActivateOnMissile_B, iHUDCrosshairAlwaysVisible.getValueInt())
		SetOptionFlags(_crosshairActivateOnSpell_B, iHUDCrosshairAlwaysVisible.getValueInt())	
	elseif (a_option == _stealthMeterEnabled_B)
		toggle(iHUDSneakMeterEnabled)
		SetToggleOptionValue(a_option, iHUDSneakMeterEnabled.getValueInt())
	elseif (a_option == _enemyHealthMeterEnabled_B)		
		toggle(iHUDEnemyHealthEnabled)
		SetToggleOptionValue(a_option, iHUDEnemyHealthEnabled.getValueInt())
		
		iHUDEnemyHealth.processEnemyHealth()
	elseif (a_option == _shoutMeterHide_B)		
		toggle(iHUDShoutMeterHide)
		SetToggleOptionValue(a_option, iHUDShoutMeterHide.getValueInt())
	elseif (a_option == _crosshairActivateOnActivate_B)		
		toggle(iHUDCrosshairOnActivate)
		SetToggleOptionValue(a_option, iHUDCrosshairOnActivate.getValueInt())	
	elseif (a_option == _crosshairActivateOnMelee_B)		
		toggle(iHUDCrosshairOnMelee)
		SetToggleOptionValue(a_option, iHUDCrosshairOnMelee.getValueInt())	
	elseif (a_option == _crosshairActivateOnMissile_B)		
		toggle(iHUDCrosshairOnRanged)
		SetToggleOptionValue(a_option, iHUDCrosshairOnRanged.getValueInt())	
	elseif (a_option == _crosshairActivateOnSpell_B)		
		toggle(iHUDCrosshairOnSpell)
		SetToggleOptionValue(a_option, iHUDCrosshairOnSpell.getValueInt())	
	elseif (a_option == _forceCrosshairHidden_B)		
		toggle(iHUDForceCrosshairEnabled)
		SetToggleOptionValue(a_option, iHUDForceCrosshairEnabled.getValueInt())	
	elseif (a_option == _magickaFastFade_B)		
		toggle(iHUDMagickaFastFade)
		SetToggleOptionValue(a_option, iHUDMagickaFastFade.getValueInt())	
	elseif (a_option == _healthFastFade_B)		
		toggle(iHUDHealthFastFade)
		SetToggleOptionValue(a_option, iHUDHealthFastFade.getValueInt())	
	elseif (a_option == _staminaFastFade_B)		
		toggle(iHUDStaminaFastFade)
		SetToggleOptionValue(a_option, iHUDStaminaFastFade.getValueInt())	
	elseif (a_option == _widgetActiveEffectsToggle_B)
		toggle(iHUDWidgetActiveEffectsOnKey)
		SetToggleOptionValue(a_option, iHUDWidgetActiveEffectsOnKey.getValueInt())	
	elseif (a_option == _widgetActiveEffectsCombat_B)
		toggle(iHUDWidgetActiveEffectsOnCombat)
		SetToggleOptionValue(a_option, iHUDWidgetActiveEffectsOnCombat.getValueInt())	
	elseif (a_option == _widgetActiveEffectsAlways_B)
		toggle(iHUDWidgetActiveEffectsOnAlways)
		SetToggleOptionValue(a_option, iHUDWidgetActiveEffectsOnAlways.getValueInt())	
		
		SetOptionFlags(_widgetActiveEffectsToggle_B, iHUDWidgetActiveEffectsOnAlways.getValueInt())
		SetOptionFlags(_widgetActiveEffectsCombat_B, iHUDWidgetActiveEffectsOnAlways.getValueInt())
	elseif (a_option == _widgetLinkALL_B)
		toggle(iHUDWidgetLinkAll)
		SetToggleOptionValue(a_option, iHUDWidgetLinkAll.getValueInt())
		iHUDControl.reset()
	ELSEIF (a_option == savePreset_T )
		IF ShowMessage("Are you sure you want to save a preset?")
			FISS_SAVE()
			ShowMessage("Done saving a preset to FISS")
		ENDIF
	ELSEIF (a_option == loadPreset_T )
		IF ShowMessage("Are you sure you want to load a preset?")
			FISS_LOAD()
			ShowMessage("Done loading a FISS preset")
		ENDIF
	endif		
endEvent

; @implements SKI_ConfigBase
event OnOptionDefault(int a_option)
	{Called when resetting an option to its default value}

	string page = CurrentPage
	; ...
endEvent

; @implements SKI_ConfigBase
event OnOptionSliderOpen(int a_option)
	string page = CurrentPage

	if (page == "Options")
		if (a_option == _pollDelay_S)
			SetSliderDialogStartValue(iHUDUpdateDelay.getValue())
			SetSliderDialogDefaultValue(0.5)
			SetSliderDialogRange(0.01, 1.0)
			SetSliderDialogInterval(0.01)		
		endIf
	elseif (page == "Transparencies")
		if (a_option == _compassAlpha_S)
			SetSliderDialogStartValue(iHUDCompassAlpha.getValueInt())
			SetSliderDialogDefaultValue(100)
			SetSliderDialogRange(0, 150)
			SetSliderDialogInterval(1)
		elseif (a_option == _crosshairAlpha_S)
			SetSliderDialogStartValue(iHUDCrosshairAlpha.getValueInt())
			SetSliderDialogDefaultValue(100)
			SetSliderDialogRange(0, 150)
			SetSliderDialogInterval(1)
		elseif (a_option == _magickaAlpha_S)
			SetSliderDialogStartValue(iHUDMagickaAlpha.getValueInt())
			SetSliderDialogDefaultValue(100)
			SetSliderDialogRange(0, 150)
			SetSliderDialogInterval(1)
		elseif (a_option == _healthAlpha_S)
			SetSliderDialogStartValue(iHUDHealthAlpha.getValueInt())
			SetSliderDialogDefaultValue(100)
			SetSliderDialogRange(0, 150)
			SetSliderDialogInterval(1)
		elseif (a_option == _staminaAlpha_S)
			SetSliderDialogStartValue(iHUDStaminaAlpha.getValueInt())
			SetSliderDialogDefaultValue(100)
			SetSliderDialogRange(0, 150)
			SetSliderDialogInterval(1)
		endif
	endif
endEvent

; @implements SKI_ConfigBase
event OnOptionSliderAccept(int a_option, float a_value)
	string page = CurrentPage

	if (page == "Options")
		if (a_option == _pollDelay_S)
			SetSliderOptionValue(a_option, a_value, "{2} s")
			iHUDUpdateDelay.setValue(a_value)
		endif
	elseif (page == "Transparencies")
		if (a_option == _compassAlpha_S)
			SetSliderOptionValue(a_option, a_value)
			iHUDCompassAlpha.setValue(a_value)
		elseif (a_option == _crosshairAlpha_S)
			SetSliderOptionValue(a_option, a_value)
			iHUDCrosshairAlpha.setValue(a_value)
		elseif (a_option == _magickaAlpha_S)
			SetSliderOptionValue(a_option, a_value)
			iHUDMagickaAlpha.setValue(a_value)
		elseif (a_option == _healthAlpha_S)
			SetSliderOptionValue(a_option, a_value)
			iHUDHealthAlpha.setValue(a_value)
		elseif (a_option == _staminaAlpha_S)
			SetSliderOptionValue(a_option, a_value)
			iHUDStaminaAlpha.setValue(a_value)
		endif
	endif
endEvent

; @implements SKI_ConfigBase
event OnOptionMenuOpen(int a_option)
	{Called when a menu option has been selected}

	string page = CurrentPage
	; ...
endEvent

; @implements SKI_ConfigBase
event OnOptionMenuAccept(int a_option, int a_index)
	{Called when a menu entry has been accepted}

	string page = CurrentPage
	; ...
endEvent

; @implements SKI_ConfigBase
event OnOptionColorOpen(int a_option)
	{Called when a color option has been selected}

	string page = CurrentPage
	; ...
endEvent

; @implements SKI_ConfigBase
event OnOptionColorAccept(int a_option, int a_color)
	{Called when a new color has been accepted}

	string page = CurrentPage
	; ...
endEvent

; @implements SKI_ConfigBase
event OnOptionKeyMapChange(int a_option, int a_keyCode, string a_conflictControl, string a_conflictName)
	string page = CurrentPage

	; -------------------------------------------------------
	if (page == "Activation")
		if (a_option == _toggleHotkey_K)
			SetKeyMapOptionValue(a_option, a_keyCode)
			iHUDKey.setValueInt(a_keyCode) 
			iHUDKeyController.reset()
		endIf
	endIf
endEvent

; ---------------------GRIMY BUNYIP EDITS---------------------
IMPORT FISSFactory
int savePreset_T
int loadPreset_T

FUNCTION FISS_LOAD()
	FISSInterface fiss = FISSFactory.getFISS()
	If !fiss
		debug.MessageBox("FISS not installed. Saving disabled")
		return
	endif
	
	fiss.beginLoad("iHUD.xml")

	IF fiss.loadBool("fissExists")
		iHUDKey.setValueInt(fiss.loadInt("iHUDKey") )
		iHUDKeyActionToggle.setValueInt(fiss.loadInt("iHUDKeyActionToggle") )
		iHUDWidgetActiveEffectsOnAlways.setValueInt(fiss.loadInt("iHUDWidgetActiveEffectsOnAlways") )
		iHUDWidgetActiveEffectsOnKey.setValueInt(fiss.loadInt("iHUDWidgetActiveEffectsOnKey") )
		iHUDWidgetActiveEffectsOnCombat.setValueInt(fiss.loadInt("iHUDWidgetActiveEffectsOnCombat") )
		iHUDWidgetLinkAll.setValueInt(fiss.loadInt("iHUDWidgetLinkAll") )
		iHUDCrosshairAlwaysVisible.setValueInt(fiss.loadInt("iHUDCrosshairAlwaysVisible") )
		iHUDCrosshairOnActivate.setValueInt(fiss.loadInt("iHUDCrosshairOnActivate") )
		iHUDCrosshairOnMelee.setValueInt(fiss.loadInt("iHUDCrosshairOnMelee") )
		iHUDCrosshairOnRanged.setValueInt(fiss.loadInt("iHUDCrosshairOnRanged") )
		iHUDCrosshairOnSpell.setValueInt(fiss.loadInt("iHUDCrosshairOnSpell") )
		iHUDSneakMeterEnabled.setValueInt(fiss.loadInt("iHUDSneakMeterEnabled") )
		iHUDEnemyHealthEnabled.setValueInt(fiss.loadInt("iHUDEnemyHealthEnabled") )
		iHUDShoutMeterHide.setValueInt(fiss.loadInt("iHUDShoutMeterHide") )
		iHUDForceCrosshairEnabled.setValueInt(fiss.loadInt("iHUDForceCrosshairEnabled") )
		iHUDMagickaFastFade.setValueInt(fiss.loadInt("iHUDMagickaFastFade") )
		iHUDHealthFastFade.setValueInt(fiss.loadInt("iHUDHealthFastFade") )
		iHUDStaminaFastFade.setValueInt(fiss.loadInt("iHUDStaminaFastFade") )
		iHUDUpdateDelay.setValue(fiss.loadFloat("iHUDUpdateDelay") )
		iHUDCompassAlpha.setValueInt(fiss.loadInt("iHUDCompassAlpha") )
		iHUDCrosshairAlpha.setValueInt(fiss.loadInt("iHUDCrosshairAlpha") )
		iHUDMagickaAlpha.setValueInt(fiss.loadInt("iHUDMagickaAlpha") )
		iHUDHealthAlpha.setValueInt(fiss.loadInt("iHUDHealthAlpha") )
		iHUDStaminaAlpha.setValueInt(fiss.loadInt("iHUDStaminaAlpha") )
		
		if iHUDEnabled.getValueInt()
			iHUDKeyController.reset()
			iHUDControl.reset()
		else
			iHUDKeyController.deactivate()
			iHUDControl.deactivate()
		endif

		SetOptionFlags(_crosshairActivateOnActivate_B, iHUDCrosshairAlwaysVisible.getValueInt())
		SetOptionFlags(_crosshairActivateOnMelee_B, iHUDCrosshairAlwaysVisible.getValueInt())
		SetOptionFlags(_crosshairActivateOnMissile_B, iHUDCrosshairAlwaysVisible.getValueInt())
		SetOptionFlags(_crosshairActivateOnSpell_B, iHUDCrosshairAlwaysVisible.getValueInt())

		iHUDEnemyHealth.processEnemyHealth()

		SetOptionFlags(_widgetActiveEffectsToggle_B, iHUDWidgetActiveEffectsOnAlways.getValueInt())
		SetOptionFlags(_widgetActiveEffectsCombat_B, iHUDWidgetActiveEffectsOnAlways.getValueInt())

		iHUDControl.reset()
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
	
	fiss.beginSave("iHUD.xml","iHUD")
	
	fiss.saveBool("fissExists",true)
	fiss.saveInt("iHUDKey", iHUDKey.getValueInt())
	fiss.saveInt("iHUDKeyActionToggle", iHUDKeyActionToggle.getValueInt())
	fiss.saveInt("iHUDWidgetActiveEffectsOnAlways", iHUDWidgetActiveEffectsOnAlways.getValueInt())
	fiss.saveInt("iHUDWidgetActiveEffectsOnKey", iHUDWidgetActiveEffectsOnKey.getValueInt())
	fiss.saveInt("iHUDWidgetActiveEffectsOnCombat", iHUDWidgetActiveEffectsOnCombat.getValueInt())
	fiss.saveInt("iHUDWidgetLinkAll", iHUDWidgetLinkAll.getValueInt())
	fiss.saveInt("iHUDCrosshairAlwaysVisible", iHUDCrosshairAlwaysVisible.getValueInt())
	fiss.saveInt("iHUDCrosshairOnActivate", iHUDCrosshairOnActivate.getValueInt())
	fiss.saveInt("iHUDCrosshairOnMelee", iHUDCrosshairOnMelee.getValueInt())
	fiss.saveInt("iHUDCrosshairOnRanged", iHUDCrosshairOnRanged.getValueInt())
	fiss.saveInt("iHUDCrosshairOnSpell", iHUDCrosshairOnSpell.getValueInt())
	fiss.saveInt("iHUDSneakMeterEnabled", iHUDSneakMeterEnabled.getValueInt())
	fiss.saveInt("iHUDEnemyHealthEnabled", iHUDEnemyHealthEnabled.getValueInt())
	fiss.saveInt("iHUDShoutMeterHide", iHUDShoutMeterHide.getValueInt())
	fiss.saveInt("iHUDForceCrosshairEnabled", iHUDForceCrosshairEnabled.getValueInt())
	fiss.saveInt("iHUDMagickaFastFade", iHUDMagickaFastFade.getValueInt())
	fiss.saveInt("iHUDHealthFastFade", iHUDHealthFastFade.getValueInt())
	fiss.saveInt("iHUDStaminaFastFade", iHUDStaminaFastFade.getValueInt())
	fiss.saveFloat("iHUDUpdateDelay", iHUDUpdateDelay.getValue())
	fiss.saveInt("iHUDCompassAlpha", iHUDCompassAlpha.getValueInt())
	fiss.saveInt("iHUDCrosshairAlpha", iHUDCrosshairAlpha.getValueInt())
	fiss.saveInt("iHUDMagickaAlpha", iHUDMagickaAlpha.getValueInt())
	fiss.saveInt("iHUDHealthAlpha", iHUDHealthAlpha.getValueInt())
	fiss.saveInt("iHUDStaminaAlpha", iHUDStaminaAlpha.getValueInt())

	
	string saveResult = fiss.endSave()
	
	IF saveResult != ""
		debug.Trace(saveResult)
	ENDIF
ENDFUNCTION