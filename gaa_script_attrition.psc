Scriptname GAA_Script_Attrition extends ActiveMagicEffect  

IMPORT ActorValueInfo

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	FLOAT akMag =  GetAVIByName("Health").GetMaximumValue(akCaster) - akCaster.GetAV("Health")
	IF akMag < 0.0
		akMag = 0.0
	ENDIF
	akCaster.RestoreAV("Stamina",akMag)
ENDEVENT