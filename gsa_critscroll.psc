Scriptname GSA_CritScroll extends activemagiceffect  

GSA_WeaponAlias PROPERTY BattleaxeAlias AUTO
GSA_WeaponAlias PROPERTY BowAlias AUTO
GSA_WeaponAlias PROPERTY CrossbowAlias AUTO
GSA_WeaponAlias PROPERTY DaggerAlias AUTO
GSA_WeaponAlias PROPERTY GreatswordAlias AUTO
GSA_WeaponAlias PROPERTY MaceAlias AUTO
GSA_WeaponAlias PROPERTY SwordAlias AUTO
GSA_WeaponAlias PROPERTY WarAxeAlias AUTO
GSA_WeaponAlias PROPERTY WarhammerAlias AUTO

SCROLL PROPERTY thisScroll AUTO
ACTOR PROPERTY PlayerRef AUTO
SPELL PROPERTY Spell2H AUTO
SPELL PROPERTY SpellDagger AUTO
SPELL PROPERTY SpellMace AUTO
SPELL PROPERTY SpellSword AUTO
SPELL PROPERTY SpellWarAxe AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	OBJECTREFERENCE tempRef = Game.GetCurrentCrosshairRef()
	WEAPON tempWeapon = tempRef.GetBaseObject() AS WEAPON

	IF tempWeapon
		IF tempWeapon.IsBattleAxe() 
			applySpell(BattleaxeAlias,tempRef,Spell2H)
		ELSEIF tempWeapon.IsBow() 
			IF tempWeapon.GetWeaponType() == 7 ; Bow
				applySpell(BowAlias,tempRef,Spell2H)
			ELSE ; Crossbow
				applySpell(CrossbowAlias,tempRef,Spell2H)
			ENDIF
		ELSEIF tempWeapon.IsDagger() 
			applySpell(DaggerAlias,tempRef,SpellDagger)
		ELSEIF tempWeapon.IsGreatsword() 
			applySpell(GreatswordAlias,tempRef,Spell2H)
		ELSEIF tempWeapon.IsMace() 
			applySpell(MaceAlias,tempRef,SpellMace)
		ELSEIF tempWeapon.IsSword() 
			applySpell(SwordAlias,tempRef,SpellSword)
		ELSEIF tempWeapon.IsWarAxe() 
			applySpell(WarAxeAlias,tempRef,SpellWarAxe)
		ELSEIF tempWeapon.IsWarhammer() 
			applySpell(WarhammerAlias,tempRef,Spell2H)
		ELSE
			PlayerRef.Additem(thisScroll,1,true)
		ENDIF
	ELSE
		PlayerRef.Additem(thisScroll,1,true)
	ENDIF
	Dispel()
ENDEVENT

FLOAT PROPERTY akMag2Mult = 1.0 AUTO
FUNCTION applySpell(GSA_WeaponAlias akAlias, OBJECTREFERENCE akRef, SPELL akSpell)
	IF akAlias.GetRef() != akRef
		Debug.Notification("You can only upgrade signature items")
		PlayerRef.Additem(thisScroll,1,true)
		Dispel()
		RETURN
	ENDIF

	IF akAlias == None
		Debug.Notification("You can't apply this upgrade to this item type")
		PlayerRef.Additem(thisScroll,1,true)
		Dispel()
		RETURN
	ENDIF

	INT applyStatus = akAlias.addCritSlot(  StringUtil.Substring(thisScroll.GetName(),0,-10+StringUtil.GetLength(thisScroll.GetName()) )  , akSpell, getMagnitude(), akMag2Mult)
	IF applyStatus == -1
		Debug.Notification("That item already has this upgrade")
		PlayerRef.Additem(thisScroll,1,true)
	ELSEIF applyStatus == 0
		Debug.Notification("No more upgrade slots left")
		PlayerRef.Additem(thisScroll,1,true)
	ELSEIF applyStatus == 1
		akAlias.updateStats()
		akRef.Activate(PlayerRef)
	ENDIF
	Dispel()
ENDFUNCTION