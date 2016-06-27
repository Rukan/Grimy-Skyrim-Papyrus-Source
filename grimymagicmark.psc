Scriptname GrimyMagicMark extends activemagiceffect  

OBJECTREFERENCE PROPERTY markerReference AUTO
ACTOR PROPERTY PlayerRef AUTO
GLOBALVARIABLE PROPERTY isValid AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	IF akCaster == PlayerRef
		markerReference.MoveTo(PlayerRef)
		isValid.SetValueInt(1)
	ENDIF
ENDEVENT