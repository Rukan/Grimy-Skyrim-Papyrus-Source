Scriptname GVC_Script_XPMine extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	IF ( akCaster == PlayerRef )
		Game.AdvanceSkill("Alchemy",GVC_XP_ExplosionMine.GetValue())
	ENDIF
ENDEVENT

GLOBALVARIABLE PROPERTY GVC_XP_ExplosionMine AUTO
ACTOR PROPERTY PlayerRef AUTO