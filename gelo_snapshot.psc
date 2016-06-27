Scriptname GELO_Snapshot extends ActiveMagicEffect  

PERK PROPERTY GrimyPerkSnapshot AUTO
ACTOR thisActor

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	thisActor = akTarget
	RegisterForEvents()
ENDEVENT

EVENT OnPlayerGameLoad()
	RegisterForEvents()
ENDEVENT

FUNCTION RegisterForEvents()
	RegisterForAnimationEvent(thisActor,"bowDraw")
	RegisterForAnimationEvent(thisActor,"BowDrawn")
	RegisterForAnimationEvent(thisActor,"attackStop")
	RegisterForAnimationEvent(thisActor,"arrowRelease")
ENDFUNCTION

EVENT OnAnimationEvent(ObjectReference akSource, string asEventName)
	IF asEventName == "BowDrawn" || asEventName == "attackStop"
		thisActor.removePerk(GrimyPerkSnapshot)
	ELSEIF asEventName == "bowdraw"
		thisActor.addPerk(GrimyPerkSnapshot)
	elseIF asEventName == "arrowRelease" && thisActor.HasPerk(GrimyPerkSnapshot)
		Game.ShakeCamera(thisActor,0.5,0.3)
	ENDIF
ENDEVENT