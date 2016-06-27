Scriptname GUI_Script_ContainerMenuHotkeys extends activemagiceffect  

Import UI
Import Game
GUI_MenuMain PROPERTY MenuMain AUTO
QUEST PROPERTY UILib AUTO
String[] Property OptionList Auto
FORM PROPERTy GUI_NullItem AUTO

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	RegisterForMenu("ContainerMenu")
ENDEVENT

EVENT OnPlayerLoadGame()
	RegisterForMenu("ContainerMenu")
ENDEVENT

EVENT OnMenuOpen(String MenuName)
	RegisterForKey(MenuMain.GUI_Hotkey_Container)
	RegisterForKey(MenuMain.GUI_Hotkey_InspectKey)
ENDEVENT

EVENT OnMenuClose(String MenuName)
	UnregisterForAllKeys()
ENDEVENT

EVENT OnKeyDown(Int KeyCode)
	IF !isMenuOpen("Console") && !isMenuOpen("CustomMenu") && !((UILib as FORM) as UILIB_GRIMY).IsMenuOpen()
		FORM akForm = GetFormEx(GetInt("ContainerMenu", "_root.Menu_mc.inventoryLists.itemList.selectedEntry.formId"))
		IF KeyCode == MenuMain.GUI_Hotkey_Container
			OBJECTREFERENCE tempRef = GetCurrentCrosshairRef()
			IF tempRef && tempRef AS ACTOR
				ACTOR tempActor = tempRef AS ACTOR
				INT index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Container Menu Hotkeys", OptionList, 0, 0)
				IF index == 1 ; equip item
					IF tempActor.GetItemCount(akForm) > 0 
						tempActor.EquipItem(akForm,false)
						IF !tempActor.IsOnMount()
							tempActor.QueueNiNodeUpdate()
						ENDIF
					ELSE 
						Debug.Notification(tempActor.GetDisplayName() + " doesn't have any of that item")
					ENDIF
				ELSEIF index == 2 ; equip item prevent unequip
					IF tempActor.GetItemCount(akForm) > 0 
						tempActor.EquipItem(akForm,true)
						IF !tempActor.IsOnMount()
							tempActor.QueueNiNodeUpdate()
						ENDIF
					ELSE
						Debug.Notification(tempActor.GetDisplayName() + " doesn't have any of that item")
					ENDIF
				ELSEIF index == 3 ; equip item
					IF tempActor.GetItemCount(akForm) > 0 
						tempActor.UnequipItem(akForm,false)
						IF !tempActor.IsOnMount()
							tempActor.QueueNiNodeUpdate()
						ENDIF
					ELSE 
						Debug.Notification(tempActor.GetDisplayName() + " doesn't have any of that item")
					ENDIF
				ELSEIF index == 4 ; equip item prevent unequip
					IF tempActor.GetItemCount(akForm) > 0 
						tempActor.UnequipItem(akForm,true)
						IF !tempActor.IsOnMount()
							tempActor.QueueNiNodeUpdate()
						ENDIF
						Debug.Notification("Note: Prevent Unequip will not work on all many item types for NPCs.")
					ELSE
						Debug.Notification(tempActor.GetDisplayName() + " doesn't have any of that item")
					ENDIF
				ELSEIF index == 5 && akForm AS BOOK && (akForm AS BOOK).GetSpell() ; teach spell tome
					IF tempActor.GetItemCount(akForm) > 0 
						tempActor.RemoveItem(akForm)
						tempActor.AddSpell((akForm AS BOOK).GetSpell())
						;PlayerRef.AddItem(GUI_NullItem,1,true)
						;PlayerRef.RemoveItem(GUI_NullItem,1,true)
					ELSE
						Debug.Notification(tempActor.GetDisplayName() + " doesn't any of that spell tome.")
					ENDIF
				ENDIF
			ELSE 
				Debug.Notification("You must be looking at an NPC to use this feature.")
			ENDIF
		ELSE
			MenuMain.inspectForm(akForm)
		ENDIF
	ENDIF
ENDEVENT 