Scriptname GSA_MenuMainPlayerRef extends ReferenceAlias  

ACTOR PROPERTY PlayerRef AUTO
SPELL PROPERTY GSA_LoadAliasSettings AUTO
KEYWORD PROPERTY GSA_SignatureWeapon AUTO
BOOL PROPERTY swapToggle AUTO
GVC_MenuMain PROPERTY MenuMain1 AUTO
GSA_MenuMain PROPERTY MenuMain2 AUTO
GELO_MenuMain PROPERTY MenuMain3 AUTO
GAA_MenuMain PROPERTY MenuMain4 AUTO
GAT_MenuMain PROPERTY MenuMain5 AUTO

Event OnPlayerLoadGame()
	MenuMain1.OnGameReload()
	MenuMain2.OnGameReload()
	MenuMain3.OnGameReload()
	MenuMain4.OnGameReload()
	MenuMain5.OnGameReload()

	MenuMain4.RegisterKeys()
	GSA_LoadAliasSettings.Cast(PlayerRef,PlayerRef)
	IF swapToggle
		Utility.Wait(0.5)
		swapWeapon(true,PlayerRef.GetEquippedWeapon(true))
		swapWeapon(false,PlayerRef.GetEquippedWeapon(false))
	ENDIF
EndEvent

FUNCTION swapWeapon(BOOL leftHand, WEAPON akWeapon)
	IF akWeapon
		IF akWeapon.HasKeyword(GSA_SignatureWeapon)
			IF leftHand
				PlayerRef.UnequipItemEx(akWeapon, 2)
				Utility.Wait(0.1)
				PlayerRef.EquipItemEx(akWeapon, 2)
			ELSE
				PlayerRef.UnequipItemEx(akWeapon, 1)
				Utility.Wait(0.1)
				PlayerRef.EquipItemEx(akWeapon, 1)
			ENDIF
		ENDIF
	ENDIF
ENDFUNCTION