Scriptname GVC_Engine_Overdose extends ReferenceAlias

EVENT OnInit()
	ForceRefTo(PlayerRef)
ENDEVENT

FUNCTION StartCooldown()
	GoToState("Cooldown")
ENDFUNCTION

STATE Cooldown
	FUNCTION StartCooldown()
	ENDFUNCTION
	
	EVENT OnBeginState()
		ForceRefTo(PlayerRef)
		RegisterForSingleUpdate(GVC_Base_Cooldown.GetValue()*(1.0-PlayerRef.GetActorValue("Alchemy")*GVC_ScaleCooldown.GetValue()))
		GVC_DispelBeneficialEffects.Cast(PlayerRef)
		PlayerRef.DamageActorValue("Health",GVC_OD_Health.GetValue())
		PlayerRef.DamageActorValue("Magicka",GVC_OD_Magicka.GetValue())
		PlayerRef.DamageActorValue("Stamina",GVC_OD_Stamina.GetValue())
		PlayerRef.DamageActorValue("SpeedMult",GVC_OD_Slow.GetValue())
		ODSkills = GVC_OD_Skills.GetValue()
		IF ( ODSkills > 0.0 )
			PlayerRef.DamageActorValue("OneHanded",ODSkills)
			PlayerRef.DamageActorValue("TwoHanded",ODSkills)
			PlayerRef.DamageActorValue("Marksman",ODSkills)
			PlayerRef.DamageActorValue("Block",ODSkills)
			PlayerRef.DamageActorValue("Smithing",ODSkills)
			PlayerRef.DamageActorValue("HeavyArmor",ODSkills)
			PlayerRef.DamageActorValue("LightArmor",ODSkills)
			PlayerRef.DamageActorValue("Pickpocket",ODSkills)
			PlayerRef.DamageActorValue("Lockpicking",ODSkills)
			PlayerRef.DamageActorValue("Sneak",ODSkills)
			PlayerRef.DamageActorValue("Alchemy",ODSkills)
			PlayerRef.DamageActorValue("Speechcraft",ODSkills)
			PlayerRef.DamageActorValue("Alteration",ODSkills)
			PlayerRef.DamageActorValue("Conjuration",ODSkills)
			PlayerRef.DamageActorValue("Destruction",ODSkills)
			PlayerRef.DamageActorValue("Illusion",ODSkills)
			PlayerRef.DamageActorValue("Restoration",ODSkills)
			PlayerRef.DamageActorValue("Enchanting",ODSkills)
		ENDIF
		IF GVC_OD_Expulsions.GetValueInt()
			GVC_OverdoseExpulsions.Cast(PlayerRef)
		ENDIF
		MAGIllusionNightEyeOn.Play(PlayerRef)
	ENDEVENT

	EVENT OnUpdate()
		GVC_Cooldown.Show()
		PlayerRef.RestoreActorValue("Health",GVC_OD_Health.GetValue())
		PlayerRef.RestoreActorValue("Magicka",GVC_OD_Magicka.GetValue())
		PlayerRef.RestoreActorValue("Stamina",GVC_OD_Stamina.GetValue())
		PlayerRef.RestoreActorValue("SpeedMult",GVC_OD_Slow.GetValue())
		IF ( ODSkills > 0.0 )
			PlayerRef.RestoreActorValue("OneHanded",ODSkills)
			PlayerRef.RestoreActorValue("TwoHanded",ODSkills)
			PlayerRef.RestoreActorValue("Marksman",ODSkills)
			PlayerRef.RestoreActorValue("Block",ODSkills)
			PlayerRef.RestoreActorValue("Smithing",ODSkills)
			PlayerRef.RestoreActorValue("HeavyArmor",ODSkills)
			PlayerRef.RestoreActorValue("LightArmor",ODSkills)
			PlayerRef.RestoreActorValue("Pickpocket",ODSkills)
			PlayerRef.RestoreActorValue("Lockpicking",ODSkills)
			PlayerRef.RestoreActorValue("Sneak",ODSkills)
			PlayerRef.RestoreActorValue("Alchemy",ODSkills)
			PlayerRef.RestoreActorValue("Speechcraft",ODSkills)
			PlayerRef.RestoreActorValue("Alteration",ODSkills)
			PlayerRef.RestoreActorValue("Conjuration",ODSkills)
			PlayerRef.RestoreActorValue("Destruction",ODSkills)
			PlayerRef.RestoreActorValue("Illusion",ODSkills)
			PlayerRef.RestoreActorValue("Restoration",ODSkills)
			PlayerRef.RestoreActorValue("Enchanting",ODSkills)
		ENDIF
		GoToState("")
	ENDEVENT

	EVENT OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		IF akBaseObject.HasKeyword(MagicAlch)
			GVC_RefundMessage.Show()
			PlayerRef.AddItem(akBaseObject,1,true)
		ENDIF
	ENDEVENT
ENDSTATE

float ODSkills
ACTOR PROPERTY PlayerRef AUTO
GLOBALVARIABLE PROPERTY GVC_Base_Cooldown AUTO
GLOBALVARIABLE PROPERTY GVC_ScaleCooldown AUTO
SPELL PROPERTY GVC_OverdoseExpulsions AUTO
SPELL PROPERTY GVC_DispelBeneficialEffects AUTO
KEYWORD PROPERTY MagicAlch AUTO
MESSAGE PROPERTY GVC_Cooldown AUTO
MESSAGE PROPERTY GVC_RefundMessage AUTO
GLOBALVARIABLE PROPERTY GVC_OD_Expulsions AUTO
GLOBALVARIABLE PROPERTY GVC_OD_Health AUTO
GLOBALVARIABLE PROPERTY GVC_OD_Magicka AUTO
GLOBALVARIABLE PROPERTY GVC_OD_Skills AUTO
GLOBALVARIABLE PROPERTY GVC_OD_Slow AUTO
GLOBALVARIABLE PROPERTY GVC_OD_Stamina AUTO
SOUND PROPERTY MAGIllusionNightEyeOn AUTO