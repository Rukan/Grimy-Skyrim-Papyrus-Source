Scriptname GELO_MagickaOnHit extends activemagiceffect  

EVENT OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)
	self.GetTargetActor().RestoreActorValue("Magicka",self.GetMagnitude())
ENDEVENT