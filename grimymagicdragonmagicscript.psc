Scriptname GrimyMagicDragonMagicScript extends activemagiceffect  

Spell property GrimyPerkSpellFireBreath auto
Spell property GrimyPerkSpellFrostBreath auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akCaster.AddSpell(GrimyPerkSpellFireBreath, false)
	akCaster.AddSpell(GrimyPerkSpellFrostBreath, false)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akCaster.RemoveSpell(GrimyPerkSpellFireBreath)
	akCaster.RemoveSpell(GrimyPerkSpellFrostBreath)
EndEvent