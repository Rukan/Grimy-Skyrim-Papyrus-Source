Scriptname GrimyWeaponChargeCost extends ActiveMagicEffect  

ACTOR caster
FUNCTION RegisterEvents()
	IF caster.GetEquippedItemType(1) <= 6 && WornObject.GetEnchantment(caster,1,0).HasKeyword(GrimyKeywordWeaponEnchant)
		RegisterForAnimationEvent(caster,"weaponSwing")
	ELSEIF caster.GetEquippedItemType(1) == 7 && WornObject.GetEnchantment(caster,1,0).HasKeyword(GrimyKeywordWeaponEnchant)
		RegisterForAnimationEvent(caster,"BowRelease")
	ELSEIF caster.GetEquippedItemType(1) == 12 && WornObject.GetEnchantment(caster,1,0).HasKeyword(GrimyKeywordWeaponEnchant)
		RegisterForAnimationEvent(caster,"BowRelease")
	ELSEIF caster.GetEquippedItemType(0) <= 6 && WornObject.GetEnchantment(caster,1,0).HasKeyword(GrimyKeywordWeaponEnchant)
		RegisterForAnimationEvent(caster,"weaponLeftSwing")
	ENDIF
ENDFUNCTION

EVENT OnPlayerLoadGame()
	RegisterEvents()	
ENDEVENT

EVENT OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	RegisterEvents()
ENDEVENT

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	caster = akCaster
	RegisterEvents()
ENDEVENT

EVENT OnAnimationEvent(ObjectReference akSource, string asEventName)
	IF asEventName == "weaponLeftSwing"
		updateCharge(caster.GetAV("LeftItemCharge"), GrimyGlobal_ChargeCost.GetValue(), 0)
	ELSE 
		updateCharge(caster.GetAV("RightItemCharge"), GrimyGlobal_ChargeCost.GetValue(), 1)
	ENDIF
ENDEVENT
KEYWORD PROPERTY GrimyKeywordWeaponEnchant AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_ChargeCost AUTO

FUNCTION updateCharge(float akCharge, float akCost, int akSlot)
	IF akCharge > 0.0
		IF akCharge < akCost
			IF akSlot
				caster.SetAV("RightItemCharge",0.0)
			ELSE
				caster.SetAV("LeftItemCharge",0.0)
			ENDIF
		ELSE
			IF akSlot
				caster.SetAV("RightItemCharge",akCharge - akCost)
			ELSE
				caster.SetAV("LeftItemCharge",akCharge - akCost)
			ENDIF
		ENDIF
	ENDIF
ENDFUNCTION