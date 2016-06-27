Scriptname GELO_StaffEnchantment extends ObjectReference  

ENCHANTMENT PROPERTY GELO_StaffEnchNull AUTO

EVENT OnEquipped(ACTOR akActor)
	ENCHANTMENT tempEnch = GetEnchantment()
	IF tempEnch
		ENCHANTMENT cloneEnch = GELO_StaffEnchNull.TempClone() AS ENCHANTMENT
		(GetBaseObject() AS WEAPON).SetEnchantment(cloneEnch)
		cloneEnch.SetNthEffectMagicEffect(0,tempEnch.GetNthEffectMagicEffect(0))
		cloneEnch.SetNthEffectMagicEffect(1,tempEnch.GetNthEffectMagicEffect(1))
		cloneEnch.SetNthEffectMagicEffect(2,tempEnch.GetNthEffectMagicEffect(2))
		cloneEnch.SetNthEffectMagicEffect(3,tempEnch.GetNthEffectMagicEffect(3))
		cloneEnch.SetNthEffectMagicEffect(4,tempEnch.GetNthEffectMagicEffect(4))
		cloneEnch.SetNthEffectMagicEffect(5,tempEnch.GetNthEffectMagicEffect(5))
		cloneEnch.SetNthEffectMagicEffect(6,tempEnch.GetNthEffectMagicEffect(6))
		cloneEnch.SetNthEffectMagicEffect(7,tempEnch.GetNthEffectMagicEffect(7))
		cloneEnch.SetNthEffectMagnitude(0,tempEnch.GetNthEffectMagnitude(0))
		cloneEnch.SetNthEffectMagnitude(1,tempEnch.GetNthEffectMagnitude(1))
		cloneEnch.SetNthEffectMagnitude(2,tempEnch.GetNthEffectMagnitude(2))
		cloneEnch.SetNthEffectMagnitude(3,tempEnch.GetNthEffectMagnitude(3))
		cloneEnch.SetNthEffectMagnitude(4,tempEnch.GetNthEffectMagnitude(4))
		cloneEnch.SetNthEffectMagnitude(5,tempEnch.GetNthEffectMagnitude(5))
		cloneEnch.SetNthEffectMagnitude(6,tempEnch.GetNthEffectMagnitude(6))
		cloneEnch.SetNthEffectMagnitude(7,tempEnch.GetNthEffectMagnitude(7))
		cloneEnch.SetNthEffectArea(0,tempEnch.GetNthEffectArea(0))
		cloneEnch.SetNthEffectArea(1,tempEnch.GetNthEffectArea(1))
		cloneEnch.SetNthEffectArea(2,tempEnch.GetNthEffectArea(2))
		cloneEnch.SetNthEffectArea(3,tempEnch.GetNthEffectArea(3))
		cloneEnch.SetNthEffectArea(4,tempEnch.GetNthEffectArea(4))
		cloneEnch.SetNthEffectArea(5,tempEnch.GetNthEffectArea(5))
		cloneEnch.SetNthEffectArea(6,tempEnch.GetNthEffectArea(6))
		cloneEnch.SetNthEffectArea(7,tempEnch.GetNthEffectArea(7))
		cloneEnch.SetNthEffectDuration(0,tempEnch.GetNthEffectDuration(0))
		cloneEnch.SetNthEffectDuration(1,tempEnch.GetNthEffectDuration(1))
		cloneEnch.SetNthEffectDuration(2,tempEnch.GetNthEffectDuration(2))
		cloneEnch.SetNthEffectDuration(3,tempEnch.GetNthEffectDuration(3))
		cloneEnch.SetNthEffectDuration(4,tempEnch.GetNthEffectDuration(4))
		cloneEnch.SetNthEffectDuration(5,tempEnch.GetNthEffectDuration(5))
		cloneEnch.SetNthEffectDuration(6,tempEnch.GetNthEffectDuration(6))
		cloneEnch.SetNthEffectDuration(7,tempEnch.GetNthEffectDuration(7))
	ENDIF
ENDEVENT