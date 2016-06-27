Scriptname GAA_MenuMain extends SKI_ConfigBase  

INT FUNCTION GetVersion()
	return 1
ENDFUNCTION

EVENT OnVersionUpdate(int a_version)
	;Debug.Notification("Updating Signature Arms MCM menu")
	refreshPages()
ENDEVENT

EVENT OnConfigInit()
	refreshPages()
ENDEVENT

FUNCTION refreshPages()
	Pages = new string[2]
	Pages[0] = "Settings"
	Pages[1] = "Perks"
ENDFUNCTION

EVENT OnPageReset(string page)
	refreshPages()
	IF page == "Perks"
	ELSE
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Hotkeys")
		AddKeyMapOptionST("ARMOR_OID","Armor Ability Key",varArmorKey)
		
		SetCursorPosition(1)
		AddTextOption("Coming Soon!","")
	ENDIF
ENDEVENT

STATE ARMOR_OID
	EVENT OnKeyMapChangeST(int a_keyCode, string a_conflictControl, string a_conflictName)
		varArmorKey = a_keyCode
		registerKeys()
		SetKeyMapOptionValueST(a_keyCode)
	ENDEVENT

	EVENT OnDefaultST()
		varArmorKey = -1
		 SetKeyMapOptionValueST(-1)
	ENDEVENT
ENDSTATE

INT PROPERTY varArmorKey AUTO

SPELL[] PROPERTY AbilitySpells AUTO
FLOAT[] PROPERTY AbilityCosts AUTO
FLOAT[] PROPERTY AbilityCooldowns AUTO
FLOAT[] PROPERTY AbilityTime AUTO
FORM[] PROPERTY AbilitySounds AUTO

GSA_MenuMain PROPERTY UILib AUTO

IMPORT input

EVENT OnKeyDown(Int KeyCode)
	IF ( Game.IsLookingControlsEnabled() && !Utility.IsInMenuMode() && !((UILib as FORM) as UILIB_GRIMY).IsMenuOpen())
		INT akIndex = ((UILib as FORM) as UILIB_GRIMY).ShowList("Armor Abilities", AbilityList(), 0, 0) - 1
		IF akIndex >= 0
			IF ( Utility.GetCurrentRealTime() - AbilityTime[akIndex] ) < AbilityCooldowns[akIndex]
				Debug.Notification("That ability is still on cooldown")
				RETURN
			ENDIF
			IF AbilitySpells[akIndex] && ( PlayerRef.GetAV("Stamina") > AbilityCosts[akIndex] )
				AbilityTime[akIndex] = Utility.GetCurrentRealTime()
				PlayerRef.DamageAV("Stamina",AbilityCosts[akIndex])
				AbilitySpells[akIndex].Cast(PlayerRef)
				IF AbilitySounds[akIndex]
					(AbilitySounds[akIndex] AS SOUND).Play(PlayerRef)
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDEVENT

STRING[] FUNCTION AbilityList()
	STRING[] retVal = new String[6]
	INT i = 0
	int j = 0
	WHILE i < 5
		STRING tempName = AbilityName(i)
		IF tempName != "~"
			retVal[i] = tempName
			j += 1
		ENDIF
		i += 1
	ENDWHILE
	retVal[j] = "Cancel"
	
	RETURN retVal
ENDFUNCTION

STRING FUNCTION AbilityName(INT akIndex)
	IF AbilitySpells[akIndex]
		RETURN AbilitySpells[akIndex].GetName()
	ELSE
		RETURN "~"
	ENDIF
ENDFUNCTION

FUNCTION registerKeys()
	UnregisterForAllKeys()
	RegisterForKey(varArmorKey)
ENDFUNCTION

ACTOR PROPERTY PlayerRef AUTO

INT FUNCTION GetHeavyArmorCount(ACTOR akActor)
	INT result = 0
	result += isHeavy(akActor.GetWornForm(0x00000002))
	result += isHeavy(akActor.GetWornForm(0x00000004))
	result += isHeavy(akActor.GetWornForm(0x00000008))
	result += isHeavy(akActor.GetWornForm(0x00000080))
	RETURN result
ENDFUNCTION

INT FUNCTION isHeavy(FORM akForm)
	IF akForm AS ARMOR
		IF (akForm AS ARMOR).GetWeightClass() == 1
			RETURN 1
		ENDIF
	ENDIF
	RETURN 0
ENDFUNCTION