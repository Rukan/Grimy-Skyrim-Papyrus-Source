Scriptname GSA_Magic_AbilityScroll extends activemagiceffect  

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
FLOAT PROPERTY akCooldown AUTO
FLOAT PROPERTY akCost AUTO
SOUND PROPERTY akSound AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	OBJECTREFERENCE tempRef = Game.GetCurrentCrosshairRef()
	ARMOR tempArmor = tempRef.GetBaseObject() AS ARMOR

	IF tempArmor
		IF tempArmor.GetWeightClass() == 0
			IF  tempArmor.IsHelmet()
				applySpell(lightHelmetAlias,lightHelmetSpell,tempRef)
			ELSEIF tempArmor.IsCuirass()
				applySpell(lightCuirassAlias,lightCuirassSpell,tempRef)
			ELSEIF tempArmor.IsGauntlets()
				applySpell(lightGauntletsAlias,lightGauntletsSpell,tempRef)
			ELSEIF tempArmor.IsBoots()
				applySpell(lightBootsAlias,lightBootsSpell,tempRef)
			ELSEIF tempArmor.IsShield()
				applySpell(lightShieldAlias,lightShieldSpell,tempRef)
			ENDIF
		ELSEIF tempArmor.GetWeightClass() == 1
			IF  tempArmor.IsHelmet()
				applySpell(heavyHelmetAlias,heavyHelmetSpell,tempRef)
			ELSEIF tempArmor.IsCuirass()
				applySpell(heavyCuirassAlias,heavyCuirassSpell,tempRef)
			ELSEIF tempArmor.IsGauntlets()
				applySpell(heavyGauntletsAlias,heavyGauntletsSpell,tempRef)
			ELSEIF tempArmor.IsBoots()
				applySpell(heavyBootsAlias,heavyBootsSpell,tempRef)
			ELSEIF tempArmor.IsShield()
				applySpell(heavyShieldAlias,heavyShieldSpell,tempRef)
			ENDIF
		ENDIF
	ELSE
		PlayerRef.Additem(thisScroll,1,true)
		Dispel()
		RETURN
	ENDIF
ENDEVENT

FUNCTION applySpell(GSA_ArmorAlias akAlias, SPELL akSpell, OBJECTREFERENCE akRef)
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

	INT applyStatus = akAlias.addAbilitySlot(StringUtil.Substring(thisScroll.GetName(),0,-10+StringUtil.GetLength(thisScroll.GetName()) ),akSpell,GetMagnitude(),GetDuration() AS INT,akCost,akCooldown, akSound)
	IF applyStatus == 0
		Debug.Notification("This item already has an ability upgrade.")
		PlayerRef.Additem(thisScroll,1,true)
	ELSE
		akRef.Activate(PlayerRef)
	ENDIF
	Dispel()
ENDFUNCTION