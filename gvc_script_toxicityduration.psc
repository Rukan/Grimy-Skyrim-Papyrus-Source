Scriptname GVC_Script_ToxicityDuration extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	IF ( akTarget == PlayerRef )
		tempDuration = Self.GetDuration()
		RegisterForSingleUpdate(tempDuration+(-0.1))
		GVC_Toxicity_Count_Container.AddItem(GVC_Toxicity_Count,1,true)
		IF !PlayerRef.HasPerk(GVC_Perk_A11_Desensitization)
			tempToxicity = GVC_Toxicity_Count_Container.GetItemCount(GVC_Toxicity_Count)
			tempMaxToxicity = CalculateMaxToxicity()
			IF GVC_AB_Engine.GetValueInt() && ( tempToxicity > tempMaxToxicity )
				GVC_CooldownOverdoseStart.Show()
				OverdoseAlias.StartCooldown()
			ELSEIF PlayerRef.HasPerk(GVC_Perk_C08_SpecializedEnzymes)
				IF GVC_AB_Engine.GetValueInt()
					GVC_MessageToxicity.Show(tempToxicity, tempMaxToxicity)
				ENDIF
				PotionAlias.StartCooldown()
			ELSE
				IF GVC_AB_Engine.GetValueInt()
					GVC_MessageToxicity.Show(tempToxicity, tempMaxToxicity)
				ENDIF
				AllPotionAlias.StartCooldown()
			ENDIF
		ENDIF
		Game.AdvanceSkill("Alchemy",GVC_XP_PotionBase.GetValue())
	ENDIF
ENDEVENT

EVENT OnUpdate()
	tempDuration = tempDuration*GVC_XP_PotionDuration.GetValue()
	Game.AdvanceSkill("Alchemy",tempDuration)
	IF GVC_AB_Engine.GetValueInt()
		GVC_XPPotionDuration.Show(GVC_Toxicity_Count_Container.GetItemCount(GVC_Toxicity_Count),GVC_MaxToxicity.GetValueInt(),tempDuration)
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

float tempDuration
int tempToxicity
int tempMaxToxicity
PERK PROPERTY GVC_Perk_C08_SpecializedEnzymes AUTO
PERK PROPERTY GVC_Perk_A11_Desensitization AUTO
ACTOR PROPERTY PlayerRef AUTO
OBJECTREFERENCE PROPERTY GVC_Toxicity_Count_Container AUTO
GLOBALVARIABLE PROPERTY GVC_XP_PotionDuration AUTO
GLOBALVARIABLE PROPERTY GVC_XP_PotionBase AUTO
GLOBALVARIABLE PROPERTY GVC_MaxToxicity AUTO

FORM PROPERTY GVC_Toxicity_Count AUTO
MESSAGE PROPERTY GVC_XPPotionDuration AUTO

GVC_Engine_Alias PROPERTY PotionAlias AUTO
GVC_Engine_Alias PROPERTY AllPotionAlias AUTO
GVC_Engine_Overdose PROPERTY OverdoseAlias AUTO

GLOBALVARIABLE PROPERTY GVC_AB_Engine AUTO
MESSAGE PROPERTY GVC_CooldownOverdoseStart AUTO
MESSAGE PROPERTY GVC_MessageToxicity AUTO
PERK PROPERTY GVC_Perk_B13_Snakeblood AUTO