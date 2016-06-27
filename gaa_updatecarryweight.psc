Scriptname GAA_UpdateCarryWeight extends ActiveMagicEffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.ModAV("CarryWeight",-0.1)
	akTarget.ModAV("CarryWeight",0.1)
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.ModAV("CarryWeight",-0.1)
	akTarget.ModAV("CarryWeight",0.1)
ENDEVENT