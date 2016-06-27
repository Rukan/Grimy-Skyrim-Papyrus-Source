Scriptname GUISE_Script_SpellMenuHotkeys extends activemagiceffect  

QUEST PROPERTY UILib AUTO
SPELL PROPERTY GAT_SignatureSpell01 AUTO
SPELL PROPERTY GAT_SignatureSpell02 AUTO
SPELL PROPERTY GAT_SignatureSpell03 AUTO
SPELL PROPERTY GAT_SignatureSpell04 AUTO
SPELL PROPERTY GAT_SignatureSpell05 AUTO
SPELL PROPERTY GAT_SignatureSpell11 AUTO
SPELL PROPERTY GAT_SignatureSpell12 AUTO
SPELL PROPERTY GAT_SignatureSpell13 AUTO
SPELL PROPERTY GAT_SignatureSpell14 AUTO
SPELL PROPERTY GAT_SignatureSpell15 AUTO
FORMLIST PROPERTY GAT_SpellList AUTO
GAT_MenuMain PROPERTY MainMenu AUTO

IMPORT UI
IMPORT Game
IMPORT Debug

ACTOR PROPERTY PlayerRef AUTO

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	RegisterForMenu("MagicMenu")
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
FORM PROPERTY GAT_MagicInk AUTO
EVENT OnKeyDown(INT keyCode)
	IF isMenuOpen("Console") || isMenuOpen("CustomMenu") || ((UILib as FORM) as UILIB_GRIMY).IsMenuOpen()
		RETURN 
	ENDIF 
	
	FORM akForm = GetFormEx(GetInt("MagicMenu", "_root.Menu_mc.InventoryLists.itemList.selectedEntry.formId"))
	INT index
	IF akForm AS SPELL
		;proceed
	ELSEIF (akForm AS SHOUT) && PlayerRef.HasPerk(GAT_Perk80_Thuumcraft)
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select Thu'um", ShoutcraftList, 0, 0) - 1
		IF index >= 0 && index <= 2 &&((akForm AS SHOUT).GetNthWordOfPower(index)).PlayerKnows()
			akForm = (akForm AS SHOUT).GetNthSpell(index) AS FORM
		ELSEIF index >= 0
			Notification("You don't know that many words of power")
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
		ENDIF
	ELSEIF index == 4
		IF PlayerRef.GetItemCount(GAT_MagicInk) > 0
			SaveTemplateToSignature( ((UILib as FORM) as UILIB_GRIMY).ShowList("Save to which signature spell slot?", GetSignatureList(), 0, 0) )
		ELSE
			Notification("You need 1 aetherial ink to craft a signature spell")
		ENDIF
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

PERK PROPERTY GAT_Perk00_Spellcraft AUTO
PERK PROPERTY GAT_Perk20_Calibration AUTO
PERK PROPERTY GAT_Perk40_Protraction AUTO
PERK PROPERTY GAT_Perk60_Alacrity AUTO
PERK PROPERTY GAT_Perk80_Thuumcraft AUTO
FUNCTION AdjustSignatureSpell()
	INT index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Adjust which signature spell slot?", GetSignatureList(), 0, 0)
	IF index < 1 || index > 5
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
	ENDIF
	IF spellIndex < 0 || spellIndex > 4
		RETURN 
	ENDIF 
		
	IF PlayerRef.HasPerk(GAT_Perk20_Calibration)
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
			ENDIF 
		ELSE
			Notification("Your multiplier must be greater than or equal to 0")
		ENDIF
	ENDIF 
	IF PlayerRef.HasPerk(GAT_Perk40_Protraction)
		FLOAT akMult = ((UILib AS FORM) AS UILIB_GRIMY).ShowTextInput("Choose Duration Multiplier", "1.0" ) AS FLOAT
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
			ENDIF 
		ELSE
			Notification("Your multiplier must be greater than or equal to 0")
		ENDIF
	ENDIF 
	IF PlayerRef.HasPerk(GAT_Perk60_Alacrity)
		FLOAT akMult = ((UILib AS FORM) AS UILIB_GRIMY).ShowTextInput("Choose Cast Time Multiplier (Affects Entire Spell)", "1.0" ) AS FLOAT
		IF akMult > 0.0
			MainMenu.SigSpellTimes[-1 + index] = akMult
		ELSE
			Notification("Your multiplier must be greater than or equal to 0")
		ENDIF
	ENDIF
	
	MainMenu.updateSpell(index)
ENDFUNCTION

STRING[] FUNCTION GetSignatureList()
	STRING[] returnList = new STRING[6]
	returnList[0] = "Cancel"
	IF PlayerRef.HasPerk(GAT_Perk00_Spellcraft)
		returnList[1] = MainMenu.SigSpellNames[0]
	ENDIF
	IF PlayerRef.HasPerk(GAT_Perk20_Calibration)
		returnList[2] = MainMenu.SigSpellNames[1]
	ENDIF
	IF PlayerRef.HasPerk(GAT_Perk40_Protraction)
		returnList[3] = MainMenu.SigSpellNames[2]
	ENDIF
	IF PlayerRef.HasPerk(GAT_Perk60_Alacrity)
		returnList[4] = MainMenu.SigSpellNames[3]
	ENDIF
	IF PlayerRef.HasPerk(GAT_Perk80_Thuumcraft)
		returnList[5] = MainMenu.SigSpellNames[4]
	ENDIF
	RETURN returnList
ENDFUNCTION 

STRING[] FUNCTION GetTemplateList(SPELL[] templateList)
	STRING[] returnList = new STRING[6]
	returnList[0] = "Cancel"
	INT i = 0
	WHILE i < 5
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
ENDFUNCTION

FUNCTION SaveTemplateToSignature(INT index)
	IF index > 0 && MainMenu.updateSpell(index) >= 0
		PlayerRef.RemoveItem(GAT_MagicInk)
	ENDIF
ENDFUNCTION 

FUNCTION AddSpellToSig(SPELL akSpell)
	IF GAT_SpellList.Find(akSpell) != -1
		Notification("You can't craft spells out of signature spells!")
		RETURN
	ENDIF
	INT index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Add spell to which slot?", GetSignatureList(), 0, 0)
	IF index == 1
		index = 0
		WHILE index < 5
			IF MainMenu.SigSpellList1[index] == NONE 
				MainMenu.SigSpellList1[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Notification("No more spell slots left in this template")
	ELSEIF index == 2
		index = 0
		WHILE index < 5
			IF MainMenu.SigSpellList2[index] == NONE 
				MainMenu.SigSpellList2[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Notification("No more spell slots left in this template")
	ELSEIF index == 3
		index = 0
		WHILE index < 5
			IF MainMenu.SigSpellList3[index] == NONE 
				MainMenu.SigSpellList3[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Notification("No more spell slots left in this template")
	ELSEIF index == 4
		index = 0
		WHILE index < 5
			IF MainMenu.SigSpellList4[index] == NONE 
				MainMenu.SigSpellList4[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Notification("No more spell slots left in this template")
	ELSEIF index == 5
		index = 0
		WHILE index < 5
			IF MainMenu.SigSpellList5[index] == NONE 
				MainMenu.SigSpellList5[index] = akSpell
				RETURN
			ENDIF 
			index += 1
		ENDWHILE
		Notification("No more spell slots left in this template")
	ENDIF
ENDFUNCTION 

FUNCTION ReplaceSpellToSig(SPELL akSpell)
	IF GAT_SpellList.Find(akSpell) != -1
		Notification("You can't craft spells out of signature spells!")
		RETURN
	ENDIF
	
	INT index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Replace spell in which slot?", GetSignatureList(), 0, 0)
	IF index == 1
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList1), 0, 0) - 1
		IF index >= 0 && index <= 4
			MainMenu.SigSpellList1[index] = akSpell
		ENDIF
	ELSEIF index == 2
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList2), 0, 0) - 1
		IF index >= 0 && index <= 4
			MainMenu.SigSpellList2[index] = akSpell
		ENDIF
	ELSEIF index == 3
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList3), 0, 0) - 1
		IF index >= 0 && index <= 4
			MainMenu.SigSpellList3[index] = akSpell
		ENDIF
	ELSEIF index == 4
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList4), 0, 0) - 1
		IF index >= 0 && index <= 4
			MainMenu.SigSpellList4[index] = akSpell
		ENDIF
	ELSEIF index == 5
		index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Which spell to replace?", GetTemplateList(MainMenu.SigSpellList5), 0, 0) - 1
		IF index >= 0 && index <= 4
			MainMenu.SigSpellList5[index] = akSpell
		ENDIF
	ENDIF
ENDFUNCTION 

STRING[] PROPERTY DeliveryList AUTO
FUNCTION AdjustDelivery()
	INT index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Change delivery of which Signature Spell?", GetSignatureList(), 0, 0) - 1
	IF index >= 0 && index <= 4
		INT index2 = ((UILib as FORM) as UILIB_GRIMY).ShowList("Choose Delivery Type", DeliveryList, 1 + MainMenu.SigSpellDeliveries[index], 0) - 1
		IF index2 >= 0 && index2 <= 4
			MainMenu.SigSpellDeliveries[index] = index2
			Notification("You may need to completely exit the game for spell deliveries to update")
		ENDIF
	ENDIF
ENDFUNCTION 

STRING[] PROPERTY CastTypeList AUTO
FUNCTION AdjustCastType()
	INT index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Change cast type of which Signature Spell?", GetSignatureList(), 0, 0) - 1
	IF index >= 0 && index <= 4
		INT index2 = ((UILib as FORM) as UILIB_GRIMY).ShowList("Choose Cast Type", CastTypeList, 1 + MainMenu.SigSpellCastTypes[index], 0) - 1
		IF index2 >= 0 && index2 <= 2
			MainMenu.SigSpellCastTypes[index] = index2
			Notification("You may need to completely exit the game for cast types to update")
		ENDIF
	ENDIF
ENDFUNCTION 