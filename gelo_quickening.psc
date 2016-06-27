Scriptname GELO_Quickening extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	currentActor = akTarget
	RegisterEvents()
ENDEVENT

EVENT OnPlayerGameLoad()
	RegisterEvents()
ENDEVENT

FUNCTION RegisterEvents()
	RegisterForAnimationEvent(currentActor, "attackStop")
ENDFUNCTION

int counter = 0
EVENT OnAnimationEvent(ObjectReference akSource, string asEventName)
	IF counter == 0
		GrimyAbQuicken1.Cast(currentActor)
		counter = 1
	ELSEIF counter == 1
		GrimyAbQuicken2.Cast(currentActor)
		counter = 2
	ELSE
		GrimyAbQuicken3.Cast(currentActor)
		counter = 0
	ENDIF
ENDEVENT

ACTOR currentActor
SPELL PROPERTY GrimyAbQuicken1 AUTO
SPELL PROPERTY GrimyAbQuicken2 AUTO
SPELL PROPERTY GrimyAbQuicken3 AUTO