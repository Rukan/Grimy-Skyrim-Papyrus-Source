Scriptname GELO_MeleeArcher extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	GrimyAbMeleeArcherSpell.Cast(akCaster,akCaster)
ENDEVENT

SPELL PROPERTY GrimyAbMeleeArcherSpell AUTO