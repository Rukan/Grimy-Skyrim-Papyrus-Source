scriptName GBT_Script_MeleeStagger extends activemagiceffect
actor property PlayerRef auto
spell property GBT_MeleeStaggerProjectile auto

Event OnActorAction(Int actionType, actor akActor, Form source, Int slot)
	if actionType == 0
		GBT_MeleeStaggerProjectile.Cast(PlayerRef, none)
	endIf
EndEvent

Event OnEffectStart(actor akTarget, actor akCaster)
	RegisterForActorAction(0)
EndEvent

Event OnPlayerLoadGame()
	RegisterForActorAction(0)
EndEvent