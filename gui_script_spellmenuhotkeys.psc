scriptName GUI_Script_SpellMenuHotkeys extends activemagiceffect

quest property UILib auto
gui_menumain property MenuMain auto
actor property PlayerRef auto
message property GUI_DeleteSpellWarning auto
String[] Property equipSlots Auto

Event OnMenuOpen(String MenuName)
	RegisterForKey(MenuMain.GUI_Hotkey_HotcastSpellSelect)
	RegisterForKey(MenuMain.GUI_Hotkey_ForceEquip)
	RegisterForKey(MenuMain.GUI_Hotkey_ForgetSpellKey)
	RegisterForKey(MenuMain.GUI_Hotkey_AddSpellToMark)
	RegisterForKey(MenuMain.GUI_Hotkey_InspectKey)
EndEvent

Event OnMenuClose(String MenuName)
	UnregisterForAllKeys()
EndEvent

form property GUI_NullItem Auto
Event OnKeyDown(Int KeyCode)
	if !ui.isMenuOpen("Console") && !ui.isMenuOpen("Custom") && !((UILib as FORM) as UILIB_GRIMY).IsMenuOpen()
		form akForm = game.GetFormEx(ui.GetInt("MagicMenu", "_root.Menu_mc.InventoryLists.itemList.selectedEntry.formId"))
		if KeyCode == MenuMain.GUI_Hotkey_HotcastSpellSelect
			Int Result = ((UILib as form) as uilib_grimy).ShowList("Hotcast Slots", MenuMain.getSpellNames(), 0, 0)
			if Result >= 0 && Result < 12 && (akForm as spell) as Bool
				MenuMain.setSpell(Result, akForm as spell)
			endIf
		ElseIf KeyCode == MenuMain.GUI_Hotkey_ForgetSpellKey
			if (akform as spell) as Bool && GUI_DeleteSpellWarning.Show() == 0
				PlayerRef.RemoveSpell(akform as spell)
				PlayerRef.AddItem(GUI_NullItem,1,true)
				PlayerRef.RemoveItem(GUI_NullItem,1,true)
			endIf
		ElseIf KeyCode == MenuMain.GUI_Hotkey_ForceEquip
			Int Result = ((UILib as form) as uilib_grimy).ShowList("Force equip to which slot?", equipSlots, 0, 0)
			If ( Result <= 2 ) && ( Result >= 0 )
				PlayerRef.EquipSpell(akForm as Spell,Result)
			EndIf
		ElseIf KeyCode == MenuMain.GUI_Hotkey_AddSpellToMark
			Int Result = ((UILib as form) as uilib_grimy).ShowList("Add Spell to Which Mark?", MenuMain.getObjectListString(), 0, 0)
			If MenuMain.objectList[Result] As Actor
				(MenuMain.objectList[Result] As Actor).AddSpell(akform as Spell)
			Else
				Debug.Notification("That is not an actor")
			EndIf
		Else
			MenuMain.inspectForm(akForm)
		endIf
	endIf
EndEvent

Event OnEffectStart(actor akTarget, actor akCaster)
	RegisterForMenu("MagicMenu")
EndEvent

Event OnPlayerLoadGame()
	RegisterForMenu("MagicMenu")
EndEvent
