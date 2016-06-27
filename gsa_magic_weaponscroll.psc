Scriptname GSA_Magic_WeaponScroll extends activemagiceffect  

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
			applySpell(BattleaxeAlias,tempRef,Spell2H,0)
		ELSEIF tempWeapon.IsBow() 
			IF tempWeapon.GetWeaponType() == 7 ; Bow
				applySpell(BowAlias,tempRef,Spell2H,0)
			ELSE ; Crossbow
				applySpell(CrossbowAlias,tempRef,Spell2H,0)
			ENDIF
		ELSEIF tempWeapon.IsDagger() 
			applySpell(DaggerAlias,tempRef,SpellDagger,1)
		ELSEIF tempWeapon.IsGreatsword() 
			applySpell(GreatswordAlias,tempRef,Spell2H,0)
		ELSEIF tempWeapon.IsMace() 
			applySpell(MaceAlias,tempRef,SpellMace,20)
		ELSEIF tempWeapon.IsSword() 
			applySpell(SwordAlias,tempRef,SpellSword,3)
		ELSEIF tempWeapon.IsWarAxe() 
			applySpell(WarAxeAlias,tempRef,SpellWarAxe,4)
		ELSEIF tempWeapon.IsWarhammer() 
			applySpell(WarhammerAlias,tempRef,Spell2H,0)
		ELSE
			PlayerRef.Additem(thisScroll,1,true)
		ENDIF
	ELSE
		PlayerRef.Additem(thisScroll,1,true)
	ENDIF
	Dispel()
ENDEVENT

FUNCTION applySpell(GSA_WeaponAlias akAlias, OBJECTREFERENCE akRef, SPELL akSpell, INT akDur)
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

	INT applyStatus = akAlias.addSpellSlot(  StringUtil.Substring(thisScroll.GetName(),0,-10+StringUtil.GetLength(thisScroll.GetName()) )  , akSpell, GetMagnitude(), akDur)
	IF applyStatus == -1
		Debug.Notification("That item already has this upgrade")
		PlayerRef.Additem(thisScroll,1,true)
	ELSEIF applyStatus == 0
		Debug.Notification("No more upgrade slots left")
		PlayerRef.Additem(thisScroll,1,true)
	ELSEIF applyStatus == 1
		akRef.Activate(PlayerRef)
	ENDIF
	Dispel()
ENDFUNCTION