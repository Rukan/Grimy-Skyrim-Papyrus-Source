Scriptname GVC_Script_Pyromaniac extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	PlayerRef.RestoreActorValue("Stamina",10.0)
ENDEVENT

ACTOR PROPERTY PlayerRef AUTO