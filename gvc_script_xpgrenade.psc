Scriptname GVC_Script_XPGrenade extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	IF ( akCaster == PlayerRef )
		Game.AdvanceSkill("Alchemy",GVC_XP_ExplosionGrenade.GetValue())
	ENDIF
ENDEVENT

GLOBALVARIABLE PROPERTY GVC_XP_ExplosionGrenade AUTO
ACTOR PROPERTY PlayerRef AUTO