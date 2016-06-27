Scriptname GVC_Script_ToxicityInstant extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	IF ( akTarget == PlayerRef )
		IF GVC_AB_Engine.GetValueInt() && ( GVC_Toxicity_Count_Container.GetItemCount(GVC_Toxicity_Count) >= CalculateMaxToxicity() )
			GVC_CooldownOverdoseStart.Show()
			OverdoseAlias.StartCooldown()
		ELSE
			IF ( akTarget.hasPerk(GVC_Perk_A10_Aromatics) )
				GVC_Aromatics.Cast(akTarget)
			ENDIF
			Game.AdvanceSkill("Alchemy",GVC_XP_PotionBase.GetValue())
			IF PlayerRef.HasPerk(GVC_Perk_C08_SpecializedEnzymes)
				PotionAlias.StartCooldown()
			ELSE
				AllPotionAlias.StartCooldown()
			ENDIF
		ENDIF
	ENDIF
ENDEVENT

int FUNCTION CalculateMaxToxicity()
	IF PlayerRef.HasPerk(GVC_Perk_B13_Snakeblood)
		return GVC_MaxToxicity.GetValueInt() + (PlayerRef.GetActorValue("PoisonResist")/25) AS INT
	ELSE
		return GVC_MaxToxicity.GetValueInt()
	ENDIF
ENDFUNCTION

GLOBALVARIABLE PROPERTY GVC_MaxToxicity AUTO
FORM PROPERTY GVC_Toxicity_Count AUTO
ACTOR PROPERTY PlayerRef AUTO
OBJECTREFERENCE PROPERTY GVC_Toxicity_Count_Container AUTO
SPELL PROPERTY GVC_Aromatics AUTO
PERK PROPERTY GVC_Perk_A10_Aromatics AUTO
PERK PROPERTY GVC_Perk_C08_SpecializedEnzymes AUTO
PERK PROPERTY GVC_Perk_B13_Snakeblood AUTO
GLOBALVARIABLE PROPERTY GVC_XP_PotionBase AUTO
GVC_Engine_Alias PROPERTY AllPotionAlias AUTO
GVC_Engine_Alias PROPERTY PotionAlias AUTO
GVC_Engine_Overdose PROPERTY OverdoseAlias AUTO
MESSAGE PROPERTY GVC_CooldownOverdoseStart AUTO
GLOBALVARIABLE PROPERTY GVC_AB_Engine AUTO