Scriptname GrimyUnlock extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	OBJECTREFERENCE tempRef = Game.GetCurrentCrosshairRef()
	IF akCaster.GetAV("Illusion") >= tempRef.GetLockLevel()
		tempRef.Lock(false)
	ELSE
		Debug.Notification("You need a higher illusion level to unlock this.")
	ENDIF
ENDEVENT