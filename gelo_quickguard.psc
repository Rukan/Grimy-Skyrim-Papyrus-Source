Scriptname GELO_QuickGuard extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	spellTarget = akTarget
	RegisterForEvents()
ENDEVENT

EVENT OnPlayerLoadGame()
	RegisterForEvents()
ENDEVENT

FUNCTION RegisterForEvents()
	RegisterForAnimationEvent(spellTarget, "blockStartOut")
ENDFUNCTION

EVENT OnAnimationEvent(ObjectReference akSource, string asEventName)
	IF !spellTarget.HasMagicEffect(GrimyMagicEnchQuickGuardCooldown)
		GrimyAbQuickGuardSpell.Cast(spellTarget,spellTarget)
	ENDIF
ENDEVENT

ACTOR spellTarget
SPELL PROPERTY GrimyAbQuickGuardSpell AUTO
MAGICEFFECT PROPERTY GrimyMagicEnchQuickGuardCooldown AUTO