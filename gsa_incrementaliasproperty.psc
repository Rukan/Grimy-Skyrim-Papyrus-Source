Scriptname GSA_IncrementAliasProperty extends activemagiceffect

GSA_WeaponAlias PROPERTY BattleaxeAlias AUTO
GSA_WeaponAlias PROPERTY BowAlias AUTO
GSA_WeaponAlias PROPERTY CrossbowAlias AUTO
GSA_WeaponAlias PROPERTY DaggerAlias AUTO
GSA_WeaponAlias PROPERTY GreatswordAlias AUTO
GSA_WeaponAlias PROPERTY MaceAlias AUTO
GSA_WeaponAlias PROPERTY SwordAlias AUTO
GSA_WeaponAlias PROPERTY WarAxeAlias AUTO
GSA_WeaponAlias PROPERTY WarhammerAlias AUTO

INT PROPERTY propertyIndex AUTO

SCROLL PROPERTY thisScroll AUTO
ACTOR PROPERTY PlayerRef AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	OBJECTREFERENCE tempRef = Game.GetCurrentCrosshairRef()
	WEAPON tempWeapon = tempRef.GetBaseObject() AS WEAPON

	IF tempWeapon
		IF tempWeapon.IsBattleAxe() 
			applySpell(BattleaxeAlias,tempRef)
		ELSEIF tempWeapon.IsBow() 
			IF tempWeapon.GetWeaponType() == 7 ; Bow
				applySpell(BowAlias,tempRef)
			ELSE ; Crossbow
				applySpell(CrossbowAlias,tempRef)
			ENDIF
		ELSEIF tempWeapon.IsDagger() 
			applySpell(DaggerAlias,tempRef)
		ELSEIF tempWeapon.IsGreatsword() 
			applySpell(GreatswordAlias,tempRef)
		ELSEIF tempWeapon.IsMace() 
			applySpell(MaceAlias,tempRef)
		ELSEIF tempWeapon.IsSword() 
			applySpell(SwordAlias,tempRef)
		ELSEIF tempWeapon.IsWarAxe() 
			applySpell(WarAxeAlias,tempRef)
		ELSEIF tempWeapon.IsWarhammer() 
			applySpell(WarhammerAlias,tempRef)
		ELSE
			PlayerRef.Additem(thisScroll,1,true)
		ENDIF
	ELSE
		PlayerRef.Additem(thisScroll,1,true)
	ENDIF
ENDEVENT

FUNCTION applySpell(GSA_WeaponAlias akAlias, OBJECTREFERENCE akRef)
	IF akAlias.GetRef() != akRef
		Debug.Notification("You can only upgrade signature items")
		PlayerRef.Additem(thisScroll,1,true)
		RETURN
	ENDIF

	INT applyStatus = akAlias.addSpellSlot(  StringUtil.Substring(thisScroll.GetName(),0,-10+StringUtil.GetLength(thisScroll.GetName()) )  , None, GetMagnitude())
	IF applyStatus == -1
		Debug.Notification("That item already has this upgrade")
		PlayerRef.Additem(thisScroll,1,true)
	ELSEIF applyStatus == 0
		Debug.Notification("No more upgrade slots left")
		PlayerRef.Additem(thisScroll,1,true)
	ELSEIF applyStatus == 1
		IF propertyIndex == 1
			akAlias.myBaseDamage += GetMagnitude() AS INT
		ELSEIF propertyIndex == 2
			akAlias.myCritDamage += GetMagnitude() AS INT
		ELSEIF propertyIndex == 3
			akAlias.myCritMultiplier += GetMagnitude()/100.0
		ELSEIF propertyIndex == 4
			akAlias.myReach += GetMagnitude()/100.0
		ELSEIF propertyIndex == 5
			akAlias.mySpeed += GetMagnitude()/100.0
		ELSEIF propertyIndex == 6
			akAlias.myWeight += GetMagnitude()/100.0
		ENDIF
		akAlias.updateStats()
		akRef.Activate(PlayerRef)
	ENDIF
ENDFUNCTION
