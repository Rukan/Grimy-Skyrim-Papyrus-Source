Scriptname GSA_Magic_ResetScroll extends activemagiceffect  

GSA_ArmorAlias PROPERTY lightHelmetAlias AUTO
GSA_ArmorAlias PROPERTY lightCuirassAlias AUTO
GSA_ArmorAlias PROPERTY lightGauntletsAlias AUTO
GSA_ArmorAlias PROPERTY lightBootsAlias AUTO
GSA_ArmorAlias PROPERTY lightShieldAlias AUTO

GSA_ArmorAlias PROPERTY heavyHelmetAlias AUTO
GSA_ArmorAlias PROPERTY heavyCuirassAlias AUTO
GSA_ArmorAlias PROPERTY heavyGauntletsAlias AUTO
GSA_ArmorAlias PROPERTY heavyBootsAlias AUTO
GSA_ArmorAlias PROPERTY heavyShieldAlias AUTO

GSA_WeaponAlias PROPERTY BattleaxeAlias AUTO
GSA_WeaponAlias PROPERTY BowAlias AUTO
GSA_WeaponAlias PROPERTY DaggerAlias AUTO
GSA_WeaponAlias PROPERTY GreatswordAlias AUTO
GSA_WeaponAlias PROPERTY MaceAlias AUTO
GSA_WeaponAlias PROPERTY SwordAlias AUTO
GSA_WeaponAlias PROPERTY WarAxeAlias AUTO
GSA_WeaponAlias PROPERTY WarhammerAlias AUTO

WEAPON PROPERTY GSA_Battleaxe AUTO
WEAPON PROPERTY GSA_Bow AUTO
WEAPON PROPERTY GSA_Dagger AUTO
WEAPON PROPERTY GSA_Greatsword AUTO
WEAPON PROPERTY GSA_Mace AUTO
WEAPON PROPERTY GSA_Sword AUTO
WEAPON PROPERTY GSA_WarAxe AUTO
WEAPON PROPERTY GSA_Warhammer AUTO

SCROLL PROPERTY GSA_Scroll_Reset AUTO
ACTOR PROPERTY PlayerRef AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	OBJECTREFERENCE tempRef = Game.GetCurrentCrosshairRef()
	ARMOR tempArmor = tempRef.GetBaseObject() AS ARMOR
	WEAPON tempWeapon = tempRef.GetBaseObject() AS WEAPON

	IF tempArmor
		IF tempArmor.GetWeightClass() == 0
			IF  tempArmor.IsHelmet()
				applySpell(lightHelmetAlias,tempRef)
			ELSEIF tempArmor.IsCuirass()
				applySpell(lightCuirassAlias,tempRef)
			ELSEIF tempArmor.IsGauntlets()
				applySpell(lightGauntletsAlias,tempRef)
			ELSEIF tempArmor.IsBoots()
				applySpell(lightBootsAlias,tempRef)
			ELSEIF tempArmor.IsShield()
				applySpell(lightShieldAlias,tempRef)
			ENDIF
		ELSEIF tempArmor.GetWeightClass() == 1
			IF  tempArmor.IsHelmet()
				applySpell(heavyHelmetAlias,tempRef)
			ELSEIF tempArmor.IsCuirass()
				applySpell(heavyCuirassAlias,tempRef)
			ELSEIF tempArmor.IsGauntlets()
				applySpell(heavyGauntletsAlias,tempRef)
			ELSEIF tempArmor.IsBoots()
				applySpell(heavyHelmetAlias,tempRef)
			ELSEIF tempArmor.IsShield()
				applySpell(heavyShieldAlias,tempRef)
			ENDIF
		ENDIF
	ELSEIF tempWeapon
		IF tempWeapon == GSA_Battleaxe
			BattleaxeAlias.ResetStats()
		ELSEIF tempWeapon == GSA_Bow
			BowAlias.ResetStats()
		ELSEIF tempWeapon == GSA_Dagger
			DaggerAlias.ResetStats()
		ELSEIF tempWeapon == GSA_Greatsword
			GreatswordAlias.ResetStats()
		ELSEIF tempWeapon == GSA_Mace
			MaceAlias.ResetStats()
		ELSEIF tempWeapon == GSA_Sword
			SwordAlias.ResetStats()
		ELSEIF tempWeapon == GSA_WarAxe
			WarAxeAlias.ResetStats()
		ELSEIF tempWeapon == GSA_Warhammer
			WarhammerAlias.ResetStats()
		ELSE
			PlayerRef.Additem(GSA_Scroll_Reset,1,true)
			Dispel()
			RETURN
		ENDIF
		tempRef.Activate(PlayerRef)
	ELSE
		PlayerRef.Additem(GSA_Scroll_Reset,1,true)
		Dispel()
		RETURN
	ENDIF
	Dispel()
ENDEVENT

FUNCTION applySpell(GSA_ArmorAlias akAlias, OBJECTREFERENCE akRef)
	IF akAlias.GetRef() != akRef
		Debug.Notification("That is not a signature item")
		PlayerRef.Additem(GSA_Scroll_Reset,1,true)
		Dispel()
		RETURN
	ENDIF

	akAlias.resetStats()
	akRef.Activate(PlayerRef)
	Dispel()
ENDFUNCTION