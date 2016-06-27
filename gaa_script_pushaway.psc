Scriptname GAA_Script_PushAway extends ActiveMagicEffect  

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	akCaster.PushActorAway(akTarget, 1)
ENDEVENT