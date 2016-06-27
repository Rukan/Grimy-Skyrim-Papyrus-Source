Scriptname SWT_InitChargeGlobal extends activemagiceffect  

GlobalVariable Property akGlobal Auto
Spell Property akSpell Auto

Event OnEffectStart(Actor akTarget, Actor AkCaster)
	akCaster.AddSpell(akSpell)
	akGlobal.SetValue(GetMagnitude())
EndEvent

Event OnEffectFinish(Actor akTarget, Actor AkCaster)
	akCaster.RemoveSpell(akSpell)
	akGlobal.SetValue(0)
EndEvent