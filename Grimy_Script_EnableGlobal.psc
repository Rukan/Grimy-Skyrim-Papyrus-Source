Scriptname Grimy_Script_EnableGlobal extends activemagiceffect  

GLOBALVARIABLE PROPERTY akGlobal AUTO
INT PROPERTY akInt AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	akGlobal.SetValueInt(akInt)
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	akGlobal.SetValueInt(0)
ENDEVENT