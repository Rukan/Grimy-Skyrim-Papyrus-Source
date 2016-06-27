Scriptname GSA_SpellOnHit extends activemagiceffect  

SPELL PROPERTY akSpell AUTO
KEYWORD PROPERTY akKeyword AUTO
ACTOR target

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	target = akTarget
ENDEVENT

EVENT OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	IF akSource.HasKeyword(akKeyword)
		akSpell .Cast(akAggressor,target)
	ENDIF
ENDEVENT