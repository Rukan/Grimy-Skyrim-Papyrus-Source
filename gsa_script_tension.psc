Scriptname GSA_Script_Tension extends activemagiceffect  

SPELL PROPERTY GSA_AB_TensionCost AUTO
ACTOR akSubject

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	akSubject = akTarget
	RegisterForAnimations(akTarget)
ENDEVENT

FUNCTION RegisterForAnimations(ACTOR akActor)
	RegisterForAnimationEvent(akActor, "bowDraw")
	RegisterForAnimationEvent(akActor, "BowRelease")
ENDFUNCTION

EVENT OnAnimationEvent(OBJECTREFERENCE akSource, STRING akEvent)
	IF akEvent == "bowDraw"
		akSubject.AddSpell(GSA_AB_TensionCost)
	ELSE
		akSubject.RemoveSpell(GSA_AB_TensionCost)
	ENDIF
ENDEVENT

EVENT OnEffectFinish(ACTOR akTarget, ACTOR akCaster)
	akSubject.RemoveSpell(GSA_AB_TensionCost)
ENDEVENT