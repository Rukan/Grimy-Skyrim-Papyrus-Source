Scriptname GAA_Script_Battlerage extends ActiveMagicEffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	float akMag = 2.0 - akCaster.GetAVPercentage("Health")
	IF akMag < 1.0
		akMag = 1.0
	ENDIF
	akPerk.SetNthEntryValue(0,0,akMag)
ENDEVENT

PERK PROPERTY akPerk AUTO	