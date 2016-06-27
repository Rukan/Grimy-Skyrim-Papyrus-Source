Scriptname GrimyMagicGuardianCircleScript extends ActiveMagicEffect  

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked )
	PercentHealth = PlayerRef.GetAVPercentage("Health")
	If PercentHealth < 0.25
		HazardGuardianCircleSpell .Cast(PlayerRef)
	EndIf
endEvent

Actor Property PlayerRef Auto

Spell Property HazardGuardianCircleSpell Auto  

float Property PercentHealth = 100.0 Auto  