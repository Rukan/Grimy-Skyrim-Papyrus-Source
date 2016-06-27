Scriptname GVC_Hotkey_Grenadier extends activemagiceffect  

PERK PROPERTY GVC_Perk_A03_Sapper AUTO
PERK PROPERTY GVC_Perk_A01_Grenadier AUTO
EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	ReRegisterHotKeys()
ENDEVENT

EVENT OnPlayerLoadGame()
	ReRegisterHotKeys()
ENDEVENT

FUNCTION ReRegisterHotKeys()
	UnregisterForAllKeys()
	IF PlayerRef.HasPerk(GVC_Perk_A01_Grenadier) && GVC_Hotkey_Selection.GetValueInt() < 10
		RegisterForKey(GVC_KeyNum_Grenade.GetValueInt())
		GoToState("Grenade")
	ELSEIF PlayerRef.HasPerk(GVC_Perk_A03_Sapper) && GVC_Hotkey_Selection.GetValueInt() >= 10
		RegisterForKey(GVC_KeyNum_Grenade.GetValueInt())
		GoToState("Grenade")
	ENDIF
ENDFUNCTION
GLOBALVARIABLE PROPERTY GVC_KeyNum_Grenade AUTO
GLOBALVARIABLE PROPERTY GVC_Hotkey_Selection AUTO
STRING[] PROPERTY MessageList AUTO
QUEST PROPERTY UILib AUTO

STATE Grenade
	EVENT OnKeyDown(Int KeyCode)
		IF ( Game.IsLookingControlsEnabled() && !Utility.IsInMenuMode() && !((UILib as FORM) as UILIB_GRIMY).IsMenuOpen())
			int tempSelection = GVC_Hotkey_Selection.GetValueInt()
			IF tempSelection < 6
				IF tempSelection < 3
					IF tempSelection == 0
						throwGrenade(GVC_Scroll_GenericFire)
					ELSEIF tempSelection == 1
						throwGrenade(GVC_Scroll_GenericFrost)
					ELSE ; == 2
						throwGrenade(GVC_Scroll_GenericShock)
					ENDIF
				ELSE
					IF tempSelection == 3
						throwGrenade(GVC_Scroll_GenericMagic)
					ELSEIF tempSelection == 4
						throwGrenade(GVC_Scroll_GenericPoison)
					ELSE ; == 5
						throwGrenade(GVC_Scroll_GenericPhysical)
					ENDIF
				ENDIF
			ELSEIF tempSelection < 12
				IF tempSelection < 9
					IF tempSelection == 6
						throwGrenade(GVC_Scroll_MineFire)
					ELSEIF tempSelection == 7
						throwGrenade(GVC_Scroll_MineFrost)
					ELSE ; == 8
						throwGrenade(GVC_Scroll_MineShock)
					ENDIF
				ELSE
					IF tempSelection == 9
						throwGrenade(GVC_Scroll_MineMagic)
					ELSEIF tempSelection == 10
						throwGrenade(GVC_Scroll_MinePoison)
					ELSE ; == 11
						throwGrenade(GVC_Scroll_MinePhysical)
					ENDIF
				ENDIF
			ELSE
				IF tempSelection < 15
					IF tempSelection == 12
						throwGrenade(GVC_Scroll_DwemerMineFire)
					ELSEIF tempSelection == 13
						throwGrenade(GVC_Scroll_DwemerMineFrost)
					ELSE ; == 14
						throwGrenade(GVC_Scroll_DwemerMineShock)
					ENDIF
				ELSE
					IF tempSelection == 15
						throwGrenade(GVC_Scroll_DwemerMineMagic)
					ELSEIF tempSelection == 16
						throwGrenade(GVC_Scroll_DwemerMinePoison)
					ELSE ; == 17
						throwGrenade(GVC_Scroll_DwemerMinePhysical)
					ENDIF
				ENDIF
			ENDIF
		EndIf
	ENDEVENT
ENDSTATE

SCROLL PROPERTY GVC_Scroll_DwemerMineFire AUTO
SCROLL PROPERTY GVC_Scroll_DwemerMineFrost AUTO
SCROLL PROPERTY GVC_Scroll_DwemerMineShock AUTO
SCROLL PROPERTY GVC_Scroll_DwemerMinePhysical AUTO
SCROLL PROPERTY GVC_Scroll_DwemerMinePoison AUTO
SCROLL PROPERTY GVC_Scroll_DwemerMineMagic AUTO

SCROLL PROPERTY GVC_Scroll_MineFire AUTO
SCROLL PROPERTY GVC_Scroll_MineFrost AUTO
SCROLL PROPERTY GVC_Scroll_MineShock AUTO
SCROLL PROPERTY GVC_Scroll_MinePhysical AUTO
SCROLL PROPERTY GVC_Scroll_MinePoison AUTO
SCROLL PROPERTY GVC_Scroll_MineMagic AUTO

SCROLL PROPERTY GVC_Scroll_GenericFire AUTO
SCROLL PROPERTY GVC_Scroll_GenericFrost AUTO
SCROLL PROPERTY GVC_Scroll_GenericShock AUTO
SCROLL PROPERTY GVC_Scroll_GenericPhysical AUTO
SCROLL PROPERTY GVC_Scroll_GenericPoison AUTO
SCROLL PROPERTY GVC_Scroll_GenericMagic AUTO

FUNCTION throwGrenade(SCROLL akAmmo)
	IF PlayerRef.IsInCombat() || PlayerRef.IsSneaking()
		IF PlayerRef.GetItemCount(akAmmo) > 0
			PlayerRef.RemoveItem(akAmmo,1,true)
			tempAmmo = akAmmo
			GoToState("Cooldown")
		ELSE
			Debug.Notification("No more " + akAmmo.GetName() + " left!")
			grenadePrompt()
		ENDIF
	ELSE
		grenadePrompt()
	ENDIF
ENDFUNCTION

FUNCTION grenadePrompt()
	int Result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Bind Explosive to Hotkey", MessageList, 0,0)
	IF ( Result >= 0 ) && ( Result < 18 )
		GVC_Hotkey_Selection.SetValueInt( Result )
		ReRegisterHotKeys()
	ENDIF
ENDFUNCTION

SCROLL tempAmmo
STATE Cooldown
	EVENT OnBeginState()
		tempAmmo.Cast(PlayerRef)
		RegisterForSingleUpdate(GVC_Grenade_Cooldown.GetValue())
	ENDEVENT
	
	EVENT OnUpdate()
		GoToState("Grenade")
	ENDEVENT
ENDSTATE

ACTOR PROPERTY PlayerRef AUTO
GLOBALVARIABLE PROPERTY GVC_Grenade_Cooldown AUTO