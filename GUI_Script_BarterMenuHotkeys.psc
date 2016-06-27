Scriptname GUI_Script_BarterMenuHotkeys extends activemagiceffect  

Import UI
Import Game
GUI_MenuMain PROPERTY MenuMain AUTO
QUEST PROPERTY UILib AUTO

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	RegisterForMenu("BarterMenu")
ENDEVENT

EVENT OnPlayerLoadGame()
	RegisterForMenu("BarterMenu")
ENDEVENT

EVENT OnMenuOpen(String MenuName)
	RegisterForKey(MenuMain.GUI_Hotkey_BarterSellOne)
	RegisterForKey(MenuMain.GUI_Hotkey_InspectKey)
ENDEVENT

EVENT OnMenuClose(String MenuName)
	UnregisterForAllKeys()
ENDEVENT

EVENT OnKeyDown(Int KeyCode)
	IF !isMenuOpen("Console") && !isMenuOpen("CustomMenu") && !((UILib as FORM) as UILIB_GRIMY).IsMenuOpen()
		IF KeyCode == MenuMain.GUI_Hotkey_BarterSellOne
			InvokeInt("BarterMenu", "_root.Menu_mc.doTransaction", 1)
		ELSE
			FORM akForm = GetFormEx(GetInt("BarterMenu", "_root.Menu_mc.inventoryLists.itemList.selectedEntry.formId"))
			MenuMain.inspectForm(akForm)
		ENDIF
	ENDIF
ENDEVENT 