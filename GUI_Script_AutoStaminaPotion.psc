scriptName GUI_Script_AutoStaminaPotion extends activemagiceffect

actor property PlayerRef auto
gui_menumain property MainMenu auto

Event OnEffectStart(actor akTarget, actor akCaster)
	self.RegisterForActorAction(0)
	self.RegisterForAnimationEvent(PlayerRef, "SoundPlay.NPCHumanCombatShieldBash")
	self.GotoState("Neutral")
EndEvent

state Cooldown
	Event onBeginState()
		RegisterForSingleUpdate(MainMenu.GUI_Interval_AutoStaminaPotionCooldown)
	EndEvent

	Event OnUpdate()
		GotoState("Neutral")
	EndEvent
endState

state Neutral
	Event OnAnimationEvent(objectreference akSource, String asEventName)
		if akSource == PlayerRef && asEventName == "SoundPlay.NPCHumanCombatShieldBash"
			if PlayerRef.GetActorValuePercentage("Stamina") < MainMenu.GUI_Interval_AutoStaminaPotion
				MainMenu.equipStaminaPotion()
				GotoState("Cooldown")
			endIf
		endIf
	EndEvent

	Event OnActorAction(Int actionType, actor akActor, Form source, Int slot)
		if actionType == 0
			if PlayerRef.GetActorValuePercentage("Stamina") < MainMenu.GUI_Interval_AutoStaminaPotion
				MainMenu.equipStaminaPotion()
				GotoState("Cooldown")
			endIf
		endIf
	EndEvent
endState
