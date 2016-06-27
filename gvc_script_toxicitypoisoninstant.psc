Scriptname GVC_Script_ToxicityPoisonInstant extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	IF ( akTarget == PlayerRef )
		IF GVC_AB_Engine.GetValueInt() && ( GVC_Toxicity_Count_Container.GetItemCount(GVC_Toxicity_Count) >= CalculateMaxToxicity() )
			GVC_CooldownOverdoseStart.Show()
			OverdoseAlias.StartCooldown()
		ENDIF
	ELSEIF ( akCaster == PlayerRef )
		Game.AdvanceSkill("Alchemy",GVC_XP_PoisonBase.GetValue())
	ENDIF
ENDEVENT

int FUNCTION CalculateMaxToxicity()
	IF PlayerRef.HasPerk(GVC_Perk_B13_Snakeblood)
		return GVC_MaxToxicity.GetValueInt() + (PlayerRef.GetActorValue("PoisonResist")/25) AS INT
	ELSE
		return GVC_MaxToxicity.GetValueInt()
	ENDIF
ENDFUNCTION

FORM PROPERTY GVC_Toxicity_Count AUTO
GLOBALVARIABLE PROPERTY GVC_MaxToxicity AUTO
ACTOR PROPERTY PlayerRef AUTO
OBJECTREFERENCE PROPERTY GVC_Toxicity_Count_Container AUTO
GLOBALVARIABLE PROPERTY GVC_XP_PoisonBase AUTO
PERK PROPERTY GVC_Perk_B13_Snakeblood AUTO
MESSAGE PROPERTY GVC_CooldownOverdoseStart AUTO
GLOBALVARIABLE PROPERTY GVC_AB_Engine AUTO
GVC_Engine_Overdose PROPERTY OverdoseAlias AUTO