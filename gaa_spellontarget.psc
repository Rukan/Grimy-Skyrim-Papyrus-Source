Scriptname GAA_SpellOnTarget extends ActiveMagicEffect  

SPELL PROPERTY akSpell AUTO
PERK PROPERTY akPerk AUTO

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	OBJECTREFERENCE crossRef = game.GetCurrentCrosshairRef()
	IF crossRef AS ACTOR
		akPerk.SetNthEntryValue(0,0,1.0 + GetMagnitude()/100.0)
		akSpell.SetNthEffectDuration(0,GetDuration() AS INT)
		akSpell.Cast(akCaster,crossRef)
	ENDIF
ENDEVENT