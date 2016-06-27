Scriptname GrimyMagicNighteye extends activemagiceffect  

Spell property GrimyToggleNightEye auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akCaster.AddSpell(GrimyToggleNightEye, false)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akCaster.RemoveSpell(GrimyToggleNightEye)
EndEvent