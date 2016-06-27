Scriptname GrimyAddTwoSpells extends activemagiceffect  

Spell property Spell1 auto
Spell property Spell2 auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akCaster.AddSpell(Spell1, false)
	akCaster.AddSpell(Spell2, false)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akCaster.RemoveSpell(Spell1)
	akCaster.RemoveSpell(Spell2)
EndEvent