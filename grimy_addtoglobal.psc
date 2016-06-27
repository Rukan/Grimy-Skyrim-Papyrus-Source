Scriptname Grimy_AddToGlobal extends activemagiceffect  

GLOBALVARIABLE PROPERTY akGlobal AUTO
INT akInt

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	akInt = GetMagnitude() AS INT
	akGlobal.SetValueInt(akGlobal.GetValueInt() + akInt )
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	akGlobal.SetValueInt(akGlobal.GetValueInt() - akInt )
ENDEVENT
