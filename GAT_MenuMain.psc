Scriptname GAT_MenuMain extends SKI_ConfigBase  

QUEST PROPERTY UILib AUTO
IMPORT GrimyToolsPluginScript

INT FUNCTION GetVersion()
	return 1
ENDFUNCTION

EVENT OnVersionUpdate(int a_version)
	refreshPages()
ENDEVENT

EVENT OnConfigInit()
	ModName = "Grimy: Spell Weaver"
	PlayerRef.AddSpell(GUISE_AB_SpellMenu_Hotkey)
	refreshPages()
ENDEVENT

FUNCTION refreshPages()
ENDFUNCTION

PERK PROPERTY GAT_Perk00_Spellcraft AUTO
PERK PROPERTY GAT_Perk20_Calibration AUTO
PERK PROPERTY GAT_Perk40_Protraction AUTO
PERK PROPERTY GAT_Perk60_Alacrity AUTO
PERK PROPERTY GAT_Perk80_Thuumcraft AUTO
SPELL PROPERTY GUISE_AB_SpellMenu_Hotkey AUTO
INT PROPERTY varSpellKey = 47 AUTO

EVENT OnPageReset(string page)
	refreshPages()
	SetCursorFillMode(TOP_TO_BOTTOM)
	AddHeaderOption("Setup")
	AddKeyMapOptionST("SPELL_MENU_KEY","Spell Menu Key",varSpellKey)
	AddToggleOptionST("REGISTER_SPELL_HOTKEY","Register Spellcrafting",PlayerRef.HasSpell(GUISE_AB_SpellMenu_Hotkey))
	
	SetCursorPosition(1)
	AddHeaderOption("Perks")
	AddToggleOptionST("SPELLCRAFT_01","Spellcraft",PlayerRef.HasPerk(GAT_Perk00_Spellcraft))
	AddToggleOptionST("SPELLCRAFT_02","Calibration",PlayerRef.HasPerk(GAT_Perk20_Calibration))
	AddToggleOptionST("SPELLCRAFT_03","Protraction",PlayerRef.HasPerk(GAT_Perk40_Protraction))
	AddToggleOptionST("SPELLCRAFT_04","Alacrity",PlayerRef.HasPerk(GAT_Perk60_Alacrity))
	AddToggleOptionST("SPELLCRAFT_05","Thu'umcraft",PlayerRef.HasPerk(GAT_Perk80_Thuumcraft))
ENDEVENT

STATE REGISTER_SPELL_HOTKEY
	EVENT OnSelectST()
		IF PlayerRef.hasSpell(GUISE_AB_SpellMenu_Hotkey)
			PlayerRef.RemoveSpell(GUISE_AB_SpellMenu_Hotkey)
			SetToggleOptionValueST(false)
		ELSE
			PlayerRef.AddSpell(GUISE_AB_SpellMenu_Hotkey,false)
			SetToggleOptionValueST(true)
		ENDIF
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemoveSpell(GUISE_AB_SpellMenu_Hotkey)
		SetToggleOptionValueST(PlayerRef.HasPerk(GAT_Perk00_Spellcraft))
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Activates Spellcrafting.\nToggle this off and on to refresh the spellcrafting script. You may need to do this on updates.")
	ENDEVENT
ENDSTATE

STATE SPELL_MENU_KEY
	EVENT OnKeyMapChangeST(int a_keyCode, string a_conflictControl, string a_conflictName)
		varSpellKey = a_keyCode
		IF PlayerRef.HasSpell(GUISE_AB_SpellMenu_Hotkey)
			PlayerRef.RemoveSpell(GUISE_AB_SpellMenu_Hotkey)
			PlayerRef.AddSpell(GUISE_AB_SpellMenu_Hotkey,false)
		ENDIF
		SetKeyMapOptionValueST(a_keyCode)
	ENDEVENT

	EVENT OnDefaultST()
		varSpellKey = 46
		SetKeyMapOptionValueST(46)
	ENDEVENT
ENDSTATE

FUNCTION togglePerk(PERK akPerk)
	IF PlayerRef.HasPerk(akPerk)
		IF ShowMessage("Refund a perk point?",true,"Refund Perk","No Perk Point")
			Game.ModPerkpoints(1)
		ENDIF
		PlayerRef.RemovePerk(akPerk)
		SetToggleOptionValueST(false)
	ELSE
		IF ShowMessage("Deduct a perk point?",true,"Deduct Perk","Free Perk")
			IF Game.GetPerkPoints() > 0
				Game.ModPerkPoints(-1)
				PlayerRef.AddPerk(akPerk)
				SetToggleOptionValueST(true)
			ELSE
				ShowMessage("You don't have any perk points",false)
			ENDIF
		ELSE
			PlayerRef.AddPerk(akPerk)
			SetToggleOptionValueST(true)
		ENDIF
	ENDIF
ENDFUNCTION

STATE SPELLCRAFT_01
	EVENT OnSelectST()
		togglePerk(GAT_Perk00_Spellcraft)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GAT_Perk00_Spellcraft)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Gain the ability to craft a signature spell.")
	ENDEVENT
ENDSTATE

STATE SPELLCRAFT_02
	EVENT OnSelectST()
		IF PlayerRef.HasPerk(GAT_Perk20_Calibration) || PlayerRef.HasPerk(GAT_Perk00_Spellcraft)
			togglePerk(GAT_Perk20_Calibration)
		ELSE
			ShowMessage("You need the Spellcraft Perk",false)
		ENDIF
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GAT_Perk20_Calibration)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Gain the ability to adjust the magnitude of signature spell effects.+1 Signature Spell Slot.\nRequires Spellcraft and level 20 alteration.")
	ENDEVENT
ENDSTATE

STATE SPELLCRAFT_03
	EVENT OnSelectST()
		IF PlayerRef.HasPerk(GAT_Perk40_Protraction) || PlayerRef.HasPerk(GAT_Perk20_Calibration)
			togglePerk(GAT_Perk40_Protraction)
		ELSE
			ShowMessage("You need the Calibration Perk",false)
		ENDIF
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GAT_Perk40_Protraction)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Gain the ability to adjust the duration of signature spell effects.+1 Signature Spell Slot.\nRequires Calibration and level 40 alteration.")
	ENDEVENT
ENDSTATE

STATE SPELLCRAFT_04
	EVENT OnSelectST()
		IF PlayerRef.HasPerk(GAT_Perk60_Alacrity) || PlayerRef.HasPerk(GAT_Perk40_Protraction)
			togglePerk(GAT_Perk60_Alacrity)
		ELSE
			ShowMessage("You need the Protraction Perk",false)
		ENDIF
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GAT_Perk60_Alacrity)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Gain the ability to adjust the casting speed of signature spell effects. The magnitude and cost of non-buff spell effects will scale with casting speed. +1 Signature Spell Slot.\nRequires Protraction and level 60 alteration")
	ENDEVENT
ENDSTATE

STATE SPELLCRAFT_05
	EVENT OnSelectST()
		IF PlayerRef.HasPerk(GAT_Perk80_Thuumcraft) || PlayerRef.HasPerk(GAT_Perk60_Alacrity)
			togglePerk(GAT_Perk80_Thuumcraft)
		ELSE
			ShowMessage("You need the Alacrity Perk",false)
		ENDIF
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GAT_Perk80_Thuumcraft)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Gain the ability to build signature spells out of shouts. +1 Signature Spell Slot.\nRequires Alacrity and level 80 alteration.")
	ENDEVENT
ENDSTATE

ACTOR PROPERTY PlayerRef AUTO
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

INT FUNCTION updateSpell(INT index)
	IF index == 1 
		MergeSpells(GAT_SignatureSpell01,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GAT_SignatureSpell11,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell01,SigSpellList1,SigSpellMag1,SigSpellDur1,SigSpellCost1,SigSpellTimes[-1+index]), GAT_SignatureSpell01 )
		RETURN DisplayErrorMessage( MergeSpells(GAT_SignatureSpell11,SigSpellList1,SigSpellMag1,SigSpellDur1,SigSpellCost1,SigSpellTimes[-1+index]), GAT_SignatureSpell11 )
	ELSEIF index == 2 
		MergeSpells(GAT_SignatureSpell02,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GAT_SignatureSpell11,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell02,SigSpellList2,SigSpellMag2,SigSpellDur2,SigSpellCost2,SigSpellTimes[-1+index]), GAT_SignatureSpell02 )
		RETURN DisplayErrorMessage( MergeSpells(GAT_SignatureSpell11,SigSpellList1,SigSpellMag1,SigSpellDur1,SigSpellCost1,SigSpellTimes[-1+index]), GAT_SignatureSpell12 )
	ELSEIF index == 3 
		MergeSpells(GAT_SignatureSpell03,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GAT_SignatureSpell13,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell03,SigSpellList3,SigSpellMag3,SigSpellDur3,SigSpellCost3,SigSpellTimes[-1+index]), GAT_SignatureSpell03 )
		RETURN DisplayErrorMessage( MergeSpells(GAT_SignatureSpell13,SigSpellList3,SigSpellMag3,SigSpellDur3,SigSpellCost3,SigSpellTimes[-1+index]), GAT_SignatureSpell13 )
	ELSEIF index == 4 
		MergeSpells(GAT_SignatureSpell04,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GAT_SignatureSpell14,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell04,SigSpellList4,SigSpellMag4,SigSpellDur4,SigSpellCost4,SigSpellTimes[-1+index]), GAT_SignatureSpell04 )
		RETURN DisplayErrorMessage( MergeSpells(GAT_SignatureSpell14,SigSpellList4,SigSpellMag4,SigSpellDur4,SigSpellCost4,SigSpellTimes[-1+index]), GAT_SignatureSpell14 )
	ELSEIF index == 5 
		MergeSpells(GAT_SignatureSpell05,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GAT_SignatureSpell15,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell05,SigSpellList5,SigSpellMag5,SigSpellDur5,SigSpellCost5,SigSpellTimes[-1+index]), GAT_SignatureSpell05 )
		RETURN DisplayErrorMessage( MergeSpells(GAT_SignatureSpell15,SigSpellList5,SigSpellMag5,SigSpellDur5,SigSpellCost5,SigSpellTimes[-1+index]), GAT_SignatureSpell15 )
	ENDIF
	RETURN -10
ENDFUNCTION

FUNCTION UpdateNames(INT index)
	IF index == 1
		GAT_SignatureSpell01.SetName(SigSpellNames[-1+index])
		GAT_SignatureSpell11.SetName(SigSpellNames[-1+index])
	ELSEIF index == 2
		GAT_SignatureSpell02.SetName(SigSpellNames[-1+index])
		GAT_SignatureSpell12.SetName(SigSpellNames[-1+index])
	ELSEIF index == 3
		GAT_SignatureSpell03.SetName(SigSpellNames[-1+index])
		GAT_SignatureSpell13.SetName(SigSpellNames[-1+index])
	ELSEIF index == 4
		GAT_SignatureSpell04.SetName(SigSpellNames[-1+index])
		GAT_SignatureSpell14.SetName(SigSpellNames[-1+index])
	ELSEIF index == 5
		GAT_SignatureSpell05.SetName(SigSpellNames[-1+index])
		GAT_SignatureSpell15.SetName(SigSpellNames[-1+index])
	ENDIF
ENDFUNCTION 

SPELL PROPERTY GAT_IsSpellLoaded AUTO
BOOL SpellFlip = true
FUNCTION updateAllSpells()
	IF !GAT_IsSpellLoaded.GetName()
		GAT_IsSpellLoaded.SetName("1")
		SpellFlip = !SpellFlip
		IF SpellFlip
			PlayerRef.RemoveSpell(GAT_SignatureSpell01)
			PlayerRef.RemoveSpell(GAT_SignatureSpell02)
			PlayerRef.RemoveSpell(GAT_SignatureSpell03)
			PlayerRef.RemoveSpell(GAT_SignatureSpell04)
			PlayerRef.RemoveSpell(GAT_SignatureSpell05)
			PlayerRef.AddSpell(GAT_SignatureSpell11,false)
			PlayerRef.AddSpell(GAT_SignatureSpell12,false)
			PlayerRef.AddSpell(GAT_SignatureSpell13,false)
			PlayerRef.AddSpell(GAT_SignatureSpell14,false)
			PlayerRef.AddSpell(GAT_SignatureSpell15,false)
		ELSE 
			PlayerRef.RemoveSpell(GAT_SignatureSpell11)
			PlayerRef.RemoveSpell(GAT_SignatureSpell12)
			PlayerRef.RemoveSpell(GAT_SignatureSpell13)
			PlayerRef.RemoveSpell(GAT_SignatureSpell14)
			PlayerRef.RemoveSpell(GAT_SignatureSpell15)
			PlayerRef.AddSpell(GAT_SignatureSpell01,false)
			PlayerRef.AddSpell(GAT_SignatureSpell02,false)
			PlayerRef.AddSpell(GAT_SignatureSpell03,false)
			PlayerRef.AddSpell(GAT_SignatureSpell04,false)
			PlayerRef.AddSpell(GAT_SignatureSpell05,false)
		ENDIF
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell01,SigSpellList1,SigSpellMag1,SigSpellDur1,SigSpellCost1,SigSpellTimes[0]), GAT_SignatureSpell01 )
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell02,SigSpellList2,SigSpellMag2,SigSpellDur2,SigSpellCost2,SigSpellTimes[1]), GAT_SignatureSpell02 )
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell03,SigSpellList3,SigSpellMag3,SigSpellDur3,SigSpellCost3,SigSpellTimes[2]), GAT_SignatureSpell03 )
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell04,SigSpellList4,SigSpellMag4,SigSpellDur4,SigSpellCost4,SigSpellTimes[3]), GAT_SignatureSpell04 )
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell05,SigSpellList5,SigSpellMag5,SigSpellDur5,SigSpellCost5,SigSpellTimes[4]), GAT_SignatureSpell05 )
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell11,SigSpellList1,SigSpellMag1,SigSpellDur1,SigSpellCost1,SigSpellTimes[0]), GAT_SignatureSpell11 )
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell12,SigSpellList2,SigSpellMag2,SigSpellDur2,SigSpellCost2,SigSpellTimes[1]), GAT_SignatureSpell12 )
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell13,SigSpellList3,SigSpellMag3,SigSpellDur3,SigSpellCost3,SigSpellTimes[2]), GAT_SignatureSpell13 )
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell14,SigSpellList4,SigSpellMag4,SigSpellDur4,SigSpellCost4,SigSpellTimes[3]), GAT_SignatureSpell14 )
		DisplayErrorMessage( MergeSpells(GAT_SignatureSpell15,SigSpellList5,SigSpellMag5,SigSpellDur5,SigSpellCost5,SigSpellTimes[4]), GAT_SignatureSpell15 )
		
		SetSpellDelivery(GAT_SignatureSpell01,SigSpellDeliveries[0])
		SetSpellDelivery(GAT_SignatureSpell02,SigSpellDeliveries[1])
		SetSpellDelivery(GAT_SignatureSpell03,SigSpellDeliveries[2])
		SetSpellDelivery(GAT_SignatureSpell04,SigSpellDeliveries[3])
		SetSpellDelivery(GAT_SignatureSpell05,SigSpellDeliveries[4])
		SetSpellDelivery(GAT_SignatureSpell11,SigSpellDeliveries[0])
		SetSpellDelivery(GAT_SignatureSpell12,SigSpellDeliveries[1])
		SetSpellDelivery(GAT_SignatureSpell13,SigSpellDeliveries[2])
		SetSpellDelivery(GAT_SignatureSpell14,SigSpellDeliveries[3])
		SetSpellDelivery(GAT_SignatureSpell15,SigSpellDeliveries[4])
		
		SetSpellCastType(GAT_SignatureSpell01,SigSpellCastTypes[0])
		SetSpellCastType(GAT_SignatureSpell02,SigSpellCastTypes[1])
		SetSpellCastType(GAT_SignatureSpell03,SigSpellCastTypes[2])
		SetSpellCastType(GAT_SignatureSpell04,SigSpellCastTypes[3])
		SetSpellCastType(GAT_SignatureSpell05,SigSpellCastTypes[4])
		SetSpellCastType(GAT_SignatureSpell11,SigSpellCastTypes[0])
		SetSpellCastType(GAT_SignatureSpell12,SigSpellCastTypes[1])
		SetSpellCastType(GAT_SignatureSpell13,SigSpellCastTypes[2])
		SetSpellCastType(GAT_SignatureSpell14,SigSpellCastTypes[3])
		SetSpellCastType(GAT_SignatureSpell15,SigSpellCastTypes[4])
		
		GAT_SignatureSpell01.SetName(SigSpellNames[0])
		GAT_SignatureSpell02.SetName(SigSpellNames[1])
		GAT_SignatureSpell03.SetName(SigSpellNames[2])
		GAT_SignatureSpell04.SetName(SigSpellNames[3])
		GAT_SignatureSpell05.SetName(SigSpellNames[4])
		GAT_SignatureSpell11.SetName(SigSpellNames[0])
		GAT_SignatureSpell12.SetName(SigSpellNames[1])
		GAT_SignatureSpell13.SetName(SigSpellNames[2])
		GAT_SignatureSpell14.SetName(SigSpellNames[3])
		GAT_SignatureSpell15.SetName(SigSpellNames[4])
	ENDIF
ENDFUNCTION 

INT FUNCTION DisplayErrorMessage(INT Index, SPELL akSpell)
	IF index == 1
		SetSpellType(akSpell,3)
	ELSEIF index == -1
		Debug.Notification("Spellcrafting failed, Spell Cast Types (Concentration, Fire and Forget, Etc) need to match!")
	ELSEIF index == -2
		Debug.Notification("Spellcrafting failed, Spell Delivery (Aimed, Self, Etc) need to match!")
	ELSEIF index == -3
		Debug.Notification("Spellcrafting failed, You can't make a spell with more than 10 magic effects!")
	ELSEIF index == -4
		Debug.Notification("Spellcrafting failed, Data Structure has been corrupted")
	ENDIF 
	RETURN index
ENDFUNCTION

SPELL[] PROPERTY SigSpellList0 AUTO
FLOAT[] PROPERTY SigSpellMag0 AUTO
FLOAT[] PROPERTY SigSpellDur0 AUTO
FLOAT[] PROPERTY SigSpellCost0 AUTO

SPELL[] PROPERTY SigSpellList1 AUTO
SPELL[] PROPERTY SigSpellList2 AUTO
SPELL[] PROPERTY SigSpellList3 AUTO
SPELL[] PROPERTY SigSpellList4 AUTO
SPELL[] PROPERTY SigSpellList5 AUTO

FLOAT[] PROPERTY SigSpellMag1 AUTO
FLOAT[] PROPERTY SigSpellMag2 AUTO
FLOAT[] PROPERTY SigSpellMag3 AUTO
FLOAT[] PROPERTY SigSpellMag4 AUTO
FLOAT[] PROPERTY SigSpellMag5 AUTO

FLOAT[] PROPERTY SigSpellDur1 AUTO
FLOAT[] PROPERTY SigSpellDur2 AUTO
FLOAT[] PROPERTY SigSpellDur3 AUTO
FLOAT[] PROPERTY SigSpellDur4 AUTO
FLOAT[] PROPERTY SigSpellDur5 AUTO

FLOAT[] PROPERTY SigSpellCost1 AUTO
FLOAT[] PROPERTY SigSpellCost2 AUTO
FLOAT[] PROPERTY SigSpellCost3 AUTO
FLOAT[] PROPERTY SigSpellCost4 AUTO
FLOAT[] PROPERTY SigSpellCost5 AUTO

FLOAT[] PROPERTY SigSpellTimes AUTO
INT[] PROPERTY SigSpellDeliveries AUTO 
INT[] PROPERTY SigSpellCastTypes AUTO

STRING[] PROPERTY SigSpellNames AUTO