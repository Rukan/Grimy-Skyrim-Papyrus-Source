Scriptname GrimyMagicShieldForce extends activemagiceffect  

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if (abHitBlocked)
		VoiceUnrelentingForce1.cast(PlayerRef,akAggressor)
	endIf

endEvent

Actor Property PlayerRef Auto
Spell Property VoiceUnrelentingForce1 Auto