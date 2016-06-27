Scriptname GrimyMagicAddSmeltOre extends activemagiceffect  

Spell property GrimyPerkSpellSmeltOre auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akCaster.AddSpell(GrimyPerkSpellSmeltOre, false)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akCaster.RemoveSpell(GrimyPerkSpellSmeltOre)
EndEvent