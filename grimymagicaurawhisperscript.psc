Scriptname GrimyMagicAuraWhisperScript extends ActiveMagicEffect  

ImageSpaceModifier property StaticFX auto
{IsMod applied during all of the spell effect}

Event OnEffectStart(Actor Target, Actor Caster)
	If StaticFX != None				;Do we have an Static?
		StaticFX.apply()   				; apply isMod at full strength
	endif
EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)
	if StaticFX != None
		StaticFX.remove()
	endif
endEvent

