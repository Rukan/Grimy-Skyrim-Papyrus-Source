Scriptname GrimyMagicShieldSnare extends activemagiceffect  

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if (abHitBlocked)
		GrimySpellPerkShieldSlow.cast(PlayerRef,akAggressor)
	endIf

endEvent

Actor Property PlayerRef Auto
Spell Property GrimySpellPerkShieldSlow Auto