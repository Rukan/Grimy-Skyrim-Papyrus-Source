Scriptname GVC_Script_XPArrow extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	IF ( akCaster == PlayerRef )
		Game.AdvanceSkill("Alchemy",GVC_XP_ExplosionArrow.GetValue())
		IF PlayerRef.HasPerk(GVC_Perk_C06_Contender)
			akTarget.DamageActorValue("Magicka",PlayerRef.GetBaseActorValue("Alchemy")/2.0)
		ENDIF
	ENDIF
ENDEVENT

GLOBALVARIABLE PROPERTY GVC_XP_ExplosionArrow AUTO
ACTOR PROPERTY PlayerRef AUTO
PERK PROPERTY GVC_Perk_C06_Contender AUTO