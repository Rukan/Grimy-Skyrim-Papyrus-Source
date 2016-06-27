scriptName GUI_Script_AutoMagickaPotion extends activemagiceffect

gui_menumain property MainMenu auto
actor property PlayerRef auto

Event OnSpellHotCast(String eventName, String strArg, Float numArg, Form sender)

EndEvent

Event OnEffectStart(actor akTarget, actor akCaster)
	RegisterForModEvent("SpellHotCast", "OnSpellHotCast")
	GotoState("Neutral")
EndEvent

;-- State -------------------------------------------
state Cooldown
	Event OnUpdate()
		GotoState("Neutral")
	EndEvent

	Event onBeginState()
		RegisterForSingleUpdate(MainMenu.GUI_Interval_AutoMagickaPotionCooldown)
	EndEvent
endState

;-- State -------------------------------------------
state Neutral
	Event OnSpellCast(Form akSpell)
		if PlayerRef.GetActorValuePercentage("Magicka") < MainMenu.GUI_Interval_AutoMagickaPotion
			MainMenu.equipMagickaPotion()
			GotoState("Cooldown")
		endIf
	EndEvent

	Event OnSpellHotCast(String eventName, String strArg, Float numArg, Form sender)
		if PlayerRef.GetActorValuePercentage("Magicka") < MainMenu.GUI_Interval_AutoMagickaPotion
			MainMenu.equipMagickaPotion()
			GotoState("Cooldown")
		endIf
	EndEvent
endState
