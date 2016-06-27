Scriptname GBS_Script_SpellMenuHotkeys extends activemagiceffect  

QUEST PROPERTY UILib AUTO
SPELL PROPERTY GBS_Spell01 AUTO
SPELL PROPERTY GBS_Spell02 AUTO
SPELL PROPERTY GBS_Spell03 AUTO
SPELL PROPERTY GBS_Spell04 AUTO
SPELL PROPERTY GBS_Spell05 AUTO
SPELL PROPERTY GBS_Spell06 AUTO
SPELL PROPERTY GBS_Spell07 AUTO
SPELL PROPERTY GBS_Spell08 AUTO
SPELL PROPERTY GBS_Spell09 AUTO
SPELL PROPERTY GBS_Spell00 AUTO
SPELL PROPERTY GBS_Spell11 AUTO
SPELL PROPERTY GBS_Spell12 AUTO
SPELL PROPERTY GBS_Spell13 AUTO
SPELL PROPERTY GBS_Spell14 AUTO
SPELL PROPERTY GBS_Spell15 AUTO
SPELL PROPERTY GBS_Spell16 AUTO
SPELL PROPERTY GBS_Spell17 AUTO
SPELL PROPERTY GBS_Spell18 AUTO
SPELL PROPERTY GBS_Spell19 AUTO
SPELL PROPERTY GBS_Spell10 AUTO
FORMLIST PROPERTY GBS_SpellList AUTO
GBS_MenuMain PROPERTY MainMenu AUTO
;IMPORT GrimyToolsPluginScript

ACTOR PROPERTY PlayerRef AUTO

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	RegisterForMenu("MagicMenu")
	PlayerRef.AddSpell(GBS_Spell11,false)
	PlayerRef.AddSpell(GBS_Spell12,false)
	PlayerRef.AddSpell(GBS_Spell13,false)
	PlayerRef.AddSpell(GBS_Spell14,false)
	PlayerRef.AddSpell(GBS_Spell15,false)
	PlayerRef.AddSpell(GBS_Spell16,false)
	PlayerRef.AddSpell(GBS_Spell17,false)
	PlayerRef.AddSpell(GBS_Spell18,false)
	PlayerRef.AddSpell(GBS_Spell19,false)
	PlayerRef.AddSpell(GBS_Spell10,false)
ENDEVENT

EVENT OnPlayerLoadGame()
	MainMenu.updateAllSpells()
	RegisterForMenu("MagicMenu")
ENDEVENT

EVENT OnMenuOpen(String MenuName)
	registerKeys()
ENDEVENT

EVENT OnMenuClose(String MenuName)
	UnregisterForAllKeys()
ENDEVENT

FUNCTION registerKeys()
	RegisterForKey(MainMenu.varSpellKey)
ENDFUNCTION 

STRING[] PROPERTY SpellcraftList AUTO
STRING[] PROPERTY ShoutcraftList AUTO
EVENT OnKeyDown(INT keyCode)
	IF UI.isMenuOpen("Console") || UI.isMenuOpen("CustomMenu") || ((UILib as FORM) as UILIB_GRIMY).IsMenuOpen()
		RETURN 
	ENDIF 
	
	;Debug.Notification("UI.Get Int: " + UI.GetInt("MagicMenu", "_root.Menu_mc.InventoryLists.itemList.selectedEntry.formId"))
	FORM akForm = Game.GetFormEx(UI.GetInt("MagicMenu", "_root.Menu_mc.InventoryLists.itemList.selectedEntry.formId"))
	INT index
	IF akForm AS SPELL
		;proceed
		;Debug.Notification("Spell # Effects: " + (akForm AS SPELL).GetNumEffects())
	ELSEIF (akForm AS SHOUT)
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select Thu'um", ShoutcraftList, 0, 0) - 1
		IF index >= 0 && index <= 2 &&((akForm AS SHOUT).GetNthWordOfPower(index)).PlayerKnows()
			akForm = (akForm AS SHOUT).GetNthSpell(index) AS FORM
		ELSEIF index >= 0
			Debug.Notification("You don't know that many words of power")
			RETURN
		ELSE
			RETURN
		ENDIF
	ELSE 
		RETURN
	ENDIF
	
	index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Spellcrafting", SpellcraftList, 0, 0)
	;index 0 = cancel
	;index 1 = add spell to Signature Spell
	;index 2 = replace spell in Signature Spell
	;index 3 = clear Signature Spell
	;index 4 = Refresh Signature Spell
	;index 5 = Adjust Signature Spell
	;index 6 = Rename spell
	;index 7 = Set Spell Delivery
	;index 8 = Set Spell Casting Type
	
	IF index == 1
		AddSpellToSig(akForm AS SPELL)
	ELSEIF index == 2
		ReplaceSpellToSig(akForm AS SPELL)
	ELSEIF index == 3
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Clear which Signature Spell?", GetSignatureList(), 0, 0)
		IF index == 1
			ClearTemplateList(MainMenu.SigSpellList1)
		ELSEIF index == 2
			ClearTemplateList(MainMenu.SigSpellList2)
		ELSEIF index == 3
			ClearTemplateList(MainMenu.SigSpellList3)
		ELSEIF index == 4
			ClearTemplateList(MainMenu.SigSpellList4)
		ELSEIF index == 5
			ClearTemplateList(MainMenu.SigSpellList5)
		ELSEIF index == 6
			ClearTemplateList(MainMenu.SigSpellList6)
		ELSEIF index == 7
			ClearTemplateList(MainMenu.SigSpellList7)
		ELSEIF index == 8
			ClearTemplateList(MainMenu.SigSpellList8)
		ELSEIF index == 9
			ClearTemplateList(MainMenu.SigSpellList9)
		ELSEIF index == 10
			ClearTemplateList(MainMenu.SigSpellList10)
		ENDIF
	ELSEIF index == 4
		SaveTemplateToSignature( ((UILib as FORM) as UILIB_GRIMY).ShowList("Save to which signature spell slot?", GetSignatureList(), 0, 0) )
	ELSEIF index == 5
		AdjustSignatureSpell()
	ELSEIF index == 6
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Rename which spell?", GetSignatureList(), 0, 0)
		IF ( index >= 1 ) && ( index <= 5 )
			STRING akString = ((UILib AS FORM) AS UILIB_GRIMY).ShowTextInput("Name your signature spell","Signature Spell " + index )
			IF akString != ""
				MainMenu.SigSpellNames[-1+index] = akString
				MainMenu.UpdateNames(index)
			ENDIF
		ENDIF
	ELSEIF index == 7
		AdjustDelivery()
	ELSEIF index == 8
		AdjustCastType()
	ENDIF
ENDEVENT 

FUNCTION AdjustSignatureSpell()
	INT index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Adjust which signature spell slot?", GetSignatureList(), 0, 0)
	IF index < 1 || index > 10
		RETURN
	ENDIF

	INT spellIndex
	IF index == 1
		spellIndex = ((UILib as FORM) as UILIB_GRIMY).ShowList("Adjust which subspell?", GetTemplateList(MainMenu.SigSpellList1), 0, 0) - 1
	ELSEIF index == 2
		spellIndex = ((UILib as FORM) as UILIB_GRIMY).ShowList("Adjust which subspell?", GetTemplateList(MainMenu.SigSpellList2), 0, 0) - 1
	ELSEIF index == 3
		spellIndex = ((UILib as FORM) as UILIB_GRIMY).ShowList("Adjust which subspell?", GetTemplateList(MainMenu.SigSpellList3), 0, 0) - 1
	ELSEIF index == 4
		spellIndex = ((UILib as FORM) as UILIB_GRIMY).ShowList("Adjust which subspell?", GetTemplateList(MainMenu.SigSpellList4), 0, 0) - 1
	ELSEIF index == 5
		spellIndex = ((UILib as FORM) as UILIB_GRIMY).ShowList("Adjust which subspell?", GetTemplateList(MainMenu.SigSpellList5), 0, 0) - 1
	ELSEIF index == 6
		spellIndex = ((UILib as FORM) as UILIB_GRIMY).ShowList("Adjust which subspell?", GetTemplateList(MainMenu.SigSpellList6), 0, 0) - 1
	ELSEIF index == 7
		spellIndex = ((UILib as FORM) as UILIB_GRIMY).ShowList("Adjust which subspell?", GetTemplateList(MainMenu.SigSpellList7), 0, 0) - 1
	ELSEIF index == 8
		spellIndex = ((UILib as FORM) as UILIB_GRIMY).ShowList("Adjust which subspell?", GetTemplateList(MainMenu.SigSpellList8), 0, 0) - 1
	ELSEIF index == 9
		spellIndex = ((UILib as FORM) as UILIB_GRIMY).ShowList("Adjust which subspell?", GetTemplateList(MainMenu.SigSpellList9), 0, 0) - 1
	ELSEIF index == 10
		spellIndex = ((UILib as FORM) as UILIB_GRIMY).ShowList("Adjust which subspell?", GetTemplateList(MainMenu.SigSpellList10), 0, 0) - 1
	ENDIF
	IF spellIndex < 0 || spellIndex > 9
		RETURN 
	ENDIF 
		
	FLOAT akMult = ((UILib AS FORM) AS UILIB_GRIMY).ShowTextInput("Choose Magnitude Multiplier", "1.0" ) AS FLOAT
	IF akMult > 0.0
		IF index == 1
			MainMenu.SigSpellMag1[spellIndex] = akMult
		ELSEIF index == 2
			MainMenu.SigSpellMag2[spellIndex] = akMult
		ELSEIF index == 3
			MainMenu.SigSpellMag3[spellIndex] = akMult
		ELSEIF index == 4
			MainMenu.SigSpellMag2[spellIndex] = akMult
		ELSEIF index == 5
			MainMenu.SigSpellMag5[spellIndex] = akMult
		ELSEIF index == 6
			MainMenu.SigSpellMag6[spellIndex] = akMult
		ELSEIF index == 7
			MainMenu.SigSpellMag7[spellIndex] = akMult
		ELSEIF index == 8
			MainMenu.SigSpellMag8[spellIndex] = akMult
		ELSEIF index == 9
			MainMenu.SigSpellMag9[spellIndex] = akMult
		ELSEIF index == 10
			MainMenu.SigSpellMag10[spellIndex] = akMult
		ENDIF 
	ELSE
		Debug.Notification("Your multiplier must be greater than or equal to 0")
	ENDIF
	
	akMult = ((UILib AS FORM) AS UILIB_GRIMY).ShowTextInput("Choose Duration Multiplier", "1.0" ) AS FLOAT
	IF akMult > 0.0
		IF index == 1
			MainMenu.SigSpellDur1[spellIndex] = akMult
		ELSEIF index == 2
			MainMenu.SigSpellDur2[spellIndex] = akMult
		ELSEIF index == 3
			MainMenu.SigSpellDur3[spellIndex] = akMult
		ELSEIF index == 4
			MainMenu.SigSpellDur2[spellIndex] = akMult
		ELSEIF index == 5
			MainMenu.SigSpellDur5[spellIndex] = akMult
		ELSEIF index == 6
			MainMenu.SigSpellDur6[spellIndex] = akMult
		ELSEIF index == 7
			MainMenu.SigSpellDur7[spellIndex] = akMult
		ELSEIF index == 8
			MainMenu.SigSpellDur8[spellIndex] = akMult
		ELSEIF index == 9
			MainMenu.SigSpellDur9[spellIndex] = akMult
		ELSEIF index == 10
			MainMenu.SigSpellDur10[spellIndex] = akMult
		ENDIF 
	ELSE
		Debug.Notification("Your multiplier must be greater than or equal to 0")
	ENDIF
	
	akMult = ((UILib AS FORM) AS UILIB_GRIMY).ShowTextInput("Choose Cast Time Multiplier (Affects Entire Spell)", "1.0" ) AS FLOAT
	IF akMult > 0.0
		MainMenu.SigSpellTimes[-1 + index] = akMult
	ELSE
		Debug.Notification("Your multiplier must be greater than or equal to 0")
	ENDIF
	
	MainMenu.updateSpell(index)
ENDFUNCTION

STRING[] FUNCTION GetSignatureList()
	STRING[] returnList = new STRING[11]
	returnList[0] = "Cancel"
	returnList[1] = MainMenu.SigSpellNames[0]
	returnList[2] = MainMenu.SigSpellNames[1]
	returnList[3] = MainMenu.SigSpellNames[2]
	returnList[4] = MainMenu.SigSpellNames[3]
	returnList[5] = MainMenu.SigSpellNames[4]
	returnList[6] = MainMenu.SigSpellNames[5]
	returnList[7] = MainMenu.SigSpellNames[6]
	returnList[8] = MainMenu.SigSpellNames[7]
	returnList[9] = MainMenu.SigSpellNames[8]
	returnList[10] = MainMenu.SigSpellNames[9]
	RETURN returnList
ENDFUNCTION 

STRING[] FUNCTION GetTemplateList(SPELL[] templateList)
	STRING[] returnList = new STRING[11]
	returnList[0] = "Cancel"
	INT i = 0
	WHILE i < 10
		IF templateList[i]
			returnList[i+1] = templateList[i].GetName()
		ELSE
			RETURN returnList
		ENDIF
		i += 1
	ENDWHILE
	RETURN returnList
ENDFUNCTION 

FUNCTION ClearTemplateList(SPELL[] templateList)
	templateList[0] = NONE 
	templateList[1] = NONE 
	templateList[2] = NONE 
	templateList[3] = NONE 
	templateList[4] = NONE 
	templateList[5] = NONE 
	templateList[6] = NONE 
	templateList[7] = NONE 
	templateList[8] = NONE 
	templateList[9] = NONE 
ENDFUNCTION

FUNCTION SaveTemplateToSignature(INT index)
	IF index > 0 && MainMenu.updateSpell(index) >= 0
		PlayerRef.AddItem(GBS_NullItem,1,true)
		PlayerRef.RemoveItem(GBS_NullItem,1,true)
	ENDIF
ENDFUNCTION 
FORM PROPERTY GBS_NullItem AUTO

FUNCTION AddSpellToSig(SPELL akSpell)
	IF GBS_SpellList.Find(akSpell) != -1
		Debug.Notification("You can't craft spells out of signature spells!")
		RETURN
	ENDIF
	INT index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Add spell to which slot?", GetSignatureList(), 0, 0)
	IF index == 1
		index = 0
		WHILE index < 10
			IF MainMenu.SigSpellList1[index] == NONE 
				MainMenu.SigSpellList1[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Debug.Notification("No more spell slots left in this template")
	ELSEIF index == 2
		index = 0
		WHILE index < 10
			IF MainMenu.SigSpellList2[index] == NONE 
				MainMenu.SigSpellList2[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Debug.Notification("No more spell slots left in this template")
	ELSEIF index == 3
		index = 0
		WHILE index < 10
			IF MainMenu.SigSpellList3[index] == NONE 
				MainMenu.SigSpellList3[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Debug.Notification("No more spell slots left in this template")
	ELSEIF index == 4
		index = 0
		WHILE index < 10
			IF MainMenu.SigSpellList4[index] == NONE 
				MainMenu.SigSpellList4[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Debug.Notification("No more spell slots left in this template")
	ELSEIF index == 5
		index = 0
		WHILE index < 10
			IF MainMenu.SigSpellList5[index] == NONE 
				MainMenu.SigSpellList5[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Debug.Notification("No more spell slots left in this template")
	ELSEIF index == 6
		index = 0
		WHILE index < 10
			IF MainMenu.SigSpellList6[index] == NONE 
				MainMenu.SigSpellList6[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Debug.Notification("No more spell slots left in this template")
	ELSEIF index == 7
		index = 0
		WHILE index < 10
			IF MainMenu.SigSpellList7[index] == NONE 
				MainMenu.SigSpellList7[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Debug.Notification("No more spell slots left in this template")
	ELSEIF index == 8
		index = 0
		WHILE index < 10
			IF MainMenu.SigSpellList8[index] == NONE 
				MainMenu.SigSpellList8[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Debug.Notification("No more spell slots left in this template")
	ELSEIF index == 9
		index = 0
		WHILE index < 10
			IF MainMenu.SigSpellList9[index] == NONE 
				MainMenu.SigSpellList9[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Debug.Notification("No more spell slots left in this template")
	ELSEIF index == 10
		index = 0
		WHILE index < 10
			IF MainMenu.SigSpellList10[index] == NONE 
				MainMenu.SigSpellList10[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Debug.Notification("No more spell slots left in this template")
	ENDIF
ENDFUNCTION 

FUNCTION ReplaceSpellToSig(SPELL akSpell)
	IF GBS_SpellList.Find(akSpell) != -1
		Debug.Notification("You can't craft spells out of signature spells!")
		RETURN
	ENDIF
	
	INT index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Replace spell in which slot?", GetSignatureList(), 0, 0)
	IF index == 1
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList1), 0, 0) - 1
		IF index >= 0 && index <= 9
			MainMenu.SigSpellList1[index] = akSpell
		ENDIF
	ELSEIF index == 2
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList2), 0, 0) - 1
		IF index >= 0 && index <= 9
			MainMenu.SigSpellList2[index] = akSpell
		ENDIF
	ELSEIF index == 3
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList3), 0, 0) - 1
		IF index >= 0 && index <= 9
			MainMenu.SigSpellList3[index] = akSpell
		ENDIF
	ELSEIF index == 4
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList4), 0, 0) - 1
		IF index >= 0 && index <= 9
			MainMenu.SigSpellList4[index] = akSpell
		ENDIF
	ELSEIF index == 5
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList5), 0, 0) - 1
		IF index >= 0 && index <= 9
			MainMenu.SigSpellList5[index] = akSpell
		ENDIF
	ELSEIF index == 6
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList6), 0, 0) - 1
		IF index >= 0 && index <= 9
			MainMenu.SigSpellList6[index] = akSpell
		ENDIF
	ELSEIF index == 7
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList7), 0, 0) - 1
		IF index >= 0 && index <= 9
			MainMenu.SigSpellList7[index] = akSpell
		ENDIF
	ELSEIF index == 8
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList8), 0, 0) - 1
		IF index >= 0 && index <= 9
			MainMenu.SigSpellList8[index] = akSpell
		ENDIF
	ELSEIF index == 9
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList9), 0, 0) - 1
		IF index >= 0 && index <= 9
			MainMenu.SigSpellList9[index] = akSpell
		ENDIF
	ELSEIF index == 10
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList10), 0, 0) - 1
		IF index >= 0 && index <= 9
			MainMenu.SigSpellList10[index] = akSpell
		ENDIF
	ENDIF
ENDFUNCTION 

STRING[] PROPERTY DeliveryList AUTO
FUNCTION AdjustDelivery()
	INT index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Change delivery of which Signature Spell?", GetSignatureList(), 0, 0) - 1
	IF index >= 0 && index <= 9
		INT index2 = ((UILib as FORM) as UILIB_GRIMY).ShowList("Choose Delivery Type", DeliveryList, 1 + MainMenu.SigSpellDeliveries[index], 0) - 1
		IF index2 >= 0 && index2 <= 4
			MainMenu.SigSpellDeliveries[index] = index2
			Debug.Notification("You may need to completely exit the game for spell deliveries to update")
		ENDIF
	ENDIF
ENDFUNCTION 

STRING[] PROPERTY CastTypeList AUTO
FUNCTION AdjustCastType()
	INT index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Change cast type of which Signature Spell?", GetSignatureList(), 0, 0) - 1
	IF index >= 0 && index <= 9
		INT index2 = ((UILib as FORM) as UILIB_GRIMY).ShowList("Choose Cast Type", CastTypeList, 1 + MainMenu.SigSpellCastTypes[index], 0) - 1
		IF index2 >= 0 && index2 <= 2
			MainMenu.SigSpellCastTypes[index] = index2
			Debug.Notification("You may need to completely exit the game for cast types to update")
		ENDIF
	ENDIF
ENDFUNCTION 