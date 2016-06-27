Scriptname GBT_Script_SneakFatigue extends activemagiceffect  

Actor Property PlayerRef Auto
Spell Property GBT_DamageStamina Auto
GrimyMenuMain Property GBT_MainMenu Auto
Import GrimyToolsPluginScript

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForAnimationEvent(PlayerRef,"SneakStart")
	RegisterForAnimationEvent(PlayerRef,"SneakStop")
EndEvent

Event OnPlayerLoadGame()
	RegisterForAnimationEvent(PlayerRef,"SneakStart")
	RegisterForAnimationEvent(PlayerRef,"SneakStop")
EndEvent

Event OnAnimationEvent(ObjectReference akSource, String asEventName)
	If PlayerRef.IsSneaking()
		SetSpellNthMagicEffectMagnitude(GBT_DamageStamina,GBT_MainMenu.GetGBT_sneakFatigue_Float(),0)
		PlayerRef.AddSpell(GBT_DamageStamina,false)
	Else
		PlayerRef.RemoveSpell(GBT_DamageStamina)
	EndIf
EndEvent