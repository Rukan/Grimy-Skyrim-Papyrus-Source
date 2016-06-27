scriptName GUI_Script_AutoHealthPotion extends activemagiceffect

actor property PlayerRef auto
gui_menumain property MainMenu auto

Event OnEffectStart(actor akTarget, actor akCaster)
	GotoState("Neutral")
EndEvent

state Cooldown
	Event onBeginState()
		RegisterForSingleUpdate(MainMenu.GUI_Interval_AutoHealthPotionCooldown)
	EndEvent

	Event OnUpdate()
		GotoState("Neutral")
	EndEvent
endState

state Neutral
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)
		if PlayerRef.GetActorValuePercentage("Health") < MainMenu.GUI_Interval_AutoHealthPotion
			MainMenu.equipHealthPotion()
			GotoState("Cooldown")
		endIf
	EndEvent
endState
