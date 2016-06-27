Scriptname GUISE_Script_CraftingMenuHotkeys extends activemagiceffect  

ACTOR PROPERTY PlayerRef AUTO
IMPORT UI
QUEST PROPERTY UILib AUTO
STRING[] PROPERTY WateredDownList AUTO
PERK PROPERTY GVC_Perk_A12_EfficientFiltering AUTO

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	RegisterForMenu("Crafting Menu")
ENDEVENT

EVENT OnPlayerLoadGame()
	RegisterForMenu("Crafting Menu")
ENDEVENT

GLOBALVARIABLE PROPERTY GUISE_Hotkey_WateredDown AUTO
EVENT OnMenuOpen(String MenuName)
	RegisterForKey(GUISE_Hotkey_WateredDown.GetValueInt())
ENDEVENT

EVENT OnMenuClose(String MenuName)
	UnregisterForAllKeys()
ENDEVENT

EVENT OnKeyDown(Int KeyCode)
	IF !isMenuOpen("Console") && !isMenuOpen("CustomMenu") && !((UILib as FORM) as UILIB_GRIMY).IsMenuOpen()
		IF ( PlayerRef.HasPerk(GVC_Perk_A12_EfficientFiltering) )
			FLOAT Result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Adjust Watered Down", WateredDownList, GVC_Perk_A12_EfficientFiltering.GetNthEntryValue(0,0) AS INT - 1, GVC_Perk_A12_EfficientFiltering.GetNthEntryValue(0,0) AS INT - 1) AS FLOAT + 1.0
			GVC_Perk_A12_EfficientFiltering.SetNthEntryValue(1,0,0.6 / Result + 0.4)
			GVC_Perk_A12_EfficientFiltering.SetNthEntryValue(0,0,Result)
		ENDIF
	ENDIF
ENDEVENT