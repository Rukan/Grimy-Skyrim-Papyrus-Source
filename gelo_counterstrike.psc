Scriptname GELO_Counterstrike extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	spellTarget = akTarget
ENDEVENT

EVENT OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	IF abHitBlocked
		GrimyAbCounterStrikeSpell.cast(spellTarget,spellTarget)
	ENDIF
ENDEVENT

ACTOR spellTarget
SPELL PROPERTY GrimyAbCounterStrikeSpell AUTO