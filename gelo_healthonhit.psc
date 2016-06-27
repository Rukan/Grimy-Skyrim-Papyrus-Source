Scriptname GELO_HealthOnHit extends activemagiceffect  

EVENT OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)
	self.GetTargetActor().RestoreActorValue("Health",self.GetMagnitude())
ENDEVENT