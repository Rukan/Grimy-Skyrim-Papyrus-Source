Scriptname GELO_GlobalPerkOrder extends activemagiceffect  

ACTOR PROPERTY PlayerRef AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_Irregular AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_MinRoll AUTO
SPELL PROPERTY GrimyAbGlobalOrder AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	IF akTarget == PlayerRef
		GrimyGlobal_Irregular.SetValue(0.0)
		GrimyGlobal_MinRoll.SetValue(GrimyGlobal_MinRoll.GetValue() + 0.1)
	ENDIF
	akTarget.RemoveSpell(GrimyAbGlobalOrder)
ENDEVENT