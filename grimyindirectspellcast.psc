Scriptname GrimyIndirectSpellCast extends activemagiceffect  

Spell property akSpell auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akSpell.Cast(akCaster, akCaster)
EndEvent