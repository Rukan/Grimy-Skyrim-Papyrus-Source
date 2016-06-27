Scriptname GrimyMagicRecall extends activemagiceffect  

GLOBALVARIABLE PROPERTY isValid AUTO
ACTOR PROPERTY PlayerRef AUTO
OBJECTREFERENCE PROPERTY markerReference AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	IF isValid.GetValueInt() && akCaster == PlayerRef
		PlayerRef.MoveTo(markerReference)
	ELSE
		debug.notification("No Mark Found")
	ENDIF
ENDEVENT