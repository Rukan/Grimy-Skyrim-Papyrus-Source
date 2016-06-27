Scriptname GVC_Script_Shockwave extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	PlayerRef.PushActorAway(akTarget,10.0)
ENDEVENT
ACTOR PROPERTY PlayerRef AUTO