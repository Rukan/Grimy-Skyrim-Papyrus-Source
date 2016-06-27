scriptName GUI_Script_AutoPoison extends activemagiceffect

actor property PlayerRef auto
gui_menumain property MainMenu auto

Int tempInt = 0

Event OnEffectStart(actor akTarget, actor akCaster)
	RegisterForAnimationEvent(PlayerRef, "weaponSwing")
	GotoState("Neutral")
EndEvent

state Neutral
	Event OnAnimationEvent(objectreference akSource, String asEventName)
		if akSource == PlayerRef && asEventName == "weaponSwing"
			MainMenu.equipPoison()
			GotoState("Cooldown")
		endIf
	EndEvent

	Event OnPlayerBowShot(Weapon akWeapon, Ammo akAmmo, Float afPower, Bool abSunGazing)
		MainMenu.equipPoison()
		GotoState("Cooldown")
	EndEvent
endState

;-- State -------------------------------------------
state Cooldown
	Event OnAnimationEvent(objectreference akSource, String asEventName)
		if akSource == PlayerRef && asEventName == "weaponSwing"
			tempInt += 1
			if tempInt >= MainMenu.GUI_Interval_AutoPoison
				GotoState("Neutral")
			endIf
		endIf
	EndEvent

	Event OnPlayerBowShot(Weapon akWeapon, Ammo akAmmo, Float afPower, Bool abSunGazing)
		tempInt += 1
		if tempInt >= MainMenu.GUI_Interval_AutoPoison
			GotoState("Neutral")
		endIf
	EndEvent

	Event onBeginState()
		tempInt = 1
	EndEvent
endState
