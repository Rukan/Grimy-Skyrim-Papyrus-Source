Scriptname GSA_ScriptCone extends activemagiceffect  

ACTOR caster
SPELL PROPERTY scriptSpell AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	caster = akTarget
	RegisterForEvents()
ENDEVENT

EVENT OnPlayerLoadGame()
	RegisterForEvents()
ENDEVENT

FUNCTION RegisterForEvents()
	RegisterForAnimationEvent(caster,"WeaponSwing")
	RegisterForAnimationEvent(caster,"WeaponLeftSwing")
ENDFUNCTION

EVENT OnAnimationEvent(ObjectReference akSource, string asEventName)
	scriptSpell.Cast(caster,Game.GetCurrentCrosshairRef())
ENDEVENT