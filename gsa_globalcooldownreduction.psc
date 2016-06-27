Scriptname GSA_GlobalCooldownReduction extends activemagiceffect  

GLOBALVARIABLE PROPERTY akGlobal AUTO
FLOAT delta

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	FLOAT tempFloat = akGlobal.GetValue()
	delta = tempFloat * GetMagnitude()/100.0
	IF delta > tempFloat
		delta = tempFloat
	ENDIF
	akGlobal.SetValue(tempFloat - delta )
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	akGlobal.SetValue(akGlobal.GetValue() + delta )
ENDEVENT