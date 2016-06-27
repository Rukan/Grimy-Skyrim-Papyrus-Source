Scriptname GSA_BleedCone extends activemagiceffect  

ACTOR caster
SPELL PROPERTY scriptSpell AUTO
WEAPON PROPERTY akWeapon AUTO
STRING PROPERTY AV1 AUTO
STRING PROPERTY AV2 AUTO
STRING PROPERTY AV3 AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	caster = akTarget
	RegisterForEvents()
ENDEVENT

EVENT OnPlayerLoadGame()
	RegisterForEvents()
ENDEVENT

FUNCTION RegisterForEvents()
	IF akWeapon == None
		akWeapon = caster.GetEquippedWeapon()
	ENDIF
	float akDamage = ( akWeapon.GetBaseDamage() AS FLOAT ) * getMagnitude()
	akDamage *= 100.0 + caster.GetAV(AV1)
	akDamage *= 100.0 + caster.GetAV(AV1)
	akDamage *= 100.0 + caster.GetAV(AV1)
	akDamage /= 100000000.0
	scriptSpell.SetNthEffectMagnitude(0, akDamage)
	RegisterForAnimationEvent(caster,"WeaponSwing")
	RegisterForAnimationEvent(caster,"WeaponLeftSwing")
ENDFUNCTION

EVENT OnAnimationEvent(ObjectReference akSource, string asEventName)
	scriptSpell.Cast(caster,Game.GetCurrentCrosshairRef())
ENDEVENT