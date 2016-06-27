Scriptname GrimySwiftSwim extends activemagiceffect  

ACTOR caster
FORM PROPERTY Gold001 AUTO
bool isSwimming

EVENT OnPlayerLoadGame()
	registerEvents()
ENDEVENT

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	caster = akCaster
	isSwimming = caster.IsSwimming()
	registerEvents()
ENDEVENT

EVENT OnAnimationEvent(ObjectReference akSource, string asEventName)
	updateSpeed()
	RegisterEvents()
ENDEVENT

FUNCTION registerEvents()
	IF isSwimming 
		RegisterForAnimationEvent(caster,"FootRight")
		UnregisterForAnimationEvent(caster,"SoundPlay.FSTSwimSwim")
	ELSE
		UnregisterForAnimationEvent(caster,"SoundPlay.FSTSwimSwim")
		RegisterForAnimationEvent(caster,"FootRight")
	ENDIF
ENDFUNCTION

FUNCTION updateSpeed()
	caster.AddItem(Gold001,1,true)
	caster.RemoveItem(Gold001,1,true)
ENDFUNCTION