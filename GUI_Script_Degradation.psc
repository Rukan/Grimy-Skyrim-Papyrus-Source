Scriptname GUI_Script_Degradation extends activemagiceffect  

GUI_MenuMain PROPERTY MenuMain AUTO
ACTOR akActor
IMPORT WornObject

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	akActor = akTarget
	RegisterForAnimations()
ENDEVENT

EVENT OnPlayerLoadGame()
	RegisterForAnimations()
ENDEVENT

FUNCTION RegisterForAnimations()
	RegisterForAnimationEvent(akActor,"BowRelease")
	RegisterForAnimationEvent(akActor,"weaponSwing")
	RegisterForAnimationEvent(akActor,"weaponLeftSwing")
ENDFUNCTION

EVENT OnAnimationEvent(ObjectReference akSource, string asEventName)
	IF asEventName == "weaponLeftSwing"
		degradeWeapon(false)
	ELSE
		degradeWeapon(true)
	ENDIF
ENDEVENT

EVENT OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	SetItemHealthPercent(akActor, 0, 0x00000002, GetItemHealthPercent(akActor, 0, 0x00000002) - MenuMain.GUI_DegradationRateArmor * 0.0001)
	SetItemHealthPercent(akActor, 0, 0x00000004, GetItemHealthPercent(akActor, 0, 0x00000004) - MenuMain.GUI_DegradationRateArmor * 0.0001)
	SetItemHealthPercent(akActor, 0, 0x00000008, GetItemHealthPercent(akActor, 0, 0x00000008) - MenuMain.GUI_DegradationRateArmor * 0.0001)
	SetItemHealthPercent(akActor, 0, 0x00000080, GetItemHealthPercent(akActor, 0, 0x00000080) - MenuMain.GUI_DegradationRateArmor * 0.0001)
	SetItemHealthPercent(akActor, 0, 0x00000200, GetItemHealthPercent(akActor, 0, 0x00000200) - MenuMain.GUI_DegradationRateArmor * 0.0001)
ENDEVENT

FUNCTION degradeWeapon(BOOL isRight)
	SetItemHealthPercent(akActor, isRight AS INT, 0, GetItemHealthPercent(akActor, isRight AS INT, 0) - akActor.GetEquippedWeapon(!isRight).GetBaseDamage() * MenuMain.GUI_DegradationRateWeapon  * 0.00012)
ENDFUNCTION