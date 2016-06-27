Scriptname Grimy_Script_EnableGlobalFloat extends activemagiceffect  

GLOBALVARIABLE PROPERTY akGlobal AUTO
FLOAT PROPERTY akFloat AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	akGlobal.SetValue(akFloat)
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	akGlobal.SetValue(0)
ENDEVENT