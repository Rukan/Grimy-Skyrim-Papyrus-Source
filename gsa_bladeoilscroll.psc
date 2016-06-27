Scriptname GSA_BladeOilScroll extends activemagiceffect 

GSA_WeaponAlias PROPERTY BattleaxeAlias AUTO
GSA_WeaponAlias PROPERTY BowAlias AUTO
GSA_WeaponAlias PROPERTY CrossbowAlias AUTO
GSA_WeaponAlias PROPERTY DaggerAlias AUTO
GSA_WeaponAlias PROPERTY GreatswordAlias AUTO
GSA_WeaponAlias PROPERTY MaceAlias AUTO
GSA_WeaponAlias PROPERTY SwordAlias AUTO
GSA_WeaponAlias PROPERTY WarAxeAlias AUTO
GSA_WeaponAlias PROPERTY WarhammerAlias AUTO

INT PROPERTY creatureIndex AUTO
SPELL PROPERTY oilSpell2H AUTO
SPELL PROPERTY oilSpellDagger AUTO
SPELL PROPERTY oilSpellMace AUTO
SPELL PROPERTY oilSpellSword AUTO
SPELL PROPERTY oilSpellWarAxe AUTO
SCROLL PROPERTY thisScroll AUTO
ACTOR PROPERTY PlayerRef AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	OBJECTREFERENCE tempRef = Game.GetCurrentCrosshairRef()
	WEAPON tempWeapon = tempRef.GetBaseObject() AS WEAPON

	IF tempWeapon
		IF tempWeapon.IsBattleAxe() 
			applyOil(BattleaxeAlias,tempRef,oilSpell2H)
		ELSEIF tempWeapon.IsBow() 
			IF tempWeapon.GetWeaponType() == 7 ; Bow
				applyOil(BowAlias,tempRef,oilSpell2H)
			ELSE ; Crossbow
				applyOil(CrossbowAlias,tempRef,oilSpell2H)
			ENDIF
		ELSEIF tempWeapon.IsDagger() 
			applyOil(DaggerAlias,tempRef,oilSpellDagger)
		ELSEIF tempWeapon.IsGreatsword() 
			applyOil(GreatswordAlias,tempRef,oilSpell2H)
		ELSEIF tempWeapon.IsMace() 
			applyOil(MaceAlias,tempRef,oilSpellMace)
		ELSEIF tempWeapon.IsSword() 
			applyOil(SwordAlias,tempRef,oilSpellSword)
		ELSEIF tempWeapon.IsWarAxe() 
			applyOil(WarAxeAlias,tempRef,oilSpellWarAxe)
		ELSEIF tempWeapon.IsWarhammer() 
			applyOil(WarhammerAlias,tempRef,oilSpell2H)
		ELSE
			PlayerRef.Additem(thisScroll,1,true)
		ENDIF
	ELSE
		PlayerRef.Additem(thisScroll,1,true)
	ENDIF
	Dispel()
ENDEVENT

FUNCTION applyOil(GSA_WeaponAlias akAlias, OBJECTREFERENCE akRef, SPELL oilSpell)
	IF akAlias.GetRef() != akRef
		Debug.Notification("You can only upgrade signature items")
		PlayerRef.Additem(thisScroll,1,true)
		Dispel()
		RETURN
	ENDIF

	akAlias.attachBladeOil( oilSpell, GetMagnitude(), creatureIndex )
	akRef.Activate(PlayerRef)
	Dispel()
ENDFUNCTION