Scriptname GBS_MenuMain extends SKI_ConfigBase  

QUEST PROPERTY UILib AUTO
IMPORT GrimyToolsPluginScript

INT FUNCTION GetVersion()
	return 1
ENDFUNCTION

EVENT OnVersionUpdate(int a_version)
	refreshPages()
ENDEVENT

EVENT OnConfigInit()
	refreshPages()
ENDEVENT

FUNCTION refreshPages()
	ModName = "Better Spellcrafting"
ENDFUNCTION

SPELL PROPERTY GBS_AB_SpellMenu_Hotkey AUTO
INT PROPERTY varSpellKey = 47 AUTO
EVENT OnPageReset(string page)
	refreshPages()
	SetCursorFillMode(TOP_TO_BOTTOM)
	AddHeaderOption("Hotkeys")
	AddKeyMapOptionST("SPELL_MENU_KEY","Spell Menu Key",varSpellKey)
	AddHeaderOption("Debug")
	AddToggleOptionST("REGISTER_SPELL_HOTKEY","Register Spellcrafting",PlayerRef.HasSpell(GBS_AB_SpellMenu_Hotkey))
ENDEVENT

STATE REGISTER_SPELL_HOTKEY
	EVENT OnSelectST()
		IF PlayerRef.hasSpell(GBS_AB_SpellMenu_Hotkey)
			PlayerRef.RemoveSpell(GBS_AB_SpellMenu_Hotkey)
			SetToggleOptionValueST(false)
		ELSE
			PlayerRef.AddSpell(GBS_AB_SpellMenu_Hotkey,false)
			SetToggleOptionValueST(true)
		ENDIF
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemoveSpell(GBS_AB_SpellMenu_Hotkey)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Activates Spellcrafting.\nToggle this off and on to refresh the spellcrafting script. You may need to do this on updates.")
	ENDEVENT
ENDSTATE

STATE SPELL_MENU_KEY
	EVENT OnKeyMapChangeST(int a_keyCode, string a_conflictControl, string a_conflictName)
		varSpellKey = a_keyCode
		IF PlayerRef.HasSpell(GBS_AB_SpellMenu_Hotkey)
			PlayerRef.RemoveSpell(GBS_AB_SpellMenu_Hotkey)
			PlayerRef.AddSpell(GBS_AB_SpellMenu_Hotkey,false)
		ENDIF
		SetKeyMapOptionValueST(a_keyCode)
	ENDEVENT

	EVENT OnDefaultST()
		varSpellKey = 46
		SetKeyMapOptionValueST(46)
	ENDEVENT
ENDSTATE

ACTOR PROPERTY PlayerRef AUTO
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

INT FUNCTION updateSpell(INT index)
	IF index == 1 
		MergeSpells(GBS_Spell00,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GBS_Spell10,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GBS_Spell00,SigSpellList1,SigSpellMag1,SigSpellDur1,SigSpellCost1,SigSpellTimes[-1+index]), GBS_Spell00 )
		RETURN DisplayErrorMessage( MergeSpells(GBS_Spell10,SigSpellList1,SigSpellMag1,SigSpellDur1,SigSpellCost1,SigSpellTimes[-1+index]), GBS_Spell10 )
	ELSEIF index == 2 
		MergeSpells(GBS_Spell01,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GBS_Spell11,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GBS_Spell01,SigSpellList2,SigSpellMag2,SigSpellDur2,SigSpellCost2,SigSpellTimes[-1+index]), GBS_Spell01 )
		RETURN DisplayErrorMessage( MergeSpells(GBS_Spell11,SigSpellList2,SigSpellMag2,SigSpellDur2,SigSpellCost2,SigSpellTimes[-1+index]), GBS_Spell11 )
	ELSEIF index == 3 
		MergeSpells(GBS_Spell02,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GBS_Spell12,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GBS_Spell02,SigSpellList3,SigSpellMag3,SigSpellDur3,SigSpellCost3,SigSpellTimes[-1+index]), GBS_Spell02 )
		RETURN DisplayErrorMessage( MergeSpells(GBS_Spell12,SigSpellList3,SigSpellMag3,SigSpellDur3,SigSpellCost3,SigSpellTimes[-1+index]), GBS_Spell12 )
	ELSEIF index == 4 
		MergeSpells(GBS_Spell03,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GBS_Spell13,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GBS_Spell03,SigSpellList4,SigSpellMag4,SigSpellDur4,SigSpellCost4,SigSpellTimes[-1+index]), GBS_Spell03 )
		RETURN DisplayErrorMessage( MergeSpells(GBS_Spell13,SigSpellList4,SigSpellMag4,SigSpellDur4,SigSpellCost4,SigSpellTimes[-1+index]), GBS_Spell13 )
	ELSEIF index == 5 
		MergeSpells(GBS_Spell04,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GBS_Spell14,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GBS_Spell04,SigSpellList5,SigSpellMag5,SigSpellDur5,SigSpellCost5,SigSpellTimes[-1+index]), GBS_Spell04 )
		RETURN DisplayErrorMessage( MergeSpells(GBS_Spell14,SigSpellList5,SigSpellMag5,SigSpellDur5,SigSpellCost5,SigSpellTimes[-1+index]), GBS_Spell14 )
	ELSEIF index == 6 
		MergeSpells(GBS_Spell05,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GBS_Spell15,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GBS_Spell05,SigSpellList6,SigSpellMag6,SigSpellDur6,SigSpellCost6,SigSpellTimes[-1+index]), GBS_Spell05 )
		RETURN DisplayErrorMessage( MergeSpells(GBS_Spell15,SigSpellList6,SigSpellMag6,SigSpellDur6,SigSpellCost6,SigSpellTimes[-1+index]), GBS_Spell15 )
	ELSEIF index == 7 
		MergeSpells(GBS_Spell06,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GBS_Spell16,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GBS_Spell06,SigSpellList7,SigSpellMag7,SigSpellDur7,SigSpellCost7,SigSpellTimes[-1+index]), GBS_Spell06 )
		RETURN DisplayErrorMessage( MergeSpells(GBS_Spell16,SigSpellList7,SigSpellMag7,SigSpellDur7,SigSpellCost7,SigSpellTimes[-1+index]), GBS_Spell16 )
	ELSEIF index == 8 
		MergeSpells(GBS_Spell07,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GBS_Spell17,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GBS_Spell07,SigSpellList8,SigSpellMag8,SigSpellDur8,SigSpellCost8,SigSpellTimes[-1+index]), GBS_Spell07 )
		RETURN DisplayErrorMessage( MergeSpells(GBS_Spell17,SigSpellList8,SigSpellMag8,SigSpellDur8,SigSpellCost8,SigSpellTimes[-1+index]), GBS_Spell17 )
	ELSEIF index == 9 
		MergeSpells(GBS_Spell08,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GBS_Spell18,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GBS_Spell08,SigSpellList9,SigSpellMag9,SigSpellDur9,SigSpellCost9,SigSpellTimes[-1+index]), GBS_Spell08 )
		RETURN DisplayErrorMessage( MergeSpells(GBS_Spell18,SigSpellList9,SigSpellMag9,SigSpellDur9,SigSpellCost9,SigSpellTimes[-1+index]), GBS_Spell18 )
	ELSEIF index == 10 
		MergeSpells(GBS_Spell09,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		MergeSpells(GBS_Spell19,SigSpellList0,SigSpellMag0,SigSpellDur0,SigSpellCost0,0.5)
		DisplayErrorMessage( MergeSpells(GBS_Spell09,SigSpellList10,SigSpellMag10,SigSpellDur10,SigSpellCost10,SigSpellTimes[-1+index]), GBS_Spell09 )
		RETURN DisplayErrorMessage( MergeSpells(GBS_Spell19,SigSpellList10,SigSpellMag10,SigSpellDur10,SigSpellCost10,SigSpellTimes[-1+index]), GBS_Spell19 )
	ENDIF
	RETURN -10
ENDFUNCTION

FUNCTION UpdateNames(INT index)
	IF index == 1
		GBS_Spell00.SetName(SigSpellNames[-1+index])
		GBS_Spell10.SetName(SigSpellNames[-1+index])
	ELSEIF index == 2
		GBS_Spell01.SetName(SigSpellNames[-1+index])
		GBS_Spell11.SetName(SigSpellNames[-1+index])
	ELSEIF index == 3
		GBS_Spell02.SetName(SigSpellNames[-1+index])
		GBS_Spell12.SetName(SigSpellNames[-1+index])
	ELSEIF index == 4
		GBS_Spell03.SetName(SigSpellNames[-1+index])
		GBS_Spell13.SetName(SigSpellNames[-1+index])
	ELSEIF index == 5
		GBS_Spell04.SetName(SigSpellNames[-1+index])
		GBS_Spell14.SetName(SigSpellNames[-1+index])
	ELSEIF index == 6
		GBS_Spell05.SetName(SigSpellNames[-1+index])
		GBS_Spell15.SetName(SigSpellNames[-1+index])
	ELSEIF index == 7
		GBS_Spell06.SetName(SigSpellNames[-1+index])
		GBS_Spell16.SetName(SigSpellNames[-1+index])
	ELSEIF index == 8
		GBS_Spell07.SetName(SigSpellNames[-1+index])
		GBS_Spell17.SetName(SigSpellNames[-1+index])
	ELSEIF index == 9
		GBS_Spell08.SetName(SigSpellNames[-1+index])
		GBS_Spell18.SetName(SigSpellNames[-1+index])
	ELSEIF index == 10
		GBS_Spell09.SetName(SigSpellNames[-1+index])
		GBS_Spell19.SetName(SigSpellNames[-1+index])
	ENDIF
ENDFUNCTION 

SPELL PROPERTY GBS_IsSpellLoaded AUTO
BOOL SpellFlip = true
FUNCTION updateAllSpells()
	IF !GBS_IsSpellLoaded.GetName()
		GBS_IsSpellLoaded.SetName("1")
		SpellFlip = !SpellFlip
		IF SpellFlip
			PlayerRef.RemoveSpell(GBS_Spell01)
			PlayerRef.RemoveSpell(GBS_Spell02)
			PlayerRef.RemoveSpell(GBS_Spell03)
			PlayerRef.RemoveSpell(GBS_Spell04)
			PlayerRef.RemoveSpell(GBS_Spell05)
			PlayerRef.RemoveSpell(GBS_Spell06)
			PlayerRef.RemoveSpell(GBS_Spell07)
			PlayerRef.RemoveSpell(GBS_Spell08)
			PlayerRef.RemoveSpell(GBS_Spell09)
			PlayerRef.RemoveSpell(GBS_Spell00)
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
		ELSE 
			PlayerRef.RemoveSpell(GBS_Spell11)
			PlayerRef.RemoveSpell(GBS_Spell12)
			PlayerRef.RemoveSpell(GBS_Spell13)
			PlayerRef.RemoveSpell(GBS_Spell14)
			PlayerRef.RemoveSpell(GBS_Spell15)
			PlayerRef.RemoveSpell(GBS_Spell16)
			PlayerRef.RemoveSpell(GBS_Spell17)
			PlayerRef.RemoveSpell(GBS_Spell18)
			PlayerRef.RemoveSpell(GBS_Spell19)
			PlayerRef.RemoveSpell(GBS_Spell10)
			PlayerRef.AddSpell(GBS_Spell01,false)
			PlayerRef.AddSpell(GBS_Spell02,false)
			PlayerRef.AddSpell(GBS_Spell03,false)
			PlayerRef.AddSpell(GBS_Spell04,false)
			PlayerRef.AddSpell(GBS_Spell05,false)
			PlayerRef.AddSpell(GBS_Spell06,false)
			PlayerRef.AddSpell(GBS_Spell07,false)
			PlayerRef.AddSpell(GBS_Spell08,false)
			PlayerRef.AddSpell(GBS_Spell09,false)
			PlayerRef.AddSpell(GBS_Spell00,false)
		ENDIF
		DisplayErrorMessage( MergeSpells(GBS_Spell00,SigSpellList1,SigSpellMag1,SigSpellDur1,SigSpellCost1,SigSpellTimes[0]), GBS_Spell00 )
		DisplayErrorMessage( MergeSpells(GBS_Spell01,SigSpellList2,SigSpellMag2,SigSpellDur2,SigSpellCost2,SigSpellTimes[1]), GBS_Spell01 )
		DisplayErrorMessage( MergeSpells(GBS_Spell02,SigSpellList3,SigSpellMag3,SigSpellDur3,SigSpellCost3,SigSpellTimes[2]), GBS_Spell02 )
		DisplayErrorMessage( MergeSpells(GBS_Spell03,SigSpellList4,SigSpellMag4,SigSpellDur4,SigSpellCost4,SigSpellTimes[3]), GBS_Spell03 )
		DisplayErrorMessage( MergeSpells(GBS_Spell04,SigSpellList5,SigSpellMag5,SigSpellDur5,SigSpellCost5,SigSpellTimes[4]), GBS_Spell04 )
		DisplayErrorMessage( MergeSpells(GBS_Spell05,SigSpellList6,SigSpellMag6,SigSpellDur6,SigSpellCost6,SigSpellTimes[5]), GBS_Spell05 )
		DisplayErrorMessage( MergeSpells(GBS_Spell06,SigSpellList7,SigSpellMag7,SigSpellDur7,SigSpellCost7,SigSpellTimes[6]), GBS_Spell06 )
		DisplayErrorMessage( MergeSpells(GBS_Spell07,SigSpellList8,SigSpellMag8,SigSpellDur8,SigSpellCost8,SigSpellTimes[7]), GBS_Spell07 )
		DisplayErrorMessage( MergeSpells(GBS_Spell08,SigSpellList9,SigSpellMag9,SigSpellDur9,SigSpellCost9,SigSpellTimes[8]), GBS_Spell08 )
		DisplayErrorMessage( MergeSpells(GBS_Spell09,SigSpellList10,SigSpellMag10,SigSpellDur10,SigSpellCost10,SigSpellTimes[9]), GBS_Spell09 )
		DisplayErrorMessage( MergeSpells(GBS_Spell10,SigSpellList1,SigSpellMag1,SigSpellDur1,SigSpellCost1,SigSpellTimes[0]), GBS_Spell10 )
		DisplayErrorMessage( MergeSpells(GBS_Spell11,SigSpellList2,SigSpellMag2,SigSpellDur2,SigSpellCost2,SigSpellTimes[1]), GBS_Spell11 )
		DisplayErrorMessage( MergeSpells(GBS_Spell12,SigSpellList3,SigSpellMag3,SigSpellDur3,SigSpellCost3,SigSpellTimes[2]), GBS_Spell12 )
		DisplayErrorMessage( MergeSpells(GBS_Spell13,SigSpellList4,SigSpellMag4,SigSpellDur4,SigSpellCost4,SigSpellTimes[3]), GBS_Spell13 )
		DisplayErrorMessage( MergeSpells(GBS_Spell14,SigSpellList5,SigSpellMag5,SigSpellDur5,SigSpellCost5,SigSpellTimes[4]), GBS_Spell14 )
		DisplayErrorMessage( MergeSpells(GBS_Spell15,SigSpellList6,SigSpellMag6,SigSpellDur6,SigSpellCost6,SigSpellTimes[5]), GBS_Spell15 )
		DisplayErrorMessage( MergeSpells(GBS_Spell16,SigSpellList7,SigSpellMag7,SigSpellDur7,SigSpellCost7,SigSpellTimes[6]), GBS_Spell16 )
		DisplayErrorMessage( MergeSpells(GBS_Spell17,SigSpellList8,SigSpellMag8,SigSpellDur8,SigSpellCost8,SigSpellTimes[7]), GBS_Spell17 )
		DisplayErrorMessage( MergeSpells(GBS_Spell18,SigSpellList9,SigSpellMag9,SigSpellDur9,SigSpellCost9,SigSpellTimes[8]), GBS_Spell18 )
		DisplayErrorMessage( MergeSpells(GBS_Spell19,SigSpellList10,SigSpellMag10,SigSpellDur10,SigSpellCost10,SigSpellTimes[9]), GBS_Spell19 )
		SetSpellDelivery(GBS_Spell00,SigSpellDeliveries[0])
		SetSpellDelivery(GBS_Spell01,SigSpellDeliveries[1])
		SetSpellDelivery(GBS_Spell02,SigSpellDeliveries[2])
		SetSpellDelivery(GBS_Spell03,SigSpellDeliveries[3])
		SetSpellDelivery(GBS_Spell04,SigSpellDeliveries[4])
		SetSpellDelivery(GBS_Spell05,SigSpellDeliveries[5])
		SetSpellDelivery(GBS_Spell06,SigSpellDeliveries[6])
		SetSpellDelivery(GBS_Spell07,SigSpellDeliveries[7])
		SetSpellDelivery(GBS_Spell08,SigSpellDeliveries[8])
		SetSpellDelivery(GBS_Spell09,SigSpellDeliveries[9])
		SetSpellDelivery(GBS_Spell10,SigSpellDeliveries[0])
		SetSpellDelivery(GBS_Spell11,SigSpellDeliveries[1])
		SetSpellDelivery(GBS_Spell12,SigSpellDeliveries[2])
		SetSpellDelivery(GBS_Spell13,SigSpellDeliveries[3])
		SetSpellDelivery(GBS_Spell14,SigSpellDeliveries[4])
		SetSpellDelivery(GBS_Spell15,SigSpellDeliveries[5])
		SetSpellDelivery(GBS_Spell16,SigSpellDeliveries[6])
		SetSpellDelivery(GBS_Spell17,SigSpellDeliveries[7])
		SetSpellDelivery(GBS_Spell18,SigSpellDeliveries[8])
		SetSpellDelivery(GBS_Spell19,SigSpellDeliveries[9])
		
		SetSpellCastType(GBS_Spell00,SigSpellCastTypes[0])
		SetSpellCastType(GBS_Spell01,SigSpellCastTypes[1])
		SetSpellCastType(GBS_Spell02,SigSpellCastTypes[2])
		SetSpellCastType(GBS_Spell03,SigSpellCastTypes[3])
		SetSpellCastType(GBS_Spell04,SigSpellCastTypes[4])
		SetSpellCastType(GBS_Spell05,SigSpellCastTypes[5])
		SetSpellCastType(GBS_Spell06,SigSpellCastTypes[6])
		SetSpellCastType(GBS_Spell07,SigSpellCastTypes[7])
		SetSpellCastType(GBS_Spell08,SigSpellCastTypes[8])
		SetSpellCastType(GBS_Spell09,SigSpellCastTypes[9])
		SetSpellCastType(GBS_Spell10,SigSpellCastTypes[0])
		SetSpellCastType(GBS_Spell11,SigSpellCastTypes[1])
		SetSpellCastType(GBS_Spell12,SigSpellCastTypes[2])
		SetSpellCastType(GBS_Spell13,SigSpellCastTypes[3])
		SetSpellCastType(GBS_Spell14,SigSpellCastTypes[4])
		SetSpellCastType(GBS_Spell15,SigSpellCastTypes[5])
		SetSpellCastType(GBS_Spell16,SigSpellCastTypes[6])
		SetSpellCastType(GBS_Spell17,SigSpellCastTypes[7])
		SetSpellCastType(GBS_Spell18,SigSpellCastTypes[8])
		SetSpellCastType(GBS_Spell19,SigSpellCastTypes[9])
		
		GBS_Spell00.SetName(SigSpellNames[0])
		GBS_Spell01.SetName(SigSpellNames[1])
		GBS_Spell02.SetName(SigSpellNames[2])
		GBS_Spell03.SetName(SigSpellNames[3])
		GBS_Spell04.SetName(SigSpellNames[4])
		GBS_Spell05.SetName(SigSpellNames[5])
		GBS_Spell06.SetName(SigSpellNames[6])
		GBS_Spell07.SetName(SigSpellNames[7])
		GBS_Spell08.SetName(SigSpellNames[8])
		GBS_Spell09.SetName(SigSpellNames[9])
		GBS_Spell10.SetName(SigSpellNames[0])
		GBS_Spell11.SetName(SigSpellNames[1])
		GBS_Spell12.SetName(SigSpellNames[2])
		GBS_Spell13.SetName(SigSpellNames[3])
		GBS_Spell14.SetName(SigSpellNames[4])
		GBS_Spell15.SetName(SigSpellNames[5])
		GBS_Spell16.SetName(SigSpellNames[6])
		GBS_Spell17.SetName(SigSpellNames[7])
		GBS_Spell18.SetName(SigSpellNames[8])
		GBS_Spell19.SetName(SigSpellNames[9])
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
SPELL[] PROPERTY SigSpellList6 AUTO
SPELL[] PROPERTY SigSpellList7 AUTO
SPELL[] PROPERTY SigSpellList8 AUTO
SPELL[] PROPERTY SigSpellList9 AUTO
SPELL[] PROPERTY SigSpellList10 AUTO

FLOAT[] PROPERTY SigSpellMag1 AUTO
FLOAT[] PROPERTY SigSpellMag2 AUTO
FLOAT[] PROPERTY SigSpellMag3 AUTO
FLOAT[] PROPERTY SigSpellMag4 AUTO
FLOAT[] PROPERTY SigSpellMag5 AUTO
FLOAT[] PROPERTY SigSpellMag6 AUTO
FLOAT[] PROPERTY SigSpellMag7 AUTO
FLOAT[] PROPERTY SigSpellMag8 AUTO
FLOAT[] PROPERTY SigSpellMag9 AUTO
FLOAT[] PROPERTY SigSpellMag10 AUTO

FLOAT[] PROPERTY SigSpellDur1 AUTO
FLOAT[] PROPERTY SigSpellDur2 AUTO
FLOAT[] PROPERTY SigSpellDur3 AUTO
FLOAT[] PROPERTY SigSpellDur4 AUTO
FLOAT[] PROPERTY SigSpellDur5 AUTO
FLOAT[] PROPERTY SigSpellDur6 AUTO
FLOAT[] PROPERTY SigSpellDur7 AUTO
FLOAT[] PROPERTY SigSpellDur8 AUTO
FLOAT[] PROPERTY SigSpellDur9 AUTO
FLOAT[] PROPERTY SigSpellDur10 AUTO

FLOAT[] PROPERTY SigSpellCost1 AUTO
FLOAT[] PROPERTY SigSpellCost2 AUTO
FLOAT[] PROPERTY SigSpellCost3 AUTO
FLOAT[] PROPERTY SigSpellCost4 AUTO
FLOAT[] PROPERTY SigSpellCost5 AUTO
FLOAT[] PROPERTY SigSpellCost6 AUTO
FLOAT[] PROPERTY SigSpellCost7 AUTO
FLOAT[] PROPERTY SigSpellCost8 AUTO
FLOAT[] PROPERTY SigSpellCost9 AUTO
FLOAT[] PROPERTY SigSpellCost10 AUTO

FLOAT[] PROPERTY SigSpellTimes AUTO
INT[] PROPERTY SigSpellDeliveries AUTO 
INT[] PROPERTY SigSpellCastTypes AUTO

STRING[] PROPERTY SigSpellNames AUTO