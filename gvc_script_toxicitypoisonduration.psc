Scriptname GVC_Script_ToxicityPoisonDuration extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	IF ( akTarget == PlayerRef )
		GVC_Toxicity_Count_Container.AddItem(GVC_Toxicity_Count,1,true)
		IF GVC_AB_Engine.GetValueInt() && ( PlayerRef.GetItemCount(GVC_Toxicity_Count) > CalculateMaxToxicity() )
			GVC_CooldownOverdoseStart.Show()
			OverdoseAlias.StartCooldown()
		ENDIF
	ELSEIF ( akCaster == PlayerRef )
		Game.AdvanceSkill("Alchemy",GVC_XP_PoisonBase.GetValue())
	ENDIF
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	IF ( akTarget == PlayerRef )
		GVC_Toxicity_Count_Container.RemoveItem(GVC_Toxicity_Count,1,true)
	ENDIF
ENDEVENT

int FUNCTION CalculateMaxToxicity()
	IF PlayerRef.HasPerk(GVC_Perk_B13_Snakeblood)
		return GVC_MaxToxicity.GetValueInt() + (PlayerRef.GetActorValue("PoisonResist")/25) AS INT
	ELSE
		return GVC_MaxToxicity.GetValueInt()
	ENDIF
ENDFUNCTION

OBJECTREFERENCE PROPERTY GVC_Toxicity_Count_Container AUTO
ACTOR PROPERTY PlayerRef AUTO
GLOBALVARIABLE PROPERTY GVC_XP_PoisonBase AUTO
FORM PROPERTY GVC_Toxicity_Count AUTO
GLOBALVARIABLE PROPERTY GVC_MaxToxicity AUTO
MESSAGE PROPERTY GVC_CooldownOverdoseStart AUTO
PERK PROPERTY GVC_Perk_B13_Snakeblood AUTO
GLOBALVARIABLE PROPERTY GVC_AB_Engine AUTO
GVC_Engine_Overdose Property OverdoseAlias AUTO