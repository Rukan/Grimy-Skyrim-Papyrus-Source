Scriptname GBT_Script_Combat_State extends activemagiceffect  

IMPORT GAME
IMPORT Utility
FLOAT time
GrimyMenuMain Property GBT_MainMenu Auto

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	time = GetCurrentGameTime()
ENDEVENT

EVENT OnEffectFinish(ACTOR akTarget, ACTOR akCaster)
	time = GetCurrentGameTime() - time
	time *= 24 * 60 ; time in minutes
	AdvanceSkill("Block",time * GBT_MainMenu.GetGBT_BlockExp_Float())
	time *= GBT_MainMenu.GetGBT_ArmorExp_Float()
	AdvanceSkill("LightArmor",time*getLightCount(akCaster))
	AdvanceSkill("HeavyArmor",time*getHeavyCount(akCaster))
ENDEVENT

FLOAT FUNCTION getLightCount(ACTOR akActor)
	FLOAT retval = 0.0
	IF (akActor.GetWornForm(0x00000002) AS ARMOR).GetWeightClass() != 1
		retval += 1.0
	ENDIF
	IF (akActor.GetWornForm(0x00000004) AS ARMOR).GetWeightClass() != 1
		retval += 1.0
	ENDIF
	IF (akActor.GetWornForm(0x00000008) AS ARMOR).GetWeightClass() != 1
		retval += 1.0
	ENDIF
	IF (akActor.GetWornForm(0x00000080) AS ARMOR).GetWeightClass() != 1
		retval += 1.0
	ENDIF
	IF (akActor.GetWornForm(0x00000200) AS ARMOR).GetWeightClass() != 1
		retval += 1.0
	ENDIF
	RETURN retval
ENDFUNCTION

FLOAT FUNCTION getHeavyCount(ACTOR akActor)
	FLOAT retval = 0.0
	IF (akActor.GetWornForm(0x00000002) AS ARMOR).GetWeightClass() == 1
		retval += 1.0
	ENDIF
	IF (akActor.GetWornForm(0x00000004) AS ARMOR).GetWeightClass() == 1
		retval += 1.0
	ENDIF
	IF (akActor.GetWornForm(0x00000008) AS ARMOR).GetWeightClass() == 1
		retval += 1.0
	ENDIF
	IF (akActor.GetWornForm(0x00000080) AS ARMOR).GetWeightClass() == 1
		retval += 1.0
	ENDIF
	IF (akActor.GetWornForm(0x00000200) AS ARMOR).GetWeightClass() == 1
		retval += 1.0
	ENDIF
	RETURN retval
ENDFUNCTION