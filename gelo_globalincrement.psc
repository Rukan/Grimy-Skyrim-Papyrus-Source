Scriptname GELO_GlobalIncrement extends activemagiceffect  

ACTOR PROPERTY PlayerRef AUTO
GLOBALVARIABLE PROPERTY akGlobal AUTO
float akDelta

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	IF akTarget == PlayerRef
		akDelta = self.GetMagnitude()/100
		akGlobal.SetValue(akGlobal.GetValue() + akDelta)
	ENDIF
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	IF akTarget == PlayerRef
		akGlobal.SetValue(akGlobal.GetValue() - akDelta)
	ENDIF
ENDEVENT