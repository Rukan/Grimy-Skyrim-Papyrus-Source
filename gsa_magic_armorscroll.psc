Scriptname GSA_Magic_ArmorScroll extends activemagiceffect  

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

SPELL PROPERTY lightHelmetSpell AUTO
SPELL PROPERTY lightCuirassSpell AUTO
SPELL PROPERTY lightGauntletsSpell AUTO
SPELL PROPERTY lightBootsSpell AUTO
SPELL PROPERTY lightShieldSpell AUTO

SPELL PROPERTY heavyHelmetSpell AUTO
SPELL PROPERTY heavyCuirassSpell AUTO
SPELL PROPERTY heavyGauntletsSpell AUTO
SPELL PROPERTY heavyBootsSpell AUTO
SPELL PROPERTY heavyShieldSpell AUTO

SCROLL PROPERTY thisScroll AUTO
ACTOR PROPERTY PlayerRef AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	OBJECTREFERENCE tempRef = Game.GetCurrentCrosshairRef()
	ARMOR tempArmor = tempRef.GetBaseObject() AS ARMOR

	IF tempArmor
		IF tempArmor.GetWeightClass() == 0
			IF  tempArmor.IsHelmet()
				applySpell(lightHelmetAlias,lightHelmetSpell,tempRef,3)
			ELSEIF tempArmor.IsCuirass()
				applySpell(lightCuirassAlias,lightCuirassSpell,tempRef,1)
			ELSEIF tempArmor.IsGauntlets()
				applySpell(lightGauntletsAlias,lightGauntletsSpell,tempRef,2)
			ELSEIF tempArmor.IsBoots()
				applySpell(lightBootsAlias,lightBootsSpell,tempRef,0)
			ELSEIF tempArmor.IsShield()
				applySpell(lightShieldAlias,lightShieldSpell,tempRef,4)
			ENDIF
		ELSEIF tempArmor.GetWeightClass() == 1
			IF  tempArmor.IsHelmet()
				applySpell(heavyHelmetAlias,heavyHelmetSpell,tempRef,3)
			ELSEIF tempArmor.IsCuirass()
				applySpell(heavyCuirassAlias,heavyCuirassSpell,tempRef,1)
			ELSEIF tempArmor.IsGauntlets()
				applySpell(heavyGauntletsAlias,heavyGauntletsSpell,tempRef,2)
			ELSEIF tempArmor.IsBoots()
				applySpell(heavyBootsAlias,heavyBootsSpell,tempRef,0)
			ELSEIF tempArmor.IsShield()
				applySpell(heavyShieldAlias,heavyShieldSpell,tempRef,4)
			ENDIF
		ENDIF
	ELSE
		PlayerRef.Additem(thisScroll,1,true)
		Dispel()
		RETURN
	ENDIF
ENDEVENT

FUNCTION applySpell(GSA_ArmorAlias akAlias, SPELL akSpell, OBJECTREFERENCE akRef, INT akDur)
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

	INT applyStatus = akAlias.addSpellSlot(StringUtil.Substring(thisScroll.GetName(),0,-10+StringUtil.GetLength(thisScroll.GetName()) ),akSpell,GetMagnitude(),akDur)
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