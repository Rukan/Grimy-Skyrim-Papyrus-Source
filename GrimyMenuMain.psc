scriptname GrimyMenuMain extends SKI_ConfigBase

ACTOR PROPERTY PlayerRef AUTO
IMPORT Game
IMPORT GrimyToolsPluginScript
IMPORT ActorValueInfo
IMPORT Debug
IMPORT Utility

INT FUNCTION GetVersion()
	return 22
ENDFUNCTION

EVENT OnVersionUpdate(int a_version)
	refreshPages()
ENDEVENT

EVENT OnConfigInit()
	refreshPages()
	RegisterEverything()
ENDEVENT

FUNCTION refreshPages()
	quickSaveOptions = new STRING[4]
	quickSaveOptions[0] = "User Inputs Filename"
	quickSaveOptions[1] = "5 quicksave slots"
	quickSaveOptions[2] = "Regular Save Slot"
	quickSaveOptions[3] = "Autosave Slot"
	ModName = "SkyTweak"
	Pages = new string[15]
	Pages[0] = "Tweaks"
	Pages[1] = "Magic"
	Pages[2] = "Combat"
	Pages[3] = "Stealth"
	Pages[4] = "Crafting"
	Pages[5] = "Vendors"
	Pages[6] = "Attributes"
	Pages[7] = "Actor Values"
	Pages[8] = "MISC"
	Pages[9] = "NPC"
	Pages[10] = "Experience"
	Pages[11] = "Physics"
	Pages[12] = "INI"
	Pages[13] = "Scripts"
	Pages[14] = "Options & Info"
ENDFUNCTION

FUNCTION RegisterEverything()
	RegisterForModEvent("PingSkyTweak","onPingSkyTweak")
	RegisterForMenu("LevelUp Menu")
	IF isRegistered
		RegisterForKey(saveHotkey)
	ENDIF
ENDFUNCTION

EVENT OnPageReset(string page)
	IF SliderModeVar
	IF ( page == "Tweaks")
		TEMPER_SCALE_TOGGLE = addToggleOption("Temper Scaling", PlayerRef.HasPerk(GBT_Temper_Scale))
		SHOUT_SCALE_SLIDER = addSliderOption("Shout Scaling", (GBT_shoutScale.GetNthEntryValue(0, 1) * 100) + 0,"{1}%")
		CRIT_SCALE_TOGGLE = addToggleOption("Critical Damage Scaling", PlayerRef.HasPerk(GBT_Critical_Damage_Scaling))
		BLEED_SCALE_TOGGLE = addToggleOption("Bleed Damage Scaling", PlayerRef.HasPerk(GBT_Bleed_Damage_Scaling))
		STAMINACOST_SCALE_TOGGLE = addToggleOption("Stamina Cost Scaling", PlayerRef.HasPerk(GBT_Stamina_Cost_Scaling))
		ILLTARGLVL_SCALE_TOGGLE = addToggleOption("Illusion Scale Target Level", PlayerRef.HasPerk(GBT_illScaleTargetLevel))
		FRIENDLY_DAMAGE_TOGGLE = addToggleOption("Disable Friendly Fire: Damage", PlayerRef.HasPerk(GBT_friendlyDamage))
		TRAP_MAGNITUDE_SLIDER = addSliderOption("Trap Magnitude", (GBT_trapMagnitude.GetNthEntryValue(0, 0) * 100) + 0,"{0}%")
		FRIENDLY_STAGGER_TOGGLE = addToggleOption("Disable Friendly Fire: Stagger", PlayerRef.HasPerk(GBT_friendlyStagger))
		WEREDMG_DEALT_SLIDER = addSliderOption("Werewolf Damage Dealt", (GBT_WerewolfDamageDealt.GetNthEntryValue(0, 0) * 100) + 0,"{0}%")
		WEREDMG_TAKEN_SLIDER = addSliderOption("Werewolf Damage Taken", (GBT_WerewolfDamageTaken.GetNthEntryValue(0, 0) * 100) + 0,"{0}%")
		POISON_DOSE_SLIDER = addSliderOption("Bonus Poison Doses", (GBT_poisonDose.GetNthEntryValue(0, 0) * 1) + 0,"{0}")
	ELSEIF ( page == "Magic")
		DUALCAST_POWER_SLIDER = addSliderOption("Dual Cast Power", GetGameSettingFloat("fMagicDualCastingEffectivenessBase"),"{1}")
		DUALCAST_COST_SLIDER = addSliderOption("Dual Cast Cost", GetGameSettingFloat("fMagicDualCastingCostMult"),"{1}")
		MAGICCOST_SCALE_SLIDER = addSliderOption("Player Magic Cost Scaling", GetGameSettingFloat("fMagicCasterPCSkillCostBase"),"{4}")
		MAGIC_COST_SLIDER = addSliderOption("Player Magic Cost", GetGameSettingFloat("fMagicCasterPCSkillCostMult"),"{1}")
		NPCMAGICCOST_SCALE_SLIDER = addSliderOption("NPC Magic Cost Scaling", GetGameSettingFloat("fMagicCasterSkillCostBase"),"{4}")
		NPCMAGIC_COST_SLIDER = addSliderOption("NPC Magic Cost", GetGameSettingFloat("fMagicCasterSkillCostMult"),"{1}")
		MAX_RUNES_SLIDER = addSliderOption("Base Rune Cap", GetGameSettingInt("iMaxPlayerRunes"),"{0}")
		MAX_SUMMONED_SLIDER = addSliderOption("Base Summon Creature Count", GetGameSettingInt("iMaxSummonedCreatures"),"{0}")
		TELEKIN_DAMAGE_SLIDER = addSliderOption("Telekinesis Damage", GetGameSettingFloat("fMagicTelekinesisDamageBase"),"{0}")
		TELEKIN_DUALMULT_SLIDER = addSliderOption("Telekinesis Dual Mult", GetGameSettingFloat("fMagicTelekinesisDualCastDamageMult"),"{2}")
		ALTMAG_SCALE_SLIDER = addSliderOption("Alteration Scale Magnitude", (GBT_altScaleMag.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		CONJMAG_SCALE_SLIDER = addSliderOption("Conjuration Scale Magnitude", (GBT_conjScaleMag.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		ALTDURNOTPARA_SCALE_SLIDER = addSliderOption("Alteration Scale Duration", (GBT_altScaleDurNotPara.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		CONJDUR_SCALE_SLIDER = addSliderOption("Conjuration Scale Duration", (GBT_conjScaleDur.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		ALTCOST_SCALE_SLIDER = addSliderOption("Alteration Scale Cost", (GBT_altScaleCost.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		CONJCOST_SCALE_SLIDER = addSliderOption("Conjuration Scale Cost", (GBT_conjScaleCost.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		ALTDURPARA_SCALE_SLIDER = addSliderOption("Paralysis Scale Duration", (GBT_altScaleDurPara.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		BOUNTMELEE_SCALE_SLIDER = addSliderOption("Bound Melee Scale Damage", (GBT_conjScaleBoundMelee.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		ALTCOSTDET_SCALE_SLIDER = addSliderOption("Detection Scale Cost", (GBT_altScaleCostDet.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		BOUNDBOW_SCALE_SLIDER = addSliderOption("Bound Bow Scale Damage", (GBT_conjScaleBoundBow.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		DESMAG_SCALE_SLIDER = addSliderOption("Destruction Scale Magnitude", (GBT_desScaleMag.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		HEALMAG_SCALE_SLIDER = addSliderOption("Healing Scale Magnitude", (GBT_restScaleMagHeal.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		DESDUR_SCALE_SLIDER = addSliderOption("Destruction Scale Duration", (GBT_desScaleDur.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		HEALDUR_SCALE_SLIDER = addSliderOption("Healing Scale Duration", (GBT_restScaleDurHeal.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		DESCOST_SCALE_SLIDER = addSliderOption("Destruction Scale Cost", (GBT_desScaleCost.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		HEALCOST_SCALE_SLIDER = addSliderOption("Healing Scale Cost", (GBT_restScaleCostHeal.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		ILLMAG_SCALE_SLIDER = addSliderOption("Illusion Scale Magnitude", (GBT_illScaleMag.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		NONHEALMAG_SCALE_SLIDER = addSliderOption("Non-Healing Scale Magnitude", (GBT_nonHealScaleMag.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		ILLDUR_SCALE_SLIDER = addSliderOption("Illusion Scale Duration", (GBT_illScaleDur.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		NONHEALDUR_SCALE_SLIDER = addSliderOption("Non-Healing Scale Duration", (GBT_nonHealScaleDur.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		ILLCOST_SCALE_SLIDER = addSliderOption("Illusion Scale Cost", (GBT_illScaleCost.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		NONHEALCOST_SCALE_SLIDER = addSliderOption("Non-Healing Scale Cost", (GBT_nonHealScaleCost.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		LESSERPOWER_COOLDOWN_SLIDER = addSliderOption("Lesser Power Cooldown Time", GetGameSettingFloat("fMagicLesserPowerCooldownTimer"),"{1}")
	ELSEIF ( page == "Combat")
		DAMAGEDEALTSCALE_OID = addSliderOption("Damage Dealt Scaling",scaleDamageDealt_VAR,"{3}x")
		DAMAGETAKENSCALE_OID = addSliderOption("Damage Taken Scaling",scaleDamageTaken_VAR,"{3}x")
		DAMAGEDEALT_NOVICE_SLIDER = addSliderOption("Damage Dealt Novice", GetGameSettingFloat("fDiffMultHPByPCVE") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()),"{2}")
		DAMAGETAKEN_NOVICE_SLIDER = addSliderOption("Damage Taken Novice", GetGameSettingFloat("fDiffMultHPToPCVE") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()),"{2}")
		DAMAGEDEALT_APPRENTICE_SLIDER = addSliderOption("Damage Dealt Apprentice", GetGameSettingFloat("fDiffMultHPByPCE") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()),"{2}")
		DAMAGETAKEN_APPRENTICE_SLIDER = addSliderOption("Damage Taken Apprentice", GetGameSettingFloat("fDiffMultHPToPCE") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()),"{2}")
		DAMAGEDEALT_ADEPT_SLIDER = addSliderOption("Damage Dealt Adept", GetGameSettingFloat("fDiffMultHPByPCN") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()),"{2}")
		DAMAGETAKEN_ADEPT_SLIDER = addSliderOption("Damage Taken Adept", GetGameSettingFloat("fDiffMultHPToPCN") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()),"{2}")
		DAMAGEDEALT_EXPERT_SLIDER = addSliderOption("Damage Dealt Expert", GetGameSettingFloat("fDiffMultHPByPCH") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()),"{2}")
		DAMAGETAKEN_EXPERT_SLIDER = addSliderOption("Damage Taken Expert", GetGameSettingFloat("fDiffMultHPToPCH") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()),"{2}")
		DAMAGEDEALT_MASTER_SLIDER = addSliderOption("Damage Dealt Master", GetGameSettingFloat("fDiffMultHPByPCVH") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()),"{2}")
		DAMAGETAKEN_MASTER_SLIDER = addSliderOption("Damage Taken Master", GetGameSettingFloat("fDiffMultHPToPCVH") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()),"{2}")
		DAMAGEDEALT_LEGENDARY_SLIDER = addSliderOption("Damage Dealt Legendary", GetGameSettingFloat("fDiffMultHPByPCL") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()),"{2}")
		DAMAGETAKEN_LEGENDARY_SLIDER = addSliderOption("Damage Taken Legendary", GetGameSettingFloat("fDiffMultHPToPCL") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()),"{2}")
		WEAPONSCALE_PCMIN_SLIDER = addSliderOption("Player Weapon Damage Scaling Min", GetGameSettingFloat("fDamagePCSkillMin"),"{1}")
		WEAPONSCALE_PCMAX_SLIDER = addSliderOption("Player Weapon Damage Scaling Max", GetGameSettingFloat("fDamagePCSkillMax"),"{1}")
		WEAPONSCALE_NPCMIN_SLIDER = addSliderOption("NPC Weapon Damage Scaling Min", GetGameSettingFloat("fDamageSkillMin"),"{1}")
		WEAPONSCALE_NPCMAX_SLIDER = addSliderOption("NPC Weapon Damage Scaling Max", GetGameSettingFloat("fDamageSkillMax"),"{1}")
		ARMOR_SCALE_SLIDER = addSliderOption("Armor Rating Scaling", GetGameSettingFloat("fArmorScalingFactor"),"{2}%")
		MAX_RESISTANCE_SLIDER = addSliderOption("Maximum Resistance", GetGameSettingFloat("fPlayerMaxResistance"),"{0}%")
		ARMOR_BASERESIST_SLIDER = addSliderOption("Armor Base Resistance", GetGameSettingFloat("fArmorBaseFactor"),"{2}")
		ARMOR_MAXRESIST_SLIDER = addSliderOption("Maximum Armor Resistance", GetGameSettingFloat("fMaxArmorRating"),"{1}%")
		PC_ARMORRATING_SLIDER = addSliderOption("Player Armor Rating Mult", GetGameSettingFloat("fArmorRatingPCMax"),"{3}")
		NPC_ARMORRATING_SLIDER = addSliderOption("NPC Armor Rating Mult", GetGameSettingFloat("fArmorRatingMax"),"{3}")
		ENCUM_EFFECT_SLIDER = addSliderOption("Armor Speed Decrease (Weapon)", GetGameSettingFloat("fMoveEncumEffect"),"{2}")
		ENCUMWEAP_EFFECT_SLIDER = addSliderOption("Armor Speed Decrease (No Weapon)", GetGameSettingFloat("fMoveEncumEffectNoWeapon"),"{2}")
		WEAPONDAMAGE_MULT_SLIDER = addSliderOption("Weapon Damage", GetGameSettingFloat("fDamageWeaponMult"),"{2}")
		TWOHAND_ATKSPD_SLIDER = addSliderOption("2H Attack Speed", GetGameSettingFloat("fWeaponTwoHandedAnimationSpeedMult"),"{1}")
		AUTOAIM_AREA_SLIDER = addSliderOption("Auto Aim Area", GetGameSettingFloat("fAutoAimScreenPercentage"),"{0}")
		AUTOAIM_RANGE_SLIDER = addSliderOption("Auto Aim Range", GetGameSettingFloat("fAutoAimMaxDistance"),"{0}")
		AUTOAIM_DEGREES_SLIDER = addSliderOption("Auto Aim Angle", GetGameSettingFloat("fAutoAimMaxDegrees"),"{1}")
		AUTOAIM_DEGREESTHIRD_SLIDER = addSliderOption("Auto Aim Angle 3rd Person", GetGameSettingFloat("fAutoAimMaxDegrees3rdPerson"),"{1}")
		STAMINA_POWERCOST_SLIDER = addSliderOption("Power Cost Mult", GetGameSettingFloat("fPowerAttackStaminaPenalty"),"{1}")
		STAMINA_BLOCKCOSTMULT_SLIDER = addSliderOption("Block Cost Mult", GetGameSettingFloat("fStaminaBlockDmgMult"),"{2}")
		STAMINA_BASHCOST_SLIDER = addSliderOption("Bash Cost", GetGameSettingFloat("fStaminaBashBase"),"{0}")
		STAMINA_POWERBASHCOST_SLIDER = addSliderOption("Power Bash Cost", GetGameSettingFloat("fStaminaPowerBashBase"),"{0}")
		STAMINA_BLOCKCOSTBASE_SLIDER = addSliderOption("Block Cost Base", GetGameSettingFloat("fStaminaBlockBase"),"{0}")
		BLOCK_SHIELD_SLIDER = addSliderOption("Shield Block Base", GetGameSettingFloat("fShieldBaseFactor"),"{2}")
		BLOCK_WEAPON_SLIDER = addSliderOption("Weapon Block Base", GetGameSettingFloat("fBlockWeaponBase"),"{2}")
		WEAPON_REACH_SLIDER = addSliderOption("Weapon Reach", GetGameSettingFloat("fCombatDistance"),"{0}")
		BASH_REACH_SLIDER = addSliderOption("Bash Reach", GetGameSettingFloat("fCombatBashReach"),"{0}")
	ELSEIF ( page == "Stealth")
		AISEARCH_TIME_SLIDER = addSliderOption("AI Search Time Attacked", GetGameSettingFloat("fCombatStealthPointRegenAttackedWaitTime"),"{0} Sec")
		AISEARCH_TIMEATTACKED_SLIDER = addSliderOption("AI Search Time", GetGameSettingFloat("fCombatStealthPointRegenDetectedEventWaitTime"),"{0} Sec")
		SNEAKLEVEL_BASE_SLIDER = addSliderOption("Sneak Level Base", GetGameSettingFloat("fPlayerDetectionSneakBase"),"{0}")
		SNEAKDETECTION_SCALE_SLIDER = addSliderOption("Sneak Scale Detection", GetGameSettingFloat("fPlayerDetectionSneakMult"),"{2}")
		DETECTION_FOV_SLIDER = addSliderOption("Detection FOV", GetGameSettingFloat("fDetectionViewCone"),"{0} Deg")
		SNEAK_BASE_SLIDER = addSliderOption("Sneak Base Value", GetGameSettingFloat("fSneakBaseValue"),"{0}")
		DETECTION_LIGHT_SLIDER = addSliderOption("Detection Light", GetGameSettingFloat("fDetectionSneakLightMod"),"{0}")
		DETECTION_LIGHTEXT_SLIDER = addSliderOption("Detection Light Exterior", GetGameSettingFloat("fSneakLightExteriorMult"),"{2}")
		DETECTION_SOUND_SLIDER = addSliderOption("Detection Sound", GetGameSettingFloat("fSneakSoundsMult"),"{2}")
		DETECTION_SOUNDLOS_SLIDER = addSliderOption("Detection Sound LOS", GetGameSettingFloat("fSneakSoundLosMult"),"{2}")
		PICKPOCKET_MAXCHANCE_SLIDER = addSliderOption("Max Pickpocket Chance", GetGameSettingFloat("fPickPocketMaxChance"),"{0}%")
		PICKPOCKET_MINCHANCE_SLIDER = addSliderOption("Min Pickpocket Chance", GetGameSettingFloat("fPickPocketMinChance"),"{0}%")
		SNEAKMULT_MARKSMAN_SLIDER = addSliderOption("Sneak Mult: Marksman", (GBT_SneakMarks.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		SNEAKMULT_DAGGER_SLIDER = addSliderOption("Sneak Mult: Dagger", (GBT_SneakDagger.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		SNEAKMULT_TWOHAND_SLIDER = addSliderOption("Sneak Mult: One Hand", (GBT_SneakOne.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		SNEAKMULT_ONEHAND_SLIDER = addSliderOption("Sneak Mult: Two Hand", (GBT_SneakTwo.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		SNEAKMULT_UNARMED_SLIDER = addSliderOption("Sneak Mult: Unarmed", (GBT_SneakH2H.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		SNEAKMULT_RUNE_SLIDER = addSliderOption("Sneak Mult: Rune Magnitude", (GBT_SneakRuneMag.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		SNEAKMULT_SEARCH_SLIDER = addSliderOption("Sneak Mult: Search", (GBT_SneakSearch.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		SNEAKMULT_SPELLMAG_SLIDER = addSliderOption("Sneak Mult: Spell Magnitude", (GBT_SneakSpellMag.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		SNEAKMULT_SPELLSEARCH_SLIDER = addSliderOption("Sneak Mult: Spell Search", (GBT_SneakSpellSearch.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		SNEAKMULT_SPELLDUR_SLIDER = addSliderOption("Sneak Mult: Spell Duration", (GBT_SneakSpellDur.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		SNEAKSCALE_PHYSICAL_SLIDER = addSliderOption("Sneak Scale: Physical", (GBT_SneakScalePhys.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		SNEAKSCALE_SPELLMAG_SLIDER = addSliderOption("Sneak Scale: Spell Magnitude", (GBT_SneakScaleSpell.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		SNEAKMULT_POISONMAG_SLIDER = addSliderOption("Sneak Mult: Poison Magnitude", (GBT_SneakPoisonMag.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		SNEAKMULT_POISONDUR_SLIDER = addSliderOption("Sneak Mult: Poison Duration", (GBT_SneakPoisonDur.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		SNEAKSCALE_POISONMAG_SLIDER = addSliderOption("Sneak Scale: Poison Magnitude", (GBT_SneakScalePoisonMag.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		SNEAKSCALE_POISONDUR_SLIDER = addSliderOption("Sneak Scale: Poison Duration", (GBT_SneakScalePoisonDur.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		LOCKPICK_VEASY_SLIDER = addSliderOption("Novice Lockpick Sweetspot", GetGameSettingFloat("fSweetSpotVeryEasy"),"{4}")
		LOCKPICKDUR_VEASY_SLIDER = addSliderOption("Novice Lockpick Durability", GetGameSettingFloat("fLockpickBreakNovice"),"{4}")
		LOCKPICK_EASY_SLIDER = addSliderOption("Apprentice Lockpick Sweetspot", GetGameSettingFloat("fSweetSpotEasy"),"{4}")
		LOCKPICKDUR_EASY_SLIDER = addSliderOption("Apprentice Lockpick Durability", GetGameSettingFloat("fLockpickBreakApprentice"),"{4}")
		LOCKPICK_AVERAGE_SLIDER = addSliderOption("Adept Lockpick Sweetspot", GetGameSettingFloat("fSweetSpotAverage"),"{4}")
		LOCKPICKDUR_AVERAGE_SLIDER = addSliderOption("Adept Lockpick Durability", GetGameSettingFloat("fLockpickBreakAdept"),"{4}")
		LOCKPICK_HARD_SLIDER = addSliderOption("Expert Lockpick Sweetspot", GetGameSettingFloat("fSweetSpotHard"),"{4}")
		LOCKPICKDUR_HARD_SLIDER = addSliderOption("Expert Lockpick Durability", GetGameSettingFloat("fLockpickBreakExpert"),"{4}")
		LOCKPICK_VHARD_SLIDER = addSliderOption("Master Lockpick Sweetspot", GetGameSettingFloat("fSweetSpotVeryHard"),"{4}")
		LOCKPICKDUR_VHARD_SLIDER = addSliderOption("Master Lockpick Durability", GetGameSettingFloat("fLockpickBreakMaster"),"{4}")
	ELSEIF ( page == "Crafting")
		ALCHEMYMAG_MULT_SLIDER = addSliderOption("Alchemy Magnitude Mult", GetGameSettingFloat("fAlchemyIngredientInitMult"),"{1}")
		ALCHEMYMAG_SCALE_SLIDER = addSliderOption("Alchemy Magnitude Scaling", GetGameSettingFloat("fAlchemySkillFactor"),"{2}")
		BONUS_INGR_SLIDER = addSliderOption("Bonus Ingredients Harvested", (GBT_bonusIngredients.GetNthEntryValue(0, 0) * 1) + 0,"{0}")
		BONUS_POTION_SLIDER = addSliderOption("Bonus Potions Crafted", (GBT_bonusPotions.GetNthEntryValue(0, 0) * 1) + 0,"{0}")
		CHARGECOST_POWER_SLIDER = addSliderOption("Charge Cost: Power", GetGameSettingFloat("fEnchantingCostExponent"),"{2}")
		ENCHANT_SCALING_SLIDER = addSliderOption("Enchant Skill Scaling", GetGameSettingFloat("fEnchantingSkillFactor"),"{2}")
		CHARGECOST_MULT_SLIDER = addSliderOption("Charge Cost: Mult", GetGameSettingFloat("fEnchantingSkillCostMult"),"{1}")
		ENCHANTPRICE_EFFECT_SLIDER = addSliderOption("Enchant Price: Effect Mult", GetGameSettingFloat("fEnchantmentEffectPointsMult"),"{1}")
		CHARGECOST_BASE_SLIDER = addSliderOption("Charge Cost: Base", GetGameSettingFloat("fEnchantingSkillCostBase"),"{3}")
		ENCHANTPRICE_SOUL_SLIDER = addSliderOption("Enchant Price: Soul Mult", GetGameSettingFloat("fEnchantmentPointsMult"),"{2}")
		ENCHANT_CHARGE_SLIDER = addSliderOption("Enchantment Charges Mult", (GBT_enchantCharge.GetNthEntryValue(0, 0) * 100) + 0,"{0}%")
		ENCHANT_MAG_SLIDER = addSliderOption("Enchantment Magnitude Mult", (GBT_enchantMag.GetNthEntryValue(0, 0) * 100) + 0,"{0}%")
		BONUS_ENCHANT_SLIDER = addSliderOption("Bonus Enchantment Effects", (GBT_bonusEnchants.GetNthEntryValue(0, 0) * 1) + 0,"{0}")
		TEMPER_SUFFIX_SLIDER = addSliderOption("Tempering Suffix Distribution", GetGameSettingFloat("fSmithingConditionFactor"),"{2}")
		TEMPER_ARMOR_SLIDER = addSliderOption("Armor Tempering", GetGameSettingFloat("fSmithingArmorMax"),"{1}")
		TEMPER_WEAPON_SLIDER = addSliderOption("Weapon Tempering", GetGameSettingFloat("fSmithingWeaponMax"),"{1}")
		POTION_MAG_SLIDER = addSliderOption("Potion Magnitude", (GBT_PotionMag.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		POTION_DUR_SLIDER = addSliderOption("Potion Duration", (GBT_PotionDur.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		POTION_SCALEMAG_SLIDER = addSliderOption("Potion Scale Magnitude", (GBT_PotionScaleMag.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		POTION_SCALEDUR_SLIDER = addSliderOption("Potion Scale Duration", (GBT_PotionScaleDur.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		POISON_MAG_SLIDER = addSliderOption("Poison Magnitude", (GBT_PoisonMag.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		POISON_DUR_SLIDER = addSliderOption("Poison Duration", (GBT_PoisonDur.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		POISON_SCALEMAG_SLIDER = addSliderOption("Poison Scale Magnitude", (GBT_PoisonScaleMag.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		POISON_SCALEDUR_SLIDER = addSliderOption("Poison Scale Duration", (GBT_PoisonScaleDur.GetNthEntryValue(0, 1) * 10000) + 100,"{0}%")
		SCROLL_MAG_SLIDER = addSliderOption("Scroll Magnitude", (GBT_ScrollMag.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
		SCROLL_DUR_SLIDER = addSliderOption("Scroll Duration", (GBT_ScrollDur.GetNthEntryValue(0, 0) * 1) + 0,"{2}")
	ELSEIF ( page == "Vendors")
		BARTER_BUYMIN_SLIDER = addSliderOption("Min Buy Price Factor", GetGameSettingFloat("fBarterBuyMin"),"{2}")
		BARTER_SELLMAX_SLIDER = addSliderOption("Max Sell Price Factor", GetGameSettingFloat("fBarterSellMax"),"{2}")
		BARTER_MIN_SLIDER = addSliderOption("fBarterMin", GetGameSettingFloat("fBarterMin"),"{2}")
		BARTER_MAX_SLIDER = addSliderOption("fBarterMax", GetGameSettingFloat("fBarterMax"),"{2}")
		BUY_PRICE_SLIDER = addSliderOption("Buy Price Mult", (GBT_buyPrice.GetNthEntryValue(0, 0) * 100) + 0,"{0}%")
		SELL_PRICE_SLIDER = addSliderOption("Sell Price Mult", (GBT_sellPrice.GetNthEntryValue(0, 0) * 100) + 0,"{0}%")
		VENDOR_RESPAWN_SLIDER = addSliderOption("Vendor Respawn Times", GetGameSettingInt("iDaysToRespawnVendor"),"{0}")
		TRAINING_NUMALLOWED_SLIDER = addSliderOption("Training Per Level", GetGameSettingInt("iTrainingNumAllowedPerLevel"),"{0}")
		TRAINING_JOURNEYMANCOST_SLIDER = addSliderOption("Journeyman Training Cost", GetGameSettingInt("iTrainingJourneymanCost"),"{0}")
		TRAINING_JOURNEYMANSKILL_SLIDER = addSliderOption("Journeyman Training Skill", GetGameSettingInt("iTrainingJourneymanSkill"),"{0}")
		TRAINING_EXPERTCOST_SLIDER = addSliderOption("Expert Training Cost", GetGameSettingInt("iTrainingExpertCost"),"{0}")
		TRAINING_EXPERTSKILL_SLIDER = addSliderOption("Expert Training Skill", GetGameSettingInt("iTrainingExpertSkill"),"{0}")
		TRAINING_MASTERCOST_SLIDER = addSliderOption("Master Training Cost", GetGameSettingInt("iTrainingMasterCost"),"{0}")
		TRAINING_MASTERSKILL_SLIDER = addSliderOption("Master Training Skill", GetGameSettingInt("iTrainingMasterSkill"),"{0}")
		APOTHECARY_GOLD_SLIDER = addSliderOption("Apothecary Base Gold", VendorGoldApothecary.GetNthCount(0) ,"{0}")
		BLACKSMITH_GOLD_SLIDER = addSliderOption("City Blacksmith Base Gold", VendorGoldBlacksmith.GetNthCount(0) ,"{0}")
		ORCBLACKSMITH_GOLD_SLIDER = addSliderOption("Orc Blacksmith Base Gold", VendorGoldBlacksmithOrc.GetNthCount(0) ,"{0}")
		TOWNBLACKSMITH_GOLD_SLIDER = addSliderOption("Town Blacksmith Base Gold", VendorGoldBlacksmithTown.GetNthCount(0) ,"{0}")
		INNKEERPER_GOLD_SLIDER = addSliderOption("Innkeeper Base Gold", VendorGoldInn.GetNthCount(0) ,"{0}")
		MISCMERCHANT_GOLD_SLIDER = addSliderOption("Misc Merchant Base Gold", VendorGoldMisc.GetNthCount(0) ,"{0}")
		SPELLMERCHANT_GOLD_SLIDER = addSliderOption("Spell Merchant Base Gold", VendorGoldSpells.GetNthCount(0) ,"{0}")
		STREETVENDOR_GOLD_SLIDER = addSliderOption("Street Vendor Base Gold", VendorGoldStreetVendor.GetNthCount(0) ,"{0}")
	ELSEIF ( page == "Attributes")
		COMBAT_STAMINAREGEN_SLIDER = addSliderOption("Combat Stamina Regen", GetGameSettingFloat("fCombatStaminaRegenRateMult"),"{2}")
		AV_COMBATHEALTHREGENMULT_SLIDER = addSliderOption("CombatHealthRegenMult", PlayerRef.GetAV("CombatHealthRegenMult"),"{2}")
		DAMAGESTAMINA_DELAY_SLIDER = addSliderOption("Damage Stamina Delay", GetGameSettingFloat("fDamagedStaminaRegenDelay"),"{1} sec")
		BOWZOOM_REGENDELAY_SLIDER = addSliderOption("Bow Zoom Regen Delay", GetGameSettingFloat("fBowZoomStaminaRegenDelay"),"{1} sec")
		COMBAT_MAGICKAREGEN_SLIDER = addSliderOption("Combat Magicka Regen", GetGameSettingFloat("fCombatMagickaRegenRateMult"),"{2}")
		STAMINA_REGENDELAY_SLIDER = addSliderOption("Stamina Regen Delay", GetGameSettingFloat("fStaminaRegenDelayMax"),"{1} sec")
		DAMAGEMAGICKA_DELAY_SLIDER = addSliderOption("Damage Magicka Delay", GetGameSettingFloat("fDamagedMagickaRegenDelay"),"{1} sec")
		MAGICKA_REGENDELAY_SLIDER = addSliderOption("Magicka Regen Delay", GetGameSettingFloat("fMagickaRegenDelayMax"),"{1} sec")
		AV_HEALRATEMULT_SLIDER = addSliderOption("HealRateMult", PlayerRef.GetAV("HealRateMult"),"{0}")
		AV_HEALRATE_SLIDER = addSliderOption("Base Healrate", PlayerRef.GetBaseAV("HealRate"),"{2}")
		AV_MAGICKARATEMULT_SLIDER = addSliderOption("MagickaRateMult", PlayerRef.GetAV("MagickaRateMult"),"{0}")
		AV_MAGICKARATE_SLIDER = addSliderOption("Base MagickaRate", PlayerRef.GetBaseAV("MagickaRate"),"{2}")
		AV_STAMINARATEMULT_SLIDER = addSliderOption("StaminaRateMult", PlayerRef.GetAV("StaminaRateMult"),"{0}")
		AV_STAMINARATE_SLIDER = addSliderOption("Base Stamina Rate", PlayerRef.GetBaseAV("StaminaRate"),"{2}")
		AV_HEALTH_SLIDER = addSliderOption("Health", PlayerRef.GetAV("Health"),"{0}")
		AV_MAGICKA_SLIDER = addSliderOption("Magicka ", PlayerRef.GetAV("Magicka"),"{0}")
		AV_STAMINA_SLIDER = addSliderOption("Stamina ", PlayerRef.GetAV("Stamina"),"{0}")
	ELSEIF ( page == "Actor Values")
		AV_DRAGONSOULS_SLIDER = addSliderOption("DragonSouls", PlayerRef.GetAV("DragonSouls"),"{0}")
		AV_SHOUTRECOVERYMULT_SLIDER = addSliderOption("ShoutRecoveryMult", PlayerRef.GetAV("ShoutRecoveryMult"),"{2}")
		AV_CARRYWEIGHT_SLIDER = addSliderOption("Base CarryWeight", PlayerRef.GetBaseAV("CarryWeight"),"{0}")
		AV_SPEEDMULT_SLIDER = addSliderOption("Base SpeedMult", PlayerRef.GetBaseAV("SpeedMult"),"{0}")
		AV_UNARMEDDAMAGE_SLIDER = addSliderOption("Base Unarmed Damage", PlayerRef.GetBaseAV("UnarmedDamage"),"{0}")
		AV_MASS_SLIDER = addSliderOption("Base Mass", PlayerRef.GetBaseAV("Mass"),"{2}")
		AV_CRITCHANCE_SLIDER = addSliderOption("Base Crit Chance", PlayerRef.GetBaseAV("CritChance"),"{0}")
		AV_ALTERATIONPOWERMOD_SLIDER = addSliderOption("AlterationPowerMod", PlayerRef.GetAV("AlterationPowerMod"),"{0}")
		AV_CONJURATIONPOWERMOD_SLIDER = addSliderOption("ConjurationPowerMod", PlayerRef.GetAV("ConjurationPowerMod"),"{0}")
		AV_DESTRUCTIONPOWERMOD_SLIDER = addSliderOption("DestructionPowerMod", PlayerRef.GetAV("DestructionPowerMod"),"{0}")
		AV_ILLUSIONPOWERMOD_SLIDER = addSliderOption("IllusionPowerMod", PlayerRef.GetAV("IllusionPowerMod"),"{0}")
		AV_RESTORATIONPOWERMOD_SLIDER = addSliderOption("RestorationPowerMod", PlayerRef.GetAV("RestorationPowerMod"),"{0}")
		AV_BOWSTAGGERBONUS_SLIDER = addSliderOption("BowStaggerBonus", PlayerRef.GetAV("BowStaggerBonus"),"{2}")
		AV_BOWSPEEDBONUSVAR_SLIDER = addSliderOption("Base BowSpeedBonusVar", PlayerRef.GetBaseAV("BowSpeedBonus"),"{2}")
		AV_LEFTWEAPONSPEEDMULT_SLIDER = addSliderOption("LeftWeaponSpeedMult", PlayerRef.GetAV("LeftWeaponSpeedMult"),"{2}")
		AV_WEAPONSPEEDMULT_SLIDER = addSliderOption("WeaponSpeedMult", PlayerRef.GetAV("WeaponSpeedMult"),"{2}")
		AV_MAGICRESIST_SLIDER = addSliderOption("MagicResist", PlayerRef.GetAV("MagicResist"),"{0}")
		AV_FIRERESIST_SLIDER = addSliderOption("FireResist", PlayerRef.GetAV("FireResist"),"{0}")
		AV_POISONRESIST_SLIDER = addSliderOption("PoisonResist", PlayerRef.GetAV("PoisonResist"),"{0}")
		AV_ELECTRICRESIST_SLIDER = addSliderOption("ElectricResist", PlayerRef.GetAV("ElectricResist"),"{0}")
		AV_DISEASERESIST_SLIDER = addSliderOption("DiseaseResist", PlayerRef.GetAV("DiseaseResist"),"{0}")
		AV_FROSTRESIST_SLIDER = addSliderOption("FrostResist", PlayerRef.GetAV("FrostResist"),"{0}")
	ELSEIF ( page == "MISC")
		PERK_POINTS_SLIDER = addSliderOption("Perk Points", GetPerkPoints(),"{0}")
		TIME_SCALE_SLIDER = addSliderOption("Time Scale", TimeScale.GetValueInt(),"{0}")
		FALLHEIGHT_MINNPC_SLIDER = addSliderOption("NPC Fall Damage Height", GetGameSettingFloat("fJumpFallHeightMinNPC"),"{0}")
		FALLHEIGHT_MIN_SLIDER = addSliderOption("Fall Damage Height", GetGameSettingFloat("fJumpFallHeightMin"),"{0}")
		FALLHEIGHT_MULTNPC_SLIDER = addSliderOption("NPC Fall Damage Mult", GetGameSettingFloat("fJumpFallHeightMultNPC"),"{1}")
		FALLHEIGHT_MULT_SLIDER = addSliderOption("Fall Damage Mult", GetGameSettingFloat("fJumpFallHeightMult"),"{1}")
		FALLHEIGHT_EXPNPC_SLIDER = addSliderOption("NPC Fall Damage Exponent", GetGameSettingFloat("fJumpFallHeightExponentNPC"),"{2}")
		FALLHEIGHT_EXP_SLIDER = addSliderOption("Fall Damage Exponent", GetGameSettingFloat("fJumpFallHeightExponent"),"{2}")
		JUMP_HEIGHT_SLIDER = addSliderOption("Jump Height", GetGameSettingFloat("fJumpHeightMin"),"{0}")
		SWIM_BREATHBASE_SLIDER = addSliderOption("Breath Timer (Seconds)", GetGameSettingFloat("fActorSwimBreathBase"),"{1} sec")
		SWIM_BREATHDAMAGE_SLIDER = addSliderOption("Drowning Damage", GetGameSettingFloat("fActorSwimBreathDamage"),"{2}")
		SWIM_BREATHMULT_SLIDER = addSliderOption("Breath Timer (Minutes)", GetGameSettingFloat("fActorSwimBreathMult"),"{1} min")
		KILLCAM_CHANCE_SLIDER = addSliderOption("Kill Cam Chance", GetGameSettingFloat("fKillCamBaseOdds"),"{2}")
		DEATHCAMERA_TIME_SLIDER = addSliderOption("Player Death Camera Time", GetGameSettingFloat("fPlayerDeathReloadTime"),"{0} sec")
		KILLMOVE_CHANCE_SLIDER = addSliderOption("Kill Move Chance", KillMoveRandom.GetValue(),"{0}%")
		DECAPITATION_CHANCE_SLIDER = addSliderOption("Decapitation Chance", DecapitationChance.GetValue(),"{0}%")
		SPRINT_DRAINBASE_SLIDER = addSliderOption("Sprint Stamina Drain Base", GetGameSettingFloat("fSprintStaminaDrainMult"),"{2}")
		SPRINT_DRAINMULT_SLIDER = addSliderOption("Sprint Stamina Drain Mult", GetGameSettingFloat("fSprintStaminaWeightMult"),"{2}")
		ARROW_RECOVERY_SLIDER = addSliderOption("Arrow Recovery Chance", GetGameSettingInt("iArrowInventoryChance"),"{0}%")
		DEATH_DROPCHANCE_SLIDER = addSliderOption("Death Weapon Drop Chance", GetGameSettingInt("iDeathDropWeaponChance"),"{0}%")
		CAMERA_SHAKETIME_SLIDER = addSliderOption("Camera Shake Time", GetGameSettingFloat("fCameraShakeTime"),"{2}")
		FASTRAVEL_SPEED_SLIDER = addSliderOption("Fast Travel Speed Mult", GetGameSettingFloat("fFastTravelSpeedMult"),"{2}")
		HUDCOMPASS_DISTANEC_SLIDER = addSliderOption("HUD Compass Distance", GetGameSettingFloat("fHUDCompassLocationMaxDist"),"{0}")
		ATTACHED_ARROWS_SLIDER = addSliderOption("Max Attached Arrows", GetGameSettingInt("iMaxAttachedArrows"),"{0}")
		LightRadius_OID = addSliderOption("Light Radius", GetLightRadius(Torch01),"{0}")
		LightDuration_OID = addSliderOption("Light Duration", GetLightDuration(Torch01),"{0}s")
		SPECIAL_LOOT_SLIDER = addSliderOption("No Special Loot Chance", SpecialLootChance.GetValueInt(),"{0}%")
	ELSEIF ( page == "NPC")
		FRIENDHIT_TIMER_SLIDER = addSliderOption("Friend Hit Timer", GetGameSettingFloat("fFriendHitTimer"),"{1} sec")
		FRIENDHIT_INTERVAL_SLIDER = addSliderOption("Friend Hit Interval", GetGameSettingFloat("fFriendMinimumLastHitTime"),"{1} sec")
		FRIENDHIT_COMBAT_SLIDER = addSliderOption("Friend Hits Allowed (Combat)", GetGameSettingInt("iFriendHitCombatAllowed"),"{0}")
		FRIENDHIT_NONCOMBAT_SLIDER = addSliderOption("Friend Hits Allowed (NonCombat)", GetGameSettingInt("iFriendHitNonCombatAllowed"),"{0}")
		ALLYHIT_COMBAT_SLIDER = addSliderOption("Ally Hits Allowed (Combat)", GetGameSettingInt("iAllyHitCombatAllowed"),"{0}")
		ALLYHIT_NONCOMBAT_SLIDER = addSliderOption("Ally Hits Allowed (NonCombat)", GetGameSettingInt("iAllyHitNonCombatAllowed"),"{0}")
		COMBAT_DODGECHANCE_SLIDER = addSliderOption("AI Dodge Chance", GetGameSettingFloat("fCombatDodgeChanceMax"),"{1}")
		COMBAT_AIMOFFSET_SLIDER = addSliderOption("AI Aim Offset", GetGameSettingFloat("fCombatAimProjectileRandomOffset"),"{0}")
		COMBAT_FLEEHEALTH_SLIDER = addSliderOption("AI Flee Health Mult", GetGameSettingFloat("fAIFleeHealthMult"),"{0}%")
		DIALOGUE_PADDING_SLIDER = addSliderOption("Dialogue Padding", GetGameSettingFloat("fGameplayVoiceFilePadding"),"{2} sec")
		DIALOGUE_DISTANCE_SLIDER = addSliderOption("Dialogue Distance", GetGameSettingFloat("fAIMinGreetingDistance"),"{0}")
		FOLLOWER_SPACING_SLIDER = addSliderOption("Follower Spacing", GetGameSettingFloat("fFollowSpaceBetweenFollowers"),"{0}")
		FOLLOWER_CATCHUP_SLIDER = addSliderOption("Follower Catch Up", GetGameSettingFloat("fFollowExtraCatchUpSpeedMult"),"{2}")
		LEVELSCALING_MULT_SLIDER = addSliderOption("Level Scaling Mult", GetGameSettingFloat("fLevelScalingMult"),"{2}")
		LEVELEDACTOR_EASY_SLIDER = addSliderOption("Level Scaling (Easy Zones)", GetGameSettingFloat("fLeveledActorMultEasy"),"{2}")
		LEVELEDACTOR_HARD_SLIDER = addSliderOption("Level Scaling (Hard Zones)", GetGameSettingFloat("fLeveledActorMultHard"),"{2}")
		LEVELEDACTOR_MEDIUM_SLIDER = addSliderOption("Level Scaling (Medium Zones)", GetGameSettingFloat("fLeveledActorMultMedium"),"{2}")
		LEVELEDACTOR_VHARD_SLIDER = addSliderOption("Level Scaling (Very Hard Zones)", GetGameSettingFloat("fLeveledActorMultVeryHard"),"{2}")
		RESPAWN_TIME_SLIDER = addSliderOption("Respawn Time", GetGameSettingInt("iHoursToRespawnCell"),"{0}")
		NPC_HEALTHBONUS_SLIDER = addSliderOption("NPC Health Bonus", GetGameSettingFloat("fNPCHealthLevelBonus"),"{0}")
	ELSEIF ( page == "Experience")
		LEVELUP_ATTRIBUTE_SLIDER = addSliderOption("Attribute per Level", GetGameSettingInt("iAVDhmsLevelup"),"{0}")
		LEVELUP_CARRYWEIGHT_SLIDER = addSliderOption("Carry Weight per Level", GetGameSettingFloat("fLevelUpCarryWeightMod"),"{0}")
		LEGENDARYRESET_LEVEL_SLIDER = addSliderOption("Legendary Reset Level", GetGameSettingFloat("fLegendarySkillResetValue"),"{0}")
		LEVELUP_POWER_SLIDER = addSliderOption("Skill Level Cost Power", GetGameSettingFloat("fSkillUseCurve"),"{2}")
		LEVELUP_BASE_SLIDER = addSliderOption("Overall Level Cost Base", GetGameSettingFloat("fXPLevelUpBase"),"{0}")
		LEVELUP_MULT_SLIDER = addSliderOption("Overall Level Cost Mult", GetGameSettingFloat("fXPLevelUpMult"),"{0}")
		SKILLUSE_ALCHEMY_SLIDER = addSliderOption("Alchemy Experience Rate", GetAVIByID(16).GetSkillUseMult(),"{2}")
		SKILLUSE_ALTERATION_SLIDER = addSliderOption("Alteration Experience Rate", GetAVIByID(18).GetSkillUseMult(),"{2}")
		SKILLUSE_BLOCK_SLIDER = addSliderOption("Block Experience Rate", GetAVIByID(9).GetSkillUseMult(),"{2}")
		SKILLUSE_CONJURATION_SLIDER = addSliderOption("Conjuration Experience Rate", GetAVIByID(19).GetSkillUseMult(),"{2}")
		SKILLUSE_DESTRUCTION_SLIDER = addSliderOption("Destruction Experience Rate", GetAVIByID(20).GetSkillUseMult(),"{2}")
		SKILLUSE_ENCHANTING_SLIDER = addSliderOption("Enchanting Experience Rate", GetAVIByID(23).GetSkillUseMult(),"{2}")
		SKILLUSE_HEAVYARMOR_SLIDER = addSliderOption("HeavyArmor Experience Rate", GetAVIByID(11).GetSkillUseMult(),"{2}")
		SKILLUSE_ILLUSION_SLIDER = addSliderOption("Illusion Experience Rate", GetAVIByID(21).GetSkillUseMult(),"{2}")
		SKILLUSE_LIGHTARMOR_SLIDER = addSliderOption("LightArmor Experience Rate", GetAVIByID(12).GetSkillUseMult(),"{2}")
		SKILLUSE_LOCKPICKING_SLIDER = addSliderOption("Lockpicking Experience Rate", GetAVIByID(14).GetSkillUseMult(),"{2}")
		SKILLUSE_MARKSMAN_SLIDER = addSliderOption("Marksman Experience Rate", GetAVIByID(8).GetSkillUseMult(),"{2}")
		SKILLUSE_ONEHANDED_SLIDER = addSliderOption("OneHanded Experience Rate", GetAVIByID(6).GetSkillUseMult(),"{2}")
		SKILLUSE_PICKPOCKET_SLIDER = addSliderOption("Pickpocketing Experience Rate", GetAVIByID(13).GetSkillUseMult(),"{2}")
		SKILLUSE_RESTORATION_SLIDER = addSliderOption("Restoration Experience Rate", GetAVIByID(22).GetSkillUseMult(),"{2}")
		SKILLUSE_SMITHING_SLIDER = addSliderOption("Smithing Experience Rate", GetAVIByID(10).GetSkillUseMult(),"{2}")
		SKILLUSE_SNEAK_SLIDER = addSliderOption("Sneak Experience Rate", GetAVIByID(15).GetSkillUseMult(),"{2}")
		SKILLUSE_SPEECHCRAFT_SLIDER = addSliderOption("Speechcraft Experience Rate", GetAVIByID(17).GetSkillUseMult(),"{2}")
		SKILLUSE_TWOHAND_SLIDER = addSliderOption("TwoHanded Experience Rate", GetAVIByID(7).GetSkillUseMult(),"{2}")
	ELSEIF ( page == "Physics")
		RFORCE_MIN_SLIDER = addSliderOption("Min Ranged Ragdoll Force", GetGameSettingFloat("fDeathForceRangedForceMin"),"{0}")
		RFORCE_MAX_SLIDER = addSliderOption("Max Ranged Ragdoll Force", GetGameSettingFloat("fDeathForceRangedForceMax"),"{0}")
		MFORCE_MIN_SLIDER = addSliderOption("Min Melee Ragdoll Force", GetGameSettingFloat("fDeathForceForceMin"),"{0}")
		MFORCE_MAX_SLIDER = addSliderOption("Max Melee Ragdoll Force", GetGameSettingFloat("fDeathForceForceMax"),"{0}")
		SFORCE_SLIDER = addSliderOption("Spell Ragdoll Force Mult", GetGameSettingFloat("fDeathForceSpellImpactMult"),"{0}")
		GFORCE_SLIDER = addSliderOption("Grab Force", GetGameSettingFloat("fZKeyMaxForce"),"{0}")
	ELSEIF ( page == "INI")
		FIRST_FOV_SLIDER = addSliderOption("First Person FOV", GetINIFloat("fDefaultWorldFOV:Display"),"{0}")
		THIRD_FOV_SLIDER = addSliderOption("Third Person FOV", GetINIFloat("fDefault1stPersonFOV:Display"),"{0}")
		XSENSITIVITY_SLIDER = addSliderOption("Mouse X Sensitivity", GetINIFloat("fMouseHeadingXScale:Controls"),"{3}")
		YSENSITIVITY_SLIDER = addSliderOption("Mouse Y Sensitivity", GetINIFloat("fMouseHeadingYScale:Controls"),"{3}")
		COMBAT_SHOULDERY_SLIDER = addSliderOption("Combat Over Shoulder Add Y", GetINIFloat("fOverShoulderCombatAddY:Camera"),"{0}")
		COMBAT_SHOULDERZ_SLIDER = addSliderOption("Combat Over Shoulder Pos Z", GetINIFloat("fOverShoulderCombatPosZ:Camera"),"{0}")
		COMBAT_SHOULDERX_SLIDER = addSliderOption("Combat Over Shoulder Pos X", GetINIFloat("fOverShoulderCombatPosX:Camera"),"{0}")
		SHOULDERZ_SLIDER = addSliderOption("Over Shoulder Pos Z", GetINIFloat("fOverShoulderPosZ:Camera"),"{0}")
		SHOULDERX_SLIDER = addSliderOption("Over Shoulder Pos X", GetINIFloat("fOverShoulderPosX:Camera"),"{0}")
		AUTOSAVE_COUNT_SLIDER = addSliderOption("Autosave Slot Count", GetINIInt("iAutoSaveCount:SaveGame"),"{0}")
		SHOWCOMPASS_TOGGLE = addToggleOption("Show Compass", GetINIBool("bShowCompass:Interface"))
		DEPTHFIELD_TOGGLE = addToggleOption("Depth of Field Blur", GetINIBool("bDoDepthOfField:Imagespace"))
		HAVOK_HIT_TOGGLE = addToggleOption("Enable Havok Hit", GetINIBool("bEnableHavokHit:Animation"))
		HAVOK_HIT_SLIDER = addSliderOption("Havok Hit Mult", GetINIFloat("fHavokHitImpulseMult:Animation"),"{0}")
		SHOW_TUTORIAL_TOGGLE = addToggleOption("Show Tutorials", GetINIBool("bShowTutorials:Interface"))
		BOOK_SPEED_SLIDER = addSliderOption("Book Open Time", GetINIFloat("fBookOpenTime:Interface"),"{0}")
		FIRST_ARROWTILT_SLIDER = addSliderOption("1st Person Arrow Tilt", GetINIFloat("f1PArrowTiltUpAngle:Combat"),"{2}")
		THIRD_ARROWTILT_SLIDER = addSliderOption("3rd Person Arrow Tilt", GetINIFloat("f3PArrowTiltUpAngle:Combat"),"{2}")
		FIRST_BOLTTILT_SLIDER = addSliderOption("1st Person Bolt Tilt", GetINIFloat("f1PBoltTiltUpAngle:Combat"),"{2}")
		NPC_USEAMMO_TOGGLE = addToggleOption("NPCs Use Ammo", GetINIBool("bForceNPCsUseAmmo:Combat"))
		NAVMESH_DISTANCE_SLIDER = addSliderOption("Visible Navmesh Distance", GetINIFloat("fVisibleNavmeshMoveDist:Actor"),"{0}")
		FRICTION_LAND_SLIDER = addSliderOption("Landscape Friction", GetINIFloat("fLandFriction:Landscape"),"{1}")
		TREE_ANIMATION_TOGGLE = addToggleOption("Enable Tree Animations", GetINIBool("bEnableTreeAnimations:Trees"))
		GORE_TOGGLE = addToggleOption("Disable Gore", GetINIBool("bDisableAllGore:General"))
		CONSOLE_TEXT_SLIDER = addSliderOption("Console Text Size", GetINIInt("iConsoleTextSize:Menu"),"{0}")
		CONSOLE_PERCENT_SLIDER = addSliderOption("Console Size Percent", GetINIInt("iConsoleSizeScreenPercent:Menu"),"{0}")
		MAP_YAW_SLIDER = addSliderOption("World Map Yaw Range", GetINIFloat("fMapWorldYawRange:MapMenu"),"{0}")
		MAP_PITCH_SLIDER = addSliderOption("World Map Pitch Range", GetINIFloat("fMapWorldMaxPitch:MapMenu"),"{0}")
		VATS_TOGGLE = addToggleOption("Disable VATS Kill Camera", GetINIBool("bVatsDisable:VATS"))
		ALWAYS_ACTIVE_TOGGLE = addToggleOption("Run Skyrim In Background", GetINIBool("bAlwaysActive:General"))
		ESSENTIAL_NPC_TOGGLE = addToggleOption("Essential NPCs Can't Die", GetINIBool("bEssentialTakeNoDamage:Gameplay"))
	ELSEIF ( page == "Scripts")
		LEGENDARY_BONUS_TOGGLE = addToggleOption("Enable Legendary Bonus", PlayerRef.HasSpell(GBT_legendaryBonus))
		LEGENDARY_BONUS_SLIDER = addSliderOption("Bonus per reset", GBT_legendaryBonus_Float,"{0}")
		ARROW_FAMINE_TOGGLE = addToggleOption("Enable Arrow Famine", PlayerRef.HasSpell(GBT_arrowFamine))
		ARROW_FAMINE_SLIDER = addSliderOption("Arrows per Shot", GBT_arrowFamine_Float,"{0}")
		SNEAK_FATIGUE_TOGGLE = addToggleOption("Enable Sneak Fatigue", PlayerRef.HasSpell(GBT_sneakFatigue))
		SNEAK_FATIGUE_SLIDER = addSliderOption("Stamina per Second", GBT_sneakFatigue_Float,"{0}")
		TIMED_BLOCK_TOGGLE = addToggleOption("Enable Timed Block", PlayerRef.HasSpell(GBT_enableTimedBlock))
		addHeaderOption("")
		TIMEDBLOCK_WEAPON_SLIDER = addSliderOption("Weapon Block Time", GBT_timeBlockWeapon_Float,"{2}")
		TIMEDBLOCK_SHIELD_SLIDER = addSliderOption("Shield Block Time", GBT_timeBlockShield_Float,"{2}")
		TIMEDBLOCK_REFLECTTIME_SLIDER = addSliderOption("Stamina Reflect Time", GBT_timeBlockReflect_Float,"{2}")
		TIMEDBLOCK_REFLECTWARD_SLIDER = addSliderOption("Ward Reflect Time", GBT_timeBlockWard_Float,"{2}")
		TIMEDBLOCK_REFLECTDMG_SLIDER = addSliderOption("Reflected Damage", GBT_timeBlockDamage_Float,"{0}")
		TIMEDBLOCK_EXP_SLIDER = addSliderOption("Timed Block XP", GBT_timeBlockXP_Float,"{1}")
		ITEM_LIMITER_TOGGLE = addToggleOption("Enable Item Limiter", PlayerRef.HasSpell(GBT_enableItemAdded))
		addHeaderOption("")
		ITEMLIMITER_LOCKPICK_SLIDER = addSliderOption("Lockpick Limit", GBT_limitLockpick_Int,"{0}")
		ITEMLIMITER_ARROW_SLIDER = addSliderOption("Arrow Limit", GBT_limitArrow_Int,"{0}")
		ITEMLIMITER_POTION_SLIDER = addSliderOption("Potion Limit", GBT_limitPotion_Int,"{0}")
		ITEMLIMITER_POISON_SLIDER = addSliderOption("Poison Limit", GBT_limitPoison_Int,"{0}")
		PLAYER_STAGGER_TOGGLE = addToggleOption("Enable Player Stagger", PlayerRef.HasSpell(GBT_enableOnHit))
		addHeaderOption("")
		PLAYERSTAGGER_BASEDUR_SLIDER = addSliderOption("Base Stagger Duration", GBT_staggerTaken_Float,"{2}")
		PLAYERSTAGGER_IMMUNITY_SLIDER = addSliderOption("Stagger Immunity Duration", GBT_staggerImmunity_Float,"{2}")
		PLAYERSTAGGER_ARMORWEIGHT_SLIDER = addSliderOption("Armor Weight Factor", GBT_staggerArmor_Float,"{0}")
		PLAYERSTAGGER_MAGICKACOST_SLIDER = addSliderOption("Magicka Cost Factor", GBT_staggerMagicka_Float,"{0}")
		PLAYERSTAGGER_MINTHRESH_SLIDER = addSliderOption("Minimum Stagger Threshold", GBT_staggerMin_Float,"{2}")
		PLAYERSTAGGER_MAXTHRESH_SLIDER = addSliderOption("Maximum Stagger Duration", GBT_staggerMax_Float,"{1}")
		NPC_STAGGER_TOGGLE = addToggleOption("Enable NPC Stagger (Melee)", PlayerRef.HasSpell(GBT_enableMeleeStagger))
		addHeaderOption("")
		NPCSTAGGER_MULT_SLIDER = addSliderOption("Weapon Stagger Mult", GBT_MeleeStaggerMult_Float,"{2}")
		NPCSTAGGER_BASE_SLIDER = addSliderOption("Base Stagger", GBT_MeleeStaggerBase_Float,"{2}")
		NPCSTAGGER_ARMORWEIGHT_SLIDER = addSliderOption("Armor Weight Factor", GBT_MeleeStaggerWeight_Float,"{2}")
		NPCSTAGGER_IMMUNITY_SLIDER = addSliderOption("Stagger Immunity Duration", GBT_MeleeStaggerCD_Float,"{2}")
		BLEEDOUT_TOGGLE = addToggleOption("Enable Bleedout", PlayerRef.HasSpell(GBT_enableBleedout))
		addHeaderOption("")
		BLEEDOUT_LOSSBASE_SLIDER = addSliderOption("Gold Loss Base", GBT_bleedoutBase_Float,"{2}")
		BLEEDOUT_LOSSMULT_SLIDER = addSliderOption("Gold Loss Level Mult", GBT_bleedoutMult_Int,"{0}")
		BLEEDOUT_MAXLIVES_SLIDER = addSliderOption("Number of Lives", GBT_bleedoutLivesMax_Int,"{0}")
		addHeaderOption("")
		ARMOR_CMBEXP_TOGGLE = addToggleOption("Defense Experience In Combat", PlayerRef.HasSpell(GBT_EnableCombatState))
		ARMOR_CMBEXP_SLIDER = addSliderOption("Armor Exp Per Minute", GBT_ArmorExp_Float,"{0}")
		BLOCK_CMBEXP_SLIDER = addSliderOption("Block Exp Per Minute", GBT_BlockExp_Float,"{0}")
	ELSE
		addHeaderOption("Information")
		addHeaderOption("")
		INFO1_TEXT = addTextOption("Scanner","Info")
		INFO2_TEXT = addTextOption("Stacker(+/*)","Info")
		INFO3_TEXT = addTextOption("Spell Script","Info")
		INFO4_TEXT = addTextOption("Vanilla(#)","Info")
		INFO5_TEXT = addTextOption("Perk","Info")
		INFO6_TEXT = addTextOption("Persistent","Info")
		addHeaderOption("Save and Settings Options")
		addHeaderOption("")
		LOADFROMFISS_OID = addTextOption("Load Settings from FISS","GO!")
		SAVETOFISS_OID = addTextOption("Save Settings to FISS","GO!")
		FISSFILENAME_OID = AddInputOption("FISS Filename",FissFilename)
		SAVELOCAL_OID = AddInputOption("Create Save File","GO!")
		EXITGAME_OID = addTextOption("Exit Game","GO!")
		SLIDERMODE_OID = addToggleOption("Slider Mode",SliderModeVar)
		REIMPORT_OID = addTextOption("Full Reset","GO!")
		REGISTERSAVEKEY_OID = addToggleOption("Register Save Hotkey",isRegistered)
		SHOWMESSAGE_OID = addToggleOption("Show Save/Load Messages",ShowMessages)
		SAVEHOTKEY_OID = AddKeyMapOption("Save Hotkey",saveHotkey)
		QUICKSAVE_OID = AddMenuOption("Hotkey Settings",quickSaveOptions[isQuickSave])
		CREDITS_TEXT = addTextOption("Credits:","Grimy Bunyip")
	ENDIF
	ELSE
	IF ( page == "Tweaks")
		TEMPER_SCALE_TOGGLE = addToggleOption("Temper Scaling", PlayerRef.HasPerk(GBT_Temper_Scale))
		SHOUT_SCALE_SLIDER = AddInputOption("Shout Scaling", StringDecimals((GBT_shoutScale.GetNthEntryValue(0, 1) * 100) + 0,1) + "%")
		CRIT_SCALE_TOGGLE = addToggleOption("Critical Damage Scaling", PlayerRef.HasPerk(GBT_Critical_Damage_Scaling))
		BLEED_SCALE_TOGGLE = addToggleOption("Bleed Damage Scaling", PlayerRef.HasPerk(GBT_Bleed_Damage_Scaling))
		STAMINACOST_SCALE_TOGGLE = addToggleOption("Stamina Cost Scaling", PlayerRef.HasPerk(GBT_Stamina_Cost_Scaling))
		ILLTARGLVL_SCALE_TOGGLE = addToggleOption("Illusion Scale Target Level", PlayerRef.HasPerk(GBT_illScaleTargetLevel))
		FRIENDLY_DAMAGE_TOGGLE = addToggleOption("Disable Friendly Fire: Damage", PlayerRef.HasPerk(GBT_friendlyDamage))
		TRAP_MAGNITUDE_SLIDER = AddInputOption("Trap Magnitude", StringDecimals((GBT_trapMagnitude.GetNthEntryValue(0, 0) * 100) + 0,0) + "%")
		FRIENDLY_STAGGER_TOGGLE = addToggleOption("Disable Friendly Fire: Stagger", PlayerRef.HasPerk(GBT_friendlyStagger))
		WEREDMG_DEALT_SLIDER = AddInputOption("Werewolf Damage Dealt", StringDecimals((GBT_WerewolfDamageDealt.GetNthEntryValue(0, 0) * 100) + 0,0) + "%")
		WEREDMG_TAKEN_SLIDER = AddInputOption("Werewolf Damage Taken", StringDecimals((GBT_WerewolfDamageTaken.GetNthEntryValue(0, 0) * 100) + 0,0) + "%")
		POISON_DOSE_SLIDER = AddInputOption("Bonus Poison Doses", StringDecimals((GBT_poisonDose.GetNthEntryValue(0, 0) * 1) + 0,0) + "")
	ELSEIF ( page == "Magic")
		DUALCAST_POWER_SLIDER = AddInputOption("Dual Cast Power", StringDecimals(GetGameSettingFloat("fMagicDualCastingEffectivenessBase"),1) + "")
		DUALCAST_COST_SLIDER = AddInputOption("Dual Cast Cost", StringDecimals(GetGameSettingFloat("fMagicDualCastingCostMult"),1) + "")
		MAGICCOST_SCALE_SLIDER = AddInputOption("Player Magic Cost Scaling", StringDecimals(GetGameSettingFloat("fMagicCasterPCSkillCostBase"),4) + "")
		MAGIC_COST_SLIDER = AddInputOption("Player Magic Cost", StringDecimals(GetGameSettingFloat("fMagicCasterPCSkillCostMult"),1) + "")
		NPCMAGICCOST_SCALE_SLIDER = AddInputOption("NPC Magic Cost Scaling", StringDecimals(GetGameSettingFloat("fMagicCasterSkillCostBase"),4) + "")
		NPCMAGIC_COST_SLIDER = AddInputOption("NPC Magic Cost", StringDecimals(GetGameSettingFloat("fMagicCasterSkillCostMult"),1) + "")
		MAX_RUNES_SLIDER = AddInputOption("Base Rune Cap", GetGameSettingInt("iMaxPlayerRunes") + "" )
		MAX_SUMMONED_SLIDER = AddInputOption("Base Summon Creature Count", GetGameSettingInt("iMaxSummonedCreatures") + "" )
		TELEKIN_DAMAGE_SLIDER = AddInputOption("Telekinesis Damage", StringDecimals(GetGameSettingFloat("fMagicTelekinesisDamageBase"),0) + "")
		TELEKIN_DUALMULT_SLIDER = AddInputOption("Telekinesis Dual Mult", StringDecimals(GetGameSettingFloat("fMagicTelekinesisDualCastDamageMult"),2) + "")
		ALTMAG_SCALE_SLIDER = AddInputOption("Alteration Scale Magnitude", StringDecimals((GBT_altScaleMag.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		CONJMAG_SCALE_SLIDER = AddInputOption("Conjuration Scale Magnitude", StringDecimals((GBT_conjScaleMag.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		ALTDURNOTPARA_SCALE_SLIDER = AddInputOption("Alteration Scale Duration", StringDecimals((GBT_altScaleDurNotPara.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		CONJDUR_SCALE_SLIDER = AddInputOption("Conjuration Scale Duration", StringDecimals((GBT_conjScaleDur.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		ALTCOST_SCALE_SLIDER = AddInputOption("Alteration Scale Cost", StringDecimals((GBT_altScaleCost.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		CONJCOST_SCALE_SLIDER = AddInputOption("Conjuration Scale Cost", StringDecimals((GBT_conjScaleCost.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		ALTDURPARA_SCALE_SLIDER = AddInputOption("Paralysis Scale Duration", StringDecimals((GBT_altScaleDurPara.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		BOUNTMELEE_SCALE_SLIDER = AddInputOption("Bound Melee Scale Damage", StringDecimals((GBT_conjScaleBoundMelee.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		ALTCOSTDET_SCALE_SLIDER = AddInputOption("Detection Scale Cost", StringDecimals((GBT_altScaleCostDet.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		BOUNDBOW_SCALE_SLIDER = AddInputOption("Bound Bow Scale Damage", StringDecimals((GBT_conjScaleBoundBow.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		DESMAG_SCALE_SLIDER = AddInputOption("Destruction Scale Magnitude", StringDecimals((GBT_desScaleMag.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		HEALMAG_SCALE_SLIDER = AddInputOption("Healing Scale Magnitude", StringDecimals((GBT_restScaleMagHeal.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		DESDUR_SCALE_SLIDER = AddInputOption("Destruction Scale Duration", StringDecimals((GBT_desScaleDur.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		HEALDUR_SCALE_SLIDER = AddInputOption("Healing Scale Duration", StringDecimals((GBT_restScaleDurHeal.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		DESCOST_SCALE_SLIDER = AddInputOption("Destruction Scale Cost", StringDecimals((GBT_desScaleCost.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		HEALCOST_SCALE_SLIDER = AddInputOption("Healing Scale Cost", StringDecimals((GBT_restScaleCostHeal.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		ILLMAG_SCALE_SLIDER = AddInputOption("Illusion Scale Magnitude", StringDecimals((GBT_illScaleMag.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		NONHEALMAG_SCALE_SLIDER = AddInputOption("Non-Healing Scale Magnitude", StringDecimals((GBT_nonHealScaleMag.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		ILLDUR_SCALE_SLIDER = AddInputOption("Illusion Scale Duration", StringDecimals((GBT_illScaleDur.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		NONHEALDUR_SCALE_SLIDER = AddInputOption("Non-Healing Scale Duration", StringDecimals((GBT_nonHealScaleDur.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		ILLCOST_SCALE_SLIDER = AddInputOption("Illusion Scale Cost", StringDecimals((GBT_illScaleCost.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		NONHEALCOST_SCALE_SLIDER = AddInputOption("Non-Healing Scale Cost", StringDecimals((GBT_nonHealScaleCost.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		LESSERPOWER_COOLDOWN_SLIDER = AddInputOption("Lesser Power Cooldown Time", StringDecimals(GetGameSettingFloat("fMagicLesserPowerCooldownTimer"),1) + "")
	ELSEIF ( page == "Combat")
		DAMAGEDEALTSCALE_OID = AddInputOption("Damage Dealt Scaling",scaleDamageDealt_VAR + "x")
		DAMAGETAKENSCALE_OID = AddInputOption("Damage Taken Scaling",scaleDamageTaken_VAR + "x")
		DAMAGEDEALT_NOVICE_SLIDER = AddInputOption("Damage Dealt Novice", StringDecimals(GetGameSettingFloat("fDiffMultHPByPCVE") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()),2) + "")
		DAMAGETAKEN_NOVICE_SLIDER = AddInputOption("Damage Taken Novice", StringDecimals(GetGameSettingFloat("fDiffMultHPToPCVE") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()),2) + "")
		DAMAGEDEALT_APPRENTICE_SLIDER = AddInputOption("Damage Dealt Apprentice", StringDecimals(GetGameSettingFloat("fDiffMultHPByPCE") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()),2) + "")
		DAMAGETAKEN_APPRENTICE_SLIDER = AddInputOption("Damage Taken Apprentice", StringDecimals(GetGameSettingFloat("fDiffMultHPToPCE") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()),2) + "")
		DAMAGEDEALT_ADEPT_SLIDER = AddInputOption("Damage Dealt Adept", StringDecimals(GetGameSettingFloat("fDiffMultHPByPCN") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()),2) + "")
		DAMAGETAKEN_ADEPT_SLIDER = AddInputOption("Damage Taken Adept", StringDecimals(GetGameSettingFloat("fDiffMultHPToPCN") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()),2) + "")
		DAMAGEDEALT_EXPERT_SLIDER = AddInputOption("Damage Dealt Expert", StringDecimals(GetGameSettingFloat("fDiffMultHPByPCH") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()),2) + "")
		DAMAGETAKEN_EXPERT_SLIDER = AddInputOption("Damage Taken Expert", StringDecimals(GetGameSettingFloat("fDiffMultHPToPCH") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()),2) + "")
		DAMAGEDEALT_MASTER_SLIDER = AddInputOption("Damage Dealt Master", StringDecimals(GetGameSettingFloat("fDiffMultHPByPCVH") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()),2) + "")
		DAMAGETAKEN_MASTER_SLIDER = AddInputOption("Damage Taken Master", StringDecimals(GetGameSettingFloat("fDiffMultHPToPCVH") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()),2) + "")
		DAMAGEDEALT_LEGENDARY_SLIDER = AddInputOption("Damage Dealt Legendary", StringDecimals(GetGameSettingFloat("fDiffMultHPByPCL") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()),2) + "")
		DAMAGETAKEN_LEGENDARY_SLIDER = AddInputOption("Damage Taken Legendary", StringDecimals(GetGameSettingFloat("fDiffMultHPToPCL") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()),2) + "")
		WEAPONSCALE_PCMIN_SLIDER = AddInputOption("Player Weapon Damage Scaling Min", StringDecimals(GetGameSettingFloat("fDamagePCSkillMin"),1) + "")
		WEAPONSCALE_PCMAX_SLIDER = AddInputOption("Player Weapon Damage Scaling Max", StringDecimals(GetGameSettingFloat("fDamagePCSkillMax"),1) + "")
		WEAPONSCALE_NPCMIN_SLIDER = AddInputOption("NPC Weapon Damage Scaling Min", StringDecimals(GetGameSettingFloat("fDamageSkillMin"),1) + "")
		WEAPONSCALE_NPCMAX_SLIDER = AddInputOption("NPC Weapon Damage Scaling Max", StringDecimals(GetGameSettingFloat("fDamageSkillMax"),1) + "")
		ARMOR_SCALE_SLIDER = AddInputOption("Armor Rating Scaling", StringDecimals(GetGameSettingFloat("fArmorScalingFactor"),2) + "%")
		MAX_RESISTANCE_SLIDER = AddInputOption("Maximum Resistance", StringDecimals(GetGameSettingFloat("fPlayerMaxResistance"),0) + "%")
		ARMOR_BASERESIST_SLIDER = AddInputOption("Armor Base Resistance", StringDecimals(GetGameSettingFloat("fArmorBaseFactor"),2) + "")
		ARMOR_MAXRESIST_SLIDER = AddInputOption("Maximum Armor Resistance", StringDecimals(GetGameSettingFloat("fMaxArmorRating"),1) + "%")
		PC_ARMORRATING_SLIDER = AddInputOption("Player Armor Rating Mult", StringDecimals(GetGameSettingFloat("fArmorRatingPCMax"),3) + "")
		NPC_ARMORRATING_SLIDER = AddInputOption("NPC Armor Rating Mult", StringDecimals(GetGameSettingFloat("fArmorRatingMax"),3) + "")
		ENCUM_EFFECT_SLIDER = AddInputOption("Armor Speed Decrease (Weapon)", StringDecimals(GetGameSettingFloat("fMoveEncumEffect"),2) + "")
		ENCUMWEAP_EFFECT_SLIDER = AddInputOption("Armor Speed Decrease (No Weapon)", StringDecimals(GetGameSettingFloat("fMoveEncumEffectNoWeapon"),2) + "")
		WEAPONDAMAGE_MULT_SLIDER = AddInputOption("Weapon Damage", StringDecimals(GetGameSettingFloat("fDamageWeaponMult"),2) + "")
		TWOHAND_ATKSPD_SLIDER = AddInputOption("2H Attack Speed", StringDecimals(GetGameSettingFloat("fWeaponTwoHandedAnimationSpeedMult"),1) + "")
		AUTOAIM_AREA_SLIDER = AddInputOption("Auto Aim Area", StringDecimals(GetGameSettingFloat("fAutoAimScreenPercentage"),0) + "")
		AUTOAIM_RANGE_SLIDER = AddInputOption("Auto Aim Range", StringDecimals(GetGameSettingFloat("fAutoAimMaxDistance"),0) + "")
		AUTOAIM_DEGREES_SLIDER = AddInputOption("Auto Aim Angle", StringDecimals(GetGameSettingFloat("fAutoAimMaxDegrees"),1) + "")
		AUTOAIM_DEGREESTHIRD_SLIDER = AddInputOption("Auto Aim Angle 3rd Person", StringDecimals(GetGameSettingFloat("fAutoAimMaxDegrees3rdPerson"),1) + "")
		STAMINA_POWERCOST_SLIDER = AddInputOption("Power Cost Mult", StringDecimals(GetGameSettingFloat("fPowerAttackStaminaPenalty"),1) + "")
		STAMINA_BLOCKCOSTMULT_SLIDER = AddInputOption("Block Cost Mult", StringDecimals(GetGameSettingFloat("fStaminaBlockDmgMult"),2) + "")
		STAMINA_BASHCOST_SLIDER = AddInputOption("Bash Cost", StringDecimals(GetGameSettingFloat("fStaminaBashBase"),0) + "")
		STAMINA_POWERBASHCOST_SLIDER = AddInputOption("Power Bash Cost", StringDecimals(GetGameSettingFloat("fStaminaPowerBashBase"),0) + "")
		STAMINA_BLOCKCOSTBASE_SLIDER = AddInputOption("Block Cost Base", StringDecimals(GetGameSettingFloat("fStaminaBlockBase"),0) + "")
		BLOCK_SHIELD_SLIDER = AddInputOption("Shield Block Base", StringDecimals(GetGameSettingFloat("fShieldBaseFactor"),2) + "")
		BLOCK_WEAPON_SLIDER = AddInputOption("Weapon Block Base", StringDecimals(GetGameSettingFloat("fBlockWeaponBase"),2) + "")
		WEAPON_REACH_SLIDER = AddInputOption("Weapon Reach", StringDecimals(GetGameSettingFloat("fCombatDistance"),0) + "")
		BASH_REACH_SLIDER = AddInputOption("Bash Reach", StringDecimals(GetGameSettingFloat("fCombatBashReach"),0) + "")
	ELSEIF ( page == "Stealth")
		AISEARCH_TIME_SLIDER = AddInputOption("AI Search Time Attacked", StringDecimals(GetGameSettingFloat("fCombatStealthPointRegenAttackedWaitTime"),0) + " Sec")
		AISEARCH_TIMEATTACKED_SLIDER = AddInputOption("AI Search Time", StringDecimals(GetGameSettingFloat("fCombatStealthPointRegenDetectedEventWaitTime"),0) + " Sec")
		SNEAKLEVEL_BASE_SLIDER = AddInputOption("Sneak Level Base", StringDecimals(GetGameSettingFloat("fPlayerDetectionSneakBase"),0) + "")
		SNEAKDETECTION_SCALE_SLIDER = AddInputOption("Sneak Scale Detection", StringDecimals(GetGameSettingFloat("fPlayerDetectionSneakMult"),2) + "")
		DETECTION_FOV_SLIDER = AddInputOption("Detection FOV", StringDecimals(GetGameSettingFloat("fDetectionViewCone"),0) + " Deg")
		SNEAK_BASE_SLIDER = AddInputOption("Sneak Base Value", StringDecimals(GetGameSettingFloat("fSneakBaseValue"),0) + "")
		DETECTION_LIGHT_SLIDER = AddInputOption("Detection Light", StringDecimals(GetGameSettingFloat("fDetectionSneakLightMod"),0) + "")
		DETECTION_LIGHTEXT_SLIDER = AddInputOption("Detection Light Exterior", StringDecimals(GetGameSettingFloat("fSneakLightExteriorMult"),2) + "")
		DETECTION_SOUND_SLIDER = AddInputOption("Detection Sound", StringDecimals(GetGameSettingFloat("fSneakSoundsMult"),2) + "")
		DETECTION_SOUNDLOS_SLIDER = AddInputOption("Detection Sound LOS", StringDecimals(GetGameSettingFloat("fSneakSoundLosMult"),2) + "")
		PICKPOCKET_MAXCHANCE_SLIDER = AddInputOption("Max Pickpocket Chance", StringDecimals(GetGameSettingFloat("fPickPocketMaxChance"),0) + "%")
		PICKPOCKET_MINCHANCE_SLIDER = AddInputOption("Min Pickpocket Chance", StringDecimals(GetGameSettingFloat("fPickPocketMinChance"),0) + "%")
		SNEAKMULT_MARKSMAN_SLIDER = AddInputOption("Sneak Mult: Marksman", StringDecimals((GBT_SneakMarks.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		SNEAKMULT_DAGGER_SLIDER = AddInputOption("Sneak Mult: Dagger", StringDecimals((GBT_SneakDagger.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		SNEAKMULT_TWOHAND_SLIDER = AddInputOption("Sneak Mult: One Hand", StringDecimals((GBT_SneakOne.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		SNEAKMULT_ONEHAND_SLIDER = AddInputOption("Sneak Mult: Two Hand", StringDecimals((GBT_SneakTwo.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		SNEAKMULT_UNARMED_SLIDER = AddInputOption("Sneak Mult: Unarmed", StringDecimals((GBT_SneakH2H.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		SNEAKMULT_RUNE_SLIDER = AddInputOption("Sneak Mult: Rune Magnitude", StringDecimals((GBT_SneakRuneMag.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		SNEAKMULT_SEARCH_SLIDER = AddInputOption("Sneak Mult: Search", StringDecimals((GBT_SneakSearch.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		SNEAKMULT_SPELLMAG_SLIDER = AddInputOption("Sneak Mult: Spell Magnitude", StringDecimals((GBT_SneakSpellMag.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		SNEAKMULT_SPELLSEARCH_SLIDER = AddInputOption("Sneak Mult: Spell Search", StringDecimals((GBT_SneakSpellSearch.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		SNEAKMULT_SPELLDUR_SLIDER = AddInputOption("Sneak Mult: Spell Duration", StringDecimals((GBT_SneakSpellDur.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		SNEAKSCALE_PHYSICAL_SLIDER = AddInputOption("Sneak Scale: Physical", StringDecimals((GBT_SneakScalePhys.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		SNEAKSCALE_SPELLMAG_SLIDER = AddInputOption("Sneak Scale: Spell Magnitude", StringDecimals((GBT_SneakScaleSpell.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		SNEAKMULT_POISONMAG_SLIDER = AddInputOption("Sneak Mult: Poison Magnitude", StringDecimals((GBT_SneakPoisonMag.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		SNEAKMULT_POISONDUR_SLIDER = AddInputOption("Sneak Mult: Poison Duration", StringDecimals((GBT_SneakPoisonDur.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		SNEAKSCALE_POISONMAG_SLIDER = AddInputOption("Sneak Scale: Poison Magnitude", StringDecimals((GBT_SneakScalePoisonMag.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		SNEAKSCALE_POISONDUR_SLIDER = AddInputOption("Sneak Scale: Poison Duration", StringDecimals((GBT_SneakScalePoisonDur.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		LOCKPICK_VEASY_SLIDER = AddInputOption("Novice Lockpick Sweetspot", StringDecimals(GetGameSettingFloat("fSweetSpotVeryEasy"),4) + "")
		LOCKPICKDUR_VEASY_SLIDER = AddInputOption("Novice Lockpick Durability", StringDecimals(GetGameSettingFloat("fLockpickBreakNovice"),4) + "")
		LOCKPICK_EASY_SLIDER = AddInputOption("Apprentice Lockpick Sweetspot", StringDecimals(GetGameSettingFloat("fSweetSpotEasy"),4) + "")
		LOCKPICKDUR_EASY_SLIDER = AddInputOption("Apprentice Lockpick Durability", StringDecimals(GetGameSettingFloat("fLockpickBreakApprentice"),4) + "")
		LOCKPICK_AVERAGE_SLIDER = AddInputOption("Adept Lockpick Sweetspot", StringDecimals(GetGameSettingFloat("fSweetSpotAverage"),4) + "")
		LOCKPICKDUR_AVERAGE_SLIDER = AddInputOption("Adept Lockpick Durability", StringDecimals(GetGameSettingFloat("fLockpickBreakAdept"),4) + "")
		LOCKPICK_HARD_SLIDER = AddInputOption("Expert Lockpick Sweetspot", StringDecimals(GetGameSettingFloat("fSweetSpotHard"),4) + "")
		LOCKPICKDUR_HARD_SLIDER = AddInputOption("Expert Lockpick Durability", StringDecimals(GetGameSettingFloat("fLockpickBreakExpert"),4) + "")
		LOCKPICK_VHARD_SLIDER = AddInputOption("Master Lockpick Sweetspot", StringDecimals(GetGameSettingFloat("fSweetSpotVeryHard"),4) + "")
		LOCKPICKDUR_VHARD_SLIDER = AddInputOption("Master Lockpick Durability", StringDecimals(GetGameSettingFloat("fLockpickBreakMaster"),4) + "")
	ELSEIF ( page == "Crafting")
		ALCHEMYMAG_MULT_SLIDER = AddInputOption("Alchemy Magnitude Mult", StringDecimals(GetGameSettingFloat("fAlchemyIngredientInitMult"),1) + "")
		ALCHEMYMAG_SCALE_SLIDER = AddInputOption("Alchemy Magnitude Scaling", StringDecimals(GetGameSettingFloat("fAlchemySkillFactor"),2) + "")
		BONUS_INGR_SLIDER = AddInputOption("Bonus Ingredients Harvested", StringDecimals((GBT_bonusIngredients.GetNthEntryValue(0, 0) * 1) + 0,0) + "")
		BONUS_POTION_SLIDER = AddInputOption("Bonus Potions Crafted", StringDecimals((GBT_bonusPotions.GetNthEntryValue(0, 0) * 1) + 0,0) + "")
		CHARGECOST_POWER_SLIDER = AddInputOption("Charge Cost: Power", StringDecimals(GetGameSettingFloat("fEnchantingCostExponent"),2) + "")
		ENCHANT_SCALING_SLIDER = AddInputOption("Enchant Skill Scaling", StringDecimals(GetGameSettingFloat("fEnchantingSkillFactor"),2) + "")
		CHARGECOST_MULT_SLIDER = AddInputOption("Charge Cost: Mult", StringDecimals(GetGameSettingFloat("fEnchantingSkillCostMult"),1) + "")
		ENCHANTPRICE_EFFECT_SLIDER = AddInputOption("Enchant Price: Effect Mult", StringDecimals(GetGameSettingFloat("fEnchantmentEffectPointsMult"),1) + "")
		CHARGECOST_BASE_SLIDER = AddInputOption("Charge Cost: Base", StringDecimals(GetGameSettingFloat("fEnchantingSkillCostBase"),3) + "")
		ENCHANTPRICE_SOUL_SLIDER = AddInputOption("Enchant Price: Soul Mult", StringDecimals(GetGameSettingFloat("fEnchantmentPointsMult"),2) + "")
		ENCHANT_CHARGE_SLIDER = AddInputOption("Enchantment Charges Mult", StringDecimals((GBT_enchantCharge.GetNthEntryValue(0, 0) * 100) + 0,0) + "%")
		ENCHANT_MAG_SLIDER = AddInputOption("Enchantment Magnitude Mult", StringDecimals((GBT_enchantMag.GetNthEntryValue(0, 0) * 100) + 0,0) + "%")
		BONUS_ENCHANT_SLIDER = AddInputOption("Bonus Enchantment Effects", StringDecimals((GBT_bonusEnchants.GetNthEntryValue(0, 0) * 1) + 0,0) + "")
		TEMPER_SUFFIX_SLIDER = AddInputOption("Tempering Suffix Distribution", StringDecimals(GetGameSettingFloat("fSmithingConditionFactor"),2) + "")
		TEMPER_ARMOR_SLIDER = AddInputOption("Armor Tempering", StringDecimals(GetGameSettingFloat("fSmithingArmorMax"),1) + "")
		TEMPER_WEAPON_SLIDER = AddInputOption("Weapon Tempering", StringDecimals(GetGameSettingFloat("fSmithingWeaponMax"),1) + "")
		POTION_MAG_SLIDER = AddInputOption("Potion Magnitude", StringDecimals((GBT_PotionMag.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		POTION_DUR_SLIDER = AddInputOption("Potion Duration", StringDecimals((GBT_PotionDur.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		POTION_SCALEMAG_SLIDER = AddInputOption("Potion Scale Magnitude", StringDecimals((GBT_PotionScaleMag.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		POTION_SCALEDUR_SLIDER = AddInputOption("Potion Scale Duration", StringDecimals((GBT_PotionScaleDur.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		POISON_MAG_SLIDER = AddInputOption("Poison Magnitude", StringDecimals((GBT_PoisonMag.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		POISON_DUR_SLIDER = AddInputOption("Poison Duration", StringDecimals((GBT_PoisonDur.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		POISON_SCALEMAG_SLIDER = AddInputOption("Poison Scale Magnitude", StringDecimals((GBT_PoisonScaleMag.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		POISON_SCALEDUR_SLIDER = AddInputOption("Poison Scale Duration", StringDecimals((GBT_PoisonScaleDur.GetNthEntryValue(0, 1) * 10000) + 100,0) + "%")
		SCROLL_MAG_SLIDER = AddInputOption("Scroll Magnitude", StringDecimals((GBT_ScrollMag.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
		SCROLL_DUR_SLIDER = AddInputOption("Scroll Duration", StringDecimals((GBT_ScrollDur.GetNthEntryValue(0, 0) * 1) + 0,2) + "")
	ELSEIF ( page == "Vendors")
		BARTER_BUYMIN_SLIDER = AddInputOption("Min Buy Price Factor", StringDecimals(GetGameSettingFloat("fBarterBuyMin"),2) + "")
		BARTER_SELLMAX_SLIDER = AddInputOption("Max Sell Price Factor", StringDecimals(GetGameSettingFloat("fBarterSellMax"),2) + "")
		BARTER_MIN_SLIDER = AddInputOption("fBarterMin", StringDecimals(GetGameSettingFloat("fBarterMin"),2) + "")
		BARTER_MAX_SLIDER = AddInputOption("fBarterMax", StringDecimals(GetGameSettingFloat("fBarterMax"),2) + "")
		BUY_PRICE_SLIDER = AddInputOption("Buy Price Mult", StringDecimals((GBT_buyPrice.GetNthEntryValue(0, 0) * 100) + 0,0) + "%")
		SELL_PRICE_SLIDER = AddInputOption("Sell Price Mult", StringDecimals((GBT_sellPrice.GetNthEntryValue(0, 0) * 100) + 0,0) + "%")
		VENDOR_RESPAWN_SLIDER = AddInputOption("Vendor Respawn Times", GetGameSettingInt("iDaysToRespawnVendor") + "" )
		TRAINING_NUMALLOWED_SLIDER = AddInputOption("Training Per Level", GetGameSettingInt("iTrainingNumAllowedPerLevel") + "" )
		TRAINING_JOURNEYMANCOST_SLIDER = AddInputOption("Journeyman Training Cost", GetGameSettingInt("iTrainingJourneymanCost") + "" )
		TRAINING_JOURNEYMANSKILL_SLIDER = AddInputOption("Journeyman Training Skill", GetGameSettingInt("iTrainingJourneymanSkill") + "" )
		TRAINING_EXPERTCOST_SLIDER = AddInputOption("Expert Training Cost", GetGameSettingInt("iTrainingExpertCost") + "" )
		TRAINING_EXPERTSKILL_SLIDER = AddInputOption("Expert Training Skill", GetGameSettingInt("iTrainingExpertSkill") + "" )
		TRAINING_MASTERCOST_SLIDER = AddInputOption("Master Training Cost", GetGameSettingInt("iTrainingMasterCost") + "" )
		TRAINING_MASTERSKILL_SLIDER = AddInputOption("Master Training Skill", GetGameSettingInt("iTrainingMasterSkill") + "" )
		APOTHECARY_GOLD_SLIDER = AddInputOption("Apothecary Base Gold", VendorGoldApothecary.GetNthCount(0) + "" )
		BLACKSMITH_GOLD_SLIDER = AddInputOption("City Blacksmith Base Gold", VendorGoldBlacksmith.GetNthCount(0) + "" )
		ORCBLACKSMITH_GOLD_SLIDER = AddInputOption("Orc Blacksmith Base Gold", VendorGoldBlacksmithOrc.GetNthCount(0) + "" )
		TOWNBLACKSMITH_GOLD_SLIDER = AddInputOption("Town Blacksmith Base Gold", VendorGoldBlacksmithTown.GetNthCount(0) + "" )
		INNKEERPER_GOLD_SLIDER = AddInputOption("Innkeeper Base Gold", VendorGoldInn.GetNthCount(0) + "" )
		MISCMERCHANT_GOLD_SLIDER = AddInputOption("Misc Merchant Base Gold", VendorGoldMisc.GetNthCount(0) + "" )
		SPELLMERCHANT_GOLD_SLIDER = AddInputOption("Spell Merchant Base Gold", VendorGoldSpells.GetNthCount(0) + "" )
		STREETVENDOR_GOLD_SLIDER = AddInputOption("Street Vendor Base Gold", VendorGoldStreetVendor.GetNthCount(0) + "" )
	ELSEIF ( page == "Attributes")
		COMBAT_STAMINAREGEN_SLIDER = AddInputOption("Combat Stamina Regen", StringDecimals(GetGameSettingFloat("fCombatStaminaRegenRateMult"),2) + "")
		AV_COMBATHEALTHREGENMULT_SLIDER = AddInputOption("CombatHealthRegenMult", StringDecimals(PlayerRef.GetAV("CombatHealthRegenMult"),2) + "")
		DAMAGESTAMINA_DELAY_SLIDER = AddInputOption("Damage Stamina Delay", StringDecimals(GetGameSettingFloat("fDamagedStaminaRegenDelay"),1) + " sec")
		BOWZOOM_REGENDELAY_SLIDER = AddInputOption("Bow Zoom Regen Delay", StringDecimals(GetGameSettingFloat("fBowZoomStaminaRegenDelay"),1) + " sec")
		COMBAT_MAGICKAREGEN_SLIDER = AddInputOption("Combat Magicka Regen", StringDecimals(GetGameSettingFloat("fCombatMagickaRegenRateMult"),2) + "")
		STAMINA_REGENDELAY_SLIDER = AddInputOption("Stamina Regen Delay", StringDecimals(GetGameSettingFloat("fStaminaRegenDelayMax"),1) + " sec")
		DAMAGEMAGICKA_DELAY_SLIDER = AddInputOption("Damage Magicka Delay", StringDecimals(GetGameSettingFloat("fDamagedMagickaRegenDelay"),1) + " sec")
		MAGICKA_REGENDELAY_SLIDER = AddInputOption("Magicka Regen Delay", StringDecimals(GetGameSettingFloat("fMagickaRegenDelayMax"),1) + " sec")
		AV_HEALRATEMULT_SLIDER = AddInputOption("HealRateMult", StringDecimals(PlayerRef.GetAV("HealRateMult"),0) + "")
		AV_HEALRATE_SLIDER = AddInputOption("Base Healrate", StringDecimals(PlayerRef.GetBaseAV("HealRate"),2) + "")
		AV_MAGICKARATEMULT_SLIDER = AddInputOption("MagickaRateMult", StringDecimals(PlayerRef.GetAV("MagickaRateMult"),0) + "")
		AV_MAGICKARATE_SLIDER = AddInputOption("Base MagickaRate", StringDecimals(PlayerRef.GetBaseAV("MagickaRate"),2) + "")
		AV_STAMINARATEMULT_SLIDER = AddInputOption("StaminaRateMult", StringDecimals(PlayerRef.GetAV("StaminaRateMult"),0) + "")
		AV_STAMINARATE_SLIDER = AddInputOption("Base Stamina Rate", StringDecimals(PlayerRef.GetBaseAV("StaminaRate"),2) + "")
		AV_HEALTH_SLIDER = AddInputOption("Health", StringDecimals(PlayerRef.GetAV("Health"),0) + "")
		AV_MAGICKA_SLIDER = AddInputOption("Magicka ", StringDecimals(PlayerRef.GetAV("Magicka"),0) + "")
		AV_STAMINA_SLIDER = AddInputOption("Stamina ", StringDecimals(PlayerRef.GetAV("Stamina"),0) + "")
	ELSEIF ( page == "Actor Values")
		AV_DRAGONSOULS_SLIDER = AddInputOption("DragonSouls", StringDecimals(PlayerRef.GetAV("DragonSouls"),0) + "")
		AV_SHOUTRECOVERYMULT_SLIDER = AddInputOption("ShoutRecoveryMult", StringDecimals(PlayerRef.GetAV("ShoutRecoveryMult"),2) + "")
		AV_CARRYWEIGHT_SLIDER = AddInputOption("Base CarryWeight", StringDecimals(PlayerRef.GetBaseAV("CarryWeight"),0) + "")
		AV_SPEEDMULT_SLIDER = AddInputOption("Base SpeedMult", StringDecimals(PlayerRef.GetBaseAV("SpeedMult"),0) + "")
		AV_UNARMEDDAMAGE_SLIDER = AddInputOption("Base Unarmed Damage", StringDecimals(PlayerRef.GetBaseAV("UnarmedDamage"),0) + "")
		AV_MASS_SLIDER = AddInputOption("Base Mass", StringDecimals(PlayerRef.GetBaseAV("Mass"),2) + "")
		AV_CRITCHANCE_SLIDER = AddInputOption("Base Crit Chance", StringDecimals(PlayerRef.GetBaseAV("CritChance"),0) + "")
		AV_ALTERATIONPOWERMOD_SLIDER = AddInputOption("AlterationPowerMod", StringDecimals(PlayerRef.GetAV("AlterationPowerMod"),0) + "")
		AV_CONJURATIONPOWERMOD_SLIDER = AddInputOption("ConjurationPowerMod", StringDecimals(PlayerRef.GetAV("ConjurationPowerMod"),0) + "")
		AV_DESTRUCTIONPOWERMOD_SLIDER = AddInputOption("DestructionPowerMod", StringDecimals(PlayerRef.GetAV("DestructionPowerMod"),0) + "")
		AV_ILLUSIONPOWERMOD_SLIDER = AddInputOption("IllusionPowerMod", StringDecimals(PlayerRef.GetAV("IllusionPowerMod"),0) + "")
		AV_RESTORATIONPOWERMOD_SLIDER = AddInputOption("RestorationPowerMod", StringDecimals(PlayerRef.GetAV("RestorationPowerMod"),0) + "")
		AV_BOWSTAGGERBONUS_SLIDER = AddInputOption("BowStaggerBonus", StringDecimals(PlayerRef.GetAV("BowStaggerBonus"),2) + "")
		AV_BOWSPEEDBONUSVAR_SLIDER = AddInputOption("Base BowSpeedBonusVar", StringDecimals(PlayerRef.GetBaseAV("BowSpeedBonus"),2) + "")
		AV_LEFTWEAPONSPEEDMULT_SLIDER = AddInputOption("LeftWeaponSpeedMult", StringDecimals(PlayerRef.GetAV("LeftWeaponSpeedMult"),2) + "")
		AV_WEAPONSPEEDMULT_SLIDER = AddInputOption("WeaponSpeedMult", StringDecimals(PlayerRef.GetAV("WeaponSpeedMult"),2) + "")
		AV_MAGICRESIST_SLIDER = AddInputOption("MagicResist", StringDecimals(PlayerRef.GetAV("MagicResist"),0) + "")
		AV_FIRERESIST_SLIDER = AddInputOption("FireResist", StringDecimals(PlayerRef.GetAV("FireResist"),0) + "")
		AV_POISONRESIST_SLIDER = AddInputOption("PoisonResist", StringDecimals(PlayerRef.GetAV("PoisonResist"),0) + "")
		AV_ELECTRICRESIST_SLIDER = AddInputOption("ElectricResist", StringDecimals(PlayerRef.GetAV("ElectricResist"),0) + "")
		AV_DISEASERESIST_SLIDER = AddInputOption("DiseaseResist", StringDecimals(PlayerRef.GetAV("DiseaseResist"),0) + "")
		AV_FROSTRESIST_SLIDER = AddInputOption("FrostResist", StringDecimals(PlayerRef.GetAV("FrostResist"),0) + "")
	ELSEIF ( page == "MISC")
		PERK_POINTS_SLIDER = AddInputOption("Perk Points", GetPerkPoints())
		TIME_SCALE_SLIDER = AddInputOption("Time Scale", TimeScale.GetValueInt() + "")
		FALLHEIGHT_MINNPC_SLIDER = AddInputOption("NPC Fall Damage Height", StringDecimals(GetGameSettingFloat("fJumpFallHeightMinNPC"),0) + "")
		FALLHEIGHT_MIN_SLIDER = AddInputOption("Fall Damage Height", StringDecimals(GetGameSettingFloat("fJumpFallHeightMin"),0) + "")
		FALLHEIGHT_MULTNPC_SLIDER = AddInputOption("NPC Fall Damage Mult", StringDecimals(GetGameSettingFloat("fJumpFallHeightMultNPC"),1) + "")
		FALLHEIGHT_MULT_SLIDER = AddInputOption("Fall Damage Mult", StringDecimals(GetGameSettingFloat("fJumpFallHeightMult"),1) + "")
		FALLHEIGHT_EXPNPC_SLIDER = AddInputOption("NPC Fall Damage Exponent", StringDecimals(GetGameSettingFloat("fJumpFallHeightExponentNPC"),2) + "")
		FALLHEIGHT_EXP_SLIDER = AddInputOption("Fall Damage Exponent", StringDecimals(GetGameSettingFloat("fJumpFallHeightExponent"),2) + "")
		JUMP_HEIGHT_SLIDER = AddInputOption("Jump Height", StringDecimals(GetGameSettingFloat("fJumpHeightMin"),0) + "")
		SWIM_BREATHBASE_SLIDER = AddInputOption("Breath Timer (Seconds)", StringDecimals(GetGameSettingFloat("fActorSwimBreathBase"),1) + " sec")
		SWIM_BREATHDAMAGE_SLIDER = AddInputOption("Drowning Damage", StringDecimals(GetGameSettingFloat("fActorSwimBreathDamage"),2) + "")
		SWIM_BREATHMULT_SLIDER = AddInputOption("Breath Timer (Minutes)", StringDecimals(GetGameSettingFloat("fActorSwimBreathMult"),1) + " min")
		KILLCAM_CHANCE_SLIDER = AddInputOption("Kill Cam Chance", StringDecimals(GetGameSettingFloat("fKillCamBaseOdds"),2) + "")
		DEATHCAMERA_TIME_SLIDER = AddInputOption("Player Death Camera Time", StringDecimals(GetGameSettingFloat("fPlayerDeathReloadTime"),0) + " sec")
		KILLMOVE_CHANCE_SLIDER = AddInputOption("Kill Move Chance", StringDecimals(KillMoveRandom.GetValue(),0) + "%")
		DECAPITATION_CHANCE_SLIDER = AddInputOption("Decapitation Chance", StringDecimals(DecapitationChance.GetValue(),0) + "%")
		SPRINT_DRAINBASE_SLIDER = AddInputOption("Sprint Stamina Drain Base", StringDecimals(GetGameSettingFloat("fSprintStaminaDrainMult"),2) + "")
		SPRINT_DRAINMULT_SLIDER = AddInputOption("Sprint Stamina Drain Mult", StringDecimals(GetGameSettingFloat("fSprintStaminaWeightMult"),2) + "")
		ARROW_RECOVERY_SLIDER = AddInputOption("Arrow Recovery Chance", GetGameSettingInt("iArrowInventoryChance") + "%" )
		DEATH_DROPCHANCE_SLIDER = AddInputOption("Death Weapon Drop Chance", GetGameSettingInt("iDeathDropWeaponChance") + "%" )
		CAMERA_SHAKETIME_SLIDER = AddInputOption("Camera Shake Time", StringDecimals(GetGameSettingFloat("fCameraShakeTime"),2) + "")
		FASTRAVEL_SPEED_SLIDER = AddInputOption("Fast Travel Speed Mult", StringDecimals(GetGameSettingFloat("fFastTravelSpeedMult"),2) + "")
		HUDCOMPASS_DISTANEC_SLIDER = AddInputOption("HUD Compass Distance", StringDecimals(GetGameSettingFloat("fHUDCompassLocationMaxDist"),0) + "")
		ATTACHED_ARROWS_SLIDER = AddInputOption("Max Attached Arrows", GetGameSettingInt("iMaxAttachedArrows") + "" )
		LightRadius_OID = AddInputOption("Light Radius", GetLightRadius(Torch01))
		LightDuration_OID = AddInputOption("Light Duration", GetLightDuration(Torch01) + "s")
		SPECIAL_LOOT_SLIDER = AddInputOption("No Special Loot Chance", SpecialLootChance.GetValueInt() + "%")
	ELSEIF ( page == "NPC")
		FRIENDHIT_TIMER_SLIDER = AddInputOption("Friend Hit Timer", StringDecimals(GetGameSettingFloat("fFriendHitTimer"),1) + " sec")
		FRIENDHIT_INTERVAL_SLIDER = AddInputOption("Friend Hit Interval", StringDecimals(GetGameSettingFloat("fFriendMinimumLastHitTime"),1) + " sec")
		FRIENDHIT_COMBAT_SLIDER = AddInputOption("Friend Hits Allowed (Combat)", GetGameSettingInt("iFriendHitCombatAllowed") + "" )
		FRIENDHIT_NONCOMBAT_SLIDER = AddInputOption("Friend Hits Allowed (NonCombat)", GetGameSettingInt("iFriendHitNonCombatAllowed") + "" )
		ALLYHIT_COMBAT_SLIDER = AddInputOption("Ally Hits Allowed (Combat)", GetGameSettingInt("iAllyHitCombatAllowed") + "" )
		ALLYHIT_NONCOMBAT_SLIDER = AddInputOption("Ally Hits Allowed (NonCombat)", GetGameSettingInt("iAllyHitNonCombatAllowed") + "" )
		COMBAT_DODGECHANCE_SLIDER = AddInputOption("AI Dodge Chance", StringDecimals(GetGameSettingFloat("fCombatDodgeChanceMax"),1) + "")
		COMBAT_AIMOFFSET_SLIDER = AddInputOption("AI Aim Offset", StringDecimals(GetGameSettingFloat("fCombatAimProjectileRandomOffset"),0) + "")
		COMBAT_FLEEHEALTH_SLIDER = AddInputOption("AI Flee Health Mult", StringDecimals(GetGameSettingFloat("fAIFleeHealthMult"),0) + "%")
		DIALOGUE_PADDING_SLIDER = AddInputOption("Dialogue Padding", StringDecimals(GetGameSettingFloat("fGameplayVoiceFilePadding"),2) + " sec")
		DIALOGUE_DISTANCE_SLIDER = AddInputOption("Dialogue Distance", StringDecimals(GetGameSettingFloat("fAIMinGreetingDistance"),0) + "")
		FOLLOWER_SPACING_SLIDER = AddInputOption("Follower Spacing", StringDecimals(GetGameSettingFloat("fFollowSpaceBetweenFollowers"),0) + "")
		FOLLOWER_CATCHUP_SLIDER = AddInputOption("Follower Catch Up", StringDecimals(GetGameSettingFloat("fFollowExtraCatchUpSpeedMult"),2) + "")
		LEVELSCALING_MULT_SLIDER = AddInputOption("Level Scaling Mult", StringDecimals(GetGameSettingFloat("fLevelScalingMult"),2) + "")
		LEVELEDACTOR_EASY_SLIDER = AddInputOption("Level Scaling (Easy Zones)", StringDecimals(GetGameSettingFloat("fLeveledActorMultEasy"),2) + "")
		LEVELEDACTOR_HARD_SLIDER = AddInputOption("Level Scaling (Hard Zones)", StringDecimals(GetGameSettingFloat("fLeveledActorMultHard"),2) + "")
		LEVELEDACTOR_MEDIUM_SLIDER = AddInputOption("Level Scaling (Medium Zones)", StringDecimals(GetGameSettingFloat("fLeveledActorMultMedium"),2) + "")
		LEVELEDACTOR_VHARD_SLIDER = AddInputOption("Level Scaling (Very Hard Zones)", StringDecimals(GetGameSettingFloat("fLeveledActorMultVeryHard"),2) + "")
		RESPAWN_TIME_SLIDER = AddInputOption("Respawn Time", GetGameSettingInt("iHoursToRespawnCell") + "" )
		NPC_HEALTHBONUS_SLIDER = AddInputOption("NPC Health Bonus", StringDecimals(GetGameSettingFloat("fNPCHealthLevelBonus"),0) + "")
	ELSEIF ( page == "Experience")
		LEVELUP_ATTRIBUTE_SLIDER = AddInputOption("Attribute per Level", GetGameSettingInt("iAVDhmsLevelup") + "" )
		LEVELUP_CARRYWEIGHT_SLIDER = AddInputOption("Carry Weight per Level", StringDecimals(GetGameSettingFloat("fLevelUpCarryWeightMod"),0) + "")
		LEGENDARYRESET_LEVEL_SLIDER = AddInputOption("Legendary Reset Level", StringDecimals(GetGameSettingFloat("fLegendarySkillResetValue"),0) + "")
		LEVELUP_POWER_SLIDER = AddInputOption("Skill Level Cost Power", StringDecimals(GetGameSettingFloat("fSkillUseCurve"),2) + "")
		LEVELUP_BASE_SLIDER = AddInputOption("Overall Level Cost Base", StringDecimals(GetGameSettingFloat("fXPLevelUpBase"),0) + "")
		LEVELUP_MULT_SLIDER = AddInputOption("Overall Level Cost Mult", StringDecimals(GetGameSettingFloat("fXPLevelUpMult"),0) + "")
		SKILLUSE_ALCHEMY_SLIDER = AddInputOption("Alchemy Experience Rate", StringDecimals(GetAVIByID(16).GetSkillUseMult(),2) + "")
		SKILLUSE_ALTERATION_SLIDER = AddInputOption("Alteration Experience Rate", StringDecimals(GetAVIByID(18).GetSkillUseMult(),2) + "")
		SKILLUSE_BLOCK_SLIDER = AddInputOption("Block Experience Rate", StringDecimals(GetAVIByID(9).GetSkillUseMult(),2) + "")
		SKILLUSE_CONJURATION_SLIDER = AddInputOption("Conjuration Experience Rate", StringDecimals(GetAVIByID(19).GetSkillUseMult(),2) + "")
		SKILLUSE_DESTRUCTION_SLIDER = AddInputOption("Destruction Experience Rate", StringDecimals(GetAVIByID(20).GetSkillUseMult(),2) + "")
		SKILLUSE_ENCHANTING_SLIDER = AddInputOption("Enchanting Experience Rate", StringDecimals(GetAVIByID(23).GetSkillUseMult(),2) + "")
		SKILLUSE_HEAVYARMOR_SLIDER = AddInputOption("HeavyArmor Experience Rate", StringDecimals(GetAVIByID(11).GetSkillUseMult(),2) + "")
		SKILLUSE_ILLUSION_SLIDER = AddInputOption("Illusion Experience Rate", StringDecimals(GetAVIByID(21).GetSkillUseMult(),2) + "")
		SKILLUSE_LIGHTARMOR_SLIDER = AddInputOption("LightArmor Experience Rate", StringDecimals(GetAVIByID(12).GetSkillUseMult(),2) + "")
		SKILLUSE_LOCKPICKING_SLIDER = AddInputOption("Lockpicking Experience Rate", StringDecimals(GetAVIByID(14).GetSkillUseMult(),2) + "")
		SKILLUSE_MARKSMAN_SLIDER = AddInputOption("Marksman Experience Rate", StringDecimals(GetAVIByID(8).GetSkillUseMult(),2) + "")
		SKILLUSE_ONEHANDED_SLIDER = AddInputOption("OneHanded Experience Rate", StringDecimals(GetAVIByID(6).GetSkillUseMult(),2) + "")
		SKILLUSE_PICKPOCKET_SLIDER = AddInputOption("Pickpocketing Experience Rate", StringDecimals(GetAVIByID(13).GetSkillUseMult(),2) + "")
		SKILLUSE_RESTORATION_SLIDER = AddInputOption("Restoration Experience Rate", StringDecimals(GetAVIByID(22).GetSkillUseMult(),2) + "")
		SKILLUSE_SMITHING_SLIDER = AddInputOption("Smithing Experience Rate", StringDecimals(GetAVIByID(10).GetSkillUseMult(),2) + "")
		SKILLUSE_SNEAK_SLIDER = AddInputOption("Sneak Experience Rate", StringDecimals(GetAVIByID(15).GetSkillUseMult(),2) + "")
		SKILLUSE_SPEECHCRAFT_SLIDER = AddInputOption("Speechcraft Experience Rate", StringDecimals(GetAVIByID(17).GetSkillUseMult(),2) + "")
		SKILLUSE_TWOHAND_SLIDER = AddInputOption("TwoHanded Experience Rate", StringDecimals(GetAVIByID(7).GetSkillUseMult(),2) + "")
	ELSEIF ( page == "Physics")
		RFORCE_MIN_SLIDER = AddInputOption("Min Ranged Ragdoll Force", StringDecimals(GetGameSettingFloat("fDeathForceRangedForceMin"),0) + "")
		RFORCE_MAX_SLIDER = AddInputOption("Max Ranged Ragdoll Force", StringDecimals(GetGameSettingFloat("fDeathForceRangedForceMax"),0) + "")
		MFORCE_MIN_SLIDER = AddInputOption("Min Melee Ragdoll Force", StringDecimals(GetGameSettingFloat("fDeathForceForceMin"),0) + "")
		MFORCE_MAX_SLIDER = AddInputOption("Max Melee Ragdoll Force", StringDecimals(GetGameSettingFloat("fDeathForceForceMax"),0) + "")
		SFORCE_SLIDER = AddInputOption("Spell Ragdoll Force Mult", StringDecimals(GetGameSettingFloat("fDeathForceSpellImpactMult"),0) + "")
		GFORCE_SLIDER = AddInputOption("Grab Force", StringDecimals(GetGameSettingFloat("fZKeyMaxForce"),0) + "")
	ELSEIF ( page == "INI")
		FIRST_FOV_SLIDER = AddInputOption("First Person FOV", StringDecimals(GetINIFloat("fDefaultWorldFOV:Display"),0) + "")
		THIRD_FOV_SLIDER = AddInputOption("Third Person FOV", StringDecimals(GetINIFloat("fDefault1stPersonFOV:Display"),0) + "")
		XSENSITIVITY_SLIDER = AddInputOption("Mouse X Sensitivity", StringDecimals(GetINIFloat("fMouseHeadingXScale:Controls"),3) + "")
		YSENSITIVITY_SLIDER = AddInputOption("Mouse Y Sensitivity", StringDecimals(GetINIFloat("fMouseHeadingYScale:Controls"),3) + "")
		COMBAT_SHOULDERY_SLIDER = AddInputOption("Combat Over Shoulder Add Y", StringDecimals(GetINIFloat("fOverShoulderCombatAddY:Camera"),0) + "")
		COMBAT_SHOULDERZ_SLIDER = AddInputOption("Combat Over Shoulder Pos Z", StringDecimals(GetINIFloat("fOverShoulderCombatPosZ:Camera"),0) + "")
		COMBAT_SHOULDERX_SLIDER = AddInputOption("Combat Over Shoulder Pos X", StringDecimals(GetINIFloat("fOverShoulderCombatPosX:Camera"),0) + "")
		SHOULDERZ_SLIDER = AddInputOption("Over Shoulder Pos Z", StringDecimals(GetINIFloat("fOverShoulderPosZ:Camera"),0) + "")
		SHOULDERX_SLIDER = AddInputOption("Over Shoulder Pos X", StringDecimals(GetINIFloat("fOverShoulderPosX:Camera"),0) + "")
		AUTOSAVE_COUNT_SLIDER = AddInputOption("Autosave Slot Count", GetINIInt("iAutoSaveCount:SaveGame") + "")
		SHOWCOMPASS_TOGGLE = addToggleOption("Show Compass", GetINIBool("bShowCompass:Interface"))
		DEPTHFIELD_TOGGLE = addToggleOption("Depth of Field Blur", GetINIBool("bDoDepthOfField:Imagespace"))
		HAVOK_HIT_TOGGLE = addToggleOption("Enable Havok Hit", GetINIBool("bEnableHavokHit:Animation"))
		HAVOK_HIT_SLIDER = AddInputOption("Havok Hit Mult", StringDecimals(GetINIFloat("fHavokHitImpulseMult:Animation"),0) + "")
		SHOW_TUTORIAL_TOGGLE = addToggleOption("Show Tutorials", GetINIBool("bShowTutorials:Interface"))
		BOOK_SPEED_SLIDER = AddInputOption("Book Open Time", StringDecimals(GetINIFloat("fBookOpenTime:Interface"),0) + "")
		FIRST_ARROWTILT_SLIDER = AddInputOption("1st Person Arrow Tilt", StringDecimals(GetINIFloat("f1PArrowTiltUpAngle:Combat"),2) + "")
		THIRD_ARROWTILT_SLIDER = AddInputOption("3rd Person Arrow Tilt", StringDecimals(GetINIFloat("f3PArrowTiltUpAngle:Combat"),2) + "")
		FIRST_BOLTTILT_SLIDER = AddInputOption("1st Person Bolt Tilt", StringDecimals(GetINIFloat("f1PBoltTiltUpAngle:Combat"),2) + "")
		NPC_USEAMMO_TOGGLE = addToggleOption("NPCs Use Ammo", GetINIBool("bForceNPCsUseAmmo:Combat"))
		NAVMESH_DISTANCE_SLIDER = AddInputOption("Visible Navmesh Distance", StringDecimals(GetINIFloat("fVisibleNavmeshMoveDist:Actor"),0) + "")
		FRICTION_LAND_SLIDER = AddInputOption("Landscape Friction", StringDecimals(GetINIFloat("fLandFriction:Landscape"),1) + "")
		TREE_ANIMATION_TOGGLE = addToggleOption("Enable Tree Animations", GetINIBool("bEnableTreeAnimations:Trees"))
		GORE_TOGGLE = addToggleOption("Disable Gore", GetINIBool("bDisableAllGore:General"))
		CONSOLE_TEXT_SLIDER = AddInputOption("Console Text Size", GetINIInt("iConsoleTextSize:Menu") + "")
		CONSOLE_PERCENT_SLIDER = AddInputOption("Console Size Percent", GetINIInt("iConsoleSizeScreenPercent:Menu") + "")
		MAP_YAW_SLIDER = AddInputOption("World Map Yaw Range", StringDecimals(GetINIFloat("fMapWorldYawRange:MapMenu"),0) + "")
		MAP_PITCH_SLIDER = AddInputOption("World Map Pitch Range", StringDecimals(GetINIFloat("fMapWorldMaxPitch:MapMenu"),0) + "")
		VATS_TOGGLE = addToggleOption("Disable VATS Kill Camera", GetINIBool("bVatsDisable:VATS"))
		ALWAYS_ACTIVE_TOGGLE = addToggleOption("Run Skyrim In Background", GetINIBool("bAlwaysActive:General"))
		ESSENTIAL_NPC_TOGGLE = addToggleOption("Essential NPCs Can't Die", GetINIBool("bEssentialTakeNoDamage:Gameplay"))
	ELSEIF ( page == "Scripts")
		LEGENDARY_BONUS_TOGGLE = addToggleOption("Enable Legendary Bonus", PlayerRef.HasSpell(GBT_legendaryBonus))
		LEGENDARY_BONUS_SLIDER = AddInputOption("Bonus per reset", StringDecimals(GBT_legendaryBonus_Float,0) + "")
		ARROW_FAMINE_TOGGLE = addToggleOption("Enable Arrow Famine", PlayerRef.HasSpell(GBT_arrowFamine))
		ARROW_FAMINE_SLIDER = AddInputOption("Arrows per Shot", StringDecimals(GBT_arrowFamine_Float,0) + "")
		SNEAK_FATIGUE_TOGGLE = addToggleOption("Enable Sneak Fatigue", PlayerRef.HasSpell(GBT_sneakFatigue))
		SNEAK_FATIGUE_SLIDER = AddInputOption("Stamina per Second", StringDecimals(GBT_sneakFatigue_Float,0) + "")
		TIMED_BLOCK_TOGGLE = addToggleOption("Enable Timed Block", PlayerRef.HasSpell(GBT_enableTimedBlock))
		addHeaderOption("")
		TIMEDBLOCK_WEAPON_SLIDER = AddInputOption("Weapon Block Time", StringDecimals(GBT_timeBlockWeapon_Float,2) + "")
		TIMEDBLOCK_SHIELD_SLIDER = AddInputOption("Shield Block Time", StringDecimals(GBT_timeBlockShield_Float,2) + "")
		TIMEDBLOCK_REFLECTTIME_SLIDER = AddInputOption("Stamina Reflect Time", StringDecimals(GBT_timeBlockReflect_Float,2) + "")
		TIMEDBLOCK_REFLECTWARD_SLIDER = AddInputOption("Ward Reflect Time", StringDecimals(GBT_timeBlockWard_Float,2) + "")
		TIMEDBLOCK_REFLECTDMG_SLIDER = AddInputOption("Reflected Damage", StringDecimals(GBT_timeBlockDamage_Float,0) + "")
		TIMEDBLOCK_EXP_SLIDER = AddInputOption("Timed Block XP", StringDecimals(GBT_timeBlockXP_Float,1) + "")
		ITEM_LIMITER_TOGGLE = addToggleOption("Enable Item Limiter", PlayerRef.HasSpell(GBT_enableItemAdded))
		addHeaderOption("")
		ITEMLIMITER_LOCKPICK_SLIDER = AddInputOption("Lockpick Limit", GBT_limitLockpick_Int + "")
		ITEMLIMITER_ARROW_SLIDER = AddInputOption("Arrow Limit", GBT_limitArrow_Int + "")
		ITEMLIMITER_POTION_SLIDER = AddInputOption("Potion Limit", GBT_limitPotion_Int + "")
		ITEMLIMITER_POISON_SLIDER = AddInputOption("Poison Limit", GBT_limitPoison_Int + "")
		PLAYER_STAGGER_TOGGLE = addToggleOption("Enable Player Stagger", PlayerRef.HasSpell(GBT_enableOnHit))
		addHeaderOption("")
		PLAYERSTAGGER_BASEDUR_SLIDER = AddInputOption("Base Stagger Duration", StringDecimals(GBT_staggerTaken_Float,2) + "")
		PLAYERSTAGGER_IMMUNITY_SLIDER = AddInputOption("Stagger Immunity Duration", StringDecimals(GBT_staggerImmunity_Float,2) + "")
		PLAYERSTAGGER_ARMORWEIGHT_SLIDER = AddInputOption("Armor Weight Factor", StringDecimals(GBT_staggerArmor_Float,0) + "")
		PLAYERSTAGGER_MAGICKACOST_SLIDER = AddInputOption("Magicka Cost Factor", StringDecimals(GBT_staggerMagicka_Float,0) + "")
		PLAYERSTAGGER_MINTHRESH_SLIDER = AddInputOption("Minimum Stagger Threshold", StringDecimals(GBT_staggerMin_Float,2) + "")
		PLAYERSTAGGER_MAXTHRESH_SLIDER = AddInputOption("Maximum Stagger Duration", StringDecimals(GBT_staggerMax_Float,1) + "")
		NPC_STAGGER_TOGGLE = addToggleOption("Enable NPC Stagger (Melee)", PlayerRef.HasSpell(GBT_enableMeleeStagger))
		addHeaderOption("")
		NPCSTAGGER_MULT_SLIDER = AddInputOption("Weapon Stagger Mult", StringDecimals(GBT_MeleeStaggerMult_Float,2) + "")
		NPCSTAGGER_BASE_SLIDER = AddInputOption("Base Stagger", StringDecimals(GBT_MeleeStaggerBase_Float,2) + "")
		NPCSTAGGER_ARMORWEIGHT_SLIDER = AddInputOption("Armor Weight Factor", StringDecimals(GBT_MeleeStaggerWeight_Float,2) + "")
		NPCSTAGGER_IMMUNITY_SLIDER = AddInputOption("Stagger Immunity Duration", StringDecimals(GBT_MeleeStaggerCD_Float,2) + "")
		BLEEDOUT_TOGGLE = addToggleOption("Enable Bleedout", PlayerRef.HasSpell(GBT_enableBleedout))
		addHeaderOption("")
		BLEEDOUT_LOSSBASE_SLIDER = AddInputOption("Gold Loss Base", StringDecimals(GBT_bleedoutBase_Float,2) + "")
		BLEEDOUT_LOSSMULT_SLIDER = AddInputOption("Gold Loss Level Mult", GBT_bleedoutMult_Int + "")
		BLEEDOUT_MAXLIVES_SLIDER = AddInputOption("Number of Lives", GBT_bleedoutLivesMax_Int + "")
		addHeaderOption("")
		ARMOR_CMBEXP_TOGGLE = addToggleOption("Defense Experience In Combat", PlayerRef.HasSpell(GBT_EnableCombatState))
		ARMOR_CMBEXP_SLIDER = AddInputOption("Armor Exp Per Minute", StringDecimals(GBT_ArmorExp_Float,0) + "")
		BLOCK_CMBEXP_SLIDER = AddInputOption("Block Exp Per Minute", StringDecimals(GBT_BlockExp_Float,0) + "")
	ELSE
		addHeaderOption("Information")
		addHeaderOption("")
		INFO1_TEXT = addTextOption("Scanner","Info")
		INFO2_TEXT = addTextOption("Stacker(+/*)","Info")
		INFO3_TEXT = addTextOption("Spell Script","Info")
		INFO4_TEXT = addTextOption("Vanilla(#)","Info")
		INFO5_TEXT = addTextOption("Perk","Info")
		INFO6_TEXT = addTextOption("Persistent","Info")
		addHeaderOption("Save and Settings Options")
		addHeaderOption("")
		LOADFROMFISS_OID = addTextOption("Load Settings from FISS","GO!")
		SAVETOFISS_OID = addTextOption("Save Settings to FISS","GO!")
		FISSFILENAME_OID = AddInputOption("FISS Filename",FissFilename)
		SAVELOCAL_OID = AddInputOption("Create Save File","GO!")
		EXITGAME_OID = addTextOption("Exit Game","GO!")
		SLIDERMODE_OID = addToggleOption("Slider Mode",SliderModeVar)
		REIMPORT_OID = addTextOption("Full Reset","GO!")
		REGISTERSAVEKEY_OID = addToggleOption("Register Save Hotkey",isRegistered)
		SHOWMESSAGE_OID = addToggleOption("Show Save/Load Messages",ShowMessages)
		SAVEHOTKEY_OID = AddKeyMapOption("Save Hotkey",saveHotkey)
		QUICKSAVE_OID = AddMenuOption("Hotkey Settings",quickSaveOptions[isQuickSave])
		CREDITS_TEXT = addTextOption("Credits:","Grimy Bunyip")
	ENDIF
	ENDIF
ENDEVENT


EVENT OnOptionSelect(int option)
	IF ( option == TEMPER_SCALE_TOGGLE)
		IF PlayerRef.HasPerk(GBT_Temper_Scale)
			PlayerRef.RemovePerk(GBT_Temper_Scale)
			SetToggleOptionValue(TEMPER_SCALE_TOGGLE,false)
		ELSE
			PlayerRef.AddPerk(GBT_Temper_Scale)
			SetToggleOptionValue(TEMPER_SCALE_TOGGLE,true)
		ENDIF
	ELSEIF ( option == CRIT_SCALE_TOGGLE)
		IF PlayerRef.HasPerk(GBT_Critical_Damage_Scaling)
			PlayerRef.RemovePerk(GBT_Critical_Damage_Scaling)
			SetToggleOptionValue(CRIT_SCALE_TOGGLE,false)
		ELSE
			PlayerRef.AddPerk(GBT_Critical_Damage_Scaling)
			SetToggleOptionValue(CRIT_SCALE_TOGGLE,true)
		ENDIF
	ELSEIF ( option == BLEED_SCALE_TOGGLE)
		IF PlayerRef.HasPerk(GBT_Bleed_Damage_Scaling)
			PlayerRef.RemovePerk(GBT_Bleed_Damage_Scaling)
			SetToggleOptionValue(BLEED_SCALE_TOGGLE,false)
		ELSE
			PlayerRef.AddPerk(GBT_Bleed_Damage_Scaling)
			SetToggleOptionValue(BLEED_SCALE_TOGGLE,true)
		ENDIF
	ELSEIF ( option == STAMINACOST_SCALE_TOGGLE)
		IF PlayerRef.HasPerk(GBT_Stamina_Cost_Scaling)
			PlayerRef.RemovePerk(GBT_Stamina_Cost_Scaling)
			SetToggleOptionValue(STAMINACOST_SCALE_TOGGLE,false)
		ELSE
			PlayerRef.AddPerk(GBT_Stamina_Cost_Scaling)
			SetToggleOptionValue(STAMINACOST_SCALE_TOGGLE,true)
		ENDIF
	ELSEIF ( option == ILLTARGLVL_SCALE_TOGGLE)
		IF PlayerRef.HasPerk(GBT_illScaleTargetLevel)
			PlayerRef.RemovePerk(GBT_illScaleTargetLevel)
			SetToggleOptionValue(ILLTARGLVL_SCALE_TOGGLE,false)
		ELSE
			PlayerRef.AddPerk(GBT_illScaleTargetLevel)
			SetToggleOptionValue(ILLTARGLVL_SCALE_TOGGLE,true)
		ENDIF
	ELSEIF ( option == FRIENDLY_DAMAGE_TOGGLE)
		IF PlayerRef.HasPerk(GBT_friendlyDamage)
			PlayerRef.RemovePerk(GBT_friendlyDamage)
			SetToggleOptionValue(FRIENDLY_DAMAGE_TOGGLE,false)
		ELSE
			PlayerRef.AddPerk(GBT_friendlyDamage)
			SetToggleOptionValue(FRIENDLY_DAMAGE_TOGGLE,true)
		ENDIF
	ELSEIF ( option == FRIENDLY_STAGGER_TOGGLE)
		IF PlayerRef.HasPerk(GBT_friendlyStagger)
			PlayerRef.RemovePerk(GBT_friendlyStagger)
			SetToggleOptionValue(FRIENDLY_STAGGER_TOGGLE,false)
		ELSE
			PlayerRef.AddPerk(GBT_friendlyStagger)
			SetToggleOptionValue(FRIENDLY_STAGGER_TOGGLE,true)
		ENDIF
	ELSEIF ( option == SHOWCOMPASS_TOGGLE)
		IF GetINIBool("bShowCompass:Interface")
			SetINIBool("bShowCompass:Interface",false)
			SetToggleOptionValue(SHOWCOMPASS_TOGGLE,false)
		ELSE
			SetINIBool("bShowCompass:Interface",true)
			SetToggleOptionValue(SHOWCOMPASS_TOGGLE,true)
		ENDIF
	ELSEIF ( option == DEPTHFIELD_TOGGLE)
		IF GetINIBool("bDoDepthOfField:Imagespace")
			SetINIBool("bDoDepthOfField:Imagespace",false)
			SetToggleOptionValue(DEPTHFIELD_TOGGLE,false)
		ELSE
			SetINIBool("bDoDepthOfField:Imagespace",true)
			SetToggleOptionValue(DEPTHFIELD_TOGGLE,true)
		ENDIF
	ELSEIF ( option == HAVOK_HIT_TOGGLE)
		IF GetINIBool("bEnableHavokHit:Animation")
			SetINIBool("bEnableHavokHit:Animation",false)
			SetToggleOptionValue(HAVOK_HIT_TOGGLE,false)
		ELSE
			SetINIBool("bEnableHavokHit:Animation",true)
			SetToggleOptionValue(HAVOK_HIT_TOGGLE,true)
		ENDIF
	ELSEIF ( option == SHOW_TUTORIAL_TOGGLE)
		IF GetINIBool("bShowTutorials:Interface")
			SetINIBool("bShowTutorials:Interface",false)
			SetToggleOptionValue(SHOW_TUTORIAL_TOGGLE,false)
		ELSE
			SetINIBool("bShowTutorials:Interface",true)
			SetToggleOptionValue(SHOW_TUTORIAL_TOGGLE,true)
		ENDIF
	ELSEIF ( option == NPC_USEAMMO_TOGGLE)
		IF GetINIBool("bForceNPCsUseAmmo:Combat")
			SetINIBool("bForceNPCsUseAmmo:Combat",false)
			SetToggleOptionValue(NPC_USEAMMO_TOGGLE,false)
		ELSE
			SetINIBool("bForceNPCsUseAmmo:Combat",true)
			SetToggleOptionValue(NPC_USEAMMO_TOGGLE,true)
		ENDIF
	ELSEIF ( option == TREE_ANIMATION_TOGGLE)
		IF GetINIBool("bEnableTreeAnimations:Trees")
			SetINIBool("bEnableTreeAnimations:Trees",false)
			SetToggleOptionValue(TREE_ANIMATION_TOGGLE,false)
		ELSE
			SetINIBool("bEnableTreeAnimations:Trees",true)
			SetToggleOptionValue(TREE_ANIMATION_TOGGLE,true)
		ENDIF
	ELSEIF ( option == GORE_TOGGLE)
		IF GetINIBool("bDisableAllGore:General")
			SetINIBool("bDisableAllGore:General",false)
			SetToggleOptionValue(GORE_TOGGLE,false)
		ELSE
			SetINIBool("bDisableAllGore:General",true)
			SetToggleOptionValue(GORE_TOGGLE,true)
		ENDIF
	ELSEIF ( option == VATS_TOGGLE)
		IF GetINIBool("bVatsDisable:VATS")
			SetINIBool("bVatsDisable:VATS",false)
			SetToggleOptionValue(VATS_TOGGLE,false)
		ELSE
			SetINIBool("bVatsDisable:VATS",true)
			SetToggleOptionValue(VATS_TOGGLE,true)
		ENDIF
	ELSEIF ( option == ALWAYS_ACTIVE_TOGGLE)
		IF GetINIBool("bAlwaysActive:General")
			SetINIBool("bAlwaysActive:General",false)
			SetToggleOptionValue(ALWAYS_ACTIVE_TOGGLE,false)
		ELSE
			SetINIBool("bAlwaysActive:General",true)
			SetToggleOptionValue(ALWAYS_ACTIVE_TOGGLE,true)
		ENDIF
	ELSEIF ( option == ESSENTIAL_NPC_TOGGLE)
		IF GetINIBool("bEssentialTakeNoDamage:Gameplay")
			SetINIBool("bEssentialTakeNoDamage:Gameplay",false)
			SetToggleOptionValue(ESSENTIAL_NPC_TOGGLE,false)
		ELSE
			SetINIBool("bEssentialTakeNoDamage:Gameplay",true)
			SetToggleOptionValue(ESSENTIAL_NPC_TOGGLE,true)
		ENDIF
	ELSEIF ( option == LEGENDARY_BONUS_TOGGLE)
		IF PlayerRef.HasSpell(GBT_legendaryBonus)
			PlayerRef.RemoveSpell(GBT_legendaryBonus)
			SetToggleOptionValue(LEGENDARY_BONUS_TOGGLE,false)
		ELSE
			PlayerRef.AddSpell(GBT_legendaryBonus)
			SetToggleOptionValue(LEGENDARY_BONUS_TOGGLE,true)
		ENDIF
	ELSEIF ( option == ARROW_FAMINE_TOGGLE)
		IF PlayerRef.HasSpell(GBT_arrowFamine)
			PlayerRef.RemoveSpell(GBT_arrowFamine)
			SetToggleOptionValue(ARROW_FAMINE_TOGGLE,false)
		ELSE
			PlayerRef.AddSpell(GBT_arrowFamine)
			SetToggleOptionValue(ARROW_FAMINE_TOGGLE,true)
		ENDIF
	ELSEIF ( option == SNEAK_FATIGUE_TOGGLE)
		IF PlayerRef.HasSpell(GBT_sneakFatigue)
			PlayerRef.RemoveSpell(GBT_sneakFatigue)
			SetToggleOptionValue(SNEAK_FATIGUE_TOGGLE,false)
		ELSE
			PlayerRef.AddSpell(GBT_sneakFatigue)
			SetToggleOptionValue(SNEAK_FATIGUE_TOGGLE,true)
		ENDIF
	ELSEIF ( option == TIMED_BLOCK_TOGGLE)
		IF PlayerRef.HasSpell(GBT_enableTimedBlock)
			PlayerRef.RemoveSpell(GBT_enableTimedBlock)
			SetToggleOptionValue(TIMED_BLOCK_TOGGLE,false)
		ELSE
			PlayerRef.AddSpell(GBT_enableTimedBlock)
			SetToggleOptionValue(TIMED_BLOCK_TOGGLE,true)
		ENDIF
	ELSEIF ( option == ITEM_LIMITER_TOGGLE)
		IF PlayerRef.HasSpell(GBT_enableItemAdded)
			PlayerRef.RemoveSpell(GBT_enableItemAdded)
			SetToggleOptionValue(ITEM_LIMITER_TOGGLE,false)
		ELSE
			PlayerRef.AddSpell(GBT_enableItemAdded)
			SetToggleOptionValue(ITEM_LIMITER_TOGGLE,true)
		ENDIF
	ELSEIF ( option == PLAYER_STAGGER_TOGGLE)
		IF PlayerRef.HasSpell(GBT_enableOnHit)
			PlayerRef.RemoveSpell(GBT_enableOnHit)
			SetToggleOptionValue(PLAYER_STAGGER_TOGGLE,false)
		ELSE
			PlayerRef.AddSpell(GBT_enableOnHit)
			SetToggleOptionValue(PLAYER_STAGGER_TOGGLE,true)
		ENDIF
	ELSEIF ( option == NPC_STAGGER_TOGGLE)
		IF PlayerRef.HasSpell(GBT_enableMeleeStagger)
			PlayerRef.RemoveSpell(GBT_enableMeleeStagger)
			SetToggleOptionValue(NPC_STAGGER_TOGGLE,false)
		ELSE
			PlayerRef.AddSpell(GBT_enableMeleeStagger)
			SetToggleOptionValue(NPC_STAGGER_TOGGLE,true)
		ENDIF
	ELSEIF ( option == BLEEDOUT_TOGGLE)
		IF PlayerRef.HasSpell(GBT_enableBleedout)
			PlayerRef.RemoveSpell(GBT_enableBleedout)
			SetToggleOptionValue(BLEEDOUT_TOGGLE,false)
		ELSE
			PlayerRef.AddSpell(GBT_enableBleedout)
			SetToggleOptionValue(BLEEDOUT_TOGGLE,true)
		ENDIF
	ELSEIF ( option == ARMOR_CMBEXP_TOGGLE)
		IF PlayerRef.HasSpell(GBT_EnableCombatState)
			PlayerRef.RemoveSpell(GBT_EnableCombatState)
			SetToggleOptionValue(ARMOR_CMBEXP_TOGGLE,false)
		ELSE
			PlayerRef.AddSpell(GBT_EnableCombatState)
			SetToggleOptionValue(ARMOR_CMBEXP_TOGGLE,true)
		ENDIF
	ELSEIF ( option == LOADFROMFISS_OID)
			fissLoadAll()
	ELSEIF ( option == SAVETOFISS_OID)
		IF ShowMessage("Are you sure? Wait for a completion message if your accept.")
			fissSaveAll()
			ShowMessage("Done saving settings to FISS XML.",false)
		ENDIF
	ELSEIF ( option == EXITGAME_OID)
		IF ShowMessage("Are you sure you want to exit the game?")
			Debug.QuitGame()
		ENDIF
	ELSEIF ( option == SLIDERMODE_OID)
		IF SliderModeVar
		SliderModeVar = false
			SetToggleOptionValue(SLIDERMODE_OID,false)
		ELSE
		SliderModeVar = true
			SetToggleOptionValue(SLIDERMODE_OID,true)
		ENDIF
	ELSEIF ( option == REIMPORT_OID)
		IF ShowMessage("Are you sure you want to reset all settings for SkyTweak?\nNote: You will need to restart Skyrim for the reset to take effect?",TRUE)
			needReimport = true
		ELSE
			needReimport = false
		ENDIF
	ELSEIF ( option == REGISTERSAVEKEY_OID)
		IF isRegistered
			UnregisterForKey(saveHotkey)
			saveHotkey = -1
			isRegistered = false
			SetKeyMapOptionValue(SAVEHOTKEY_OID, saveHotkey)
		ELSE
			IF saveHotkey > 0
				RegisterForKey(saveHotkey)
			ENDIF
			isRegistered = true
		ENDIF
		SetToggleOptionValue(REGISTERSAVEKEY_OID, isRegistered)
	ELSEIF ( option == SHOWMESSAGE_OID)
		ShowMessages = !ShowMessages
		SetToggleOptionValue(SHOWMESSAGE_OID, ShowMessages)
	ENDIF
ENDEVENT


EVENT OnOptionSliderOpen(int option)
	IF ( option == SHOUT_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_shoutScale.GetNthEntryValue(0, 1) * 100) + 0 )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == TRAP_MAGNITUDE_SLIDER)
		SetSliderDialogStartValue( (GBT_trapMagnitude.GetNthEntryValue(0, 0) * 100) + 0 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 10000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == WEREDMG_DEALT_SLIDER)
		SetSliderDialogStartValue( (GBT_WerewolfDamageDealt.GetNthEntryValue(0, 0) * 100) + 0 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == WEREDMG_TAKEN_SLIDER)
		SetSliderDialogStartValue( (GBT_WerewolfDamageTaken.GetNthEntryValue(0, 0) * 100) + 0 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == POISON_DOSE_SLIDER)
		SetSliderDialogStartValue( (GBT_poisonDose.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == DUALCAST_POWER_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fMagicDualCastingEffectivenessBase") )
		SetSliderDialogDefaultValue(2.2)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == DUALCAST_COST_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fMagicDualCastingCostMult") )
		SetSliderDialogDefaultValue(2.8)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == MAGICCOST_SCALE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fMagicCasterPCSkillCostBase") )
		SetSliderDialogDefaultValue(0.0025)
		SetSliderDialogRange(0.0, 0.005)
		SetSliderDialogInterval(0.0001)
	ELSEIF ( option == MAGIC_COST_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fMagicCasterPCSkillCostMult") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == NPCMAGICCOST_SCALE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fMagicCasterSkillCostBase") )
		SetSliderDialogDefaultValue(0.0025)
		SetSliderDialogRange(0.0, 0.005)
		SetSliderDialogInterval(0.0001)
	ELSEIF ( option == NPCMAGIC_COST_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fMagicCasterSkillCostMult") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == MAX_RUNES_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iMaxPlayerRunes") )
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == MAX_SUMMONED_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iMaxSummonedCreatures") )
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == TELEKIN_DAMAGE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fMagicTelekinesisDamageBase") )
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == TELEKIN_DUALMULT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fMagicTelekinesisDualCastDamageMult") )
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == ALTMAG_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_altScaleMag.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == CONJMAG_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_conjScaleMag.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == ALTDURNOTPARA_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_altScaleDurNotPara.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == CONJDUR_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_conjScaleDur.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == ALTCOST_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_altScaleCost.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == CONJCOST_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_conjScaleCost.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == ALTDURPARA_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_altScaleDurPara.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == BOUNTMELEE_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_conjScaleBoundMelee.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == ALTCOSTDET_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_altScaleCostDet.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == BOUNDBOW_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_conjScaleBoundBow.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == DESMAG_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_desScaleMag.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == HEALMAG_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_restScaleMagHeal.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == DESDUR_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_desScaleDur.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == HEALDUR_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_restScaleDurHeal.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == DESCOST_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_desScaleCost.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == HEALCOST_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_restScaleCostHeal.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == ILLMAG_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_illScaleMag.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == NONHEALMAG_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_nonHealScaleMag.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == ILLDUR_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_illScaleDur.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == NONHEALDUR_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_nonHealScaleDur.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == ILLCOST_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_illScaleCost.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == NONHEALCOST_SCALE_SLIDER)
		SetSliderDialogStartValue( (GBT_nonHealScaleCost.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == LESSERPOWER_COOLDOWN_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fMagicLesserPowerCooldownTimer") )
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == DAMAGEDEALTSCALE_OID)
		SetSliderDialogStartValue( scaleDamageDealt_VAR )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 2.0)
		SetSliderDialogInterval(0.001)
	ELSEIF ( option == DAMAGETAKENSCALE_OID)
		SetSliderDialogStartValue( scaleDamageTaken_VAR )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 2.0)
		SetSliderDialogInterval(0.001)
	ELSEIF ( option == DAMAGEDEALT_NOVICE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDiffMultHPByPCVE") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DAMAGETAKEN_NOVICE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDiffMultHPToPCVE") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DAMAGEDEALT_APPRENTICE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDiffMultHPByPCE") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
		SetSliderDialogDefaultValue(1.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DAMAGETAKEN_APPRENTICE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDiffMultHPToPCE") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
		SetSliderDialogDefaultValue(0.75)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DAMAGEDEALT_ADEPT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDiffMultHPByPCN") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DAMAGETAKEN_ADEPT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDiffMultHPToPCN") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DAMAGEDEALT_EXPERT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDiffMultHPByPCH") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
		SetSliderDialogDefaultValue(0.75)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DAMAGETAKEN_EXPERT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDiffMultHPToPCH") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
		SetSliderDialogDefaultValue(1.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DAMAGEDEALT_MASTER_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDiffMultHPByPCVH") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DAMAGETAKEN_MASTER_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDiffMultHPToPCVH") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DAMAGEDEALT_LEGENDARY_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDiffMultHPByPCL") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
		SetSliderDialogDefaultValue(0.25)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DAMAGETAKEN_LEGENDARY_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDiffMultHPToPCL") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == WEAPONSCALE_PCMIN_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDamagePCSkillMin") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == WEAPONSCALE_PCMAX_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDamagePCSkillMax") )
		SetSliderDialogDefaultValue(1.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == WEAPONSCALE_NPCMIN_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDamageSkillMin") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == WEAPONSCALE_NPCMAX_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDamageSkillMax") )
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == ARMOR_SCALE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fArmorScalingFactor") )
		SetSliderDialogDefaultValue(0.12)
		SetSliderDialogRange(0.0, 0.5)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == MAX_RESISTANCE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fPlayerMaxResistance") )
		SetSliderDialogDefaultValue(85.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == ARMOR_BASERESIST_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fArmorBaseFactor") )
		SetSliderDialogDefaultValue(0.03)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == ARMOR_MAXRESIST_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fMaxArmorRating") )
		SetSliderDialogDefaultValue(80.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == PC_ARMORRATING_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fArmorRatingPCMax") )
		SetSliderDialogDefaultValue(1.4)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == NPC_ARMORRATING_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fArmorRatingMax") )
		SetSliderDialogDefaultValue(2.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == ENCUM_EFFECT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fMoveEncumEffect") )
		SetSliderDialogDefaultValue(0.3)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == ENCUMWEAP_EFFECT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fMoveEncumEffectNoWeapon") )
		SetSliderDialogDefaultValue(0.15)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == WEAPONDAMAGE_MULT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDamageWeaponMult") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == TWOHAND_ATKSPD_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fWeaponTwoHandedAnimationSpeedMult") )
		SetSliderDialogDefaultValue(1.5)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == AUTOAIM_AREA_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fAutoAimScreenPercentage") )
		SetSliderDialogDefaultValue(6.0)
		SetSliderDialogRange(0.0, 200.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AUTOAIM_RANGE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fAutoAimMaxDistance") )
		SetSliderDialogDefaultValue(1800.0)
		SetSliderDialogRange(0.0, 5000.0)
		SetSliderDialogInterval(50)
	ELSEIF ( option == AUTOAIM_DEGREES_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fAutoAimMaxDegrees") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 30.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == AUTOAIM_DEGREESTHIRD_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fAutoAimMaxDegrees3rdPerson") )
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 30.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == STAMINA_POWERCOST_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fPowerAttackStaminaPenalty") )
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == STAMINA_BLOCKCOSTMULT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fStaminaBlockDmgMult") )
		SetSliderDialogDefaultValue(0.25)
		SetSliderDialogRange(0.0, 2.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == STAMINA_BASHCOST_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fStaminaBashBase") )
		SetSliderDialogDefaultValue(35.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == STAMINA_POWERBASHCOST_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fStaminaPowerBashBase") )
		SetSliderDialogDefaultValue(55.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == STAMINA_BLOCKCOSTBASE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fStaminaBlockBase") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == BLOCK_SHIELD_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fShieldBaseFactor") )
		SetSliderDialogDefaultValue(0.45)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == BLOCK_WEAPON_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fBlockWeaponBase") )
		SetSliderDialogDefaultValue(0.3)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == WEAPON_REACH_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fCombatDistance") )
		SetSliderDialogDefaultValue(141.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == BASH_REACH_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fCombatBashReach") )
		SetSliderDialogDefaultValue(141.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AISEARCH_TIME_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fCombatStealthPointRegenAttackedWaitTime") )
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0, 300.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AISEARCH_TIMEATTACKED_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fCombatStealthPointRegenDetectedEventWaitTime") )
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 300.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == SNEAKLEVEL_BASE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fPlayerDetectionSneakBase") )
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 50.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == SNEAKDETECTION_SCALE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fPlayerDetectionSneakMult") )
		SetSliderDialogDefaultValue(0.4)
		SetSliderDialogRange(0.0, 2.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DETECTION_FOV_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDetectionViewCone") )
		SetSliderDialogDefaultValue(190.0)
		SetSliderDialogRange(0.0, 360.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == SNEAK_BASE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSneakBaseValue") )
		SetSliderDialogDefaultValue(-15.0)
		SetSliderDialogRange(-200.0, 0.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == DETECTION_LIGHT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDetectionSneakLightMod") )
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == DETECTION_LIGHTEXT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSneakLightExteriorMult") )
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 2.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DETECTION_SOUND_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSneakSoundsMult") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 2.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DETECTION_SOUNDLOS_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSneakSoundLosMult") )
		SetSliderDialogDefaultValue(0.3)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == PICKPOCKET_MAXCHANCE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fPickPocketMaxChance") )
		SetSliderDialogDefaultValue(90.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == PICKPOCKET_MINCHANCE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fPickPocketMinChance") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == SNEAKMULT_MARKSMAN_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakMarks.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SNEAKMULT_DAGGER_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakDagger.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SNEAKMULT_TWOHAND_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakOne.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SNEAKMULT_ONEHAND_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakTwo.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SNEAKMULT_UNARMED_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakH2H.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SNEAKMULT_RUNE_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakRuneMag.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SNEAKMULT_SEARCH_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakSearch.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SNEAKMULT_SPELLMAG_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakSpellMag.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SNEAKMULT_SPELLSEARCH_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakSpellSearch.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SNEAKMULT_SPELLDUR_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakSpellDur.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SNEAKSCALE_PHYSICAL_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakScalePhys.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == SNEAKSCALE_SPELLMAG_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakScaleSpell.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == SNEAKMULT_POISONMAG_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakPoisonMag.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SNEAKMULT_POISONDUR_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakPoisonDur.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SNEAKSCALE_POISONMAG_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakScalePoisonMag.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == SNEAKSCALE_POISONDUR_SLIDER)
		SetSliderDialogStartValue( (GBT_SneakScalePoisonDur.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == LOCKPICK_VEASY_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSweetSpotVeryEasy") )
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.01, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == LOCKPICKDUR_VEASY_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fLockpickBreakNovice") )
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.01, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == LOCKPICK_EASY_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSweetSpotEasy") )
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.01, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == LOCKPICKDUR_EASY_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fLockpickBreakApprentice") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.01, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == LOCKPICK_AVERAGE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSweetSpotAverage") )
		SetSliderDialogDefaultValue(7.5)
		SetSliderDialogRange(0.01, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == LOCKPICKDUR_AVERAGE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fLockpickBreakAdept") )
		SetSliderDialogDefaultValue(0.75)
		SetSliderDialogRange(0.01, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == LOCKPICK_HARD_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSweetSpotHard") )
		SetSliderDialogDefaultValue(3.75)
		SetSliderDialogRange(0.01, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == LOCKPICKDUR_HARD_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fLockpickBreakExpert") )
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.01, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == LOCKPICK_VHARD_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSweetSpotVeryHard") )
		SetSliderDialogDefaultValue(1.875)
		SetSliderDialogRange(0.01, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == LOCKPICKDUR_VHARD_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fLockpickBreakMaster") )
		SetSliderDialogDefaultValue(0.25)
		SetSliderDialogRange(0.01, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == ALCHEMYMAG_MULT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fAlchemyIngredientInitMult") )
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 50.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == ALCHEMYMAG_SCALE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fAlchemySkillFactor") )
		SetSliderDialogDefaultValue(1.5)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.05)
	ELSEIF ( option == BONUS_INGR_SLIDER)
		SetSliderDialogStartValue( (GBT_bonusIngredients.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == BONUS_POTION_SLIDER)
		SetSliderDialogStartValue( (GBT_bonusPotions.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == CHARGECOST_POWER_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fEnchantingCostExponent") )
		SetSliderDialogDefaultValue(1.1)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == ENCHANT_SCALING_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fEnchantingSkillFactor") )
		SetSliderDialogDefaultValue(1.25)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == CHARGECOST_MULT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fEnchantingSkillCostMult") )
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == ENCHANTPRICE_EFFECT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fEnchantmentEffectPointsMult") )
		SetSliderDialogDefaultValue(8.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == CHARGECOST_BASE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fEnchantingSkillCostBase") )
		SetSliderDialogDefaultValue(0.005)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.001)
	ELSEIF ( option == ENCHANTPRICE_SOUL_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fEnchantmentPointsMult") )
		SetSliderDialogDefaultValue(0.12)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == ENCHANT_CHARGE_SLIDER)
		SetSliderDialogStartValue( (GBT_enchantCharge.GetNthEntryValue(0, 0) * 100) + 0 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 10000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == ENCHANT_MAG_SLIDER)
		SetSliderDialogStartValue( (GBT_enchantMag.GetNthEntryValue(0, 0) * 100) + 0 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 10000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == BONUS_ENCHANT_SLIDER)
		SetSliderDialogStartValue( (GBT_bonusEnchants.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == TEMPER_SUFFIX_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSmithingConditionFactor") )
		SetSliderDialogDefaultValue(0.5825)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == TEMPER_ARMOR_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSmithingArmorMax") )
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == TEMPER_WEAPON_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSmithingWeaponMax") )
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == POTION_MAG_SLIDER)
		SetSliderDialogStartValue( (GBT_PotionMag.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == POTION_DUR_SLIDER)
		SetSliderDialogStartValue( (GBT_PotionDur.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == POTION_SCALEMAG_SLIDER)
		SetSliderDialogStartValue( (GBT_PotionScaleMag.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == POTION_SCALEDUR_SLIDER)
		SetSliderDialogStartValue( (GBT_PotionScaleDur.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == POISON_MAG_SLIDER)
		SetSliderDialogStartValue( (GBT_PoisonMag.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == POISON_DUR_SLIDER)
		SetSliderDialogStartValue( (GBT_PoisonDur.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == POISON_SCALEMAG_SLIDER)
		SetSliderDialogStartValue( (GBT_PoisonScaleMag.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == POISON_SCALEDUR_SLIDER)
		SetSliderDialogStartValue( (GBT_PoisonScaleDur.GetNthEntryValue(0, 1) * 10000) + 100 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(100.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == SCROLL_MAG_SLIDER)
		SetSliderDialogStartValue( (GBT_ScrollMag.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SCROLL_DUR_SLIDER)
		SetSliderDialogStartValue( (GBT_ScrollDur.GetNthEntryValue(0, 0) * 1) + 0 )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == BARTER_BUYMIN_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fBarterBuyMin") )
		SetSliderDialogDefaultValue(1.05)
		SetSliderDialogRange(0.0, 2.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == BARTER_SELLMAX_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fBarterSellMax") )
		SetSliderDialogDefaultValue(0.95)
		SetSliderDialogRange(0.0, 2.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == BARTER_MIN_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fBarterMin") )
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == BARTER_MAX_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fBarterMax") )
		SetSliderDialogDefaultValue(3.3)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == BUY_PRICE_SLIDER)
		SetSliderDialogStartValue( (GBT_buyPrice.GetNthEntryValue(0, 0) * 100) + 0 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 10000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == SELL_PRICE_SLIDER)
		SetSliderDialogStartValue( (GBT_sellPrice.GetNthEntryValue(0, 0) * 100) + 0 )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 10000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == VENDOR_RESPAWN_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iDaysToRespawnVendor") )
		SetSliderDialogDefaultValue(2)
		SetSliderDialogRange(1, 60)
		SetSliderDialogInterval(1)
	ELSEIF ( option == TRAINING_NUMALLOWED_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iTrainingNumAllowedPerLevel") )
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == TRAINING_JOURNEYMANCOST_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iTrainingJourneymanCost") )
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == TRAINING_JOURNEYMANSKILL_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iTrainingJourneymanSkill") )
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == TRAINING_EXPERTCOST_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iTrainingExpertCost") )
		SetSliderDialogDefaultValue(3)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == TRAINING_EXPERTSKILL_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iTrainingExpertSkill") )
		SetSliderDialogDefaultValue(75)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == TRAINING_MASTERCOST_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iTrainingMasterCost") )
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == TRAINING_MASTERSKILL_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iTrainingMasterSkill") )
		SetSliderDialogDefaultValue(90)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == APOTHECARY_GOLD_SLIDER)
		SetSliderDialogStartValue( VendorGoldApothecary.GetNthCount(0) )
		SetSliderDialogDefaultValue(500)
		SetSliderDialogRange(10, 65530)
		SetSliderDialogInterval(10)
	ELSEIF ( option == BLACKSMITH_GOLD_SLIDER)
		SetSliderDialogStartValue( VendorGoldBlacksmith.GetNthCount(0) )
		SetSliderDialogDefaultValue(1000)
		SetSliderDialogRange(10, 65530)
		SetSliderDialogInterval(10)
	ELSEIF ( option == ORCBLACKSMITH_GOLD_SLIDER)
		SetSliderDialogStartValue( VendorGoldBlacksmithOrc.GetNthCount(0) )
		SetSliderDialogDefaultValue(400)
		SetSliderDialogRange(10, 65530)
		SetSliderDialogInterval(10)
	ELSEIF ( option == TOWNBLACKSMITH_GOLD_SLIDER)
		SetSliderDialogStartValue( VendorGoldBlacksmithTown.GetNthCount(0) )
		SetSliderDialogDefaultValue(500)
		SetSliderDialogRange(10, 65530)
		SetSliderDialogInterval(10)
	ELSEIF ( option == INNKEERPER_GOLD_SLIDER)
		SetSliderDialogStartValue( VendorGoldInn.GetNthCount(0) )
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(10, 65530)
		SetSliderDialogInterval(10)
	ELSEIF ( option == MISCMERCHANT_GOLD_SLIDER)
		SetSliderDialogStartValue( VendorGoldMisc.GetNthCount(0) )
		SetSliderDialogDefaultValue(750)
		SetSliderDialogRange(10, 65530)
		SetSliderDialogInterval(10)
	ELSEIF ( option == SPELLMERCHANT_GOLD_SLIDER)
		SetSliderDialogStartValue( VendorGoldSpells.GetNthCount(0) )
		SetSliderDialogDefaultValue(500)
		SetSliderDialogRange(10, 65530)
		SetSliderDialogInterval(10)
	ELSEIF ( option == STREETVENDOR_GOLD_SLIDER)
		SetSliderDialogStartValue( VendorGoldStreetVendor.GetNthCount(0) )
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(10, 65530)
		SetSliderDialogInterval(10)
	ELSEIF ( option == COMBAT_STAMINAREGEN_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fCombatStaminaRegenRateMult") )
		SetSliderDialogDefaultValue(0.35)
		SetSliderDialogRange(0.0, 2.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == AV_COMBATHEALTHREGENMULT_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("CombatHealthRegenMult") )
		SetSliderDialogDefaultValue(0.7)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DAMAGESTAMINA_DELAY_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDamagedStaminaRegenDelay") )
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == BOWZOOM_REGENDELAY_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fBowZoomStaminaRegenDelay") )
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 60.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == COMBAT_MAGICKAREGEN_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fCombatMagickaRegenRateMult") )
		SetSliderDialogDefaultValue(0.33)
		SetSliderDialogRange(0.0, 2.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == STAMINA_REGENDELAY_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fStaminaRegenDelayMax") )
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 60.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == DAMAGEMAGICKA_DELAY_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDamagedMagickaRegenDelay") )
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == MAGICKA_REGENDELAY_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fMagickaRegenDelayMax") )
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 60.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == AV_HEALRATEMULT_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("HealRateMult") )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_HEALRATE_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetBaseAV("HealRate") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == AV_MAGICKARATEMULT_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("MagickaRateMult") )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_MAGICKARATE_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetBaseAV("MagickaRate") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == AV_STAMINARATEMULT_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("StaminaRateMult") )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_STAMINARATE_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetBaseAV("StaminaRate") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == AV_HEALTH_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("Health") )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 10000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_MAGICKA_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("Magicka") )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 10000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_STAMINA_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("Stamina") )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 10000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_DRAGONSOULS_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("DragonSouls") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_SHOUTRECOVERYMULT_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("ShoutRecoveryMult") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == AV_CARRYWEIGHT_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetBaseAV("CarryWeight") )
		SetSliderDialogDefaultValue(300.0)
		SetSliderDialogRange(0.0, 10000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_SPEEDMULT_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetBaseAV("SpeedMult") )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_UNARMEDDAMAGE_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetBaseAV("UnarmedDamage") )
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_MASS_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetBaseAV("Mass") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == AV_CRITCHANCE_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetBaseAV("CritChance") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_ALTERATIONPOWERMOD_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("AlterationPowerMod") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_CONJURATIONPOWERMOD_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("ConjurationPowerMod") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_DESTRUCTIONPOWERMOD_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("DestructionPowerMod") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_ILLUSIONPOWERMOD_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("IllusionPowerMod") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_RESTORATIONPOWERMOD_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("RestorationPowerMod") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_BOWSTAGGERBONUS_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("BowStaggerBonus") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == AV_BOWSPEEDBONUSVAR_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetBaseAV("BowSpeedBonus") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == AV_LEFTWEAPONSPEEDMULT_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("LeftWeaponSpeedMult") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == AV_WEAPONSPEEDMULT_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("WeaponSpeedMult") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == AV_MAGICRESIST_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("MagicResist") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_FIRERESIST_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("FireResist") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_POISONRESIST_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("PoisonResist") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_ELECTRICRESIST_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("ElectricResist") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_DISEASERESIST_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("DiseaseResist") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AV_FROSTRESIST_SLIDER)
		SetSliderDialogStartValue( PlayerRef.GetAV("FrostResist") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == PERK_POINTS_SLIDER)
		SetSliderDialogStartValue( GetPerkPoints() )
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 255)
		SetSliderDialogInterval(1)
	ELSEIF ( option == TIME_SCALE_SLIDER)
		SetSliderDialogStartValue(TimeScale.GetValueInt() )
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == FALLHEIGHT_MINNPC_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fJumpFallHeightMinNPC") )
		SetSliderDialogDefaultValue(450.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(10)
	ELSEIF ( option == FALLHEIGHT_MIN_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fJumpFallHeightMin") )
		SetSliderDialogDefaultValue(600.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(10)
	ELSEIF ( option == FALLHEIGHT_MULTNPC_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fJumpFallHeightMultNPC") )
		SetSliderDialogDefaultValue(0.1)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == FALLHEIGHT_MULT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fJumpFallHeightMult") )
		SetSliderDialogDefaultValue(0.1)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == FALLHEIGHT_EXPNPC_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fJumpFallHeightExponentNPC") )
		SetSliderDialogDefaultValue(1.65)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == FALLHEIGHT_EXP_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fJumpFallHeightExponent") )
		SetSliderDialogDefaultValue(1.45)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == JUMP_HEIGHT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fJumpHeightMin") )
		SetSliderDialogDefaultValue(76.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == SWIM_BREATHBASE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fActorSwimBreathBase") )
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 60.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == SWIM_BREATHDAMAGE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fActorSwimBreathDamage") )
		SetSliderDialogDefaultValue(0.08)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SWIM_BREATHMULT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fActorSwimBreathMult") )
		SetSliderDialogDefaultValue(0.2)
		SetSliderDialogRange(0.0, 60.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == KILLCAM_CHANCE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fKillCamBaseOdds") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DEATHCAMERA_TIME_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fPlayerDeathReloadTime") )
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 120.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == KILLMOVE_CHANCE_SLIDER)
		SetSliderDialogStartValue( KillMoveRandom.GetValue() )
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == DECAPITATION_CHANCE_SLIDER)
		SetSliderDialogStartValue( DecapitationChance.GetValue() )
		SetSliderDialogDefaultValue(40.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == SPRINT_DRAINBASE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSprintStaminaDrainMult") )
		SetSliderDialogDefaultValue(7.0)
		SetSliderDialogRange(0.0, 50.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == SPRINT_DRAINMULT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSprintStaminaWeightMult") )
		SetSliderDialogDefaultValue(0.02)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == ARROW_RECOVERY_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iArrowInventoryChance") )
		SetSliderDialogDefaultValue(33)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == DEATH_DROPCHANCE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iDeathDropWeaponChance") )
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == CAMERA_SHAKETIME_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fCameraShakeTime") )
		SetSliderDialogDefaultValue(1.25)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == FASTRAVEL_SPEED_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fFastTravelSpeedMult") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == HUDCOMPASS_DISTANEC_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fHUDCompassLocationMaxDist") )
		SetSliderDialogDefaultValue(20000.0)
		SetSliderDialogRange(0.0, 100000.0)
		SetSliderDialogInterval(100)
	ELSEIF ( option == ATTACHED_ARROWS_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iMaxAttachedArrows") )
		SetSliderDialogDefaultValue(3)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == LightRadius_OID)
		SetSliderDialogStartValue( GetLightRadius(Torch01) )
		SetSliderDialogDefaultValue(512.0)
		SetSliderDialogRange(1, 10000)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == LightDuration_OID)
		SetSliderDialogStartValue( GetLightDuration(Torch01) )
		SetSliderDialogDefaultValue(240.0)
		SetSliderDialogRange(1, 10000)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == SPECIAL_LOOT_SLIDER)
		SetSliderDialogStartValue(SpecialLootChance.GetValueInt() )
		SetSliderDialogDefaultValue(90)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == FRIENDHIT_TIMER_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fFriendHitTimer") )
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 60.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == FRIENDHIT_INTERVAL_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fFriendMinimumLastHitTime") )
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == FRIENDHIT_COMBAT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iFriendHitCombatAllowed") )
		SetSliderDialogDefaultValue(3)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == FRIENDHIT_NONCOMBAT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iFriendHitNonCombatAllowed") )
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == ALLYHIT_COMBAT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iAllyHitCombatAllowed") )
		SetSliderDialogDefaultValue(1000)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	ELSEIF ( option == ALLYHIT_NONCOMBAT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iAllyHitNonCombatAllowed") )
		SetSliderDialogDefaultValue(3)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == COMBAT_DODGECHANCE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fCombatDodgeChanceMax") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == COMBAT_AIMOFFSET_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fCombatAimProjectileRandomOffset") )
		SetSliderDialogDefaultValue(16.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == COMBAT_FLEEHEALTH_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fAIFleeHealthMult") )
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == DIALOGUE_PADDING_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fGameplayVoiceFilePadding") )
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.0, 3.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == DIALOGUE_DISTANCE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fAIMinGreetingDistance") )
		SetSliderDialogDefaultValue(150.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == FOLLOWER_SPACING_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fFollowSpaceBetweenFollowers") )
		SetSliderDialogDefaultValue(192.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == FOLLOWER_CATCHUP_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fFollowExtraCatchUpSpeedMult") )
		SetSliderDialogDefaultValue(0.2)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == LEVELSCALING_MULT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fLevelScalingMult") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == LEVELEDACTOR_EASY_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fLeveledActorMultEasy") )
		SetSliderDialogDefaultValue(0.33)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == LEVELEDACTOR_HARD_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fLeveledActorMultHard") )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == LEVELEDACTOR_MEDIUM_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fLeveledActorMultMedium") )
		SetSliderDialogDefaultValue(0.67)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == LEVELEDACTOR_VHARD_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fLeveledActorMultVeryHard") )
		SetSliderDialogDefaultValue(1.25)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == RESPAWN_TIME_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iHoursToRespawnCell") )
		SetSliderDialogDefaultValue(240)
		SetSliderDialogRange(0, 3000)
		SetSliderDialogInterval(10)
	ELSEIF ( option == NPC_HEALTHBONUS_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fNPCHealthLevelBonus") )
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 10000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == LEVELUP_ATTRIBUTE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingInt("iAVDhmsLevelup") )
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	ELSEIF ( option == LEVELUP_CARRYWEIGHT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fLevelUpCarryWeightMod") )
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == LEGENDARYRESET_LEVEL_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fLegendarySkillResetValue") )
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == LEVELUP_POWER_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fSkillUseCurve") )
		SetSliderDialogDefaultValue(1.95)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == LEVELUP_BASE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fXPLevelUpBase") )
		SetSliderDialogDefaultValue(75.0)
		SetSliderDialogRange(0.0, 500.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == LEVELUP_MULT_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fXPLevelUpMult") )
		SetSliderDialogDefaultValue(25.0)
		SetSliderDialogRange(0.0, 250.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == SKILLUSE_ALCHEMY_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(16).GetSkillUseMult() )
		SetSliderDialogDefaultValue(0.75)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_ALTERATION_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(18).GetSkillUseMult() )
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_BLOCK_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(9).GetSkillUseMult() )
		SetSliderDialogDefaultValue(8.1)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_CONJURATION_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(19).GetSkillUseMult() )
		SetSliderDialogDefaultValue(2.1)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_DESTRUCTION_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(20).GetSkillUseMult() )
		SetSliderDialogDefaultValue(1.35)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_ENCHANTING_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(23).GetSkillUseMult() )
		SetSliderDialogDefaultValue(900.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_HEAVYARMOR_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(11).GetSkillUseMult() )
		SetSliderDialogDefaultValue(3.8)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_ILLUSION_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(21).GetSkillUseMult() )
		SetSliderDialogDefaultValue(4.6)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_LIGHTARMOR_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(12).GetSkillUseMult() )
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_LOCKPICKING_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(14).GetSkillUseMult() )
		SetSliderDialogDefaultValue(45.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_MARKSMAN_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(8).GetSkillUseMult() )
		SetSliderDialogDefaultValue(9.3)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_ONEHANDED_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(6).GetSkillUseMult() )
		SetSliderDialogDefaultValue(6.3)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_PICKPOCKET_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(13).GetSkillUseMult() )
		SetSliderDialogDefaultValue(8.1)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_RESTORATION_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(22).GetSkillUseMult() )
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_SMITHING_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(10).GetSkillUseMult() )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_SNEAK_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(15).GetSkillUseMult() )
		SetSliderDialogDefaultValue(11.25)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_SPEECHCRAFT_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(17).GetSkillUseMult() )
		SetSliderDialogDefaultValue(0.36)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == SKILLUSE_TWOHAND_SLIDER)
		SetSliderDialogStartValue( GetAVIByID(7).GetSkillUseMult() )
		SetSliderDialogDefaultValue(5.95)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == RFORCE_MIN_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDeathForceRangedForceMin") )
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == RFORCE_MAX_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDeathForceRangedForceMax") )
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == MFORCE_MIN_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDeathForceForceMin") )
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == MFORCE_MAX_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDeathForceForceMax") )
		SetSliderDialogDefaultValue(12.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == SFORCE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fDeathForceSpellImpactMult") )
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == GFORCE_SLIDER)
		SetSliderDialogStartValue( GetGameSettingFloat("fZKeyMaxForce") )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 10000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == FIRST_FOV_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fDefaultWorldFOV:Display") )
		SetSliderDialogDefaultValue(65.0)
		SetSliderDialogRange(0.0, 360.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == THIRD_FOV_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fDefault1stPersonFOV:Display") )
		SetSliderDialogDefaultValue(65.0)
		SetSliderDialogRange(0.0, 360.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == XSENSITIVITY_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fMouseHeadingXScale:Controls") )
		SetSliderDialogDefaultValue(0.02)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.001)
	ELSEIF ( option == YSENSITIVITY_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fMouseHeadingYScale:Controls") )
		SetSliderDialogDefaultValue(0.85)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.001)
	ELSEIF ( option == COMBAT_SHOULDERY_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fOverShoulderCombatAddY:Camera") )
		SetSliderDialogDefaultValue(-100.0)
		SetSliderDialogRange(-1000.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == COMBAT_SHOULDERZ_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fOverShoulderCombatPosZ:Camera") )
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(-1000.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == COMBAT_SHOULDERX_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fOverShoulderCombatPosX:Camera") )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-1000.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == SHOULDERZ_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fOverShoulderPosZ:Camera") )
		SetSliderDialogDefaultValue(-10.0)
		SetSliderDialogRange(-1000.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == SHOULDERX_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fOverShoulderPosX:Camera") )
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(-1000.0, 1000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == AUTOSAVE_COUNT_SLIDER)
		SetSliderDialogStartValue( GetINIInt("iAutoSaveCount:SaveGame") )
		SetSliderDialogDefaultValue(3)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == HAVOK_HIT_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fHavokHitImpulseMult:Animation") )
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 500.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == BOOK_SPEED_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fBookOpenTime:Interface") )
		SetSliderDialogDefaultValue(1000.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(10)
	ELSEIF ( option == FIRST_ARROWTILT_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("f1PArrowTiltUpAngle:Combat") )
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(-10.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == THIRD_ARROWTILT_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("f3PArrowTiltUpAngle:Combat") )
		SetSliderDialogDefaultValue(2.5)
		SetSliderDialogRange(-10.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == FIRST_BOLTTILT_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("f1PBoltTiltUpAngle:Combat") )
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(-10.0, 10.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == NAVMESH_DISTANCE_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fVisibleNavmeshMoveDist:Actor") )
		SetSliderDialogDefaultValue(4096.0)
		SetSliderDialogRange(0.0, 20000.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == FRICTION_LAND_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fLandFriction:Landscape") )
		SetSliderDialogDefaultValue(2.5)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == CONSOLE_TEXT_SLIDER)
		SetSliderDialogStartValue( GetINIInt("iConsoleTextSize:Menu") )
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == CONSOLE_PERCENT_SLIDER)
		SetSliderDialogStartValue( GetINIInt("iConsoleSizeScreenPercent:Menu") )
		SetSliderDialogDefaultValue(40)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == MAP_YAW_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fMapWorldYawRange:MapMenu") )
		SetSliderDialogDefaultValue(80.0)
		SetSliderDialogRange(0.0, 360.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == MAP_PITCH_SLIDER)
		SetSliderDialogStartValue( GetINIFloat("fMapWorldMaxPitch:MapMenu") )
		SetSliderDialogDefaultValue(75.0)
		SetSliderDialogRange(0.0, 360.0)
		SetSliderDialogInterval(1)
	ELSEIF ( option == LEGENDARY_BONUS_SLIDER)
		SetSliderDialogStartValue( GBT_legendaryBonus_Float )
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == ARROW_FAMINE_SLIDER)
		SetSliderDialogStartValue( GBT_arrowFamine_Float )
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(2.0, 10.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == SNEAK_FATIGUE_SLIDER)
		SetSliderDialogStartValue( GBT_sneakFatigue_Float )
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == TIMEDBLOCK_WEAPON_SLIDER)
		SetSliderDialogStartValue( GBT_timeBlockWeapon_Float )
		SetSliderDialogDefaultValue(0.3)
		SetSliderDialogRange(0.01, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == TIMEDBLOCK_SHIELD_SLIDER)
		SetSliderDialogStartValue( GBT_timeBlockShield_Float )
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.01, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == TIMEDBLOCK_REFLECTTIME_SLIDER)
		SetSliderDialogStartValue( GBT_timeBlockReflect_Float )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == TIMEDBLOCK_REFLECTWARD_SLIDER)
		SetSliderDialogStartValue( GBT_timeBlockWard_Float )
		SetSliderDialogDefaultValue(0.3)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == TIMEDBLOCK_REFLECTDMG_SLIDER)
		SetSliderDialogStartValue( GBT_timeBlockDamage_Float )
		SetSliderDialogDefaultValue(40.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == TIMEDBLOCK_EXP_SLIDER)
		SetSliderDialogStartValue( GBT_timeBlockXP_Float )
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == ITEMLIMITER_LOCKPICK_SLIDER)
		SetSliderDialogStartValue(GBT_limitLockpick_Int)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	ELSEIF ( option == ITEMLIMITER_ARROW_SLIDER)
		SetSliderDialogStartValue(GBT_limitArrow_Int)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	ELSEIF ( option == ITEMLIMITER_POTION_SLIDER)
		SetSliderDialogStartValue(GBT_limitPotion_Int)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	ELSEIF ( option == ITEMLIMITER_POISON_SLIDER)
		SetSliderDialogStartValue(GBT_limitPoison_Int)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	ELSEIF ( option == PLAYERSTAGGER_BASEDUR_SLIDER)
		SetSliderDialogStartValue( GBT_staggerTaken_Float )
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.01, 2.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == PLAYERSTAGGER_IMMUNITY_SLIDER)
		SetSliderDialogStartValue( GBT_staggerImmunity_Float )
		SetSliderDialogDefaultValue(0.5)
		SetSliderDialogRange(0.01, 2.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == PLAYERSTAGGER_ARMORWEIGHT_SLIDER)
		SetSliderDialogStartValue( GBT_staggerArmor_Float )
		SetSliderDialogDefaultValue(35.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == PLAYERSTAGGER_MAGICKACOST_SLIDER)
		SetSliderDialogStartValue( GBT_staggerMagicka_Float )
		SetSliderDialogDefaultValue(200.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == PLAYERSTAGGER_MINTHRESH_SLIDER)
		SetSliderDialogStartValue( GBT_staggerMin_Float )
		SetSliderDialogDefaultValue(0.25)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == PLAYERSTAGGER_MAXTHRESH_SLIDER)
		SetSliderDialogStartValue( GBT_staggerMax_Float )
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
	ELSEIF ( option == NPCSTAGGER_MULT_SLIDER)
		SetSliderDialogStartValue( GBT_MeleeStaggerMult_Float )
		SetSliderDialogDefaultValue(0.35)
		SetSliderDialogRange(0.0, 2.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == NPCSTAGGER_BASE_SLIDER)
		SetSliderDialogStartValue( GBT_MeleeStaggerBase_Float )
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == NPCSTAGGER_ARMORWEIGHT_SLIDER)
		SetSliderDialogStartValue( GBT_MeleeStaggerWeight_Float )
		SetSliderDialogDefaultValue(35.0)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == NPCSTAGGER_IMMUNITY_SLIDER)
		SetSliderDialogStartValue( GBT_MeleeStaggerCD_Float )
		SetSliderDialogDefaultValue(3.5)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == BLEEDOUT_LOSSBASE_SLIDER)
		SetSliderDialogStartValue( GBT_bleedoutBase_Float )
		SetSliderDialogDefaultValue(0.25)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.01)
	ELSEIF ( option == BLEEDOUT_LOSSMULT_SLIDER)
		SetSliderDialogStartValue(GBT_bleedoutMult_Int)
		SetSliderDialogDefaultValue(75)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	ELSEIF ( option == BLEEDOUT_MAXLIVES_SLIDER)
		SetSliderDialogStartValue(GBT_bleedoutLivesMax_Int)
		SetSliderDialogDefaultValue(3)
		SetSliderDialogRange(0, 1000)
		SetSliderDialogInterval(1)
	ELSEIF ( option == ARMOR_CMBEXP_SLIDER)
		SetSliderDialogStartValue( GBT_ArmorExp_Float )
		SetSliderDialogDefaultValue(25.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == BLOCK_CMBEXP_SLIDER)
		SetSliderDialogStartValue( GBT_BlockExp_Float )
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	ELSEIF ( option == FISSFILENAME_OID)
	ELSEIF ( option == SAVELOCAL_OID)
	ENDIF
ENDEVENT


EVENT OnOptionInputOpen(int option)
	IF ( option == SHOUT_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_shoutScale.GetNthEntryValue(0, 1) * 100) + 0 )
	ELSEIF ( option == TRAP_MAGNITUDE_SLIDER)
		SetInputDialogStartText( (GBT_trapMagnitude.GetNthEntryValue(0, 0) * 100) + 0 )
	ELSEIF ( option == WEREDMG_DEALT_SLIDER)
		SetInputDialogStartText( (GBT_WerewolfDamageDealt.GetNthEntryValue(0, 0) * 100) + 0 )
	ELSEIF ( option == WEREDMG_TAKEN_SLIDER)
		SetInputDialogStartText( (GBT_WerewolfDamageTaken.GetNthEntryValue(0, 0) * 100) + 0 )
	ELSEIF ( option == POISON_DOSE_SLIDER)
		SetInputDialogStartText( (GBT_poisonDose.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == DUALCAST_POWER_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fMagicDualCastingEffectivenessBase") + "" )
	ELSEIF ( option == DUALCAST_COST_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fMagicDualCastingCostMult") + "" )
	ELSEIF ( option == MAGICCOST_SCALE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fMagicCasterPCSkillCostBase") + "" )
	ELSEIF ( option == MAGIC_COST_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fMagicCasterPCSkillCostMult") + "" )
	ELSEIF ( option == NPCMAGICCOST_SCALE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fMagicCasterSkillCostBase") + "" )
	ELSEIF ( option == NPCMAGIC_COST_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fMagicCasterSkillCostMult") + "" )
	ELSEIF ( option == MAX_RUNES_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iMaxPlayerRunes") )
	ELSEIF ( option == MAX_SUMMONED_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iMaxSummonedCreatures") )
	ELSEIF ( option == TELEKIN_DAMAGE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fMagicTelekinesisDamageBase") + "" )
	ELSEIF ( option == TELEKIN_DUALMULT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fMagicTelekinesisDualCastDamageMult") + "" )
	ELSEIF ( option == ALTMAG_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_altScaleMag.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == CONJMAG_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_conjScaleMag.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == ALTDURNOTPARA_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_altScaleDurNotPara.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == CONJDUR_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_conjScaleDur.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == ALTCOST_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_altScaleCost.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == CONJCOST_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_conjScaleCost.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == ALTDURPARA_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_altScaleDurPara.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == BOUNTMELEE_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_conjScaleBoundMelee.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == ALTCOSTDET_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_altScaleCostDet.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == BOUNDBOW_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_conjScaleBoundBow.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == DESMAG_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_desScaleMag.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == HEALMAG_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_restScaleMagHeal.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == DESDUR_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_desScaleDur.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == HEALDUR_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_restScaleDurHeal.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == DESCOST_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_desScaleCost.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == HEALCOST_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_restScaleCostHeal.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == ILLMAG_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_illScaleMag.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == NONHEALMAG_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_nonHealScaleMag.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == ILLDUR_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_illScaleDur.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == NONHEALDUR_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_nonHealScaleDur.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == ILLCOST_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_illScaleCost.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == NONHEALCOST_SCALE_SLIDER)
		SetInputDialogStartText( (GBT_nonHealScaleCost.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == LESSERPOWER_COOLDOWN_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fMagicLesserPowerCooldownTimer") + "" )
	ELSEIF ( option == DAMAGEDEALTSCALE_OID)
		SetInputDialogStartText( scaleDamageDealt_VAR )
	ELSEIF ( option == DAMAGETAKENSCALE_OID)
		SetInputDialogStartText( scaleDamageTaken_VAR )
	ELSEIF ( option == DAMAGEDEALT_NOVICE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDiffMultHPByPCVE") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
	ELSEIF ( option == DAMAGETAKEN_NOVICE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDiffMultHPToPCVE") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
	ELSEIF ( option == DAMAGEDEALT_APPRENTICE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDiffMultHPByPCE") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
	ELSEIF ( option == DAMAGETAKEN_APPRENTICE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDiffMultHPToPCE") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
	ELSEIF ( option == DAMAGEDEALT_ADEPT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDiffMultHPByPCN") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
	ELSEIF ( option == DAMAGETAKEN_ADEPT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDiffMultHPToPCN") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
	ELSEIF ( option == DAMAGEDEALT_EXPERT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDiffMultHPByPCH") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
	ELSEIF ( option == DAMAGETAKEN_EXPERT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDiffMultHPToPCH") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
	ELSEIF ( option == DAMAGEDEALT_MASTER_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDiffMultHPByPCVH") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
	ELSEIF ( option == DAMAGETAKEN_MASTER_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDiffMultHPToPCVH") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
	ELSEIF ( option == DAMAGEDEALT_LEGENDARY_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDiffMultHPByPCL") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
	ELSEIF ( option == DAMAGETAKEN_LEGENDARY_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDiffMultHPToPCL") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
	ELSEIF ( option == WEAPONSCALE_PCMIN_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDamagePCSkillMin") + "" )
	ELSEIF ( option == WEAPONSCALE_PCMAX_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDamagePCSkillMax") + "" )
	ELSEIF ( option == WEAPONSCALE_NPCMIN_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDamageSkillMin") + "" )
	ELSEIF ( option == WEAPONSCALE_NPCMAX_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDamageSkillMax") + "" )
	ELSEIF ( option == ARMOR_SCALE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fArmorScalingFactor") + "%" )
	ELSEIF ( option == MAX_RESISTANCE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fPlayerMaxResistance") + "%" )
	ELSEIF ( option == ARMOR_BASERESIST_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fArmorBaseFactor") + "" )
	ELSEIF ( option == ARMOR_MAXRESIST_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fMaxArmorRating") + "%" )
	ELSEIF ( option == PC_ARMORRATING_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fArmorRatingPCMax") + "" )
	ELSEIF ( option == NPC_ARMORRATING_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fArmorRatingMax") + "" )
	ELSEIF ( option == ENCUM_EFFECT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fMoveEncumEffect") + "" )
	ELSEIF ( option == ENCUMWEAP_EFFECT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fMoveEncumEffectNoWeapon") + "" )
	ELSEIF ( option == WEAPONDAMAGE_MULT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDamageWeaponMult") + "" )
	ELSEIF ( option == TWOHAND_ATKSPD_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fWeaponTwoHandedAnimationSpeedMult") + "" )
	ELSEIF ( option == AUTOAIM_AREA_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fAutoAimScreenPercentage") + "" )
	ELSEIF ( option == AUTOAIM_RANGE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fAutoAimMaxDistance") + "" )
	ELSEIF ( option == AUTOAIM_DEGREES_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fAutoAimMaxDegrees") + "" )
	ELSEIF ( option == AUTOAIM_DEGREESTHIRD_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fAutoAimMaxDegrees3rdPerson") + "" )
	ELSEIF ( option == STAMINA_POWERCOST_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fPowerAttackStaminaPenalty") + "" )
	ELSEIF ( option == STAMINA_BLOCKCOSTMULT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fStaminaBlockDmgMult") + "" )
	ELSEIF ( option == STAMINA_BASHCOST_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fStaminaBashBase") + "" )
	ELSEIF ( option == STAMINA_POWERBASHCOST_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fStaminaPowerBashBase") + "" )
	ELSEIF ( option == STAMINA_BLOCKCOSTBASE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fStaminaBlockBase") + "" )
	ELSEIF ( option == BLOCK_SHIELD_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fShieldBaseFactor") + "" )
	ELSEIF ( option == BLOCK_WEAPON_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fBlockWeaponBase") + "" )
	ELSEIF ( option == WEAPON_REACH_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fCombatDistance") + "" )
	ELSEIF ( option == BASH_REACH_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fCombatBashReach") + "" )
	ELSEIF ( option == AISEARCH_TIME_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fCombatStealthPointRegenAttackedWaitTime") + " Sec" )
	ELSEIF ( option == AISEARCH_TIMEATTACKED_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fCombatStealthPointRegenDetectedEventWaitTime") + " Sec" )
	ELSEIF ( option == SNEAKLEVEL_BASE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fPlayerDetectionSneakBase") + "" )
	ELSEIF ( option == SNEAKDETECTION_SCALE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fPlayerDetectionSneakMult") + "" )
	ELSEIF ( option == DETECTION_FOV_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDetectionViewCone") + " Deg" )
	ELSEIF ( option == SNEAK_BASE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSneakBaseValue") + "" )
	ELSEIF ( option == DETECTION_LIGHT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDetectionSneakLightMod") + "" )
	ELSEIF ( option == DETECTION_LIGHTEXT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSneakLightExteriorMult") + "" )
	ELSEIF ( option == DETECTION_SOUND_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSneakSoundsMult") + "" )
	ELSEIF ( option == DETECTION_SOUNDLOS_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSneakSoundLosMult") + "" )
	ELSEIF ( option == PICKPOCKET_MAXCHANCE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fPickPocketMaxChance") + "%" )
	ELSEIF ( option == PICKPOCKET_MINCHANCE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fPickPocketMinChance") + "%" )
	ELSEIF ( option == SNEAKMULT_MARKSMAN_SLIDER)
		SetInputDialogStartText( (GBT_SneakMarks.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == SNEAKMULT_DAGGER_SLIDER)
		SetInputDialogStartText( (GBT_SneakDagger.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == SNEAKMULT_TWOHAND_SLIDER)
		SetInputDialogStartText( (GBT_SneakOne.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == SNEAKMULT_ONEHAND_SLIDER)
		SetInputDialogStartText( (GBT_SneakTwo.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == SNEAKMULT_UNARMED_SLIDER)
		SetInputDialogStartText( (GBT_SneakH2H.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == SNEAKMULT_RUNE_SLIDER)
		SetInputDialogStartText( (GBT_SneakRuneMag.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == SNEAKMULT_SEARCH_SLIDER)
		SetInputDialogStartText( (GBT_SneakSearch.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == SNEAKMULT_SPELLMAG_SLIDER)
		SetInputDialogStartText( (GBT_SneakSpellMag.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == SNEAKMULT_SPELLSEARCH_SLIDER)
		SetInputDialogStartText( (GBT_SneakSpellSearch.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == SNEAKMULT_SPELLDUR_SLIDER)
		SetInputDialogStartText( (GBT_SneakSpellDur.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == SNEAKSCALE_PHYSICAL_SLIDER)
		SetInputDialogStartText( (GBT_SneakScalePhys.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == SNEAKSCALE_SPELLMAG_SLIDER)
		SetInputDialogStartText( (GBT_SneakScaleSpell.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == SNEAKMULT_POISONMAG_SLIDER)
		SetInputDialogStartText( (GBT_SneakPoisonMag.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == SNEAKMULT_POISONDUR_SLIDER)
		SetInputDialogStartText( (GBT_SneakPoisonDur.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == SNEAKSCALE_POISONMAG_SLIDER)
		SetInputDialogStartText( (GBT_SneakScalePoisonMag.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == SNEAKSCALE_POISONDUR_SLIDER)
		SetInputDialogStartText( (GBT_SneakScalePoisonDur.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == LOCKPICK_VEASY_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSweetSpotVeryEasy") + "" )
	ELSEIF ( option == LOCKPICKDUR_VEASY_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fLockpickBreakNovice") + "" )
	ELSEIF ( option == LOCKPICK_EASY_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSweetSpotEasy") + "" )
	ELSEIF ( option == LOCKPICKDUR_EASY_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fLockpickBreakApprentice") + "" )
	ELSEIF ( option == LOCKPICK_AVERAGE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSweetSpotAverage") + "" )
	ELSEIF ( option == LOCKPICKDUR_AVERAGE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fLockpickBreakAdept") + "" )
	ELSEIF ( option == LOCKPICK_HARD_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSweetSpotHard") + "" )
	ELSEIF ( option == LOCKPICKDUR_HARD_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fLockpickBreakExpert") + "" )
	ELSEIF ( option == LOCKPICK_VHARD_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSweetSpotVeryHard") + "" )
	ELSEIF ( option == LOCKPICKDUR_VHARD_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fLockpickBreakMaster") + "" )
	ELSEIF ( option == ALCHEMYMAG_MULT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fAlchemyIngredientInitMult") + "" )
	ELSEIF ( option == ALCHEMYMAG_SCALE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fAlchemySkillFactor") + "" )
	ELSEIF ( option == BONUS_INGR_SLIDER)
		SetInputDialogStartText( (GBT_bonusIngredients.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == BONUS_POTION_SLIDER)
		SetInputDialogStartText( (GBT_bonusPotions.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == CHARGECOST_POWER_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fEnchantingCostExponent") + "" )
	ELSEIF ( option == ENCHANT_SCALING_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fEnchantingSkillFactor") + "" )
	ELSEIF ( option == CHARGECOST_MULT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fEnchantingSkillCostMult") + "" )
	ELSEIF ( option == ENCHANTPRICE_EFFECT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fEnchantmentEffectPointsMult") + "" )
	ELSEIF ( option == CHARGECOST_BASE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fEnchantingSkillCostBase") + "" )
	ELSEIF ( option == ENCHANTPRICE_SOUL_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fEnchantmentPointsMult") + "" )
	ELSEIF ( option == ENCHANT_CHARGE_SLIDER)
		SetInputDialogStartText( (GBT_enchantCharge.GetNthEntryValue(0, 0) * 100) + 0 )
	ELSEIF ( option == ENCHANT_MAG_SLIDER)
		SetInputDialogStartText( (GBT_enchantMag.GetNthEntryValue(0, 0) * 100) + 0 )
	ELSEIF ( option == BONUS_ENCHANT_SLIDER)
		SetInputDialogStartText( (GBT_bonusEnchants.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == TEMPER_SUFFIX_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSmithingConditionFactor") + "" )
	ELSEIF ( option == TEMPER_ARMOR_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSmithingArmorMax") + "" )
	ELSEIF ( option == TEMPER_WEAPON_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSmithingWeaponMax") + "" )
	ELSEIF ( option == POTION_MAG_SLIDER)
		SetInputDialogStartText( (GBT_PotionMag.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == POTION_DUR_SLIDER)
		SetInputDialogStartText( (GBT_PotionDur.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == POTION_SCALEMAG_SLIDER)
		SetInputDialogStartText( (GBT_PotionScaleMag.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == POTION_SCALEDUR_SLIDER)
		SetInputDialogStartText( (GBT_PotionScaleDur.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == POISON_MAG_SLIDER)
		SetInputDialogStartText( (GBT_PoisonMag.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == POISON_DUR_SLIDER)
		SetInputDialogStartText( (GBT_PoisonDur.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == POISON_SCALEMAG_SLIDER)
		SetInputDialogStartText( (GBT_PoisonScaleMag.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == POISON_SCALEDUR_SLIDER)
		SetInputDialogStartText( (GBT_PoisonScaleDur.GetNthEntryValue(0, 1) * 10000) + 100 )
	ELSEIF ( option == SCROLL_MAG_SLIDER)
		SetInputDialogStartText( (GBT_ScrollMag.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == SCROLL_DUR_SLIDER)
		SetInputDialogStartText( (GBT_ScrollDur.GetNthEntryValue(0, 0) * 1) + 0 )
	ELSEIF ( option == BARTER_BUYMIN_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fBarterBuyMin") + "" )
	ELSEIF ( option == BARTER_SELLMAX_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fBarterSellMax") + "" )
	ELSEIF ( option == BARTER_MIN_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fBarterMin") + "" )
	ELSEIF ( option == BARTER_MAX_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fBarterMax") + "" )
	ELSEIF ( option == BUY_PRICE_SLIDER)
		SetInputDialogStartText( (GBT_buyPrice.GetNthEntryValue(0, 0) * 100) + 0 )
	ELSEIF ( option == SELL_PRICE_SLIDER)
		SetInputDialogStartText( (GBT_sellPrice.GetNthEntryValue(0, 0) * 100) + 0 )
	ELSEIF ( option == VENDOR_RESPAWN_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iDaysToRespawnVendor") )
	ELSEIF ( option == TRAINING_NUMALLOWED_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iTrainingNumAllowedPerLevel") )
	ELSEIF ( option == TRAINING_JOURNEYMANCOST_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iTrainingJourneymanCost") )
	ELSEIF ( option == TRAINING_JOURNEYMANSKILL_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iTrainingJourneymanSkill") )
	ELSEIF ( option == TRAINING_EXPERTCOST_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iTrainingExpertCost") )
	ELSEIF ( option == TRAINING_EXPERTSKILL_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iTrainingExpertSkill") )
	ELSEIF ( option == TRAINING_MASTERCOST_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iTrainingMasterCost") )
	ELSEIF ( option == TRAINING_MASTERSKILL_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iTrainingMasterSkill") )
	ELSEIF ( option == APOTHECARY_GOLD_SLIDER)
		SetInputDialogStartText( VendorGoldApothecary.GetNthCount(0) )
	ELSEIF ( option == BLACKSMITH_GOLD_SLIDER)
		SetInputDialogStartText( VendorGoldBlacksmith.GetNthCount(0) )
	ELSEIF ( option == ORCBLACKSMITH_GOLD_SLIDER)
		SetInputDialogStartText( VendorGoldBlacksmithOrc.GetNthCount(0) )
	ELSEIF ( option == TOWNBLACKSMITH_GOLD_SLIDER)
		SetInputDialogStartText( VendorGoldBlacksmithTown.GetNthCount(0) )
	ELSEIF ( option == INNKEERPER_GOLD_SLIDER)
		SetInputDialogStartText( VendorGoldInn.GetNthCount(0) )
	ELSEIF ( option == MISCMERCHANT_GOLD_SLIDER)
		SetInputDialogStartText( VendorGoldMisc.GetNthCount(0) )
	ELSEIF ( option == SPELLMERCHANT_GOLD_SLIDER)
		SetInputDialogStartText( VendorGoldSpells.GetNthCount(0) )
	ELSEIF ( option == STREETVENDOR_GOLD_SLIDER)
		SetInputDialogStartText( VendorGoldStreetVendor.GetNthCount(0) )
	ELSEIF ( option == COMBAT_STAMINAREGEN_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fCombatStaminaRegenRateMult") + "" )
	ELSEIF ( option == AV_COMBATHEALTHREGENMULT_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("CombatHealthRegenMult") )
	ELSEIF ( option == DAMAGESTAMINA_DELAY_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDamagedStaminaRegenDelay") + " sec" )
	ELSEIF ( option == BOWZOOM_REGENDELAY_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fBowZoomStaminaRegenDelay") + " sec" )
	ELSEIF ( option == COMBAT_MAGICKAREGEN_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fCombatMagickaRegenRateMult") + "" )
	ELSEIF ( option == STAMINA_REGENDELAY_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fStaminaRegenDelayMax") + " sec" )
	ELSEIF ( option == DAMAGEMAGICKA_DELAY_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDamagedMagickaRegenDelay") + " sec" )
	ELSEIF ( option == MAGICKA_REGENDELAY_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fMagickaRegenDelayMax") + " sec" )
	ELSEIF ( option == AV_HEALRATEMULT_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("HealRateMult") )
	ELSEIF ( option == AV_HEALRATE_SLIDER)
		SetInputDialogStartText( PlayerRef.GetBaseAV("HealRate") )
	ELSEIF ( option == AV_MAGICKARATEMULT_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("MagickaRateMult") )
	ELSEIF ( option == AV_MAGICKARATE_SLIDER)
		SetInputDialogStartText( PlayerRef.GetBaseAV("MagickaRate") )
	ELSEIF ( option == AV_STAMINARATEMULT_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("StaminaRateMult") )
	ELSEIF ( option == AV_STAMINARATE_SLIDER)
		SetInputDialogStartText( PlayerRef.GetBaseAV("StaminaRate") )
	ELSEIF ( option == AV_HEALTH_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("Health") )
	ELSEIF ( option == AV_MAGICKA_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("Magicka") )
	ELSEIF ( option == AV_STAMINA_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("Stamina") )
	ELSEIF ( option == AV_DRAGONSOULS_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("DragonSouls") )
	ELSEIF ( option == AV_SHOUTRECOVERYMULT_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("ShoutRecoveryMult") )
	ELSEIF ( option == AV_CARRYWEIGHT_SLIDER)
		SetInputDialogStartText( PlayerRef.GetBaseAV("CarryWeight") )
	ELSEIF ( option == AV_SPEEDMULT_SLIDER)
		SetInputDialogStartText( PlayerRef.GetBaseAV("SpeedMult") )
	ELSEIF ( option == AV_UNARMEDDAMAGE_SLIDER)
		SetInputDialogStartText( PlayerRef.GetBaseAV("UnarmedDamage") )
	ELSEIF ( option == AV_MASS_SLIDER)
		SetInputDialogStartText( PlayerRef.GetBaseAV("Mass") )
	ELSEIF ( option == AV_CRITCHANCE_SLIDER)
		SetInputDialogStartText( PlayerRef.GetBaseAV("CritChance") )
	ELSEIF ( option == AV_ALTERATIONPOWERMOD_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("AlterationPowerMod") )
	ELSEIF ( option == AV_CONJURATIONPOWERMOD_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("ConjurationPowerMod") )
	ELSEIF ( option == AV_DESTRUCTIONPOWERMOD_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("DestructionPowerMod") )
	ELSEIF ( option == AV_ILLUSIONPOWERMOD_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("IllusionPowerMod") )
	ELSEIF ( option == AV_RESTORATIONPOWERMOD_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("RestorationPowerMod") )
	ELSEIF ( option == AV_BOWSTAGGERBONUS_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("BowStaggerBonus") )
	ELSEIF ( option == AV_BOWSPEEDBONUSVAR_SLIDER)
		SetInputDialogStartText( PlayerRef.GetBaseAV("BowSpeedBonus") )
	ELSEIF ( option == AV_LEFTWEAPONSPEEDMULT_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("LeftWeaponSpeedMult") )
	ELSEIF ( option == AV_WEAPONSPEEDMULT_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("WeaponSpeedMult") )
	ELSEIF ( option == AV_MAGICRESIST_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("MagicResist") )
	ELSEIF ( option == AV_FIRERESIST_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("FireResist") )
	ELSEIF ( option == AV_POISONRESIST_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("PoisonResist") )
	ELSEIF ( option == AV_ELECTRICRESIST_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("ElectricResist") )
	ELSEIF ( option == AV_DISEASERESIST_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("DiseaseResist") )
	ELSEIF ( option == AV_FROSTRESIST_SLIDER)
		SetInputDialogStartText( PlayerRef.GetAV("FrostResist") )
	ELSEIF ( option == PERK_POINTS_SLIDER)
		SetInputDialogStartText( GetPerkPoints() )
	ELSEIF ( option == TIME_SCALE_SLIDER)
		SetInputDialogStartText(TimeScale.GetValueInt() )
	ELSEIF ( option == FALLHEIGHT_MINNPC_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fJumpFallHeightMinNPC") + "" )
	ELSEIF ( option == FALLHEIGHT_MIN_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fJumpFallHeightMin") + "" )
	ELSEIF ( option == FALLHEIGHT_MULTNPC_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fJumpFallHeightMultNPC") + "" )
	ELSEIF ( option == FALLHEIGHT_MULT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fJumpFallHeightMult") + "" )
	ELSEIF ( option == FALLHEIGHT_EXPNPC_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fJumpFallHeightExponentNPC") + "" )
	ELSEIF ( option == FALLHEIGHT_EXP_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fJumpFallHeightExponent") + "" )
	ELSEIF ( option == JUMP_HEIGHT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fJumpHeightMin") + "" )
	ELSEIF ( option == SWIM_BREATHBASE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fActorSwimBreathBase") + " sec" )
	ELSEIF ( option == SWIM_BREATHDAMAGE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fActorSwimBreathDamage") + "" )
	ELSEIF ( option == SWIM_BREATHMULT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fActorSwimBreathMult") + " min" )
	ELSEIF ( option == KILLCAM_CHANCE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fKillCamBaseOdds") + "" )
	ELSEIF ( option == DEATHCAMERA_TIME_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fPlayerDeathReloadTime") + " sec" )
	ELSEIF ( option == KILLMOVE_CHANCE_SLIDER)
		SetInputDialogStartText( KillMoveRandom.GetValue() )
	ELSEIF ( option == DECAPITATION_CHANCE_SLIDER)
		SetInputDialogStartText( DecapitationChance.GetValue() )
	ELSEIF ( option == SPRINT_DRAINBASE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSprintStaminaDrainMult") + "" )
	ELSEIF ( option == SPRINT_DRAINMULT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSprintStaminaWeightMult") + "" )
	ELSEIF ( option == ARROW_RECOVERY_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iArrowInventoryChance") )
	ELSEIF ( option == DEATH_DROPCHANCE_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iDeathDropWeaponChance") )
	ELSEIF ( option == CAMERA_SHAKETIME_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fCameraShakeTime") + "" )
	ELSEIF ( option == FASTRAVEL_SPEED_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fFastTravelSpeedMult") + "" )
	ELSEIF ( option == HUDCOMPASS_DISTANEC_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fHUDCompassLocationMaxDist") + "" )
	ELSEIF ( option == ATTACHED_ARROWS_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iMaxAttachedArrows") )
	ELSEIF ( option == LightRadius_OID)
		SetInputDialogStartText( GetLightRadius(Torch01) )
	ELSEIF ( option == LightDuration_OID)
		SetInputDialogStartText( GetLightDuration(Torch01) )
	ELSEIF ( option == SPECIAL_LOOT_SLIDER)
		SetInputDialogStartText(SpecialLootChance.GetValueInt() )
	ELSEIF ( option == FRIENDHIT_TIMER_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fFriendHitTimer") + " sec" )
	ELSEIF ( option == FRIENDHIT_INTERVAL_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fFriendMinimumLastHitTime") + " sec" )
	ELSEIF ( option == FRIENDHIT_COMBAT_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iFriendHitCombatAllowed") )
	ELSEIF ( option == FRIENDHIT_NONCOMBAT_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iFriendHitNonCombatAllowed") )
	ELSEIF ( option == ALLYHIT_COMBAT_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iAllyHitCombatAllowed") )
	ELSEIF ( option == ALLYHIT_NONCOMBAT_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iAllyHitNonCombatAllowed") )
	ELSEIF ( option == COMBAT_DODGECHANCE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fCombatDodgeChanceMax") + "" )
	ELSEIF ( option == COMBAT_AIMOFFSET_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fCombatAimProjectileRandomOffset") + "" )
	ELSEIF ( option == COMBAT_FLEEHEALTH_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fAIFleeHealthMult") + "%" )
	ELSEIF ( option == DIALOGUE_PADDING_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fGameplayVoiceFilePadding") + " sec" )
	ELSEIF ( option == DIALOGUE_DISTANCE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fAIMinGreetingDistance") + "" )
	ELSEIF ( option == FOLLOWER_SPACING_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fFollowSpaceBetweenFollowers") + "" )
	ELSEIF ( option == FOLLOWER_CATCHUP_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fFollowExtraCatchUpSpeedMult") + "" )
	ELSEIF ( option == LEVELSCALING_MULT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fLevelScalingMult") + "" )
	ELSEIF ( option == LEVELEDACTOR_EASY_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fLeveledActorMultEasy") + "" )
	ELSEIF ( option == LEVELEDACTOR_HARD_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fLeveledActorMultHard") + "" )
	ELSEIF ( option == LEVELEDACTOR_MEDIUM_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fLeveledActorMultMedium") + "" )
	ELSEIF ( option == LEVELEDACTOR_VHARD_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fLeveledActorMultVeryHard") + "" )
	ELSEIF ( option == RESPAWN_TIME_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iHoursToRespawnCell") )
	ELSEIF ( option == NPC_HEALTHBONUS_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fNPCHealthLevelBonus") + "" )
	ELSEIF ( option == LEVELUP_ATTRIBUTE_SLIDER)
		SetInputDialogStartText( GetGameSettingInt("iAVDhmsLevelup") )
	ELSEIF ( option == LEVELUP_CARRYWEIGHT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fLevelUpCarryWeightMod") + "" )
	ELSEIF ( option == LEGENDARYRESET_LEVEL_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fLegendarySkillResetValue") + "" )
	ELSEIF ( option == LEVELUP_POWER_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fSkillUseCurve") + "" )
	ELSEIF ( option == LEVELUP_BASE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fXPLevelUpBase") + "" )
	ELSEIF ( option == LEVELUP_MULT_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fXPLevelUpMult") + "" )
	ELSEIF ( option == SKILLUSE_ALCHEMY_SLIDER)
		SetInputDialogStartText( GetAVIByID(16).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_ALTERATION_SLIDER)
		SetInputDialogStartText( GetAVIByID(18).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_BLOCK_SLIDER)
		SetInputDialogStartText( GetAVIByID(9).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_CONJURATION_SLIDER)
		SetInputDialogStartText( GetAVIByID(19).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_DESTRUCTION_SLIDER)
		SetInputDialogStartText( GetAVIByID(20).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_ENCHANTING_SLIDER)
		SetInputDialogStartText( GetAVIByID(23).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_HEAVYARMOR_SLIDER)
		SetInputDialogStartText( GetAVIByID(11).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_ILLUSION_SLIDER)
		SetInputDialogStartText( GetAVIByID(21).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_LIGHTARMOR_SLIDER)
		SetInputDialogStartText( GetAVIByID(12).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_LOCKPICKING_SLIDER)
		SetInputDialogStartText( GetAVIByID(14).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_MARKSMAN_SLIDER)
		SetInputDialogStartText( GetAVIByID(8).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_ONEHANDED_SLIDER)
		SetInputDialogStartText( GetAVIByID(6).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_PICKPOCKET_SLIDER)
		SetInputDialogStartText( GetAVIByID(13).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_RESTORATION_SLIDER)
		SetInputDialogStartText( GetAVIByID(22).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_SMITHING_SLIDER)
		SetInputDialogStartText( GetAVIByID(10).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_SNEAK_SLIDER)
		SetInputDialogStartText( GetAVIByID(15).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_SPEECHCRAFT_SLIDER)
		SetInputDialogStartText( GetAVIByID(17).GetSkillUseMult() )
	ELSEIF ( option == SKILLUSE_TWOHAND_SLIDER)
		SetInputDialogStartText( GetAVIByID(7).GetSkillUseMult() )
	ELSEIF ( option == RFORCE_MIN_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDeathForceRangedForceMin") + "" )
	ELSEIF ( option == RFORCE_MAX_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDeathForceRangedForceMax") + "" )
	ELSEIF ( option == MFORCE_MIN_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDeathForceForceMin") + "" )
	ELSEIF ( option == MFORCE_MAX_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDeathForceForceMax") + "" )
	ELSEIF ( option == SFORCE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fDeathForceSpellImpactMult") + "" )
	ELSEIF ( option == GFORCE_SLIDER)
		SetInputDialogStartText( GetGameSettingFloat("fZKeyMaxForce") + "" )
	ELSEIF ( option == FIRST_FOV_SLIDER)
		SetInputDialogStartText( GetINIFloat("fDefaultWorldFOV:Display") )
	ELSEIF ( option == THIRD_FOV_SLIDER)
		SetInputDialogStartText( GetINIFloat("fDefault1stPersonFOV:Display") )
	ELSEIF ( option == XSENSITIVITY_SLIDER)
		SetInputDialogStartText( GetINIFloat("fMouseHeadingXScale:Controls") )
	ELSEIF ( option == YSENSITIVITY_SLIDER)
		SetInputDialogStartText( GetINIFloat("fMouseHeadingYScale:Controls") )
	ELSEIF ( option == COMBAT_SHOULDERY_SLIDER)
		SetInputDialogStartText( GetINIFloat("fOverShoulderCombatAddY:Camera") )
	ELSEIF ( option == COMBAT_SHOULDERZ_SLIDER)
		SetInputDialogStartText( GetINIFloat("fOverShoulderCombatPosZ:Camera") )
	ELSEIF ( option == COMBAT_SHOULDERX_SLIDER)
		SetInputDialogStartText( GetINIFloat("fOverShoulderCombatPosX:Camera") )
	ELSEIF ( option == SHOULDERZ_SLIDER)
		SetInputDialogStartText( GetINIFloat("fOverShoulderPosZ:Camera") )
	ELSEIF ( option == SHOULDERX_SLIDER)
		SetInputDialogStartText( GetINIFloat("fOverShoulderPosX:Camera") )
	ELSEIF ( option == AUTOSAVE_COUNT_SLIDER)
		SetInputDialogStartText( GetINIInt("iAutoSaveCount:SaveGame") )
	ELSEIF ( option == HAVOK_HIT_SLIDER)
		SetInputDialogStartText( GetINIFloat("fHavokHitImpulseMult:Animation") )
	ELSEIF ( option == BOOK_SPEED_SLIDER)
		SetInputDialogStartText( GetINIFloat("fBookOpenTime:Interface") )
	ELSEIF ( option == FIRST_ARROWTILT_SLIDER)
		SetInputDialogStartText( GetINIFloat("f1PArrowTiltUpAngle:Combat") )
	ELSEIF ( option == THIRD_ARROWTILT_SLIDER)
		SetInputDialogStartText( GetINIFloat("f3PArrowTiltUpAngle:Combat") )
	ELSEIF ( option == FIRST_BOLTTILT_SLIDER)
		SetInputDialogStartText( GetINIFloat("f1PBoltTiltUpAngle:Combat") )
	ELSEIF ( option == NAVMESH_DISTANCE_SLIDER)
		SetInputDialogStartText( GetINIFloat("fVisibleNavmeshMoveDist:Actor") )
	ELSEIF ( option == FRICTION_LAND_SLIDER)
		SetInputDialogStartText( GetINIFloat("fLandFriction:Landscape") )
	ELSEIF ( option == CONSOLE_TEXT_SLIDER)
		SetInputDialogStartText( GetINIInt("iConsoleTextSize:Menu") )
	ELSEIF ( option == CONSOLE_PERCENT_SLIDER)
		SetInputDialogStartText( GetINIInt("iConsoleSizeScreenPercent:Menu") )
	ELSEIF ( option == MAP_YAW_SLIDER)
		SetInputDialogStartText( GetINIFloat("fMapWorldYawRange:MapMenu") )
	ELSEIF ( option == MAP_PITCH_SLIDER)
		SetInputDialogStartText( GetINIFloat("fMapWorldMaxPitch:MapMenu") )
	ELSEIF ( option == LEGENDARY_BONUS_SLIDER)
		SetInputDialogStartText( GBT_legendaryBonus_Float )
	ELSEIF ( option == ARROW_FAMINE_SLIDER)
		SetInputDialogStartText( GBT_arrowFamine_Float )
	ELSEIF ( option == SNEAK_FATIGUE_SLIDER)
		SetInputDialogStartText( GBT_sneakFatigue_Float )
	ELSEIF ( option == TIMEDBLOCK_WEAPON_SLIDER)
		SetInputDialogStartText( GBT_timeBlockWeapon_Float )
	ELSEIF ( option == TIMEDBLOCK_SHIELD_SLIDER)
		SetInputDialogStartText( GBT_timeBlockShield_Float )
	ELSEIF ( option == TIMEDBLOCK_REFLECTTIME_SLIDER)
		SetInputDialogStartText( GBT_timeBlockReflect_Float )
	ELSEIF ( option == TIMEDBLOCK_REFLECTWARD_SLIDER)
		SetInputDialogStartText( GBT_timeBlockWard_Float )
	ELSEIF ( option == TIMEDBLOCK_REFLECTDMG_SLIDER)
		SetInputDialogStartText( GBT_timeBlockDamage_Float )
	ELSEIF ( option == TIMEDBLOCK_EXP_SLIDER)
		SetInputDialogStartText( GBT_timeBlockXP_Float )
	ELSEIF ( option == ITEMLIMITER_LOCKPICK_SLIDER)
		SetInputDialogStartText(GBT_limitLockpick_Int)
	ELSEIF ( option == ITEMLIMITER_ARROW_SLIDER)
		SetInputDialogStartText(GBT_limitArrow_Int)
	ELSEIF ( option == ITEMLIMITER_POTION_SLIDER)
		SetInputDialogStartText(GBT_limitPotion_Int)
	ELSEIF ( option == ITEMLIMITER_POISON_SLIDER)
		SetInputDialogStartText(GBT_limitPoison_Int)
	ELSEIF ( option == PLAYERSTAGGER_BASEDUR_SLIDER)
		SetInputDialogStartText( GBT_staggerTaken_Float )
	ELSEIF ( option == PLAYERSTAGGER_IMMUNITY_SLIDER)
		SetInputDialogStartText( GBT_staggerImmunity_Float )
	ELSEIF ( option == PLAYERSTAGGER_ARMORWEIGHT_SLIDER)
		SetInputDialogStartText( GBT_staggerArmor_Float )
	ELSEIF ( option == PLAYERSTAGGER_MAGICKACOST_SLIDER)
		SetInputDialogStartText( GBT_staggerMagicka_Float )
	ELSEIF ( option == PLAYERSTAGGER_MINTHRESH_SLIDER)
		SetInputDialogStartText( GBT_staggerMin_Float )
	ELSEIF ( option == PLAYERSTAGGER_MAXTHRESH_SLIDER)
		SetInputDialogStartText( GBT_staggerMax_Float )
	ELSEIF ( option == NPCSTAGGER_MULT_SLIDER)
		SetInputDialogStartText( GBT_MeleeStaggerMult_Float )
	ELSEIF ( option == NPCSTAGGER_BASE_SLIDER)
		SetInputDialogStartText( GBT_MeleeStaggerBase_Float )
	ELSEIF ( option == NPCSTAGGER_ARMORWEIGHT_SLIDER)
		SetInputDialogStartText( GBT_MeleeStaggerWeight_Float )
	ELSEIF ( option == NPCSTAGGER_IMMUNITY_SLIDER)
		SetInputDialogStartText( GBT_MeleeStaggerCD_Float )
	ELSEIF ( option == BLEEDOUT_LOSSBASE_SLIDER)
		SetInputDialogStartText( GBT_bleedoutBase_Float )
	ELSEIF ( option == BLEEDOUT_LOSSMULT_SLIDER)
		SetInputDialogStartText(GBT_bleedoutMult_Int)
	ELSEIF ( option == BLEEDOUT_MAXLIVES_SLIDER)
		SetInputDialogStartText(GBT_bleedoutLivesMax_Int)
	ELSEIF ( option == ARMOR_CMBEXP_SLIDER)
		SetInputDialogStartText( GBT_ArmorExp_Float )
	ELSEIF ( option == BLOCK_CMBEXP_SLIDER)
		SetInputDialogStartText( GBT_BlockExp_Float )
	ELSEIF ( option == FISSFILENAME_OID)
		SetInputDialogStartText( FissFilename )
	ELSEIF ( option == SAVELOCAL_OID)
		SetInputDialogStartText( "SkyTweakSave" )
	ENDIF
ENDEVENT


EVENT OnOptionSliderAccept(int option, float value)
	IF ( option == SHOUT_SCALE_SLIDER)
		GBT_shoutScale.SetNthEntryValue(0, 1, ( value - 0 ) / 100 )
		IF value == 0.0
			PlayerRef.RemovePerk(GBT_shoutScale)
		ELSE
			PlayerRef.AddPerk(GBT_shoutScale)
		ENDIF
		SHOUT_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(SHOUT_SCALE_SLIDER, value, "{1}%")
	ELSEIF ( option == TRAP_MAGNITUDE_SLIDER)
		GBT_trapMagnitude.SetNthEntryValue(0, 0, ( value - 0 ) / 100 )
		GBT_trapMagnitude.SetNthEntryValue(1, 0, ( value - 0 ) / 100 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_trapMagnitude)
		ELSE
			PlayerRef.AddPerk(GBT_trapMagnitude)
		ENDIF
		TRAP_MAGNITUDE_SLIDER_VAR = value
		SetSliderOptionValue(TRAP_MAGNITUDE_SLIDER, value, "{0}%")
	ELSEIF ( option == WEREDMG_DEALT_SLIDER)
		GBT_WerewolfDamageDealt.SetNthEntryValue(0, 0, ( value - 0 ) / 100 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_WerewolfDamageDealt)
		ELSE
			PlayerRef.AddPerk(GBT_WerewolfDamageDealt)
		ENDIF
		WEREDMG_DEALT_SLIDER_VAR = value
		SetSliderOptionValue(WEREDMG_DEALT_SLIDER, value, "{0}%")
	ELSEIF ( option == WEREDMG_TAKEN_SLIDER)
		GBT_WerewolfDamageTaken.SetNthEntryValue(0, 0, ( value - 0 ) / 100 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_WerewolfDamageTaken)
		ELSE
			PlayerRef.AddPerk(GBT_WerewolfDamageTaken)
		ENDIF
		WEREDMG_TAKEN_SLIDER_VAR = value
		SetSliderOptionValue(WEREDMG_TAKEN_SLIDER, value, "{0}%")
	ELSEIF ( option == POISON_DOSE_SLIDER)
		GBT_poisonDose.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 0.0
			PlayerRef.RemovePerk(GBT_poisonDose)
		ELSE
			PlayerRef.AddPerk(GBT_poisonDose)
		ENDIF
		POISON_DOSE_SLIDER_VAR = value
		SetSliderOptionValue(POISON_DOSE_SLIDER, value, "{0}")
	ELSEIF ( option == DUALCAST_POWER_SLIDER)
		SetGameSettingFloat("fMagicDualCastingEffectivenessBase", value)
		DUALCAST_POWER_SLIDER_VAR = value
		SetSliderOptionValue(DUALCAST_POWER_SLIDER, value, "{1}")
	ELSEIF ( option == DUALCAST_COST_SLIDER)
		SetGameSettingFloat("fMagicDualCastingCostMult", value)
		DUALCAST_COST_SLIDER_VAR = value
		SetSliderOptionValue(DUALCAST_COST_SLIDER, value, "{1}")
	ELSEIF ( option == MAGICCOST_SCALE_SLIDER)
		SetGameSettingFloat("fMagicCasterPCSkillCostBase", value)
		MAGICCOST_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(MAGICCOST_SCALE_SLIDER, value, "{4}")
	ELSEIF ( option == MAGIC_COST_SLIDER)
		SetGameSettingFloat("fMagicCasterPCSkillCostMult", value)
		MAGIC_COST_SLIDER_VAR = value
		SetSliderOptionValue(MAGIC_COST_SLIDER, value, "{1}")
	ELSEIF ( option == NPCMAGICCOST_SCALE_SLIDER)
		SetGameSettingFloat("fMagicCasterSkillCostBase", value)
		NPCMAGICCOST_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(NPCMAGICCOST_SCALE_SLIDER, value, "{4}")
	ELSEIF ( option == NPCMAGIC_COST_SLIDER)
		SetGameSettingFloat("fMagicCasterSkillCostMult", value)
		NPCMAGIC_COST_SLIDER_VAR = value
		SetSliderOptionValue(NPCMAGIC_COST_SLIDER, value, "{1}")
	ELSEIF ( option == MAX_RUNES_SLIDER)
		SetGameSettingInt("iMaxPlayerRunes", value AS INT)
		MAX_RUNES_SLIDER_VAR = value AS INT
		SetSliderOptionValue(MAX_RUNES_SLIDER, value, "{0}")
	ELSEIF ( option == MAX_SUMMONED_SLIDER)
		SetGameSettingInt("iMaxSummonedCreatures", value AS INT)
		MAX_SUMMONED_SLIDER_VAR = value AS INT
		SetSliderOptionValue(MAX_SUMMONED_SLIDER, value, "{0}")
	ELSEIF ( option == TELEKIN_DAMAGE_SLIDER)
		SetGameSettingFloat("fMagicTelekinesisDamageBase", value)
		TELEKIN_DAMAGE_SLIDER_VAR = value
		SetSliderOptionValue(TELEKIN_DAMAGE_SLIDER, value, "{0}")
	ELSEIF ( option == TELEKIN_DUALMULT_SLIDER)
		SetGameSettingFloat("fMagicTelekinesisDualCastDamageMult", value)
		TELEKIN_DUALMULT_SLIDER_VAR = value
		SetSliderOptionValue(TELEKIN_DUALMULT_SLIDER, value, "{2}")
	ELSEIF ( option == ALTMAG_SCALE_SLIDER)
		GBT_altScaleMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_altScaleMag)
		ELSE
			PlayerRef.AddPerk(GBT_altScaleMag)
		ENDIF
		ALTMAG_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(ALTMAG_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == CONJMAG_SCALE_SLIDER)
		GBT_conjScaleMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_conjScaleMag)
		ELSE
			PlayerRef.AddPerk(GBT_conjScaleMag)
		ENDIF
		CONJMAG_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(CONJMAG_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == ALTDURNOTPARA_SCALE_SLIDER)
		GBT_altScaleDurNotPara.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_altScaleDurNotPara)
		ELSE
			PlayerRef.AddPerk(GBT_altScaleDurNotPara)
		ENDIF
		ALTDURNOTPARA_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(ALTDURNOTPARA_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == CONJDUR_SCALE_SLIDER)
		GBT_conjScaleDur.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_conjScaleDur)
		ELSE
			PlayerRef.AddPerk(GBT_conjScaleDur)
		ENDIF
		CONJDUR_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(CONJDUR_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == ALTCOST_SCALE_SLIDER)
		GBT_altScaleCost.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_altScaleCost)
		ELSE
			PlayerRef.AddPerk(GBT_altScaleCost)
		ENDIF
		ALTCOST_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(ALTCOST_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == CONJCOST_SCALE_SLIDER)
		GBT_conjScaleCost.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_conjScaleCost)
		ELSE
			PlayerRef.AddPerk(GBT_conjScaleCost)
		ENDIF
		CONJCOST_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(CONJCOST_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == ALTDURPARA_SCALE_SLIDER)
		GBT_altScaleDurPara.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_altScaleDurPara)
		ELSE
			PlayerRef.AddPerk(GBT_altScaleDurPara)
		ENDIF
		ALTDURPARA_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(ALTDURPARA_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == BOUNTMELEE_SCALE_SLIDER)
		GBT_conjScaleBoundMelee.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_conjScaleBoundMelee)
		ELSE
			PlayerRef.AddPerk(GBT_conjScaleBoundMelee)
		ENDIF
		BOUNTMELEE_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(BOUNTMELEE_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == ALTCOSTDET_SCALE_SLIDER)
		GBT_altScaleCostDet.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_altScaleCostDet)
		ELSE
			PlayerRef.AddPerk(GBT_altScaleCostDet)
		ENDIF
		ALTCOSTDET_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(ALTCOSTDET_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == BOUNDBOW_SCALE_SLIDER)
		GBT_conjScaleBoundBow.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_conjScaleBoundBow)
		ELSE
			PlayerRef.AddPerk(GBT_conjScaleBoundBow)
		ENDIF
		BOUNDBOW_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(BOUNDBOW_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == DESMAG_SCALE_SLIDER)
		GBT_desScaleMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_desScaleMag)
		ELSE
			PlayerRef.AddPerk(GBT_desScaleMag)
		ENDIF
		DESMAG_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(DESMAG_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == HEALMAG_SCALE_SLIDER)
		GBT_restScaleMagHeal.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_restScaleMagHeal)
		ELSE
			PlayerRef.AddPerk(GBT_restScaleMagHeal)
		ENDIF
		HEALMAG_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(HEALMAG_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == DESDUR_SCALE_SLIDER)
		GBT_desScaleDur.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_desScaleDur)
		ELSE
			PlayerRef.AddPerk(GBT_desScaleDur)
		ENDIF
		DESDUR_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(DESDUR_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == HEALDUR_SCALE_SLIDER)
		GBT_restScaleDurHeal.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_restScaleDurHeal)
		ELSE
			PlayerRef.AddPerk(GBT_restScaleDurHeal)
		ENDIF
		HEALDUR_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(HEALDUR_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == DESCOST_SCALE_SLIDER)
		GBT_desScaleCost.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_desScaleCost)
		ELSE
			PlayerRef.AddPerk(GBT_desScaleCost)
		ENDIF
		DESCOST_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(DESCOST_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == HEALCOST_SCALE_SLIDER)
		GBT_restScaleCostHeal.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_restScaleCostHeal)
		ELSE
			PlayerRef.AddPerk(GBT_restScaleCostHeal)
		ENDIF
		HEALCOST_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(HEALCOST_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == ILLMAG_SCALE_SLIDER)
		GBT_illScaleMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_illScaleMag)
		ELSE
			PlayerRef.AddPerk(GBT_illScaleMag)
		ENDIF
		ILLMAG_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(ILLMAG_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == NONHEALMAG_SCALE_SLIDER)
		GBT_nonHealScaleMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_nonHealScaleMag)
		ELSE
			PlayerRef.AddPerk(GBT_nonHealScaleMag)
		ENDIF
		NONHEALMAG_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(NONHEALMAG_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == ILLDUR_SCALE_SLIDER)
		GBT_illScaleDur.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_illScaleDur)
		ELSE
			PlayerRef.AddPerk(GBT_illScaleDur)
		ENDIF
		ILLDUR_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(ILLDUR_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == NONHEALDUR_SCALE_SLIDER)
		GBT_nonHealScaleDur.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_nonHealScaleDur)
		ELSE
			PlayerRef.AddPerk(GBT_nonHealScaleDur)
		ENDIF
		NONHEALDUR_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(NONHEALDUR_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == ILLCOST_SCALE_SLIDER)
		GBT_illScaleCost.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_illScaleCost)
		ELSE
			PlayerRef.AddPerk(GBT_illScaleCost)
		ENDIF
		ILLCOST_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(ILLCOST_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == NONHEALCOST_SCALE_SLIDER)
		GBT_nonHealScaleCost.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_nonHealScaleCost)
		ELSE
			PlayerRef.AddPerk(GBT_nonHealScaleCost)
		ENDIF
		NONHEALCOST_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(NONHEALCOST_SCALE_SLIDER, value, "{0}%")
	ELSEIF ( option == LESSERPOWER_COOLDOWN_SLIDER)
		SetGameSettingFloat("fMagicLesserPowerCooldownTimer", value)
		LESSERPOWER_COOLDOWN_SLIDER_VAR = value
		SetSliderOptionValue(LESSERPOWER_COOLDOWN_SLIDER, value, "{1}")
	ELSEIF ( option == DAMAGEDEALTSCALE_OID)
		scaleDamageDealt_VAR = value
		updateDamageDealtScaling()
		SetSliderOptionValue(DAMAGEDEALTSCALE_OID, value, "{3}x")
	ELSEIF ( option == DAMAGETAKENSCALE_OID)
		scaleDamageTaken_VAR = value
		updateDamageTakenScaling()
		SetSliderOptionValue(DAMAGETAKENSCALE_OID, value, "{3}x")
	ELSEIF ( option == DAMAGEDEALT_NOVICE_SLIDER)
		SetGameSettingFloat("fDiffMultHPByPCVE", value * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
		DAMAGEDEALT_NOVICE_SLIDER_VAR = value
		SetSliderOptionValue(DAMAGEDEALT_NOVICE_SLIDER, value, "{2}")
	ELSEIF ( option == DAMAGETAKEN_NOVICE_SLIDER)
		SetGameSettingFloat("fDiffMultHPToPCVE", value * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
		DAMAGETAKEN_NOVICE_SLIDER_VAR = value
		SetSliderOptionValue(DAMAGETAKEN_NOVICE_SLIDER, value, "{2}")
	ELSEIF ( option == DAMAGEDEALT_APPRENTICE_SLIDER)
		SetGameSettingFloat("fDiffMultHPByPCE", value * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
		DAMAGEDEALT_APPRENTICE_SLIDER_VAR = value
		SetSliderOptionValue(DAMAGEDEALT_APPRENTICE_SLIDER, value, "{2}")
	ELSEIF ( option == DAMAGETAKEN_APPRENTICE_SLIDER)
		SetGameSettingFloat("fDiffMultHPToPCE", value * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
		DAMAGETAKEN_APPRENTICE_SLIDER_VAR = value
		SetSliderOptionValue(DAMAGETAKEN_APPRENTICE_SLIDER, value, "{2}")
	ELSEIF ( option == DAMAGEDEALT_ADEPT_SLIDER)
		SetGameSettingFloat("fDiffMultHPByPCN", value * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
		DAMAGEDEALT_ADEPT_SLIDER_VAR = value
		SetSliderOptionValue(DAMAGEDEALT_ADEPT_SLIDER, value, "{2}")
	ELSEIF ( option == DAMAGETAKEN_ADEPT_SLIDER)
		SetGameSettingFloat("fDiffMultHPToPCN", value * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
		DAMAGETAKEN_ADEPT_SLIDER_VAR = value
		SetSliderOptionValue(DAMAGETAKEN_ADEPT_SLIDER, value, "{2}")
	ELSEIF ( option == DAMAGEDEALT_EXPERT_SLIDER)
		SetGameSettingFloat("fDiffMultHPByPCH", value * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
		DAMAGEDEALT_EXPERT_SLIDER_VAR = value
		SetSliderOptionValue(DAMAGEDEALT_EXPERT_SLIDER, value, "{2}")
	ELSEIF ( option == DAMAGETAKEN_EXPERT_SLIDER)
		SetGameSettingFloat("fDiffMultHPToPCH", value * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
		DAMAGETAKEN_EXPERT_SLIDER_VAR = value
		SetSliderOptionValue(DAMAGETAKEN_EXPERT_SLIDER, value, "{2}")
	ELSEIF ( option == DAMAGEDEALT_MASTER_SLIDER)
		SetGameSettingFloat("fDiffMultHPByPCVH", value * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
		DAMAGEDEALT_MASTER_SLIDER_VAR = value
		SetSliderOptionValue(DAMAGEDEALT_MASTER_SLIDER, value, "{2}")
	ELSEIF ( option == DAMAGETAKEN_MASTER_SLIDER)
		SetGameSettingFloat("fDiffMultHPToPCVH", value * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
		DAMAGETAKEN_MASTER_SLIDER_VAR = value
		SetSliderOptionValue(DAMAGETAKEN_MASTER_SLIDER, value, "{2}")
	ELSEIF ( option == DAMAGEDEALT_LEGENDARY_SLIDER)
		SetGameSettingFloat("fDiffMultHPByPCL", value * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
		DAMAGEDEALT_LEGENDARY_SLIDER_VAR = value
		SetSliderOptionValue(DAMAGEDEALT_LEGENDARY_SLIDER, value, "{2}")
	ELSEIF ( option == DAMAGETAKEN_LEGENDARY_SLIDER)
		SetGameSettingFloat("fDiffMultHPToPCL", value * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
		DAMAGETAKEN_LEGENDARY_SLIDER_VAR = value
		SetSliderOptionValue(DAMAGETAKEN_LEGENDARY_SLIDER, value, "{2}")
	ELSEIF ( option == WEAPONSCALE_PCMIN_SLIDER)
		SetGameSettingFloat("fDamagePCSkillMin", value)
		WEAPONSCALE_PCMIN_SLIDER_VAR = value
		SetSliderOptionValue(WEAPONSCALE_PCMIN_SLIDER, value, "{1}")
	ELSEIF ( option == WEAPONSCALE_PCMAX_SLIDER)
		SetGameSettingFloat("fDamagePCSkillMax", value)
		WEAPONSCALE_PCMAX_SLIDER_VAR = value
		SetSliderOptionValue(WEAPONSCALE_PCMAX_SLIDER, value, "{1}")
	ELSEIF ( option == WEAPONSCALE_NPCMIN_SLIDER)
		SetGameSettingFloat("fDamageSkillMin", value)
		WEAPONSCALE_NPCMIN_SLIDER_VAR = value
		SetSliderOptionValue(WEAPONSCALE_NPCMIN_SLIDER, value, "{1}")
	ELSEIF ( option == WEAPONSCALE_NPCMAX_SLIDER)
		SetGameSettingFloat("fDamageSkillMax", value)
		WEAPONSCALE_NPCMAX_SLIDER_VAR = value
		SetSliderOptionValue(WEAPONSCALE_NPCMAX_SLIDER, value, "{1}")
	ELSEIF ( option == ARMOR_SCALE_SLIDER)
		SetGameSettingFloat("fArmorScalingFactor", value)
		ARMOR_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(ARMOR_SCALE_SLIDER, value, "{2}%")
	ELSEIF ( option == MAX_RESISTANCE_SLIDER)
		SetGameSettingFloat("fPlayerMaxResistance", value)
		MAX_RESISTANCE_SLIDER_VAR = value
		SetSliderOptionValue(MAX_RESISTANCE_SLIDER, value, "{0}%")
	ELSEIF ( option == ARMOR_BASERESIST_SLIDER)
		SetGameSettingFloat("fArmorBaseFactor", value)
		ARMOR_BASERESIST_SLIDER_VAR = value
		SetSliderOptionValue(ARMOR_BASERESIST_SLIDER, value, "{2}")
	ELSEIF ( option == ARMOR_MAXRESIST_SLIDER)
		SetGameSettingFloat("fMaxArmorRating", value)
		ARMOR_MAXRESIST_SLIDER_VAR = value
		SetSliderOptionValue(ARMOR_MAXRESIST_SLIDER, value, "{1}%")
	ELSEIF ( option == PC_ARMORRATING_SLIDER)
		SetGameSettingFloat("fArmorRatingPCMax", value)
		PC_ARMORRATING_SLIDER_VAR = value
		SetSliderOptionValue(PC_ARMORRATING_SLIDER, value, "{3}")
	ELSEIF ( option == NPC_ARMORRATING_SLIDER)
		SetGameSettingFloat("fArmorRatingMax", value)
		NPC_ARMORRATING_SLIDER_VAR = value
		SetSliderOptionValue(NPC_ARMORRATING_SLIDER, value, "{3}")
	ELSEIF ( option == ENCUM_EFFECT_SLIDER)
		SetGameSettingFloat("fMoveEncumEffect", value)
		ENCUM_EFFECT_SLIDER_VAR = value
		SetSliderOptionValue(ENCUM_EFFECT_SLIDER, value, "{2}")
	ELSEIF ( option == ENCUMWEAP_EFFECT_SLIDER)
		SetGameSettingFloat("fMoveEncumEffectNoWeapon", value)
		ENCUMWEAP_EFFECT_SLIDER_VAR = value
		SetSliderOptionValue(ENCUMWEAP_EFFECT_SLIDER, value, "{2}")
	ELSEIF ( option == WEAPONDAMAGE_MULT_SLIDER)
		SetGameSettingFloat("fDamageWeaponMult", value)
		WEAPONDAMAGE_MULT_SLIDER_VAR = value
		SetSliderOptionValue(WEAPONDAMAGE_MULT_SLIDER, value, "{2}")
	ELSEIF ( option == TWOHAND_ATKSPD_SLIDER)
		SetGameSettingFloat("fWeaponTwoHandedAnimationSpeedMult", value)
		TWOHAND_ATKSPD_SLIDER_VAR = value
		SetSliderOptionValue(TWOHAND_ATKSPD_SLIDER, value, "{1}")
	ELSEIF ( option == AUTOAIM_AREA_SLIDER)
		SetGameSettingFloat("fAutoAimScreenPercentage", value)
		AUTOAIM_AREA_SLIDER_VAR = value
		SetSliderOptionValue(AUTOAIM_AREA_SLIDER, value, "{0}")
	ELSEIF ( option == AUTOAIM_RANGE_SLIDER)
		SetGameSettingFloat("fAutoAimMaxDistance", value)
		AUTOAIM_RANGE_SLIDER_VAR = value
		SetSliderOptionValue(AUTOAIM_RANGE_SLIDER, value, "{0}")
	ELSEIF ( option == AUTOAIM_DEGREES_SLIDER)
		SetGameSettingFloat("fAutoAimMaxDegrees", value)
		AUTOAIM_DEGREES_SLIDER_VAR = value
		SetSliderOptionValue(AUTOAIM_DEGREES_SLIDER, value, "{1}")
	ELSEIF ( option == AUTOAIM_DEGREESTHIRD_SLIDER)
		SetGameSettingFloat("fAutoAimMaxDegrees3rdPerson", value)
		AUTOAIM_DEGREESTHIRD_SLIDER_VAR = value
		SetSliderOptionValue(AUTOAIM_DEGREESTHIRD_SLIDER, value, "{1}")
	ELSEIF ( option == STAMINA_POWERCOST_SLIDER)
		SetGameSettingFloat("fPowerAttackStaminaPenalty", value)
		STAMINA_POWERCOST_SLIDER_VAR = value
		SetSliderOptionValue(STAMINA_POWERCOST_SLIDER, value, "{1}")
	ELSEIF ( option == STAMINA_BLOCKCOSTMULT_SLIDER)
		SetGameSettingFloat("fStaminaBlockDmgMult", value)
		STAMINA_BLOCKCOSTMULT_SLIDER_VAR = value
		SetSliderOptionValue(STAMINA_BLOCKCOSTMULT_SLIDER, value, "{2}")
	ELSEIF ( option == STAMINA_BASHCOST_SLIDER)
		SetGameSettingFloat("fStaminaBashBase", value)
		STAMINA_BASHCOST_SLIDER_VAR = value
		SetSliderOptionValue(STAMINA_BASHCOST_SLIDER, value, "{0}")
	ELSEIF ( option == STAMINA_POWERBASHCOST_SLIDER)
		SetGameSettingFloat("fStaminaPowerBashBase", value)
		STAMINA_POWERBASHCOST_SLIDER_VAR = value
		SetSliderOptionValue(STAMINA_POWERBASHCOST_SLIDER, value, "{0}")
	ELSEIF ( option == STAMINA_BLOCKCOSTBASE_SLIDER)
		SetGameSettingFloat("fStaminaBlockBase", value)
		STAMINA_BLOCKCOSTBASE_SLIDER_VAR = value
		SetSliderOptionValue(STAMINA_BLOCKCOSTBASE_SLIDER, value, "{0}")
	ELSEIF ( option == BLOCK_SHIELD_SLIDER)
		SetGameSettingFloat("fShieldBaseFactor", value)
		BLOCK_SHIELD_SLIDER_VAR = value
		SetSliderOptionValue(BLOCK_SHIELD_SLIDER, value, "{2}")
	ELSEIF ( option == BLOCK_WEAPON_SLIDER)
		SetGameSettingFloat("fBlockWeaponBase", value)
		BLOCK_WEAPON_SLIDER_VAR = value
		SetSliderOptionValue(BLOCK_WEAPON_SLIDER, value, "{2}")
	ELSEIF ( option == WEAPON_REACH_SLIDER)
		SetGameSettingFloat("fCombatDistance", value)
		WEAPON_REACH_SLIDER_VAR = value
		SetSliderOptionValue(WEAPON_REACH_SLIDER, value, "{0}")
	ELSEIF ( option == BASH_REACH_SLIDER)
		SetGameSettingFloat("fCombatBashReach", value)
		BASH_REACH_SLIDER_VAR = value
		SetSliderOptionValue(BASH_REACH_SLIDER, value, "{0}")
	ELSEIF ( option == AISEARCH_TIME_SLIDER)
		SetGameSettingFloat("fCombatStealthPointRegenAttackedWaitTime", value)
		AISEARCH_TIME_SLIDER_VAR = value
		SetSliderOptionValue(AISEARCH_TIME_SLIDER, value, "{0} Sec")
	ELSEIF ( option == AISEARCH_TIMEATTACKED_SLIDER)
		SetGameSettingFloat("fCombatStealthPointRegenDetectedEventWaitTime", value)
		AISEARCH_TIMEATTACKED_SLIDER_VAR = value
		SetSliderOptionValue(AISEARCH_TIMEATTACKED_SLIDER, value, "{0} Sec")
	ELSEIF ( option == SNEAKLEVEL_BASE_SLIDER)
		SetGameSettingFloat("fPlayerDetectionSneakBase", value)
		SNEAKLEVEL_BASE_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKLEVEL_BASE_SLIDER, value, "{0}")
	ELSEIF ( option == SNEAKDETECTION_SCALE_SLIDER)
		SetGameSettingFloat("fPlayerDetectionSneakMult", value)
		SNEAKDETECTION_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKDETECTION_SCALE_SLIDER, value, "{2}")
	ELSEIF ( option == DETECTION_FOV_SLIDER)
		SetGameSettingFloat("fDetectionViewCone", value)
		DETECTION_FOV_SLIDER_VAR = value
		SetSliderOptionValue(DETECTION_FOV_SLIDER, value, "{0} Deg")
	ELSEIF ( option == SNEAK_BASE_SLIDER)
		SetGameSettingFloat("fSneakBaseValue", value)
		SNEAK_BASE_SLIDER_VAR = value
		SetSliderOptionValue(SNEAK_BASE_SLIDER, value, "{0}")
	ELSEIF ( option == DETECTION_LIGHT_SLIDER)
		SetGameSettingFloat("fDetectionSneakLightMod", value)
		DETECTION_LIGHT_SLIDER_VAR = value
		SetSliderOptionValue(DETECTION_LIGHT_SLIDER, value, "{0}")
	ELSEIF ( option == DETECTION_LIGHTEXT_SLIDER)
		SetGameSettingFloat("fSneakLightExteriorMult", value)
		DETECTION_LIGHTEXT_SLIDER_VAR = value
		SetSliderOptionValue(DETECTION_LIGHTEXT_SLIDER, value, "{2}")
	ELSEIF ( option == DETECTION_SOUND_SLIDER)
		SetGameSettingFloat("fSneakSoundsMult", value)
		DETECTION_SOUND_SLIDER_VAR = value
		SetSliderOptionValue(DETECTION_SOUND_SLIDER, value, "{2}")
	ELSEIF ( option == DETECTION_SOUNDLOS_SLIDER)
		SetGameSettingFloat("fSneakSoundLosMult", value)
		DETECTION_SOUNDLOS_SLIDER_VAR = value
		SetSliderOptionValue(DETECTION_SOUNDLOS_SLIDER, value, "{2}")
	ELSEIF ( option == PICKPOCKET_MAXCHANCE_SLIDER)
		SetGameSettingFloat("fPickPocketMaxChance", value)
		PICKPOCKET_MAXCHANCE_SLIDER_VAR = value
		SetSliderOptionValue(PICKPOCKET_MAXCHANCE_SLIDER, value, "{0}%")
	ELSEIF ( option == PICKPOCKET_MINCHANCE_SLIDER)
		SetGameSettingFloat("fPickPocketMinChance", value)
		PICKPOCKET_MINCHANCE_SLIDER_VAR = value
		SetSliderOptionValue(PICKPOCKET_MINCHANCE_SLIDER, value, "{0}%")
	ELSEIF ( option == SNEAKMULT_MARKSMAN_SLIDER)
		GBT_SneakMarks.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakMarks)
		ELSE
			PlayerRef.AddPerk(GBT_SneakMarks)
		ENDIF
		SNEAKMULT_MARKSMAN_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKMULT_MARKSMAN_SLIDER, value, "{2}")
	ELSEIF ( option == SNEAKMULT_DAGGER_SLIDER)
		GBT_SneakDagger.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakDagger)
		ELSE
			PlayerRef.AddPerk(GBT_SneakDagger)
		ENDIF
		SNEAKMULT_DAGGER_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKMULT_DAGGER_SLIDER, value, "{2}")
	ELSEIF ( option == SNEAKMULT_TWOHAND_SLIDER)
		GBT_SneakOne.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakOne)
		ELSE
			PlayerRef.AddPerk(GBT_SneakOne)
		ENDIF
		SNEAKMULT_TWOHAND_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKMULT_TWOHAND_SLIDER, value, "{2}")
	ELSEIF ( option == SNEAKMULT_ONEHAND_SLIDER)
		GBT_SneakTwo.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakTwo)
		ELSE
			PlayerRef.AddPerk(GBT_SneakTwo)
		ENDIF
		SNEAKMULT_ONEHAND_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKMULT_ONEHAND_SLIDER, value, "{2}")
	ELSEIF ( option == SNEAKMULT_UNARMED_SLIDER)
		GBT_SneakH2H.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakH2H)
		ELSE
			PlayerRef.AddPerk(GBT_SneakH2H)
		ENDIF
		SNEAKMULT_UNARMED_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKMULT_UNARMED_SLIDER, value, "{2}")
	ELSEIF ( option == SNEAKMULT_RUNE_SLIDER)
		GBT_SneakRuneMag.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakRuneMag)
		ELSE
			PlayerRef.AddPerk(GBT_SneakRuneMag)
		ENDIF
		SNEAKMULT_RUNE_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKMULT_RUNE_SLIDER, value, "{2}")
	ELSEIF ( option == SNEAKMULT_SEARCH_SLIDER)
		GBT_SneakSearch.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakSearch)
		ELSE
			PlayerRef.AddPerk(GBT_SneakSearch)
		ENDIF
		SNEAKMULT_SEARCH_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKMULT_SEARCH_SLIDER, value, "{2}")
	ELSEIF ( option == SNEAKMULT_SPELLMAG_SLIDER)
		GBT_SneakSpellMag.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakSpellMag)
		ELSE
			PlayerRef.AddPerk(GBT_SneakSpellMag)
		ENDIF
		SNEAKMULT_SPELLMAG_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKMULT_SPELLMAG_SLIDER, value, "{2}")
	ELSEIF ( option == SNEAKMULT_SPELLSEARCH_SLIDER)
		GBT_SneakSpellSearch.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakSpellSearch)
		ELSE
			PlayerRef.AddPerk(GBT_SneakSpellSearch)
		ENDIF
		SNEAKMULT_SPELLSEARCH_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKMULT_SPELLSEARCH_SLIDER, value, "{2}")
	ELSEIF ( option == SNEAKMULT_SPELLDUR_SLIDER)
		GBT_SneakSpellDur.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakSpellDur)
		ELSE
			PlayerRef.AddPerk(GBT_SneakSpellDur)
		ENDIF
		SNEAKMULT_SPELLDUR_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKMULT_SPELLDUR_SLIDER, value, "{2}")
	ELSEIF ( option == SNEAKSCALE_PHYSICAL_SLIDER)
		GBT_SneakScalePhys.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_SneakScalePhys)
		ELSE
			PlayerRef.AddPerk(GBT_SneakScalePhys)
		ENDIF
		SNEAKSCALE_PHYSICAL_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKSCALE_PHYSICAL_SLIDER, value, "{0}%")
	ELSEIF ( option == SNEAKSCALE_SPELLMAG_SLIDER)
		GBT_SneakScaleSpell.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_SneakScaleSpell)
		ELSE
			PlayerRef.AddPerk(GBT_SneakScaleSpell)
		ENDIF
		SNEAKSCALE_SPELLMAG_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKSCALE_SPELLMAG_SLIDER, value, "{0}%")
	ELSEIF ( option == SNEAKMULT_POISONMAG_SLIDER)
		GBT_SneakPoisonMag.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakPoisonMag)
		ELSE
			PlayerRef.AddPerk(GBT_SneakPoisonMag)
		ENDIF
		SNEAKMULT_POISONMAG_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKMULT_POISONMAG_SLIDER, value, "{2}")
	ELSEIF ( option == SNEAKMULT_POISONDUR_SLIDER)
		GBT_SneakPoisonDur.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakPoisonDur)
		ELSE
			PlayerRef.AddPerk(GBT_SneakPoisonDur)
		ENDIF
		SNEAKMULT_POISONDUR_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKMULT_POISONDUR_SLIDER, value, "{2}")
	ELSEIF ( option == SNEAKSCALE_POISONMAG_SLIDER)
		GBT_SneakScalePoisonMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_SneakScalePoisonMag)
		ELSE
			PlayerRef.AddPerk(GBT_SneakScalePoisonMag)
		ENDIF
		SNEAKSCALE_POISONMAG_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKSCALE_POISONMAG_SLIDER, value, "{0}%")
	ELSEIF ( option == SNEAKSCALE_POISONDUR_SLIDER)
		GBT_SneakScalePoisonDur.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_SneakScalePoisonDur)
		ELSE
			PlayerRef.AddPerk(GBT_SneakScalePoisonDur)
		ENDIF
		SNEAKSCALE_POISONDUR_SLIDER_VAR = value
		SetSliderOptionValue(SNEAKSCALE_POISONDUR_SLIDER, value, "{0}%")
	ELSEIF ( option == LOCKPICK_VEASY_SLIDER)
		SetGameSettingFloat("fSweetSpotVeryEasy", value)
		LOCKPICK_VEASY_SLIDER_VAR = value
		SetSliderOptionValue(LOCKPICK_VEASY_SLIDER, value, "{4}")
	ELSEIF ( option == LOCKPICKDUR_VEASY_SLIDER)
		SetGameSettingFloat("fLockpickBreakNovice", value)
		LOCKPICKDUR_VEASY_SLIDER_VAR = value
		SetSliderOptionValue(LOCKPICKDUR_VEASY_SLIDER, value, "{4}")
	ELSEIF ( option == LOCKPICK_EASY_SLIDER)
		SetGameSettingFloat("fSweetSpotEasy", value)
		LOCKPICK_EASY_SLIDER_VAR = value
		SetSliderOptionValue(LOCKPICK_EASY_SLIDER, value, "{4}")
	ELSEIF ( option == LOCKPICKDUR_EASY_SLIDER)
		SetGameSettingFloat("fLockpickBreakApprentice", value)
		LOCKPICKDUR_EASY_SLIDER_VAR = value
		SetSliderOptionValue(LOCKPICKDUR_EASY_SLIDER, value, "{4}")
	ELSEIF ( option == LOCKPICK_AVERAGE_SLIDER)
		SetGameSettingFloat("fSweetSpotAverage", value)
		LOCKPICK_AVERAGE_SLIDER_VAR = value
		SetSliderOptionValue(LOCKPICK_AVERAGE_SLIDER, value, "{4}")
	ELSEIF ( option == LOCKPICKDUR_AVERAGE_SLIDER)
		SetGameSettingFloat("fLockpickBreakAdept", value)
		LOCKPICKDUR_AVERAGE_SLIDER_VAR = value
		SetSliderOptionValue(LOCKPICKDUR_AVERAGE_SLIDER, value, "{4}")
	ELSEIF ( option == LOCKPICK_HARD_SLIDER)
		SetGameSettingFloat("fSweetSpotHard", value)
		LOCKPICK_HARD_SLIDER_VAR = value
		SetSliderOptionValue(LOCKPICK_HARD_SLIDER, value, "{4}")
	ELSEIF ( option == LOCKPICKDUR_HARD_SLIDER)
		SetGameSettingFloat("fLockpickBreakExpert", value)
		LOCKPICKDUR_HARD_SLIDER_VAR = value
		SetSliderOptionValue(LOCKPICKDUR_HARD_SLIDER, value, "{4}")
	ELSEIF ( option == LOCKPICK_VHARD_SLIDER)
		SetGameSettingFloat("fSweetSpotVeryHard", value)
		LOCKPICK_VHARD_SLIDER_VAR = value
		SetSliderOptionValue(LOCKPICK_VHARD_SLIDER, value, "{4}")
	ELSEIF ( option == LOCKPICKDUR_VHARD_SLIDER)
		SetGameSettingFloat("fLockpickBreakMaster", value)
		LOCKPICKDUR_VHARD_SLIDER_VAR = value
		SetSliderOptionValue(LOCKPICKDUR_VHARD_SLIDER, value, "{4}")
	ELSEIF ( option == ALCHEMYMAG_MULT_SLIDER)
		SetGameSettingFloat("fAlchemyIngredientInitMult", value)
		ALCHEMYMAG_MULT_SLIDER_VAR = value
		SetSliderOptionValue(ALCHEMYMAG_MULT_SLIDER, value, "{1}")
	ELSEIF ( option == ALCHEMYMAG_SCALE_SLIDER)
		SetGameSettingFloat("fAlchemySkillFactor", value)
		ALCHEMYMAG_SCALE_SLIDER_VAR = value
		SetSliderOptionValue(ALCHEMYMAG_SCALE_SLIDER, value, "{2}")
	ELSEIF ( option == BONUS_INGR_SLIDER)
		GBT_bonusIngredients.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 0.0
			PlayerRef.RemovePerk(GBT_bonusIngredients)
		ELSE
			PlayerRef.AddPerk(GBT_bonusIngredients)
		ENDIF
		BONUS_INGR_SLIDER_VAR = value
		SetSliderOptionValue(BONUS_INGR_SLIDER, value, "{0}")
	ELSEIF ( option == BONUS_POTION_SLIDER)
		GBT_bonusPotions.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 0.0
			PlayerRef.RemovePerk(GBT_bonusPotions)
		ELSE
			PlayerRef.AddPerk(GBT_bonusPotions)
		ENDIF
		BONUS_POTION_SLIDER_VAR = value
		SetSliderOptionValue(BONUS_POTION_SLIDER, value, "{0}")
	ELSEIF ( option == CHARGECOST_POWER_SLIDER)
		SetGameSettingFloat("fEnchantingCostExponent", value)
		CHARGECOST_POWER_SLIDER_VAR = value
		SetSliderOptionValue(CHARGECOST_POWER_SLIDER, value, "{2}")
	ELSEIF ( option == ENCHANT_SCALING_SLIDER)
		SetGameSettingFloat("fEnchantingSkillFactor", value)
		ENCHANT_SCALING_SLIDER_VAR = value
		SetSliderOptionValue(ENCHANT_SCALING_SLIDER, value, "{2}")
	ELSEIF ( option == CHARGECOST_MULT_SLIDER)
		SetGameSettingFloat("fEnchantingSkillCostMult", value)
		CHARGECOST_MULT_SLIDER_VAR = value
		SetSliderOptionValue(CHARGECOST_MULT_SLIDER, value, "{1}")
	ELSEIF ( option == ENCHANTPRICE_EFFECT_SLIDER)
		SetGameSettingFloat("fEnchantmentEffectPointsMult", value)
		ENCHANTPRICE_EFFECT_SLIDER_VAR = value
		SetSliderOptionValue(ENCHANTPRICE_EFFECT_SLIDER, value, "{1}")
	ELSEIF ( option == CHARGECOST_BASE_SLIDER)
		SetGameSettingFloat("fEnchantingSkillCostBase", value)
		CHARGECOST_BASE_SLIDER_VAR = value
		SetSliderOptionValue(CHARGECOST_BASE_SLIDER, value, "{3}")
	ELSEIF ( option == ENCHANTPRICE_SOUL_SLIDER)
		SetGameSettingFloat("fEnchantmentPointsMult", value)
		ENCHANTPRICE_SOUL_SLIDER_VAR = value
		SetSliderOptionValue(ENCHANTPRICE_SOUL_SLIDER, value, "{2}")
	ELSEIF ( option == ENCHANT_CHARGE_SLIDER)
		GBT_enchantCharge.SetNthEntryValue(0, 0, ( value - 0 ) / 100 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_enchantCharge)
		ELSE
			PlayerRef.AddPerk(GBT_enchantCharge)
		ENDIF
		ENCHANT_CHARGE_SLIDER_VAR = value
		SetSliderOptionValue(ENCHANT_CHARGE_SLIDER, value, "{0}%")
	ELSEIF ( option == ENCHANT_MAG_SLIDER)
		GBT_enchantMag.SetNthEntryValue(0, 0, ( value - 0 ) / 100 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_enchantMag)
		ELSE
			PlayerRef.AddPerk(GBT_enchantMag)
		ENDIF
		ENCHANT_MAG_SLIDER_VAR = value
		SetSliderOptionValue(ENCHANT_MAG_SLIDER, value, "{0}%")
	ELSEIF ( option == BONUS_ENCHANT_SLIDER)
		GBT_bonusEnchants.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 0.0
			PlayerRef.RemovePerk(GBT_bonusEnchants)
		ELSE
			PlayerRef.AddPerk(GBT_bonusEnchants)
		ENDIF
		BONUS_ENCHANT_SLIDER_VAR = value
		SetSliderOptionValue(BONUS_ENCHANT_SLIDER, value, "{0}")
	ELSEIF ( option == TEMPER_SUFFIX_SLIDER)
		SetGameSettingFloat("fSmithingConditionFactor", value)
		TEMPER_SUFFIX_SLIDER_VAR = value
		SetSliderOptionValue(TEMPER_SUFFIX_SLIDER, value, "{2}")
	ELSEIF ( option == TEMPER_ARMOR_SLIDER)
		SetGameSettingFloat("fSmithingArmorMax", value)
		TEMPER_ARMOR_SLIDER_VAR = value
		SetSliderOptionValue(TEMPER_ARMOR_SLIDER, value, "{1}")
	ELSEIF ( option == TEMPER_WEAPON_SLIDER)
		SetGameSettingFloat("fSmithingWeaponMax", value)
		TEMPER_WEAPON_SLIDER_VAR = value
		SetSliderOptionValue(TEMPER_WEAPON_SLIDER, value, "{1}")
	ELSEIF ( option == POTION_MAG_SLIDER)
		GBT_PotionMag.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_PotionMag)
		ELSE
			PlayerRef.AddPerk(GBT_PotionMag)
		ENDIF
		POTION_MAG_SLIDER_VAR = value
		SetSliderOptionValue(POTION_MAG_SLIDER, value, "{2}")
	ELSEIF ( option == POTION_DUR_SLIDER)
		GBT_PotionDur.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_PotionDur)
		ELSE
			PlayerRef.AddPerk(GBT_PotionDur)
		ENDIF
		POTION_DUR_SLIDER_VAR = value
		SetSliderOptionValue(POTION_DUR_SLIDER, value, "{2}")
	ELSEIF ( option == POTION_SCALEMAG_SLIDER)
		GBT_PotionScaleMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_PotionScaleMag)
		ELSE
			PlayerRef.AddPerk(GBT_PotionScaleMag)
		ENDIF
		POTION_SCALEMAG_SLIDER_VAR = value
		SetSliderOptionValue(POTION_SCALEMAG_SLIDER, value, "{0}%")
	ELSEIF ( option == POTION_SCALEDUR_SLIDER)
		GBT_PotionScaleDur.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_PotionScaleDur)
		ELSE
			PlayerRef.AddPerk(GBT_PotionScaleDur)
		ENDIF
		POTION_SCALEDUR_SLIDER_VAR = value
		SetSliderOptionValue(POTION_SCALEDUR_SLIDER, value, "{0}%")
	ELSEIF ( option == POISON_MAG_SLIDER)
		GBT_PoisonMag.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_PoisonMag)
		ELSE
			PlayerRef.AddPerk(GBT_PoisonMag)
		ENDIF
		POISON_MAG_SLIDER_VAR = value
		SetSliderOptionValue(POISON_MAG_SLIDER, value, "{2}")
	ELSEIF ( option == POISON_DUR_SLIDER)
		GBT_PoisonDur.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_PoisonDur)
		ELSE
			PlayerRef.AddPerk(GBT_PoisonDur)
		ENDIF
		POISON_DUR_SLIDER_VAR = value
		SetSliderOptionValue(POISON_DUR_SLIDER, value, "{2}")
	ELSEIF ( option == POISON_SCALEMAG_SLIDER)
		GBT_PoisonScaleMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_PoisonScaleMag)
		ELSE
			PlayerRef.AddPerk(GBT_PoisonScaleMag)
		ENDIF
		POISON_SCALEMAG_SLIDER_VAR = value
		SetSliderOptionValue(POISON_SCALEMAG_SLIDER, value, "{0}%")
	ELSEIF ( option == POISON_SCALEDUR_SLIDER)
		GBT_PoisonScaleDur.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_PoisonScaleDur)
		ELSE
			PlayerRef.AddPerk(GBT_PoisonScaleDur)
		ENDIF
		POISON_SCALEDUR_SLIDER_VAR = value
		SetSliderOptionValue(POISON_SCALEDUR_SLIDER, value, "{0}%")
	ELSEIF ( option == SCROLL_MAG_SLIDER)
		GBT_ScrollMag.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_ScrollMag)
		ELSE
			PlayerRef.AddPerk(GBT_ScrollMag)
		ENDIF
		SCROLL_MAG_SLIDER_VAR = value
		SetSliderOptionValue(SCROLL_MAG_SLIDER, value, "{2}")
	ELSEIF ( option == SCROLL_DUR_SLIDER)
		GBT_ScrollDur.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_ScrollDur)
		ELSE
			PlayerRef.AddPerk(GBT_ScrollDur)
		ENDIF
		SCROLL_DUR_SLIDER_VAR = value
		SetSliderOptionValue(SCROLL_DUR_SLIDER, value, "{2}")
	ELSEIF ( option == BARTER_BUYMIN_SLIDER)
		SetGameSettingFloat("fBarterBuyMin", value)
		BARTER_BUYMIN_SLIDER_VAR = value
		SetSliderOptionValue(BARTER_BUYMIN_SLIDER, value, "{2}")
	ELSEIF ( option == BARTER_SELLMAX_SLIDER)
		SetGameSettingFloat("fBarterSellMax", value)
		BARTER_SELLMAX_SLIDER_VAR = value
		SetSliderOptionValue(BARTER_SELLMAX_SLIDER, value, "{2}")
	ELSEIF ( option == BARTER_MIN_SLIDER)
		SetGameSettingFloat("fBarterMin", value)
		BARTER_MIN_SLIDER_VAR = value
		SetSliderOptionValue(BARTER_MIN_SLIDER, value, "{2}")
	ELSEIF ( option == BARTER_MAX_SLIDER)
		SetGameSettingFloat("fBarterMax", value)
		BARTER_MAX_SLIDER_VAR = value
		SetSliderOptionValue(BARTER_MAX_SLIDER, value, "{2}")
	ELSEIF ( option == BUY_PRICE_SLIDER)
		GBT_buyPrice.SetNthEntryValue(0, 0, ( value - 0 ) / 100 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_buyPrice)
		ELSE
			PlayerRef.AddPerk(GBT_buyPrice)
		ENDIF
		BUY_PRICE_SLIDER_VAR = value
		SetSliderOptionValue(BUY_PRICE_SLIDER, value, "{0}%")
	ELSEIF ( option == SELL_PRICE_SLIDER)
		GBT_sellPrice.SetNthEntryValue(0, 0, ( value - 0 ) / 100 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_sellPrice)
		ELSE
			PlayerRef.AddPerk(GBT_sellPrice)
		ENDIF
		SELL_PRICE_SLIDER_VAR = value
		SetSliderOptionValue(SELL_PRICE_SLIDER, value, "{0}%")
	ELSEIF ( option == VENDOR_RESPAWN_SLIDER)
		SetGameSettingInt("iDaysToRespawnVendor", value AS INT)
		VENDOR_RESPAWN_SLIDER_VAR = value AS INT
		SetSliderOptionValue(VENDOR_RESPAWN_SLIDER, value, "{0}")
	ELSEIF ( option == TRAINING_NUMALLOWED_SLIDER)
		SetGameSettingInt("iTrainingNumAllowedPerLevel", value AS INT)
		TRAINING_NUMALLOWED_SLIDER_VAR = value AS INT
		SetSliderOptionValue(TRAINING_NUMALLOWED_SLIDER, value, "{0}")
	ELSEIF ( option == TRAINING_JOURNEYMANCOST_SLIDER)
		SetGameSettingInt("iTrainingJourneymanCost", value AS INT)
		TRAINING_JOURNEYMANCOST_SLIDER_VAR = value AS INT
		SetSliderOptionValue(TRAINING_JOURNEYMANCOST_SLIDER, value, "{0}")
	ELSEIF ( option == TRAINING_JOURNEYMANSKILL_SLIDER)
		SetGameSettingInt("iTrainingJourneymanSkill", value AS INT)
		TRAINING_JOURNEYMANSKILL_SLIDER_VAR = value AS INT
		SetSliderOptionValue(TRAINING_JOURNEYMANSKILL_SLIDER, value, "{0}")
	ELSEIF ( option == TRAINING_EXPERTCOST_SLIDER)
		SetGameSettingInt("iTrainingExpertCost", value AS INT)
		TRAINING_EXPERTCOST_SLIDER_VAR = value AS INT
		SetSliderOptionValue(TRAINING_EXPERTCOST_SLIDER, value, "{0}")
	ELSEIF ( option == TRAINING_EXPERTSKILL_SLIDER)
		SetGameSettingInt("iTrainingExpertSkill", value AS INT)
		TRAINING_EXPERTSKILL_SLIDER_VAR = value AS INT
		SetSliderOptionValue(TRAINING_EXPERTSKILL_SLIDER, value, "{0}")
	ELSEIF ( option == TRAINING_MASTERCOST_SLIDER)
		SetGameSettingInt("iTrainingMasterCost", value AS INT)
		TRAINING_MASTERCOST_SLIDER_VAR = value AS INT
		SetSliderOptionValue(TRAINING_MASTERCOST_SLIDER, value, "{0}")
	ELSEIF ( option == TRAINING_MASTERSKILL_SLIDER)
		SetGameSettingInt("iTrainingMasterSkill", value AS INT)
		TRAINING_MASTERSKILL_SLIDER_VAR = value AS INT
		SetSliderOptionValue(TRAINING_MASTERSKILL_SLIDER, value, "{0}")
	ELSEIF ( option == APOTHECARY_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldApothecary,0,value AS INT)
		APOTHECARY_GOLD_SLIDER_VAR = value AS INT
		SetSliderOptionValue(APOTHECARY_GOLD_SLIDER, value, "{0}")
	ELSEIF ( option == BLACKSMITH_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldBlacksmith,0,value AS INT)
		BLACKSMITH_GOLD_SLIDER_VAR = value AS INT
		SetSliderOptionValue(BLACKSMITH_GOLD_SLIDER, value, "{0}")
	ELSEIF ( option == ORCBLACKSMITH_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldBlacksmithOrc,0,value AS INT)
		ORCBLACKSMITH_GOLD_SLIDER_VAR = value AS INT
		SetSliderOptionValue(ORCBLACKSMITH_GOLD_SLIDER, value, "{0}")
	ELSEIF ( option == TOWNBLACKSMITH_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldBlacksmithTown,0,value AS INT)
		TOWNBLACKSMITH_GOLD_SLIDER_VAR = value AS INT
		SetSliderOptionValue(TOWNBLACKSMITH_GOLD_SLIDER, value, "{0}")
	ELSEIF ( option == INNKEERPER_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldInn,0,value AS INT)
		INNKEERPER_GOLD_SLIDER_VAR = value AS INT
		SetSliderOptionValue(INNKEERPER_GOLD_SLIDER, value, "{0}")
	ELSEIF ( option == MISCMERCHANT_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldMisc,0,value AS INT)
		MISCMERCHANT_GOLD_SLIDER_VAR = value AS INT
		SetSliderOptionValue(MISCMERCHANT_GOLD_SLIDER, value, "{0}")
	ELSEIF ( option == SPELLMERCHANT_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldSpells,0,value AS INT)
		SPELLMERCHANT_GOLD_SLIDER_VAR = value AS INT
		SetSliderOptionValue(SPELLMERCHANT_GOLD_SLIDER, value, "{0}")
	ELSEIF ( option == STREETVENDOR_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldStreetVendor,0,value AS INT)
		STREETVENDOR_GOLD_SLIDER_VAR = value AS INT
		SetSliderOptionValue(STREETVENDOR_GOLD_SLIDER, value, "{0}")
	ELSEIF ( option == COMBAT_STAMINAREGEN_SLIDER)
		SetGameSettingFloat("fCombatStaminaRegenRateMult", value)
		COMBAT_STAMINAREGEN_SLIDER_VAR = value
		SetSliderOptionValue(COMBAT_STAMINAREGEN_SLIDER, value, "{2}")
	ELSEIF ( option == AV_COMBATHEALTHREGENMULT_SLIDER)
		PlayerRef.SetAV("CombatHealthRegenMult", value - PlayerRef.GetAV("CombatHealthRegenMult") + PlayerRef.GetBaseAV("CombatHealthRegenMult"))
		SetSliderOptionValue(AV_COMBATHEALTHREGENMULT_SLIDER, value, "{2}")
	ELSEIF ( option == DAMAGESTAMINA_DELAY_SLIDER)
		SetGameSettingFloat("fDamagedStaminaRegenDelay", value)
		DAMAGESTAMINA_DELAY_SLIDER_VAR = value
		SetSliderOptionValue(DAMAGESTAMINA_DELAY_SLIDER, value, "{1} sec")
	ELSEIF ( option == BOWZOOM_REGENDELAY_SLIDER)
		SetGameSettingFloat("fBowZoomStaminaRegenDelay", value)
		BOWZOOM_REGENDELAY_SLIDER_VAR = value
		SetSliderOptionValue(BOWZOOM_REGENDELAY_SLIDER, value, "{1} sec")
	ELSEIF ( option == COMBAT_MAGICKAREGEN_SLIDER)
		SetGameSettingFloat("fCombatMagickaRegenRateMult", value)
		COMBAT_MAGICKAREGEN_SLIDER_VAR = value
		SetSliderOptionValue(COMBAT_MAGICKAREGEN_SLIDER, value, "{2}")
	ELSEIF ( option == STAMINA_REGENDELAY_SLIDER)
		SetGameSettingFloat("fStaminaRegenDelayMax", value)
		STAMINA_REGENDELAY_SLIDER_VAR = value
		SetSliderOptionValue(STAMINA_REGENDELAY_SLIDER, value, "{1} sec")
	ELSEIF ( option == DAMAGEMAGICKA_DELAY_SLIDER)
		SetGameSettingFloat("fDamagedMagickaRegenDelay", value)
		DAMAGEMAGICKA_DELAY_SLIDER_VAR = value
		SetSliderOptionValue(DAMAGEMAGICKA_DELAY_SLIDER, value, "{1} sec")
	ELSEIF ( option == MAGICKA_REGENDELAY_SLIDER)
		SetGameSettingFloat("fMagickaRegenDelayMax", value)
		MAGICKA_REGENDELAY_SLIDER_VAR = value
		SetSliderOptionValue(MAGICKA_REGENDELAY_SLIDER, value, "{1} sec")
	ELSEIF ( option == AV_HEALRATEMULT_SLIDER)
		PlayerRef.SetAV("HealRateMult", value - PlayerRef.GetAV("HealRateMult") + PlayerRef.GetBaseAV("HealRateMult"))
		SetSliderOptionValue(AV_HEALRATEMULT_SLIDER, value, "{0}")
	ELSEIF ( option == AV_HEALRATE_SLIDER)
		PlayerRef.SetAV("HealRate", value)
		AV_HEALRATE_SLIDER_Var = value
		SetSliderOptionValue(AV_HEALRATE_SLIDER, value, "{2}")
	ELSEIF ( option == AV_MAGICKARATEMULT_SLIDER)
		PlayerRef.SetAV("MagickaRateMult", value - PlayerRef.GetAV("MagickaRateMult") + PlayerRef.GetBaseAV("MagickaRateMult"))
		SetSliderOptionValue(AV_MAGICKARATEMULT_SLIDER, value, "{0}")
	ELSEIF ( option == AV_MAGICKARATE_SLIDER)
		PlayerRef.SetAV("MagickaRate", value)
		AV_MAGICKARATE_SLIDER_Var = value
		SetSliderOptionValue(AV_MAGICKARATE_SLIDER, value, "{2}")
	ELSEIF ( option == AV_STAMINARATEMULT_SLIDER)
		PlayerRef.SetAV("StaminaRateMult", value - PlayerRef.GetAV("StaminaRateMult") + PlayerRef.GetBaseAV("StaminaRateMult"))
		SetSliderOptionValue(AV_STAMINARATEMULT_SLIDER, value, "{0}")
	ELSEIF ( option == AV_STAMINARATE_SLIDER)
		PlayerRef.SetAV("StaminaRate", value)
		AV_STAMINARATE_SLIDER_Var = value
		SetSliderOptionValue(AV_STAMINARATE_SLIDER, value, "{2}")
	ELSEIF ( option == AV_HEALTH_SLIDER)
		PlayerRef.SetAV("Health", value - PlayerRef.GetAV("Health") + PlayerRef.GetBaseAV("Health"))
		SetSliderOptionValue(AV_HEALTH_SLIDER, value, "{0}")
	ELSEIF ( option == AV_MAGICKA_SLIDER)
		PlayerRef.SetAV("Magicka", value - PlayerRef.GetAV("Magicka") + PlayerRef.GetBaseAV("Magicka"))
		SetSliderOptionValue(AV_MAGICKA_SLIDER, value, "{0}")
	ELSEIF ( option == AV_STAMINA_SLIDER)
		PlayerRef.SetAV("Stamina", value - PlayerRef.GetAV("Stamina") + PlayerRef.GetBaseAV("Stamina"))
		SetSliderOptionValue(AV_STAMINA_SLIDER, value, "{0}")
	ELSEIF ( option == AV_DRAGONSOULS_SLIDER)
		PlayerRef.SetAV("DragonSouls", value - PlayerRef.GetAV("DragonSouls") + PlayerRef.GetBaseAV("DragonSouls"))
		SetSliderOptionValue(AV_DRAGONSOULS_SLIDER, value, "{0}")
	ELSEIF ( option == AV_SHOUTRECOVERYMULT_SLIDER)
		PlayerRef.SetAV("ShoutRecoveryMult", value - PlayerRef.GetAV("ShoutRecoveryMult") + PlayerRef.GetBaseAV("ShoutRecoveryMult"))
		SetSliderOptionValue(AV_SHOUTRECOVERYMULT_SLIDER, value, "{2}")
	ELSEIF ( option == AV_CARRYWEIGHT_SLIDER)
		PlayerRef.SetAV("CarryWeight", value)
		AV_CARRYWEIGHT_SLIDER_Var = value
		SetSliderOptionValue(AV_CARRYWEIGHT_SLIDER, value, "{0}")
	ELSEIF ( option == AV_SPEEDMULT_SLIDER)
		PlayerRef.SetAV("SpeedMult", value)
		AV_SPEEDMULT_SLIDER_Var = value
		SetSliderOptionValue(AV_SPEEDMULT_SLIDER, value, "{0}")
	ELSEIF ( option == AV_UNARMEDDAMAGE_SLIDER)
		PlayerRef.SetAV("UnarmedDamage", value)
		AV_UNARMEDDAMAGE_SLIDER_Var = value
		SetSliderOptionValue(AV_UNARMEDDAMAGE_SLIDER, value, "{0}")
	ELSEIF ( option == AV_MASS_SLIDER)
		PlayerRef.SetAV("Mass", value)
		AV_MASS_SLIDER_Var = value
		SetSliderOptionValue(AV_MASS_SLIDER, value, "{2}")
	ELSEIF ( option == AV_CRITCHANCE_SLIDER)
		PlayerRef.SetAV("CritChance", value)
		AV_CRITCHANCE_SLIDER_Var = value
		SetSliderOptionValue(AV_CRITCHANCE_SLIDER, value, "{0}")
	ELSEIF ( option == AV_ALTERATIONPOWERMOD_SLIDER)
		PlayerRef.SetAV("AlterationPowerMod", value - PlayerRef.GetAV("AlterationPowerMod") + PlayerRef.GetBaseAV("AlterationPowerMod"))
		SetSliderOptionValue(AV_ALTERATIONPOWERMOD_SLIDER, value, "{0}")
	ELSEIF ( option == AV_CONJURATIONPOWERMOD_SLIDER)
		PlayerRef.SetAV("ConjurationPowerMod", value - PlayerRef.GetAV("ConjurationPowerMod") + PlayerRef.GetBaseAV("ConjurationPowerMod"))
		SetSliderOptionValue(AV_CONJURATIONPOWERMOD_SLIDER, value, "{0}")
	ELSEIF ( option == AV_DESTRUCTIONPOWERMOD_SLIDER)
		PlayerRef.SetAV("DestructionPowerMod", value - PlayerRef.GetAV("DestructionPowerMod") + PlayerRef.GetBaseAV("DestructionPowerMod"))
		SetSliderOptionValue(AV_DESTRUCTIONPOWERMOD_SLIDER, value, "{0}")
	ELSEIF ( option == AV_ILLUSIONPOWERMOD_SLIDER)
		PlayerRef.SetAV("IllusionPowerMod", value - PlayerRef.GetAV("IllusionPowerMod") + PlayerRef.GetBaseAV("IllusionPowerMod"))
		SetSliderOptionValue(AV_ILLUSIONPOWERMOD_SLIDER, value, "{0}")
	ELSEIF ( option == AV_RESTORATIONPOWERMOD_SLIDER)
		PlayerRef.SetAV("RestorationPowerMod", value - PlayerRef.GetAV("RestorationPowerMod") + PlayerRef.GetBaseAV("RestorationPowerMod"))
		SetSliderOptionValue(AV_RESTORATIONPOWERMOD_SLIDER, value, "{0}")
	ELSEIF ( option == AV_BOWSTAGGERBONUS_SLIDER)
		PlayerRef.SetAV("BowStaggerBonus", value - PlayerRef.GetAV("BowStaggerBonus") + PlayerRef.GetBaseAV("BowStaggerBonus"))
		SetSliderOptionValue(AV_BOWSTAGGERBONUS_SLIDER, value, "{2}")
	ELSEIF ( option == AV_BOWSPEEDBONUSVAR_SLIDER)
		PlayerRef.SetAV("BowSpeedBonus", value)
		AV_BOWSPEEDBONUSVAR_SLIDER_Var = value
		SetSliderOptionValue(AV_BOWSPEEDBONUSVAR_SLIDER, value, "{2}")
	ELSEIF ( option == AV_LEFTWEAPONSPEEDMULT_SLIDER)
		PlayerRef.SetAV("LeftWeaponSpeedMult", value - PlayerRef.GetAV("LeftWeaponSpeedMult") + PlayerRef.GetBaseAV("LeftWeaponSpeedMult"))
		SetSliderOptionValue(AV_LEFTWEAPONSPEEDMULT_SLIDER, value, "{2}")
	ELSEIF ( option == AV_WEAPONSPEEDMULT_SLIDER)
		PlayerRef.SetAV("WeaponSpeedMult", value - PlayerRef.GetAV("WeaponSpeedMult") + PlayerRef.GetBaseAV("WeaponSpeedMult"))
		SetSliderOptionValue(AV_WEAPONSPEEDMULT_SLIDER, value, "{2}")
	ELSEIF ( option == AV_MAGICRESIST_SLIDER)
		PlayerRef.SetAV("MagicResist", value - PlayerRef.GetAV("MagicResist") + PlayerRef.GetBaseAV("MagicResist"))
		SetSliderOptionValue(AV_MAGICRESIST_SLIDER, value, "{0}")
	ELSEIF ( option == AV_FIRERESIST_SLIDER)
		PlayerRef.SetAV("FireResist", value - PlayerRef.GetAV("FireResist") + PlayerRef.GetBaseAV("FireResist"))
		SetSliderOptionValue(AV_FIRERESIST_SLIDER, value, "{0}")
	ELSEIF ( option == AV_POISONRESIST_SLIDER)
		PlayerRef.SetAV("PoisonResist", value - PlayerRef.GetAV("PoisonResist") + PlayerRef.GetBaseAV("PoisonResist"))
		SetSliderOptionValue(AV_POISONRESIST_SLIDER, value, "{0}")
	ELSEIF ( option == AV_ELECTRICRESIST_SLIDER)
		PlayerRef.SetAV("ElectricResist", value - PlayerRef.GetAV("ElectricResist") + PlayerRef.GetBaseAV("ElectricResist"))
		SetSliderOptionValue(AV_ELECTRICRESIST_SLIDER, value, "{0}")
	ELSEIF ( option == AV_DISEASERESIST_SLIDER)
		PlayerRef.SetAV("DiseaseResist", value - PlayerRef.GetAV("DiseaseResist") + PlayerRef.GetBaseAV("DiseaseResist"))
		SetSliderOptionValue(AV_DISEASERESIST_SLIDER, value, "{0}")
	ELSEIF ( option == AV_FROSTRESIST_SLIDER)
		PlayerRef.SetAV("FrostResist", value - PlayerRef.GetAV("FrostResist") + PlayerRef.GetBaseAV("FrostResist"))
		SetSliderOptionValue(AV_FROSTRESIST_SLIDER, value, "{0}")
	ELSEIF ( option == PERK_POINTS_SLIDER)
		SetPerkPoints(value AS INT)
		SetSliderOptionValue(PERK_POINTS_SLIDER, value)
	ELSEIF ( option == TIME_SCALE_SLIDER)
		TimeScale.SetValueInt(value AS INT)
		TIME_SCALE_SLIDER_VAR = value AS INT
		SetSliderOptionValue(TIME_SCALE_SLIDER, value, "{0}")
	ELSEIF ( option == FALLHEIGHT_MINNPC_SLIDER)
		SetGameSettingFloat("fJumpFallHeightMinNPC", value)
		FALLHEIGHT_MINNPC_SLIDER_VAR = value
		SetSliderOptionValue(FALLHEIGHT_MINNPC_SLIDER, value, "{0}")
	ELSEIF ( option == FALLHEIGHT_MIN_SLIDER)
		SetGameSettingFloat("fJumpFallHeightMin", value)
		FALLHEIGHT_MIN_SLIDER_VAR = value
		SetSliderOptionValue(FALLHEIGHT_MIN_SLIDER, value, "{0}")
	ELSEIF ( option == FALLHEIGHT_MULTNPC_SLIDER)
		SetGameSettingFloat("fJumpFallHeightMultNPC", value)
		FALLHEIGHT_MULTNPC_SLIDER_VAR = value
		SetSliderOptionValue(FALLHEIGHT_MULTNPC_SLIDER, value, "{1}")
	ELSEIF ( option == FALLHEIGHT_MULT_SLIDER)
		SetGameSettingFloat("fJumpFallHeightMult", value)
		FALLHEIGHT_MULT_SLIDER_VAR = value
		SetSliderOptionValue(FALLHEIGHT_MULT_SLIDER, value, "{1}")
	ELSEIF ( option == FALLHEIGHT_EXPNPC_SLIDER)
		SetGameSettingFloat("fJumpFallHeightExponentNPC", value)
		FALLHEIGHT_EXPNPC_SLIDER_VAR = value
		SetSliderOptionValue(FALLHEIGHT_EXPNPC_SLIDER, value, "{2}")
	ELSEIF ( option == FALLHEIGHT_EXP_SLIDER)
		SetGameSettingFloat("fJumpFallHeightExponent", value)
		FALLHEIGHT_EXP_SLIDER_VAR = value
		SetSliderOptionValue(FALLHEIGHT_EXP_SLIDER, value, "{2}")
	ELSEIF ( option == JUMP_HEIGHT_SLIDER)
		SetGameSettingFloat("fJumpHeightMin", value)
		JUMP_HEIGHT_SLIDER_VAR = value
		SetSliderOptionValue(JUMP_HEIGHT_SLIDER, value, "{0}")
	ELSEIF ( option == SWIM_BREATHBASE_SLIDER)
		SetGameSettingFloat("fActorSwimBreathBase", value)
		SWIM_BREATHBASE_SLIDER_VAR = value
		SetSliderOptionValue(SWIM_BREATHBASE_SLIDER, value, "{1} sec")
	ELSEIF ( option == SWIM_BREATHDAMAGE_SLIDER)
		SetGameSettingFloat("fActorSwimBreathDamage", value)
		SWIM_BREATHDAMAGE_SLIDER_VAR = value
		SetSliderOptionValue(SWIM_BREATHDAMAGE_SLIDER, value, "{2}")
	ELSEIF ( option == SWIM_BREATHMULT_SLIDER)
		SetGameSettingFloat("fActorSwimBreathMult", value)
		SWIM_BREATHMULT_SLIDER_VAR = value
		SetSliderOptionValue(SWIM_BREATHMULT_SLIDER, value, "{1} min")
	ELSEIF ( option == KILLCAM_CHANCE_SLIDER)
		SetGameSettingFloat("fKillCamBaseOdds", value)
		KILLCAM_CHANCE_SLIDER_VAR = value
		SetSliderOptionValue(KILLCAM_CHANCE_SLIDER, value, "{2}")
	ELSEIF ( option == DEATHCAMERA_TIME_SLIDER)
		SetGameSettingFloat("fPlayerDeathReloadTime", value)
		DEATHCAMERA_TIME_SLIDER_VAR = value
		SetSliderOptionValue(DEATHCAMERA_TIME_SLIDER, value, "{0} sec")
	ELSEIF ( option == KILLMOVE_CHANCE_SLIDER)
		KillMoveRandom.SetValue(value)
		KILLMOVE_CHANCE_SLIDER_VAR = value
		SetSliderOptionValue(KILLMOVE_CHANCE_SLIDER, value, "{0}%")
	ELSEIF ( option == DECAPITATION_CHANCE_SLIDER)
		DecapitationChance.SetValue(value)
		DECAPITATION_CHANCE_SLIDER_VAR = value
		SetSliderOptionValue(DECAPITATION_CHANCE_SLIDER, value, "{0}%")
	ELSEIF ( option == SPRINT_DRAINBASE_SLIDER)
		SetGameSettingFloat("fSprintStaminaDrainMult", value)
		SPRINT_DRAINBASE_SLIDER_VAR = value
		SetSliderOptionValue(SPRINT_DRAINBASE_SLIDER, value, "{2}")
	ELSEIF ( option == SPRINT_DRAINMULT_SLIDER)
		SetGameSettingFloat("fSprintStaminaWeightMult", value)
		SPRINT_DRAINMULT_SLIDER_VAR = value
		SetSliderOptionValue(SPRINT_DRAINMULT_SLIDER, value, "{2}")
	ELSEIF ( option == ARROW_RECOVERY_SLIDER)
		SetGameSettingInt("iArrowInventoryChance", value AS INT)
		ARROW_RECOVERY_SLIDER_VAR = value AS INT
		SetSliderOptionValue(ARROW_RECOVERY_SLIDER, value, "{0}%")
	ELSEIF ( option == DEATH_DROPCHANCE_SLIDER)
		SetGameSettingInt("iDeathDropWeaponChance", value AS INT)
		DEATH_DROPCHANCE_SLIDER_VAR = value AS INT
		SetSliderOptionValue(DEATH_DROPCHANCE_SLIDER, value, "{0}%")
	ELSEIF ( option == CAMERA_SHAKETIME_SLIDER)
		SetGameSettingFloat("fCameraShakeTime", value)
		CAMERA_SHAKETIME_SLIDER_VAR = value
		SetSliderOptionValue(CAMERA_SHAKETIME_SLIDER, value, "{2}")
	ELSEIF ( option == FASTRAVEL_SPEED_SLIDER)
		SetGameSettingFloat("fFastTravelSpeedMult", value)
		FASTRAVEL_SPEED_SLIDER_VAR = value
		SetSliderOptionValue(FASTRAVEL_SPEED_SLIDER, value, "{2}")
	ELSEIF ( option == HUDCOMPASS_DISTANEC_SLIDER)
		SetGameSettingFloat("fHUDCompassLocationMaxDist", value)
		HUDCOMPASS_DISTANEC_SLIDER_VAR = value
		SetSliderOptionValue(HUDCOMPASS_DISTANEC_SLIDER, value, "{0}")
	ELSEIF ( option == ATTACHED_ARROWS_SLIDER)
		SetGameSettingInt("iMaxAttachedArrows", value AS INT)
		ATTACHED_ARROWS_SLIDER_VAR = value AS INT
		SetSliderOptionValue(ATTACHED_ARROWS_SLIDER, value, "{0}")
	ELSEIF ( option == LightRadius_OID)
		SetLightRadius(Torch01, value AS INT)
		SetSliderOptionValue(LightRadius_OID, value)
	ELSEIF ( option == LightDuration_OID)
		SetLightDuration(Torch01, value AS INT)
		SetSliderOptionValue(LightDuration_OID, value)
	ELSEIF ( option == SPECIAL_LOOT_SLIDER)
		SpecialLootChance.SetValueInt(value AS INT)
		SPECIAL_LOOT_SLIDER_VAR = value AS INT
		SetSliderOptionValue(SPECIAL_LOOT_SLIDER, value, "{0}%")
	ELSEIF ( option == FRIENDHIT_TIMER_SLIDER)
		SetGameSettingFloat("fFriendHitTimer", value)
		FRIENDHIT_TIMER_SLIDER_VAR = value
		SetSliderOptionValue(FRIENDHIT_TIMER_SLIDER, value, "{1} sec")
	ELSEIF ( option == FRIENDHIT_INTERVAL_SLIDER)
		SetGameSettingFloat("fFriendMinimumLastHitTime", value)
		FRIENDHIT_INTERVAL_SLIDER_VAR = value
		SetSliderOptionValue(FRIENDHIT_INTERVAL_SLIDER, value, "{1} sec")
	ELSEIF ( option == FRIENDHIT_COMBAT_SLIDER)
		SetGameSettingInt("iFriendHitCombatAllowed", value AS INT)
		FRIENDHIT_COMBAT_SLIDER_VAR = value AS INT
		SetSliderOptionValue(FRIENDHIT_COMBAT_SLIDER, value, "{0}")
	ELSEIF ( option == FRIENDHIT_NONCOMBAT_SLIDER)
		SetGameSettingInt("iFriendHitNonCombatAllowed", value AS INT)
		FRIENDHIT_NONCOMBAT_SLIDER_VAR = value AS INT
		SetSliderOptionValue(FRIENDHIT_NONCOMBAT_SLIDER, value, "{0}")
	ELSEIF ( option == ALLYHIT_COMBAT_SLIDER)
		SetGameSettingInt("iAllyHitCombatAllowed", value AS INT)
		ALLYHIT_COMBAT_SLIDER_VAR = value AS INT
		SetSliderOptionValue(ALLYHIT_COMBAT_SLIDER, value, "{0}")
	ELSEIF ( option == ALLYHIT_NONCOMBAT_SLIDER)
		SetGameSettingInt("iAllyHitNonCombatAllowed", value AS INT)
		ALLYHIT_NONCOMBAT_SLIDER_VAR = value AS INT
		SetSliderOptionValue(ALLYHIT_NONCOMBAT_SLIDER, value, "{0}")
	ELSEIF ( option == COMBAT_DODGECHANCE_SLIDER)
		SetGameSettingFloat("fCombatDodgeChanceMax", value)
		COMBAT_DODGECHANCE_SLIDER_VAR = value
		SetSliderOptionValue(COMBAT_DODGECHANCE_SLIDER, value, "{1}")
	ELSEIF ( option == COMBAT_AIMOFFSET_SLIDER)
		SetGameSettingFloat("fCombatAimProjectileRandomOffset", value)
		COMBAT_AIMOFFSET_SLIDER_VAR = value
		SetSliderOptionValue(COMBAT_AIMOFFSET_SLIDER, value, "{0}")
	ELSEIF ( option == COMBAT_FLEEHEALTH_SLIDER)
		SetGameSettingFloat("fAIFleeHealthMult", value)
		COMBAT_FLEEHEALTH_SLIDER_VAR = value
		SetSliderOptionValue(COMBAT_FLEEHEALTH_SLIDER, value, "{0}%")
	ELSEIF ( option == DIALOGUE_PADDING_SLIDER)
		SetGameSettingFloat("fGameplayVoiceFilePadding", value)
		DIALOGUE_PADDING_SLIDER_VAR = value
		SetSliderOptionValue(DIALOGUE_PADDING_SLIDER, value, "{2} sec")
	ELSEIF ( option == DIALOGUE_DISTANCE_SLIDER)
		SetGameSettingFloat("fAIMinGreetingDistance", value)
		DIALOGUE_DISTANCE_SLIDER_VAR = value
		SetSliderOptionValue(DIALOGUE_DISTANCE_SLIDER, value, "{0}")
	ELSEIF ( option == FOLLOWER_SPACING_SLIDER)
		SetGameSettingFloat("fFollowSpaceBetweenFollowers", value)
		FOLLOWER_SPACING_SLIDER_VAR = value
		SetSliderOptionValue(FOLLOWER_SPACING_SLIDER, value, "{0}")
	ELSEIF ( option == FOLLOWER_CATCHUP_SLIDER)
		SetGameSettingFloat("fFollowExtraCatchUpSpeedMult", value)
		FOLLOWER_CATCHUP_SLIDER_VAR = value
		SetSliderOptionValue(FOLLOWER_CATCHUP_SLIDER, value, "{2}")
	ELSEIF ( option == LEVELSCALING_MULT_SLIDER)
		SetGameSettingFloat("fLevelScalingMult", value)
		LEVELSCALING_MULT_SLIDER_VAR = value
		SetSliderOptionValue(LEVELSCALING_MULT_SLIDER, value, "{2}")
	ELSEIF ( option == LEVELEDACTOR_EASY_SLIDER)
		SetGameSettingFloat("fLeveledActorMultEasy", value)
		LEVELEDACTOR_EASY_SLIDER_VAR = value
		SetSliderOptionValue(LEVELEDACTOR_EASY_SLIDER, value, "{2}")
	ELSEIF ( option == LEVELEDACTOR_HARD_SLIDER)
		SetGameSettingFloat("fLeveledActorMultHard", value)
		LEVELEDACTOR_HARD_SLIDER_VAR = value
		SetSliderOptionValue(LEVELEDACTOR_HARD_SLIDER, value, "{2}")
	ELSEIF ( option == LEVELEDACTOR_MEDIUM_SLIDER)
		SetGameSettingFloat("fLeveledActorMultMedium", value)
		LEVELEDACTOR_MEDIUM_SLIDER_VAR = value
		SetSliderOptionValue(LEVELEDACTOR_MEDIUM_SLIDER, value, "{2}")
	ELSEIF ( option == LEVELEDACTOR_VHARD_SLIDER)
		SetGameSettingFloat("fLeveledActorMultVeryHard", value)
		LEVELEDACTOR_VHARD_SLIDER_VAR = value
		SetSliderOptionValue(LEVELEDACTOR_VHARD_SLIDER, value, "{2}")
	ELSEIF ( option == RESPAWN_TIME_SLIDER)
		SetGameSettingInt("iHoursToRespawnCell", value AS INT)
		RESPAWN_TIME_SLIDER_VAR = value AS INT
		SetSliderOptionValue(RESPAWN_TIME_SLIDER, value, "{0}")
	ELSEIF ( option == NPC_HEALTHBONUS_SLIDER)
		SetGameSettingFloat("fNPCHealthLevelBonus", value)
		NPC_HEALTHBONUS_SLIDER_VAR = value
		SetSliderOptionValue(NPC_HEALTHBONUS_SLIDER, value, "{0}")
	ELSEIF ( option == LEVELUP_ATTRIBUTE_SLIDER)
		SetGameSettingInt("iAVDhmsLevelup", value AS INT)
		LEVELUP_ATTRIBUTE_SLIDER_VAR = value AS INT
		SetSliderOptionValue(LEVELUP_ATTRIBUTE_SLIDER, value, "{0}")
	ELSEIF ( option == LEVELUP_CARRYWEIGHT_SLIDER)
		SetGameSettingFloat("fLevelUpCarryWeightMod", value)
		LEVELUP_CARRYWEIGHT_SLIDER_VAR = value
		SetSliderOptionValue(LEVELUP_CARRYWEIGHT_SLIDER, value, "{0}")
	ELSEIF ( option == LEGENDARYRESET_LEVEL_SLIDER)
		SetGameSettingFloat("fLegendarySkillResetValue", value)
		LEGENDARYRESET_LEVEL_SLIDER_VAR = value
		SetSliderOptionValue(LEGENDARYRESET_LEVEL_SLIDER, value, "{0}")
	ELSEIF ( option == LEVELUP_POWER_SLIDER)
		SetGameSettingFloat("fSkillUseCurve", value)
		LEVELUP_POWER_SLIDER_VAR = value
		SetSliderOptionValue(LEVELUP_POWER_SLIDER, value, "{2}")
	ELSEIF ( option == LEVELUP_BASE_SLIDER)
		SetGameSettingFloat("fXPLevelUpBase", value)
		LEVELUP_BASE_SLIDER_VAR = value
		SetSliderOptionValue(LEVELUP_BASE_SLIDER, value, "{0}")
	ELSEIF ( option == LEVELUP_MULT_SLIDER)
		SetGameSettingFloat("fXPLevelUpMult", value)
		LEVELUP_MULT_SLIDER_VAR = value
		SetSliderOptionValue(LEVELUP_MULT_SLIDER, value, "{0}")
	ELSEIF ( option == SKILLUSE_ALCHEMY_SLIDER)
		GetAVIByID(16).SetSkillUseMult(value)
		SKILLUSE_ALCHEMY_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_ALCHEMY_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_ALTERATION_SLIDER)
		GetAVIByID(18).SetSkillUseMult(value)
		SKILLUSE_ALTERATION_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_ALTERATION_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_BLOCK_SLIDER)
		GetAVIByID(9).SetSkillUseMult(value)
		SKILLUSE_BLOCK_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_BLOCK_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_CONJURATION_SLIDER)
		GetAVIByID(19).SetSkillUseMult(value)
		SKILLUSE_CONJURATION_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_CONJURATION_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_DESTRUCTION_SLIDER)
		GetAVIByID(20).SetSkillUseMult(value)
		SKILLUSE_DESTRUCTION_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_DESTRUCTION_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_ENCHANTING_SLIDER)
		GetAVIByID(23).SetSkillUseMult(value)
		SKILLUSE_ENCHANTING_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_ENCHANTING_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_HEAVYARMOR_SLIDER)
		GetAVIByID(11).SetSkillUseMult(value)
		SKILLUSE_HEAVYARMOR_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_HEAVYARMOR_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_ILLUSION_SLIDER)
		GetAVIByID(21).SetSkillUseMult(value)
		SKILLUSE_ILLUSION_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_ILLUSION_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_LIGHTARMOR_SLIDER)
		GetAVIByID(12).SetSkillUseMult(value)
		SKILLUSE_LIGHTARMOR_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_LIGHTARMOR_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_LOCKPICKING_SLIDER)
		GetAVIByID(14).SetSkillUseMult(value)
		SKILLUSE_LOCKPICKING_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_LOCKPICKING_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_MARKSMAN_SLIDER)
		GetAVIByID(8).SetSkillUseMult(value)
		SKILLUSE_MARKSMAN_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_MARKSMAN_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_ONEHANDED_SLIDER)
		GetAVIByID(6).SetSkillUseMult(value)
		SKILLUSE_ONEHANDED_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_ONEHANDED_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_PICKPOCKET_SLIDER)
		GetAVIByID(13).SetSkillUseMult(value)
		SKILLUSE_PICKPOCKET_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_PICKPOCKET_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_RESTORATION_SLIDER)
		GetAVIByID(22).SetSkillUseMult(value)
		SKILLUSE_RESTORATION_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_RESTORATION_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_SMITHING_SLIDER)
		GetAVIByID(10).SetSkillUseMult(value)
		SKILLUSE_SMITHING_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_SMITHING_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_SNEAK_SLIDER)
		GetAVIByID(15).SetSkillUseMult(value)
		SKILLUSE_SNEAK_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_SNEAK_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_SPEECHCRAFT_SLIDER)
		GetAVIByID(17).SetSkillUseMult(value)
		SKILLUSE_SPEECHCRAFT_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_SPEECHCRAFT_SLIDER, value, "{2}")
	ELSEIF ( option == SKILLUSE_TWOHAND_SLIDER)
		GetAVIByID(7).SetSkillUseMult(value)
		SKILLUSE_TWOHAND_SLIDER_VAR = value
		SetSliderOptionValue(SKILLUSE_TWOHAND_SLIDER, value, "{2}")
	ELSEIF ( option == RFORCE_MIN_SLIDER)
		SetGameSettingFloat("fDeathForceRangedForceMin", value)
		RFORCE_MIN_SLIDER_VAR = value
		SetSliderOptionValue(RFORCE_MIN_SLIDER, value, "{0}")
	ELSEIF ( option == RFORCE_MAX_SLIDER)
		SetGameSettingFloat("fDeathForceRangedForceMax", value)
		RFORCE_MAX_SLIDER_VAR = value
		SetSliderOptionValue(RFORCE_MAX_SLIDER, value, "{0}")
	ELSEIF ( option == MFORCE_MIN_SLIDER)
		SetGameSettingFloat("fDeathForceForceMin", value)
		MFORCE_MIN_SLIDER_VAR = value
		SetSliderOptionValue(MFORCE_MIN_SLIDER, value, "{0}")
	ELSEIF ( option == MFORCE_MAX_SLIDER)
		SetGameSettingFloat("fDeathForceForceMax", value)
		MFORCE_MAX_SLIDER_VAR = value
		SetSliderOptionValue(MFORCE_MAX_SLIDER, value, "{0}")
	ELSEIF ( option == SFORCE_SLIDER)
		SetGameSettingFloat("fDeathForceSpellImpactMult", value)
		SFORCE_SLIDER_VAR = value
		SetSliderOptionValue(SFORCE_SLIDER, value, "{0}")
	ELSEIF ( option == GFORCE_SLIDER)
		SetGameSettingFloat("fZKeyMaxForce", value)
		GFORCE_SLIDER_VAR = value
		SetSliderOptionValue(GFORCE_SLIDER, value, "{0}")
	ELSEIF ( option == FIRST_FOV_SLIDER)
		SetINIFloat("fDefaultWorldFOV:Display", value)
		FIRST_FOV_SLIDER_VAR = value
		SetSliderOptionValue(FIRST_FOV_SLIDER, value, "{0}")
	ELSEIF ( option == THIRD_FOV_SLIDER)
		SetINIFloat("fDefault1stPersonFOV:Display", value)
		THIRD_FOV_SLIDER_VAR = value
		SetSliderOptionValue(THIRD_FOV_SLIDER, value, "{0}")
	ELSEIF ( option == XSENSITIVITY_SLIDER)
		SetINIFloat("fMouseHeadingXScale:Controls", value)
		XSENSITIVITY_SLIDER_VAR = value
		SetSliderOptionValue(XSENSITIVITY_SLIDER, value, "{3}")
	ELSEIF ( option == YSENSITIVITY_SLIDER)
		SetINIFloat("fMouseHeadingYScale:Controls", value)
		YSENSITIVITY_SLIDER_VAR = value
		SetSliderOptionValue(YSENSITIVITY_SLIDER, value, "{3}")
	ELSEIF ( option == COMBAT_SHOULDERY_SLIDER)
		SetINIFloat("fOverShoulderCombatAddY:Camera", value)
		COMBAT_SHOULDERY_SLIDER_VAR = value
		SetSliderOptionValue(COMBAT_SHOULDERY_SLIDER, value, "{0}")
	ELSEIF ( option == COMBAT_SHOULDERZ_SLIDER)
		SetINIFloat("fOverShoulderCombatPosZ:Camera", value)
		COMBAT_SHOULDERZ_SLIDER_VAR = value
		SetSliderOptionValue(COMBAT_SHOULDERZ_SLIDER, value, "{0}")
	ELSEIF ( option == COMBAT_SHOULDERX_SLIDER)
		SetINIFloat("fOverShoulderCombatPosX:Camera", value)
		COMBAT_SHOULDERX_SLIDER_VAR = value
		SetSliderOptionValue(COMBAT_SHOULDERX_SLIDER, value, "{0}")
	ELSEIF ( option == SHOULDERZ_SLIDER)
		SetINIFloat("fOverShoulderPosZ:Camera", value)
		SHOULDERZ_SLIDER_VAR = value
		SetSliderOptionValue(SHOULDERZ_SLIDER, value, "{0}")
	ELSEIF ( option == SHOULDERX_SLIDER)
		SetINIFloat("fOverShoulderPosX:Camera", value)
		SHOULDERX_SLIDER_VAR = value
		SetSliderOptionValue(SHOULDERX_SLIDER, value, "{0}")
	ELSEIF ( option == AUTOSAVE_COUNT_SLIDER)
		SetINIInt("iAutoSaveCount:SaveGame", value AS INT)
		AUTOSAVE_COUNT_SLIDER_VAR = value AS INT
		SetSliderOptionValue(AUTOSAVE_COUNT_SLIDER, value, "{0}")
	ELSEIF ( option == HAVOK_HIT_SLIDER)
		SetINIFloat("fHavokHitImpulseMult:Animation", value)
		HAVOK_HIT_SLIDER_VAR = value
		SetSliderOptionValue(HAVOK_HIT_SLIDER, value, "{0}")
	ELSEIF ( option == BOOK_SPEED_SLIDER)
		SetINIFloat("fBookOpenTime:Interface", value)
		BOOK_SPEED_SLIDER_VAR = value
		SetSliderOptionValue(BOOK_SPEED_SLIDER, value, "{0}")
	ELSEIF ( option == FIRST_ARROWTILT_SLIDER)
		SetINIFloat("f1PArrowTiltUpAngle:Combat", value)
		FIRST_ARROWTILT_SLIDER_VAR = value
		SetSliderOptionValue(FIRST_ARROWTILT_SLIDER, value, "{2}")
	ELSEIF ( option == THIRD_ARROWTILT_SLIDER)
		SetINIFloat("f3PArrowTiltUpAngle:Combat", value)
		THIRD_ARROWTILT_SLIDER_VAR = value
		SetSliderOptionValue(THIRD_ARROWTILT_SLIDER, value, "{2}")
	ELSEIF ( option == FIRST_BOLTTILT_SLIDER)
		SetINIFloat("f1PBoltTiltUpAngle:Combat", value)
		FIRST_BOLTTILT_SLIDER_VAR = value
		SetSliderOptionValue(FIRST_BOLTTILT_SLIDER, value, "{2}")
	ELSEIF ( option == NAVMESH_DISTANCE_SLIDER)
		SetINIFloat("fVisibleNavmeshMoveDist:Actor", value)
		NAVMESH_DISTANCE_SLIDER_VAR = value
		SetSliderOptionValue(NAVMESH_DISTANCE_SLIDER, value, "{0}")
	ELSEIF ( option == FRICTION_LAND_SLIDER)
		SetINIFloat("fLandFriction:Landscape", value)
		FRICTION_LAND_SLIDER_VAR = value
		SetSliderOptionValue(FRICTION_LAND_SLIDER, value, "{1}")
	ELSEIF ( option == CONSOLE_TEXT_SLIDER)
		SetINIInt("iConsoleTextSize:Menu", value AS INT)
		CONSOLE_TEXT_SLIDER_VAR = value AS INT
		SetSliderOptionValue(CONSOLE_TEXT_SLIDER, value, "{0}")
	ELSEIF ( option == CONSOLE_PERCENT_SLIDER)
		SetINIInt("iConsoleSizeScreenPercent:Menu", value AS INT)
		CONSOLE_PERCENT_SLIDER_VAR = value AS INT
		SetSliderOptionValue(CONSOLE_PERCENT_SLIDER, value, "{0}")
	ELSEIF ( option == MAP_YAW_SLIDER)
		SetINIFloat("fMapWorldYawRange:MapMenu", value)
		MAP_YAW_SLIDER_VAR = value
		SetSliderOptionValue(MAP_YAW_SLIDER, value, "{0}")
	ELSEIF ( option == MAP_PITCH_SLIDER)
		SetINIFloat("fMapWorldMaxPitch:MapMenu", value)
		MAP_PITCH_SLIDER_VAR = value
		SetSliderOptionValue(MAP_PITCH_SLIDER, value, "{0}")
	ELSEIF ( option == LEGENDARY_BONUS_SLIDER)
		GBT_legendaryBonus_Float = value
		SetSliderOptionValue(LEGENDARY_BONUS_SLIDER, value, "{0}")
	ELSEIF ( option == ARROW_FAMINE_SLIDER)
		GBT_arrowFamine_Float = value
		SetSliderOptionValue(ARROW_FAMINE_SLIDER, value, "{0}")
	ELSEIF ( option == SNEAK_FATIGUE_SLIDER)
		GBT_sneakFatigue_Float = value
		SetSliderOptionValue(SNEAK_FATIGUE_SLIDER, value, "{0}")
	ELSEIF ( option == TIMEDBLOCK_WEAPON_SLIDER)
		GBT_timeBlockWeapon_Float = value
		SetSliderOptionValue(TIMEDBLOCK_WEAPON_SLIDER, value, "{2}")
	ELSEIF ( option == TIMEDBLOCK_SHIELD_SLIDER)
		GBT_timeBlockShield_Float = value
		SetSliderOptionValue(TIMEDBLOCK_SHIELD_SLIDER, value, "{2}")
	ELSEIF ( option == TIMEDBLOCK_REFLECTTIME_SLIDER)
		GBT_timeBlockReflect_Float = value
		SetSliderOptionValue(TIMEDBLOCK_REFLECTTIME_SLIDER, value, "{2}")
	ELSEIF ( option == TIMEDBLOCK_REFLECTWARD_SLIDER)
		GBT_timeBlockWard_Float = value
		SetSliderOptionValue(TIMEDBLOCK_REFLECTWARD_SLIDER, value, "{2}")
	ELSEIF ( option == TIMEDBLOCK_REFLECTDMG_SLIDER)
		GBT_timeBlockDamage_Float = value
		SetSliderOptionValue(TIMEDBLOCK_REFLECTDMG_SLIDER, value, "{0}")
	ELSEIF ( option == TIMEDBLOCK_EXP_SLIDER)
		GBT_timeBlockXP_Float = value
		SetSliderOptionValue(TIMEDBLOCK_EXP_SLIDER, value, "{1}")
	ELSEIF ( option == ITEMLIMITER_LOCKPICK_SLIDER)
		GBT_limitLockpick_Int = value AS INT
		SetSliderOptionValue(ITEMLIMITER_LOCKPICK_SLIDER, value, "{0}")
	ELSEIF ( option == ITEMLIMITER_ARROW_SLIDER)
		GBT_limitArrow_Int = value AS INT
		SetSliderOptionValue(ITEMLIMITER_ARROW_SLIDER, value, "{0}")
	ELSEIF ( option == ITEMLIMITER_POTION_SLIDER)
		GBT_limitPotion_Int = value AS INT
		SetSliderOptionValue(ITEMLIMITER_POTION_SLIDER, value, "{0}")
	ELSEIF ( option == ITEMLIMITER_POISON_SLIDER)
		GBT_limitPoison_Int = value AS INT
		SetSliderOptionValue(ITEMLIMITER_POISON_SLIDER, value, "{0}")
	ELSEIF ( option == PLAYERSTAGGER_BASEDUR_SLIDER)
		GBT_staggerTaken_Float = value
		SetSliderOptionValue(PLAYERSTAGGER_BASEDUR_SLIDER, value, "{2}")
	ELSEIF ( option == PLAYERSTAGGER_IMMUNITY_SLIDER)
		GBT_staggerImmunity_Float = value
		SetSliderOptionValue(PLAYERSTAGGER_IMMUNITY_SLIDER, value, "{2}")
	ELSEIF ( option == PLAYERSTAGGER_ARMORWEIGHT_SLIDER)
		GBT_staggerArmor_Float = value
		SetSliderOptionValue(PLAYERSTAGGER_ARMORWEIGHT_SLIDER, value, "{0}")
	ELSEIF ( option == PLAYERSTAGGER_MAGICKACOST_SLIDER)
		GBT_staggerMagicka_Float = value
		SetSliderOptionValue(PLAYERSTAGGER_MAGICKACOST_SLIDER, value, "{0}")
	ELSEIF ( option == PLAYERSTAGGER_MINTHRESH_SLIDER)
		GBT_staggerMin_Float = value
		SetSliderOptionValue(PLAYERSTAGGER_MINTHRESH_SLIDER, value, "{2}")
	ELSEIF ( option == PLAYERSTAGGER_MAXTHRESH_SLIDER)
		GBT_staggerMax_Float = value
		SetSliderOptionValue(PLAYERSTAGGER_MAXTHRESH_SLIDER, value, "{1}")
	ELSEIF ( option == NPCSTAGGER_MULT_SLIDER)
		GBT_MeleeStaggerMult_Float = value
		SetSliderOptionValue(NPCSTAGGER_MULT_SLIDER, value, "{2}")
	ELSEIF ( option == NPCSTAGGER_BASE_SLIDER)
		GBT_MeleeStaggerBase_Float = value
		SetSliderOptionValue(NPCSTAGGER_BASE_SLIDER, value, "{2}")
	ELSEIF ( option == NPCSTAGGER_ARMORWEIGHT_SLIDER)
		GBT_MeleeStaggerWeight_Float = value
		SetSliderOptionValue(NPCSTAGGER_ARMORWEIGHT_SLIDER, value, "{2}")
	ELSEIF ( option == NPCSTAGGER_IMMUNITY_SLIDER)
		GBT_MeleeStaggerCD_Float = value
		SetSliderOptionValue(NPCSTAGGER_IMMUNITY_SLIDER, value, "{2}")
	ELSEIF ( option == BLEEDOUT_LOSSBASE_SLIDER)
		GBT_bleedoutBase_Float = value
		SetSliderOptionValue(BLEEDOUT_LOSSBASE_SLIDER, value, "{2}")
	ELSEIF ( option == BLEEDOUT_LOSSMULT_SLIDER)
		GBT_bleedoutMult_Int = value AS INT
		SetSliderOptionValue(BLEEDOUT_LOSSMULT_SLIDER, value, "{0}")
	ELSEIF ( option == BLEEDOUT_MAXLIVES_SLIDER)
		GBT_bleedoutLivesMax_Int = value AS INT
		SetSliderOptionValue(BLEEDOUT_MAXLIVES_SLIDER, value, "{0}")
	ELSEIF ( option == ARMOR_CMBEXP_SLIDER)
		GBT_ArmorExp_Float = value
		SetSliderOptionValue(ARMOR_CMBEXP_SLIDER, value, "{0}")
	ELSEIF ( option == BLOCK_CMBEXP_SLIDER)
		GBT_BlockExp_Float = value
		SetSliderOptionValue(BLOCK_CMBEXP_SLIDER, value, "{0}")
	ELSEIF ( option == FISSFILENAME_OID)
	ELSEIF ( option == SAVELOCAL_OID)
	ENDIF
ENDEVENT


EVENT OnOptionInputAccept(int option, string sResult)
	FLOAT value = sResult AS FLOAT
	IF ( option == SHOUT_SCALE_SLIDER)
		GBT_shoutScale.SetNthEntryValue(0, 1, ( value - 0 ) / 100 )
		IF value == 0.0
			PlayerRef.RemovePerk(GBT_shoutScale)
		ELSE
			PlayerRef.AddPerk(GBT_shoutScale)
		ENDIF
		SHOUT_SCALE_SLIDER_VAR = value
		SetInputOptionValue(SHOUT_SCALE_SLIDER, StringDecimals(value,1) + "%")
	ELSEIF ( option == TRAP_MAGNITUDE_SLIDER)
		GBT_trapMagnitude.SetNthEntryValue(0, 0, ( value - 0 ) / 100 )
		GBT_trapMagnitude.SetNthEntryValue(1, 0, ( value - 0 ) / 100 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_trapMagnitude)
		ELSE
			PlayerRef.AddPerk(GBT_trapMagnitude)
		ENDIF
		TRAP_MAGNITUDE_SLIDER_VAR = value
		SetInputOptionValue(TRAP_MAGNITUDE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == WEREDMG_DEALT_SLIDER)
		GBT_WerewolfDamageDealt.SetNthEntryValue(0, 0, ( value - 0 ) / 100 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_WerewolfDamageDealt)
		ELSE
			PlayerRef.AddPerk(GBT_WerewolfDamageDealt)
		ENDIF
		WEREDMG_DEALT_SLIDER_VAR = value
		SetInputOptionValue(WEREDMG_DEALT_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == WEREDMG_TAKEN_SLIDER)
		GBT_WerewolfDamageTaken.SetNthEntryValue(0, 0, ( value - 0 ) / 100 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_WerewolfDamageTaken)
		ELSE
			PlayerRef.AddPerk(GBT_WerewolfDamageTaken)
		ENDIF
		WEREDMG_TAKEN_SLIDER_VAR = value
		SetInputOptionValue(WEREDMG_TAKEN_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == POISON_DOSE_SLIDER)
		GBT_poisonDose.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 0.0
			PlayerRef.RemovePerk(GBT_poisonDose)
		ELSE
			PlayerRef.AddPerk(GBT_poisonDose)
		ENDIF
		POISON_DOSE_SLIDER_VAR = value
		SetInputOptionValue(POISON_DOSE_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == DUALCAST_POWER_SLIDER)
		SetGameSettingFloat("fMagicDualCastingEffectivenessBase", value)
		DUALCAST_POWER_SLIDER_VAR = value
		SetInputOptionValue(DUALCAST_POWER_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == DUALCAST_COST_SLIDER)
		SetGameSettingFloat("fMagicDualCastingCostMult", value)
		DUALCAST_COST_SLIDER_VAR = value
		SetInputOptionValue(DUALCAST_COST_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == MAGICCOST_SCALE_SLIDER)
		SetGameSettingFloat("fMagicCasterPCSkillCostBase", value)
		MAGICCOST_SCALE_SLIDER_VAR = value
		SetInputOptionValue(MAGICCOST_SCALE_SLIDER, StringDecimals(value,4)+ "")
	ELSEIF ( option == MAGIC_COST_SLIDER)
		SetGameSettingFloat("fMagicCasterPCSkillCostMult", value)
		MAGIC_COST_SLIDER_VAR = value
		SetInputOptionValue(MAGIC_COST_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == NPCMAGICCOST_SCALE_SLIDER)
		SetGameSettingFloat("fMagicCasterSkillCostBase", value)
		NPCMAGICCOST_SCALE_SLIDER_VAR = value
		SetInputOptionValue(NPCMAGICCOST_SCALE_SLIDER, StringDecimals(value,4)+ "")
	ELSEIF ( option == NPCMAGIC_COST_SLIDER)
		SetGameSettingFloat("fMagicCasterSkillCostMult", value)
		NPCMAGIC_COST_SLIDER_VAR = value
		SetInputOptionValue(NPCMAGIC_COST_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == MAX_RUNES_SLIDER)
		SetGameSettingInt("iMaxPlayerRunes", value AS INT)
		MAX_RUNES_SLIDER_VAR = value AS INT
		SetInputOptionValue(MAX_RUNES_SLIDER, value + "")
	ELSEIF ( option == MAX_SUMMONED_SLIDER)
		SetGameSettingInt("iMaxSummonedCreatures", value AS INT)
		MAX_SUMMONED_SLIDER_VAR = value AS INT
		SetInputOptionValue(MAX_SUMMONED_SLIDER, value + "")
	ELSEIF ( option == TELEKIN_DAMAGE_SLIDER)
		SetGameSettingFloat("fMagicTelekinesisDamageBase", value)
		TELEKIN_DAMAGE_SLIDER_VAR = value
		SetInputOptionValue(TELEKIN_DAMAGE_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == TELEKIN_DUALMULT_SLIDER)
		SetGameSettingFloat("fMagicTelekinesisDualCastDamageMult", value)
		TELEKIN_DUALMULT_SLIDER_VAR = value
		SetInputOptionValue(TELEKIN_DUALMULT_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == ALTMAG_SCALE_SLIDER)
		GBT_altScaleMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_altScaleMag)
		ELSE
			PlayerRef.AddPerk(GBT_altScaleMag)
		ENDIF
		ALTMAG_SCALE_SLIDER_VAR = value
		SetInputOptionValue(ALTMAG_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == CONJMAG_SCALE_SLIDER)
		GBT_conjScaleMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_conjScaleMag)
		ELSE
			PlayerRef.AddPerk(GBT_conjScaleMag)
		ENDIF
		CONJMAG_SCALE_SLIDER_VAR = value
		SetInputOptionValue(CONJMAG_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == ALTDURNOTPARA_SCALE_SLIDER)
		GBT_altScaleDurNotPara.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_altScaleDurNotPara)
		ELSE
			PlayerRef.AddPerk(GBT_altScaleDurNotPara)
		ENDIF
		ALTDURNOTPARA_SCALE_SLIDER_VAR = value
		SetInputOptionValue(ALTDURNOTPARA_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == CONJDUR_SCALE_SLIDER)
		GBT_conjScaleDur.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_conjScaleDur)
		ELSE
			PlayerRef.AddPerk(GBT_conjScaleDur)
		ENDIF
		CONJDUR_SCALE_SLIDER_VAR = value
		SetInputOptionValue(CONJDUR_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == ALTCOST_SCALE_SLIDER)
		GBT_altScaleCost.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_altScaleCost)
		ELSE
			PlayerRef.AddPerk(GBT_altScaleCost)
		ENDIF
		ALTCOST_SCALE_SLIDER_VAR = value
		SetInputOptionValue(ALTCOST_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == CONJCOST_SCALE_SLIDER)
		GBT_conjScaleCost.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_conjScaleCost)
		ELSE
			PlayerRef.AddPerk(GBT_conjScaleCost)
		ENDIF
		CONJCOST_SCALE_SLIDER_VAR = value
		SetInputOptionValue(CONJCOST_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == ALTDURPARA_SCALE_SLIDER)
		GBT_altScaleDurPara.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_altScaleDurPara)
		ELSE
			PlayerRef.AddPerk(GBT_altScaleDurPara)
		ENDIF
		ALTDURPARA_SCALE_SLIDER_VAR = value
		SetInputOptionValue(ALTDURPARA_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == BOUNTMELEE_SCALE_SLIDER)
		GBT_conjScaleBoundMelee.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_conjScaleBoundMelee)
		ELSE
			PlayerRef.AddPerk(GBT_conjScaleBoundMelee)
		ENDIF
		BOUNTMELEE_SCALE_SLIDER_VAR = value
		SetInputOptionValue(BOUNTMELEE_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == ALTCOSTDET_SCALE_SLIDER)
		GBT_altScaleCostDet.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_altScaleCostDet)
		ELSE
			PlayerRef.AddPerk(GBT_altScaleCostDet)
		ENDIF
		ALTCOSTDET_SCALE_SLIDER_VAR = value
		SetInputOptionValue(ALTCOSTDET_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == BOUNDBOW_SCALE_SLIDER)
		GBT_conjScaleBoundBow.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_conjScaleBoundBow)
		ELSE
			PlayerRef.AddPerk(GBT_conjScaleBoundBow)
		ENDIF
		BOUNDBOW_SCALE_SLIDER_VAR = value
		SetInputOptionValue(BOUNDBOW_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == DESMAG_SCALE_SLIDER)
		GBT_desScaleMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_desScaleMag)
		ELSE
			PlayerRef.AddPerk(GBT_desScaleMag)
		ENDIF
		DESMAG_SCALE_SLIDER_VAR = value
		SetInputOptionValue(DESMAG_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == HEALMAG_SCALE_SLIDER)
		GBT_restScaleMagHeal.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_restScaleMagHeal)
		ELSE
			PlayerRef.AddPerk(GBT_restScaleMagHeal)
		ENDIF
		HEALMAG_SCALE_SLIDER_VAR = value
		SetInputOptionValue(HEALMAG_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == DESDUR_SCALE_SLIDER)
		GBT_desScaleDur.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_desScaleDur)
		ELSE
			PlayerRef.AddPerk(GBT_desScaleDur)
		ENDIF
		DESDUR_SCALE_SLIDER_VAR = value
		SetInputOptionValue(DESDUR_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == HEALDUR_SCALE_SLIDER)
		GBT_restScaleDurHeal.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_restScaleDurHeal)
		ELSE
			PlayerRef.AddPerk(GBT_restScaleDurHeal)
		ENDIF
		HEALDUR_SCALE_SLIDER_VAR = value
		SetInputOptionValue(HEALDUR_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == DESCOST_SCALE_SLIDER)
		GBT_desScaleCost.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_desScaleCost)
		ELSE
			PlayerRef.AddPerk(GBT_desScaleCost)
		ENDIF
		DESCOST_SCALE_SLIDER_VAR = value
		SetInputOptionValue(DESCOST_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == HEALCOST_SCALE_SLIDER)
		GBT_restScaleCostHeal.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_restScaleCostHeal)
		ELSE
			PlayerRef.AddPerk(GBT_restScaleCostHeal)
		ENDIF
		HEALCOST_SCALE_SLIDER_VAR = value
		SetInputOptionValue(HEALCOST_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == ILLMAG_SCALE_SLIDER)
		GBT_illScaleMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_illScaleMag)
		ELSE
			PlayerRef.AddPerk(GBT_illScaleMag)
		ENDIF
		ILLMAG_SCALE_SLIDER_VAR = value
		SetInputOptionValue(ILLMAG_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == NONHEALMAG_SCALE_SLIDER)
		GBT_nonHealScaleMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_nonHealScaleMag)
		ELSE
			PlayerRef.AddPerk(GBT_nonHealScaleMag)
		ENDIF
		NONHEALMAG_SCALE_SLIDER_VAR = value
		SetInputOptionValue(NONHEALMAG_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == ILLDUR_SCALE_SLIDER)
		GBT_illScaleDur.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_illScaleDur)
		ELSE
			PlayerRef.AddPerk(GBT_illScaleDur)
		ENDIF
		ILLDUR_SCALE_SLIDER_VAR = value
		SetInputOptionValue(ILLDUR_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == NONHEALDUR_SCALE_SLIDER)
		GBT_nonHealScaleDur.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_nonHealScaleDur)
		ELSE
			PlayerRef.AddPerk(GBT_nonHealScaleDur)
		ENDIF
		NONHEALDUR_SCALE_SLIDER_VAR = value
		SetInputOptionValue(NONHEALDUR_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == ILLCOST_SCALE_SLIDER)
		GBT_illScaleCost.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_illScaleCost)
		ELSE
			PlayerRef.AddPerk(GBT_illScaleCost)
		ENDIF
		ILLCOST_SCALE_SLIDER_VAR = value
		SetInputOptionValue(ILLCOST_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == NONHEALCOST_SCALE_SLIDER)
		GBT_nonHealScaleCost.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_nonHealScaleCost)
		ELSE
			PlayerRef.AddPerk(GBT_nonHealScaleCost)
		ENDIF
		NONHEALCOST_SCALE_SLIDER_VAR = value
		SetInputOptionValue(NONHEALCOST_SCALE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == LESSERPOWER_COOLDOWN_SLIDER)
		SetGameSettingFloat("fMagicLesserPowerCooldownTimer", value)
		LESSERPOWER_COOLDOWN_SLIDER_VAR = value
		SetInputOptionValue(LESSERPOWER_COOLDOWN_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == DAMAGEDEALTSCALE_OID)
		scaleDamageDealt_VAR = value
		updateDamageDealtScaling()
		SetInputOptionValue(DAMAGEDEALTSCALE_OID, value + "x")
	ELSEIF ( option == DAMAGETAKENSCALE_OID)
		scaleDamageTaken_VAR = value
		updateDamageTakenScaling()
		SetInputOptionValue(DAMAGETAKENSCALE_OID, value + "x")
	ELSEIF ( option == DAMAGEDEALT_NOVICE_SLIDER)
		SetGameSettingFloat("fDiffMultHPByPCVE", value * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
		DAMAGEDEALT_NOVICE_SLIDER_VAR = value
		SetInputOptionValue(DAMAGEDEALT_NOVICE_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == DAMAGETAKEN_NOVICE_SLIDER)
		SetGameSettingFloat("fDiffMultHPToPCVE", value * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
		DAMAGETAKEN_NOVICE_SLIDER_VAR = value
		SetInputOptionValue(DAMAGETAKEN_NOVICE_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == DAMAGEDEALT_APPRENTICE_SLIDER)
		SetGameSettingFloat("fDiffMultHPByPCE", value * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
		DAMAGEDEALT_APPRENTICE_SLIDER_VAR = value
		SetInputOptionValue(DAMAGEDEALT_APPRENTICE_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == DAMAGETAKEN_APPRENTICE_SLIDER)
		SetGameSettingFloat("fDiffMultHPToPCE", value * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
		DAMAGETAKEN_APPRENTICE_SLIDER_VAR = value
		SetInputOptionValue(DAMAGETAKEN_APPRENTICE_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == DAMAGEDEALT_ADEPT_SLIDER)
		SetGameSettingFloat("fDiffMultHPByPCN", value * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
		DAMAGEDEALT_ADEPT_SLIDER_VAR = value
		SetInputOptionValue(DAMAGEDEALT_ADEPT_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == DAMAGETAKEN_ADEPT_SLIDER)
		SetGameSettingFloat("fDiffMultHPToPCN", value * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
		DAMAGETAKEN_ADEPT_SLIDER_VAR = value
		SetInputOptionValue(DAMAGETAKEN_ADEPT_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == DAMAGEDEALT_EXPERT_SLIDER)
		SetGameSettingFloat("fDiffMultHPByPCH", value * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
		DAMAGEDEALT_EXPERT_SLIDER_VAR = value
		SetInputOptionValue(DAMAGEDEALT_EXPERT_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == DAMAGETAKEN_EXPERT_SLIDER)
		SetGameSettingFloat("fDiffMultHPToPCH", value * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
		DAMAGETAKEN_EXPERT_SLIDER_VAR = value
		SetInputOptionValue(DAMAGETAKEN_EXPERT_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == DAMAGEDEALT_MASTER_SLIDER)
		SetGameSettingFloat("fDiffMultHPByPCVH", value * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
		DAMAGEDEALT_MASTER_SLIDER_VAR = value
		SetInputOptionValue(DAMAGEDEALT_MASTER_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == DAMAGETAKEN_MASTER_SLIDER)
		SetGameSettingFloat("fDiffMultHPToPCVH", value * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
		DAMAGETAKEN_MASTER_SLIDER_VAR = value
		SetInputOptionValue(DAMAGETAKEN_MASTER_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == DAMAGEDEALT_LEGENDARY_SLIDER)
		SetGameSettingFloat("fDiffMultHPByPCL", value * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
		DAMAGEDEALT_LEGENDARY_SLIDER_VAR = value
		SetInputOptionValue(DAMAGEDEALT_LEGENDARY_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == DAMAGETAKEN_LEGENDARY_SLIDER)
		SetGameSettingFloat("fDiffMultHPToPCL", value * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
		DAMAGETAKEN_LEGENDARY_SLIDER_VAR = value
		SetInputOptionValue(DAMAGETAKEN_LEGENDARY_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == WEAPONSCALE_PCMIN_SLIDER)
		SetGameSettingFloat("fDamagePCSkillMin", value)
		WEAPONSCALE_PCMIN_SLIDER_VAR = value
		SetInputOptionValue(WEAPONSCALE_PCMIN_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == WEAPONSCALE_PCMAX_SLIDER)
		SetGameSettingFloat("fDamagePCSkillMax", value)
		WEAPONSCALE_PCMAX_SLIDER_VAR = value
		SetInputOptionValue(WEAPONSCALE_PCMAX_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == WEAPONSCALE_NPCMIN_SLIDER)
		SetGameSettingFloat("fDamageSkillMin", value)
		WEAPONSCALE_NPCMIN_SLIDER_VAR = value
		SetInputOptionValue(WEAPONSCALE_NPCMIN_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == WEAPONSCALE_NPCMAX_SLIDER)
		SetGameSettingFloat("fDamageSkillMax", value)
		WEAPONSCALE_NPCMAX_SLIDER_VAR = value
		SetInputOptionValue(WEAPONSCALE_NPCMAX_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == ARMOR_SCALE_SLIDER)
		SetGameSettingFloat("fArmorScalingFactor", value)
		ARMOR_SCALE_SLIDER_VAR = value
		SetInputOptionValue(ARMOR_SCALE_SLIDER, StringDecimals(value,2)+ "%")
	ELSEIF ( option == MAX_RESISTANCE_SLIDER)
		SetGameSettingFloat("fPlayerMaxResistance", value)
		MAX_RESISTANCE_SLIDER_VAR = value
		SetInputOptionValue(MAX_RESISTANCE_SLIDER, StringDecimals(value,0)+ "%")
	ELSEIF ( option == ARMOR_BASERESIST_SLIDER)
		SetGameSettingFloat("fArmorBaseFactor", value)
		ARMOR_BASERESIST_SLIDER_VAR = value
		SetInputOptionValue(ARMOR_BASERESIST_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == ARMOR_MAXRESIST_SLIDER)
		SetGameSettingFloat("fMaxArmorRating", value)
		ARMOR_MAXRESIST_SLIDER_VAR = value
		SetInputOptionValue(ARMOR_MAXRESIST_SLIDER, StringDecimals(value,1)+ "%")
	ELSEIF ( option == PC_ARMORRATING_SLIDER)
		SetGameSettingFloat("fArmorRatingPCMax", value)
		PC_ARMORRATING_SLIDER_VAR = value
		SetInputOptionValue(PC_ARMORRATING_SLIDER, StringDecimals(value,3)+ "")
	ELSEIF ( option == NPC_ARMORRATING_SLIDER)
		SetGameSettingFloat("fArmorRatingMax", value)
		NPC_ARMORRATING_SLIDER_VAR = value
		SetInputOptionValue(NPC_ARMORRATING_SLIDER, StringDecimals(value,3)+ "")
	ELSEIF ( option == ENCUM_EFFECT_SLIDER)
		SetGameSettingFloat("fMoveEncumEffect", value)
		ENCUM_EFFECT_SLIDER_VAR = value
		SetInputOptionValue(ENCUM_EFFECT_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == ENCUMWEAP_EFFECT_SLIDER)
		SetGameSettingFloat("fMoveEncumEffectNoWeapon", value)
		ENCUMWEAP_EFFECT_SLIDER_VAR = value
		SetInputOptionValue(ENCUMWEAP_EFFECT_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == WEAPONDAMAGE_MULT_SLIDER)
		SetGameSettingFloat("fDamageWeaponMult", value)
		WEAPONDAMAGE_MULT_SLIDER_VAR = value
		SetInputOptionValue(WEAPONDAMAGE_MULT_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == TWOHAND_ATKSPD_SLIDER)
		SetGameSettingFloat("fWeaponTwoHandedAnimationSpeedMult", value)
		TWOHAND_ATKSPD_SLIDER_VAR = value
		SetInputOptionValue(TWOHAND_ATKSPD_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == AUTOAIM_AREA_SLIDER)
		SetGameSettingFloat("fAutoAimScreenPercentage", value)
		AUTOAIM_AREA_SLIDER_VAR = value
		SetInputOptionValue(AUTOAIM_AREA_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == AUTOAIM_RANGE_SLIDER)
		SetGameSettingFloat("fAutoAimMaxDistance", value)
		AUTOAIM_RANGE_SLIDER_VAR = value
		SetInputOptionValue(AUTOAIM_RANGE_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == AUTOAIM_DEGREES_SLIDER)
		SetGameSettingFloat("fAutoAimMaxDegrees", value)
		AUTOAIM_DEGREES_SLIDER_VAR = value
		SetInputOptionValue(AUTOAIM_DEGREES_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == AUTOAIM_DEGREESTHIRD_SLIDER)
		SetGameSettingFloat("fAutoAimMaxDegrees3rdPerson", value)
		AUTOAIM_DEGREESTHIRD_SLIDER_VAR = value
		SetInputOptionValue(AUTOAIM_DEGREESTHIRD_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == STAMINA_POWERCOST_SLIDER)
		SetGameSettingFloat("fPowerAttackStaminaPenalty", value)
		STAMINA_POWERCOST_SLIDER_VAR = value
		SetInputOptionValue(STAMINA_POWERCOST_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == STAMINA_BLOCKCOSTMULT_SLIDER)
		SetGameSettingFloat("fStaminaBlockDmgMult", value)
		STAMINA_BLOCKCOSTMULT_SLIDER_VAR = value
		SetInputOptionValue(STAMINA_BLOCKCOSTMULT_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == STAMINA_BASHCOST_SLIDER)
		SetGameSettingFloat("fStaminaBashBase", value)
		STAMINA_BASHCOST_SLIDER_VAR = value
		SetInputOptionValue(STAMINA_BASHCOST_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == STAMINA_POWERBASHCOST_SLIDER)
		SetGameSettingFloat("fStaminaPowerBashBase", value)
		STAMINA_POWERBASHCOST_SLIDER_VAR = value
		SetInputOptionValue(STAMINA_POWERBASHCOST_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == STAMINA_BLOCKCOSTBASE_SLIDER)
		SetGameSettingFloat("fStaminaBlockBase", value)
		STAMINA_BLOCKCOSTBASE_SLIDER_VAR = value
		SetInputOptionValue(STAMINA_BLOCKCOSTBASE_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == BLOCK_SHIELD_SLIDER)
		SetGameSettingFloat("fShieldBaseFactor", value)
		BLOCK_SHIELD_SLIDER_VAR = value
		SetInputOptionValue(BLOCK_SHIELD_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == BLOCK_WEAPON_SLIDER)
		SetGameSettingFloat("fBlockWeaponBase", value)
		BLOCK_WEAPON_SLIDER_VAR = value
		SetInputOptionValue(BLOCK_WEAPON_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == WEAPON_REACH_SLIDER)
		SetGameSettingFloat("fCombatDistance", value)
		WEAPON_REACH_SLIDER_VAR = value
		SetInputOptionValue(WEAPON_REACH_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == BASH_REACH_SLIDER)
		SetGameSettingFloat("fCombatBashReach", value)
		BASH_REACH_SLIDER_VAR = value
		SetInputOptionValue(BASH_REACH_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == AISEARCH_TIME_SLIDER)
		SetGameSettingFloat("fCombatStealthPointRegenAttackedWaitTime", value)
		AISEARCH_TIME_SLIDER_VAR = value
		SetInputOptionValue(AISEARCH_TIME_SLIDER, StringDecimals(value,0)+ " Sec")
	ELSEIF ( option == AISEARCH_TIMEATTACKED_SLIDER)
		SetGameSettingFloat("fCombatStealthPointRegenDetectedEventWaitTime", value)
		AISEARCH_TIMEATTACKED_SLIDER_VAR = value
		SetInputOptionValue(AISEARCH_TIMEATTACKED_SLIDER, StringDecimals(value,0)+ " Sec")
	ELSEIF ( option == SNEAKLEVEL_BASE_SLIDER)
		SetGameSettingFloat("fPlayerDetectionSneakBase", value)
		SNEAKLEVEL_BASE_SLIDER_VAR = value
		SetInputOptionValue(SNEAKLEVEL_BASE_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == SNEAKDETECTION_SCALE_SLIDER)
		SetGameSettingFloat("fPlayerDetectionSneakMult", value)
		SNEAKDETECTION_SCALE_SLIDER_VAR = value
		SetInputOptionValue(SNEAKDETECTION_SCALE_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == DETECTION_FOV_SLIDER)
		SetGameSettingFloat("fDetectionViewCone", value)
		DETECTION_FOV_SLIDER_VAR = value
		SetInputOptionValue(DETECTION_FOV_SLIDER, StringDecimals(value,0)+ " Deg")
	ELSEIF ( option == SNEAK_BASE_SLIDER)
		SetGameSettingFloat("fSneakBaseValue", value)
		SNEAK_BASE_SLIDER_VAR = value
		SetInputOptionValue(SNEAK_BASE_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == DETECTION_LIGHT_SLIDER)
		SetGameSettingFloat("fDetectionSneakLightMod", value)
		DETECTION_LIGHT_SLIDER_VAR = value
		SetInputOptionValue(DETECTION_LIGHT_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == DETECTION_LIGHTEXT_SLIDER)
		SetGameSettingFloat("fSneakLightExteriorMult", value)
		DETECTION_LIGHTEXT_SLIDER_VAR = value
		SetInputOptionValue(DETECTION_LIGHTEXT_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == DETECTION_SOUND_SLIDER)
		SetGameSettingFloat("fSneakSoundsMult", value)
		DETECTION_SOUND_SLIDER_VAR = value
		SetInputOptionValue(DETECTION_SOUND_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == DETECTION_SOUNDLOS_SLIDER)
		SetGameSettingFloat("fSneakSoundLosMult", value)
		DETECTION_SOUNDLOS_SLIDER_VAR = value
		SetInputOptionValue(DETECTION_SOUNDLOS_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == PICKPOCKET_MAXCHANCE_SLIDER)
		SetGameSettingFloat("fPickPocketMaxChance", value)
		PICKPOCKET_MAXCHANCE_SLIDER_VAR = value
		SetInputOptionValue(PICKPOCKET_MAXCHANCE_SLIDER, StringDecimals(value,0)+ "%")
	ELSEIF ( option == PICKPOCKET_MINCHANCE_SLIDER)
		SetGameSettingFloat("fPickPocketMinChance", value)
		PICKPOCKET_MINCHANCE_SLIDER_VAR = value
		SetInputOptionValue(PICKPOCKET_MINCHANCE_SLIDER, StringDecimals(value,0)+ "%")
	ELSEIF ( option == SNEAKMULT_MARKSMAN_SLIDER)
		GBT_SneakMarks.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakMarks)
		ELSE
			PlayerRef.AddPerk(GBT_SneakMarks)
		ENDIF
		SNEAKMULT_MARKSMAN_SLIDER_VAR = value
		SetInputOptionValue(SNEAKMULT_MARKSMAN_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SNEAKMULT_DAGGER_SLIDER)
		GBT_SneakDagger.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakDagger)
		ELSE
			PlayerRef.AddPerk(GBT_SneakDagger)
		ENDIF
		SNEAKMULT_DAGGER_SLIDER_VAR = value
		SetInputOptionValue(SNEAKMULT_DAGGER_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SNEAKMULT_TWOHAND_SLIDER)
		GBT_SneakOne.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakOne)
		ELSE
			PlayerRef.AddPerk(GBT_SneakOne)
		ENDIF
		SNEAKMULT_TWOHAND_SLIDER_VAR = value
		SetInputOptionValue(SNEAKMULT_TWOHAND_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SNEAKMULT_ONEHAND_SLIDER)
		GBT_SneakTwo.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakTwo)
		ELSE
			PlayerRef.AddPerk(GBT_SneakTwo)
		ENDIF
		SNEAKMULT_ONEHAND_SLIDER_VAR = value
		SetInputOptionValue(SNEAKMULT_ONEHAND_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SNEAKMULT_UNARMED_SLIDER)
		GBT_SneakH2H.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakH2H)
		ELSE
			PlayerRef.AddPerk(GBT_SneakH2H)
		ENDIF
		SNEAKMULT_UNARMED_SLIDER_VAR = value
		SetInputOptionValue(SNEAKMULT_UNARMED_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SNEAKMULT_RUNE_SLIDER)
		GBT_SneakRuneMag.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakRuneMag)
		ELSE
			PlayerRef.AddPerk(GBT_SneakRuneMag)
		ENDIF
		SNEAKMULT_RUNE_SLIDER_VAR = value
		SetInputOptionValue(SNEAKMULT_RUNE_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SNEAKMULT_SEARCH_SLIDER)
		GBT_SneakSearch.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakSearch)
		ELSE
			PlayerRef.AddPerk(GBT_SneakSearch)
		ENDIF
		SNEAKMULT_SEARCH_SLIDER_VAR = value
		SetInputOptionValue(SNEAKMULT_SEARCH_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SNEAKMULT_SPELLMAG_SLIDER)
		GBT_SneakSpellMag.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakSpellMag)
		ELSE
			PlayerRef.AddPerk(GBT_SneakSpellMag)
		ENDIF
		SNEAKMULT_SPELLMAG_SLIDER_VAR = value
		SetInputOptionValue(SNEAKMULT_SPELLMAG_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SNEAKMULT_SPELLSEARCH_SLIDER)
		GBT_SneakSpellSearch.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakSpellSearch)
		ELSE
			PlayerRef.AddPerk(GBT_SneakSpellSearch)
		ENDIF
		SNEAKMULT_SPELLSEARCH_SLIDER_VAR = value
		SetInputOptionValue(SNEAKMULT_SPELLSEARCH_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SNEAKMULT_SPELLDUR_SLIDER)
		GBT_SneakSpellDur.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakSpellDur)
		ELSE
			PlayerRef.AddPerk(GBT_SneakSpellDur)
		ENDIF
		SNEAKMULT_SPELLDUR_SLIDER_VAR = value
		SetInputOptionValue(SNEAKMULT_SPELLDUR_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SNEAKSCALE_PHYSICAL_SLIDER)
		GBT_SneakScalePhys.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_SneakScalePhys)
		ELSE
			PlayerRef.AddPerk(GBT_SneakScalePhys)
		ENDIF
		SNEAKSCALE_PHYSICAL_SLIDER_VAR = value
		SetInputOptionValue(SNEAKSCALE_PHYSICAL_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == SNEAKSCALE_SPELLMAG_SLIDER)
		GBT_SneakScaleSpell.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_SneakScaleSpell)
		ELSE
			PlayerRef.AddPerk(GBT_SneakScaleSpell)
		ENDIF
		SNEAKSCALE_SPELLMAG_SLIDER_VAR = value
		SetInputOptionValue(SNEAKSCALE_SPELLMAG_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == SNEAKMULT_POISONMAG_SLIDER)
		GBT_SneakPoisonMag.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakPoisonMag)
		ELSE
			PlayerRef.AddPerk(GBT_SneakPoisonMag)
		ENDIF
		SNEAKMULT_POISONMAG_SLIDER_VAR = value
		SetInputOptionValue(SNEAKMULT_POISONMAG_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SNEAKMULT_POISONDUR_SLIDER)
		GBT_SneakPoisonDur.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_SneakPoisonDur)
		ELSE
			PlayerRef.AddPerk(GBT_SneakPoisonDur)
		ENDIF
		SNEAKMULT_POISONDUR_SLIDER_VAR = value
		SetInputOptionValue(SNEAKMULT_POISONDUR_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SNEAKSCALE_POISONMAG_SLIDER)
		GBT_SneakScalePoisonMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_SneakScalePoisonMag)
		ELSE
			PlayerRef.AddPerk(GBT_SneakScalePoisonMag)
		ENDIF
		SNEAKSCALE_POISONMAG_SLIDER_VAR = value
		SetInputOptionValue(SNEAKSCALE_POISONMAG_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == SNEAKSCALE_POISONDUR_SLIDER)
		GBT_SneakScalePoisonDur.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_SneakScalePoisonDur)
		ELSE
			PlayerRef.AddPerk(GBT_SneakScalePoisonDur)
		ENDIF
		SNEAKSCALE_POISONDUR_SLIDER_VAR = value
		SetInputOptionValue(SNEAKSCALE_POISONDUR_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == LOCKPICK_VEASY_SLIDER)
		SetGameSettingFloat("fSweetSpotVeryEasy", value)
		LOCKPICK_VEASY_SLIDER_VAR = value
		SetInputOptionValue(LOCKPICK_VEASY_SLIDER, StringDecimals(value,4)+ "")
	ELSEIF ( option == LOCKPICKDUR_VEASY_SLIDER)
		SetGameSettingFloat("fLockpickBreakNovice", value)
		LOCKPICKDUR_VEASY_SLIDER_VAR = value
		SetInputOptionValue(LOCKPICKDUR_VEASY_SLIDER, StringDecimals(value,4)+ "")
	ELSEIF ( option == LOCKPICK_EASY_SLIDER)
		SetGameSettingFloat("fSweetSpotEasy", value)
		LOCKPICK_EASY_SLIDER_VAR = value
		SetInputOptionValue(LOCKPICK_EASY_SLIDER, StringDecimals(value,4)+ "")
	ELSEIF ( option == LOCKPICKDUR_EASY_SLIDER)
		SetGameSettingFloat("fLockpickBreakApprentice", value)
		LOCKPICKDUR_EASY_SLIDER_VAR = value
		SetInputOptionValue(LOCKPICKDUR_EASY_SLIDER, StringDecimals(value,4)+ "")
	ELSEIF ( option == LOCKPICK_AVERAGE_SLIDER)
		SetGameSettingFloat("fSweetSpotAverage", value)
		LOCKPICK_AVERAGE_SLIDER_VAR = value
		SetInputOptionValue(LOCKPICK_AVERAGE_SLIDER, StringDecimals(value,4)+ "")
	ELSEIF ( option == LOCKPICKDUR_AVERAGE_SLIDER)
		SetGameSettingFloat("fLockpickBreakAdept", value)
		LOCKPICKDUR_AVERAGE_SLIDER_VAR = value
		SetInputOptionValue(LOCKPICKDUR_AVERAGE_SLIDER, StringDecimals(value,4)+ "")
	ELSEIF ( option == LOCKPICK_HARD_SLIDER)
		SetGameSettingFloat("fSweetSpotHard", value)
		LOCKPICK_HARD_SLIDER_VAR = value
		SetInputOptionValue(LOCKPICK_HARD_SLIDER, StringDecimals(value,4)+ "")
	ELSEIF ( option == LOCKPICKDUR_HARD_SLIDER)
		SetGameSettingFloat("fLockpickBreakExpert", value)
		LOCKPICKDUR_HARD_SLIDER_VAR = value
		SetInputOptionValue(LOCKPICKDUR_HARD_SLIDER, StringDecimals(value,4)+ "")
	ELSEIF ( option == LOCKPICK_VHARD_SLIDER)
		SetGameSettingFloat("fSweetSpotVeryHard", value)
		LOCKPICK_VHARD_SLIDER_VAR = value
		SetInputOptionValue(LOCKPICK_VHARD_SLIDER, StringDecimals(value,4)+ "")
	ELSEIF ( option == LOCKPICKDUR_VHARD_SLIDER)
		SetGameSettingFloat("fLockpickBreakMaster", value)
		LOCKPICKDUR_VHARD_SLIDER_VAR = value
		SetInputOptionValue(LOCKPICKDUR_VHARD_SLIDER, StringDecimals(value,4)+ "")
	ELSEIF ( option == ALCHEMYMAG_MULT_SLIDER)
		SetGameSettingFloat("fAlchemyIngredientInitMult", value)
		ALCHEMYMAG_MULT_SLIDER_VAR = value
		SetInputOptionValue(ALCHEMYMAG_MULT_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == ALCHEMYMAG_SCALE_SLIDER)
		SetGameSettingFloat("fAlchemySkillFactor", value)
		ALCHEMYMAG_SCALE_SLIDER_VAR = value
		SetInputOptionValue(ALCHEMYMAG_SCALE_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == BONUS_INGR_SLIDER)
		GBT_bonusIngredients.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 0.0
			PlayerRef.RemovePerk(GBT_bonusIngredients)
		ELSE
			PlayerRef.AddPerk(GBT_bonusIngredients)
		ENDIF
		BONUS_INGR_SLIDER_VAR = value
		SetInputOptionValue(BONUS_INGR_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == BONUS_POTION_SLIDER)
		GBT_bonusPotions.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 0.0
			PlayerRef.RemovePerk(GBT_bonusPotions)
		ELSE
			PlayerRef.AddPerk(GBT_bonusPotions)
		ENDIF
		BONUS_POTION_SLIDER_VAR = value
		SetInputOptionValue(BONUS_POTION_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == CHARGECOST_POWER_SLIDER)
		SetGameSettingFloat("fEnchantingCostExponent", value)
		CHARGECOST_POWER_SLIDER_VAR = value
		SetInputOptionValue(CHARGECOST_POWER_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == ENCHANT_SCALING_SLIDER)
		SetGameSettingFloat("fEnchantingSkillFactor", value)
		ENCHANT_SCALING_SLIDER_VAR = value
		SetInputOptionValue(ENCHANT_SCALING_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == CHARGECOST_MULT_SLIDER)
		SetGameSettingFloat("fEnchantingSkillCostMult", value)
		CHARGECOST_MULT_SLIDER_VAR = value
		SetInputOptionValue(CHARGECOST_MULT_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == ENCHANTPRICE_EFFECT_SLIDER)
		SetGameSettingFloat("fEnchantmentEffectPointsMult", value)
		ENCHANTPRICE_EFFECT_SLIDER_VAR = value
		SetInputOptionValue(ENCHANTPRICE_EFFECT_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == CHARGECOST_BASE_SLIDER)
		SetGameSettingFloat("fEnchantingSkillCostBase", value)
		CHARGECOST_BASE_SLIDER_VAR = value
		SetInputOptionValue(CHARGECOST_BASE_SLIDER, StringDecimals(value,3)+ "")
	ELSEIF ( option == ENCHANTPRICE_SOUL_SLIDER)
		SetGameSettingFloat("fEnchantmentPointsMult", value)
		ENCHANTPRICE_SOUL_SLIDER_VAR = value
		SetInputOptionValue(ENCHANTPRICE_SOUL_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == ENCHANT_CHARGE_SLIDER)
		GBT_enchantCharge.SetNthEntryValue(0, 0, ( value - 0 ) / 100 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_enchantCharge)
		ELSE
			PlayerRef.AddPerk(GBT_enchantCharge)
		ENDIF
		ENCHANT_CHARGE_SLIDER_VAR = value
		SetInputOptionValue(ENCHANT_CHARGE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == ENCHANT_MAG_SLIDER)
		GBT_enchantMag.SetNthEntryValue(0, 0, ( value - 0 ) / 100 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_enchantMag)
		ELSE
			PlayerRef.AddPerk(GBT_enchantMag)
		ENDIF
		ENCHANT_MAG_SLIDER_VAR = value
		SetInputOptionValue(ENCHANT_MAG_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == BONUS_ENCHANT_SLIDER)
		GBT_bonusEnchants.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 0.0
			PlayerRef.RemovePerk(GBT_bonusEnchants)
		ELSE
			PlayerRef.AddPerk(GBT_bonusEnchants)
		ENDIF
		BONUS_ENCHANT_SLIDER_VAR = value
		SetInputOptionValue(BONUS_ENCHANT_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == TEMPER_SUFFIX_SLIDER)
		SetGameSettingFloat("fSmithingConditionFactor", value)
		TEMPER_SUFFIX_SLIDER_VAR = value
		SetInputOptionValue(TEMPER_SUFFIX_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == TEMPER_ARMOR_SLIDER)
		SetGameSettingFloat("fSmithingArmorMax", value)
		TEMPER_ARMOR_SLIDER_VAR = value
		SetInputOptionValue(TEMPER_ARMOR_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == TEMPER_WEAPON_SLIDER)
		SetGameSettingFloat("fSmithingWeaponMax", value)
		TEMPER_WEAPON_SLIDER_VAR = value
		SetInputOptionValue(TEMPER_WEAPON_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == POTION_MAG_SLIDER)
		GBT_PotionMag.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_PotionMag)
		ELSE
			PlayerRef.AddPerk(GBT_PotionMag)
		ENDIF
		POTION_MAG_SLIDER_VAR = value
		SetInputOptionValue(POTION_MAG_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == POTION_DUR_SLIDER)
		GBT_PotionDur.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_PotionDur)
		ELSE
			PlayerRef.AddPerk(GBT_PotionDur)
		ENDIF
		POTION_DUR_SLIDER_VAR = value
		SetInputOptionValue(POTION_DUR_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == POTION_SCALEMAG_SLIDER)
		GBT_PotionScaleMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_PotionScaleMag)
		ELSE
			PlayerRef.AddPerk(GBT_PotionScaleMag)
		ENDIF
		POTION_SCALEMAG_SLIDER_VAR = value
		SetInputOptionValue(POTION_SCALEMAG_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == POTION_SCALEDUR_SLIDER)
		GBT_PotionScaleDur.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_PotionScaleDur)
		ELSE
			PlayerRef.AddPerk(GBT_PotionScaleDur)
		ENDIF
		POTION_SCALEDUR_SLIDER_VAR = value
		SetInputOptionValue(POTION_SCALEDUR_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == POISON_MAG_SLIDER)
		GBT_PoisonMag.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_PoisonMag)
		ELSE
			PlayerRef.AddPerk(GBT_PoisonMag)
		ENDIF
		POISON_MAG_SLIDER_VAR = value
		SetInputOptionValue(POISON_MAG_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == POISON_DUR_SLIDER)
		GBT_PoisonDur.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_PoisonDur)
		ELSE
			PlayerRef.AddPerk(GBT_PoisonDur)
		ENDIF
		POISON_DUR_SLIDER_VAR = value
		SetInputOptionValue(POISON_DUR_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == POISON_SCALEMAG_SLIDER)
		GBT_PoisonScaleMag.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_PoisonScaleMag)
		ELSE
			PlayerRef.AddPerk(GBT_PoisonScaleMag)
		ENDIF
		POISON_SCALEMAG_SLIDER_VAR = value
		SetInputOptionValue(POISON_SCALEMAG_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == POISON_SCALEDUR_SLIDER)
		GBT_PoisonScaleDur.SetNthEntryValue(0, 1, ( value - 100 ) / 10000 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_PoisonScaleDur)
		ELSE
			PlayerRef.AddPerk(GBT_PoisonScaleDur)
		ENDIF
		POISON_SCALEDUR_SLIDER_VAR = value
		SetInputOptionValue(POISON_SCALEDUR_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == SCROLL_MAG_SLIDER)
		GBT_ScrollMag.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_ScrollMag)
		ELSE
			PlayerRef.AddPerk(GBT_ScrollMag)
		ENDIF
		SCROLL_MAG_SLIDER_VAR = value
		SetInputOptionValue(SCROLL_MAG_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SCROLL_DUR_SLIDER)
		GBT_ScrollDur.SetNthEntryValue(0, 0, ( value - 0 ) / 1 )
		IF value == 1.0
			PlayerRef.RemovePerk(GBT_ScrollDur)
		ELSE
			PlayerRef.AddPerk(GBT_ScrollDur)
		ENDIF
		SCROLL_DUR_SLIDER_VAR = value
		SetInputOptionValue(SCROLL_DUR_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == BARTER_BUYMIN_SLIDER)
		SetGameSettingFloat("fBarterBuyMin", value)
		BARTER_BUYMIN_SLIDER_VAR = value
		SetInputOptionValue(BARTER_BUYMIN_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == BARTER_SELLMAX_SLIDER)
		SetGameSettingFloat("fBarterSellMax", value)
		BARTER_SELLMAX_SLIDER_VAR = value
		SetInputOptionValue(BARTER_SELLMAX_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == BARTER_MIN_SLIDER)
		SetGameSettingFloat("fBarterMin", value)
		BARTER_MIN_SLIDER_VAR = value
		SetInputOptionValue(BARTER_MIN_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == BARTER_MAX_SLIDER)
		SetGameSettingFloat("fBarterMax", value)
		BARTER_MAX_SLIDER_VAR = value
		SetInputOptionValue(BARTER_MAX_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == BUY_PRICE_SLIDER)
		GBT_buyPrice.SetNthEntryValue(0, 0, ( value - 0 ) / 100 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_buyPrice)
		ELSE
			PlayerRef.AddPerk(GBT_buyPrice)
		ENDIF
		BUY_PRICE_SLIDER_VAR = value
		SetInputOptionValue(BUY_PRICE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == SELL_PRICE_SLIDER)
		GBT_sellPrice.SetNthEntryValue(0, 0, ( value - 0 ) / 100 )
		IF value == 100.0
			PlayerRef.RemovePerk(GBT_sellPrice)
		ELSE
			PlayerRef.AddPerk(GBT_sellPrice)
		ENDIF
		SELL_PRICE_SLIDER_VAR = value
		SetInputOptionValue(SELL_PRICE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == VENDOR_RESPAWN_SLIDER)
		SetGameSettingInt("iDaysToRespawnVendor", value AS INT)
		VENDOR_RESPAWN_SLIDER_VAR = value AS INT
		SetInputOptionValue(VENDOR_RESPAWN_SLIDER, value + "")
	ELSEIF ( option == TRAINING_NUMALLOWED_SLIDER)
		SetGameSettingInt("iTrainingNumAllowedPerLevel", value AS INT)
		TRAINING_NUMALLOWED_SLIDER_VAR = value AS INT
		SetInputOptionValue(TRAINING_NUMALLOWED_SLIDER, value + "")
	ELSEIF ( option == TRAINING_JOURNEYMANCOST_SLIDER)
		SetGameSettingInt("iTrainingJourneymanCost", value AS INT)
		TRAINING_JOURNEYMANCOST_SLIDER_VAR = value AS INT
		SetInputOptionValue(TRAINING_JOURNEYMANCOST_SLIDER, value + "")
	ELSEIF ( option == TRAINING_JOURNEYMANSKILL_SLIDER)
		SetGameSettingInt("iTrainingJourneymanSkill", value AS INT)
		TRAINING_JOURNEYMANSKILL_SLIDER_VAR = value AS INT
		SetInputOptionValue(TRAINING_JOURNEYMANSKILL_SLIDER, value + "")
	ELSEIF ( option == TRAINING_EXPERTCOST_SLIDER)
		SetGameSettingInt("iTrainingExpertCost", value AS INT)
		TRAINING_EXPERTCOST_SLIDER_VAR = value AS INT
		SetInputOptionValue(TRAINING_EXPERTCOST_SLIDER, value + "")
	ELSEIF ( option == TRAINING_EXPERTSKILL_SLIDER)
		SetGameSettingInt("iTrainingExpertSkill", value AS INT)
		TRAINING_EXPERTSKILL_SLIDER_VAR = value AS INT
		SetInputOptionValue(TRAINING_EXPERTSKILL_SLIDER, value + "")
	ELSEIF ( option == TRAINING_MASTERCOST_SLIDER)
		SetGameSettingInt("iTrainingMasterCost", value AS INT)
		TRAINING_MASTERCOST_SLIDER_VAR = value AS INT
		SetInputOptionValue(TRAINING_MASTERCOST_SLIDER, value + "")
	ELSEIF ( option == TRAINING_MASTERSKILL_SLIDER)
		SetGameSettingInt("iTrainingMasterSkill", value AS INT)
		TRAINING_MASTERSKILL_SLIDER_VAR = value AS INT
		SetInputOptionValue(TRAINING_MASTERSKILL_SLIDER, value + "")
	ELSEIF ( option == APOTHECARY_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldApothecary,0,value AS INT)
		APOTHECARY_GOLD_SLIDER_VAR = value AS INT
		SetInputOptionValue(APOTHECARY_GOLD_SLIDER, value + "")
	ELSEIF ( option == BLACKSMITH_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldBlacksmith,0,value AS INT)
		BLACKSMITH_GOLD_SLIDER_VAR = value AS INT
		SetInputOptionValue(BLACKSMITH_GOLD_SLIDER, value + "")
	ELSEIF ( option == ORCBLACKSMITH_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldBlacksmithOrc,0,value AS INT)
		ORCBLACKSMITH_GOLD_SLIDER_VAR = value AS INT
		SetInputOptionValue(ORCBLACKSMITH_GOLD_SLIDER, value + "")
	ELSEIF ( option == TOWNBLACKSMITH_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldBlacksmithTown,0,value AS INT)
		TOWNBLACKSMITH_GOLD_SLIDER_VAR = value AS INT
		SetInputOptionValue(TOWNBLACKSMITH_GOLD_SLIDER, value + "")
	ELSEIF ( option == INNKEERPER_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldInn,0,value AS INT)
		INNKEERPER_GOLD_SLIDER_VAR = value AS INT
		SetInputOptionValue(INNKEERPER_GOLD_SLIDER, value + "")
	ELSEIF ( option == MISCMERCHANT_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldMisc,0,value AS INT)
		MISCMERCHANT_GOLD_SLIDER_VAR = value AS INT
		SetInputOptionValue(MISCMERCHANT_GOLD_SLIDER, value + "")
	ELSEIF ( option == SPELLMERCHANT_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldSpells,0,value AS INT)
		SPELLMERCHANT_GOLD_SLIDER_VAR = value AS INT
		SetInputOptionValue(SPELLMERCHANT_GOLD_SLIDER, value + "")
	ELSEIF ( option == STREETVENDOR_GOLD_SLIDER)
		SetNthLevelItemCount(VendorGoldStreetVendor,0,value AS INT)
		STREETVENDOR_GOLD_SLIDER_VAR = value AS INT
		SetInputOptionValue(STREETVENDOR_GOLD_SLIDER, value + "")
	ELSEIF ( option == COMBAT_STAMINAREGEN_SLIDER)
		SetGameSettingFloat("fCombatStaminaRegenRateMult", value)
		COMBAT_STAMINAREGEN_SLIDER_VAR = value
		SetInputOptionValue(COMBAT_STAMINAREGEN_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == AV_COMBATHEALTHREGENMULT_SLIDER)
		PlayerRef.SetAV("CombatHealthRegenMult", value - PlayerRef.GetAV("CombatHealthRegenMult") + PlayerRef.GetBaseAV("CombatHealthRegenMult"))
		SetInputOptionValue(AV_COMBATHEALTHREGENMULT_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == DAMAGESTAMINA_DELAY_SLIDER)
		SetGameSettingFloat("fDamagedStaminaRegenDelay", value)
		DAMAGESTAMINA_DELAY_SLIDER_VAR = value
		SetInputOptionValue(DAMAGESTAMINA_DELAY_SLIDER, StringDecimals(value,1)+ " sec")
	ELSEIF ( option == BOWZOOM_REGENDELAY_SLIDER)
		SetGameSettingFloat("fBowZoomStaminaRegenDelay", value)
		BOWZOOM_REGENDELAY_SLIDER_VAR = value
		SetInputOptionValue(BOWZOOM_REGENDELAY_SLIDER, StringDecimals(value,1)+ " sec")
	ELSEIF ( option == COMBAT_MAGICKAREGEN_SLIDER)
		SetGameSettingFloat("fCombatMagickaRegenRateMult", value)
		COMBAT_MAGICKAREGEN_SLIDER_VAR = value
		SetInputOptionValue(COMBAT_MAGICKAREGEN_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == STAMINA_REGENDELAY_SLIDER)
		SetGameSettingFloat("fStaminaRegenDelayMax", value)
		STAMINA_REGENDELAY_SLIDER_VAR = value
		SetInputOptionValue(STAMINA_REGENDELAY_SLIDER, StringDecimals(value,1)+ " sec")
	ELSEIF ( option == DAMAGEMAGICKA_DELAY_SLIDER)
		SetGameSettingFloat("fDamagedMagickaRegenDelay", value)
		DAMAGEMAGICKA_DELAY_SLIDER_VAR = value
		SetInputOptionValue(DAMAGEMAGICKA_DELAY_SLIDER, StringDecimals(value,1)+ " sec")
	ELSEIF ( option == MAGICKA_REGENDELAY_SLIDER)
		SetGameSettingFloat("fMagickaRegenDelayMax", value)
		MAGICKA_REGENDELAY_SLIDER_VAR = value
		SetInputOptionValue(MAGICKA_REGENDELAY_SLIDER, StringDecimals(value,1)+ " sec")
	ELSEIF ( option == AV_HEALRATEMULT_SLIDER)
		PlayerRef.SetAV("HealRateMult", value - PlayerRef.GetAV("HealRateMult") + PlayerRef.GetBaseAV("HealRateMult"))
		SetInputOptionValue(AV_HEALRATEMULT_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_HEALRATE_SLIDER)
		PlayerRef.SetAV("HealRate", value)
		AV_HEALRATE_SLIDER_Var = value
		SetInputOptionValue(AV_HEALRATE_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == AV_MAGICKARATEMULT_SLIDER)
		PlayerRef.SetAV("MagickaRateMult", value - PlayerRef.GetAV("MagickaRateMult") + PlayerRef.GetBaseAV("MagickaRateMult"))
		SetInputOptionValue(AV_MAGICKARATEMULT_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_MAGICKARATE_SLIDER)
		PlayerRef.SetAV("MagickaRate", value)
		AV_MAGICKARATE_SLIDER_Var = value
		SetInputOptionValue(AV_MAGICKARATE_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == AV_STAMINARATEMULT_SLIDER)
		PlayerRef.SetAV("StaminaRateMult", value - PlayerRef.GetAV("StaminaRateMult") + PlayerRef.GetBaseAV("StaminaRateMult"))
		SetInputOptionValue(AV_STAMINARATEMULT_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_STAMINARATE_SLIDER)
		PlayerRef.SetAV("StaminaRate", value)
		AV_STAMINARATE_SLIDER_Var = value
		SetInputOptionValue(AV_STAMINARATE_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == AV_HEALTH_SLIDER)
		PlayerRef.SetAV("Health", value - PlayerRef.GetAV("Health") + PlayerRef.GetBaseAV("Health"))
		SetInputOptionValue(AV_HEALTH_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_MAGICKA_SLIDER)
		PlayerRef.SetAV("Magicka", value - PlayerRef.GetAV("Magicka") + PlayerRef.GetBaseAV("Magicka"))
		SetInputOptionValue(AV_MAGICKA_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_STAMINA_SLIDER)
		PlayerRef.SetAV("Stamina", value - PlayerRef.GetAV("Stamina") + PlayerRef.GetBaseAV("Stamina"))
		SetInputOptionValue(AV_STAMINA_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_DRAGONSOULS_SLIDER)
		PlayerRef.SetAV("DragonSouls", value - PlayerRef.GetAV("DragonSouls") + PlayerRef.GetBaseAV("DragonSouls"))
		SetInputOptionValue(AV_DRAGONSOULS_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_SHOUTRECOVERYMULT_SLIDER)
		PlayerRef.SetAV("ShoutRecoveryMult", value - PlayerRef.GetAV("ShoutRecoveryMult") + PlayerRef.GetBaseAV("ShoutRecoveryMult"))
		SetInputOptionValue(AV_SHOUTRECOVERYMULT_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == AV_CARRYWEIGHT_SLIDER)
		PlayerRef.SetAV("CarryWeight", value)
		AV_CARRYWEIGHT_SLIDER_Var = value
		SetInputOptionValue(AV_CARRYWEIGHT_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_SPEEDMULT_SLIDER)
		PlayerRef.SetAV("SpeedMult", value)
		AV_SPEEDMULT_SLIDER_Var = value
		SetInputOptionValue(AV_SPEEDMULT_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_UNARMEDDAMAGE_SLIDER)
		PlayerRef.SetAV("UnarmedDamage", value)
		AV_UNARMEDDAMAGE_SLIDER_Var = value
		SetInputOptionValue(AV_UNARMEDDAMAGE_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_MASS_SLIDER)
		PlayerRef.SetAV("Mass", value)
		AV_MASS_SLIDER_Var = value
		SetInputOptionValue(AV_MASS_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == AV_CRITCHANCE_SLIDER)
		PlayerRef.SetAV("CritChance", value)
		AV_CRITCHANCE_SLIDER_Var = value
		SetInputOptionValue(AV_CRITCHANCE_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_ALTERATIONPOWERMOD_SLIDER)
		PlayerRef.SetAV("AlterationPowerMod", value - PlayerRef.GetAV("AlterationPowerMod") + PlayerRef.GetBaseAV("AlterationPowerMod"))
		SetInputOptionValue(AV_ALTERATIONPOWERMOD_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_CONJURATIONPOWERMOD_SLIDER)
		PlayerRef.SetAV("ConjurationPowerMod", value - PlayerRef.GetAV("ConjurationPowerMod") + PlayerRef.GetBaseAV("ConjurationPowerMod"))
		SetInputOptionValue(AV_CONJURATIONPOWERMOD_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_DESTRUCTIONPOWERMOD_SLIDER)
		PlayerRef.SetAV("DestructionPowerMod", value - PlayerRef.GetAV("DestructionPowerMod") + PlayerRef.GetBaseAV("DestructionPowerMod"))
		SetInputOptionValue(AV_DESTRUCTIONPOWERMOD_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_ILLUSIONPOWERMOD_SLIDER)
		PlayerRef.SetAV("IllusionPowerMod", value - PlayerRef.GetAV("IllusionPowerMod") + PlayerRef.GetBaseAV("IllusionPowerMod"))
		SetInputOptionValue(AV_ILLUSIONPOWERMOD_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_RESTORATIONPOWERMOD_SLIDER)
		PlayerRef.SetAV("RestorationPowerMod", value - PlayerRef.GetAV("RestorationPowerMod") + PlayerRef.GetBaseAV("RestorationPowerMod"))
		SetInputOptionValue(AV_RESTORATIONPOWERMOD_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_BOWSTAGGERBONUS_SLIDER)
		PlayerRef.SetAV("BowStaggerBonus", value - PlayerRef.GetAV("BowStaggerBonus") + PlayerRef.GetBaseAV("BowStaggerBonus"))
		SetInputOptionValue(AV_BOWSTAGGERBONUS_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == AV_BOWSPEEDBONUSVAR_SLIDER)
		PlayerRef.SetAV("BowSpeedBonus", value)
		AV_BOWSPEEDBONUSVAR_SLIDER_Var = value
		SetInputOptionValue(AV_BOWSPEEDBONUSVAR_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == AV_LEFTWEAPONSPEEDMULT_SLIDER)
		PlayerRef.SetAV("LeftWeaponSpeedMult", value - PlayerRef.GetAV("LeftWeaponSpeedMult") + PlayerRef.GetBaseAV("LeftWeaponSpeedMult"))
		SetInputOptionValue(AV_LEFTWEAPONSPEEDMULT_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == AV_WEAPONSPEEDMULT_SLIDER)
		PlayerRef.SetAV("WeaponSpeedMult", value - PlayerRef.GetAV("WeaponSpeedMult") + PlayerRef.GetBaseAV("WeaponSpeedMult"))
		SetInputOptionValue(AV_WEAPONSPEEDMULT_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == AV_MAGICRESIST_SLIDER)
		PlayerRef.SetAV("MagicResist", value - PlayerRef.GetAV("MagicResist") + PlayerRef.GetBaseAV("MagicResist"))
		SetInputOptionValue(AV_MAGICRESIST_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_FIRERESIST_SLIDER)
		PlayerRef.SetAV("FireResist", value - PlayerRef.GetAV("FireResist") + PlayerRef.GetBaseAV("FireResist"))
		SetInputOptionValue(AV_FIRERESIST_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_POISONRESIST_SLIDER)
		PlayerRef.SetAV("PoisonResist", value - PlayerRef.GetAV("PoisonResist") + PlayerRef.GetBaseAV("PoisonResist"))
		SetInputOptionValue(AV_POISONRESIST_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_ELECTRICRESIST_SLIDER)
		PlayerRef.SetAV("ElectricResist", value - PlayerRef.GetAV("ElectricResist") + PlayerRef.GetBaseAV("ElectricResist"))
		SetInputOptionValue(AV_ELECTRICRESIST_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_DISEASERESIST_SLIDER)
		PlayerRef.SetAV("DiseaseResist", value - PlayerRef.GetAV("DiseaseResist") + PlayerRef.GetBaseAV("DiseaseResist"))
		SetInputOptionValue(AV_DISEASERESIST_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AV_FROSTRESIST_SLIDER)
		PlayerRef.SetAV("FrostResist", value - PlayerRef.GetAV("FrostResist") + PlayerRef.GetBaseAV("FrostResist"))
		SetInputOptionValue(AV_FROSTRESIST_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == PERK_POINTS_SLIDER)
		SetPerkPoints(value AS INT)
		SetInputOptionValue(PERK_POINTS_SLIDER, value)
	ELSEIF ( option == TIME_SCALE_SLIDER)
		TimeScale.SetValueInt(value AS INT)
		TIME_SCALE_SLIDER_VAR = value AS INT
		SetInputOptionValue(TIME_SCALE_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == FALLHEIGHT_MINNPC_SLIDER)
		SetGameSettingFloat("fJumpFallHeightMinNPC", value)
		FALLHEIGHT_MINNPC_SLIDER_VAR = value
		SetInputOptionValue(FALLHEIGHT_MINNPC_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == FALLHEIGHT_MIN_SLIDER)
		SetGameSettingFloat("fJumpFallHeightMin", value)
		FALLHEIGHT_MIN_SLIDER_VAR = value
		SetInputOptionValue(FALLHEIGHT_MIN_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == FALLHEIGHT_MULTNPC_SLIDER)
		SetGameSettingFloat("fJumpFallHeightMultNPC", value)
		FALLHEIGHT_MULTNPC_SLIDER_VAR = value
		SetInputOptionValue(FALLHEIGHT_MULTNPC_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == FALLHEIGHT_MULT_SLIDER)
		SetGameSettingFloat("fJumpFallHeightMult", value)
		FALLHEIGHT_MULT_SLIDER_VAR = value
		SetInputOptionValue(FALLHEIGHT_MULT_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == FALLHEIGHT_EXPNPC_SLIDER)
		SetGameSettingFloat("fJumpFallHeightExponentNPC", value)
		FALLHEIGHT_EXPNPC_SLIDER_VAR = value
		SetInputOptionValue(FALLHEIGHT_EXPNPC_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == FALLHEIGHT_EXP_SLIDER)
		SetGameSettingFloat("fJumpFallHeightExponent", value)
		FALLHEIGHT_EXP_SLIDER_VAR = value
		SetInputOptionValue(FALLHEIGHT_EXP_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == JUMP_HEIGHT_SLIDER)
		SetGameSettingFloat("fJumpHeightMin", value)
		JUMP_HEIGHT_SLIDER_VAR = value
		SetInputOptionValue(JUMP_HEIGHT_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == SWIM_BREATHBASE_SLIDER)
		SetGameSettingFloat("fActorSwimBreathBase", value)
		SWIM_BREATHBASE_SLIDER_VAR = value
		SetInputOptionValue(SWIM_BREATHBASE_SLIDER, StringDecimals(value,1)+ " sec")
	ELSEIF ( option == SWIM_BREATHDAMAGE_SLIDER)
		SetGameSettingFloat("fActorSwimBreathDamage", value)
		SWIM_BREATHDAMAGE_SLIDER_VAR = value
		SetInputOptionValue(SWIM_BREATHDAMAGE_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == SWIM_BREATHMULT_SLIDER)
		SetGameSettingFloat("fActorSwimBreathMult", value)
		SWIM_BREATHMULT_SLIDER_VAR = value
		SetInputOptionValue(SWIM_BREATHMULT_SLIDER, StringDecimals(value,1)+ " min")
	ELSEIF ( option == KILLCAM_CHANCE_SLIDER)
		SetGameSettingFloat("fKillCamBaseOdds", value)
		KILLCAM_CHANCE_SLIDER_VAR = value
		SetInputOptionValue(KILLCAM_CHANCE_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == DEATHCAMERA_TIME_SLIDER)
		SetGameSettingFloat("fPlayerDeathReloadTime", value)
		DEATHCAMERA_TIME_SLIDER_VAR = value
		SetInputOptionValue(DEATHCAMERA_TIME_SLIDER, StringDecimals(value,0)+ " sec")
	ELSEIF ( option == KILLMOVE_CHANCE_SLIDER)
		KillMoveRandom.SetValue(value)
		KILLMOVE_CHANCE_SLIDER_VAR = value
		SetInputOptionValue(KILLMOVE_CHANCE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == DECAPITATION_CHANCE_SLIDER)
		DecapitationChance.SetValue(value)
		DECAPITATION_CHANCE_SLIDER_VAR = value
		SetInputOptionValue(DECAPITATION_CHANCE_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == SPRINT_DRAINBASE_SLIDER)
		SetGameSettingFloat("fSprintStaminaDrainMult", value)
		SPRINT_DRAINBASE_SLIDER_VAR = value
		SetInputOptionValue(SPRINT_DRAINBASE_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == SPRINT_DRAINMULT_SLIDER)
		SetGameSettingFloat("fSprintStaminaWeightMult", value)
		SPRINT_DRAINMULT_SLIDER_VAR = value
		SetInputOptionValue(SPRINT_DRAINMULT_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == ARROW_RECOVERY_SLIDER)
		SetGameSettingInt("iArrowInventoryChance", value AS INT)
		ARROW_RECOVERY_SLIDER_VAR = value AS INT
		SetInputOptionValue(ARROW_RECOVERY_SLIDER, value + "%")
	ELSEIF ( option == DEATH_DROPCHANCE_SLIDER)
		SetGameSettingInt("iDeathDropWeaponChance", value AS INT)
		DEATH_DROPCHANCE_SLIDER_VAR = value AS INT
		SetInputOptionValue(DEATH_DROPCHANCE_SLIDER, value + "%")
	ELSEIF ( option == CAMERA_SHAKETIME_SLIDER)
		SetGameSettingFloat("fCameraShakeTime", value)
		CAMERA_SHAKETIME_SLIDER_VAR = value
		SetInputOptionValue(CAMERA_SHAKETIME_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == FASTRAVEL_SPEED_SLIDER)
		SetGameSettingFloat("fFastTravelSpeedMult", value)
		FASTRAVEL_SPEED_SLIDER_VAR = value
		SetInputOptionValue(FASTRAVEL_SPEED_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == HUDCOMPASS_DISTANEC_SLIDER)
		SetGameSettingFloat("fHUDCompassLocationMaxDist", value)
		HUDCOMPASS_DISTANEC_SLIDER_VAR = value
		SetInputOptionValue(HUDCOMPASS_DISTANEC_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == ATTACHED_ARROWS_SLIDER)
		SetGameSettingInt("iMaxAttachedArrows", value AS INT)
		ATTACHED_ARROWS_SLIDER_VAR = value AS INT
		SetInputOptionValue(ATTACHED_ARROWS_SLIDER, value + "")
	ELSEIF ( option == LightRadius_OID)
		SetLightRadius(Torch01, value AS INT)
		SetInputOptionValue(LightRadius_OID, value)
	ELSEIF ( option == LightDuration_OID)
		SetLightDuration(Torch01, value AS INT)
		SetInputOptionValue(LightDuration_OID, value + "s")
	ELSEIF ( option == SPECIAL_LOOT_SLIDER)
		SpecialLootChance.SetValueInt(value AS INT)
		SPECIAL_LOOT_SLIDER_VAR = value AS INT
		SetInputOptionValue(SPECIAL_LOOT_SLIDER, StringDecimals(value,0) + "%")
	ELSEIF ( option == FRIENDHIT_TIMER_SLIDER)
		SetGameSettingFloat("fFriendHitTimer", value)
		FRIENDHIT_TIMER_SLIDER_VAR = value
		SetInputOptionValue(FRIENDHIT_TIMER_SLIDER, StringDecimals(value,1)+ " sec")
	ELSEIF ( option == FRIENDHIT_INTERVAL_SLIDER)
		SetGameSettingFloat("fFriendMinimumLastHitTime", value)
		FRIENDHIT_INTERVAL_SLIDER_VAR = value
		SetInputOptionValue(FRIENDHIT_INTERVAL_SLIDER, StringDecimals(value,1)+ " sec")
	ELSEIF ( option == FRIENDHIT_COMBAT_SLIDER)
		SetGameSettingInt("iFriendHitCombatAllowed", value AS INT)
		FRIENDHIT_COMBAT_SLIDER_VAR = value AS INT
		SetInputOptionValue(FRIENDHIT_COMBAT_SLIDER, value + "")
	ELSEIF ( option == FRIENDHIT_NONCOMBAT_SLIDER)
		SetGameSettingInt("iFriendHitNonCombatAllowed", value AS INT)
		FRIENDHIT_NONCOMBAT_SLIDER_VAR = value AS INT
		SetInputOptionValue(FRIENDHIT_NONCOMBAT_SLIDER, value + "")
	ELSEIF ( option == ALLYHIT_COMBAT_SLIDER)
		SetGameSettingInt("iAllyHitCombatAllowed", value AS INT)
		ALLYHIT_COMBAT_SLIDER_VAR = value AS INT
		SetInputOptionValue(ALLYHIT_COMBAT_SLIDER, value + "")
	ELSEIF ( option == ALLYHIT_NONCOMBAT_SLIDER)
		SetGameSettingInt("iAllyHitNonCombatAllowed", value AS INT)
		ALLYHIT_NONCOMBAT_SLIDER_VAR = value AS INT
		SetInputOptionValue(ALLYHIT_NONCOMBAT_SLIDER, value + "")
	ELSEIF ( option == COMBAT_DODGECHANCE_SLIDER)
		SetGameSettingFloat("fCombatDodgeChanceMax", value)
		COMBAT_DODGECHANCE_SLIDER_VAR = value
		SetInputOptionValue(COMBAT_DODGECHANCE_SLIDER, StringDecimals(value,1)+ "")
	ELSEIF ( option == COMBAT_AIMOFFSET_SLIDER)
		SetGameSettingFloat("fCombatAimProjectileRandomOffset", value)
		COMBAT_AIMOFFSET_SLIDER_VAR = value
		SetInputOptionValue(COMBAT_AIMOFFSET_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == COMBAT_FLEEHEALTH_SLIDER)
		SetGameSettingFloat("fAIFleeHealthMult", value)
		COMBAT_FLEEHEALTH_SLIDER_VAR = value
		SetInputOptionValue(COMBAT_FLEEHEALTH_SLIDER, StringDecimals(value,0)+ "%")
	ELSEIF ( option == DIALOGUE_PADDING_SLIDER)
		SetGameSettingFloat("fGameplayVoiceFilePadding", value)
		DIALOGUE_PADDING_SLIDER_VAR = value
		SetInputOptionValue(DIALOGUE_PADDING_SLIDER, StringDecimals(value,2)+ " sec")
	ELSEIF ( option == DIALOGUE_DISTANCE_SLIDER)
		SetGameSettingFloat("fAIMinGreetingDistance", value)
		DIALOGUE_DISTANCE_SLIDER_VAR = value
		SetInputOptionValue(DIALOGUE_DISTANCE_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == FOLLOWER_SPACING_SLIDER)
		SetGameSettingFloat("fFollowSpaceBetweenFollowers", value)
		FOLLOWER_SPACING_SLIDER_VAR = value
		SetInputOptionValue(FOLLOWER_SPACING_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == FOLLOWER_CATCHUP_SLIDER)
		SetGameSettingFloat("fFollowExtraCatchUpSpeedMult", value)
		FOLLOWER_CATCHUP_SLIDER_VAR = value
		SetInputOptionValue(FOLLOWER_CATCHUP_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == LEVELSCALING_MULT_SLIDER)
		SetGameSettingFloat("fLevelScalingMult", value)
		LEVELSCALING_MULT_SLIDER_VAR = value
		SetInputOptionValue(LEVELSCALING_MULT_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == LEVELEDACTOR_EASY_SLIDER)
		SetGameSettingFloat("fLeveledActorMultEasy", value)
		LEVELEDACTOR_EASY_SLIDER_VAR = value
		SetInputOptionValue(LEVELEDACTOR_EASY_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == LEVELEDACTOR_HARD_SLIDER)
		SetGameSettingFloat("fLeveledActorMultHard", value)
		LEVELEDACTOR_HARD_SLIDER_VAR = value
		SetInputOptionValue(LEVELEDACTOR_HARD_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == LEVELEDACTOR_MEDIUM_SLIDER)
		SetGameSettingFloat("fLeveledActorMultMedium", value)
		LEVELEDACTOR_MEDIUM_SLIDER_VAR = value
		SetInputOptionValue(LEVELEDACTOR_MEDIUM_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == LEVELEDACTOR_VHARD_SLIDER)
		SetGameSettingFloat("fLeveledActorMultVeryHard", value)
		LEVELEDACTOR_VHARD_SLIDER_VAR = value
		SetInputOptionValue(LEVELEDACTOR_VHARD_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == RESPAWN_TIME_SLIDER)
		SetGameSettingInt("iHoursToRespawnCell", value AS INT)
		RESPAWN_TIME_SLIDER_VAR = value AS INT
		SetInputOptionValue(RESPAWN_TIME_SLIDER, value + "")
	ELSEIF ( option == NPC_HEALTHBONUS_SLIDER)
		SetGameSettingFloat("fNPCHealthLevelBonus", value)
		NPC_HEALTHBONUS_SLIDER_VAR = value
		SetInputOptionValue(NPC_HEALTHBONUS_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == LEVELUP_ATTRIBUTE_SLIDER)
		SetGameSettingInt("iAVDhmsLevelup", value AS INT)
		LEVELUP_ATTRIBUTE_SLIDER_VAR = value AS INT
		SetInputOptionValue(LEVELUP_ATTRIBUTE_SLIDER, value + "")
	ELSEIF ( option == LEVELUP_CARRYWEIGHT_SLIDER)
		SetGameSettingFloat("fLevelUpCarryWeightMod", value)
		LEVELUP_CARRYWEIGHT_SLIDER_VAR = value
		SetInputOptionValue(LEVELUP_CARRYWEIGHT_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == LEGENDARYRESET_LEVEL_SLIDER)
		SetGameSettingFloat("fLegendarySkillResetValue", value)
		LEGENDARYRESET_LEVEL_SLIDER_VAR = value
		SetInputOptionValue(LEGENDARYRESET_LEVEL_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == LEVELUP_POWER_SLIDER)
		SetGameSettingFloat("fSkillUseCurve", value)
		LEVELUP_POWER_SLIDER_VAR = value
		SetInputOptionValue(LEVELUP_POWER_SLIDER, StringDecimals(value,2)+ "")
	ELSEIF ( option == LEVELUP_BASE_SLIDER)
		SetGameSettingFloat("fXPLevelUpBase", value)
		LEVELUP_BASE_SLIDER_VAR = value
		SetInputOptionValue(LEVELUP_BASE_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == LEVELUP_MULT_SLIDER)
		SetGameSettingFloat("fXPLevelUpMult", value)
		LEVELUP_MULT_SLIDER_VAR = value
		SetInputOptionValue(LEVELUP_MULT_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == SKILLUSE_ALCHEMY_SLIDER)
		GetAVIByID(16).SetSkillUseMult(value)
		SKILLUSE_ALCHEMY_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_ALCHEMY_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_ALTERATION_SLIDER)
		GetAVIByID(18).SetSkillUseMult(value)
		SKILLUSE_ALTERATION_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_ALTERATION_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_BLOCK_SLIDER)
		GetAVIByID(9).SetSkillUseMult(value)
		SKILLUSE_BLOCK_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_BLOCK_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_CONJURATION_SLIDER)
		GetAVIByID(19).SetSkillUseMult(value)
		SKILLUSE_CONJURATION_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_CONJURATION_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_DESTRUCTION_SLIDER)
		GetAVIByID(20).SetSkillUseMult(value)
		SKILLUSE_DESTRUCTION_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_DESTRUCTION_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_ENCHANTING_SLIDER)
		GetAVIByID(23).SetSkillUseMult(value)
		SKILLUSE_ENCHANTING_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_ENCHANTING_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_HEAVYARMOR_SLIDER)
		GetAVIByID(11).SetSkillUseMult(value)
		SKILLUSE_HEAVYARMOR_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_HEAVYARMOR_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_ILLUSION_SLIDER)
		GetAVIByID(21).SetSkillUseMult(value)
		SKILLUSE_ILLUSION_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_ILLUSION_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_LIGHTARMOR_SLIDER)
		GetAVIByID(12).SetSkillUseMult(value)
		SKILLUSE_LIGHTARMOR_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_LIGHTARMOR_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_LOCKPICKING_SLIDER)
		GetAVIByID(14).SetSkillUseMult(value)
		SKILLUSE_LOCKPICKING_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_LOCKPICKING_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_MARKSMAN_SLIDER)
		GetAVIByID(8).SetSkillUseMult(value)
		SKILLUSE_MARKSMAN_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_MARKSMAN_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_ONEHANDED_SLIDER)
		GetAVIByID(6).SetSkillUseMult(value)
		SKILLUSE_ONEHANDED_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_ONEHANDED_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_PICKPOCKET_SLIDER)
		GetAVIByID(13).SetSkillUseMult(value)
		SKILLUSE_PICKPOCKET_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_PICKPOCKET_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_RESTORATION_SLIDER)
		GetAVIByID(22).SetSkillUseMult(value)
		SKILLUSE_RESTORATION_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_RESTORATION_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_SMITHING_SLIDER)
		GetAVIByID(10).SetSkillUseMult(value)
		SKILLUSE_SMITHING_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_SMITHING_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_SNEAK_SLIDER)
		GetAVIByID(15).SetSkillUseMult(value)
		SKILLUSE_SNEAK_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_SNEAK_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_SPEECHCRAFT_SLIDER)
		GetAVIByID(17).SetSkillUseMult(value)
		SKILLUSE_SPEECHCRAFT_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_SPEECHCRAFT_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == SKILLUSE_TWOHAND_SLIDER)
		GetAVIByID(7).SetSkillUseMult(value)
		SKILLUSE_TWOHAND_SLIDER_VAR = value
		SetInputOptionValue(SKILLUSE_TWOHAND_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == RFORCE_MIN_SLIDER)
		SetGameSettingFloat("fDeathForceRangedForceMin", value)
		RFORCE_MIN_SLIDER_VAR = value
		SetInputOptionValue(RFORCE_MIN_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == RFORCE_MAX_SLIDER)
		SetGameSettingFloat("fDeathForceRangedForceMax", value)
		RFORCE_MAX_SLIDER_VAR = value
		SetInputOptionValue(RFORCE_MAX_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == MFORCE_MIN_SLIDER)
		SetGameSettingFloat("fDeathForceForceMin", value)
		MFORCE_MIN_SLIDER_VAR = value
		SetInputOptionValue(MFORCE_MIN_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == MFORCE_MAX_SLIDER)
		SetGameSettingFloat("fDeathForceForceMax", value)
		MFORCE_MAX_SLIDER_VAR = value
		SetInputOptionValue(MFORCE_MAX_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == SFORCE_SLIDER)
		SetGameSettingFloat("fDeathForceSpellImpactMult", value)
		SFORCE_SLIDER_VAR = value
		SetInputOptionValue(SFORCE_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == GFORCE_SLIDER)
		SetGameSettingFloat("fZKeyMaxForce", value)
		GFORCE_SLIDER_VAR = value
		SetInputOptionValue(GFORCE_SLIDER, StringDecimals(value,0)+ "")
	ELSEIF ( option == FIRST_FOV_SLIDER)
		SetINIFloat("fDefaultWorldFOV:Display", value)
		FIRST_FOV_SLIDER_VAR = value
		SetInputOptionValue(FIRST_FOV_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == THIRD_FOV_SLIDER)
		SetINIFloat("fDefault1stPersonFOV:Display", value)
		THIRD_FOV_SLIDER_VAR = value
		SetInputOptionValue(THIRD_FOV_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == XSENSITIVITY_SLIDER)
		SetINIFloat("fMouseHeadingXScale:Controls", value)
		XSENSITIVITY_SLIDER_VAR = value
		SetInputOptionValue(XSENSITIVITY_SLIDER, StringDecimals(value,3) + "")
	ELSEIF ( option == YSENSITIVITY_SLIDER)
		SetINIFloat("fMouseHeadingYScale:Controls", value)
		YSENSITIVITY_SLIDER_VAR = value
		SetInputOptionValue(YSENSITIVITY_SLIDER, StringDecimals(value,3) + "")
	ELSEIF ( option == COMBAT_SHOULDERY_SLIDER)
		SetINIFloat("fOverShoulderCombatAddY:Camera", value)
		COMBAT_SHOULDERY_SLIDER_VAR = value
		SetInputOptionValue(COMBAT_SHOULDERY_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == COMBAT_SHOULDERZ_SLIDER)
		SetINIFloat("fOverShoulderCombatPosZ:Camera", value)
		COMBAT_SHOULDERZ_SLIDER_VAR = value
		SetInputOptionValue(COMBAT_SHOULDERZ_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == COMBAT_SHOULDERX_SLIDER)
		SetINIFloat("fOverShoulderCombatPosX:Camera", value)
		COMBAT_SHOULDERX_SLIDER_VAR = value
		SetInputOptionValue(COMBAT_SHOULDERX_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == SHOULDERZ_SLIDER)
		SetINIFloat("fOverShoulderPosZ:Camera", value)
		SHOULDERZ_SLIDER_VAR = value
		SetInputOptionValue(SHOULDERZ_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == SHOULDERX_SLIDER)
		SetINIFloat("fOverShoulderPosX:Camera", value)
		SHOULDERX_SLIDER_VAR = value
		SetInputOptionValue(SHOULDERX_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == AUTOSAVE_COUNT_SLIDER)
		SetINIInt("iAutoSaveCount:SaveGame", value AS INT)
		AUTOSAVE_COUNT_SLIDER_VAR = value AS INT
		SetInputOptionValue(AUTOSAVE_COUNT_SLIDER, value + "")
	ELSEIF ( option == HAVOK_HIT_SLIDER)
		SetINIFloat("fHavokHitImpulseMult:Animation", value)
		HAVOK_HIT_SLIDER_VAR = value
		SetInputOptionValue(HAVOK_HIT_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == BOOK_SPEED_SLIDER)
		SetINIFloat("fBookOpenTime:Interface", value)
		BOOK_SPEED_SLIDER_VAR = value
		SetInputOptionValue(BOOK_SPEED_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == FIRST_ARROWTILT_SLIDER)
		SetINIFloat("f1PArrowTiltUpAngle:Combat", value)
		FIRST_ARROWTILT_SLIDER_VAR = value
		SetInputOptionValue(FIRST_ARROWTILT_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == THIRD_ARROWTILT_SLIDER)
		SetINIFloat("f3PArrowTiltUpAngle:Combat", value)
		THIRD_ARROWTILT_SLIDER_VAR = value
		SetInputOptionValue(THIRD_ARROWTILT_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == FIRST_BOLTTILT_SLIDER)
		SetINIFloat("f1PBoltTiltUpAngle:Combat", value)
		FIRST_BOLTTILT_SLIDER_VAR = value
		SetInputOptionValue(FIRST_BOLTTILT_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == NAVMESH_DISTANCE_SLIDER)
		SetINIFloat("fVisibleNavmeshMoveDist:Actor", value)
		NAVMESH_DISTANCE_SLIDER_VAR = value
		SetInputOptionValue(NAVMESH_DISTANCE_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == FRICTION_LAND_SLIDER)
		SetINIFloat("fLandFriction:Landscape", value)
		FRICTION_LAND_SLIDER_VAR = value
		SetInputOptionValue(FRICTION_LAND_SLIDER, StringDecimals(value,1) + "")
	ELSEIF ( option == CONSOLE_TEXT_SLIDER)
		SetINIInt("iConsoleTextSize:Menu", value AS INT)
		CONSOLE_TEXT_SLIDER_VAR = value AS INT
		SetInputOptionValue(CONSOLE_TEXT_SLIDER, value + "")
	ELSEIF ( option == CONSOLE_PERCENT_SLIDER)
		SetINIInt("iConsoleSizeScreenPercent:Menu", value AS INT)
		CONSOLE_PERCENT_SLIDER_VAR = value AS INT
		SetInputOptionValue(CONSOLE_PERCENT_SLIDER, value + "")
	ELSEIF ( option == MAP_YAW_SLIDER)
		SetINIFloat("fMapWorldYawRange:MapMenu", value)
		MAP_YAW_SLIDER_VAR = value
		SetInputOptionValue(MAP_YAW_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == MAP_PITCH_SLIDER)
		SetINIFloat("fMapWorldMaxPitch:MapMenu", value)
		MAP_PITCH_SLIDER_VAR = value
		SetInputOptionValue(MAP_PITCH_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == LEGENDARY_BONUS_SLIDER)
		GBT_legendaryBonus_Float = value
		SetInputOptionValue(LEGENDARY_BONUS_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == ARROW_FAMINE_SLIDER)
		GBT_arrowFamine_Float = value
		SetInputOptionValue(ARROW_FAMINE_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == SNEAK_FATIGUE_SLIDER)
		GBT_sneakFatigue_Float = value
		SetInputOptionValue(SNEAK_FATIGUE_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == TIMEDBLOCK_WEAPON_SLIDER)
		GBT_timeBlockWeapon_Float = value
		SetInputOptionValue(TIMEDBLOCK_WEAPON_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == TIMEDBLOCK_SHIELD_SLIDER)
		GBT_timeBlockShield_Float = value
		SetInputOptionValue(TIMEDBLOCK_SHIELD_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == TIMEDBLOCK_REFLECTTIME_SLIDER)
		GBT_timeBlockReflect_Float = value
		SetInputOptionValue(TIMEDBLOCK_REFLECTTIME_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == TIMEDBLOCK_REFLECTWARD_SLIDER)
		GBT_timeBlockWard_Float = value
		SetInputOptionValue(TIMEDBLOCK_REFLECTWARD_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == TIMEDBLOCK_REFLECTDMG_SLIDER)
		GBT_timeBlockDamage_Float = value
		SetInputOptionValue(TIMEDBLOCK_REFLECTDMG_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == TIMEDBLOCK_EXP_SLIDER)
		GBT_timeBlockXP_Float = value
		SetInputOptionValue(TIMEDBLOCK_EXP_SLIDER, StringDecimals(value,1) + "")
	ELSEIF ( option == ITEMLIMITER_LOCKPICK_SLIDER)
		GBT_limitLockpick_Int = value AS INT
		SetInputOptionValue(ITEMLIMITER_LOCKPICK_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == ITEMLIMITER_ARROW_SLIDER)
		GBT_limitArrow_Int = value AS INT
		SetInputOptionValue(ITEMLIMITER_ARROW_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == ITEMLIMITER_POTION_SLIDER)
		GBT_limitPotion_Int = value AS INT
		SetInputOptionValue(ITEMLIMITER_POTION_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == ITEMLIMITER_POISON_SLIDER)
		GBT_limitPoison_Int = value AS INT
		SetInputOptionValue(ITEMLIMITER_POISON_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == PLAYERSTAGGER_BASEDUR_SLIDER)
		GBT_staggerTaken_Float = value
		SetInputOptionValue(PLAYERSTAGGER_BASEDUR_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == PLAYERSTAGGER_IMMUNITY_SLIDER)
		GBT_staggerImmunity_Float = value
		SetInputOptionValue(PLAYERSTAGGER_IMMUNITY_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == PLAYERSTAGGER_ARMORWEIGHT_SLIDER)
		GBT_staggerArmor_Float = value
		SetInputOptionValue(PLAYERSTAGGER_ARMORWEIGHT_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == PLAYERSTAGGER_MAGICKACOST_SLIDER)
		GBT_staggerMagicka_Float = value
		SetInputOptionValue(PLAYERSTAGGER_MAGICKACOST_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == PLAYERSTAGGER_MINTHRESH_SLIDER)
		GBT_staggerMin_Float = value
		SetInputOptionValue(PLAYERSTAGGER_MINTHRESH_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == PLAYERSTAGGER_MAXTHRESH_SLIDER)
		GBT_staggerMax_Float = value
		SetInputOptionValue(PLAYERSTAGGER_MAXTHRESH_SLIDER, StringDecimals(value,1) + "")
	ELSEIF ( option == NPCSTAGGER_MULT_SLIDER)
		GBT_MeleeStaggerMult_Float = value
		SetInputOptionValue(NPCSTAGGER_MULT_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == NPCSTAGGER_BASE_SLIDER)
		GBT_MeleeStaggerBase_Float = value
		SetInputOptionValue(NPCSTAGGER_BASE_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == NPCSTAGGER_ARMORWEIGHT_SLIDER)
		GBT_MeleeStaggerWeight_Float = value
		SetInputOptionValue(NPCSTAGGER_ARMORWEIGHT_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == NPCSTAGGER_IMMUNITY_SLIDER)
		GBT_MeleeStaggerCD_Float = value
		SetInputOptionValue(NPCSTAGGER_IMMUNITY_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == BLEEDOUT_LOSSBASE_SLIDER)
		GBT_bleedoutBase_Float = value
		SetInputOptionValue(BLEEDOUT_LOSSBASE_SLIDER, StringDecimals(value,2) + "")
	ELSEIF ( option == BLEEDOUT_LOSSMULT_SLIDER)
		GBT_bleedoutMult_Int = value AS INT
		SetInputOptionValue(BLEEDOUT_LOSSMULT_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == BLEEDOUT_MAXLIVES_SLIDER)
		GBT_bleedoutLivesMax_Int = value AS INT
		SetInputOptionValue(BLEEDOUT_MAXLIVES_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == ARMOR_CMBEXP_SLIDER)
		GBT_ArmorExp_Float = value
		SetInputOptionValue(ARMOR_CMBEXP_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == BLOCK_CMBEXP_SLIDER)
		GBT_BlockExp_Float = value
		SetInputOptionValue(BLOCK_CMBEXP_SLIDER, StringDecimals(value,0) + "")
	ELSEIF ( option == FISSFILENAME_OID)
		FissFilename = sResult
		SetInputOptionValue(FISSFILENAME_OID, sResult)
	ELSEIF ( option == SAVELOCAL_OID)
		IF sResult != ""
			localSaveAll()
			SaveGame(sResult)
			ShowMessage("Done saving.",false)
		ENDIF
	ENDIF
ENDEVENT


EVENT OnOptionHighlight(int option)
	IF ( option == TEMPER_SCALE_TOGGLE)
		SetInfoText("Stacker(*) Perk: Rebalances scaling of tempering\n Tempering will no longer favor fast weapon types and light armor as much")
	ELSEIF ( option == SHOUT_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Gain this much extra shout magnitude for each dragon soul stockpiled.")
	ELSEIF ( option == CRIT_SCALE_TOGGLE)
		SetInfoText("Stacker(*) Perk: In vanilla, critical damage does not increase with level, perks, and magic effects.\n This perk makes critical damage scale with skill level, vanilla perks, and magic effects.")
	ELSEIF ( option == BLEED_SCALE_TOGGLE)
		SetInfoText("Stacker(+) Perk: In vanilla, bleed damage does not increase with level, perks, and magic effects.\n This perk makes bleed damage scale with skill level, vanilla perks, and magic effects.\n Each perk tier adds 10% of total weapon damage as bleed over 3 seconds.")
	ELSEIF ( option == STAMINACOST_SCALE_TOGGLE)
		SetInfoText("Stacker(*) Perk: When the player's stamina drops below 40, power attack damage and stagger decreases, scaled to stamina.")
	ELSEIF ( option == ILLTARGLVL_SCALE_TOGGLE)
		SetInfoText("Stacker(*) Perk: Allows illusion spells to work on any enemy, but the duration will decrease with enemy level.")
	ELSEIF ( option == FRIENDLY_DAMAGE_TOGGLE)
		SetInfoText("Stacker(*) Perk: Prevents the player from dealing physical or destruction damage to friends and allies.\nOnly takes effect during combat. Friends and allies may still hurt you.")
	ELSEIF ( option == TRAP_MAGNITUDE_SLIDER)
		SetInfoText("Stacker(*) Perk: Magnitude of effects from traps, including darts.\nDoes not apply to Havok/Physics based traps.")
	ELSEIF ( option == FRIENDLY_STAGGER_TOGGLE)
		SetInfoText("Stacker(*) Perk: Prevents the player from dealing stagger to friends and allies.\nOnly takes effect during combat. Friends and allies may still stagger you.")
	ELSEIF ( option == WEREDMG_DEALT_SLIDER)
		SetInfoText("Stacker(*) Perk: Multiplier for damage you deal while in werewolf form.")
	ELSEIF ( option == WEREDMG_TAKEN_SLIDER)
		SetInfoText("Stacker(*) Perk: Multiplier for damage you take while in werewolf form.")
	ELSEIF ( option == POISON_DOSE_SLIDER)
		SetInfoText("Stacker(+) Perk: Number of bonus doses per poison used.\nCertain perk mods may override override this setting.")
	ELSEIF ( option == DUALCAST_POWER_SLIDER)
		SetInfoText("Scanner Vanilla(2.2): Multiplier for spell power while dualcasting.\nWill either increase magnitude or duration, depending on the school of magic.")
	ELSEIF ( option == DUALCAST_COST_SLIDER)
		SetInfoText("Scanner Vanilla(2.8): Multiplier for spell cost while dualcasting.")
	ELSEIF ( option == MAGICCOST_SCALE_SLIDER)
		SetInfoText("Scanner Vanilla(0.0025): Spell cost decreases exponentially at the rate of this variable.\nSpell Cost = 1 - (skill * THIS)^0.65. This affects spells from ALL spell schools.\nI recommend setting this to 0 and using the custom magic scalers at the bottom of this page.")
	ELSEIF ( option == MAGIC_COST_SLIDER)
		SetInfoText("Scanner Vanilla(1): Multiplier for the cost of all spells.")
	ELSEIF ( option == NPCMAGICCOST_SCALE_SLIDER)
		SetInfoText("Scanner Vanilla(0.005): Spell cost decreases exponentially at the rate of this variable.\nThis setting affects NPCs instead of the player.\nNote that NPC spell cost decreases twice as quickly relative to level in vanilla.")
	ELSEIF ( option == NPCMAGIC_COST_SLIDER)
		SetInfoText("Scanner Vanilla(0.5): Multiplier for the cost of all spells for NPCs\nNPC's normally cast spells for half the cost.")
	ELSEIF ( option == MAX_RUNES_SLIDER)
		SetInfoText("Scanner Vanilla(1): The base number of runes you can set.\nCertain poorly designed perk mods will make the game ignore this setting,")
	ELSEIF ( option == MAX_SUMMONED_SLIDER)
		SetInfoText("Scanner Vanilla(1): The base number of familiars you can summon.\nCertain poorly designed perk mods will make the game ignore this setting,")
	ELSEIF ( option == TELEKIN_DAMAGE_SLIDER)
		SetInfoText("Scanner Vanilla(5): Base damage dealt by objects shot with telekinesis.")
	ELSEIF ( option == TELEKIN_DUALMULT_SLIDER)
		SetInfoText("Scanner Vanilla(2): Multiplier for how much more damage telekinesis magic will do when dualcast.")
	ELSEIF ( option == ALTMAG_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales alteration spell magnitude with your alteration level.\nIn vanilla, this only affects armor spells. It can affect modded spells too.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == CONJMAG_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales conjuration spell magnitude with your conjuration level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == ALTDURNOTPARA_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales alteration spell duration with your alteration level.\nIn vanilla, this only affects armor spells. It can affect modded spells too.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == CONJDUR_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales conjuration spell duration with your conjuration level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == ALTCOST_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales alteration spell cost with your alteration level.\nIn vanilla, this only affects armor spells. It can affect modded spells too.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == CONJCOST_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales conjuration spell cost with your conjuration level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == ALTDURPARA_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales paralysis spell duration with your alteration level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == BOUNTMELEE_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales bound melee damage with your conjuration level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.\nI recommend 170% to keep bound melee weapons roughly balanced with smithing/tempering.")
	ELSEIF ( option == ALTCOSTDET_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales detection spell cost with your alteration level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == BOUNDBOW_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales bound bow damage with your conjuration level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.\nI recommend only 100-130%, because bound bows are pretty OP in vanilla.")
	ELSEIF ( option == DESMAG_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales destruction spell magnitude with your destruction level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == HEALMAG_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales healing spell magnitude with your restoration level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == DESDUR_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales destruction spell duration with your destruction level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == HEALDUR_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales healing spell duration with your restoration level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == DESCOST_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales destruction spell cost with your destruction level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == HEALCOST_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales healing spell cost with your restoration level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == ILLMAG_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales illusion spell magnitude with your illusion level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == NONHEALMAG_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales non-healing restoration spell magnitude with your restoration level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == ILLDUR_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales illusion spell duration with your illusion level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == NONHEALDUR_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales non-healing restoration spell duration with your restoration level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == ILLCOST_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales illusion spell cost with your illusion level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == NONHEALCOST_SCALE_SLIDER)
		SetInfoText("Stacker(*) Perk: Scales non-healing restoration spell cost with your restoration level.\nScales from 100% (no change) at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == LESSERPOWER_COOLDOWN_SLIDER)
		SetInfoText("Scanner Vanilla(3): Number of seconds for the cooldown on lesser powers.")
	ELSEIF ( option == DAMAGEDEALTSCALE_OID)
		SetInfoText("Stacker: Multiplier for damage dealt difficulty settings.\nExponentially changes damage dealt. IE this factor ^ player level.")
	ELSEIF ( option == DAMAGETAKENSCALE_OID)
		SetInfoText("Stacker: Multiplier for damage taken difficulty settings.\nExponentially changes damage taken. IE this factor ^ player level.")
	ELSEIF ( option == DAMAGEDEALT_NOVICE_SLIDER)
		SetInfoText("Scanner Vanilla(2): Damage Dealt Multiplier for Novice Difficulty.\nAfter you include scaling, this setting equals: " + GetGameSettingFloat("fDiffMultHPByPCVE") )
	ELSEIF ( option == DAMAGETAKEN_NOVICE_SLIDER)
		SetInfoText("Scanner Vanilla(0.5): Damage Taken Multiplier for Novice Difficulty.\nAfter you include scaling, this setting equals: " + GetGameSettingFloat("fDiffMultHPToPCVE") )
	ELSEIF ( option == DAMAGEDEALT_APPRENTICE_SLIDER)
		SetInfoText("Scanner Vanilla(1.5): Damage Dealt Multiplier for Apprentice Difficulty.\nAfter you include scaling, this setting equals: " + GetGameSettingFloat("fDiffMultHPByPCE") )
	ELSEIF ( option == DAMAGETAKEN_APPRENTICE_SLIDER)
		SetInfoText("Scanner Vanilla(0.75): Damage Taken Multiplier for Apprentice Difficulty.\nAfter you include scaling, this setting equals: " + GetGameSettingFloat("fDiffMultHPToPCE") )
	ELSEIF ( option == DAMAGEDEALT_ADEPT_SLIDER)
		SetInfoText("Scanner Vanilla(1): Damage Dealt Multiplier for Adept Difficulty.\nAfter you include scaling, this setting equals: " + GetGameSettingFloat("fDiffMultHPByPCN") )
	ELSEIF ( option == DAMAGETAKEN_ADEPT_SLIDER)
		SetInfoText("Scanner Vanilla(1): Damage Taken Multiplier for Adept Difficulty.\nAfter you include scaling, this setting equals: " + GetGameSettingFloat("fDiffMultHPToPCN") )
	ELSEIF ( option == DAMAGEDEALT_EXPERT_SLIDER)
		SetInfoText("Scanner Vanilla(0.75): Damage Dealt Multiplier for Expert Difficulty.\nAfter you include scaling, this setting equals: " + GetGameSettingFloat("fDiffMultHPByPCH") )
	ELSEIF ( option == DAMAGETAKEN_EXPERT_SLIDER)
		SetInfoText("Scanner Vanilla(1.5): Damage Taken Multiplier for Expert Difficulty.\nAfter you include scaling, this setting equals: " + GetGameSettingFloat("fDiffMultHPToPCH") )
	ELSEIF ( option == DAMAGEDEALT_MASTER_SLIDER)
		SetInfoText("Scanner Vanilla(0.5): Damage Dealt Multiplier for Master Difficulty.\nAfter you include scaling, this setting equals: " + GetGameSettingFloat("fDiffMultHPByPCVH") )
	ELSEIF ( option == DAMAGETAKEN_MASTER_SLIDER)
		SetInfoText("Scanner Vanilla(2): Damage Taken Multiplier for Master Difficulty.\nAfter you include scaling, this setting equals: " + GetGameSettingFloat("fDiffMultHPToPCVH") )
	ELSEIF ( option == DAMAGEDEALT_LEGENDARY_SLIDER)
		SetInfoText("Scanner Vanilla(0.25): Damage Dealt Multiplier for Legendary Difficulty.\nAfter you include scaling, this setting equals: " + GetGameSettingFloat("fDiffMultHPByPCL") )
	ELSEIF ( option == DAMAGETAKEN_LEGENDARY_SLIDER)
		SetInfoText("Scanner Vanilla(3): Damage Taken Multiplier for Legendary Difficulty.\nAfter you include scaling, this setting equals: " + GetGameSettingFloat("fDiffMultHPToPCL") )
	ELSEIF ( option == WEAPONSCALE_PCMIN_SLIDER)
		SetInfoText("Scanner Vanilla(1): Weapon damage scales from Min Scaling at level 0 to Max Scaling at level 100.")
	ELSEIF ( option == WEAPONSCALE_PCMAX_SLIDER)
		SetInfoText("Scanner Vanilla(1.5): Weapon damage scales from Min Scaling at level 0 to Max Scaling at level 100.")
	ELSEIF ( option == WEAPONSCALE_NPCMIN_SLIDER)
		SetInfoText("Scanner Vanilla(1): Weapon damage scales from Min Scaling at level 0 to Max Scaling at level 100.")
	ELSEIF ( option == WEAPONSCALE_NPCMAX_SLIDER)
		SetInfoText("Scanner Vanilla(3.0): Weapon damage scales from Min Scaling at level 0 to Max Scaling at level 100.")
	ELSEIF ( option == ARMOR_SCALE_SLIDER)
		SetInfoText("Scanner Vanilla(0.12): % damage reduction provided per Armor Rating.")
	ELSEIF ( option == MAX_RESISTANCE_SLIDER)
		SetInfoText("Scanner Vanilla(85): Maximum possible percent damage reduction.\nAffects resistances, blocking, etc. But does not affect armor rating.")
	ELSEIF ( option == ARMOR_BASERESIST_SLIDER)
		SetInfoText("Scanner Vanilla(0.03): Every piece of armor you wear is given an additional invisible armor rating equal to:\nArmor Base Resistance/Armor Rating Scaling.")
	ELSEIF ( option == ARMOR_MAXRESIST_SLIDER)
		SetInfoText("Scanner Vanilla(80): The maximum possible percent damage reduction given by armor rating.")
	ELSEIF ( option == PC_ARMORRATING_SLIDER)
		SetInfoText("Scanner Vanilla(1.4): Multiplier for armor rating that the player receives.")
	ELSEIF ( option == NPC_ARMORRATING_SLIDER)
		SetInfoText("Scanner Vanilla(2.5): Multiplier for armor rating that NPC's receive.")
	ELSEIF ( option == ENCUM_EFFECT_SLIDER)
		SetInfoText("Scanner Vanilla(0.3): Multiplier for the speed reduction caused by armor weight while holding a weapon.\nAny perks, spells, or standing stones that decrease or remove armor weight are considered.")
	ELSEIF ( option == ENCUMWEAP_EFFECT_SLIDER)
		SetInfoText("Scanner Vanilla(0.15): Multiplier for the speed reduction caused by armor weight while not holding a weapon.\nAny perks, spells, or standing stones that decrease or remove armor weight are considered.")
	ELSEIF ( option == WEAPONDAMAGE_MULT_SLIDER)
		SetInfoText("Scanner Vanilla(1): Multiplier for damage dealt by weapons.")
	ELSEIF ( option == TWOHAND_ATKSPD_SLIDER)
		SetInfoText("Scanner Vanilla(1.5): Multiplier for the attack speed of 2 handed weapons.")
	ELSEIF ( option == AUTOAIM_AREA_SLIDER)
		SetInfoText("Scanner Vanilla(6): Area of the screen over which autoaim will activate.\n Set to 0 to deactivate autoaim")
	ELSEIF ( option == AUTOAIM_RANGE_SLIDER)
		SetInfoText("Scanner Vanilla(1800): Maximum range at which autoaim will activate.")
	ELSEIF ( option == AUTOAIM_DEGREES_SLIDER)
		SetInfoText("Scanner Vanilla(1): Maximum correction angle for autoaim.\nSetting this to 0 will deactivate autoaim.\n Set Auto Aim Area to 0 and Auto Aim Angle to a large number to get perfect hitscans.")
	ELSEIF ( option == AUTOAIM_DEGREESTHIRD_SLIDER)
		SetInfoText("Scanner Vanilla(2): Same as Auto Aim Angle, but for third person.")
	ELSEIF ( option == STAMINA_POWERCOST_SLIDER)
		SetInfoText("Scanner Vanilla(2): Multiplier for the stamina cost of power attacks, but not bashes.")
	ELSEIF ( option == STAMINA_BLOCKCOSTMULT_SLIDER)
		SetInfoText("Scanner Vanilla(0.25): Multiplier for the amount of stamina lost per damage taken while blocking.\nStamina Cost = Block Cost Mult * Incoming Damage = Block Cost Base.")
	ELSEIF ( option == STAMINA_BASHCOST_SLIDER)
		SetInfoText("Scanner Vanilla(35): Base stamina cost for bashing.")
	ELSEIF ( option == STAMINA_POWERBASHCOST_SLIDER)
		SetInfoText("Scanner Vanilla(55): Base stamina cost for power bashing.")
	ELSEIF ( option == STAMINA_BLOCKCOSTBASE_SLIDER)
		SetInfoText("Scanner Vanilla(0): Base amount of stamina lost per damage taken while blocking.\nStamina Cost = Block Cost Mult * Incoming Damage = Block Cost Base.")
	ELSEIF ( option == BLOCK_SHIELD_SLIDER)
		SetInfoText("Scanner Vanilla(0.45): Minimum percent damage reduced by blocking with a shield.\nBlocked Damage ~= Shield Block Base + 0.0027 * shield base armor rating * (1 + Skill/100)\nCapped at Maximum Resistance.")
	ELSEIF ( option == BLOCK_WEAPON_SLIDER)
		SetInfoText("Scanner Vanilla(0.3): Minimum percent damage reduced by blocking with a weapon.\nBlocked Damage ~= Weapon Block Base + .0002 * (1 + Skill/100).\nCapped at Maximum Resistance.")
	ELSEIF ( option == WEAPON_REACH_SLIDER)
		SetInfoText("Scanner Vanilla(141): Multiplier for how far weapons will reach.")
	ELSEIF ( option == BASH_REACH_SLIDER)
		SetInfoText("Scanner Vanilla(141): Multiplier for how far weapon/shield bashes will reach.")
	ELSEIF ( option == AISEARCH_TIME_SLIDER)
		SetInfoText("Scanner Vanilla(15): Time AI will spend searching for a target that has attacked them.")
	ELSEIF ( option == AISEARCH_TIMEATTACKED_SLIDER)
		SetInfoText("Scanner Vanilla(10): Time AI will spend searching for their target.")
	ELSEIF ( option == SNEAKLEVEL_BASE_SLIDER)
		SetInfoText("Scanner Vanilla(10): Base value that's added to the effectiveness of sneak level\nIncreasing this makes the player better at sneaking.")
	ELSEIF ( option == SNEAKDETECTION_SCALE_SLIDER)
		SetInfoText("Scanner Vanilla(0.4): How much better you get at sneaking for each sneak level.\nDecrease to make sneaking harder.")
	ELSEIF ( option == DETECTION_FOV_SLIDER)
		SetInfoText("Scanner Vanilla(190): The field of view cone for AI detection")
	ELSEIF ( option == SNEAK_BASE_SLIDER)
		SetInfoText("Scanner Vanilla(-15): How good you are at sneaking at level 0.\nDecrease to make sneaking harder.")
	ELSEIF ( option == DETECTION_LIGHT_SLIDER)
		SetInfoText("Scanner Vanilla(15): Increase to make it even harder to sneak in light.")
	ELSEIF ( option == DETECTION_LIGHTEXT_SLIDER)
		SetInfoText("Scanner Vanilla(0.5): Increase to make it even harder to sneak in light, while outdoors.")
	ELSEIF ( option == DETECTION_SOUND_SLIDER)
		SetInfoText("Scanner Vanilla(1): Increase to make AI's better at detecting you by hearing.")
	ELSEIF ( option == DETECTION_SOUNDLOS_SLIDER)
		SetInfoText("Scanner Vanilla(0.3): Increase to make AI's better at detecting you by hearing, but only when there is line of sight.")
	ELSEIF ( option == PICKPOCKET_MAXCHANCE_SLIDER)
		SetInfoText("Scanner Vanilla(90): Maximum possible pickpocket chance.")
	ELSEIF ( option == PICKPOCKET_MINCHANCE_SLIDER)
		SetInfoText("Scanner Vanilla(0): Minimum possible pickpocket chance.")
	ELSEIF ( option == SNEAKMULT_MARKSMAN_SLIDER)
		SetInfoText("Stacker(*) Perk: Sneak multiplier for ranged weapons.")
	ELSEIF ( option == SNEAKMULT_DAGGER_SLIDER)
		SetInfoText("Stacker(*) Perk: Sneak multiplier for daggers.")
	ELSEIF ( option == SNEAKMULT_TWOHAND_SLIDER)
		SetInfoText("Stacker(*) Perk: Sneak multiplier for melee weapons.")
	ELSEIF ( option == SNEAKMULT_ONEHAND_SLIDER)
		SetInfoText("Stacker(*) Perk: Sneak multiplier for melee weapons.\nDoes not includes daggers.")
	ELSEIF ( option == SNEAKMULT_UNARMED_SLIDER)
		SetInfoText("Stacker(*) Perk: Sneak multiplier for unarmed attacks.")
	ELSEIF ( option == SNEAKMULT_RUNE_SLIDER)
		SetInfoText("Stacker(*) Perk: Sneak multiplier bonus for magical runes.\nAffects magnitude of rune based spells.")
	ELSEIF ( option == SNEAKMULT_SEARCH_SLIDER)
		SetInfoText("Stacker(*) Perk: Sneak multiplier bonus for physical attacks on targets that are searching for you.")
	ELSEIF ( option == SNEAKMULT_SPELLMAG_SLIDER)
		SetInfoText("Stacker(*) Perk: Sneak multiplier bonus for spell magnitude.")
	ELSEIF ( option == SNEAKMULT_SPELLSEARCH_SLIDER)
		SetInfoText("Stacker(*) Perk: Sneak multiplier bonus for spells on targets that are searching for you.")
	ELSEIF ( option == SNEAKMULT_SPELLDUR_SLIDER)
		SetInfoText("Stacker(*) Perk: Sneak multiplier bonus for spell duration.")
	ELSEIF ( option == SNEAKSCALE_PHYSICAL_SLIDER)
		SetInfoText("Stacker(*) Perk: A Scaling Sneak Multiplier for physical damage that increases from 1.0x at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == SNEAKSCALE_SPELLMAG_SLIDER)
		SetInfoText("Stacker(*) Perk: A Scaling Sneak Multiplier for spell magnitude that increases from 1.0x at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == SNEAKMULT_POISONMAG_SLIDER)
		SetInfoText("Stacker(*) Perk: Sneak multiplier bonus for poison on targets that are searching for you.")
	ELSEIF ( option == SNEAKMULT_POISONDUR_SLIDER)
		SetInfoText("Stacker(*) Perk: Sneak multiplier bonus for poison duration.")
	ELSEIF ( option == SNEAKSCALE_POISONMAG_SLIDER)
		SetInfoText("Stacker(*) Perk: A Scaling Sneak Multiplier for poison magnitude that increases from 1.0x at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == SNEAKSCALE_POISONDUR_SLIDER)
		SetInfoText("Stacker(*) Perk: A Scaling Sneak Multiplier for poison duration that increases from 1.0x at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == LOCKPICK_VEASY_SLIDER)
		SetInfoText("Scanner Vanilla(30): The size of the sweetspot on novice locks.")
	ELSEIF ( option == LOCKPICKDUR_VEASY_SLIDER)
		SetInfoText("Scanner Vanilla(2.0): How long lockpicks last on novice locks.")
	ELSEIF ( option == LOCKPICK_EASY_SLIDER)
		SetInfoText("Scanner Vanilla(15): The size of the sweetspot on apprentice locks.")
	ELSEIF ( option == LOCKPICKDUR_EASY_SLIDER)
		SetInfoText("Scanner Vanilla(2.0): How long lockpicks last on apprentice locks.")
	ELSEIF ( option == LOCKPICK_AVERAGE_SLIDER)
		SetInfoText("Scanner Vanilla(7.5): The size of the sweetspot on adept locks.")
	ELSEIF ( option == LOCKPICKDUR_AVERAGE_SLIDER)
		SetInfoText("Scanner Vanilla(2.0): How long lockpicks last on adept locks.")
	ELSEIF ( option == LOCKPICK_HARD_SLIDER)
		SetInfoText("Scanner Vanilla(3.75): The size of the sweetspot on expert locks.")
	ELSEIF ( option == LOCKPICKDUR_HARD_SLIDER)
		SetInfoText("Scanner Vanilla(2.0): How long lockpicks last on expert locks.")
	ELSEIF ( option == LOCKPICK_VHARD_SLIDER)
		SetInfoText("Scanner Vanilla(1.875): The size of the sweetspot on master locks.")
	ELSEIF ( option == LOCKPICKDUR_VHARD_SLIDER)
		SetInfoText("Scanner Vanilla(2.0): How long lockpicks last on master locks.")
	ELSEIF ( option == ALCHEMYMAG_MULT_SLIDER)
		SetInfoText("Scanner Vanilla(4): Multiplier for potion magnitude and price.")
	ELSEIF ( option == ALCHEMYMAG_SCALE_SLIDER)
		SetInfoText("Scanner Vanilla(1.5): Potion magnitude and price will scale by a multiplier equal to THIS ^ (Level/100).")
	ELSEIF ( option == BONUS_INGR_SLIDER)
		SetInfoText("Stacker(+) Perk: Number of bonus ingredients harvested.\nCertain perk mods may override override this setting.")
	ELSEIF ( option == BONUS_POTION_SLIDER)
		SetInfoText("Stacker(+) Perk: Number of bonus potions crafted.\nCertain perk mods may override override this setting.")
	ELSEIF ( option == CHARGECOST_POWER_SLIDER)
		SetInfoText("Scanner Vanilla(1.1): Charges per use = Mult * ( ( Base * Magnitude / Max Magnitude ) ^ Power )\nNote this indirectly affects the price of enchantments.\nAlso note this only affects new enchantments, not existing ones.")
	ELSEIF ( option == ENCHANT_SCALING_SLIDER)
		SetInfoText("Scanner Vanilla(1.25): Determines how quickly enchantment magnitude increases as your enchantment level increases.\nAt 1.25, enchantments made at lvl 100 at 1.25x greater than those made at lvl 15.")
	ELSEIF ( option == CHARGECOST_MULT_SLIDER)
		SetInfoText("Scanner Vanilla(3): Charges per use = Mult * ( ( Base * Magnitude / Max Magnitude ) ^ Power )\nNote this indirectly affects the price of enchantments.\nAlso note this only affects new enchantments, not existing ones.")
	ELSEIF ( option == ENCHANTPRICE_EFFECT_SLIDER)
		SetInfoText("Scanner Vanilla(8): Ench Item Price = Base Item Price + Soul Mult * Soul Value + Effect Mult * Effect Value")
	ELSEIF ( option == CHARGECOST_BASE_SLIDER)
		SetInfoText("Scanner Vanilla(0.005): Charges per use = Mult * ( ( Base * Magnitude / Max Magnitude ) ^ Power )\nNote this indirectly affects the price of enchantments.\nAlso note this only affects new enchantments, not existing ones.")
	ELSEIF ( option == ENCHANTPRICE_SOUL_SLIDER)
		SetInfoText("Scanner Vanilla(0.12): Ench Item Price = Base Item Price + Soul Mult * Soul Value + Effect Mult * Effect Value")
	ELSEIF ( option == ENCHANT_CHARGE_SLIDER)
		SetInfoText("Stacker(*) Perk: Multiplier for the amount of charge on weapon enchantments you make (not retroactive).\nCertain perk mods may override override this setting.")
	ELSEIF ( option == ENCHANT_MAG_SLIDER)
		SetInfoText("Stacker(*) Perk: Multiplier for the magnitude of enchantments you make (not retroactive).\nCertain perk mods may override override this setting.")
	ELSEIF ( option == BONUS_ENCHANT_SLIDER)
		SetInfoText("Stacker(+) Perk: Number of bonus enchantment effects allowed.\nCertain perk mods may override override this setting.")
	ELSEIF ( option == TEMPER_SUFFIX_SLIDER)
		SetInfoText("Scanner Vanilla(0.5825): Determines how much tempering needs to be done for items to receive certain suffixes.\nIE Fine, Epic, Legendary. Higher means you will need lower smithing level to get a legendary weapon.\nDoes not affect the damage or armor rating on items.")
	ELSEIF ( option == TEMPER_ARMOR_SLIDER)
		SetInfoText("Scanner Vanilla(10): How exactly this affects the tempering of armor is not well understood.\nBut increasing this makes tempering armor more effective and decreasing it makes it less effective.")
	ELSEIF ( option == TEMPER_WEAPON_SLIDER)
		SetInfoText("Scanner Vanilla(10): How exactly this affects the tempering of weapons is not well understood.\nBut increasing this makes tempering weapons more effective and decreasing it makes it less effective.")
	ELSEIF ( option == POTION_MAG_SLIDER)
		SetInfoText("Stacker(*) Perk: Multiplier for the magnitude of beneficial potions.")
	ELSEIF ( option == POTION_DUR_SLIDER)
		SetInfoText("Stacker(*) Perk: Multiplier for the duration of beneficial potions.")
	ELSEIF ( option == POTION_SCALEMAG_SLIDER)
		SetInfoText("Stacker(*) Perk: A Scaling Multiplier for potion magnitude that increases from 1.0x at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == POTION_SCALEDUR_SLIDER)
		SetInfoText("Stacker(*) Perk: A Scaling Multiplier for potion duration that increases from 1.0x at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == POISON_MAG_SLIDER)
		SetInfoText("Stacker(*) Perk: Multiplier for the magnitude of beneficial poisons.")
	ELSEIF ( option == POISON_DUR_SLIDER)
		SetInfoText("Stacker(*) Perk: Multiplier for the duration of beneficial poisons.")
	ELSEIF ( option == POISON_SCALEMAG_SLIDER)
		SetInfoText("Stacker(*) Perk: A Scaling Multiplier for poison magnitude that increases from 1.0x at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == POISON_SCALEDUR_SLIDER)
		SetInfoText("Stacker(*) Perk: A Scaling Multiplier for poison duration that increases from 1.0x at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == SCROLL_MAG_SLIDER)
		SetInfoText("Stacker(*) Perk: Multiplier for the magnitude of scrolls.")
	ELSEIF ( option == SCROLL_DUR_SLIDER)
		SetInfoText("Stacker(*) Perk: Multiplier for the duration of scrolls.")
	ELSEIF ( option == BARTER_BUYMIN_SLIDER)
		SetInfoText("Scanner Vanilla(1.05): Multiplier for the cheapest deal a player can get for buying an item from any merchant.")
	ELSEIF ( option == BARTER_SELLMAX_SLIDER)
		SetInfoText("Scanner Vanilla(0.95): Multiplier for the best deal a player can get for selling an item from any merchant.")
	ELSEIF ( option == BARTER_MIN_SLIDER)
		SetInfoText("Scanner Vanilla(2): fBarterMin and fBarterMax determine how prices scale with speech level.\nfBarterMin equals your price factor at level 0 speech.\nfBarterMax equals your price factor at level 100 speech.")
	ELSEIF ( option == BARTER_MAX_SLIDER)
		SetInfoText("Scanner Vanilla(3.3): fBarterMin and fBarterMax determine how prices scale with speech level.\nfBarterMin equals your price factor at level 0 speech.\nfBarterMax equals your price factor at level 100 speech.")
	ELSEIF ( option == BUY_PRICE_SLIDER)
		SetInfoText("Stacker(*) Perk: Multiplier for buy price.")
	ELSEIF ( option == SELL_PRICE_SLIDER)
		SetInfoText("Stacker(*) Perk: Multiplier for sell price.")
	ELSEIF ( option == VENDOR_RESPAWN_SLIDER)
		SetInfoText("Scanner Vanilla(2): Number of days before a vendor respawns.")
	ELSEIF ( option == TRAINING_NUMALLOWED_SLIDER)
		SetInfoText("Scanner Vanilla(5): Number of times you can train before leveling up")
	ELSEIF ( option == TRAINING_JOURNEYMANCOST_SLIDER)
		SetInfoText("Scanner Vanilla(1): Cost multiplier for training below the journeyman training (anything below level 50 in vanilla)")
	ELSEIF ( option == TRAINING_JOURNEYMANSKILL_SLIDER)
		SetInfoText("Scanner Vanilla(50): The highest level a journey trainer can train you to.")
	ELSEIF ( option == TRAINING_EXPERTCOST_SLIDER)
		SetInfoText("Scanner Vanilla(3): Cost multiplier for training below the expert training (anything below level 75 in vanilla)")
	ELSEIF ( option == TRAINING_EXPERTSKILL_SLIDER)
		SetInfoText("Scanner Vanilla(75): The highest level an expert trainer can train you to.")
	ELSEIF ( option == TRAINING_MASTERCOST_SLIDER)
		SetInfoText("Scanner Vanilla(5): Cost multiplier for training below the master training (anything below level 90 in vanilla)")
	ELSEIF ( option == TRAINING_MASTERSKILL_SLIDER)
		SetInfoText("Scanner Vanilla(90): The highest level a master trainer can train you to.")
	ELSEIF ( option == APOTHECARY_GOLD_SLIDER)
		SetInfoText("Scanner Vanilla(500): How much base gold apothecaries start with.")
	ELSEIF ( option == BLACKSMITH_GOLD_SLIDER)
		SetInfoText("Scanner Vanilla(1000): How much base gold city blacksmiths start with.")
	ELSEIF ( option == ORCBLACKSMITH_GOLD_SLIDER)
		SetInfoText("Scanner Vanilla(400): How much base gold orc blacksmiths start with.")
	ELSEIF ( option == TOWNBLACKSMITH_GOLD_SLIDER)
		SetInfoText("Scanner Vanilla(500): How much base gold town blacksmiths start with.")
	ELSEIF ( option == INNKEERPER_GOLD_SLIDER)
		SetInfoText("Scanner Vanilla(100): How much base gold innkeepers start with.")
	ELSEIF ( option == MISCMERCHANT_GOLD_SLIDER)
		SetInfoText("Scanner Vanilla(750): How much base gold misc merchants start with.")
	ELSEIF ( option == SPELLMERCHANT_GOLD_SLIDER)
		SetInfoText("Scanner Vanilla(500): How much base gold spell merchants start with.")
	ELSEIF ( option == STREETVENDOR_GOLD_SLIDER)
		SetInfoText("Scanner Vanilla(50): How much base gold street vendors start with.")
	ELSEIF ( option == COMBAT_STAMINAREGEN_SLIDER)
		SetInfoText("Scanner Vanilla(0.35): Stamina regeneration rate in combat")
	ELSEIF ( option == AV_COMBATHEALTHREGENMULT_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): This is the actor value: CombatHealthRegenMult, it's a multiplier for health regen in combat.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("CombatHealthRegenMult") )
	ELSEIF ( option == DAMAGESTAMINA_DELAY_SLIDER)
		SetInfoText("Scanner Vanilla(0.5): Maximum delay after being dealt stamina damage,\n before stamina may begin regenerating again")
	ELSEIF ( option == BOWZOOM_REGENDELAY_SLIDER)
		SetInfoText("Scanner Vanilla(3): Maximum delay after hitting 0 stamina from using bow zoom,\n before stamina may begin regenerating")
	ELSEIF ( option == COMBAT_MAGICKAREGEN_SLIDER)
		SetInfoText("Scanner Vanilla(0.33): Magicka regeneration rate in combat")
	ELSEIF ( option == STAMINA_REGENDELAY_SLIDER)
		SetInfoText("Scanner Vanilla(5): Maximum delay after hitting 0 stamina,\n before stamina may begin regenerating")
	ELSEIF ( option == DAMAGEMAGICKA_DELAY_SLIDER)
		SetInfoText("Scanner Vanilla(0.5): Maximum delay after being dealt magicka damage,\n before magicka may begin regenerating again")
	ELSEIF ( option == MAGICKA_REGENDELAY_SLIDER)
		SetInfoText("Scanner Vanilla(5): Maximum delay after hitting 0 magicka,\n before magicka may begin regenerating")
	ELSEIF ( option == AV_HEALRATEMULT_SLIDER)
		SetInfoText("Persistent Vanilla(100): This is the actor value: HealRateMult, it's a multiplier for all health regen.\nIt increases with your Health actor value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("HealRateMult") )
	ELSEIF ( option == AV_HEALRATE_SLIDER)
		SetInfoText("Scanner Vanilla(0.7): Player's base HealRate Actor Value.\nYour overall actor value is: " + PlayerRef.GetAV("HealRate"))
	ELSEIF ( option == AV_MAGICKARATEMULT_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(100): Player's base MagickaRateMult, it's a multiplier for all magicka regen.\nIt increases with your Magicka actor value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("MagickaRateMult") )
	ELSEIF ( option == AV_MAGICKARATE_SLIDER)
		SetInfoText("Scanner Vanilla(5): Player's base MagickaRate Actor Value.\nYour overall actor value is: " + PlayerRef.GetAV("MagickaRate"))
	ELSEIF ( option == AV_STAMINARATEMULT_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(100): This is the actor value: StaminaRateMult, it's a multiplier for all stamina regen.\nIt increases with your Stamina actor value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("StaminaRateMult") )
	ELSEIF ( option == AV_STAMINARATE_SLIDER)
		SetInfoText("Scanner Vanilla(3): Player's base StaminaRate Actor Value.\nYour overall actor value is: " + PlayerRef.GetAV("StaminaRate"))
	ELSEIF ( option == AV_HEALTH_SLIDER)
		SetInfoText("Persistent Scanner: Player Health Actor Value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("Health") )
	ELSEIF ( option == AV_MAGICKA_SLIDER)
		SetInfoText("Persistent Scanner: Player Magicka Actor Value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("Magicka") )
	ELSEIF ( option == AV_STAMINA_SLIDER)
		SetInfoText("Persistent Scanner: Player Magicka Actor Value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("Stamina") )
	ELSEIF ( option == AV_DRAGONSOULS_SLIDER)
		SetInfoText("Persistent Scanner: Player Dragonsouls Actor Value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("DragonSouls") )
	ELSEIF ( option == AV_SHOUTRECOVERYMULT_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(1): Player Shout Recovery Mult Actor Value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("ShoutRecoveryMult") )
	ELSEIF ( option == AV_CARRYWEIGHT_SLIDER)
		SetInfoText("Scanner Vanilla(300): Player's base carry weight Actor Value.\nYour overall actor value is: " + PlayerRef.GetAV("CarryWeight"))
	ELSEIF ( option == AV_SPEEDMULT_SLIDER)
		SetInfoText("Scanner Vanilla(100): Player's base movement speed mult Actor Value.\nYour overall actor value is: " + PlayerRef.GetAV("SpeedMult"))
	ELSEIF ( option == AV_UNARMEDDAMAGE_SLIDER)
		SetInfoText("Scanner Vanilla(4): Player base unarmed damage Actor Value.\nYour overall actor value is: " + PlayerRef.GetAV("UnarmedDamage"))
	ELSEIF ( option == AV_MASS_SLIDER)
		SetInfoText("Scanner Vanilla(1): Player base mass Actor Value.\nYour overall actor value is: " + PlayerRef.GetAV("Mass"))
	ELSEIF ( option == AV_CRITCHANCE_SLIDER)
		SetInfoText("Scanner Vanilla(0): Player's base critical hit chance.\nIf you are not using USKP, perks from vanilla may override this actor value\nPerks from certain mods may also override this actor value.\nYour overall actor value is: " + PlayerRef.GetAV("CritChance"))
	ELSEIF ( option == AV_ALTERATIONPOWERMOD_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): Alteration Duration Mult = 1 + AlterationPowerMod/100.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("AlterationPowerMod") )
	ELSEIF ( option == AV_CONJURATIONPOWERMOD_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): Conjuration Duration Mult = 1 + ConjurationPowerMod/100.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("ConjurationPowerMod") )
	ELSEIF ( option == AV_DESTRUCTIONPOWERMOD_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): Destruction Damage Mult = 1 + DestructionPowerMod/100,\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("DestructionPowerMod") )
	ELSEIF ( option == AV_ILLUSIONPOWERMOD_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): Illusion Magnitude Mult = 1 + IllusionPowerMod/100.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("IllusionPowerMod") )
	ELSEIF ( option == AV_RESTORATIONPOWERMOD_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): Restoration Magnitude Mult = 1 + RestorationPowerMod/100.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("RestorationPowerMod") )
	ELSEIF ( option == AV_BOWSTAGGERBONUS_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): Amount of stagger dealt by your bow.\nMaximum is 1.0, which lasts about 3 seconds.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("BowStaggerBonus") )
	ELSEIF ( option == AV_BOWSPEEDBONUSVAR_SLIDER)
		SetInfoText("Scanner Vanilla(1): Player's base slow time when zoomed in with your bow Actor Value.\nYour overall actor value is: " + PlayerRef.GetAV("BowSpeedBonus"))
	ELSEIF ( option == AV_LEFTWEAPONSPEEDMULT_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): Player Left Hand Weapon Speed Mult Actor Value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("LeftWeaponSpeedMult") )
	ELSEIF ( option == AV_WEAPONSPEEDMULT_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): Player Right Hand Weapon Speed Mult Actor Value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("WeaponSpeedMult") )
	ELSEIF ( option == AV_MAGICRESIST_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): Player Magic Resist Actor Value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("MagicResist") )
	ELSEIF ( option == AV_FIRERESIST_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): Player Fire Resist Actor Value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("FireResist") )
	ELSEIF ( option == AV_POISONRESIST_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): Player Poison Resist Actor Value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("PoisonResist") )
	ELSEIF ( option == AV_ELECTRICRESIST_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): Player Electric Resist Actor Value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("ElectricResist") )
	ELSEIF ( option == AV_DISEASERESIST_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): Player Disease Resist Actor Value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("DiseaseResist") )
	ELSEIF ( option == AV_FROSTRESIST_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(0): Player Frost Resist Actor Value.\nYour base actor value, before buffs is: " + PlayerRef.GetBaseAV("FrostResist") )
	ELSEIF ( option == PERK_POINTS_SLIDER)
		SetInfoText("Number of perk points you have")
	ELSEIF ( option == TIME_SCALE_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(20): Multiplier for how much faster time moves in game compared to the real world.\nSetting the value to 1 will make time advance at the same rate as the real world.\nI don't recommend setting this below 5, as it may break some quests.")
	ELSEIF ( option == FALLHEIGHT_MINNPC_SLIDER)
		SetInfoText("Scanner Vanilla(450): Fall Damage = ((height - Fall Damage Height) * Fall Damage Mult) ^ Fall Damage Exponent")
	ELSEIF ( option == FALLHEIGHT_MIN_SLIDER)
		SetInfoText("Scanner Vanilla(600): Fall Damage = ((height - Fall Damage Height) * Fall Damage Mult) ^ Fall Damage Exponent")
	ELSEIF ( option == FALLHEIGHT_MULTNPC_SLIDER)
		SetInfoText("Scanner Vanilla(0.1): Fall Damage = ((height - Fall Damage Height) * Fall Damage Mult) ^ Fall Damage Exponent")
	ELSEIF ( option == FALLHEIGHT_MULT_SLIDER)
		SetInfoText("Scanner Vanilla(0.1): Fall Damage = ((height - Fall Damage Height) * Fall Damage Mult) ^ Fall Damage Exponent")
	ELSEIF ( option == FALLHEIGHT_EXPNPC_SLIDER)
		SetInfoText("Scanner Vanilla(1.65): Fall Damage = ((height - Fall Damage Height) * Fall Damage Mult) ^ Fall Damage Exponent")
	ELSEIF ( option == FALLHEIGHT_EXP_SLIDER)
		SetInfoText("Scanner Vanilla(1.45): Fall Damage = ((height - Fall Damage Height) * Fall Damage Mult) ^ Fall Damage Exponent")
	ELSEIF ( option == JUMP_HEIGHT_SLIDER)
		SetInfoText("Scanner Vanilla(76): How high a player can jump.")
	ELSEIF ( option == SWIM_BREATHBASE_SLIDER)
		SetInfoText("Scanner Vanilla(10): Total breath time equals Breath Timer Seconds + Minutes.")
	ELSEIF ( option == SWIM_BREATHDAMAGE_SLIDER)
		SetInfoText("Scanner Vanilla(0.08): Drowning damage taken per second as a fraction of health.")
	ELSEIF ( option == SWIM_BREATHMULT_SLIDER)
		SetInfoText("Scanner Vanilla(0.2): Total breath time equals Breath Timer Seconds + Minutes.")
	ELSEIF ( option == KILLCAM_CHANCE_SLIDER)
		SetInfoText("Scanner Vanilla(1): Likelihood that a killmove will initiate a kill camera.")
	ELSEIF ( option == DEATHCAMERA_TIME_SLIDER)
		SetInfoText("Scanner Vanilla(5): How long the camera will spin around the player before a save is loaded.")
	ELSEIF ( option == KILLMOVE_CHANCE_SLIDER)
		SetInfoText("Scanner Vanilla(50): Likelihood that the player will perform a killmove when possible.")
	ELSEIF ( option == DECAPITATION_CHANCE_SLIDER)
		SetInfoText("Persistent Scanner Vanilla(40): Likelihood that the player will perform a decapitation during a killmove.")
	ELSEIF ( option == SPRINT_DRAINBASE_SLIDER)
		SetInfoText("Scanner Vanilla(7): Sprint Stamina Drain / Second = Base + Mult * Equipped Weapon/Armor Weight + Weapon Base + Shield Base\nWeapon Base = 2.0 if you have a weapon equipped, 0 otherwise.\nShield Base = 1.0 if you have a shield equipped, 0 otherwise.")
	ELSEIF ( option == SPRINT_DRAINMULT_SLIDER)
		SetInfoText("Scanner Vanilla(0.02): Sprint Stamina Drain / Second = Base + Mult * Equipped Weapon/Armor Weight + Weapon Base + Shield Base\nWeapon Base = 2.0 if you have a weapon equipped, 0 otherwise.\nShield Base = 1.0 if you have a shield equipped, 0 otherwise.")
	ELSEIF ( option == ARROW_RECOVERY_SLIDER)
		SetInfoText("Scanner Vanilla(33): Chance of recovering arrows from enemy bodies.\nHunter's Discipline perk may override this unless a mod fixes that perk.")
	ELSEIF ( option == DEATH_DROPCHANCE_SLIDER)
		SetInfoText("Scanner Vanilla(100): Likelihood that a character's weapon and shield will drop to the ground on death.\nCommonly set to 0 as dropped weapons/shields are not cleared from the game and cause bloat.\nYou can still see the weapons/shields on the ground at 0, but clicking them accesses the NPC inventory.")
	ELSEIF ( option == CAMERA_SHAKETIME_SLIDER)
		SetInfoText("Scanner Vanilla(1.25): How long the camera will shake during camera shake events set to default duration.\nMost notably this affects stagger.")
	ELSEIF ( option == FASTRAVEL_SPEED_SLIDER)
		SetInfoText("Scanner Vanilla(1): Multiplier that determines your speed while fast travelling.\n1 is vanilla fast travel speed.")
	ELSEIF ( option == HUDCOMPASS_DISTANEC_SLIDER)
		SetInfoText("Scanner Vanilla(20000): The maximum distance for objects to appear on your HUD compass.\n64 units = 3 feet.\nSet this to 0 if you don't want to see enemies on your compass.")
	ELSEIF ( option == ATTACHED_ARROWS_SLIDER)
		SetInfoText("Scanner Vanilla(3): Maximum number of arrows you can see attached to a single enemy.")
	ELSEIF ( option == LightRadius_OID)
		SetInfoText("Radius of standard torches")
	ELSEIF ( option == LightDuration_OID)
		SetInfoText("Duration of standard torches in seconds")
	ELSEIF ( option == SPECIAL_LOOT_SLIDER)
		SetInfoText("Scanner Vanilla(90): Chance for the game's special loot lists to NOT pay out.\nThe special loot list consists of 33% enchanted weapons/armor, and 66% non-enchanted weapons/armor\nI build this option especially for GUISE. Please set this to 0 if you are playing with GUISE Enchanted Loot")
	ELSEIF ( option == FRIENDHIT_TIMER_SLIDER)
		SetInfoText("Scanner Vanilla(10): A friendly hit expires after this amount of time.")
	ELSEIF ( option == FRIENDHIT_INTERVAL_SLIDER)
		SetInfoText("Scanner Vanilla(0.5): A friendly hit is added only when this amount of time has passed since the last friendly hit.")
	ELSEIF ( option == FRIENDHIT_COMBAT_SLIDER)
		SetInfoText("Scanner Vanilla(3): The number of hits that are allowed by a friend when they are in combat before they will attack you.")
	ELSEIF ( option == FRIENDHIT_NONCOMBAT_SLIDER)
		SetInfoText("Scanner Vanilla(0): The number of hits that are allowed by a friend when they are not in combat before they will attack you.")
	ELSEIF ( option == ALLYHIT_COMBAT_SLIDER)
		SetInfoText("Scanner Vanilla(1000): The number of hits that are allowed by an ally when they are in combat before they will attack you.")
	ELSEIF ( option == ALLYHIT_NONCOMBAT_SLIDER)
		SetInfoText("Scanner Vanilla(3): The number of hits that are allowed by an ally when they are not in combat before they will attack you.")
	ELSEIF ( option == COMBAT_DODGECHANCE_SLIDER)
		SetInfoText("Scanner Vanilla(1): Maximum chance for an AI to dodge a projectile.\nYou know when an AI sidesteps really quickly? That's it.")
	ELSEIF ( option == COMBAT_AIMOFFSET_SLIDER)
		SetInfoText("Scanner Vanilla(16): Lowering AI aim offset will improve AI accuracy.")
	ELSEIF ( option == COMBAT_FLEEHEALTH_SLIDER)
		SetInfoText("Scanner Vanilla(20): When certain AI fall below this health percentage, they will flee.")
	ELSEIF ( option == DIALOGUE_PADDING_SLIDER)
		SetInfoText("Scanner Vanilla(0.5): Time between NPC Dialogue.")
	ELSEIF ( option == DIALOGUE_DISTANCE_SLIDER)
		SetInfoText("Scanner Vanilla(150): How close the player needs to be for an NPC to greet the player.\n64 units = 3 feet.")
	ELSEIF ( option == FOLLOWER_SPACING_SLIDER)
		SetInfoText("Scanner Vanilla(192): Distance between your followers.")
	ELSEIF ( option == FOLLOWER_CATCHUP_SLIDER)
		SetInfoText("Scanner Vanilla(0.2): Speed boost given to a follower so they can catch up.")
	ELSEIF ( option == LEVELSCALING_MULT_SLIDER)
		SetInfoText("Scanner Vanilla(1): Adjusts the level of NPC's that spawn.\nIncrease to make higher level enemies spawn.\nNote that enemy levels are still capped if you don't use mods.")
	ELSEIF ( option == LEVELEDACTOR_EASY_SLIDER)
		SetInfoText("Scanner Vanilla(0.33): Adjusts the level of NPC's that spawn in easy encounter zones.")
	ELSEIF ( option == LEVELEDACTOR_HARD_SLIDER)
		SetInfoText("Scanner Vanilla(1): Adjusts the level of NPC's that spawn in hard encounter zones.")
	ELSEIF ( option == LEVELEDACTOR_MEDIUM_SLIDER)
		SetInfoText("Scanner Vanilla(0.67): Adjusts the level of NPC's that spawn in medium encounter zones.")
	ELSEIF ( option == LEVELEDACTOR_VHARD_SLIDER)
		SetInfoText("Scanner Vanilla(1.25): Adjusts the level of NPC's that spawn in very hard encounter zones.")
	ELSEIF ( option == RESPAWN_TIME_SLIDER)
		SetInfoText("Scanner Vanilla(240): How long it will take NPC's to respawn, measured in game hours.")
	ELSEIF ( option == NPC_HEALTHBONUS_SLIDER)
		SetInfoText("Scanner Vanilla(5): Extra health added to NPC's.")
	ELSEIF ( option == LEVELUP_ATTRIBUTE_SLIDER)
		SetInfoText("Scanner Vanilla(10): Amount of Health/Stamina/Magicka gained per level up")
	ELSEIF ( option == LEVELUP_CARRYWEIGHT_SLIDER)
		SetInfoText("Scanner Vanilla(5): Amount of Carry Weight gained per level up")
	ELSEIF ( option == LEGENDARYRESET_LEVEL_SLIDER)
		SetInfoText("Scanner Vanilla(15): Level you are set to after a legendary reset.")
	ELSEIF ( option == LEVELUP_POWER_SLIDER)
		SetInfoText("Scanner Vanilla(1.95): Skill Level Up Cost = Mult * Level ^ Power + Base\nNote this is for the player's skill levels, not overall levels.")
	ELSEIF ( option == LEVELUP_BASE_SLIDER)
		SetInfoText("Scanner Vanilla(75): Level Up Cost = Cost of Last Level + Base + Mult*Level\nNote this is for the player's overall level, not skill levels.\nAlways set to 75 at level 1 for whatever reason.")
	ELSEIF ( option == LEVELUP_MULT_SLIDER)
		SetInfoText("Scanner Vanilla(25): Level Up Cost = Cost of Last Level + Base + Mult*Level\nNote this is for the player's overall level, not skill levels.")
	ELSEIF ( option == SKILLUSE_ALCHEMY_SLIDER)
		SetInfoText("Scanner Vanilla(0.75): Skill Use Mult for Alchemy.\nSkill Use Offset: " + GetAVIByID(16).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_ALTERATION_SLIDER)
		SetInfoText("Scanner Vanilla(3): Skill Use Mult for Alteration.\nSkill Use Offset: " + GetAVIByID(18).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_BLOCK_SLIDER)
		SetInfoText("Scanner Vanilla(8.1): Skill Use Mult for Block.\nSkill Use Offset: " + GetAVIByID(9).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_CONJURATION_SLIDER)
		SetInfoText("Scanner Vanilla(2.1): Skill Use Mult for Conjuration.\nSkill Use Offset: " + GetAVIByID(19).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_DESTRUCTION_SLIDER)
		SetInfoText("Scanner Vanilla(1.35): Skill Use Mult for Destruction.\nSkill Use Offset: " + GetAVIByID(20).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_ENCHANTING_SLIDER)
		SetInfoText("Scanner Vanilla(900): Skill Use Mult for Enchanting.\nSkill Use Offset: " + GetAVIByID(23).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_HEAVYARMOR_SLIDER)
		SetInfoText("Scanner Vanilla(3.8): Skill Use Mult for Heavy Armor.\nSkill Use Offset: " + GetAVIByID(11).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_ILLUSION_SLIDER)
		SetInfoText("Scanner Vanilla(4.6): Skill Use Mult for Illusion.\nSkill Use Offset: " + GetAVIByID(21).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_LIGHTARMOR_SLIDER)
		SetInfoText("Scanner Vanilla(4): Skill Use Mult for Light Armor.\nSkill Use Offset: " + GetAVIByID(12).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_LOCKPICKING_SLIDER)
		SetInfoText("Scanner Vanilla(45): Skill Use Mult for Lockpicking.\nSkill Use Offset: " + GetAVIByID(14).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_MARKSMAN_SLIDER)
		SetInfoText("Scanner Vanilla(9.3): Skill Use Mult for Marksman.\nSkill Use Offset: " + GetAVIByID(8).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_ONEHANDED_SLIDER)
		SetInfoText("Scanner Vanilla(6.3): Skill Use Mult for One Handed.\nSkill Use Offset: " + GetAVIByID(6).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_PICKPOCKET_SLIDER)
		SetInfoText("Scanner Vanilla(8.1): Skill Use Mult for Pickpocket.\nSkill Use Offset: " + GetAVIByID(13).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_RESTORATION_SLIDER)
		SetInfoText("Scanner Vanilla(2): Skill Use Mult for Restoration.\nSkill Use Offset: " + GetAVIByID(22).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_SMITHING_SLIDER)
		SetInfoText("Scanner Vanilla(1): Skill Use Mult for Smithing.\nSkill Use Offset: " + GetAVIByID(10).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_SNEAK_SLIDER)
		SetInfoText("Scanner Vanilla(11.25): Skill Use Mult for Sneak.\nSkill Use Offset: " + GetAVIByID(15).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_SPEECHCRAFT_SLIDER)
		SetInfoText("Scanner Vanilla(0.36): Skill Use Mult for Speechcraft.\nSkill Use Offset: " + GetAVIByID(17).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == SKILLUSE_TWOHAND_SLIDER)
		SetInfoText("Scanner Vanilla(5.95): Skill Use Mult for Two Handed.\nSkill Use Offset: " + GetAVIByID(7).GetSkillOffsetMult() + "\nYou gain exp equal to: Skill Use Mult * Base exp + Skill Use Offset")
	ELSEIF ( option == RFORCE_MIN_SLIDER)
		SetInfoText("Scanner Vanilla(10): Minimum amount of ragdoll force a body will receive when killed by a ranged attack.\nCommonly lowered substantially in realism mods.")
	ELSEIF ( option == RFORCE_MAX_SLIDER)
		SetInfoText("Scanner Vanilla(30): Maximum amount of ragdoll force a body will receive when killed by a ranged attack.\nCommonly lowered substantially in realism mods.")
	ELSEIF ( option == MFORCE_MIN_SLIDER)
		SetInfoText("Scanner Vanilla(4): Minimum amount of ragdoll force a body will receive when killed by a melee attack.\nCommonly lowered substantially in realism mods.")
	ELSEIF ( option == MFORCE_MAX_SLIDER)
		SetInfoText("Scanner Vanilla(12): Maximum amount of ragdoll force a body will receive when killed by a melee attack.\nCommonly lowered substantially in realism mods.")
	ELSEIF ( option == SFORCE_SLIDER)
		SetInfoText("Scanner Vanilla(2): Multiplier for amount of ragdoll force a body will receive when killed by a magic attack.\nCommonly lowered substantially in realism mods.")
	ELSEIF ( option == GFORCE_SLIDER)
		SetInfoText("Scanner Vanilla(100): Amount of force the player exerts when picking up a body or object.")
	ELSEIF ( option == FIRST_FOV_SLIDER)
		SetInfoText("Scanner Vanilla(65): You need to enter your character menu for this to update.")
	ELSEIF ( option == THIRD_FOV_SLIDER)
		SetInfoText("Scanner Vanilla(65): You need to enter your character menu for this to update.")
	ELSEIF ( option == XSENSITIVITY_SLIDER)
		SetInfoText("Scanner Vanilla(0.02): Mouse sensitivity in the X axis.")
	ELSEIF ( option == YSENSITIVITY_SLIDER)
		SetInfoText("Scanner Vanilla(0.85): Mouse sensitivity in the Y axis.")
	ELSEIF ( option == COMBAT_SHOULDERY_SLIDER)
		SetInfoText("Scanner Vanilla(-100): Adjust camera (forward/back) position relative to the PC while in combat.")
	ELSEIF ( option == COMBAT_SHOULDERZ_SLIDER)
		SetInfoText("Scanner Vanilla(0): Adjusts camera (up/down) position relative to the PC while in combat.")
	ELSEIF ( option == COMBAT_SHOULDERX_SLIDER)
		SetInfoText("Scanner Vanilla(0): Adjusts camera (left/right) position relative to the PC while in combat.")
	ELSEIF ( option == SHOULDERZ_SLIDER)
		SetInfoText("Scanner Vanilla(0): Adjusts camera (up/down) position relative to the PC while out of combat.")
	ELSEIF ( option == SHOULDERX_SLIDER)
		SetInfoText("Scanner Vanilla(0): Adjusts camera (left/right) position relative to the PC while out of combat.")
	ELSEIF ( option == AUTOSAVE_COUNT_SLIDER)
		SetInfoText("Scanner Vanilla(3): Number of autosave slots your autosaves cycle through.")
	ELSEIF ( option == SHOWCOMPASS_TOGGLE)
		SetInfoText("Scanner Vanilla(True): Show or hide your compass.")
	ELSEIF ( option == DEPTHFIELD_TOGGLE)
		SetInfoText("Scanner Vanilla(True): Enable or disable the blur from your player's depth of field.")
	ELSEIF ( option == HAVOK_HIT_TOGGLE)
		SetInfoText("Scanner Vanilla(False): Enabling this option causes NPC body parts to recoil with physics.\n Does not impact gameplay.")
	ELSEIF ( option == HAVOK_HIT_SLIDER)
		SetInfoText("Scanner Vanilla(False): Multiplier for how much force is used when Havok Hit is enabled.")
	ELSEIF ( option == SHOW_TUTORIAL_TOGGLE)
		SetInfoText("Scanner Vanilla(True): Show or hide tutorials.")
	ELSEIF ( option == BOOK_SPEED_SLIDER)
		SetInfoText("Scanner Vanilla(200): Time to open a book in milliseconds.")
	ELSEIF ( option == FIRST_ARROWTILT_SLIDER)
		SetInfoText("Scanner Vanilla(0.7): Affects the upwards tilt of arrows when fired from your weapon while in first person.\nSome people say 0.7 is the ideal setting for this, and that 0.0 over-corrects if you want to aim straight.")
	ELSEIF ( option == THIRD_ARROWTILT_SLIDER)
		SetInfoText("Scanner Vanilla(0.7): Affects the upwards tilt of arrows when fired from your weapon while in third person.\nSome people say 0.7 is the ideal setting for this, and that 0.0 over-corrects if you want to aim straight.")
	ELSEIF ( option == FIRST_BOLTTILT_SLIDER)
		SetInfoText("Scanner Vanilla(0.7): Affects the upwards tilt of bolts when fired from your weapon while in first person.\nSome people say 0.7 is the ideal setting for this, and that 0.0 over-corrects if you want to aim straight.")
	ELSEIF ( option == NPC_USEAMMO_TOGGLE)
		SetInfoText("Scanner Vanilla(False): Determines whether or not NPCs use ammo.")
	ELSEIF ( option == NAVMESH_DISTANCE_SLIDER)
		SetInfoText("Scanner Vanilla(10000): Affects how far your arrows can fly before they can no longer hit targets.\nYou may want to increase this.")
	ELSEIF ( option == FRICTION_LAND_SLIDER)
		SetInfoText("Scanner Vanilla(2.5): Affects the friction on the landscape, for things such as sliding bodies.\nIncrease this to make bodies slide around less.\nDoes not apply to some surfaces.")
	ELSEIF ( option == TREE_ANIMATION_TOGGLE)
		SetInfoText("Scanner Vanilla(True): Enable or disable tree and foliage animations.")
	ELSEIF ( option == GORE_TOGGLE)
		SetInfoText("Scanner Vanilla(False): Enable or disable gore.")
	ELSEIF ( option == CONSOLE_TEXT_SLIDER)
		SetInfoText("Scanner Vanilla(20): Slider for the size of text in the console.")
	ELSEIF ( option == CONSOLE_PERCENT_SLIDER)
		SetInfoText("Scanner Vanilla: Slider for the percent of your screen taken up by the console.")
	ELSEIF ( option == MAP_YAW_SLIDER)
		SetInfoText("Scanner Vanilla(80): How much you can rotate your map camera left and right.")
	ELSEIF ( option == MAP_PITCH_SLIDER)
		SetInfoText("Scanner Vanilla(75): How much you can rotate your map camera left and right.")
	ELSEIF ( option == VATS_TOGGLE)
		SetInfoText("Scanner Vanilla(false): Disables the kill cam camera, without disabling kill moves.")
	ELSEIF ( option == ALWAYS_ACTIVE_TOGGLE)
		SetInfoText("Scanner Vanilla(false): Lets Skyrim run in the background, while you are alt tabbed for example.")
	ELSEIF ( option == ESSENTIAL_NPC_TOGGLE)
		SetInfoText("Scanner Vanilla(true): Determines whether or not you can kill essential NPCs.\nWarning: this can break quests and stuff!")
	ELSEIF ( option == LEGENDARY_BONUS_TOGGLE)
		SetInfoText("Spell Script: Gain a bonus to a skill for each legendary reset you perform.\nThis is a spell script so make sure you turn this off before uninstalling.\nPS I think legendary resets are stupid <3.")
	ELSEIF ( option == LEGENDARY_BONUS_SLIDER)
		SetInfoText("The % bonus added for each legendary reset.\nNote that the bonus is only recalculated each time you exit the skills menu.\nSo if you change this value, open and close your skills menu to recalculate for the new value.")
	ELSEIF ( option == ARROW_FAMINE_TOGGLE)
		SetInfoText("Spell Script: Arrow Famine will make you consume more ammunition per shot.")
	ELSEIF ( option == ARROW_FAMINE_SLIDER)
		SetInfoText("Stacker(+): Number of arrows consumed per shot fired for Arrow Famine")
	ELSEIF ( option == SNEAK_FATIGUE_TOGGLE)
		SetInfoText("Spell Script: Sneak Fatigue makes sneaking drain stamina.\n Once under 100 stamina, detection scales remaining stamina\nYou'll be twice as easy to detect at 25 stamina than at 50 stamina.")
	ELSEIF ( option == SNEAK_FATIGUE_SLIDER)
		SetInfoText("Stacker(+): Amount of stamina drained per second by Sneak Fatigue.")
	ELSEIF ( option == TIMED_BLOCK_TOGGLE)
		SetInfoText("Spell Script: Timed blocks with shields prevent all physical damage.\nThe total duration of a timed block equals Reflect Damage Time + Weapon/Shield Block Time.")
	ELSEIF ( option == TIMEDBLOCK_WEAPON_SLIDER)
		SetInfoText("The duration of a timed block when performed with a weapon.\nThis duration is added on top of the Stamina Reflect Time.")
	ELSEIF ( option == TIMEDBLOCK_SHIELD_SLIDER)
		SetInfoText("The duration of a timed block when performed with a shield.\nThis duration is added on top of the Stamina Reflect Time.")
	ELSEIF ( option == TIMEDBLOCK_REFLECTTIME_SLIDER)
		SetInfoText("For this period of time after initiating a block, the player enters a reflection state.\nWhile reflecting, the player will reflect stamina damage to melee attacks with shields and reflect spells with wards.\nThe reflection state will be skipped if set to 0.")
	ELSEIF ( option == TIMEDBLOCK_REFLECTWARD_SLIDER)
		SetInfoText("For this duration after casting a ward, the player will be able to reflect one spell back towards the caster.\nOnly one spell can be reflected per timed ward\nThe timed ward state must expire before another spell can be reflected.")
	ELSEIF ( option == TIMEDBLOCK_REFLECTDMG_SLIDER)
		SetInfoText("The base amount of stamina damage reflected during the reflection state.\nThis will scale up to 1.5x as much at level 100 block.\nThe damage also scales with perks, enchantments, and potions, but isn't affected by difficulty.")
	ELSEIF ( option == TIMEDBLOCK_EXP_SLIDER)
		SetInfoText("The amount of experience given for executing a timed block.\nFor reference: a shield bash in vanilla gives 5 XP.")
	ELSEIF ( option == ITEM_LIMITER_TOGGLE)
		SetInfoText("Spell Script: Enables use of Lockpick, Arrow, Potion, and Poison limiters.")
	ELSEIF ( option == ITEMLIMITER_LOCKPICK_SLIDER)
		SetInfoText("This limit is enforced by a script unique to SkyTweak, it will not stack or interact with any other mods.\nThe limit will be higher than indicated if you are using mods that edit the character to start with lockpicks.")
	ELSEIF ( option == ITEMLIMITER_ARROW_SLIDER)
		SetInfoText("This limit is enforced by a script unique to SkyTweak, it will not stack or interact with any other mods.The limit will be higher than indicated if you are using mods that edit the character to start with arrows.")
	ELSEIF ( option == ITEMLIMITER_POTION_SLIDER)
		SetInfoText("This limit is enforced by a script unique to SkyTweak, it will not stack or interact with any other mods.The limit will be higher than indicated if you are using mods that edit the character to start with potions.")
	ELSEIF ( option == ITEMLIMITER_POISON_SLIDER)
		SetInfoText("This limit is enforced by a script unique to SkyTweak, it will not stack or interact with any other mods.The limit will be higher than indicated if you are using mods that edit the character to start with Poisons")
	ELSEIF ( option == PLAYER_STAGGER_TOGGLE)
		SetInfoText("Spell Script: Causes the player to enter a stagger animation each time he is hit.\nThere are 4 separate animations for being hit from the front, left, back, or right.\nYou will not be staggered if the physical attack is blocked or the magic attack is warded.")
	ELSEIF ( option == PLAYERSTAGGER_BASEDUR_SLIDER)
		SetInfoText("The base duration of the stagger. The player will not have access to his combat controls during this period of time.\nTotal Stagger Duration = Base Duration * Impact Factor / Weight Factor")
	ELSEIF ( option == PLAYERSTAGGER_IMMUNITY_SLIDER)
		SetInfoText("After your stagger wears off, you will be immune to stagger for this period of time.")
	ELSEIF ( option == PLAYERSTAGGER_ARMORWEIGHT_SLIDER)
		SetInfoText("Weight Factor = 1 + Total Player Equipped Armor Weight / Armor Weight Factor")
	ELSEIF ( option == PLAYERSTAGGER_MAGICKACOST_SLIDER)
		SetInfoText("If hit by a spell, Impact Factor = Spell Cost / Magicka Cost Factor\nIf hit by a physical attack, Impact Factor = Weapon Weight / Weapon Speed / 15")
	ELSEIF ( option == PLAYERSTAGGER_MINTHRESH_SLIDER)
		SetInfoText("If the stagger duration is calculated to be below this threshold, it will have no effect on the player.")
	ELSEIF ( option == PLAYERSTAGGER_MAXTHRESH_SLIDER)
		SetInfoText("Stagger cannot last for longer than this period of time, measured in seconds.")
	ELSEIF ( option == NPC_STAGGER_TOGGLE)
		SetInfoText("Spell Script: Enemies (not dragons) will now be staggered by the player's melee attacks.\nThis is designed to be an extremely lightweight NPC stagger script.\nIt is applied on enemies within 12 yards in a cone in front of the player on each weapon swing, then quickly deactivates itself.")
	ELSEIF ( option == NPCSTAGGER_MULT_SLIDER)
		SetInfoText("Stagger Magnitude = (Base + Mult * Weapon Stagger)/Weight Factor.\nLook up the weapons page on the uesp to see what weapons have how much base stagger\nA stagger magnitude of 1.0 stuns for about 3 seconds, you cannot exceed a stagger magnitude of 1.0.")
	ELSEIF ( option == NPCSTAGGER_BASE_SLIDER)
		SetInfoText("Stagger Magnitude = (Base + Mult * Weapon Stagger)/Weight Factor.\nLook up the weapons page on the uesp to see what weapons have how much base stagger\nA stagger magnitude of 1.0 stuns for about 3 seconds, you cannot exceed a stagger magnitude of 1.0. ")
	ELSEIF ( option == NPCSTAGGER_ARMORWEIGHT_SLIDER)
		SetInfoText("Weight Factor = 1 + Total Player Equipped Armor Weight / Armor Weight Factor")
	ELSEIF ( option == NPCSTAGGER_IMMUNITY_SLIDER)
		SetInfoText("The enemy will be immune to stagger for this period of time.\nUnlike the player stagger script, this duration is calculated from the start of the stagger,\nAs opposed to starting when the stagger animation ends.")
	ELSEIF ( option == BLEEDOUT_TOGGLE)
		SetInfoText("The player is now essential, and falls to his knees instead of dying, and gets back up with full health.\nThe player loses some gold on each bleedout, and has limited lives that are restored by sleeping.\nThanks to the Live Forever Mod by Sjakal for the idea: http://skyrim.nexusmods.com/mods/36844/")
	ELSEIF ( option == BLEEDOUT_LOSSBASE_SLIDER)
		SetInfoText("Gold Lost on Death = Base * Total Gold + Level Mult * Player Level.")
	ELSEIF ( option == BLEEDOUT_LOSSMULT_SLIDER)
		SetInfoText("Gold Lost on Death = Base * Total Gold + Level Mult * Player Level.")
	ELSEIF ( option == BLEEDOUT_MAXLIVES_SLIDER)
		SetInfoText("Number of lives you have before you become vulnerable to death. Sleep to restore your lives.")
	ELSEIF ( option == ARMOR_CMBEXP_TOGGLE)
		SetInfoText("Spell Script:The player gains light armor, heavy armor, and block experience just by being in combat.\nExperience is awarded at the end of combat.")
	ELSEIF ( option == ARMOR_CMBEXP_SLIDER)
		SetInfoText("Amount of light and heavy armor gained per minute per piece of light and heavy armor worn.")
	ELSEIF ( option == BLOCK_CMBEXP_SLIDER)
		SetInfoText("Amount of block experience gained per minute while in combat.")
	ELSEIF ( option == INFO1_TEXT)
		SetInfoText("Scanner Settings control setings, that other mods may also try to edit\nScanner settings provide you the up to date status of a given setting.\nThe default on scanner settings import your mod settings, instead of just reseting you to vanilla.")
	ELSEIF ( option == INFO2_TEXT)
		SetInfoText("Stacker Settings are completely new settings added by SkyTweak.\nThey will stack ontop of other mods additievly(+) or multiplicatively(*)\nOther mods cannot edit SkyTweak's stacker settings for obvious reasons.")
	ELSEIF ( option == INFO3_TEXT)
		SetInfoText("Register Scripts need to be enabled for certain script based tweaks to function\nThey applied via hidden Magic Effects so you should disable them before uninstallation or when not in use.")
	ELSEIF ( option == INFO4_TEXT)
		SetInfoText("The number shown inside the brackets indicates the value that this setting is in vanilla Skyrim.\nIf this a setting does not say Vanilla in it, then it is a newly added setting.")
	ELSEIF ( option == INFO5_TEXT)
		SetInfoText("If a setting's description is tagged with \"Perk\":\nThen it works by manipulating a perk that has been added to the Player.")
	ELSEIF ( option == INFO6_TEXT)
		SetInfoText("If a setting's description is tagged with \"Persistent\":\nThen this setting will persist even after uninstalling SkyTweak\nConversely, settings without this tag will revert to normal if SkyTweak is removed.")
	ELSEIF ( option == LOADFROMFISS_OID)
		SetInfoText("Load your settings from an XML file. Allows exchanging settings between save files.")
	ELSEIF ( option == SAVETOFISS_OID)
		SetInfoText("Save your settings to an XML file. Allows exchanging settings between save files.")
	ELSEIF ( option == FISSFILENAME_OID)
		SetInfoText("Name of the xml file you are saving your settings to. You can use this to maintain multiple presets.")
	ELSEIF ( option == SAVELOCAL_OID)
		SetInfoText("Save your settings to your safe file's local memory and creates a save file. Avoids rollback issues.")
	ELSEIF ( option == EXITGAME_OID)
		SetInfoText("Just exits the game, does nothing else.")
	ELSEIF ( option == SLIDERMODE_OID)
		SetInfoText("Turn on to disable text input mode and enable slider mode.")
	ELSEIF ( option == REIMPORT_OID)
		SetInfoText("This option will make SkyTweak reset its settings upon the next game load.\nThe settings it resets to should be the hardcoded settings for your current load order.")
	ELSEIF ( option == REGISTERSAVEKEY_OID)
		SetInfoText("Activate or deactivate SkyTweak's save hotkey")
	ELSEIF ( option == SAVEHOTKEY_OID)
		SetInfoText("Pick a hotkey.")
	ELSEIF ( option == QUICKSAVE_OID)
		SetInfoText("Turning this on changes the save hotkey into a quickSave Hotkey, which saves without asking you for a file name.")
	ELSEIF ( option == CREDITS_TEXT)
		SetInfoText("Check out my other mods on Skyrim Nexus:\nhttp://skyrim.nexusmods.com/users/5910982")
	ENDIF
ENDEVENT

;======================================================================
;==============================FUNCTIONS===============================
;======================================================================

FUNCTION loadPerk(PERK akPerk, BOOL akHasPerk)
	IF akHasPerk
		PlayerRef.AddPerk(akPerk)
	ELSE
		PlayerRef.RemovePerk(akPerk)
	ENDIF
ENDFUNCTION

FUNCTION loadPerkFloat1(PERK akPerk, FLOAT akFloat, FLOAT akDefault, INT akIndex)
	IF akFloat == akDefault
		PlayerRef.RemovePerk(akPerk)
	ELSE
		PlayerRef.AddPerk(akPerk)
	ENDIF
	akPerk.SetNthEntryValue(0, akIndex, akFloat)
ENDFUNCTION

FUNCTION loadPerkFloat2(PERK akPerk, FLOAT akFloat, FLOAT akDefault, INT akIndex)
	IF akFloat == akDefault
		PlayerRef.RemovePerk(akPerk)
	ELSE
		PlayerRef.AddPerk(akPerk)
	ENDIF
	akPerk.SetNthEntryValue(0, akIndex, akFloat)
	akPerk.SetNthEntryValue(1, akIndex, akFloat)
ENDFUNCTION

FUNCTION loadPerkFloat3(PERK akPerk, FLOAT akFloat, FLOAT akDefault, INT akIndex)
	IF akFloat == akDefault
		PlayerRef.RemovePerk(akPerk)
	ELSE
		PlayerRef.AddPerk(akPerk)
	ENDIF
	akPerk.SetNthEntryValue(0, akIndex, akFloat)
	akPerk.SetNthEntryValue(1, akIndex, akFloat)
	akPerk.SetNthEntryValue(2, akIndex, akFloat)
ENDFUNCTION

FUNCTION loadSpell(SPELL akSpell, BOOL akHasSpell)
	IF akHasSpell
		PlayerRef.AddSpell(akSpell)
	ELSE
		PlayerRef.RemoveSpell(akSpell)
	ENDIF
ENDFUNCTION

FLOAT FUNCTION GetGBT_legendaryBonus_Float()
	RETURN GBT_legendaryBonus_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_arrowFamine_Float()
	RETURN GBT_arrowFamine_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_sneakFatigue_Float()
	RETURN GBT_sneakFatigue_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_timeBlockWeapon_Float()
	RETURN GBT_timeBlockWeapon_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_timeBlockShield_Float()
	RETURN GBT_timeBlockShield_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_timeBlockReflect_Float()
	RETURN GBT_timeBlockReflect_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_timeBlockWard_Float()
	RETURN GBT_timeBlockWard_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_timeBlockDamage_Float()
	RETURN GBT_timeBlockDamage_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_timeBlockXP_Float()
	RETURN GBT_timeBlockXP_Float
ENDFUNCTION

INT FUNCTION GetGBT_limitLockpick_Int()
	RETURN GBT_limitLockpick_Int
ENDFUNCTION

INT FUNCTION GetGBT_limitArrow_Int()
	RETURN GBT_limitArrow_Int
ENDFUNCTION

INT FUNCTION GetGBT_limitPotion_Int()
	RETURN GBT_limitPotion_Int
ENDFUNCTION

INT FUNCTION GetGBT_limitPoison_Int()
	RETURN GBT_limitPoison_Int
ENDFUNCTION

FLOAT FUNCTION GetGBT_staggerTaken_Float()
	RETURN GBT_staggerTaken_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_staggerImmunity_Float()
	RETURN GBT_staggerImmunity_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_staggerArmor_Float()
	RETURN GBT_staggerArmor_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_staggerMagicka_Float()
	RETURN GBT_staggerMagicka_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_staggerMin_Float()
	RETURN GBT_staggerMin_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_staggerMax_Float()
	RETURN GBT_staggerMax_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_MeleeStaggerMult_Float()
	RETURN GBT_MeleeStaggerMult_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_MeleeStaggerBase_Float()
	RETURN GBT_MeleeStaggerBase_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_MeleeStaggerWeight_Float()
	RETURN GBT_MeleeStaggerWeight_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_MeleeStaggerCD_Float()
	RETURN GBT_MeleeStaggerCD_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_bleedoutBase_Float()
	RETURN GBT_bleedoutBase_Float
ENDFUNCTION

INT FUNCTION GetGBT_bleedoutMult_Int()
	RETURN GBT_bleedoutMult_Int
ENDFUNCTION

INT FUNCTION GetGBT_bleedoutLivesMax_Int()
	RETURN GBT_bleedoutLivesMax_Int
ENDFUNCTION

FLOAT FUNCTION GetGBT_ArmorExp_Float()
	RETURN GBT_ArmorExp_Float
ENDFUNCTION

FLOAT FUNCTION GetGBT_BlockExp_Float()
	RETURN GBT_BlockExp_Float
ENDFUNCTION

;======================================================================
;===========================FISS SAVE ALL=============================
;======================================================================

FUNCTION fissSaveAll()
	float ftimeStart = GetCurrentRealTime()
	FISSInterface fiss = FISSFactory.getFISS()
	If !fiss
		Debug.Notification("Error: SkyTweak now requires FISS to work.")
		RETURN
	ENDIF
	fiss.beginSave(FissFilename + ".xml",FissFilename)

	fiss.saveInt("Version",GetVersion())

	fiss.saveBool("TEMPER_SCALE_TOGGLE",PlayerRef.HasPerk(GBT_Temper_Scale))
	fiss.saveFloat("SHOUT_SCALE_SLIDER",(GBT_shoutScale.GetNthEntryValue(0, 1) * 100) + 0)
	fiss.saveBool("CRIT_SCALE_TOGGLE",PlayerRef.HasPerk(GBT_Critical_Damage_Scaling))
	fiss.saveBool("BLEED_SCALE_TOGGLE",PlayerRef.HasPerk(GBT_Bleed_Damage_Scaling))
	fiss.saveBool("STAMINACOST_SCALE_TOGGLE",PlayerRef.HasPerk(GBT_Stamina_Cost_Scaling))
	fiss.saveBool("ILLTARGLVL_SCALE_TOGGLE",PlayerRef.HasPerk(GBT_illScaleTargetLevel))
	fiss.saveBool("FRIENDLY_DAMAGE_TOGGLE",PlayerRef.HasPerk(GBT_friendlyDamage))
	fiss.saveFloat("TRAP_MAGNITUDE_SLIDER",(GBT_trapMagnitude.GetNthEntryValue(0, 0) * 100) + 0)
	fiss.saveBool("FRIENDLY_STAGGER_TOGGLE",PlayerRef.HasPerk(GBT_friendlyStagger))
	fiss.saveFloat("WEREDMG_DEALT_SLIDER",(GBT_WerewolfDamageDealt.GetNthEntryValue(0, 0) * 100) + 0)
	fiss.saveFloat("WEREDMG_TAKEN_SLIDER",(GBT_WerewolfDamageTaken.GetNthEntryValue(0, 0) * 100) + 0)
	fiss.saveFloat("POISON_DOSE_SLIDER",(GBT_poisonDose.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("DUALCAST_POWER_SLIDER", GetGameSettingFloat("fMagicDualCastingEffectivenessBase"))
	fiss.saveFloat("DUALCAST_COST_SLIDER", GetGameSettingFloat("fMagicDualCastingCostMult"))
	fiss.saveFloat("MAGICCOST_SCALE_SLIDER", GetGameSettingFloat("fMagicCasterPCSkillCostBase"))
	fiss.saveFloat("MAGIC_COST_SLIDER", GetGameSettingFloat("fMagicCasterPCSkillCostMult"))
	fiss.saveFloat("NPCMAGICCOST_SCALE_SLIDER", GetGameSettingFloat("fMagicCasterSkillCostBase"))
	fiss.saveFloat("NPCMAGIC_COST_SLIDER", GetGameSettingFloat("fMagicCasterSkillCostMult"))
	fiss.saveInt("MAX_RUNES_SLIDER", GetGameSettingInt("iMaxPlayerRunes"))
	fiss.saveInt("MAX_SUMMONED_SLIDER", GetGameSettingInt("iMaxSummonedCreatures"))
	fiss.saveFloat("TELEKIN_DAMAGE_SLIDER", GetGameSettingFloat("fMagicTelekinesisDamageBase"))
	fiss.saveFloat("TELEKIN_DUALMULT_SLIDER", GetGameSettingFloat("fMagicTelekinesisDualCastDamageMult"))
	fiss.saveFloat("ALTMAG_SCALE_SLIDER",(GBT_altScaleMag.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("CONJMAG_SCALE_SLIDER",(GBT_conjScaleMag.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("ALTDURNOTPARA_SCALE_SLIDER",(GBT_altScaleDurNotPara.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("CONJDUR_SCALE_SLIDER",(GBT_conjScaleDur.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("ALTCOST_SCALE_SLIDER",(GBT_altScaleCost.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("CONJCOST_SCALE_SLIDER",(GBT_conjScaleCost.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("ALTDURPARA_SCALE_SLIDER",(GBT_altScaleDurPara.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("BOUNTMELEE_SCALE_SLIDER",(GBT_conjScaleBoundMelee.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("ALTCOSTDET_SCALE_SLIDER",(GBT_altScaleCostDet.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("BOUNDBOW_SCALE_SLIDER",(GBT_conjScaleBoundBow.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("DESMAG_SCALE_SLIDER",(GBT_desScaleMag.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("HEALMAG_SCALE_SLIDER",(GBT_restScaleMagHeal.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("DESDUR_SCALE_SLIDER",(GBT_desScaleDur.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("HEALDUR_SCALE_SLIDER",(GBT_restScaleDurHeal.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("DESCOST_SCALE_SLIDER",(GBT_desScaleCost.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("HEALCOST_SCALE_SLIDER",(GBT_restScaleCostHeal.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("ILLMAG_SCALE_SLIDER",(GBT_illScaleMag.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("NONHEALMAG_SCALE_SLIDER",(GBT_nonHealScaleMag.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("ILLDUR_SCALE_SLIDER",(GBT_illScaleDur.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("NONHEALDUR_SCALE_SLIDER",(GBT_nonHealScaleDur.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("ILLCOST_SCALE_SLIDER",(GBT_illScaleCost.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("NONHEALCOST_SCALE_SLIDER",(GBT_nonHealScaleCost.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("LESSERPOWER_COOLDOWN_SLIDER", GetGameSettingFloat("fMagicLesserPowerCooldownTimer"))
	fiss.saveFloat("DAMAGEDEALTSCALE", scaleDamageDealt_VAR)
	fiss.saveFloat("DAMAGETAKENSCALE", scaleDamageTaken_VAR)
	fiss.saveFloat("DAMAGEDEALT_NOVICE_SLIDER", GetGameSettingFloat("fDiffMultHPByPCVE") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	fiss.saveFloat("DAMAGETAKEN_NOVICE_SLIDER", GetGameSettingFloat("fDiffMultHPToPCVE") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	fiss.saveFloat("DAMAGEDEALT_APPRENTICE_SLIDER", GetGameSettingFloat("fDiffMultHPByPCE") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	fiss.saveFloat("DAMAGETAKEN_APPRENTICE_SLIDER", GetGameSettingFloat("fDiffMultHPToPCE") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	fiss.saveFloat("DAMAGEDEALT_ADEPT_SLIDER", GetGameSettingFloat("fDiffMultHPByPCN") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	fiss.saveFloat("DAMAGETAKEN_ADEPT_SLIDER", GetGameSettingFloat("fDiffMultHPToPCN") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	fiss.saveFloat("DAMAGEDEALT_EXPERT_SLIDER", GetGameSettingFloat("fDiffMultHPByPCH") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	fiss.saveFloat("DAMAGETAKEN_EXPERT_SLIDER", GetGameSettingFloat("fDiffMultHPToPCH") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	fiss.saveFloat("DAMAGEDEALT_MASTER_SLIDER", GetGameSettingFloat("fDiffMultHPByPCVH") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	fiss.saveFloat("DAMAGETAKEN_MASTER_SLIDER", GetGameSettingFloat("fDiffMultHPToPCVH") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	fiss.saveFloat("DAMAGEDEALT_LEGENDARY_SLIDER", GetGameSettingFloat("fDiffMultHPByPCL") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	fiss.saveFloat("DAMAGETAKEN_LEGENDARY_SLIDER", GetGameSettingFloat("fDiffMultHPToPCL") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	fiss.saveFloat("WEAPONSCALE_PCMIN_SLIDER", GetGameSettingFloat("fDamagePCSkillMin"))
	fiss.saveFloat("WEAPONSCALE_PCMAX_SLIDER", GetGameSettingFloat("fDamagePCSkillMax"))
	fiss.saveFloat("WEAPONSCALE_NPCMIN_SLIDER", GetGameSettingFloat("fDamageSkillMin"))
	fiss.saveFloat("WEAPONSCALE_NPCMAX_SLIDER", GetGameSettingFloat("fDamageSkillMax"))
	fiss.saveFloat("ARMOR_SCALE_SLIDER", GetGameSettingFloat("fArmorScalingFactor"))
	fiss.saveFloat("MAX_RESISTANCE_SLIDER", GetGameSettingFloat("fPlayerMaxResistance"))
	fiss.saveFloat("ARMOR_BASERESIST_SLIDER", GetGameSettingFloat("fArmorBaseFactor"))
	fiss.saveFloat("ARMOR_MAXRESIST_SLIDER", GetGameSettingFloat("fMaxArmorRating"))
	fiss.saveFloat("PC_ARMORRATING_SLIDER", GetGameSettingFloat("fArmorRatingPCMax"))
	fiss.saveFloat("NPC_ARMORRATING_SLIDER", GetGameSettingFloat("fArmorRatingMax"))
	fiss.saveFloat("ENCUM_EFFECT_SLIDER", GetGameSettingFloat("fMoveEncumEffect"))
	fiss.saveFloat("ENCUMWEAP_EFFECT_SLIDER", GetGameSettingFloat("fMoveEncumEffectNoWeapon"))
	fiss.saveFloat("WEAPONDAMAGE_MULT_SLIDER", GetGameSettingFloat("fDamageWeaponMult"))
	fiss.saveFloat("TWOHAND_ATKSPD_SLIDER", GetGameSettingFloat("fWeaponTwoHandedAnimationSpeedMult"))
	fiss.saveFloat("AUTOAIM_AREA_SLIDER", GetGameSettingFloat("fAutoAimScreenPercentage"))
	fiss.saveFloat("AUTOAIM_RANGE_SLIDER", GetGameSettingFloat("fAutoAimMaxDistance"))
	fiss.saveFloat("AUTOAIM_DEGREES_SLIDER", GetGameSettingFloat("fAutoAimMaxDegrees"))
	fiss.saveFloat("AUTOAIM_DEGREESTHIRD_SLIDER", GetGameSettingFloat("fAutoAimMaxDegrees3rdPerson"))
	fiss.saveFloat("STAMINA_POWERCOST_SLIDER", GetGameSettingFloat("fPowerAttackStaminaPenalty"))
	fiss.saveFloat("STAMINA_BLOCKCOSTMULT_SLIDER", GetGameSettingFloat("fStaminaBlockDmgMult"))
	fiss.saveFloat("STAMINA_BASHCOST_SLIDER", GetGameSettingFloat("fStaminaBashBase"))
	fiss.saveFloat("STAMINA_POWERBASHCOST_SLIDER", GetGameSettingFloat("fStaminaPowerBashBase"))
	fiss.saveFloat("STAMINA_BLOCKCOSTBASE_SLIDER", GetGameSettingFloat("fStaminaBlockBase"))
	fiss.saveFloat("BLOCK_SHIELD_SLIDER", GetGameSettingFloat("fShieldBaseFactor"))
	fiss.saveFloat("BLOCK_WEAPON_SLIDER", GetGameSettingFloat("fBlockWeaponBase"))
	fiss.saveFloat("WEAPON_REACH_SLIDER", GetGameSettingFloat("fCombatDistance"))
	fiss.saveFloat("BASH_REACH_SLIDER", GetGameSettingFloat("fCombatBashReach"))
	fiss.saveFloat("AISEARCH_TIME_SLIDER", GetGameSettingFloat("fCombatStealthPointRegenAttackedWaitTime"))
	fiss.saveFloat("AISEARCH_TIMEATTACKED_SLIDER", GetGameSettingFloat("fCombatStealthPointRegenDetectedEventWaitTime"))
	fiss.saveFloat("SNEAKLEVEL_BASE_SLIDER", GetGameSettingFloat("fPlayerDetectionSneakBase"))
	fiss.saveFloat("SNEAKDETECTION_SCALE_SLIDER", GetGameSettingFloat("fPlayerDetectionSneakMult"))
	fiss.saveFloat("DETECTION_FOV_SLIDER", GetGameSettingFloat("fDetectionViewCone"))
	fiss.saveFloat("SNEAK_BASE_SLIDER", GetGameSettingFloat("fSneakBaseValue"))
	fiss.saveFloat("DETECTION_LIGHT_SLIDER", GetGameSettingFloat("fDetectionSneakLightMod"))
	fiss.saveFloat("DETECTION_LIGHTEXT_SLIDER", GetGameSettingFloat("fSneakLightExteriorMult"))
	fiss.saveFloat("DETECTION_SOUND_SLIDER", GetGameSettingFloat("fSneakSoundsMult"))
	fiss.saveFloat("DETECTION_SOUNDLOS_SLIDER", GetGameSettingFloat("fSneakSoundLosMult"))
	fiss.saveFloat("PICKPOCKET_MAXCHANCE_SLIDER", GetGameSettingFloat("fPickPocketMaxChance"))
	fiss.saveFloat("PICKPOCKET_MINCHANCE_SLIDER", GetGameSettingFloat("fPickPocketMinChance"))
	fiss.saveFloat("SNEAKMULT_MARKSMAN_SLIDER",(GBT_SneakMarks.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("SNEAKMULT_DAGGER_SLIDER",(GBT_SneakDagger.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("SNEAKMULT_TWOHAND_SLIDER",(GBT_SneakOne.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("SNEAKMULT_ONEHAND_SLIDER",(GBT_SneakTwo.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("SNEAKMULT_UNARMED_SLIDER",(GBT_SneakH2H.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("SNEAKMULT_RUNE_SLIDER",(GBT_SneakRuneMag.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("SNEAKMULT_SEARCH_SLIDER",(GBT_SneakSearch.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("SNEAKMULT_SPELLMAG_SLIDER",(GBT_SneakSpellMag.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("SNEAKMULT_SPELLSEARCH_SLIDER",(GBT_SneakSpellSearch.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("SNEAKMULT_SPELLDUR_SLIDER",(GBT_SneakSpellDur.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("SNEAKSCALE_PHYSICAL_SLIDER",(GBT_SneakScalePhys.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("SNEAKSCALE_SPELLMAG_SLIDER",(GBT_SneakScaleSpell.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("SNEAKMULT_POISONMAG_SLIDER",(GBT_SneakPoisonMag.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("SNEAKMULT_POISONDUR_SLIDER",(GBT_SneakPoisonDur.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("SNEAKSCALE_POISONMAG_SLIDER",(GBT_SneakScalePoisonMag.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("SNEAKSCALE_POISONDUR_SLIDER",(GBT_SneakScalePoisonDur.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("LOCKPICK_VEASY_SLIDER", GetGameSettingFloat("fSweetSpotVeryEasy"))
	fiss.saveFloat("LOCKPICKDUR_VEASY_SLIDER", GetGameSettingFloat("fLockpickBreakNovice"))
	fiss.saveFloat("LOCKPICK_EASY_SLIDER", GetGameSettingFloat("fSweetSpotEasy"))
	fiss.saveFloat("LOCKPICKDUR_EASY_SLIDER", GetGameSettingFloat("fLockpickBreakApprentice"))
	fiss.saveFloat("LOCKPICK_AVERAGE_SLIDER", GetGameSettingFloat("fSweetSpotAverage"))
	fiss.saveFloat("LOCKPICKDUR_AVERAGE_SLIDER", GetGameSettingFloat("fLockpickBreakAdept"))
	fiss.saveFloat("LOCKPICK_HARD_SLIDER", GetGameSettingFloat("fSweetSpotHard"))
	fiss.saveFloat("LOCKPICKDUR_HARD_SLIDER", GetGameSettingFloat("fLockpickBreakExpert"))
	fiss.saveFloat("LOCKPICK_VHARD_SLIDER", GetGameSettingFloat("fSweetSpotVeryHard"))
	fiss.saveFloat("LOCKPICKDUR_VHARD_SLIDER", GetGameSettingFloat("fLockpickBreakMaster"))
	fiss.saveFloat("ALCHEMYMAG_MULT_SLIDER", GetGameSettingFloat("fAlchemyIngredientInitMult"))
	fiss.saveFloat("ALCHEMYMAG_SCALE_SLIDER", GetGameSettingFloat("fAlchemySkillFactor"))
	fiss.saveFloat("BONUS_INGR_SLIDER",(GBT_bonusIngredients.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("BONUS_POTION_SLIDER",(GBT_bonusPotions.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("CHARGECOST_POWER_SLIDER", GetGameSettingFloat("fEnchantingCostExponent"))
	fiss.saveFloat("ENCHANT_SCALING_SLIDER", GetGameSettingFloat("fEnchantingSkillFactor"))
	fiss.saveFloat("CHARGECOST_MULT_SLIDER", GetGameSettingFloat("fEnchantingSkillCostMult"))
	fiss.saveFloat("ENCHANTPRICE_EFFECT_SLIDER", GetGameSettingFloat("fEnchantmentEffectPointsMult"))
	fiss.saveFloat("CHARGECOST_BASE_SLIDER", GetGameSettingFloat("fEnchantingSkillCostBase"))
	fiss.saveFloat("ENCHANTPRICE_SOUL_SLIDER", GetGameSettingFloat("fEnchantmentPointsMult"))
	fiss.saveFloat("ENCHANT_CHARGE_SLIDER",(GBT_enchantCharge.GetNthEntryValue(0, 0) * 100) + 0)
	fiss.saveFloat("ENCHANT_MAG_SLIDER",(GBT_enchantMag.GetNthEntryValue(0, 0) * 100) + 0)
	fiss.saveFloat("BONUS_ENCHANT_SLIDER",(GBT_bonusEnchants.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("TEMPER_SUFFIX_SLIDER", GetGameSettingFloat("fSmithingConditionFactor"))
	fiss.saveFloat("TEMPER_ARMOR_SLIDER", GetGameSettingFloat("fSmithingArmorMax"))
	fiss.saveFloat("TEMPER_WEAPON_SLIDER", GetGameSettingFloat("fSmithingWeaponMax"))
	fiss.saveFloat("POTION_MAG_SLIDER",(GBT_PotionMag.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("POTION_DUR_SLIDER",(GBT_PotionDur.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("POTION_SCALEMAG_SLIDER",(GBT_PotionScaleMag.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("POTION_SCALEDUR_SLIDER",(GBT_PotionScaleDur.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("POISON_MAG_SLIDER",(GBT_PoisonMag.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("POISON_DUR_SLIDER",(GBT_PoisonDur.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("POISON_SCALEMAG_SLIDER",(GBT_PoisonScaleMag.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("POISON_SCALEDUR_SLIDER",(GBT_PoisonScaleDur.GetNthEntryValue(0, 1) * 10000) + 100)
	fiss.saveFloat("SCROLL_MAG_SLIDER",(GBT_ScrollMag.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("SCROLL_DUR_SLIDER",(GBT_ScrollDur.GetNthEntryValue(0, 0) * 1) + 0)
	fiss.saveFloat("BARTER_BUYMIN_SLIDER", GetGameSettingFloat("fBarterBuyMin"))
	fiss.saveFloat("BARTER_SELLMAX_SLIDER", GetGameSettingFloat("fBarterSellMax"))
	fiss.saveFloat("BARTER_MIN_SLIDER", GetGameSettingFloat("fBarterMin"))
	fiss.saveFloat("BARTER_MAX_SLIDER", GetGameSettingFloat("fBarterMax"))
	fiss.saveFloat("BUY_PRICE_SLIDER",(GBT_buyPrice.GetNthEntryValue(0, 0) * 100) + 0)
	fiss.saveFloat("SELL_PRICE_SLIDER",(GBT_sellPrice.GetNthEntryValue(0, 0) * 100) + 0)
	fiss.saveInt("VENDOR_RESPAWN_SLIDER", GetGameSettingInt("iDaysToRespawnVendor"))
	fiss.saveInt("TRAINING_NUMALLOWED_SLIDER", GetGameSettingInt("iTrainingNumAllowedPerLevel"))
	fiss.saveInt("TRAINING_JOURNEYMANCOST_SLIDER", GetGameSettingInt("iTrainingJourneymanCost"))
	fiss.saveInt("TRAINING_JOURNEYMANSKILL_SLIDER", GetGameSettingInt("iTrainingJourneymanSkill"))
	fiss.saveInt("TRAINING_EXPERTCOST_SLIDER", GetGameSettingInt("iTrainingExpertCost"))
	fiss.saveInt("TRAINING_EXPERTSKILL_SLIDER", GetGameSettingInt("iTrainingExpertSkill"))
	fiss.saveInt("TRAINING_MASTERCOST_SLIDER", GetGameSettingInt("iTrainingMasterCost"))
	fiss.saveInt("TRAINING_MASTERSKILL_SLIDER", GetGameSettingInt("iTrainingMasterSkill"))
	fiss.saveInt("APOTHECARY_GOLD_SLIDER", VendorGoldApothecary.GetNthCount(0) )
	fiss.saveInt("BLACKSMITH_GOLD_SLIDER", VendorGoldBlacksmith.GetNthCount(0) )
	fiss.saveInt("ORCBLACKSMITH_GOLD_SLIDER", VendorGoldBlacksmithOrc.GetNthCount(0) )
	fiss.saveInt("TOWNBLACKSMITH_GOLD_SLIDER", VendorGoldBlacksmithTown.GetNthCount(0) )
	fiss.saveInt("INNKEERPER_GOLD_SLIDER", VendorGoldInn.GetNthCount(0) )
	fiss.saveInt("MISCMERCHANT_GOLD_SLIDER", VendorGoldMisc.GetNthCount(0) )
	fiss.saveInt("SPELLMERCHANT_GOLD_SLIDER", VendorGoldSpells.GetNthCount(0) )
	fiss.saveInt("STREETVENDOR_GOLD_SLIDER", VendorGoldStreetVendor.GetNthCount(0) )
	fiss.saveFloat("COMBAT_STAMINAREGEN_SLIDER", GetGameSettingFloat("fCombatStaminaRegenRateMult"))
	fiss.saveFloat("DAMAGESTAMINA_DELAY_SLIDER", GetGameSettingFloat("fDamagedStaminaRegenDelay"))
	fiss.saveFloat("BOWZOOM_REGENDELAY_SLIDER", GetGameSettingFloat("fBowZoomStaminaRegenDelay"))
	fiss.saveFloat("COMBAT_MAGICKAREGEN_SLIDER", GetGameSettingFloat("fCombatMagickaRegenRateMult"))
	fiss.saveFloat("STAMINA_REGENDELAY_SLIDER", GetGameSettingFloat("fStaminaRegenDelayMax"))
	fiss.saveFloat("DAMAGEMAGICKA_DELAY_SLIDER", GetGameSettingFloat("fDamagedMagickaRegenDelay"))
	fiss.saveFloat("MAGICKA_REGENDELAY_SLIDER", GetGameSettingFloat("fMagickaRegenDelayMax"))
	fiss.saveFloat("AV_HEALRATE_SLIDER", PlayerRef.GetBaseAV("HealRate"))
	fiss.saveFloat("AV_MAGICKARATE_SLIDER", PlayerRef.GetBaseAV("MagickaRate"))
	fiss.saveFloat("AV_STAMINARATE_SLIDER", PlayerRef.GetBaseAV("StaminaRate"))
	fiss.saveFloat("AV_CARRYWEIGHT_SLIDER", PlayerRef.GetBaseAV("CarryWeight"))
	fiss.saveFloat("AV_SPEEDMULT_SLIDER", PlayerRef.GetBaseAV("SpeedMult"))
	fiss.saveFloat("AV_UNARMEDDAMAGE_SLIDER", PlayerRef.GetBaseAV("UnarmedDamage"))
	fiss.saveFloat("AV_MASS_SLIDER", PlayerRef.GetBaseAV("Mass"))
	fiss.saveFloat("AV_CRITCHANCE_SLIDER", PlayerRef.GetBaseAV("CritChance"))
	fiss.saveFloat("AV_BOWSPEEDBONUSVAR_SLIDER", PlayerRef.GetBaseAV("BowSpeedBonus"))
	fiss.saveInt("TIME_SCALE_SLIDER", TimeScale.GetValueInt())
	fiss.saveFloat("FALLHEIGHT_MINNPC_SLIDER", GetGameSettingFloat("fJumpFallHeightMinNPC"))
	fiss.saveFloat("FALLHEIGHT_MIN_SLIDER", GetGameSettingFloat("fJumpFallHeightMin"))
	fiss.saveFloat("FALLHEIGHT_MULTNPC_SLIDER", GetGameSettingFloat("fJumpFallHeightMultNPC"))
	fiss.saveFloat("FALLHEIGHT_MULT_SLIDER", GetGameSettingFloat("fJumpFallHeightMult"))
	fiss.saveFloat("FALLHEIGHT_EXPNPC_SLIDER", GetGameSettingFloat("fJumpFallHeightExponentNPC"))
	fiss.saveFloat("FALLHEIGHT_EXP_SLIDER", GetGameSettingFloat("fJumpFallHeightExponent"))
	fiss.saveFloat("JUMP_HEIGHT_SLIDER", GetGameSettingFloat("fJumpHeightMin"))
	fiss.saveFloat("SWIM_BREATHBASE_SLIDER", GetGameSettingFloat("fActorSwimBreathBase"))
	fiss.saveFloat("SWIM_BREATHDAMAGE_SLIDER", GetGameSettingFloat("fActorSwimBreathDamage"))
	fiss.saveFloat("SWIM_BREATHMULT_SLIDER", GetGameSettingFloat("fActorSwimBreathMult"))
	fiss.saveFloat("KILLCAM_CHANCE_SLIDER", GetGameSettingFloat("fKillCamBaseOdds"))
	fiss.saveFloat("DEATHCAMERA_TIME_SLIDER", GetGameSettingFloat("fPlayerDeathReloadTime"))
	fiss.saveFloat("KILLMOVE_CHANCE_SLIDER", KillMoveRandom.GetValue())
	fiss.saveFloat("DECAPITATION_CHANCE_SLIDER", DecapitationChance.GetValue())
	fiss.saveFloat("SPRINT_DRAINBASE_SLIDER", GetGameSettingFloat("fSprintStaminaDrainMult"))
	fiss.saveFloat("SPRINT_DRAINMULT_SLIDER", GetGameSettingFloat("fSprintStaminaWeightMult"))
	fiss.saveInt("ARROW_RECOVERY_SLIDER", GetGameSettingInt("iArrowInventoryChance"))
	fiss.saveInt("DEATH_DROPCHANCE_SLIDER", GetGameSettingInt("iDeathDropWeaponChance"))
	fiss.saveFloat("CAMERA_SHAKETIME_SLIDER", GetGameSettingFloat("fCameraShakeTime"))
	fiss.saveFloat("FASTRAVEL_SPEED_SLIDER", GetGameSettingFloat("fFastTravelSpeedMult"))
	fiss.saveFloat("HUDCOMPASS_DISTANEC_SLIDER", GetGameSettingFloat("fHUDCompassLocationMaxDist"))
	fiss.saveInt("ATTACHED_ARROWS_SLIDER", GetGameSettingInt("iMaxAttachedArrows"))
	fiss.saveInt("LightRadius_OID",GetLightRadius(Torch01))
	fiss.saveInt("LightDuration_OID",GetLightDuration(Torch01))
	fiss.saveInt("SPECIAL_LOOT_SLIDER", SpecialLootChance.GetValueInt())
	fiss.saveFloat("FRIENDHIT_TIMER_SLIDER", GetGameSettingFloat("fFriendHitTimer"))
	fiss.saveFloat("FRIENDHIT_INTERVAL_SLIDER", GetGameSettingFloat("fFriendMinimumLastHitTime"))
	fiss.saveInt("FRIENDHIT_COMBAT_SLIDER", GetGameSettingInt("iFriendHitCombatAllowed"))
	fiss.saveInt("FRIENDHIT_NONCOMBAT_SLIDER", GetGameSettingInt("iFriendHitNonCombatAllowed"))
	fiss.saveInt("ALLYHIT_COMBAT_SLIDER", GetGameSettingInt("iAllyHitCombatAllowed"))
	fiss.saveInt("ALLYHIT_NONCOMBAT_SLIDER", GetGameSettingInt("iAllyHitNonCombatAllowed"))
	fiss.saveFloat("COMBAT_DODGECHANCE_SLIDER", GetGameSettingFloat("fCombatDodgeChanceMax"))
	fiss.saveFloat("COMBAT_AIMOFFSET_SLIDER", GetGameSettingFloat("fCombatAimProjectileRandomOffset"))
	fiss.saveFloat("COMBAT_FLEEHEALTH_SLIDER", GetGameSettingFloat("fAIFleeHealthMult"))
	fiss.saveFloat("DIALOGUE_PADDING_SLIDER", GetGameSettingFloat("fGameplayVoiceFilePadding"))
	fiss.saveFloat("DIALOGUE_DISTANCE_SLIDER", GetGameSettingFloat("fAIMinGreetingDistance"))
	fiss.saveFloat("FOLLOWER_SPACING_SLIDER", GetGameSettingFloat("fFollowSpaceBetweenFollowers"))
	fiss.saveFloat("FOLLOWER_CATCHUP_SLIDER", GetGameSettingFloat("fFollowExtraCatchUpSpeedMult"))
	fiss.saveFloat("LEVELSCALING_MULT_SLIDER", GetGameSettingFloat("fLevelScalingMult"))
	fiss.saveFloat("LEVELEDACTOR_EASY_SLIDER", GetGameSettingFloat("fLeveledActorMultEasy"))
	fiss.saveFloat("LEVELEDACTOR_HARD_SLIDER", GetGameSettingFloat("fLeveledActorMultHard"))
	fiss.saveFloat("LEVELEDACTOR_MEDIUM_SLIDER", GetGameSettingFloat("fLeveledActorMultMedium"))
	fiss.saveFloat("LEVELEDACTOR_VHARD_SLIDER", GetGameSettingFloat("fLeveledActorMultVeryHard"))
	fiss.saveInt("RESPAWN_TIME_SLIDER", GetGameSettingInt("iHoursToRespawnCell"))
	fiss.saveFloat("NPC_HEALTHBONUS_SLIDER", GetGameSettingFloat("fNPCHealthLevelBonus"))
	fiss.saveInt("LEVELUP_ATTRIBUTE_SLIDER", GetGameSettingInt("iAVDhmsLevelup"))
	fiss.saveFloat("LEVELUP_CARRYWEIGHT_SLIDER", GetGameSettingFloat("fLevelUpCarryWeightMod"))
	fiss.saveFloat("LEGENDARYRESET_LEVEL_SLIDER", GetGameSettingFloat("fLegendarySkillResetValue"))
	fiss.saveFloat("LEVELUP_POWER_SLIDER", GetGameSettingFloat("fSkillUseCurve"))
	fiss.saveFloat("LEVELUP_BASE_SLIDER", GetGameSettingFloat("fXPLevelUpBase"))
	fiss.saveFloat("LEVELUP_MULT_SLIDER", GetGameSettingFloat("fXPLevelUpMult"))
	fiss.saveFloat("SKILLUSE_ALCHEMY_SLIDER", GetAVIByID(16).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_ALTERATION_SLIDER", GetAVIByID(18).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_BLOCK_SLIDER", GetAVIByID(9).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_CONJURATION_SLIDER", GetAVIByID(19).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_DESTRUCTION_SLIDER", GetAVIByID(20).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_ENCHANTING_SLIDER", GetAVIByID(23).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_HEAVYARMOR_SLIDER", GetAVIByID(11).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_ILLUSION_SLIDER", GetAVIByID(21).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_LIGHTARMOR_SLIDER", GetAVIByID(12).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_LOCKPICKING_SLIDER", GetAVIByID(14).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_MARKSMAN_SLIDER", GetAVIByID(8).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_ONEHANDED_SLIDER", GetAVIByID(6).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_PICKPOCKET_SLIDER", GetAVIByID(13).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_RESTORATION_SLIDER", GetAVIByID(22).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_SMITHING_SLIDER", GetAVIByID(10).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_SNEAK_SLIDER", GetAVIByID(15).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_SPEECHCRAFT_SLIDER", GetAVIByID(17).GetSkillUseMult() )
	fiss.saveFloat("SKILLUSE_TWOHAND_SLIDER", GetAVIByID(7).GetSkillUseMult() )
	fiss.saveFloat("RFORCE_MIN_SLIDER", GetGameSettingFloat("fDeathForceRangedForceMin"))
	fiss.saveFloat("RFORCE_MAX_SLIDER", GetGameSettingFloat("fDeathForceRangedForceMax"))
	fiss.saveFloat("MFORCE_MIN_SLIDER", GetGameSettingFloat("fDeathForceForceMin"))
	fiss.saveFloat("MFORCE_MAX_SLIDER", GetGameSettingFloat("fDeathForceForceMax"))
	fiss.saveFloat("SFORCE_SLIDER", GetGameSettingFloat("fDeathForceSpellImpactMult"))
	fiss.saveFloat("GFORCE_SLIDER", GetGameSettingFloat("fZKeyMaxForce"))
	fiss.saveFloat("FIRST_FOV_SLIDER", GetINIFloat("fDefaultWorldFOV:Display"))
	fiss.saveFloat("THIRD_FOV_SLIDER", GetINIFloat("fDefault1stPersonFOV:Display"))
	fiss.saveFloat("XSENSITIVITY_SLIDER", GetINIFloat("fMouseHeadingXScale:Controls"))
	fiss.saveFloat("YSENSITIVITY_SLIDER", GetINIFloat("fMouseHeadingYScale:Controls"))
	fiss.saveFloat("COMBAT_SHOULDERY_SLIDER", GetINIFloat("fOverShoulderCombatAddY:Camera"))
	fiss.saveFloat("COMBAT_SHOULDERZ_SLIDER", GetINIFloat("fOverShoulderCombatPosZ:Camera"))
	fiss.saveFloat("COMBAT_SHOULDERX_SLIDER", GetINIFloat("fOverShoulderCombatPosX:Camera"))
	fiss.saveFloat("SHOULDERZ_SLIDER", GetINIFloat("fOverShoulderPosZ:Camera"))
	fiss.saveFloat("SHOULDERX_SLIDER", GetINIFloat("fOverShoulderPosX:Camera"))
	fiss.saveInt("AUTOSAVE_COUNT_SLIDER", GetINIInt("iAutoSaveCount:SaveGame"))
	fiss.saveBool("SHOWCOMPASS_TOGGLE",GetINIBool("bShowCompass:Interface"))
	fiss.saveBool("DEPTHFIELD_TOGGLE",GetINIBool("bDoDepthOfField:Imagespace"))
	fiss.saveBool("HAVOK_HIT_TOGGLE",GetINIBool("bEnableHavokHit:Animation"))
	fiss.saveFloat("HAVOK_HIT_SLIDER", GetINIFloat("fHavokHitImpulseMult:Animation"))
	fiss.saveBool("SHOW_TUTORIAL_TOGGLE",GetINIBool("bShowTutorials:Interface"))
	fiss.saveFloat("BOOK_SPEED_SLIDER", GetINIFloat("fBookOpenTime:Interface"))
	fiss.saveFloat("FIRST_ARROWTILT_SLIDER", GetINIFloat("f1PArrowTiltUpAngle:Combat"))
	fiss.saveFloat("THIRD_ARROWTILT_SLIDER", GetINIFloat("f3PArrowTiltUpAngle:Combat"))
	fiss.saveFloat("FIRST_BOLTTILT_SLIDER", GetINIFloat("f1PBoltTiltUpAngle:Combat"))
	fiss.saveBool("NPC_USEAMMO_TOGGLE",GetINIBool("bForceNPCsUseAmmo:Combat"))
	fiss.saveFloat("NAVMESH_DISTANCE_SLIDER", GetINIFloat("fVisibleNavmeshMoveDist:Actor"))
	fiss.saveFloat("FRICTION_LAND_SLIDER", GetINIFloat("fLandFriction:Landscape"))
	fiss.saveBool("TREE_ANIMATION_TOGGLE",GetINIBool("bEnableTreeAnimations:Trees"))
	fiss.saveBool("GORE_TOGGLE",GetINIBool("bDisableAllGore:General"))
	fiss.saveInt("CONSOLE_TEXT_SLIDER", GetINIInt("iConsoleTextSize:Menu"))
	fiss.saveInt("CONSOLE_PERCENT_SLIDER", GetINIInt("iConsoleSizeScreenPercent:Menu"))
	fiss.saveFloat("MAP_YAW_SLIDER", GetINIFloat("fMapWorldYawRange:MapMenu"))
	fiss.saveFloat("MAP_PITCH_SLIDER", GetINIFloat("fMapWorldMaxPitch:MapMenu"))
	fiss.saveBool("VATS_TOGGLE",GetINIBool("bVatsDisable:VATS"))
	fiss.saveBool("ALWAYS_ACTIVE_TOGGLE",GetINIBool("bAlwaysActive:General"))
	fiss.saveBool("ESSENTIAL_NPC_TOGGLE",GetINIBool("bEssentialTakeNoDamage:Gameplay"))
	fiss.saveBool("LEGENDARY_BONUS_TOGGLE",PlayerRef.HasSpell(GBT_legendaryBonus))
	fiss.saveFloat("GBT_legendaryBonus_Float", GBT_legendaryBonus_Float)
	fiss.saveBool("ARROW_FAMINE_TOGGLE",PlayerRef.HasSpell(GBT_arrowFamine))
	fiss.saveFloat("GBT_arrowFamine_Float", GBT_arrowFamine_Float)
	fiss.saveBool("SNEAK_FATIGUE_TOGGLE",PlayerRef.HasSpell(GBT_sneakFatigue))
	fiss.saveFloat("GBT_sneakFatigue_Float", GBT_sneakFatigue_Float)
	fiss.saveBool("TIMED_BLOCK_TOGGLE",PlayerRef.HasSpell(GBT_enableTimedBlock))
	fiss.saveFloat("GBT_timeBlockWeapon_Float", GBT_timeBlockWeapon_Float)
	fiss.saveFloat("GBT_timeBlockShield_Float", GBT_timeBlockShield_Float)
	fiss.saveFloat("GBT_timeBlockReflect_Float", GBT_timeBlockReflect_Float)
	fiss.saveFloat("GBT_timeBlockWard_Float", GBT_timeBlockWard_Float)
	fiss.saveFloat("GBT_timeBlockDamage_Float", GBT_timeBlockDamage_Float)
	fiss.saveFloat("GBT_timeBlockXP_Float", GBT_timeBlockXP_Float)
	fiss.saveBool("ITEM_LIMITER_TOGGLE",PlayerRef.HasSpell(GBT_enableItemAdded))
	fiss.saveInt("GBT_limitLockpick_Int", GBT_limitLockpick_Int)
	fiss.saveInt("GBT_limitArrow_Int", GBT_limitArrow_Int)
	fiss.saveInt("GBT_limitPotion_Int", GBT_limitPotion_Int)
	fiss.saveInt("GBT_limitPoison_Int", GBT_limitPoison_Int)
	fiss.saveBool("PLAYER_STAGGER_TOGGLE",PlayerRef.HasSpell(GBT_enableOnHit))
	fiss.saveFloat("GBT_staggerTaken_Float", GBT_staggerTaken_Float)
	fiss.saveFloat("GBT_staggerImmunity_Float", GBT_staggerImmunity_Float)
	fiss.saveFloat("GBT_staggerArmor_Float", GBT_staggerArmor_Float)
	fiss.saveFloat("GBT_staggerMagicka_Float", GBT_staggerMagicka_Float)
	fiss.saveFloat("GBT_staggerMin_Float", GBT_staggerMin_Float)
	fiss.saveFloat("GBT_staggerMax_Float", GBT_staggerMax_Float)
	fiss.saveBool("NPC_STAGGER_TOGGLE",PlayerRef.HasSpell(GBT_enableMeleeStagger))
	fiss.saveFloat("GBT_MeleeStaggerMult_Float", GBT_MeleeStaggerMult_Float)
	fiss.saveFloat("GBT_MeleeStaggerBase_Float", GBT_MeleeStaggerBase_Float)
	fiss.saveFloat("GBT_MeleeStaggerWeight_Float", GBT_MeleeStaggerWeight_Float)
	fiss.saveFloat("GBT_MeleeStaggerCD_Float", GBT_MeleeStaggerCD_Float)
	fiss.saveBool("BLEEDOUT_TOGGLE",PlayerRef.HasSpell(GBT_enableBleedout))
	fiss.saveFloat("GBT_bleedoutBase_Float", GBT_bleedoutBase_Float)
	fiss.saveInt("GBT_bleedoutMult_Int", GBT_bleedoutMult_Int)
	fiss.saveInt("GBT_bleedoutLivesMax_Int", GBT_bleedoutLivesMax_Int)
	fiss.saveBool("ARMOR_CMBEXP_TOGGLE",PlayerRef.HasSpell(GBT_EnableCombatState))
	fiss.saveFloat("GBT_ArmorExp_Float", GBT_ArmorExp_Float)
	fiss.saveFloat("GBT_BlockExp_Float", GBT_BlockExp_Float)
	fiss.saveBool("SliderModeVar",SliderModeVar)
	fiss.saveBool("isRegistered", isRegistered)
	fiss.saveBool("ShowMessages", ShowMessages)
	fiss.saveInt("saveHotkey", saveHotkey)
	fiss.saveInt("isQuickSave", isQuickSave)
	string saveResult = fiss.endSave()
	IF saveResult != ""
		Trace(saveResult)
		RETURN
	ENDIF
ENDFUNCTION

;======================================================================
;===========================FISS LOAD ALL=============================
;======================================================================
FUNCTION fissLoadAll()
	float ftimeStart = GetCurrentRealTime()
	FISSInterface fiss = FISSFactory.getFISS()
	If !fiss
		Debug.Notification("Error: SkyTweak now requires FISS to work.")
		RETURN
	ENDIF
	fiss.beginLoad(FissFilename + ".xml")

	IF fiss.loadInt("Version") != GetVersion()
		IF !ShowMessage("You are trying to load an outdated XML.\nAny new settings added in the new version will be incorrectly loaded as 0.\nAre you sure you want to proceed?")
			RETURN
		ENDIF
	ENDIF
	IF !ShowMessage("Are you sure? Wait for a completion message if your accept.")
		RETURN
	ENDIF
	loadPerk(GBT_Temper_Scale, fiss.loadBool("TEMPER_SCALE_TOGGLE"))
	loadPerkFloat1(GBT_shoutScale, (fiss.LoadFloat("SHOUT_SCALE_SLIDER") - 0) / 100, (0.0 - 0) / 100, 1)
	loadPerk(GBT_Critical_Damage_Scaling, fiss.loadBool("CRIT_SCALE_TOGGLE"))
	loadPerk(GBT_Bleed_Damage_Scaling, fiss.loadBool("BLEED_SCALE_TOGGLE"))
	loadPerk(GBT_Stamina_Cost_Scaling, fiss.loadBool("STAMINACOST_SCALE_TOGGLE"))
	loadPerk(GBT_illScaleTargetLevel, fiss.loadBool("ILLTARGLVL_SCALE_TOGGLE"))
	loadPerk(GBT_friendlyDamage, fiss.loadBool("FRIENDLY_DAMAGE_TOGGLE"))
	loadPerkFloat2(GBT_trapMagnitude, (fiss.LoadFloat("TRAP_MAGNITUDE_SLIDER") - 0) / 100, (100.0 - 0) / 100, 0)
	loadPerk(GBT_friendlyStagger, fiss.loadBool("FRIENDLY_STAGGER_TOGGLE"))
	loadPerkFloat1(GBT_WerewolfDamageDealt, (fiss.LoadFloat("WEREDMG_DEALT_SLIDER") - 0) / 100, (100.0 - 0) / 100, 0)
	loadPerkFloat1(GBT_WerewolfDamageTaken, (fiss.LoadFloat("WEREDMG_TAKEN_SLIDER") - 0) / 100, (100.0 - 0) / 100, 0)
	loadPerkFloat1(GBT_poisonDose, (fiss.LoadFloat("POISON_DOSE_SLIDER") - 0) / 1, (0.0 - 0) / 1, 0)
	SetGamesettingFloat("fMagicDualCastingEffectivenessBase", fiss.loadFloat("DUALCAST_POWER_SLIDER") )
	SetGamesettingFloat("fMagicDualCastingCostMult", fiss.loadFloat("DUALCAST_COST_SLIDER") )
	SetGamesettingFloat("fMagicCasterPCSkillCostBase", fiss.loadFloat("MAGICCOST_SCALE_SLIDER") )
	SetGamesettingFloat("fMagicCasterPCSkillCostMult", fiss.loadFloat("MAGIC_COST_SLIDER") )
	SetGamesettingFloat("fMagicCasterSkillCostBase", fiss.loadFloat("NPCMAGICCOST_SCALE_SLIDER") )
	SetGamesettingFloat("fMagicCasterSkillCostMult", fiss.loadFloat("NPCMAGIC_COST_SLIDER") )
	SetGamesettingInt("iMaxPlayerRunes", fiss.loadInt("MAX_RUNES_SLIDER") )
	SetGamesettingInt("iMaxSummonedCreatures", fiss.loadInt("MAX_SUMMONED_SLIDER") )
	SetGamesettingFloat("fMagicTelekinesisDamageBase", fiss.loadFloat("TELEKIN_DAMAGE_SLIDER") )
	SetGamesettingFloat("fMagicTelekinesisDualCastDamageMult", fiss.loadFloat("TELEKIN_DUALMULT_SLIDER") )
	loadPerkFloat1(GBT_altScaleMag, (fiss.LoadFloat("ALTMAG_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_conjScaleMag, (fiss.LoadFloat("CONJMAG_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_altScaleDurNotPara, (fiss.LoadFloat("ALTDURNOTPARA_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_conjScaleDur, (fiss.LoadFloat("CONJDUR_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_altScaleCost, (fiss.LoadFloat("ALTCOST_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_conjScaleCost, (fiss.LoadFloat("CONJCOST_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_altScaleDurPara, (fiss.LoadFloat("ALTDURPARA_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_conjScaleBoundMelee, (fiss.LoadFloat("BOUNTMELEE_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_altScaleCostDet, (fiss.LoadFloat("ALTCOSTDET_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_conjScaleBoundBow, (fiss.LoadFloat("BOUNDBOW_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_desScaleMag, (fiss.LoadFloat("DESMAG_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_restScaleMagHeal, (fiss.LoadFloat("HEALMAG_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_desScaleDur, (fiss.LoadFloat("DESDUR_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_restScaleDurHeal, (fiss.LoadFloat("HEALDUR_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_desScaleCost, (fiss.LoadFloat("DESCOST_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_restScaleCostHeal, (fiss.LoadFloat("HEALCOST_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_illScaleMag, (fiss.LoadFloat("ILLMAG_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_nonHealScaleMag, (fiss.LoadFloat("NONHEALMAG_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_illScaleDur, (fiss.LoadFloat("ILLDUR_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_nonHealScaleDur, (fiss.LoadFloat("NONHEALDUR_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_illScaleCost, (fiss.LoadFloat("ILLCOST_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_nonHealScaleCost, (fiss.LoadFloat("NONHEALCOST_SCALE_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	SetGamesettingFloat("fMagicLesserPowerCooldownTimer", fiss.loadFloat("LESSERPOWER_COOLDOWN_SLIDER") )
	scaleDamageDealt_VAR = fiss.loadFloat("DAMAGEDEALTSCALE")
	scaleDamageTaken_VAR = fiss.loadFloat("DAMAGETAKENSCALE")
	SetGamesettingFloat("fDiffMultHPByPCVE", fiss.loadFloat("DAMAGEDEALT_NOVICE_SLIDER") * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
	SetGamesettingFloat("fDiffMultHPToPCVE", fiss.loadFloat("DAMAGETAKEN_NOVICE_SLIDER") * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
	SetGamesettingFloat("fDiffMultHPByPCE", fiss.loadFloat("DAMAGEDEALT_APPRENTICE_SLIDER") * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
	SetGamesettingFloat("fDiffMultHPToPCE", fiss.loadFloat("DAMAGETAKEN_APPRENTICE_SLIDER") * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
	SetGamesettingFloat("fDiffMultHPByPCN", fiss.loadFloat("DAMAGEDEALT_ADEPT_SLIDER") * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
	SetGamesettingFloat("fDiffMultHPToPCN", fiss.loadFloat("DAMAGETAKEN_ADEPT_SLIDER") * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
	SetGamesettingFloat("fDiffMultHPByPCH", fiss.loadFloat("DAMAGEDEALT_EXPERT_SLIDER") * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
	SetGamesettingFloat("fDiffMultHPToPCH", fiss.loadFloat("DAMAGETAKEN_EXPERT_SLIDER") * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
	SetGamesettingFloat("fDiffMultHPByPCVH", fiss.loadFloat("DAMAGEDEALT_MASTER_SLIDER") * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
	SetGamesettingFloat("fDiffMultHPToPCVH", fiss.loadFloat("DAMAGETAKEN_MASTER_SLIDER") * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
	SetGamesettingFloat("fDiffMultHPByPCL", fiss.loadFloat("DAMAGEDEALT_LEGENDARY_SLIDER") * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()) )
	SetGamesettingFloat("fDiffMultHPToPCL", fiss.loadFloat("DAMAGETAKEN_LEGENDARY_SLIDER") * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()) )
	SetGamesettingFloat("fDamagePCSkillMin", fiss.loadFloat("WEAPONSCALE_PCMIN_SLIDER") )
	SetGamesettingFloat("fDamagePCSkillMax", fiss.loadFloat("WEAPONSCALE_PCMAX_SLIDER") )
	SetGamesettingFloat("fDamageSkillMin", fiss.loadFloat("WEAPONSCALE_NPCMIN_SLIDER") )
	SetGamesettingFloat("fDamageSkillMax", fiss.loadFloat("WEAPONSCALE_NPCMAX_SLIDER") )
	SetGamesettingFloat("fArmorScalingFactor", fiss.loadFloat("ARMOR_SCALE_SLIDER") )
	SetGamesettingFloat("fPlayerMaxResistance", fiss.loadFloat("MAX_RESISTANCE_SLIDER") )
	SetGamesettingFloat("fArmorBaseFactor", fiss.loadFloat("ARMOR_BASERESIST_SLIDER") )
	SetGamesettingFloat("fMaxArmorRating", fiss.loadFloat("ARMOR_MAXRESIST_SLIDER") )
	SetGamesettingFloat("fArmorRatingPCMax", fiss.loadFloat("PC_ARMORRATING_SLIDER") )
	SetGamesettingFloat("fArmorRatingMax", fiss.loadFloat("NPC_ARMORRATING_SLIDER") )
	SetGamesettingFloat("fMoveEncumEffect", fiss.loadFloat("ENCUM_EFFECT_SLIDER") )
	SetGamesettingFloat("fMoveEncumEffectNoWeapon", fiss.loadFloat("ENCUMWEAP_EFFECT_SLIDER") )
	SetGamesettingFloat("fDamageWeaponMult", fiss.loadFloat("WEAPONDAMAGE_MULT_SLIDER") )
	SetGamesettingFloat("fWeaponTwoHandedAnimationSpeedMult", fiss.loadFloat("TWOHAND_ATKSPD_SLIDER") )
	SetGamesettingFloat("fAutoAimScreenPercentage", fiss.loadFloat("AUTOAIM_AREA_SLIDER") )
	SetGamesettingFloat("fAutoAimMaxDistance", fiss.loadFloat("AUTOAIM_RANGE_SLIDER") )
	SetGamesettingFloat("fAutoAimMaxDegrees", fiss.loadFloat("AUTOAIM_DEGREES_SLIDER") )
	SetGamesettingFloat("fAutoAimMaxDegrees3rdPerson", fiss.loadFloat("AUTOAIM_DEGREESTHIRD_SLIDER") )
	SetGamesettingFloat("fPowerAttackStaminaPenalty", fiss.loadFloat("STAMINA_POWERCOST_SLIDER") )
	SetGamesettingFloat("fStaminaBlockDmgMult", fiss.loadFloat("STAMINA_BLOCKCOSTMULT_SLIDER") )
	SetGamesettingFloat("fStaminaBashBase", fiss.loadFloat("STAMINA_BASHCOST_SLIDER") )
	SetGamesettingFloat("fStaminaPowerBashBase", fiss.loadFloat("STAMINA_POWERBASHCOST_SLIDER") )
	SetGamesettingFloat("fStaminaBlockBase", fiss.loadFloat("STAMINA_BLOCKCOSTBASE_SLIDER") )
	SetGamesettingFloat("fShieldBaseFactor", fiss.loadFloat("BLOCK_SHIELD_SLIDER") )
	SetGamesettingFloat("fBlockWeaponBase", fiss.loadFloat("BLOCK_WEAPON_SLIDER") )
	SetGamesettingFloat("fCombatDistance", fiss.loadFloat("WEAPON_REACH_SLIDER") )
	SetGamesettingFloat("fCombatBashReach", fiss.loadFloat("BASH_REACH_SLIDER") )
	SetGamesettingFloat("fCombatStealthPointRegenAttackedWaitTime", fiss.loadFloat("AISEARCH_TIME_SLIDER") )
	SetGamesettingFloat("fCombatStealthPointRegenDetectedEventWaitTime", fiss.loadFloat("AISEARCH_TIMEATTACKED_SLIDER") )
	SetGamesettingFloat("fPlayerDetectionSneakBase", fiss.loadFloat("SNEAKLEVEL_BASE_SLIDER") )
	SetGamesettingFloat("fPlayerDetectionSneakMult", fiss.loadFloat("SNEAKDETECTION_SCALE_SLIDER") )
	SetGamesettingFloat("fDetectionViewCone", fiss.loadFloat("DETECTION_FOV_SLIDER") )
	SetGamesettingFloat("fSneakBaseValue", fiss.loadFloat("SNEAK_BASE_SLIDER") )
	SetGamesettingFloat("fDetectionSneakLightMod", fiss.loadFloat("DETECTION_LIGHT_SLIDER") )
	SetGamesettingFloat("fSneakLightExteriorMult", fiss.loadFloat("DETECTION_LIGHTEXT_SLIDER") )
	SetGamesettingFloat("fSneakSoundsMult", fiss.loadFloat("DETECTION_SOUND_SLIDER") )
	SetGamesettingFloat("fSneakSoundLosMult", fiss.loadFloat("DETECTION_SOUNDLOS_SLIDER") )
	SetGamesettingFloat("fPickPocketMaxChance", fiss.loadFloat("PICKPOCKET_MAXCHANCE_SLIDER") )
	SetGamesettingFloat("fPickPocketMinChance", fiss.loadFloat("PICKPOCKET_MINCHANCE_SLIDER") )
	loadPerkFloat1(GBT_SneakMarks, (fiss.LoadFloat("SNEAKMULT_MARKSMAN_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakDagger, (fiss.LoadFloat("SNEAKMULT_DAGGER_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakOne, (fiss.LoadFloat("SNEAKMULT_TWOHAND_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakTwo, (fiss.LoadFloat("SNEAKMULT_ONEHAND_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakH2H, (fiss.LoadFloat("SNEAKMULT_UNARMED_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakRuneMag, (fiss.LoadFloat("SNEAKMULT_RUNE_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakSearch, (fiss.LoadFloat("SNEAKMULT_SEARCH_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakSpellMag, (fiss.LoadFloat("SNEAKMULT_SPELLMAG_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakSpellSearch, (fiss.LoadFloat("SNEAKMULT_SPELLSEARCH_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakSpellDur, (fiss.LoadFloat("SNEAKMULT_SPELLDUR_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakScalePhys, (fiss.LoadFloat("SNEAKSCALE_PHYSICAL_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_SneakScaleSpell, (fiss.LoadFloat("SNEAKSCALE_SPELLMAG_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_SneakPoisonMag, (fiss.LoadFloat("SNEAKMULT_POISONMAG_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakPoisonDur, (fiss.LoadFloat("SNEAKMULT_POISONDUR_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakScalePoisonMag, (fiss.LoadFloat("SNEAKSCALE_POISONMAG_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_SneakScalePoisonDur, (fiss.LoadFloat("SNEAKSCALE_POISONDUR_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	SetGamesettingFloat("fSweetSpotVeryEasy", fiss.loadFloat("LOCKPICK_VEASY_SLIDER") )
	SetGamesettingFloat("fLockpickBreakNovice", fiss.loadFloat("LOCKPICKDUR_VEASY_SLIDER") )
	SetGamesettingFloat("fSweetSpotEasy", fiss.loadFloat("LOCKPICK_EASY_SLIDER") )
	SetGamesettingFloat("fLockpickBreakApprentice", fiss.loadFloat("LOCKPICKDUR_EASY_SLIDER") )
	SetGamesettingFloat("fSweetSpotAverage", fiss.loadFloat("LOCKPICK_AVERAGE_SLIDER") )
	SetGamesettingFloat("fLockpickBreakAdept", fiss.loadFloat("LOCKPICKDUR_AVERAGE_SLIDER") )
	SetGamesettingFloat("fSweetSpotHard", fiss.loadFloat("LOCKPICK_HARD_SLIDER") )
	SetGamesettingFloat("fLockpickBreakExpert", fiss.loadFloat("LOCKPICKDUR_HARD_SLIDER") )
	SetGamesettingFloat("fSweetSpotVeryHard", fiss.loadFloat("LOCKPICK_VHARD_SLIDER") )
	SetGamesettingFloat("fLockpickBreakMaster", fiss.loadFloat("LOCKPICKDUR_VHARD_SLIDER") )
	SetGamesettingFloat("fAlchemyIngredientInitMult", fiss.loadFloat("ALCHEMYMAG_MULT_SLIDER") )
	SetGamesettingFloat("fAlchemySkillFactor", fiss.loadFloat("ALCHEMYMAG_SCALE_SLIDER") )
	loadPerkFloat1(GBT_bonusIngredients, (fiss.LoadFloat("BONUS_INGR_SLIDER") - 0) / 1, (0.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_bonusPotions, (fiss.LoadFloat("BONUS_POTION_SLIDER") - 0) / 1, (0.0 - 0) / 1, 0)
	SetGamesettingFloat("fEnchantingCostExponent", fiss.loadFloat("CHARGECOST_POWER_SLIDER") )
	SetGamesettingFloat("fEnchantingSkillFactor", fiss.loadFloat("ENCHANT_SCALING_SLIDER") )
	SetGamesettingFloat("fEnchantingSkillCostMult", fiss.loadFloat("CHARGECOST_MULT_SLIDER") )
	SetGamesettingFloat("fEnchantmentEffectPointsMult", fiss.loadFloat("ENCHANTPRICE_EFFECT_SLIDER") )
	SetGamesettingFloat("fEnchantingSkillCostBase", fiss.loadFloat("CHARGECOST_BASE_SLIDER") )
	SetGamesettingFloat("fEnchantmentPointsMult", fiss.loadFloat("ENCHANTPRICE_SOUL_SLIDER") )
	loadPerkFloat1(GBT_enchantCharge, (fiss.LoadFloat("ENCHANT_CHARGE_SLIDER") - 0) / 100, (100.0 - 0) / 100, 0)
	loadPerkFloat1(GBT_enchantMag, (fiss.LoadFloat("ENCHANT_MAG_SLIDER") - 0) / 100, (100.0 - 0) / 100, 0)
	loadPerkFloat1(GBT_bonusEnchants, (fiss.LoadFloat("BONUS_ENCHANT_SLIDER") - 0) / 1, (0.0 - 0) / 1, 0)
	SetGamesettingFloat("fSmithingConditionFactor", fiss.loadFloat("TEMPER_SUFFIX_SLIDER") )
	SetGamesettingFloat("fSmithingArmorMax", fiss.loadFloat("TEMPER_ARMOR_SLIDER") )
	SetGamesettingFloat("fSmithingWeaponMax", fiss.loadFloat("TEMPER_WEAPON_SLIDER") )
	loadPerkFloat1(GBT_PotionMag, (fiss.LoadFloat("POTION_MAG_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_PotionDur, (fiss.LoadFloat("POTION_DUR_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_PotionScaleMag, (fiss.LoadFloat("POTION_SCALEMAG_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_PotionScaleDur, (fiss.LoadFloat("POTION_SCALEDUR_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_PoisonMag, (fiss.LoadFloat("POISON_MAG_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_PoisonDur, (fiss.LoadFloat("POISON_DUR_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_PoisonScaleMag, (fiss.LoadFloat("POISON_SCALEMAG_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_PoisonScaleDur, (fiss.LoadFloat("POISON_SCALEDUR_SLIDER") - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_ScrollMag, (fiss.LoadFloat("SCROLL_MAG_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_ScrollDur, (fiss.LoadFloat("SCROLL_DUR_SLIDER") - 0) / 1, (1.0 - 0) / 1, 0)
	SetGamesettingFloat("fBarterBuyMin", fiss.loadFloat("BARTER_BUYMIN_SLIDER") )
	SetGamesettingFloat("fBarterSellMax", fiss.loadFloat("BARTER_SELLMAX_SLIDER") )
	SetGamesettingFloat("fBarterMin", fiss.loadFloat("BARTER_MIN_SLIDER") )
	SetGamesettingFloat("fBarterMax", fiss.loadFloat("BARTER_MAX_SLIDER") )
	loadPerkFloat1(GBT_buyPrice, (fiss.LoadFloat("BUY_PRICE_SLIDER") - 0) / 100, (100.0 - 0) / 100, 0)
	loadPerkFloat1(GBT_sellPrice, (fiss.LoadFloat("SELL_PRICE_SLIDER") - 0) / 100, (100.0 - 0) / 100, 0)
	SetGamesettingInt("iDaysToRespawnVendor", fiss.loadInt("VENDOR_RESPAWN_SLIDER") )
	SetGamesettingInt("iTrainingNumAllowedPerLevel", fiss.loadInt("TRAINING_NUMALLOWED_SLIDER") )
	SetGamesettingInt("iTrainingJourneymanCost", fiss.loadInt("TRAINING_JOURNEYMANCOST_SLIDER") )
	SetGamesettingInt("iTrainingJourneymanSkill", fiss.loadInt("TRAINING_JOURNEYMANSKILL_SLIDER") )
	SetGamesettingInt("iTrainingExpertCost", fiss.loadInt("TRAINING_EXPERTCOST_SLIDER") )
	SetGamesettingInt("iTrainingExpertSkill", fiss.loadInt("TRAINING_EXPERTSKILL_SLIDER") )
	SetGamesettingInt("iTrainingMasterCost", fiss.loadInt("TRAINING_MASTERCOST_SLIDER") )
	SetGamesettingInt("iTrainingMasterSkill", fiss.loadInt("TRAINING_MASTERSKILL_SLIDER") )
	SetNthLevelItemCount(VendorGoldApothecary,0, fiss.loadInt("APOTHECARY_GOLD_SLIDER") )
	SetNthLevelItemCount(VendorGoldBlacksmith,0, fiss.loadInt("BLACKSMITH_GOLD_SLIDER") )
	SetNthLevelItemCount(VendorGoldBlacksmithOrc,0, fiss.loadInt("ORCBLACKSMITH_GOLD_SLIDER") )
	SetNthLevelItemCount(VendorGoldBlacksmithTown,0, fiss.loadInt("TOWNBLACKSMITH_GOLD_SLIDER") )
	SetNthLevelItemCount(VendorGoldInn,0, fiss.loadInt("INNKEERPER_GOLD_SLIDER") )
	SetNthLevelItemCount(VendorGoldMisc,0, fiss.loadInt("MISCMERCHANT_GOLD_SLIDER") )
	SetNthLevelItemCount(VendorGoldSpells,0, fiss.loadInt("SPELLMERCHANT_GOLD_SLIDER") )
	SetNthLevelItemCount(VendorGoldStreetVendor,0, fiss.loadInt("STREETVENDOR_GOLD_SLIDER") )
	SetGamesettingFloat("fCombatStaminaRegenRateMult", fiss.loadFloat("COMBAT_STAMINAREGEN_SLIDER") )
	SetGamesettingFloat("fDamagedStaminaRegenDelay", fiss.loadFloat("DAMAGESTAMINA_DELAY_SLIDER") )
	SetGamesettingFloat("fBowZoomStaminaRegenDelay", fiss.loadFloat("BOWZOOM_REGENDELAY_SLIDER") )
	SetGamesettingFloat("fCombatMagickaRegenRateMult", fiss.loadFloat("COMBAT_MAGICKAREGEN_SLIDER") )
	SetGamesettingFloat("fStaminaRegenDelayMax", fiss.loadFloat("STAMINA_REGENDELAY_SLIDER") )
	SetGamesettingFloat("fDamagedMagickaRegenDelay", fiss.loadFloat("DAMAGEMAGICKA_DELAY_SLIDER") )
	SetGamesettingFloat("fMagickaRegenDelayMax", fiss.loadFloat("MAGICKA_REGENDELAY_SLIDER") )
	PlayerRef.SetAV("HealRate", fiss.loadFloat("AV_HEALRATE_SLIDER"))
	PlayerRef.SetAV("MagickaRate", fiss.loadFloat("AV_MAGICKARATE_SLIDER"))
	PlayerRef.SetAV("StaminaRate", fiss.loadFloat("AV_STAMINARATE_SLIDER"))
	PlayerRef.SetAV("CarryWeight", fiss.loadFloat("AV_CARRYWEIGHT_SLIDER"))
	PlayerRef.SetAV("SpeedMult", fiss.loadFloat("AV_SPEEDMULT_SLIDER"))
	PlayerRef.SetAV("UnarmedDamage", fiss.loadFloat("AV_UNARMEDDAMAGE_SLIDER"))
	PlayerRef.SetAV("Mass", fiss.loadFloat("AV_MASS_SLIDER"))
	PlayerRef.SetAV("CritChance", fiss.loadFloat("AV_CRITCHANCE_SLIDER"))
	PlayerRef.SetAV("BowSpeedBonus", fiss.loadFloat("AV_BOWSPEEDBONUSVAR_SLIDER"))
	TimeScale.SetValueInt(fiss.loadInt("TIME_SCALE_SLIDER"))
	SetGamesettingFloat("fJumpFallHeightMinNPC", fiss.loadFloat("FALLHEIGHT_MINNPC_SLIDER") )
	SetGamesettingFloat("fJumpFallHeightMin", fiss.loadFloat("FALLHEIGHT_MIN_SLIDER") )
	SetGamesettingFloat("fJumpFallHeightMultNPC", fiss.loadFloat("FALLHEIGHT_MULTNPC_SLIDER") )
	SetGamesettingFloat("fJumpFallHeightMult", fiss.loadFloat("FALLHEIGHT_MULT_SLIDER") )
	SetGamesettingFloat("fJumpFallHeightExponentNPC", fiss.loadFloat("FALLHEIGHT_EXPNPC_SLIDER") )
	SetGamesettingFloat("fJumpFallHeightExponent", fiss.loadFloat("FALLHEIGHT_EXP_SLIDER") )
	SetGamesettingFloat("fJumpHeightMin", fiss.loadFloat("JUMP_HEIGHT_SLIDER") )
	SetGamesettingFloat("fActorSwimBreathBase", fiss.loadFloat("SWIM_BREATHBASE_SLIDER") )
	SetGamesettingFloat("fActorSwimBreathDamage", fiss.loadFloat("SWIM_BREATHDAMAGE_SLIDER") )
	SetGamesettingFloat("fActorSwimBreathMult", fiss.loadFloat("SWIM_BREATHMULT_SLIDER") )
	SetGamesettingFloat("fKillCamBaseOdds", fiss.loadFloat("KILLCAM_CHANCE_SLIDER") )
	SetGamesettingFloat("fPlayerDeathReloadTime", fiss.loadFloat("DEATHCAMERA_TIME_SLIDER") )
	KillMoveRandom.SetValue(fiss.loadFloat("KILLMOVE_CHANCE_SLIDER"))
	DecapitationChance.SetValue(fiss.loadFloat("DECAPITATION_CHANCE_SLIDER"))
	SetGamesettingFloat("fSprintStaminaDrainMult", fiss.loadFloat("SPRINT_DRAINBASE_SLIDER") )
	SetGamesettingFloat("fSprintStaminaWeightMult", fiss.loadFloat("SPRINT_DRAINMULT_SLIDER") )
	SetGamesettingInt("iArrowInventoryChance", fiss.loadInt("ARROW_RECOVERY_SLIDER") )
	SetGamesettingInt("iDeathDropWeaponChance", fiss.loadInt("DEATH_DROPCHANCE_SLIDER") )
	SetGamesettingFloat("fCameraShakeTime", fiss.loadFloat("CAMERA_SHAKETIME_SLIDER") )
	SetGamesettingFloat("fFastTravelSpeedMult", fiss.loadFloat("FASTRAVEL_SPEED_SLIDER") )
	SetGamesettingFloat("fHUDCompassLocationMaxDist", fiss.loadFloat("HUDCOMPASS_DISTANEC_SLIDER") )
	SetGamesettingInt("iMaxAttachedArrows", fiss.loadInt("ATTACHED_ARROWS_SLIDER") )
	SetLightRadius(Torch01,fiss.loadInt("LightRadius_OID"))
	SetLightDuration(Torch01,fiss.loadInt("LightDuration_OID"))
	SpecialLootChance.SetValueInt(fiss.loadInt("SPECIAL_LOOT_SLIDER"))
	SetGamesettingFloat("fFriendHitTimer", fiss.loadFloat("FRIENDHIT_TIMER_SLIDER") )
	SetGamesettingFloat("fFriendMinimumLastHitTime", fiss.loadFloat("FRIENDHIT_INTERVAL_SLIDER") )
	SetGamesettingInt("iFriendHitCombatAllowed", fiss.loadInt("FRIENDHIT_COMBAT_SLIDER") )
	SetGamesettingInt("iFriendHitNonCombatAllowed", fiss.loadInt("FRIENDHIT_NONCOMBAT_SLIDER") )
	SetGamesettingInt("iAllyHitCombatAllowed", fiss.loadInt("ALLYHIT_COMBAT_SLIDER") )
	SetGamesettingInt("iAllyHitNonCombatAllowed", fiss.loadInt("ALLYHIT_NONCOMBAT_SLIDER") )
	SetGamesettingFloat("fCombatDodgeChanceMax", fiss.loadFloat("COMBAT_DODGECHANCE_SLIDER") )
	SetGamesettingFloat("fCombatAimProjectileRandomOffset", fiss.loadFloat("COMBAT_AIMOFFSET_SLIDER") )
	SetGamesettingFloat("fAIFleeHealthMult", fiss.loadFloat("COMBAT_FLEEHEALTH_SLIDER") )
	SetGamesettingFloat("fGameplayVoiceFilePadding", fiss.loadFloat("DIALOGUE_PADDING_SLIDER") )
	SetGamesettingFloat("fAIMinGreetingDistance", fiss.loadFloat("DIALOGUE_DISTANCE_SLIDER") )
	SetGamesettingFloat("fFollowSpaceBetweenFollowers", fiss.loadFloat("FOLLOWER_SPACING_SLIDER") )
	SetGamesettingFloat("fFollowExtraCatchUpSpeedMult", fiss.loadFloat("FOLLOWER_CATCHUP_SLIDER") )
	SetGamesettingFloat("fLevelScalingMult", fiss.loadFloat("LEVELSCALING_MULT_SLIDER") )
	SetGamesettingFloat("fLeveledActorMultEasy", fiss.loadFloat("LEVELEDACTOR_EASY_SLIDER") )
	SetGamesettingFloat("fLeveledActorMultHard", fiss.loadFloat("LEVELEDACTOR_HARD_SLIDER") )
	SetGamesettingFloat("fLeveledActorMultMedium", fiss.loadFloat("LEVELEDACTOR_MEDIUM_SLIDER") )
	SetGamesettingFloat("fLeveledActorMultVeryHard", fiss.loadFloat("LEVELEDACTOR_VHARD_SLIDER") )
	SetGamesettingInt("iHoursToRespawnCell", fiss.loadInt("RESPAWN_TIME_SLIDER") )
	SetGamesettingFloat("fNPCHealthLevelBonus", fiss.loadFloat("NPC_HEALTHBONUS_SLIDER") )
	SetGamesettingInt("iAVDhmsLevelup", fiss.loadInt("LEVELUP_ATTRIBUTE_SLIDER") )
	SetGamesettingFloat("fLevelUpCarryWeightMod", fiss.loadFloat("LEVELUP_CARRYWEIGHT_SLIDER") )
	SetGamesettingFloat("fLegendarySkillResetValue", fiss.loadFloat("LEGENDARYRESET_LEVEL_SLIDER") )
	SetGamesettingFloat("fSkillUseCurve", fiss.loadFloat("LEVELUP_POWER_SLIDER") )
	SetGamesettingFloat("fXPLevelUpBase", fiss.loadFloat("LEVELUP_BASE_SLIDER") )
	SetGamesettingFloat("fXPLevelUpMult", fiss.loadFloat("LEVELUP_MULT_SLIDER") )
	GetAVIByID(16).SetSkillUseMult(fiss.loadFloat("SKILLUSE_ALCHEMY_SLIDER"))
	GetAVIByID(18).SetSkillUseMult(fiss.loadFloat("SKILLUSE_ALTERATION_SLIDER"))
	GetAVIByID(9).SetSkillUseMult(fiss.loadFloat("SKILLUSE_BLOCK_SLIDER"))
	GetAVIByID(19).SetSkillUseMult(fiss.loadFloat("SKILLUSE_CONJURATION_SLIDER"))
	GetAVIByID(20).SetSkillUseMult(fiss.loadFloat("SKILLUSE_DESTRUCTION_SLIDER"))
	GetAVIByID(23).SetSkillUseMult(fiss.loadFloat("SKILLUSE_ENCHANTING_SLIDER"))
	GetAVIByID(11).SetSkillUseMult(fiss.loadFloat("SKILLUSE_HEAVYARMOR_SLIDER"))
	GetAVIByID(21).SetSkillUseMult(fiss.loadFloat("SKILLUSE_ILLUSION_SLIDER"))
	GetAVIByID(12).SetSkillUseMult(fiss.loadFloat("SKILLUSE_LIGHTARMOR_SLIDER"))
	GetAVIByID(14).SetSkillUseMult(fiss.loadFloat("SKILLUSE_LOCKPICKING_SLIDER"))
	GetAVIByID(8).SetSkillUseMult(fiss.loadFloat("SKILLUSE_MARKSMAN_SLIDER"))
	GetAVIByID(6).SetSkillUseMult(fiss.loadFloat("SKILLUSE_ONEHANDED_SLIDER"))
	GetAVIByID(13).SetSkillUseMult(fiss.loadFloat("SKILLUSE_PICKPOCKET_SLIDER"))
	GetAVIByID(22).SetSkillUseMult(fiss.loadFloat("SKILLUSE_RESTORATION_SLIDER"))
	GetAVIByID(10).SetSkillUseMult(fiss.loadFloat("SKILLUSE_SMITHING_SLIDER"))
	GetAVIByID(15).SetSkillUseMult(fiss.loadFloat("SKILLUSE_SNEAK_SLIDER"))
	GetAVIByID(17).SetSkillUseMult(fiss.loadFloat("SKILLUSE_SPEECHCRAFT_SLIDER"))
	GetAVIByID(7).SetSkillUseMult(fiss.loadFloat("SKILLUSE_TWOHAND_SLIDER"))
	SetGamesettingFloat("fDeathForceRangedForceMin", fiss.loadFloat("RFORCE_MIN_SLIDER") )
	SetGamesettingFloat("fDeathForceRangedForceMax", fiss.loadFloat("RFORCE_MAX_SLIDER") )
	SetGamesettingFloat("fDeathForceForceMin", fiss.loadFloat("MFORCE_MIN_SLIDER") )
	SetGamesettingFloat("fDeathForceForceMax", fiss.loadFloat("MFORCE_MAX_SLIDER") )
	SetGamesettingFloat("fDeathForceSpellImpactMult", fiss.loadFloat("SFORCE_SLIDER") )
	SetGamesettingFloat("fZKeyMaxForce", fiss.loadFloat("GFORCE_SLIDER") )
	SetINIFloat("fDefaultWorldFOV:Display", fiss.loadFloat("FIRST_FOV_SLIDER") )
	SetINIFloat("fDefault1stPersonFOV:Display", fiss.loadFloat("THIRD_FOV_SLIDER") )
	SetINIFloat("fMouseHeadingXScale:Controls", fiss.loadFloat("XSENSITIVITY_SLIDER") )
	SetINIFloat("fMouseHeadingYScale:Controls", fiss.loadFloat("YSENSITIVITY_SLIDER") )
	SetINIFloat("fOverShoulderCombatAddY:Camera", fiss.loadFloat("COMBAT_SHOULDERY_SLIDER") )
	SetINIFloat("fOverShoulderCombatPosZ:Camera", fiss.loadFloat("COMBAT_SHOULDERZ_SLIDER") )
	SetINIFloat("fOverShoulderCombatPosX:Camera", fiss.loadFloat("COMBAT_SHOULDERX_SLIDER") )
	SetINIFloat("fOverShoulderPosZ:Camera", fiss.loadFloat("SHOULDERZ_SLIDER") )
	SetINIFloat("fOverShoulderPosX:Camera", fiss.loadFloat("SHOULDERX_SLIDER") )
	SetINIInt("iAutoSaveCount:SaveGame", fiss.loadInt("AUTOSAVE_COUNT_SLIDER") )
	SetINIBool("bShowCompass:Interface", fiss.loadBool("SHOWCOMPASS_TOGGLE"))
	SetINIBool("bDoDepthOfField:Imagespace", fiss.loadBool("DEPTHFIELD_TOGGLE"))
	SetINIBool("bEnableHavokHit:Animation", fiss.loadBool("HAVOK_HIT_TOGGLE"))
	SetINIFloat("fHavokHitImpulseMult:Animation", fiss.loadFloat("HAVOK_HIT_SLIDER") )
	SetINIBool("bShowTutorials:Interface", fiss.loadBool("SHOW_TUTORIAL_TOGGLE"))
	SetINIFloat("fBookOpenTime:Interface", fiss.loadFloat("BOOK_SPEED_SLIDER") )
	SetINIFloat("f1PArrowTiltUpAngle:Combat", fiss.loadFloat("FIRST_ARROWTILT_SLIDER") )
	SetINIFloat("f3PArrowTiltUpAngle:Combat", fiss.loadFloat("THIRD_ARROWTILT_SLIDER") )
	SetINIFloat("f1PBoltTiltUpAngle:Combat", fiss.loadFloat("FIRST_BOLTTILT_SLIDER") )
	SetINIBool("bForceNPCsUseAmmo:Combat", fiss.loadBool("NPC_USEAMMO_TOGGLE"))
	SetINIFloat("fVisibleNavmeshMoveDist:Actor", fiss.loadFloat("NAVMESH_DISTANCE_SLIDER") )
	SetINIFloat("fLandFriction:Landscape", fiss.loadFloat("FRICTION_LAND_SLIDER") )
	SetINIBool("bEnableTreeAnimations:Trees", fiss.loadBool("TREE_ANIMATION_TOGGLE"))
	SetINIBool("bDisableAllGore:General", fiss.loadBool("GORE_TOGGLE"))
	SetINIInt("iConsoleTextSize:Menu", fiss.loadInt("CONSOLE_TEXT_SLIDER") )
	SetINIInt("iConsoleSizeScreenPercent:Menu", fiss.loadInt("CONSOLE_PERCENT_SLIDER") )
	SetINIFloat("fMapWorldYawRange:MapMenu", fiss.loadFloat("MAP_YAW_SLIDER") )
	SetINIFloat("fMapWorldMaxPitch:MapMenu", fiss.loadFloat("MAP_PITCH_SLIDER") )
	SetINIBool("bVatsDisable:VATS", fiss.loadBool("VATS_TOGGLE"))
	SetINIBool("bAlwaysActive:General", fiss.loadBool("ALWAYS_ACTIVE_TOGGLE"))
	SetINIBool("bEssentialTakeNoDamage:Gameplay", fiss.loadBool("ESSENTIAL_NPC_TOGGLE"))
	loadSpell(GBT_legendaryBonus, fiss.loadBool("LEGENDARY_BONUS_TOGGLE"))
	GBT_legendaryBonus_Float = fiss.loadFloat("GBT_legendaryBonus_Float")
	loadSpell(GBT_arrowFamine, fiss.loadBool("ARROW_FAMINE_TOGGLE"))
	GBT_arrowFamine_Float = fiss.loadFloat("GBT_arrowFamine_Float")
	loadSpell(GBT_sneakFatigue, fiss.loadBool("SNEAK_FATIGUE_TOGGLE"))
	GBT_sneakFatigue_Float = fiss.loadFloat("GBT_sneakFatigue_Float")
	loadSpell(GBT_enableTimedBlock, fiss.loadBool("TIMED_BLOCK_TOGGLE"))
	GBT_timeBlockWeapon_Float = fiss.loadFloat("GBT_timeBlockWeapon_Float")
	GBT_timeBlockShield_Float = fiss.loadFloat("GBT_timeBlockShield_Float")
	GBT_timeBlockReflect_Float = fiss.loadFloat("GBT_timeBlockReflect_Float")
	GBT_timeBlockWard_Float = fiss.loadFloat("GBT_timeBlockWard_Float")
	GBT_timeBlockDamage_Float = fiss.loadFloat("GBT_timeBlockDamage_Float")
	GBT_timeBlockXP_Float = fiss.loadFloat("GBT_timeBlockXP_Float")
	loadSpell(GBT_enableItemAdded, fiss.loadBool("ITEM_LIMITER_TOGGLE"))
	GBT_limitLockpick_Int = fiss.loadInt("GBT_limitLockpick_Int")
	GBT_limitArrow_Int = fiss.loadInt("GBT_limitArrow_Int")
	GBT_limitPotion_Int = fiss.loadInt("GBT_limitPotion_Int")
	GBT_limitPoison_Int = fiss.loadInt("GBT_limitPoison_Int")
	loadSpell(GBT_enableOnHit, fiss.loadBool("PLAYER_STAGGER_TOGGLE"))
	GBT_staggerTaken_Float = fiss.loadFloat("GBT_staggerTaken_Float")
	GBT_staggerImmunity_Float = fiss.loadFloat("GBT_staggerImmunity_Float")
	GBT_staggerArmor_Float = fiss.loadFloat("GBT_staggerArmor_Float")
	GBT_staggerMagicka_Float = fiss.loadFloat("GBT_staggerMagicka_Float")
	GBT_staggerMin_Float = fiss.loadFloat("GBT_staggerMin_Float")
	GBT_staggerMax_Float = fiss.loadFloat("GBT_staggerMax_Float")
	loadSpell(GBT_enableMeleeStagger, fiss.loadBool("NPC_STAGGER_TOGGLE"))
	GBT_MeleeStaggerMult_Float = fiss.loadFloat("GBT_MeleeStaggerMult_Float")
	GBT_MeleeStaggerBase_Float = fiss.loadFloat("GBT_MeleeStaggerBase_Float")
	GBT_MeleeStaggerWeight_Float = fiss.loadFloat("GBT_MeleeStaggerWeight_Float")
	GBT_MeleeStaggerCD_Float = fiss.loadFloat("GBT_MeleeStaggerCD_Float")
	loadSpell(GBT_enableBleedout, fiss.loadBool("BLEEDOUT_TOGGLE"))
	GBT_bleedoutBase_Float = fiss.loadFloat("GBT_bleedoutBase_Float")
	GBT_bleedoutMult_Int = fiss.loadInt("GBT_bleedoutMult_Int")
	GBT_bleedoutLivesMax_Int = fiss.loadInt("GBT_bleedoutLivesMax_Int")
	loadSpell(GBT_EnableCombatState, fiss.loadBool("ARMOR_CMBEXP_TOGGLE"))
	GBT_ArmorExp_Float = fiss.loadFloat("GBT_ArmorExp_Float")
	GBT_BlockExp_Float = fiss.loadFloat("GBT_BlockExp_Float")
	SliderModeVar = fiss.loadBool("SliderModeVar")
	isRegistered = fiss.loadBool("isRegistered")
	ShowMessages = fiss.loadBool("ShowMessages")
	saveHotkey = fiss.loadInt("saveHotkey")
	isQuickSave = fiss.loadInt("isQuickSave")
	string loadResult = fiss.endLoad()
	ShowMessage("Done loading settings from FISS XML.",false)
	IF loadResult != ""
		Trace(loadResult)
		RETURN
	ENDIF
ENDFUNCTION

;======================================================================
;===========================LOCAL SAVE ALL============================
;======================================================================

FUNCTION localSaveAll()
	float ftimeStart = GetCurrentRealTime()

	TEMPER_SCALE_TOGGLE_VAR = PlayerRef.HasPerk(GBT_Temper_Scale)
	SHOUT_SCALE_SLIDER_VAR = (GBT_shoutScale.GetNthEntryValue(0, 1) * 100) + 0
	CRIT_SCALE_TOGGLE_VAR = PlayerRef.HasPerk(GBT_Critical_Damage_Scaling)
	BLEED_SCALE_TOGGLE_VAR = PlayerRef.HasPerk(GBT_Bleed_Damage_Scaling)
	STAMINACOST_SCALE_TOGGLE_VAR = PlayerRef.HasPerk(GBT_Stamina_Cost_Scaling)
	ILLTARGLVL_SCALE_TOGGLE_VAR = PlayerRef.HasPerk(GBT_illScaleTargetLevel)
	FRIENDLY_DAMAGE_TOGGLE_VAR = PlayerRef.HasPerk(GBT_friendlyDamage)
	TRAP_MAGNITUDE_SLIDER_VAR = (GBT_trapMagnitude.GetNthEntryValue(0, 0) * 100) + 0
	FRIENDLY_STAGGER_TOGGLE_VAR = PlayerRef.HasPerk(GBT_friendlyStagger)
	WEREDMG_DEALT_SLIDER_VAR = (GBT_WerewolfDamageDealt.GetNthEntryValue(0, 0) * 100) + 0
	WEREDMG_TAKEN_SLIDER_VAR = (GBT_WerewolfDamageTaken.GetNthEntryValue(0, 0) * 100) + 0
	POISON_DOSE_SLIDER_VAR = (GBT_poisonDose.GetNthEntryValue(0, 0) * 1) + 0
	DUALCAST_POWER_SLIDER_VAR = GetGameSettingFloat("fMagicDualCastingEffectivenessBase")
	DUALCAST_COST_SLIDER_VAR = GetGameSettingFloat("fMagicDualCastingCostMult")
	MAGICCOST_SCALE_SLIDER_VAR = GetGameSettingFloat("fMagicCasterPCSkillCostBase")
	MAGIC_COST_SLIDER_VAR = GetGameSettingFloat("fMagicCasterPCSkillCostMult")
	NPCMAGICCOST_SCALE_SLIDER_VAR = GetGameSettingFloat("fMagicCasterSkillCostBase")
	NPCMAGIC_COST_SLIDER_VAR = GetGameSettingFloat("fMagicCasterSkillCostMult")
	MAX_RUNES_SLIDER_VAR = GetGameSettingInt("iMaxPlayerRunes")
	MAX_SUMMONED_SLIDER_VAR = GetGameSettingInt("iMaxSummonedCreatures")
	TELEKIN_DAMAGE_SLIDER_VAR = GetGameSettingFloat("fMagicTelekinesisDamageBase")
	TELEKIN_DUALMULT_SLIDER_VAR = GetGameSettingFloat("fMagicTelekinesisDualCastDamageMult")
	ALTMAG_SCALE_SLIDER_VAR = (GBT_altScaleMag.GetNthEntryValue(0, 1) * 10000) + 100
	CONJMAG_SCALE_SLIDER_VAR = (GBT_conjScaleMag.GetNthEntryValue(0, 1) * 10000) + 100
	ALTDURNOTPARA_SCALE_SLIDER_VAR = (GBT_altScaleDurNotPara.GetNthEntryValue(0, 1) * 10000) + 100
	CONJDUR_SCALE_SLIDER_VAR = (GBT_conjScaleDur.GetNthEntryValue(0, 1) * 10000) + 100
	ALTCOST_SCALE_SLIDER_VAR = (GBT_altScaleCost.GetNthEntryValue(0, 1) * 10000) + 100
	CONJCOST_SCALE_SLIDER_VAR = (GBT_conjScaleCost.GetNthEntryValue(0, 1) * 10000) + 100
	ALTDURPARA_SCALE_SLIDER_VAR = (GBT_altScaleDurPara.GetNthEntryValue(0, 1) * 10000) + 100
	BOUNTMELEE_SCALE_SLIDER_VAR = (GBT_conjScaleBoundMelee.GetNthEntryValue(0, 1) * 10000) + 100
	ALTCOSTDET_SCALE_SLIDER_VAR = (GBT_altScaleCostDet.GetNthEntryValue(0, 1) * 10000) + 100
	BOUNDBOW_SCALE_SLIDER_VAR = (GBT_conjScaleBoundBow.GetNthEntryValue(0, 1) * 10000) + 100
	DESMAG_SCALE_SLIDER_VAR = (GBT_desScaleMag.GetNthEntryValue(0, 1) * 10000) + 100
	HEALMAG_SCALE_SLIDER_VAR = (GBT_restScaleMagHeal.GetNthEntryValue(0, 1) * 10000) + 100
	DESDUR_SCALE_SLIDER_VAR = (GBT_desScaleDur.GetNthEntryValue(0, 1) * 10000) + 100
	HEALDUR_SCALE_SLIDER_VAR = (GBT_restScaleDurHeal.GetNthEntryValue(0, 1) * 10000) + 100
	DESCOST_SCALE_SLIDER_VAR = (GBT_desScaleCost.GetNthEntryValue(0, 1) * 10000) + 100
	HEALCOST_SCALE_SLIDER_VAR = (GBT_restScaleCostHeal.GetNthEntryValue(0, 1) * 10000) + 100
	ILLMAG_SCALE_SLIDER_VAR = (GBT_illScaleMag.GetNthEntryValue(0, 1) * 10000) + 100
	NONHEALMAG_SCALE_SLIDER_VAR = (GBT_nonHealScaleMag.GetNthEntryValue(0, 1) * 10000) + 100
	ILLDUR_SCALE_SLIDER_VAR = (GBT_illScaleDur.GetNthEntryValue(0, 1) * 10000) + 100
	NONHEALDUR_SCALE_SLIDER_VAR = (GBT_nonHealScaleDur.GetNthEntryValue(0, 1) * 10000) + 100
	ILLCOST_SCALE_SLIDER_VAR = (GBT_illScaleCost.GetNthEntryValue(0, 1) * 10000) + 100
	NONHEALCOST_SCALE_SLIDER_VAR = (GBT_nonHealScaleCost.GetNthEntryValue(0, 1) * 10000) + 100
	LESSERPOWER_COOLDOWN_SLIDER_VAR = GetGameSettingFloat("fMagicLesserPowerCooldownTimer")
	DAMAGEDEALT_NOVICE_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPByPCVE") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel())
	DAMAGETAKEN_NOVICE_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPToPCVE") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel())
	DAMAGEDEALT_APPRENTICE_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPByPCE") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel())
	DAMAGETAKEN_APPRENTICE_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPToPCE") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel())
	DAMAGEDEALT_ADEPT_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPByPCN") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel())
	DAMAGETAKEN_ADEPT_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPToPCN") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel())
	DAMAGEDEALT_EXPERT_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPByPCH") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel())
	DAMAGETAKEN_EXPERT_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPToPCH") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel())
	DAMAGEDEALT_MASTER_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPByPCVH") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel())
	DAMAGETAKEN_MASTER_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPToPCVH") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel())
	DAMAGEDEALT_LEGENDARY_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPByPCL") / Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel())
	DAMAGETAKEN_LEGENDARY_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPToPCL") / Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel())
	WEAPONSCALE_PCMIN_SLIDER_VAR = GetGameSettingFloat("fDamagePCSkillMin")
	WEAPONSCALE_PCMAX_SLIDER_VAR = GetGameSettingFloat("fDamagePCSkillMax")
	WEAPONSCALE_NPCMIN_SLIDER_VAR = GetGameSettingFloat("fDamageSkillMin")
	WEAPONSCALE_NPCMAX_SLIDER_VAR = GetGameSettingFloat("fDamageSkillMax")
	ARMOR_SCALE_SLIDER_VAR = GetGameSettingFloat("fArmorScalingFactor")
	MAX_RESISTANCE_SLIDER_VAR = GetGameSettingFloat("fPlayerMaxResistance")
	ARMOR_BASERESIST_SLIDER_VAR = GetGameSettingFloat("fArmorBaseFactor")
	ARMOR_MAXRESIST_SLIDER_VAR = GetGameSettingFloat("fMaxArmorRating")
	PC_ARMORRATING_SLIDER_VAR = GetGameSettingFloat("fArmorRatingPCMax")
	NPC_ARMORRATING_SLIDER_VAR = GetGameSettingFloat("fArmorRatingMax")
	ENCUM_EFFECT_SLIDER_VAR = GetGameSettingFloat("fMoveEncumEffect")
	ENCUMWEAP_EFFECT_SLIDER_VAR = GetGameSettingFloat("fMoveEncumEffectNoWeapon")
	WEAPONDAMAGE_MULT_SLIDER_VAR = GetGameSettingFloat("fDamageWeaponMult")
	TWOHAND_ATKSPD_SLIDER_VAR = GetGameSettingFloat("fWeaponTwoHandedAnimationSpeedMult")
	AUTOAIM_AREA_SLIDER_VAR = GetGameSettingFloat("fAutoAimScreenPercentage")
	AUTOAIM_RANGE_SLIDER_VAR = GetGameSettingFloat("fAutoAimMaxDistance")
	AUTOAIM_DEGREES_SLIDER_VAR = GetGameSettingFloat("fAutoAimMaxDegrees")
	AUTOAIM_DEGREESTHIRD_SLIDER_VAR = GetGameSettingFloat("fAutoAimMaxDegrees3rdPerson")
	STAMINA_POWERCOST_SLIDER_VAR = GetGameSettingFloat("fPowerAttackStaminaPenalty")
	STAMINA_BLOCKCOSTMULT_SLIDER_VAR = GetGameSettingFloat("fStaminaBlockDmgMult")
	STAMINA_BASHCOST_SLIDER_VAR = GetGameSettingFloat("fStaminaBashBase")
	STAMINA_POWERBASHCOST_SLIDER_VAR = GetGameSettingFloat("fStaminaPowerBashBase")
	STAMINA_BLOCKCOSTBASE_SLIDER_VAR = GetGameSettingFloat("fStaminaBlockBase")
	BLOCK_SHIELD_SLIDER_VAR = GetGameSettingFloat("fShieldBaseFactor")
	BLOCK_WEAPON_SLIDER_VAR = GetGameSettingFloat("fBlockWeaponBase")
	WEAPON_REACH_SLIDER_VAR = GetGameSettingFloat("fCombatDistance")
	BASH_REACH_SLIDER_VAR = GetGameSettingFloat("fCombatBashReach")
	AISEARCH_TIME_SLIDER_VAR = GetGameSettingFloat("fCombatStealthPointRegenAttackedWaitTime")
	AISEARCH_TIMEATTACKED_SLIDER_VAR = GetGameSettingFloat("fCombatStealthPointRegenDetectedEventWaitTime")
	SNEAKLEVEL_BASE_SLIDER_VAR = GetGameSettingFloat("fPlayerDetectionSneakBase")
	SNEAKDETECTION_SCALE_SLIDER_VAR = GetGameSettingFloat("fPlayerDetectionSneakMult")
	DETECTION_FOV_SLIDER_VAR = GetGameSettingFloat("fDetectionViewCone")
	SNEAK_BASE_SLIDER_VAR = GetGameSettingFloat("fSneakBaseValue")
	DETECTION_LIGHT_SLIDER_VAR = GetGameSettingFloat("fDetectionSneakLightMod")
	DETECTION_LIGHTEXT_SLIDER_VAR = GetGameSettingFloat("fSneakLightExteriorMult")
	DETECTION_SOUND_SLIDER_VAR = GetGameSettingFloat("fSneakSoundsMult")
	DETECTION_SOUNDLOS_SLIDER_VAR = GetGameSettingFloat("fSneakSoundLosMult")
	PICKPOCKET_MAXCHANCE_SLIDER_VAR = GetGameSettingFloat("fPickPocketMaxChance")
	PICKPOCKET_MINCHANCE_SLIDER_VAR = GetGameSettingFloat("fPickPocketMinChance")
	SNEAKMULT_MARKSMAN_SLIDER_VAR = (GBT_SneakMarks.GetNthEntryValue(0, 0) * 1) + 0
	SNEAKMULT_DAGGER_SLIDER_VAR = (GBT_SneakDagger.GetNthEntryValue(0, 0) * 1) + 0
	SNEAKMULT_TWOHAND_SLIDER_VAR = (GBT_SneakOne.GetNthEntryValue(0, 0) * 1) + 0
	SNEAKMULT_ONEHAND_SLIDER_VAR = (GBT_SneakTwo.GetNthEntryValue(0, 0) * 1) + 0
	SNEAKMULT_UNARMED_SLIDER_VAR = (GBT_SneakH2H.GetNthEntryValue(0, 0) * 1) + 0
	SNEAKMULT_RUNE_SLIDER_VAR = (GBT_SneakRuneMag.GetNthEntryValue(0, 0) * 1) + 0
	SNEAKMULT_SEARCH_SLIDER_VAR = (GBT_SneakSearch.GetNthEntryValue(0, 0) * 1) + 0
	SNEAKMULT_SPELLMAG_SLIDER_VAR = (GBT_SneakSpellMag.GetNthEntryValue(0, 0) * 1) + 0
	SNEAKMULT_SPELLSEARCH_SLIDER_VAR = (GBT_SneakSpellSearch.GetNthEntryValue(0, 0) * 1) + 0
	SNEAKMULT_SPELLDUR_SLIDER_VAR = (GBT_SneakSpellDur.GetNthEntryValue(0, 0) * 1) + 0
	SNEAKSCALE_PHYSICAL_SLIDER_VAR = (GBT_SneakScalePhys.GetNthEntryValue(0, 1) * 10000) + 100
	SNEAKSCALE_SPELLMAG_SLIDER_VAR = (GBT_SneakScaleSpell.GetNthEntryValue(0, 1) * 10000) + 100
	SNEAKMULT_POISONMAG_SLIDER_VAR = (GBT_SneakPoisonMag.GetNthEntryValue(0, 0) * 1) + 0
	SNEAKMULT_POISONDUR_SLIDER_VAR = (GBT_SneakPoisonDur.GetNthEntryValue(0, 0) * 1) + 0
	SNEAKSCALE_POISONMAG_SLIDER_VAR = (GBT_SneakScalePoisonMag.GetNthEntryValue(0, 1) * 10000) + 100
	SNEAKSCALE_POISONDUR_SLIDER_VAR = (GBT_SneakScalePoisonDur.GetNthEntryValue(0, 1) * 10000) + 100
	LOCKPICK_VEASY_SLIDER_VAR = GetGameSettingFloat("fSweetSpotVeryEasy")
	LOCKPICKDUR_VEASY_SLIDER_VAR = GetGameSettingFloat("fLockpickBreakNovice")
	LOCKPICK_EASY_SLIDER_VAR = GetGameSettingFloat("fSweetSpotEasy")
	LOCKPICKDUR_EASY_SLIDER_VAR = GetGameSettingFloat("fLockpickBreakApprentice")
	LOCKPICK_AVERAGE_SLIDER_VAR = GetGameSettingFloat("fSweetSpotAverage")
	LOCKPICKDUR_AVERAGE_SLIDER_VAR = GetGameSettingFloat("fLockpickBreakAdept")
	LOCKPICK_HARD_SLIDER_VAR = GetGameSettingFloat("fSweetSpotHard")
	LOCKPICKDUR_HARD_SLIDER_VAR = GetGameSettingFloat("fLockpickBreakExpert")
	LOCKPICK_VHARD_SLIDER_VAR = GetGameSettingFloat("fSweetSpotVeryHard")
	LOCKPICKDUR_VHARD_SLIDER_VAR = GetGameSettingFloat("fLockpickBreakMaster")
	ALCHEMYMAG_MULT_SLIDER_VAR = GetGameSettingFloat("fAlchemyIngredientInitMult")
	ALCHEMYMAG_SCALE_SLIDER_VAR = GetGameSettingFloat("fAlchemySkillFactor")
	BONUS_INGR_SLIDER_VAR = (GBT_bonusIngredients.GetNthEntryValue(0, 0) * 1) + 0
	BONUS_POTION_SLIDER_VAR = (GBT_bonusPotions.GetNthEntryValue(0, 0) * 1) + 0
	CHARGECOST_POWER_SLIDER_VAR = GetGameSettingFloat("fEnchantingCostExponent")
	ENCHANT_SCALING_SLIDER_VAR = GetGameSettingFloat("fEnchantingSkillFactor")
	CHARGECOST_MULT_SLIDER_VAR = GetGameSettingFloat("fEnchantingSkillCostMult")
	ENCHANTPRICE_EFFECT_SLIDER_VAR = GetGameSettingFloat("fEnchantmentEffectPointsMult")
	CHARGECOST_BASE_SLIDER_VAR = GetGameSettingFloat("fEnchantingSkillCostBase")
	ENCHANTPRICE_SOUL_SLIDER_VAR = GetGameSettingFloat("fEnchantmentPointsMult")
	ENCHANT_CHARGE_SLIDER_VAR = (GBT_enchantCharge.GetNthEntryValue(0, 0) * 100) + 0
	ENCHANT_MAG_SLIDER_VAR = (GBT_enchantMag.GetNthEntryValue(0, 0) * 100) + 0
	BONUS_ENCHANT_SLIDER_VAR = (GBT_bonusEnchants.GetNthEntryValue(0, 0) * 1) + 0
	TEMPER_SUFFIX_SLIDER_VAR = GetGameSettingFloat("fSmithingConditionFactor")
	TEMPER_ARMOR_SLIDER_VAR = GetGameSettingFloat("fSmithingArmorMax")
	TEMPER_WEAPON_SLIDER_VAR = GetGameSettingFloat("fSmithingWeaponMax")
	POTION_MAG_SLIDER_VAR = (GBT_PotionMag.GetNthEntryValue(0, 0) * 1) + 0
	POTION_DUR_SLIDER_VAR = (GBT_PotionDur.GetNthEntryValue(0, 0) * 1) + 0
	POTION_SCALEMAG_SLIDER_VAR = (GBT_PotionScaleMag.GetNthEntryValue(0, 1) * 10000) + 100
	POTION_SCALEDUR_SLIDER_VAR = (GBT_PotionScaleDur.GetNthEntryValue(0, 1) * 10000) + 100
	POISON_MAG_SLIDER_VAR = (GBT_PoisonMag.GetNthEntryValue(0, 0) * 1) + 0
	POISON_DUR_SLIDER_VAR = (GBT_PoisonDur.GetNthEntryValue(0, 0) * 1) + 0
	POISON_SCALEMAG_SLIDER_VAR = (GBT_PoisonScaleMag.GetNthEntryValue(0, 1) * 10000) + 100
	POISON_SCALEDUR_SLIDER_VAR = (GBT_PoisonScaleDur.GetNthEntryValue(0, 1) * 10000) + 100
	SCROLL_MAG_SLIDER_VAR = (GBT_ScrollMag.GetNthEntryValue(0, 0) * 1) + 0
	SCROLL_DUR_SLIDER_VAR = (GBT_ScrollDur.GetNthEntryValue(0, 0) * 1) + 0
	BARTER_BUYMIN_SLIDER_VAR = GetGameSettingFloat("fBarterBuyMin")
	BARTER_SELLMAX_SLIDER_VAR = GetGameSettingFloat("fBarterSellMax")
	BARTER_MIN_SLIDER_VAR = GetGameSettingFloat("fBarterMin")
	BARTER_MAX_SLIDER_VAR = GetGameSettingFloat("fBarterMax")
	BUY_PRICE_SLIDER_VAR = (GBT_buyPrice.GetNthEntryValue(0, 0) * 100) + 0
	SELL_PRICE_SLIDER_VAR = (GBT_sellPrice.GetNthEntryValue(0, 0) * 100) + 0
	VENDOR_RESPAWN_SLIDER_VAR = GetGameSettingInt("iDaysToRespawnVendor")
	TRAINING_NUMALLOWED_SLIDER_VAR = GetGameSettingInt("iTrainingNumAllowedPerLevel")
	TRAINING_JOURNEYMANCOST_SLIDER_VAR = GetGameSettingInt("iTrainingJourneymanCost")
	TRAINING_JOURNEYMANSKILL_SLIDER_VAR = GetGameSettingInt("iTrainingJourneymanSkill")
	TRAINING_EXPERTCOST_SLIDER_VAR = GetGameSettingInt("iTrainingExpertCost")
	TRAINING_EXPERTSKILL_SLIDER_VAR = GetGameSettingInt("iTrainingExpertSkill")
	TRAINING_MASTERCOST_SLIDER_VAR = GetGameSettingInt("iTrainingMasterCost")
	TRAINING_MASTERSKILL_SLIDER_VAR = GetGameSettingInt("iTrainingMasterSkill")
	APOTHECARY_GOLD_SLIDER_VAR = VendorGoldApothecary.GetNthCount(0)
	BLACKSMITH_GOLD_SLIDER_VAR = VendorGoldBlacksmith.GetNthCount(0)
	ORCBLACKSMITH_GOLD_SLIDER_VAR = VendorGoldBlacksmithOrc.GetNthCount(0)
	TOWNBLACKSMITH_GOLD_SLIDER_VAR = VendorGoldBlacksmithTown.GetNthCount(0)
	INNKEERPER_GOLD_SLIDER_VAR = VendorGoldInn.GetNthCount(0)
	MISCMERCHANT_GOLD_SLIDER_VAR = VendorGoldMisc.GetNthCount(0)
	SPELLMERCHANT_GOLD_SLIDER_VAR = VendorGoldSpells.GetNthCount(0)
	STREETVENDOR_GOLD_SLIDER_VAR = VendorGoldStreetVendor.GetNthCount(0)
	COMBAT_STAMINAREGEN_SLIDER_VAR = GetGameSettingFloat("fCombatStaminaRegenRateMult")
	DAMAGESTAMINA_DELAY_SLIDER_VAR = GetGameSettingFloat("fDamagedStaminaRegenDelay")
	BOWZOOM_REGENDELAY_SLIDER_VAR = GetGameSettingFloat("fBowZoomStaminaRegenDelay")
	COMBAT_MAGICKAREGEN_SLIDER_VAR = GetGameSettingFloat("fCombatMagickaRegenRateMult")
	STAMINA_REGENDELAY_SLIDER_VAR = GetGameSettingFloat("fStaminaRegenDelayMax")
	DAMAGEMAGICKA_DELAY_SLIDER_VAR = GetGameSettingFloat("fDamagedMagickaRegenDelay")
	MAGICKA_REGENDELAY_SLIDER_VAR = GetGameSettingFloat("fMagickaRegenDelayMax")
	AV_HEALRATE_SLIDER_VAR =  PlayerRef.GetBaseAV("HealRate")
	AV_MAGICKARATE_SLIDER_VAR =  PlayerRef.GetBaseAV("MagickaRate")
	AV_STAMINARATE_SLIDER_VAR =  PlayerRef.GetBaseAV("StaminaRate")
	AV_CARRYWEIGHT_SLIDER_VAR =  PlayerRef.GetBaseAV("CarryWeight")
	AV_SPEEDMULT_SLIDER_VAR =  PlayerRef.GetBaseAV("SpeedMult")
	AV_UNARMEDDAMAGE_SLIDER_VAR =  PlayerRef.GetBaseAV("UnarmedDamage")
	AV_MASS_SLIDER_VAR =  PlayerRef.GetBaseAV("Mass")
	AV_CRITCHANCE_SLIDER_VAR =  PlayerRef.GetBaseAV("CritChance")
	AV_BOWSPEEDBONUSVAR_SLIDER_VAR =  PlayerRef.GetBaseAV("BowSpeedBonus")
	TIME_SCALE_SLIDER_VAR = TimeScale.GetValueInt()
	FALLHEIGHT_MINNPC_SLIDER_VAR = GetGameSettingFloat("fJumpFallHeightMinNPC")
	FALLHEIGHT_MIN_SLIDER_VAR = GetGameSettingFloat("fJumpFallHeightMin")
	FALLHEIGHT_MULTNPC_SLIDER_VAR = GetGameSettingFloat("fJumpFallHeightMultNPC")
	FALLHEIGHT_MULT_SLIDER_VAR = GetGameSettingFloat("fJumpFallHeightMult")
	FALLHEIGHT_EXPNPC_SLIDER_VAR = GetGameSettingFloat("fJumpFallHeightExponentNPC")
	FALLHEIGHT_EXP_SLIDER_VAR = GetGameSettingFloat("fJumpFallHeightExponent")
	JUMP_HEIGHT_SLIDER_VAR = GetGameSettingFloat("fJumpHeightMin")
	SWIM_BREATHBASE_SLIDER_VAR = GetGameSettingFloat("fActorSwimBreathBase")
	SWIM_BREATHDAMAGE_SLIDER_VAR = GetGameSettingFloat("fActorSwimBreathDamage")
	SWIM_BREATHMULT_SLIDER_VAR = GetGameSettingFloat("fActorSwimBreathMult")
	KILLCAM_CHANCE_SLIDER_VAR = GetGameSettingFloat("fKillCamBaseOdds")
	DEATHCAMERA_TIME_SLIDER_VAR = GetGameSettingFloat("fPlayerDeathReloadTime")
	KILLMOVE_CHANCE_SLIDER_VAR = KillMoveRandom.GetValue()
	DECAPITATION_CHANCE_SLIDER_VAR = DecapitationChance.GetValue()
	SPRINT_DRAINBASE_SLIDER_VAR = GetGameSettingFloat("fSprintStaminaDrainMult")
	SPRINT_DRAINMULT_SLIDER_VAR = GetGameSettingFloat("fSprintStaminaWeightMult")
	ARROW_RECOVERY_SLIDER_VAR = GetGameSettingInt("iArrowInventoryChance")
	DEATH_DROPCHANCE_SLIDER_VAR = GetGameSettingInt("iDeathDropWeaponChance")
	CAMERA_SHAKETIME_SLIDER_VAR = GetGameSettingFloat("fCameraShakeTime")
	FASTRAVEL_SPEED_SLIDER_VAR = GetGameSettingFloat("fFastTravelSpeedMult")
	HUDCOMPASS_DISTANEC_SLIDER_VAR = GetGameSettingFloat("fHUDCompassLocationMaxDist")
	ATTACHED_ARROWS_SLIDER_VAR = GetGameSettingInt("iMaxAttachedArrows")
	LightRadius_VAR = GetLightRadius(Torch01)
	LightDuration_VAR = GetLightDuration(Torch01)
	SPECIAL_LOOT_SLIDER_VAR = SpecialLootChance.GetValueInt()
	FRIENDHIT_TIMER_SLIDER_VAR = GetGameSettingFloat("fFriendHitTimer")
	FRIENDHIT_INTERVAL_SLIDER_VAR = GetGameSettingFloat("fFriendMinimumLastHitTime")
	FRIENDHIT_COMBAT_SLIDER_VAR = GetGameSettingInt("iFriendHitCombatAllowed")
	FRIENDHIT_NONCOMBAT_SLIDER_VAR = GetGameSettingInt("iFriendHitNonCombatAllowed")
	ALLYHIT_COMBAT_SLIDER_VAR = GetGameSettingInt("iAllyHitCombatAllowed")
	ALLYHIT_NONCOMBAT_SLIDER_VAR = GetGameSettingInt("iAllyHitNonCombatAllowed")
	COMBAT_DODGECHANCE_SLIDER_VAR = GetGameSettingFloat("fCombatDodgeChanceMax")
	COMBAT_AIMOFFSET_SLIDER_VAR = GetGameSettingFloat("fCombatAimProjectileRandomOffset")
	COMBAT_FLEEHEALTH_SLIDER_VAR = GetGameSettingFloat("fAIFleeHealthMult")
	DIALOGUE_PADDING_SLIDER_VAR = GetGameSettingFloat("fGameplayVoiceFilePadding")
	DIALOGUE_DISTANCE_SLIDER_VAR = GetGameSettingFloat("fAIMinGreetingDistance")
	FOLLOWER_SPACING_SLIDER_VAR = GetGameSettingFloat("fFollowSpaceBetweenFollowers")
	FOLLOWER_CATCHUP_SLIDER_VAR = GetGameSettingFloat("fFollowExtraCatchUpSpeedMult")
	LEVELSCALING_MULT_SLIDER_VAR = GetGameSettingFloat("fLevelScalingMult")
	LEVELEDACTOR_EASY_SLIDER_VAR = GetGameSettingFloat("fLeveledActorMultEasy")
	LEVELEDACTOR_HARD_SLIDER_VAR = GetGameSettingFloat("fLeveledActorMultHard")
	LEVELEDACTOR_MEDIUM_SLIDER_VAR = GetGameSettingFloat("fLeveledActorMultMedium")
	LEVELEDACTOR_VHARD_SLIDER_VAR = GetGameSettingFloat("fLeveledActorMultVeryHard")
	RESPAWN_TIME_SLIDER_VAR = GetGameSettingInt("iHoursToRespawnCell")
	NPC_HEALTHBONUS_SLIDER_VAR = GetGameSettingFloat("fNPCHealthLevelBonus")
	LEVELUP_ATTRIBUTE_SLIDER_VAR = GetGameSettingInt("iAVDhmsLevelup")
	LEVELUP_CARRYWEIGHT_SLIDER_VAR = GetGameSettingFloat("fLevelUpCarryWeightMod")
	LEGENDARYRESET_LEVEL_SLIDER_VAR = GetGameSettingFloat("fLegendarySkillResetValue")
	LEVELUP_POWER_SLIDER_VAR = GetGameSettingFloat("fSkillUseCurve")
	LEVELUP_BASE_SLIDER_VAR = GetGameSettingFloat("fXPLevelUpBase")
	LEVELUP_MULT_SLIDER_VAR = GetGameSettingFloat("fXPLevelUpMult")
	SKILLUSE_ALCHEMY_SLIDER_VAR = GetAVIByID(16).GetSkillUseMult()
	SKILLUSE_ALTERATION_SLIDER_VAR = GetAVIByID(18).GetSkillUseMult()
	SKILLUSE_BLOCK_SLIDER_VAR = GetAVIByID(9).GetSkillUseMult()
	SKILLUSE_CONJURATION_SLIDER_VAR = GetAVIByID(19).GetSkillUseMult()
	SKILLUSE_DESTRUCTION_SLIDER_VAR = GetAVIByID(20).GetSkillUseMult()
	SKILLUSE_ENCHANTING_SLIDER_VAR = GetAVIByID(23).GetSkillUseMult()
	SKILLUSE_HEAVYARMOR_SLIDER_VAR = GetAVIByID(11).GetSkillUseMult()
	SKILLUSE_ILLUSION_SLIDER_VAR = GetAVIByID(21).GetSkillUseMult()
	SKILLUSE_LIGHTARMOR_SLIDER_VAR = GetAVIByID(12).GetSkillUseMult()
	SKILLUSE_LOCKPICKING_SLIDER_VAR = GetAVIByID(14).GetSkillUseMult()
	SKILLUSE_MARKSMAN_SLIDER_VAR = GetAVIByID(8).GetSkillUseMult()
	SKILLUSE_ONEHANDED_SLIDER_VAR = GetAVIByID(6).GetSkillUseMult()
	SKILLUSE_PICKPOCKET_SLIDER_VAR = GetAVIByID(13).GetSkillUseMult()
	SKILLUSE_RESTORATION_SLIDER_VAR = GetAVIByID(22).GetSkillUseMult()
	SKILLUSE_SMITHING_SLIDER_VAR = GetAVIByID(10).GetSkillUseMult()
	SKILLUSE_SNEAK_SLIDER_VAR = GetAVIByID(15).GetSkillUseMult()
	SKILLUSE_SPEECHCRAFT_SLIDER_VAR = GetAVIByID(17).GetSkillUseMult()
	SKILLUSE_TWOHAND_SLIDER_VAR = GetAVIByID(7).GetSkillUseMult()
	RFORCE_MIN_SLIDER_VAR = GetGameSettingFloat("fDeathForceRangedForceMin")
	RFORCE_MAX_SLIDER_VAR = GetGameSettingFloat("fDeathForceRangedForceMax")
	MFORCE_MIN_SLIDER_VAR = GetGameSettingFloat("fDeathForceForceMin")
	MFORCE_MAX_SLIDER_VAR = GetGameSettingFloat("fDeathForceForceMax")
	SFORCE_SLIDER_VAR = GetGameSettingFloat("fDeathForceSpellImpactMult")
	GFORCE_SLIDER_VAR = GetGameSettingFloat("fZKeyMaxForce")
	FIRST_FOV_SLIDER_VAR = GetINIFloat("fDefaultWorldFOV:Display")
	THIRD_FOV_SLIDER_VAR = GetINIFloat("fDefault1stPersonFOV:Display")
	XSENSITIVITY_SLIDER_VAR = GetINIFloat("fMouseHeadingXScale:Controls")
	YSENSITIVITY_SLIDER_VAR = GetINIFloat("fMouseHeadingYScale:Controls")
	COMBAT_SHOULDERY_SLIDER_VAR = GetINIFloat("fOverShoulderCombatAddY:Camera")
	COMBAT_SHOULDERZ_SLIDER_VAR = GetINIFloat("fOverShoulderCombatPosZ:Camera")
	COMBAT_SHOULDERX_SLIDER_VAR = GetINIFloat("fOverShoulderCombatPosX:Camera")
	SHOULDERZ_SLIDER_VAR = GetINIFloat("fOverShoulderPosZ:Camera")
	SHOULDERX_SLIDER_VAR = GetINIFloat("fOverShoulderPosX:Camera")
	AUTOSAVE_COUNT_SLIDER_VAR = GetINIInt("iAutoSaveCount:SaveGame")
	SHOWCOMPASS_TOGGLE_VAR = GetINIBool("bShowCompass:Interface")
	DEPTHFIELD_TOGGLE_VAR = GetINIBool("bDoDepthOfField:Imagespace")
	HAVOK_HIT_TOGGLE_VAR = GetINIBool("bEnableHavokHit:Animation")
	HAVOK_HIT_SLIDER_VAR = GetINIFloat("fHavokHitImpulseMult:Animation")
	SHOW_TUTORIAL_TOGGLE_VAR = GetINIBool("bShowTutorials:Interface")
	BOOK_SPEED_SLIDER_VAR = GetINIFloat("fBookOpenTime:Interface")
	FIRST_ARROWTILT_SLIDER_VAR = GetINIFloat("f1PArrowTiltUpAngle:Combat")
	THIRD_ARROWTILT_SLIDER_VAR = GetINIFloat("f3PArrowTiltUpAngle:Combat")
	FIRST_BOLTTILT_SLIDER_VAR = GetINIFloat("f1PBoltTiltUpAngle:Combat")
	NPC_USEAMMO_TOGGLE_VAR = GetINIBool("bForceNPCsUseAmmo:Combat")
	NAVMESH_DISTANCE_SLIDER_VAR = GetINIFloat("fVisibleNavmeshMoveDist:Actor")
	FRICTION_LAND_SLIDER_VAR = GetINIFloat("fLandFriction:Landscape")
	TREE_ANIMATION_TOGGLE_VAR = GetINIBool("bEnableTreeAnimations:Trees")
	GORE_TOGGLE_VAR = GetINIBool("bDisableAllGore:General")
	CONSOLE_TEXT_SLIDER_VAR = GetINIInt("iConsoleTextSize:Menu")
	CONSOLE_PERCENT_SLIDER_VAR = GetINIInt("iConsoleSizeScreenPercent:Menu")
	MAP_YAW_SLIDER_VAR = GetINIFloat("fMapWorldYawRange:MapMenu")
	MAP_PITCH_SLIDER_VAR = GetINIFloat("fMapWorldMaxPitch:MapMenu")
	VATS_TOGGLE_VAR = GetINIBool("bVatsDisable:VATS")
	ALWAYS_ACTIVE_TOGGLE_VAR = GetINIBool("bAlwaysActive:General")
	ESSENTIAL_NPC_TOGGLE_VAR = GetINIBool("bEssentialTakeNoDamage:Gameplay")
	LEGENDARY_BONUS_TOGGLE_VAR = PlayerRef.HasSpell(GBT_legendaryBonus)
	ARROW_FAMINE_TOGGLE_VAR = PlayerRef.HasSpell(GBT_arrowFamine)
	SNEAK_FATIGUE_TOGGLE_VAR = PlayerRef.HasSpell(GBT_sneakFatigue)
	TIMED_BLOCK_TOGGLE_VAR = PlayerRef.HasSpell(GBT_enableTimedBlock)
	ITEM_LIMITER_TOGGLE_VAR = PlayerRef.HasSpell(GBT_enableItemAdded)
	PLAYER_STAGGER_TOGGLE_VAR = PlayerRef.HasSpell(GBT_enableOnHit)
	NPC_STAGGER_TOGGLE_VAR = PlayerRef.HasSpell(GBT_enableMeleeStagger)
	BLEEDOUT_TOGGLE_VAR = PlayerRef.HasSpell(GBT_enableBleedout)
	ARMOR_CMBEXP_TOGGLE_VAR = PlayerRef.HasSpell(GBT_EnableCombatState)
	IF showMessages
		float ftimeEnd = GetCurrentRealTime()
		Debug.Notification("SkyTweak: Took " + (ftimeEnd - ftimeStart) + " seconds to save to local memory")
	ENDIF
		ENDFUNCTION

;======================================================================
;===========================LOCAL LOAD ALL============================
;======================================================================
FUNCTION localLoadAll()
	float ftimeStart = GetCurrentRealTime()

	loadPerk(GBT_Temper_Scale, TEMPER_SCALE_TOGGLE_VAR)
	loadPerkFloat1(GBT_shoutScale, (SHOUT_SCALE_SLIDER_VAR - 0) / 100, (0.0 - 0) / 100, 1)
	loadPerk(GBT_Critical_Damage_Scaling, CRIT_SCALE_TOGGLE_VAR)
	loadPerk(GBT_Bleed_Damage_Scaling, BLEED_SCALE_TOGGLE_VAR)
	loadPerk(GBT_Stamina_Cost_Scaling, STAMINACOST_SCALE_TOGGLE_VAR)
	loadPerk(GBT_illScaleTargetLevel, ILLTARGLVL_SCALE_TOGGLE_VAR)
	loadPerk(GBT_friendlyDamage, FRIENDLY_DAMAGE_TOGGLE_VAR)
	loadPerkFloat2(GBT_trapMagnitude, (TRAP_MAGNITUDE_SLIDER_VAR - 0) / 100, (100.0 - 0) / 100, 0)
	loadPerk(GBT_friendlyStagger, FRIENDLY_STAGGER_TOGGLE_VAR)
	loadPerkFloat1(GBT_WerewolfDamageDealt, (WEREDMG_DEALT_SLIDER_VAR - 0) / 100, (100.0 - 0) / 100, 0)
	loadPerkFloat1(GBT_WerewolfDamageTaken, (WEREDMG_TAKEN_SLIDER_VAR - 0) / 100, (100.0 - 0) / 100, 0)
	loadPerkFloat1(GBT_poisonDose, (POISON_DOSE_SLIDER_VAR - 0) / 1, (0.0 - 0) / 1, 0)
	SetGamesettingFloat("fMagicDualCastingEffectivenessBase", DUALCAST_POWER_SLIDER_VAR )
	SetGamesettingFloat("fMagicDualCastingCostMult", DUALCAST_COST_SLIDER_VAR )
	SetGamesettingFloat("fMagicCasterPCSkillCostBase", MAGICCOST_SCALE_SLIDER_VAR )
	SetGamesettingFloat("fMagicCasterPCSkillCostMult", MAGIC_COST_SLIDER_VAR )
	SetGamesettingFloat("fMagicCasterSkillCostBase", NPCMAGICCOST_SCALE_SLIDER_VAR )
	SetGamesettingFloat("fMagicCasterSkillCostMult", NPCMAGIC_COST_SLIDER_VAR )
	SetGamesettingInt("iMaxPlayerRunes", MAX_RUNES_SLIDER_VAR )
	SetGamesettingInt("iMaxSummonedCreatures", MAX_SUMMONED_SLIDER_VAR )
	SetGamesettingFloat("fMagicTelekinesisDamageBase", TELEKIN_DAMAGE_SLIDER_VAR )
	SetGamesettingFloat("fMagicTelekinesisDualCastDamageMult", TELEKIN_DUALMULT_SLIDER_VAR )
	loadPerkFloat1(GBT_altScaleMag, (ALTMAG_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_conjScaleMag, (CONJMAG_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_altScaleDurNotPara, (ALTDURNOTPARA_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_conjScaleDur, (CONJDUR_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_altScaleCost, (ALTCOST_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_conjScaleCost, (CONJCOST_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_altScaleDurPara, (ALTDURPARA_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_conjScaleBoundMelee, (BOUNTMELEE_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_altScaleCostDet, (ALTCOSTDET_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_conjScaleBoundBow, (BOUNDBOW_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_desScaleMag, (DESMAG_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_restScaleMagHeal, (HEALMAG_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_desScaleDur, (DESDUR_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_restScaleDurHeal, (HEALDUR_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_desScaleCost, (DESCOST_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_restScaleCostHeal, (HEALCOST_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_illScaleMag, (ILLMAG_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_nonHealScaleMag, (NONHEALMAG_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_illScaleDur, (ILLDUR_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_nonHealScaleDur, (NONHEALDUR_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_illScaleCost, (ILLCOST_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_nonHealScaleCost, (NONHEALCOST_SCALE_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	SetGamesettingFloat("fMagicLesserPowerCooldownTimer", LESSERPOWER_COOLDOWN_SLIDER_VAR )
	SetGamesettingFloat("fDiffMultHPByPCVE", DAMAGEDEALT_NOVICE_SLIDER_VAR  * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPToPCVE", DAMAGETAKEN_NOVICE_SLIDER_VAR  * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPByPCE", DAMAGEDEALT_APPRENTICE_SLIDER_VAR  * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPToPCE", DAMAGETAKEN_APPRENTICE_SLIDER_VAR  * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPByPCN", DAMAGEDEALT_ADEPT_SLIDER_VAR  * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPToPCN", DAMAGETAKEN_ADEPT_SLIDER_VAR  * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPByPCH", DAMAGEDEALT_EXPERT_SLIDER_VAR  * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPToPCH", DAMAGETAKEN_EXPERT_SLIDER_VAR  * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPByPCVH", DAMAGEDEALT_MASTER_SLIDER_VAR  * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPToPCVH", DAMAGETAKEN_MASTER_SLIDER_VAR  * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPByPCL", DAMAGEDEALT_LEGENDARY_SLIDER_VAR  * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPToPCL", DAMAGETAKEN_LEGENDARY_SLIDER_VAR  * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDamagePCSkillMin", WEAPONSCALE_PCMIN_SLIDER_VAR )
	SetGamesettingFloat("fDamagePCSkillMax", WEAPONSCALE_PCMAX_SLIDER_VAR )
	SetGamesettingFloat("fDamageSkillMin", WEAPONSCALE_NPCMIN_SLIDER_VAR )
	SetGamesettingFloat("fDamageSkillMax", WEAPONSCALE_NPCMAX_SLIDER_VAR )
	SetGamesettingFloat("fArmorScalingFactor", ARMOR_SCALE_SLIDER_VAR )
	SetGamesettingFloat("fPlayerMaxResistance", MAX_RESISTANCE_SLIDER_VAR )
	SetGamesettingFloat("fArmorBaseFactor", ARMOR_BASERESIST_SLIDER_VAR )
	SetGamesettingFloat("fMaxArmorRating", ARMOR_MAXRESIST_SLIDER_VAR )
	SetGamesettingFloat("fArmorRatingPCMax", PC_ARMORRATING_SLIDER_VAR )
	SetGamesettingFloat("fArmorRatingMax", NPC_ARMORRATING_SLIDER_VAR )
	SetGamesettingFloat("fMoveEncumEffect", ENCUM_EFFECT_SLIDER_VAR )
	SetGamesettingFloat("fMoveEncumEffectNoWeapon", ENCUMWEAP_EFFECT_SLIDER_VAR )
	SetGamesettingFloat("fDamageWeaponMult", WEAPONDAMAGE_MULT_SLIDER_VAR )
	SetGamesettingFloat("fWeaponTwoHandedAnimationSpeedMult", TWOHAND_ATKSPD_SLIDER_VAR )
	SetGamesettingFloat("fAutoAimScreenPercentage", AUTOAIM_AREA_SLIDER_VAR )
	SetGamesettingFloat("fAutoAimMaxDistance", AUTOAIM_RANGE_SLIDER_VAR )
	SetGamesettingFloat("fAutoAimMaxDegrees", AUTOAIM_DEGREES_SLIDER_VAR )
	SetGamesettingFloat("fAutoAimMaxDegrees3rdPerson", AUTOAIM_DEGREESTHIRD_SLIDER_VAR )
	SetGamesettingFloat("fPowerAttackStaminaPenalty", STAMINA_POWERCOST_SLIDER_VAR )
	SetGamesettingFloat("fStaminaBlockDmgMult", STAMINA_BLOCKCOSTMULT_SLIDER_VAR )
	SetGamesettingFloat("fStaminaBashBase", STAMINA_BASHCOST_SLIDER_VAR )
	SetGamesettingFloat("fStaminaPowerBashBase", STAMINA_POWERBASHCOST_SLIDER_VAR )
	SetGamesettingFloat("fStaminaBlockBase", STAMINA_BLOCKCOSTBASE_SLIDER_VAR )
	SetGamesettingFloat("fShieldBaseFactor", BLOCK_SHIELD_SLIDER_VAR )
	SetGamesettingFloat("fBlockWeaponBase", BLOCK_WEAPON_SLIDER_VAR )
	SetGamesettingFloat("fCombatDistance", WEAPON_REACH_SLIDER_VAR )
	SetGamesettingFloat("fCombatBashReach", BASH_REACH_SLIDER_VAR )
	SetGamesettingFloat("fCombatStealthPointRegenAttackedWaitTime", AISEARCH_TIME_SLIDER_VAR )
	SetGamesettingFloat("fCombatStealthPointRegenDetectedEventWaitTime", AISEARCH_TIMEATTACKED_SLIDER_VAR )
	SetGamesettingFloat("fPlayerDetectionSneakBase", SNEAKLEVEL_BASE_SLIDER_VAR )
	SetGamesettingFloat("fPlayerDetectionSneakMult", SNEAKDETECTION_SCALE_SLIDER_VAR )
	SetGamesettingFloat("fDetectionViewCone", DETECTION_FOV_SLIDER_VAR )
	SetGamesettingFloat("fSneakBaseValue", SNEAK_BASE_SLIDER_VAR )
	SetGamesettingFloat("fDetectionSneakLightMod", DETECTION_LIGHT_SLIDER_VAR )
	SetGamesettingFloat("fSneakLightExteriorMult", DETECTION_LIGHTEXT_SLIDER_VAR )
	SetGamesettingFloat("fSneakSoundsMult", DETECTION_SOUND_SLIDER_VAR )
	SetGamesettingFloat("fSneakSoundLosMult", DETECTION_SOUNDLOS_SLIDER_VAR )
	SetGamesettingFloat("fPickPocketMaxChance", PICKPOCKET_MAXCHANCE_SLIDER_VAR )
	SetGamesettingFloat("fPickPocketMinChance", PICKPOCKET_MINCHANCE_SLIDER_VAR )
	loadPerkFloat1(GBT_SneakMarks, (SNEAKMULT_MARKSMAN_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakDagger, (SNEAKMULT_DAGGER_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakOne, (SNEAKMULT_TWOHAND_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakTwo, (SNEAKMULT_ONEHAND_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakH2H, (SNEAKMULT_UNARMED_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakRuneMag, (SNEAKMULT_RUNE_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakSearch, (SNEAKMULT_SEARCH_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakSpellMag, (SNEAKMULT_SPELLMAG_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakSpellSearch, (SNEAKMULT_SPELLSEARCH_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakSpellDur, (SNEAKMULT_SPELLDUR_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakScalePhys, (SNEAKSCALE_PHYSICAL_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_SneakScaleSpell, (SNEAKSCALE_SPELLMAG_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_SneakPoisonMag, (SNEAKMULT_POISONMAG_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakPoisonDur, (SNEAKMULT_POISONDUR_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_SneakScalePoisonMag, (SNEAKSCALE_POISONMAG_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_SneakScalePoisonDur, (SNEAKSCALE_POISONDUR_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	SetGamesettingFloat("fSweetSpotVeryEasy", LOCKPICK_VEASY_SLIDER_VAR )
	SetGamesettingFloat("fLockpickBreakNovice", LOCKPICKDUR_VEASY_SLIDER_VAR )
	SetGamesettingFloat("fSweetSpotEasy", LOCKPICK_EASY_SLIDER_VAR )
	SetGamesettingFloat("fLockpickBreakApprentice", LOCKPICKDUR_EASY_SLIDER_VAR )
	SetGamesettingFloat("fSweetSpotAverage", LOCKPICK_AVERAGE_SLIDER_VAR )
	SetGamesettingFloat("fLockpickBreakAdept", LOCKPICKDUR_AVERAGE_SLIDER_VAR )
	SetGamesettingFloat("fSweetSpotHard", LOCKPICK_HARD_SLIDER_VAR )
	SetGamesettingFloat("fLockpickBreakExpert", LOCKPICKDUR_HARD_SLIDER_VAR )
	SetGamesettingFloat("fSweetSpotVeryHard", LOCKPICK_VHARD_SLIDER_VAR )
	SetGamesettingFloat("fLockpickBreakMaster", LOCKPICKDUR_VHARD_SLIDER_VAR )
	SetGamesettingFloat("fAlchemyIngredientInitMult", ALCHEMYMAG_MULT_SLIDER_VAR )
	SetGamesettingFloat("fAlchemySkillFactor", ALCHEMYMAG_SCALE_SLIDER_VAR )
	loadPerkFloat1(GBT_bonusIngredients, (BONUS_INGR_SLIDER_VAR - 0) / 1, (0.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_bonusPotions, (BONUS_POTION_SLIDER_VAR - 0) / 1, (0.0 - 0) / 1, 0)
	SetGamesettingFloat("fEnchantingCostExponent", CHARGECOST_POWER_SLIDER_VAR )
	SetGamesettingFloat("fEnchantingSkillFactor", ENCHANT_SCALING_SLIDER_VAR )
	SetGamesettingFloat("fEnchantingSkillCostMult", CHARGECOST_MULT_SLIDER_VAR )
	SetGamesettingFloat("fEnchantmentEffectPointsMult", ENCHANTPRICE_EFFECT_SLIDER_VAR )
	SetGamesettingFloat("fEnchantingSkillCostBase", CHARGECOST_BASE_SLIDER_VAR )
	SetGamesettingFloat("fEnchantmentPointsMult", ENCHANTPRICE_SOUL_SLIDER_VAR )
	loadPerkFloat1(GBT_enchantCharge, (ENCHANT_CHARGE_SLIDER_VAR - 0) / 100, (100.0 - 0) / 100, 0)
	loadPerkFloat1(GBT_enchantMag, (ENCHANT_MAG_SLIDER_VAR - 0) / 100, (100.0 - 0) / 100, 0)
	loadPerkFloat1(GBT_bonusEnchants, (BONUS_ENCHANT_SLIDER_VAR - 0) / 1, (0.0 - 0) / 1, 0)
	SetGamesettingFloat("fSmithingConditionFactor", TEMPER_SUFFIX_SLIDER_VAR )
	SetGamesettingFloat("fSmithingArmorMax", TEMPER_ARMOR_SLIDER_VAR )
	SetGamesettingFloat("fSmithingWeaponMax", TEMPER_WEAPON_SLIDER_VAR )
	loadPerkFloat1(GBT_PotionMag, (POTION_MAG_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_PotionDur, (POTION_DUR_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_PotionScaleMag, (POTION_SCALEMAG_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_PotionScaleDur, (POTION_SCALEDUR_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_PoisonMag, (POISON_MAG_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_PoisonDur, (POISON_DUR_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_PoisonScaleMag, (POISON_SCALEMAG_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_PoisonScaleDur, (POISON_SCALEDUR_SLIDER_VAR - 100) / 10000, (100.0 - 100) / 10000, 1)
	loadPerkFloat1(GBT_ScrollMag, (SCROLL_MAG_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	loadPerkFloat1(GBT_ScrollDur, (SCROLL_DUR_SLIDER_VAR - 0) / 1, (1.0 - 0) / 1, 0)
	SetGamesettingFloat("fBarterBuyMin", BARTER_BUYMIN_SLIDER_VAR )
	SetGamesettingFloat("fBarterSellMax", BARTER_SELLMAX_SLIDER_VAR )
	SetGamesettingFloat("fBarterMin", BARTER_MIN_SLIDER_VAR )
	SetGamesettingFloat("fBarterMax", BARTER_MAX_SLIDER_VAR )
	loadPerkFloat1(GBT_buyPrice, (BUY_PRICE_SLIDER_VAR - 0) / 100, (100.0 - 0) / 100, 0)
	loadPerkFloat1(GBT_sellPrice, (SELL_PRICE_SLIDER_VAR - 0) / 100, (100.0 - 0) / 100, 0)
	SetGamesettingInt("iDaysToRespawnVendor", VENDOR_RESPAWN_SLIDER_VAR )
	SetGamesettingInt("iTrainingNumAllowedPerLevel", TRAINING_NUMALLOWED_SLIDER_VAR )
	SetGamesettingInt("iTrainingJourneymanCost", TRAINING_JOURNEYMANCOST_SLIDER_VAR )
	SetGamesettingInt("iTrainingJourneymanSkill", TRAINING_JOURNEYMANSKILL_SLIDER_VAR )
	SetGamesettingInt("iTrainingExpertCost", TRAINING_EXPERTCOST_SLIDER_VAR )
	SetGamesettingInt("iTrainingExpertSkill", TRAINING_EXPERTSKILL_SLIDER_VAR )
	SetGamesettingInt("iTrainingMasterCost", TRAINING_MASTERCOST_SLIDER_VAR )
	SetGamesettingInt("iTrainingMasterSkill", TRAINING_MASTERSKILL_SLIDER_VAR )
	SetNthLevelItemCount(VendorGoldApothecary,0, APOTHECARY_GOLD_SLIDER_VAR )
	SetNthLevelItemCount(VendorGoldBlacksmith,0, BLACKSMITH_GOLD_SLIDER_VAR )
	SetNthLevelItemCount(VendorGoldBlacksmithOrc,0, ORCBLACKSMITH_GOLD_SLIDER_VAR )
	SetNthLevelItemCount(VendorGoldBlacksmithTown,0, TOWNBLACKSMITH_GOLD_SLIDER_VAR )
	SetNthLevelItemCount(VendorGoldInn,0, INNKEERPER_GOLD_SLIDER_VAR )
	SetNthLevelItemCount(VendorGoldMisc,0, MISCMERCHANT_GOLD_SLIDER_VAR )
	SetNthLevelItemCount(VendorGoldSpells,0, SPELLMERCHANT_GOLD_SLIDER_VAR )
	SetNthLevelItemCount(VendorGoldStreetVendor,0, STREETVENDOR_GOLD_SLIDER_VAR )
	SetGamesettingFloat("fCombatStaminaRegenRateMult", COMBAT_STAMINAREGEN_SLIDER_VAR )
	SetGamesettingFloat("fDamagedStaminaRegenDelay", DAMAGESTAMINA_DELAY_SLIDER_VAR )
	SetGamesettingFloat("fBowZoomStaminaRegenDelay", BOWZOOM_REGENDELAY_SLIDER_VAR )
	SetGamesettingFloat("fCombatMagickaRegenRateMult", COMBAT_MAGICKAREGEN_SLIDER_VAR )
	SetGamesettingFloat("fStaminaRegenDelayMax", STAMINA_REGENDELAY_SLIDER_VAR )
	SetGamesettingFloat("fDamagedMagickaRegenDelay", DAMAGEMAGICKA_DELAY_SLIDER_VAR )
	SetGamesettingFloat("fMagickaRegenDelayMax", MAGICKA_REGENDELAY_SLIDER_VAR )
	PlayerRef.SetAV("HealRate", AV_HEALRATE_SLIDER_Var)
	PlayerRef.SetAV("MagickaRate", AV_MAGICKARATE_SLIDER_Var)
	PlayerRef.SetAV("StaminaRate", AV_STAMINARATE_SLIDER_Var)
	PlayerRef.SetAV("CarryWeight", AV_CARRYWEIGHT_SLIDER_Var)
	PlayerRef.SetAV("SpeedMult", AV_SPEEDMULT_SLIDER_Var)
	PlayerRef.SetAV("UnarmedDamage", AV_UNARMEDDAMAGE_SLIDER_Var)
	PlayerRef.SetAV("Mass", AV_MASS_SLIDER_Var)
	PlayerRef.SetAV("CritChance", AV_CRITCHANCE_SLIDER_Var)
	PlayerRef.SetAV("BowSpeedBonus", AV_BOWSPEEDBONUSVAR_SLIDER_Var)
	TimeScale.SetValueInt(TIME_SCALE_SLIDER_VAR )
	SetGamesettingFloat("fJumpFallHeightMinNPC", FALLHEIGHT_MINNPC_SLIDER_VAR )
	SetGamesettingFloat("fJumpFallHeightMin", FALLHEIGHT_MIN_SLIDER_VAR )
	SetGamesettingFloat("fJumpFallHeightMultNPC", FALLHEIGHT_MULTNPC_SLIDER_VAR )
	SetGamesettingFloat("fJumpFallHeightMult", FALLHEIGHT_MULT_SLIDER_VAR )
	SetGamesettingFloat("fJumpFallHeightExponentNPC", FALLHEIGHT_EXPNPC_SLIDER_VAR )
	SetGamesettingFloat("fJumpFallHeightExponent", FALLHEIGHT_EXP_SLIDER_VAR )
	SetGamesettingFloat("fJumpHeightMin", JUMP_HEIGHT_SLIDER_VAR )
	SetGamesettingFloat("fActorSwimBreathBase", SWIM_BREATHBASE_SLIDER_VAR )
	SetGamesettingFloat("fActorSwimBreathDamage", SWIM_BREATHDAMAGE_SLIDER_VAR )
	SetGamesettingFloat("fActorSwimBreathMult", SWIM_BREATHMULT_SLIDER_VAR )
	SetGamesettingFloat("fKillCamBaseOdds", KILLCAM_CHANCE_SLIDER_VAR )
	SetGamesettingFloat("fPlayerDeathReloadTime", DEATHCAMERA_TIME_SLIDER_VAR )
	KillMoveRandom.SetValue(KILLMOVE_CHANCE_SLIDER_VAR)
	DecapitationChance.SetValue(DECAPITATION_CHANCE_SLIDER_VAR)
	SetGamesettingFloat("fSprintStaminaDrainMult", SPRINT_DRAINBASE_SLIDER_VAR )
	SetGamesettingFloat("fSprintStaminaWeightMult", SPRINT_DRAINMULT_SLIDER_VAR )
	SetGamesettingInt("iArrowInventoryChance", ARROW_RECOVERY_SLIDER_VAR )
	SetGamesettingInt("iDeathDropWeaponChance", DEATH_DROPCHANCE_SLIDER_VAR )
	SetGamesettingFloat("fCameraShakeTime", CAMERA_SHAKETIME_SLIDER_VAR )
	SetGamesettingFloat("fFastTravelSpeedMult", FASTRAVEL_SPEED_SLIDER_VAR )
	SetGamesettingFloat("fHUDCompassLocationMaxDist", HUDCOMPASS_DISTANEC_SLIDER_VAR )
	SetGamesettingInt("iMaxAttachedArrows", ATTACHED_ARROWS_SLIDER_VAR )
	SetLightRadius(Torch01, LightRadius_VAR )
	SetLightDuration(Torch01, LightDuration_VAR )
	SpecialLootChance.SetValueInt(SPECIAL_LOOT_SLIDER_VAR )
	SetGamesettingFloat("fFriendHitTimer", FRIENDHIT_TIMER_SLIDER_VAR )
	SetGamesettingFloat("fFriendMinimumLastHitTime", FRIENDHIT_INTERVAL_SLIDER_VAR )
	SetGamesettingInt("iFriendHitCombatAllowed", FRIENDHIT_COMBAT_SLIDER_VAR )
	SetGamesettingInt("iFriendHitNonCombatAllowed", FRIENDHIT_NONCOMBAT_SLIDER_VAR )
	SetGamesettingInt("iAllyHitCombatAllowed", ALLYHIT_COMBAT_SLIDER_VAR )
	SetGamesettingInt("iAllyHitNonCombatAllowed", ALLYHIT_NONCOMBAT_SLIDER_VAR )
	SetGamesettingFloat("fCombatDodgeChanceMax", COMBAT_DODGECHANCE_SLIDER_VAR )
	SetGamesettingFloat("fCombatAimProjectileRandomOffset", COMBAT_AIMOFFSET_SLIDER_VAR )
	SetGamesettingFloat("fAIFleeHealthMult", COMBAT_FLEEHEALTH_SLIDER_VAR )
	SetGamesettingFloat("fGameplayVoiceFilePadding", DIALOGUE_PADDING_SLIDER_VAR )
	SetGamesettingFloat("fAIMinGreetingDistance", DIALOGUE_DISTANCE_SLIDER_VAR )
	SetGamesettingFloat("fFollowSpaceBetweenFollowers", FOLLOWER_SPACING_SLIDER_VAR )
	SetGamesettingFloat("fFollowExtraCatchUpSpeedMult", FOLLOWER_CATCHUP_SLIDER_VAR )
	SetGamesettingFloat("fLevelScalingMult", LEVELSCALING_MULT_SLIDER_VAR )
	SetGamesettingFloat("fLeveledActorMultEasy", LEVELEDACTOR_EASY_SLIDER_VAR )
	SetGamesettingFloat("fLeveledActorMultHard", LEVELEDACTOR_HARD_SLIDER_VAR )
	SetGamesettingFloat("fLeveledActorMultMedium", LEVELEDACTOR_MEDIUM_SLIDER_VAR )
	SetGamesettingFloat("fLeveledActorMultVeryHard", LEVELEDACTOR_VHARD_SLIDER_VAR )
	SetGamesettingInt("iHoursToRespawnCell", RESPAWN_TIME_SLIDER_VAR )
	SetGamesettingFloat("fNPCHealthLevelBonus", NPC_HEALTHBONUS_SLIDER_VAR )
	SetGamesettingInt("iAVDhmsLevelup", LEVELUP_ATTRIBUTE_SLIDER_VAR )
	SetGamesettingFloat("fLevelUpCarryWeightMod", LEVELUP_CARRYWEIGHT_SLIDER_VAR )
	SetGamesettingFloat("fLegendarySkillResetValue", LEGENDARYRESET_LEVEL_SLIDER_VAR )
	SetGamesettingFloat("fSkillUseCurve", LEVELUP_POWER_SLIDER_VAR )
	SetGamesettingFloat("fXPLevelUpBase", LEVELUP_BASE_SLIDER_VAR )
	SetGamesettingFloat("fXPLevelUpMult", LEVELUP_MULT_SLIDER_VAR )
	GetAVIByID(16).SetSkillUseMult(SKILLUSE_ALCHEMY_SLIDER_VAR) 
	GetAVIByID(18).SetSkillUseMult(SKILLUSE_ALTERATION_SLIDER_VAR) 
	GetAVIByID(9).SetSkillUseMult(SKILLUSE_BLOCK_SLIDER_VAR) 
	GetAVIByID(19).SetSkillUseMult(SKILLUSE_CONJURATION_SLIDER_VAR) 
	GetAVIByID(20).SetSkillUseMult(SKILLUSE_DESTRUCTION_SLIDER_VAR) 
	GetAVIByID(23).SetSkillUseMult(SKILLUSE_ENCHANTING_SLIDER_VAR) 
	GetAVIByID(11).SetSkillUseMult(SKILLUSE_HEAVYARMOR_SLIDER_VAR) 
	GetAVIByID(21).SetSkillUseMult(SKILLUSE_ILLUSION_SLIDER_VAR) 
	GetAVIByID(12).SetSkillUseMult(SKILLUSE_LIGHTARMOR_SLIDER_VAR) 
	GetAVIByID(14).SetSkillUseMult(SKILLUSE_LOCKPICKING_SLIDER_VAR) 
	GetAVIByID(8).SetSkillUseMult(SKILLUSE_MARKSMAN_SLIDER_VAR) 
	GetAVIByID(6).SetSkillUseMult(SKILLUSE_ONEHANDED_SLIDER_VAR) 
	GetAVIByID(13).SetSkillUseMult(SKILLUSE_PICKPOCKET_SLIDER_VAR) 
	GetAVIByID(22).SetSkillUseMult(SKILLUSE_RESTORATION_SLIDER_VAR) 
	GetAVIByID(10).SetSkillUseMult(SKILLUSE_SMITHING_SLIDER_VAR) 
	GetAVIByID(15).SetSkillUseMult(SKILLUSE_SNEAK_SLIDER_VAR) 
	GetAVIByID(17).SetSkillUseMult(SKILLUSE_SPEECHCRAFT_SLIDER_VAR) 
	GetAVIByID(7).SetSkillUseMult(SKILLUSE_TWOHAND_SLIDER_VAR) 
	SetGamesettingFloat("fDeathForceRangedForceMin", RFORCE_MIN_SLIDER_VAR )
	SetGamesettingFloat("fDeathForceRangedForceMax", RFORCE_MAX_SLIDER_VAR )
	SetGamesettingFloat("fDeathForceForceMin", MFORCE_MIN_SLIDER_VAR )
	SetGamesettingFloat("fDeathForceForceMax", MFORCE_MAX_SLIDER_VAR )
	SetGamesettingFloat("fDeathForceSpellImpactMult", SFORCE_SLIDER_VAR )
	SetGamesettingFloat("fZKeyMaxForce", GFORCE_SLIDER_VAR )
	SetINIFloat("fDefaultWorldFOV:Display", FIRST_FOV_SLIDER_VAR )
	SetINIFloat("fDefault1stPersonFOV:Display", THIRD_FOV_SLIDER_VAR )
	SetINIFloat("fMouseHeadingXScale:Controls", XSENSITIVITY_SLIDER_VAR )
	SetINIFloat("fMouseHeadingYScale:Controls", YSENSITIVITY_SLIDER_VAR )
	SetINIFloat("fOverShoulderCombatAddY:Camera", COMBAT_SHOULDERY_SLIDER_VAR )
	SetINIFloat("fOverShoulderCombatPosZ:Camera", COMBAT_SHOULDERZ_SLIDER_VAR )
	SetINIFloat("fOverShoulderCombatPosX:Camera", COMBAT_SHOULDERX_SLIDER_VAR )
	SetINIFloat("fOverShoulderPosZ:Camera", SHOULDERZ_SLIDER_VAR )
	SetINIFloat("fOverShoulderPosX:Camera", SHOULDERX_SLIDER_VAR )
	SetINIInt("iAutoSaveCount:SaveGame", AUTOSAVE_COUNT_SLIDER_VAR)
	SetINIBool("bShowCompass:Interface", SHOWCOMPASS_TOGGLE_VAR)
	SetINIBool("bDoDepthOfField:Imagespace", DEPTHFIELD_TOGGLE_VAR)
	SetINIBool("bEnableHavokHit:Animation", HAVOK_HIT_TOGGLE_VAR)
	SetINIFloat("fHavokHitImpulseMult:Animation", HAVOK_HIT_SLIDER_VAR )
	SetINIBool("bShowTutorials:Interface", SHOW_TUTORIAL_TOGGLE_VAR)
	SetINIFloat("fBookOpenTime:Interface", BOOK_SPEED_SLIDER_VAR )
	SetINIFloat("f1PArrowTiltUpAngle:Combat", FIRST_ARROWTILT_SLIDER_VAR )
	SetINIFloat("f3PArrowTiltUpAngle:Combat", THIRD_ARROWTILT_SLIDER_VAR )
	SetINIFloat("f1PBoltTiltUpAngle:Combat", FIRST_BOLTTILT_SLIDER_VAR )
	SetINIBool("bForceNPCsUseAmmo:Combat", NPC_USEAMMO_TOGGLE_VAR)
	SetINIFloat("fVisibleNavmeshMoveDist:Actor", NAVMESH_DISTANCE_SLIDER_VAR )
	SetINIFloat("fLandFriction:Landscape", FRICTION_LAND_SLIDER_VAR )
	SetINIBool("bEnableTreeAnimations:Trees", TREE_ANIMATION_TOGGLE_VAR)
	SetINIBool("bDisableAllGore:General", GORE_TOGGLE_VAR)
	SetINIInt("iConsoleTextSize:Menu", CONSOLE_TEXT_SLIDER_VAR)
	SetINIInt("iConsoleSizeScreenPercent:Menu", CONSOLE_PERCENT_SLIDER_VAR)
	SetINIFloat("fMapWorldYawRange:MapMenu", MAP_YAW_SLIDER_VAR )
	SetINIFloat("fMapWorldMaxPitch:MapMenu", MAP_PITCH_SLIDER_VAR )
	SetINIBool("bVatsDisable:VATS", VATS_TOGGLE_VAR)
	SetINIBool("bAlwaysActive:General", ALWAYS_ACTIVE_TOGGLE_VAR)
	SetINIBool("bEssentialTakeNoDamage:Gameplay", ESSENTIAL_NPC_TOGGLE_VAR)
	loadSpell(GBT_legendaryBonus, LEGENDARY_BONUS_TOGGLE_VAR )
	loadSpell(GBT_arrowFamine, ARROW_FAMINE_TOGGLE_VAR )
	loadSpell(GBT_sneakFatigue, SNEAK_FATIGUE_TOGGLE_VAR )
	loadSpell(GBT_enableTimedBlock, TIMED_BLOCK_TOGGLE_VAR )
	loadSpell(GBT_enableItemAdded, ITEM_LIMITER_TOGGLE_VAR )
	loadSpell(GBT_enableOnHit, PLAYER_STAGGER_TOGGLE_VAR )
	loadSpell(GBT_enableMeleeStagger, NPC_STAGGER_TOGGLE_VAR )
	loadSpell(GBT_enableBleedout, BLEEDOUT_TOGGLE_VAR )
	loadSpell(GBT_EnableCombatState, ARMOR_CMBEXP_TOGGLE_VAR )
IF showMessages
	float ftimeEnd = GetCurrentRealTime()
	Debug.Notification("SkyTweak: Took " + (ftimeEnd - ftimeStart) + " seconds to load from local memory")
	ENDIF
		ENDFUNCTION

;======================================================================
;=============================FULL RESET==============================
;======================================================================

FUNCTION resetAll()
	float ftimeStart = GetCurrentRealTime()

	TEMPER_SCALE_TOGGLE_VAR = false
	PlayerRef.RemovePerk(GBT_Temper_Scale)
	SHOUT_SCALE_SLIDER_VAR = 0.0
	PlayerRef.RemovePerk(GBT_shoutScale)
	GBT_shoutScale.SetNthEntryValue(0, 1, (0.0 - 0) / 100)
	CRIT_SCALE_TOGGLE_VAR = false
	PlayerRef.RemovePerk(GBT_Critical_Damage_Scaling)
	BLEED_SCALE_TOGGLE_VAR = false
	PlayerRef.RemovePerk(GBT_Bleed_Damage_Scaling)
	STAMINACOST_SCALE_TOGGLE_VAR = false
	PlayerRef.RemovePerk(GBT_Stamina_Cost_Scaling)
	ILLTARGLVL_SCALE_TOGGLE_VAR = false
	PlayerRef.RemovePerk(GBT_illScaleTargetLevel)
	FRIENDLY_DAMAGE_TOGGLE_VAR = false
	PlayerRef.RemovePerk(GBT_friendlyDamage)
	TRAP_MAGNITUDE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_trapMagnitude)
	GBT_trapMagnitude.SetNthEntryValue(0, 0, (100.0 - 0) / 100)
	FRIENDLY_STAGGER_TOGGLE_VAR = false
	PlayerRef.RemovePerk(GBT_friendlyStagger)
	WEREDMG_DEALT_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_WerewolfDamageDealt)
	GBT_WerewolfDamageDealt.SetNthEntryValue(0, 0, (100.0 - 0) / 100)
	WEREDMG_TAKEN_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_WerewolfDamageTaken)
	GBT_WerewolfDamageTaken.SetNthEntryValue(0, 0, (100.0 - 0) / 100)
	POISON_DOSE_SLIDER_VAR = 0.0
	PlayerRef.RemovePerk(GBT_poisonDose)
	GBT_poisonDose.SetNthEntryValue(0, 0, (0.0 - 0) / 1)
	DUALCAST_POWER_SLIDER_VAR = GetGameSettingFloat("fMagicDualCastingEffectivenessBase")
	DUALCAST_COST_SLIDER_VAR = GetGameSettingFloat("fMagicDualCastingCostMult")
	MAGICCOST_SCALE_SLIDER_VAR = GetGameSettingFloat("fMagicCasterPCSkillCostBase")
	MAGIC_COST_SLIDER_VAR = GetGameSettingFloat("fMagicCasterPCSkillCostMult")
	NPCMAGICCOST_SCALE_SLIDER_VAR = GetGameSettingFloat("fMagicCasterSkillCostBase")
	NPCMAGIC_COST_SLIDER_VAR = GetGameSettingFloat("fMagicCasterSkillCostMult")
	MAX_RUNES_SLIDER_VAR = GetGameSettingInt("iMaxPlayerRunes")
	MAX_SUMMONED_SLIDER_VAR = GetGameSettingInt("iMaxSummonedCreatures")
	TELEKIN_DAMAGE_SLIDER_VAR = GetGameSettingFloat("fMagicTelekinesisDamageBase")
	TELEKIN_DUALMULT_SLIDER_VAR = GetGameSettingFloat("fMagicTelekinesisDualCastDamageMult")
	ALTMAG_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_altScaleMag)
	GBT_altScaleMag.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	CONJMAG_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_conjScaleMag)
	GBT_conjScaleMag.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	ALTDURNOTPARA_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_altScaleDurNotPara)
	GBT_altScaleDurNotPara.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	CONJDUR_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_conjScaleDur)
	GBT_conjScaleDur.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	ALTCOST_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_altScaleCost)
	GBT_altScaleCost.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	CONJCOST_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_conjScaleCost)
	GBT_conjScaleCost.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	ALTDURPARA_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_altScaleDurPara)
	GBT_altScaleDurPara.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	BOUNTMELEE_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_conjScaleBoundMelee)
	GBT_conjScaleBoundMelee.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	ALTCOSTDET_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_altScaleCostDet)
	GBT_altScaleCostDet.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	BOUNDBOW_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_conjScaleBoundBow)
	GBT_conjScaleBoundBow.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	DESMAG_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_desScaleMag)
	GBT_desScaleMag.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	HEALMAG_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_restScaleMagHeal)
	GBT_restScaleMagHeal.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	DESDUR_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_desScaleDur)
	GBT_desScaleDur.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	HEALDUR_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_restScaleDurHeal)
	GBT_restScaleDurHeal.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	DESCOST_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_desScaleCost)
	GBT_desScaleCost.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	HEALCOST_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_restScaleCostHeal)
	GBT_restScaleCostHeal.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	ILLMAG_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_illScaleMag)
	GBT_illScaleMag.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	NONHEALMAG_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_nonHealScaleMag)
	GBT_nonHealScaleMag.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	ILLDUR_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_illScaleDur)
	GBT_illScaleDur.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	NONHEALDUR_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_nonHealScaleDur)
	GBT_nonHealScaleDur.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	ILLCOST_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_illScaleCost)
	GBT_illScaleCost.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	NONHEALCOST_SCALE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_nonHealScaleCost)
	GBT_nonHealScaleCost.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	LESSERPOWER_COOLDOWN_SLIDER_VAR = GetGameSettingFloat("fMagicLesserPowerCooldownTimer")
	scaleDamageDealt_VAR = 1.0
	scaleDamageTaken_VAR = 1.0
	DAMAGEDEALT_NOVICE_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPByPCVE")
	DAMAGETAKEN_NOVICE_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPToPCVE")
	DAMAGEDEALT_APPRENTICE_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPByPCE")
	DAMAGETAKEN_APPRENTICE_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPToPCE")
	DAMAGEDEALT_ADEPT_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPByPCN")
	DAMAGETAKEN_ADEPT_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPToPCN")
	DAMAGEDEALT_EXPERT_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPByPCH")
	DAMAGETAKEN_EXPERT_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPToPCH")
	DAMAGEDEALT_MASTER_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPByPCVH")
	DAMAGETAKEN_MASTER_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPToPCVH")
	DAMAGEDEALT_LEGENDARY_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPByPCL")
	DAMAGETAKEN_LEGENDARY_SLIDER_VAR = GetGameSettingFloat("fDiffMultHPToPCL")
	WEAPONSCALE_PCMIN_SLIDER_VAR = GetGameSettingFloat("fDamagePCSkillMin")
	WEAPONSCALE_PCMAX_SLIDER_VAR = GetGameSettingFloat("fDamagePCSkillMax")
	WEAPONSCALE_NPCMIN_SLIDER_VAR = GetGameSettingFloat("fDamageSkillMin")
	WEAPONSCALE_NPCMAX_SLIDER_VAR = GetGameSettingFloat("fDamageSkillMax")
	ARMOR_SCALE_SLIDER_VAR = GetGameSettingFloat("fArmorScalingFactor")
	MAX_RESISTANCE_SLIDER_VAR = GetGameSettingFloat("fPlayerMaxResistance")
	ARMOR_BASERESIST_SLIDER_VAR = GetGameSettingFloat("fArmorBaseFactor")
	ARMOR_MAXRESIST_SLIDER_VAR = GetGameSettingFloat("fMaxArmorRating")
	PC_ARMORRATING_SLIDER_VAR = GetGameSettingFloat("fArmorRatingPCMax")
	NPC_ARMORRATING_SLIDER_VAR = GetGameSettingFloat("fArmorRatingMax")
	ENCUM_EFFECT_SLIDER_VAR = GetGameSettingFloat("fMoveEncumEffect")
	ENCUMWEAP_EFFECT_SLIDER_VAR = GetGameSettingFloat("fMoveEncumEffectNoWeapon")
	WEAPONDAMAGE_MULT_SLIDER_VAR = GetGameSettingFloat("fDamageWeaponMult")
	TWOHAND_ATKSPD_SLIDER_VAR = GetGameSettingFloat("fWeaponTwoHandedAnimationSpeedMult")
	AUTOAIM_AREA_SLIDER_VAR = GetGameSettingFloat("fAutoAimScreenPercentage")
	AUTOAIM_RANGE_SLIDER_VAR = GetGameSettingFloat("fAutoAimMaxDistance")
	AUTOAIM_DEGREES_SLIDER_VAR = GetGameSettingFloat("fAutoAimMaxDegrees")
	AUTOAIM_DEGREESTHIRD_SLIDER_VAR = GetGameSettingFloat("fAutoAimMaxDegrees3rdPerson")
	STAMINA_POWERCOST_SLIDER_VAR = GetGameSettingFloat("fPowerAttackStaminaPenalty")
	STAMINA_BLOCKCOSTMULT_SLIDER_VAR = GetGameSettingFloat("fStaminaBlockDmgMult")
	STAMINA_BASHCOST_SLIDER_VAR = GetGameSettingFloat("fStaminaBashBase")
	STAMINA_POWERBASHCOST_SLIDER_VAR = GetGameSettingFloat("fStaminaPowerBashBase")
	STAMINA_BLOCKCOSTBASE_SLIDER_VAR = GetGameSettingFloat("fStaminaBlockBase")
	BLOCK_SHIELD_SLIDER_VAR = GetGameSettingFloat("fShieldBaseFactor")
	BLOCK_WEAPON_SLIDER_VAR = GetGameSettingFloat("fBlockWeaponBase")
	WEAPON_REACH_SLIDER_VAR = GetGameSettingFloat("fCombatDistance")
	BASH_REACH_SLIDER_VAR = GetGameSettingFloat("fCombatBashReach")
	AISEARCH_TIME_SLIDER_VAR = GetGameSettingFloat("fCombatStealthPointRegenAttackedWaitTime")
	AISEARCH_TIMEATTACKED_SLIDER_VAR = GetGameSettingFloat("fCombatStealthPointRegenDetectedEventWaitTime")
	SNEAKLEVEL_BASE_SLIDER_VAR = GetGameSettingFloat("fPlayerDetectionSneakBase")
	SNEAKDETECTION_SCALE_SLIDER_VAR = GetGameSettingFloat("fPlayerDetectionSneakMult")
	DETECTION_FOV_SLIDER_VAR = GetGameSettingFloat("fDetectionViewCone")
	SNEAK_BASE_SLIDER_VAR = GetGameSettingFloat("fSneakBaseValue")
	DETECTION_LIGHT_SLIDER_VAR = GetGameSettingFloat("fDetectionSneakLightMod")
	DETECTION_LIGHTEXT_SLIDER_VAR = GetGameSettingFloat("fSneakLightExteriorMult")
	DETECTION_SOUND_SLIDER_VAR = GetGameSettingFloat("fSneakSoundsMult")
	DETECTION_SOUNDLOS_SLIDER_VAR = GetGameSettingFloat("fSneakSoundLosMult")
	PICKPOCKET_MAXCHANCE_SLIDER_VAR = GetGameSettingFloat("fPickPocketMaxChance")
	PICKPOCKET_MINCHANCE_SLIDER_VAR = GetGameSettingFloat("fPickPocketMinChance")
	SNEAKMULT_MARKSMAN_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_SneakMarks)
	GBT_SneakMarks.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	SNEAKMULT_DAGGER_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_SneakDagger)
	GBT_SneakDagger.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	SNEAKMULT_TWOHAND_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_SneakOne)
	GBT_SneakOne.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	SNEAKMULT_ONEHAND_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_SneakTwo)
	GBT_SneakTwo.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	SNEAKMULT_UNARMED_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_SneakH2H)
	GBT_SneakH2H.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	SNEAKMULT_RUNE_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_SneakRuneMag)
	GBT_SneakRuneMag.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	SNEAKMULT_SEARCH_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_SneakSearch)
	GBT_SneakSearch.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	SNEAKMULT_SPELLMAG_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_SneakSpellMag)
	GBT_SneakSpellMag.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	SNEAKMULT_SPELLSEARCH_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_SneakSpellSearch)
	GBT_SneakSpellSearch.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	SNEAKMULT_SPELLDUR_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_SneakSpellDur)
	GBT_SneakSpellDur.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	SNEAKSCALE_PHYSICAL_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_SneakScalePhys)
	GBT_SneakScalePhys.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	SNEAKSCALE_SPELLMAG_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_SneakScaleSpell)
	GBT_SneakScaleSpell.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	SNEAKMULT_POISONMAG_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_SneakPoisonMag)
	GBT_SneakPoisonMag.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	SNEAKMULT_POISONDUR_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_SneakPoisonDur)
	GBT_SneakPoisonDur.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	SNEAKSCALE_POISONMAG_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_SneakScalePoisonMag)
	GBT_SneakScalePoisonMag.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	SNEAKSCALE_POISONDUR_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_SneakScalePoisonDur)
	GBT_SneakScalePoisonDur.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	LOCKPICK_VEASY_SLIDER_VAR = GetGameSettingFloat("fSweetSpotVeryEasy")
	LOCKPICKDUR_VEASY_SLIDER_VAR = GetGameSettingFloat("fLockpickBreakNovice")
	LOCKPICK_EASY_SLIDER_VAR = GetGameSettingFloat("fSweetSpotEasy")
	LOCKPICKDUR_EASY_SLIDER_VAR = GetGameSettingFloat("fLockpickBreakApprentice")
	LOCKPICK_AVERAGE_SLIDER_VAR = GetGameSettingFloat("fSweetSpotAverage")
	LOCKPICKDUR_AVERAGE_SLIDER_VAR = GetGameSettingFloat("fLockpickBreakAdept")
	LOCKPICK_HARD_SLIDER_VAR = GetGameSettingFloat("fSweetSpotHard")
	LOCKPICKDUR_HARD_SLIDER_VAR = GetGameSettingFloat("fLockpickBreakExpert")
	LOCKPICK_VHARD_SLIDER_VAR = GetGameSettingFloat("fSweetSpotVeryHard")
	LOCKPICKDUR_VHARD_SLIDER_VAR = GetGameSettingFloat("fLockpickBreakMaster")
	ALCHEMYMAG_MULT_SLIDER_VAR = GetGameSettingFloat("fAlchemyIngredientInitMult")
	ALCHEMYMAG_SCALE_SLIDER_VAR = GetGameSettingFloat("fAlchemySkillFactor")
	BONUS_INGR_SLIDER_VAR = 0.0
	PlayerRef.RemovePerk(GBT_bonusIngredients)
	GBT_bonusIngredients.SetNthEntryValue(0, 0, (0.0 - 0) / 1)
	BONUS_POTION_SLIDER_VAR = 0.0
	PlayerRef.RemovePerk(GBT_bonusPotions)
	GBT_bonusPotions.SetNthEntryValue(0, 0, (0.0 - 0) / 1)
	CHARGECOST_POWER_SLIDER_VAR = GetGameSettingFloat("fEnchantingCostExponent")
	ENCHANT_SCALING_SLIDER_VAR = GetGameSettingFloat("fEnchantingSkillFactor")
	CHARGECOST_MULT_SLIDER_VAR = GetGameSettingFloat("fEnchantingSkillCostMult")
	ENCHANTPRICE_EFFECT_SLIDER_VAR = GetGameSettingFloat("fEnchantmentEffectPointsMult")
	CHARGECOST_BASE_SLIDER_VAR = GetGameSettingFloat("fEnchantingSkillCostBase")
	ENCHANTPRICE_SOUL_SLIDER_VAR = GetGameSettingFloat("fEnchantmentPointsMult")
	ENCHANT_CHARGE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_enchantCharge)
	GBT_enchantCharge.SetNthEntryValue(0, 0, (100.0 - 0) / 100)
	ENCHANT_MAG_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_enchantMag)
	GBT_enchantMag.SetNthEntryValue(0, 0, (100.0 - 0) / 100)
	BONUS_ENCHANT_SLIDER_VAR = 0.0
	PlayerRef.RemovePerk(GBT_bonusEnchants)
	GBT_bonusEnchants.SetNthEntryValue(0, 0, (0.0 - 0) / 1)
	TEMPER_SUFFIX_SLIDER_VAR = GetGameSettingFloat("fSmithingConditionFactor")
	TEMPER_ARMOR_SLIDER_VAR = GetGameSettingFloat("fSmithingArmorMax")
	TEMPER_WEAPON_SLIDER_VAR = GetGameSettingFloat("fSmithingWeaponMax")
	POTION_MAG_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_PotionMag)
	GBT_PotionMag.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	POTION_DUR_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_PotionDur)
	GBT_PotionDur.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	POTION_SCALEMAG_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_PotionScaleMag)
	GBT_PotionScaleMag.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	POTION_SCALEDUR_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_PotionScaleDur)
	GBT_PotionScaleDur.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	POISON_MAG_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_PoisonMag)
	GBT_PoisonMag.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	POISON_DUR_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_PoisonDur)
	GBT_PoisonDur.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	POISON_SCALEMAG_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_PoisonScaleMag)
	GBT_PoisonScaleMag.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	POISON_SCALEDUR_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_PoisonScaleDur)
	GBT_PoisonScaleDur.SetNthEntryValue(0, 1, (100.0 - 100) / 10000)
	SCROLL_MAG_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_ScrollMag)
	GBT_ScrollMag.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	SCROLL_DUR_SLIDER_VAR = 1.0
	PlayerRef.RemovePerk(GBT_ScrollDur)
	GBT_ScrollDur.SetNthEntryValue(0, 0, (1.0 - 0) / 1)
	BARTER_BUYMIN_SLIDER_VAR = GetGameSettingFloat("fBarterBuyMin")
	BARTER_SELLMAX_SLIDER_VAR = GetGameSettingFloat("fBarterSellMax")
	BARTER_MIN_SLIDER_VAR = GetGameSettingFloat("fBarterMin")
	BARTER_MAX_SLIDER_VAR = GetGameSettingFloat("fBarterMax")
	BUY_PRICE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_buyPrice)
	GBT_buyPrice.SetNthEntryValue(0, 0, (100.0 - 0) / 100)
	SELL_PRICE_SLIDER_VAR = 100.0
	PlayerRef.RemovePerk(GBT_sellPrice)
	GBT_sellPrice.SetNthEntryValue(0, 0, (100.0 - 0) / 100)
	VENDOR_RESPAWN_SLIDER_VAR = GetGameSettingInt("iDaysToRespawnVendor")
	TRAINING_NUMALLOWED_SLIDER_VAR = GetGameSettingInt("iTrainingNumAllowedPerLevel")
	TRAINING_JOURNEYMANCOST_SLIDER_VAR = GetGameSettingInt("iTrainingJourneymanCost")
	TRAINING_JOURNEYMANSKILL_SLIDER_VAR = GetGameSettingInt("iTrainingJourneymanSkill")
	TRAINING_EXPERTCOST_SLIDER_VAR = GetGameSettingInt("iTrainingExpertCost")
	TRAINING_EXPERTSKILL_SLIDER_VAR = GetGameSettingInt("iTrainingExpertSkill")
	TRAINING_MASTERCOST_SLIDER_VAR = GetGameSettingInt("iTrainingMasterCost")
	TRAINING_MASTERSKILL_SLIDER_VAR = GetGameSettingInt("iTrainingMasterSkill")
	VendorGoldApothecary.Revert()
	APOTHECARY_GOLD_SLIDER_VAR = VendorGoldApothecary.GetNthCount(0)
	VendorGoldBlacksmith.Revert()
	BLACKSMITH_GOLD_SLIDER_VAR = VendorGoldBlacksmith.GetNthCount(0)
	VendorGoldBlacksmithOrc.Revert()
	ORCBLACKSMITH_GOLD_SLIDER_VAR = VendorGoldBlacksmithOrc.GetNthCount(0)
	VendorGoldBlacksmithTown.Revert()
	TOWNBLACKSMITH_GOLD_SLIDER_VAR = VendorGoldBlacksmithTown.GetNthCount(0)
	VendorGoldInn.Revert()
	INNKEERPER_GOLD_SLIDER_VAR = VendorGoldInn.GetNthCount(0)
	VendorGoldMisc.Revert()
	MISCMERCHANT_GOLD_SLIDER_VAR = VendorGoldMisc.GetNthCount(0)
	VendorGoldSpells.Revert()
	SPELLMERCHANT_GOLD_SLIDER_VAR = VendorGoldSpells.GetNthCount(0)
	VendorGoldStreetVendor.Revert()
	STREETVENDOR_GOLD_SLIDER_VAR = VendorGoldStreetVendor.GetNthCount(0)
	COMBAT_STAMINAREGEN_SLIDER_VAR = GetGameSettingFloat("fCombatStaminaRegenRateMult")
	DAMAGESTAMINA_DELAY_SLIDER_VAR = GetGameSettingFloat("fDamagedStaminaRegenDelay")
	BOWZOOM_REGENDELAY_SLIDER_VAR = GetGameSettingFloat("fBowZoomStaminaRegenDelay")
	COMBAT_MAGICKAREGEN_SLIDER_VAR = GetGameSettingFloat("fCombatMagickaRegenRateMult")
	STAMINA_REGENDELAY_SLIDER_VAR = GetGameSettingFloat("fStaminaRegenDelayMax")
	DAMAGEMAGICKA_DELAY_SLIDER_VAR = GetGameSettingFloat("fDamagedMagickaRegenDelay")
	MAGICKA_REGENDELAY_SLIDER_VAR = GetGameSettingFloat("fMagickaRegenDelayMax")
	AV_HEALRATE_SLIDER_VAR =  PlayerRef.GetBaseAV("HealRate")
	AV_MAGICKARATE_SLIDER_VAR =  PlayerRef.GetBaseAV("MagickaRate")
	AV_STAMINARATE_SLIDER_VAR =  PlayerRef.GetBaseAV("StaminaRate")
	AV_CARRYWEIGHT_SLIDER_VAR =  PlayerRef.GetBaseAV("CarryWeight")
	AV_SPEEDMULT_SLIDER_VAR =  PlayerRef.GetBaseAV("SpeedMult")
	AV_UNARMEDDAMAGE_SLIDER_VAR =  PlayerRef.GetBaseAV("UnarmedDamage")
	AV_MASS_SLIDER_VAR =  PlayerRef.GetBaseAV("Mass")
	AV_CRITCHANCE_SLIDER_VAR =  PlayerRef.GetBaseAV("CritChance")
	AV_BOWSPEEDBONUSVAR_SLIDER_VAR =  PlayerRef.GetBaseAV("BowSpeedBonus")
	TimeScale.SetValueInt(20)
	TIME_SCALE_SLIDER_VAR = 20
	FALLHEIGHT_MINNPC_SLIDER_VAR = GetGameSettingFloat("fJumpFallHeightMinNPC")
	FALLHEIGHT_MIN_SLIDER_VAR = GetGameSettingFloat("fJumpFallHeightMin")
	FALLHEIGHT_MULTNPC_SLIDER_VAR = GetGameSettingFloat("fJumpFallHeightMultNPC")
	FALLHEIGHT_MULT_SLIDER_VAR = GetGameSettingFloat("fJumpFallHeightMult")
	FALLHEIGHT_EXPNPC_SLIDER_VAR = GetGameSettingFloat("fJumpFallHeightExponentNPC")
	FALLHEIGHT_EXP_SLIDER_VAR = GetGameSettingFloat("fJumpFallHeightExponent")
	JUMP_HEIGHT_SLIDER_VAR = GetGameSettingFloat("fJumpHeightMin")
	SWIM_BREATHBASE_SLIDER_VAR = GetGameSettingFloat("fActorSwimBreathBase")
	SWIM_BREATHDAMAGE_SLIDER_VAR = GetGameSettingFloat("fActorSwimBreathDamage")
	SWIM_BREATHMULT_SLIDER_VAR = GetGameSettingFloat("fActorSwimBreathMult")
	KILLCAM_CHANCE_SLIDER_VAR = GetGameSettingFloat("fKillCamBaseOdds")
	DEATHCAMERA_TIME_SLIDER_VAR = GetGameSettingFloat("fPlayerDeathReloadTime")
	KillMoveRandom.SetValue(50.0)
	KILLMOVE_CHANCE_SLIDER_VAR = 50.0
	DecapitationChance.SetValue(40.0)
	DECAPITATION_CHANCE_SLIDER_VAR = 40.0
	SPRINT_DRAINBASE_SLIDER_VAR = GetGameSettingFloat("fSprintStaminaDrainMult")
	SPRINT_DRAINMULT_SLIDER_VAR = GetGameSettingFloat("fSprintStaminaWeightMult")
	ARROW_RECOVERY_SLIDER_VAR = GetGameSettingInt("iArrowInventoryChance")
	DEATH_DROPCHANCE_SLIDER_VAR = GetGameSettingInt("iDeathDropWeaponChance")
	CAMERA_SHAKETIME_SLIDER_VAR = GetGameSettingFloat("fCameraShakeTime")
	FASTRAVEL_SPEED_SLIDER_VAR = GetGameSettingFloat("fFastTravelSpeedMult")
	HUDCOMPASS_DISTANEC_SLIDER_VAR = GetGameSettingFloat("fHUDCompassLocationMaxDist")
	ATTACHED_ARROWS_SLIDER_VAR = GetGameSettingInt("iMaxAttachedArrows")
	LightRadius_VAR = 512
	SetLightRadius(Torch01,512)
	LightDuration_VAR = 240
	SetLightDuration(Torch01,240)
	SpecialLootChance.SetValueInt(90)
	SPECIAL_LOOT_SLIDER_VAR = 90
	FRIENDHIT_TIMER_SLIDER_VAR = GetGameSettingFloat("fFriendHitTimer")
	FRIENDHIT_INTERVAL_SLIDER_VAR = GetGameSettingFloat("fFriendMinimumLastHitTime")
	FRIENDHIT_COMBAT_SLIDER_VAR = GetGameSettingInt("iFriendHitCombatAllowed")
	FRIENDHIT_NONCOMBAT_SLIDER_VAR = GetGameSettingInt("iFriendHitNonCombatAllowed")
	ALLYHIT_COMBAT_SLIDER_VAR = GetGameSettingInt("iAllyHitCombatAllowed")
	ALLYHIT_NONCOMBAT_SLIDER_VAR = GetGameSettingInt("iAllyHitNonCombatAllowed")
	COMBAT_DODGECHANCE_SLIDER_VAR = GetGameSettingFloat("fCombatDodgeChanceMax")
	COMBAT_AIMOFFSET_SLIDER_VAR = GetGameSettingFloat("fCombatAimProjectileRandomOffset")
	COMBAT_FLEEHEALTH_SLIDER_VAR = GetGameSettingFloat("fAIFleeHealthMult")
	DIALOGUE_PADDING_SLIDER_VAR = GetGameSettingFloat("fGameplayVoiceFilePadding")
	DIALOGUE_DISTANCE_SLIDER_VAR = GetGameSettingFloat("fAIMinGreetingDistance")
	FOLLOWER_SPACING_SLIDER_VAR = GetGameSettingFloat("fFollowSpaceBetweenFollowers")
	FOLLOWER_CATCHUP_SLIDER_VAR = GetGameSettingFloat("fFollowExtraCatchUpSpeedMult")
	LEVELSCALING_MULT_SLIDER_VAR = GetGameSettingFloat("fLevelScalingMult")
	LEVELEDACTOR_EASY_SLIDER_VAR = GetGameSettingFloat("fLeveledActorMultEasy")
	LEVELEDACTOR_HARD_SLIDER_VAR = GetGameSettingFloat("fLeveledActorMultHard")
	LEVELEDACTOR_MEDIUM_SLIDER_VAR = GetGameSettingFloat("fLeveledActorMultMedium")
	LEVELEDACTOR_VHARD_SLIDER_VAR = GetGameSettingFloat("fLeveledActorMultVeryHard")
	RESPAWN_TIME_SLIDER_VAR = GetGameSettingInt("iHoursToRespawnCell")
	NPC_HEALTHBONUS_SLIDER_VAR = GetGameSettingFloat("fNPCHealthLevelBonus")
	LEVELUP_ATTRIBUTE_SLIDER_VAR = GetGameSettingInt("iAVDhmsLevelup")
	LEVELUP_CARRYWEIGHT_SLIDER_VAR = GetGameSettingFloat("fLevelUpCarryWeightMod")
	LEGENDARYRESET_LEVEL_SLIDER_VAR = GetGameSettingFloat("fLegendarySkillResetValue")
	LEVELUP_POWER_SLIDER_VAR = GetGameSettingFloat("fSkillUseCurve")
	LEVELUP_BASE_SLIDER_VAR = GetGameSettingFloat("fXPLevelUpBase")
	LEVELUP_MULT_SLIDER_VAR = GetGameSettingFloat("fXPLevelUpMult")
	SKILLUSE_ALCHEMY_SLIDER_VAR = GetAVIByID(16).GetSkillUseMult()
	SKILLUSE_ALTERATION_SLIDER_VAR = GetAVIByID(18).GetSkillUseMult()
	SKILLUSE_BLOCK_SLIDER_VAR = GetAVIByID(9).GetSkillUseMult()
	SKILLUSE_CONJURATION_SLIDER_VAR = GetAVIByID(19).GetSkillUseMult()
	SKILLUSE_DESTRUCTION_SLIDER_VAR = GetAVIByID(20).GetSkillUseMult()
	SKILLUSE_ENCHANTING_SLIDER_VAR = GetAVIByID(23).GetSkillUseMult()
	SKILLUSE_HEAVYARMOR_SLIDER_VAR = GetAVIByID(11).GetSkillUseMult()
	SKILLUSE_ILLUSION_SLIDER_VAR = GetAVIByID(21).GetSkillUseMult()
	SKILLUSE_LIGHTARMOR_SLIDER_VAR = GetAVIByID(12).GetSkillUseMult()
	SKILLUSE_LOCKPICKING_SLIDER_VAR = GetAVIByID(14).GetSkillUseMult()
	SKILLUSE_MARKSMAN_SLIDER_VAR = GetAVIByID(8).GetSkillUseMult()
	SKILLUSE_ONEHANDED_SLIDER_VAR = GetAVIByID(6).GetSkillUseMult()
	SKILLUSE_PICKPOCKET_SLIDER_VAR = GetAVIByID(13).GetSkillUseMult()
	SKILLUSE_RESTORATION_SLIDER_VAR = GetAVIByID(22).GetSkillUseMult()
	SKILLUSE_SMITHING_SLIDER_VAR = GetAVIByID(10).GetSkillUseMult()
	SKILLUSE_SNEAK_SLIDER_VAR = GetAVIByID(15).GetSkillUseMult()
	SKILLUSE_SPEECHCRAFT_SLIDER_VAR = GetAVIByID(17).GetSkillUseMult()
	SKILLUSE_TWOHAND_SLIDER_VAR = GetAVIByID(7).GetSkillUseMult()
	RFORCE_MIN_SLIDER_VAR = GetGameSettingFloat("fDeathForceRangedForceMin")
	RFORCE_MAX_SLIDER_VAR = GetGameSettingFloat("fDeathForceRangedForceMax")
	MFORCE_MIN_SLIDER_VAR = GetGameSettingFloat("fDeathForceForceMin")
	MFORCE_MAX_SLIDER_VAR = GetGameSettingFloat("fDeathForceForceMax")
	SFORCE_SLIDER_VAR = GetGameSettingFloat("fDeathForceSpellImpactMult")
	GFORCE_SLIDER_VAR = GetGameSettingFloat("fZKeyMaxForce")
	FIRST_FOV_SLIDER_VAR = GetINIFloat("fDefaultWorldFOV:Display")
	THIRD_FOV_SLIDER_VAR = GetINIFloat("fDefault1stPersonFOV:Display")
	XSENSITIVITY_SLIDER_VAR = GetINIFloat("fMouseHeadingXScale:Controls")
	YSENSITIVITY_SLIDER_VAR = GetINIFloat("fMouseHeadingYScale:Controls")
	COMBAT_SHOULDERY_SLIDER_VAR = GetINIFloat("fOverShoulderCombatAddY:Camera")
	COMBAT_SHOULDERZ_SLIDER_VAR = GetINIFloat("fOverShoulderCombatPosZ:Camera")
	COMBAT_SHOULDERX_SLIDER_VAR = GetINIFloat("fOverShoulderCombatPosX:Camera")
	SHOULDERZ_SLIDER_VAR = GetINIFloat("fOverShoulderPosZ:Camera")
	SHOULDERX_SLIDER_VAR = GetINIFloat("fOverShoulderPosX:Camera")
	AUTOSAVE_COUNT_SLIDER_VAR = GetINIInt("iAutoSaveCount:SaveGame")
	SetINIBool("bShowCompass:Interface", true)
	SetINIBool("bDoDepthOfField:Imagespace", true)
	SetINIBool("bEnableHavokHit:Animation", false)
	HAVOK_HIT_SLIDER_VAR = GetINIFloat("fHavokHitImpulseMult:Animation")
	SetINIBool("bShowTutorials:Interface", true)
	BOOK_SPEED_SLIDER_VAR = GetINIFloat("fBookOpenTime:Interface")
	FIRST_ARROWTILT_SLIDER_VAR = GetINIFloat("f1PArrowTiltUpAngle:Combat")
	THIRD_ARROWTILT_SLIDER_VAR = GetINIFloat("f3PArrowTiltUpAngle:Combat")
	FIRST_BOLTTILT_SLIDER_VAR = GetINIFloat("f1PBoltTiltUpAngle:Combat")
	SetINIBool("bForceNPCsUseAmmo:Combat", false)
	NAVMESH_DISTANCE_SLIDER_VAR = GetINIFloat("fVisibleNavmeshMoveDist:Actor")
	FRICTION_LAND_SLIDER_VAR = GetINIFloat("fLandFriction:Landscape")
	SetINIBool("bEnableTreeAnimations:Trees", true)
	SetINIBool("bDisableAllGore:General", false)
	CONSOLE_TEXT_SLIDER_VAR = GetINIInt("iConsoleTextSize:Menu")
	CONSOLE_PERCENT_SLIDER_VAR = GetINIInt("iConsoleSizeScreenPercent:Menu")
	MAP_YAW_SLIDER_VAR = GetINIFloat("fMapWorldYawRange:MapMenu")
	MAP_PITCH_SLIDER_VAR = GetINIFloat("fMapWorldMaxPitch:MapMenu")
	SetINIBool("bVatsDisable:VATS", false)
	SetINIBool("bAlwaysActive:General", false)
	SetINIBool("bEssentialTakeNoDamage:Gameplay", true)
	LEGENDARY_BONUS_TOGGLE_VAR = false
	PlayerRef.RemoveSpell(GBT_legendaryBonus)
	GBT_legendaryBonus_Float = 5.0
	ARROW_FAMINE_TOGGLE_VAR = false
	PlayerRef.RemoveSpell(GBT_arrowFamine)
	GBT_arrowFamine_Float = 3.0
	SNEAK_FATIGUE_TOGGLE_VAR = false
	PlayerRef.RemoveSpell(GBT_sneakFatigue)
	GBT_sneakFatigue_Float = 3.0
	TIMED_BLOCK_TOGGLE_VAR = false
	PlayerRef.RemoveSpell(GBT_enableTimedBlock)
	GBT_timeBlockWeapon_Float = 0.3
	GBT_timeBlockShield_Float = 0.5
	GBT_timeBlockReflect_Float = 0.0
	GBT_timeBlockWard_Float = 0.3
	GBT_timeBlockDamage_Float = 40.0
	GBT_timeBlockXP_Float = 5.0
	ITEM_LIMITER_TOGGLE_VAR = false
	PlayerRef.RemoveSpell(GBT_enableItemAdded)
	GBT_limitLockpick_Int = 0
	GBT_limitArrow_Int = 0
	GBT_limitPotion_Int = 0
	GBT_limitPoison_Int = 0
	PLAYER_STAGGER_TOGGLE_VAR = false
	PlayerRef.RemoveSpell(GBT_enableOnHit)
	GBT_staggerTaken_Float = 1.0
	GBT_staggerImmunity_Float = 0.5
	GBT_staggerArmor_Float = 35.0
	GBT_staggerMagicka_Float = 200.0
	GBT_staggerMin_Float = 0.25
	GBT_staggerMax_Float = 3.0
	NPC_STAGGER_TOGGLE_VAR = false
	PlayerRef.RemoveSpell(GBT_enableMeleeStagger)
	GBT_MeleeStaggerMult_Float = 0.35
	GBT_MeleeStaggerBase_Float = 0.0
	GBT_MeleeStaggerWeight_Float = 35.0
	GBT_MeleeStaggerCD_Float = 3.5
	BLEEDOUT_TOGGLE_VAR = false
	PlayerRef.RemoveSpell(GBT_enableBleedout)
	GBT_bleedoutBase_Float = 0.25
	GBT_bleedoutMult_Int = 75
	GBT_bleedoutLivesMax_Int = 3
	ARMOR_CMBEXP_TOGGLE_VAR = false
	PlayerRef.RemoveSpell(GBT_EnableCombatState)
	GBT_ArmorExp_Float = 25.0
	GBT_BlockExp_Float = 100.0
	isRegistered = false
	ShowMessages = true
	saveHotkey = -1
	isQuickSave = 0
IF showMessages
	float ftimeEnd = GetCurrentRealTime()
	Debug.Notification("SkyTweak: Took " + (ftimeEnd - ftimeStart) + " to initialize settings")
	ENDIF
		ENDFUNCTION

;======================================================================
;==========================SAVE KEY SETTINGS============================
;======================================================================
STRING[] quickSaveOptions
EVENT OnKeyDown(Int KeyCode)
	IF !((Self as Form) as UILIB_GRIMY).IsMenuOpen()
		IF isQuickSave == 1
			localSaveAll()
			quickSaveIndex = quickSaveIndex + 1
			IF quickSaveIndex > 5
				quickSaveIndex = quickSaveIndex - 5
			ENDIF
			SaveGame("SkyTweak" +  quickSaveIndex)
		ELSEIF isQuickSave == 2
			localSaveAll()
			RequestSave()
		ELSEIF isQuickSave == 3
			localSaveAll()
			RequestAutoSave()
		ELSE
			String sResult = ((Self as Form) as UILIB_GRIMY).ShowTextInput("Name of Save File", "")
			IF sResult != ""
				localSaveAll()
				SaveGame(sResult)
			ENDIF
		ENDIF
	ENDIF
ENDEVENT

EVENT OnOptionKeyMapChange(INT option, INT keyCode, STRING conflictControl, STRING conflictName)
	IF option == SAVEHOTKEY_OID
		UnregisterForKey(saveHotkey)
		IF isRegistered
			RegisterForKey(keyCode)
		ENDIF
		saveHotkey = keyCode
		SetKeyMapOptionValue(option, keyCode)
		IF conflictControl != ""
			IF conflictName == ""
				ShowMessage("Note: This key conflicts with a vanilla hotkey.",false)
			ELSE
				ShowMessage("Note: This key conflicts the mod: " + conflictName,false)
			ENDIF
		ENDIF
	ENDIF
ENDEVENT

EVENT OnOptionMenuOpen(int option)
	SetMenuDialogStartIndex(isQuickSave)
	SetMenuDialogDefaultIndex(1)
	SetMenuDialogOptions(quickSaveOptions)
ENDEVENT

EVENT OnOptionMenuAccept(int option, int index)
	isQuickSave = index
	SetMenuOptionValue(QUICKSAVE_OID,quickSaveOptions[index])
ENDEVENT

FUNCTION updateDamageDealtScaling()
	SetGamesettingFloat("fDiffMultHPByPCVE", DAMAGEDEALT_NOVICE_SLIDER_VAR  * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPByPCE", DAMAGEDEALT_APPRENTICE_SLIDER_VAR  * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPByPCN", DAMAGEDEALT_ADEPT_SLIDER_VAR  * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPByPCH", DAMAGEDEALT_EXPERT_SLIDER_VAR  * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPByPCVH", DAMAGEDEALT_MASTER_SLIDER_VAR  * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPByPCL", DAMAGEDEALT_LEGENDARY_SLIDER_VAR  * Math.Pow(scaleDamageDealt_VAR,PlayerRef.GetLevel()))
ENDFUNCTION

FUNCTION updateDamageTakenScaling()
	SetGamesettingFloat("fDiffMultHPToPCVE", DAMAGETAKEN_NOVICE_SLIDER_VAR  * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPToPCE", DAMAGETAKEN_APPRENTICE_SLIDER_VAR  * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPToPCN", DAMAGETAKEN_ADEPT_SLIDER_VAR  * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPToPCH", DAMAGETAKEN_EXPERT_SLIDER_VAR  * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPToPCVH", DAMAGETAKEN_MASTER_SLIDER_VAR  * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
	SetGamesettingFloat("fDiffMultHPToPCL", DAMAGETAKEN_LEGENDARY_SLIDER_VAR  * Math.Pow(scaleDamageTaken_VAR,PlayerRef.GetLevel()))
ENDFUNCTION

EVENT OnMenuClose(STRING MenuName)
	IF MenuName == "LevelUp Menu"
		updateDamageDealtScaling()
		updateDamageTakenScaling()
	ENDIF
ENDEVENT

;======================================================================
;===========================IMPORT SETTINGS=============================
;======================================================================
bool canLoadAllSettings = false
FUNCTION importSettings()
	canLoadAllSettings = false
	IF needReimport
		resetAll()
		needReimport = false
	ELSE
		localLoadAll()
	ENDIF
	canLoadAllSettings = true
ENDFUNCTION

EVENT onPingSkyTweak(Form sender, Form theForm, int theInt, string theString)
	IF canLoadAllSettings
	canLoadAllSettings = false
		localSaveAll()
	canLoadAllSettings = true
	ENDIF
ENDEVENT

EVENT onConfigClose()
	IF canLoadAllSettings
	canLoadAllSettings = false
		localSaveAll()
	canLoadAllSettings = true
	ENDIF
ENDEVENT

PERK PROPERTY GBT_Temper_Scale AUTO
PERK PROPERTY GBT_shoutScale AUTO
PERK PROPERTY GBT_Critical_Damage_Scaling AUTO
PERK PROPERTY GBT_Bleed_Damage_Scaling AUTO
PERK PROPERTY GBT_Stamina_Cost_Scaling AUTO
PERK PROPERTY GBT_illScaleTargetLevel AUTO
PERK PROPERTY GBT_friendlyDamage AUTO
PERK PROPERTY GBT_trapMagnitude AUTO
PERK PROPERTY GBT_friendlyStagger AUTO
PERK PROPERTY GBT_WerewolfDamageDealt AUTO
PERK PROPERTY GBT_WerewolfDamageTaken AUTO
PERK PROPERTY GBT_poisonDose AUTO
PERK PROPERTY GBT_altScaleMag AUTO
PERK PROPERTY GBT_conjScaleMag AUTO
PERK PROPERTY GBT_altScaleDurNotPara AUTO
PERK PROPERTY GBT_conjScaleDur AUTO
PERK PROPERTY GBT_altScaleCost AUTO
PERK PROPERTY GBT_conjScaleCost AUTO
PERK PROPERTY GBT_altScaleDurPara AUTO
PERK PROPERTY GBT_conjScaleBoundMelee AUTO
PERK PROPERTY GBT_altScaleCostDet AUTO
PERK PROPERTY GBT_conjScaleBoundBow AUTO
PERK PROPERTY GBT_desScaleMag AUTO
PERK PROPERTY GBT_restScaleMagHeal AUTO
PERK PROPERTY GBT_desScaleDur AUTO
PERK PROPERTY GBT_restScaleDurHeal AUTO
PERK PROPERTY GBT_desScaleCost AUTO
PERK PROPERTY GBT_restScaleCostHeal AUTO
PERK PROPERTY GBT_illScaleMag AUTO
PERK PROPERTY GBT_nonHealScaleMag AUTO
PERK PROPERTY GBT_illScaleDur AUTO
PERK PROPERTY GBT_nonHealScaleDur AUTO
PERK PROPERTY GBT_illScaleCost AUTO
PERK PROPERTY GBT_nonHealScaleCost AUTO
PERK PROPERTY GBT_SneakMarks AUTO
PERK PROPERTY GBT_SneakDagger AUTO
PERK PROPERTY GBT_SneakOne AUTO
PERK PROPERTY GBT_SneakTwo AUTO
PERK PROPERTY GBT_SneakH2H AUTO
PERK PROPERTY GBT_SneakRuneMag AUTO
PERK PROPERTY GBT_SneakSearch AUTO
PERK PROPERTY GBT_SneakSpellMag AUTO
PERK PROPERTY GBT_SneakSpellSearch AUTO
PERK PROPERTY GBT_SneakSpellDur AUTO
PERK PROPERTY GBT_SneakScalePhys AUTO
PERK PROPERTY GBT_SneakScaleSpell AUTO
PERK PROPERTY GBT_SneakPoisonMag AUTO
PERK PROPERTY GBT_SneakPoisonDur AUTO
PERK PROPERTY GBT_SneakScalePoisonMag AUTO
PERK PROPERTY GBT_SneakScalePoisonDur AUTO
PERK PROPERTY GBT_bonusIngredients AUTO
PERK PROPERTY GBT_bonusPotions AUTO
PERK PROPERTY GBT_enchantCharge AUTO
PERK PROPERTY GBT_enchantMag AUTO
PERK PROPERTY GBT_bonusEnchants AUTO
PERK PROPERTY GBT_PotionMag AUTO
PERK PROPERTY GBT_PotionDur AUTO
PERK PROPERTY GBT_PotionScaleMag AUTO
PERK PROPERTY GBT_PotionScaleDur AUTO
PERK PROPERTY GBT_PoisonMag AUTO
PERK PROPERTY GBT_PoisonDur AUTO
PERK PROPERTY GBT_PoisonScaleMag AUTO
PERK PROPERTY GBT_PoisonScaleDur AUTO
PERK PROPERTY GBT_ScrollMag AUTO
PERK PROPERTY GBT_ScrollDur AUTO
PERK PROPERTY GBT_buyPrice AUTO
PERK PROPERTY GBT_sellPrice AUTO
LEVELEDITEM PROPERTY VendorGoldApothecary AUTO
LEVELEDITEM PROPERTY VendorGoldBlacksmith AUTO
LEVELEDITEM PROPERTY VendorGoldBlacksmithOrc AUTO
LEVELEDITEM PROPERTY VendorGoldBlacksmithTown AUTO
LEVELEDITEM PROPERTY VendorGoldInn AUTO
LEVELEDITEM PROPERTY VendorGoldMisc AUTO
LEVELEDITEM PROPERTY VendorGoldSpells AUTO
LEVELEDITEM PROPERTY VendorGoldStreetVendor AUTO
GLOBALVARIABLE PROPERTY TimeScale AUTO
GLOBALVARIABLE PROPERTY KillMoveRandom AUTO
GLOBALVARIABLE PROPERTY DecapitationChance AUTO
LIGHT PROPERTY Torch01 AUTO
GLOBALVARIABLE PROPERTY SpecialLootChance AUTO
SPELL PROPERTY GBT_legendaryBonus AUTO
SPELL PROPERTY GBT_arrowFamine AUTO
SPELL PROPERTY GBT_sneakFatigue AUTO
SPELL PROPERTY GBT_enableTimedBlock AUTO
SPELL PROPERTY GBT_enableItemAdded AUTO
SPELL PROPERTY GBT_enableOnHit AUTO
SPELL PROPERTY GBT_enableMeleeStagger AUTO
SPELL PROPERTY GBT_enableBleedout AUTO
SPELL PROPERTY GBT_EnableCombatState AUTO
BOOL TEMPER_SCALE_TOGGLE_VAR = false
FLOAT SHOUT_SCALE_SLIDER_VAR = 0.0
BOOL CRIT_SCALE_TOGGLE_VAR = false
BOOL BLEED_SCALE_TOGGLE_VAR = false
BOOL STAMINACOST_SCALE_TOGGLE_VAR = false
BOOL ILLTARGLVL_SCALE_TOGGLE_VAR = false
BOOL FRIENDLY_DAMAGE_TOGGLE_VAR = false
FLOAT TRAP_MAGNITUDE_SLIDER_VAR = 100.0
BOOL FRIENDLY_STAGGER_TOGGLE_VAR = false
FLOAT WEREDMG_DEALT_SLIDER_VAR = 100.0
FLOAT WEREDMG_TAKEN_SLIDER_VAR = 100.0
FLOAT POISON_DOSE_SLIDER_VAR = 0.0
FLOAT DUALCAST_POWER_SLIDER_VAR = 2.2
FLOAT DUALCAST_COST_SLIDER_VAR = 2.8
FLOAT MAGICCOST_SCALE_SLIDER_VAR = 0.0025
FLOAT MAGIC_COST_SLIDER_VAR = 1.0
FLOAT NPCMAGICCOST_SCALE_SLIDER_VAR = 0.0025
FLOAT NPCMAGIC_COST_SLIDER_VAR = 1.0
INT MAX_RUNES_SLIDER_VAR = 1
INT MAX_SUMMONED_SLIDER_VAR = 1
FLOAT TELEKIN_DAMAGE_SLIDER_VAR = 5.0
FLOAT TELEKIN_DUALMULT_SLIDER_VAR = 2.0
FLOAT ALTMAG_SCALE_SLIDER_VAR = 100.0
FLOAT CONJMAG_SCALE_SLIDER_VAR = 100.0
FLOAT ALTDURNOTPARA_SCALE_SLIDER_VAR = 100.0
FLOAT CONJDUR_SCALE_SLIDER_VAR = 100.0
FLOAT ALTCOST_SCALE_SLIDER_VAR = 100.0
FLOAT CONJCOST_SCALE_SLIDER_VAR = 100.0
FLOAT ALTDURPARA_SCALE_SLIDER_VAR = 100.0
FLOAT BOUNTMELEE_SCALE_SLIDER_VAR = 100.0
FLOAT ALTCOSTDET_SCALE_SLIDER_VAR = 100.0
FLOAT BOUNDBOW_SCALE_SLIDER_VAR = 100.0
FLOAT DESMAG_SCALE_SLIDER_VAR = 100.0
FLOAT HEALMAG_SCALE_SLIDER_VAR = 100.0
FLOAT DESDUR_SCALE_SLIDER_VAR = 100.0
FLOAT HEALDUR_SCALE_SLIDER_VAR = 100.0
FLOAT DESCOST_SCALE_SLIDER_VAR = 100.0
FLOAT HEALCOST_SCALE_SLIDER_VAR = 100.0
FLOAT ILLMAG_SCALE_SLIDER_VAR = 100.0
FLOAT NONHEALMAG_SCALE_SLIDER_VAR = 100.0
FLOAT ILLDUR_SCALE_SLIDER_VAR = 100.0
FLOAT NONHEALDUR_SCALE_SLIDER_VAR = 100.0
FLOAT ILLCOST_SCALE_SLIDER_VAR = 100.0
FLOAT NONHEALCOST_SCALE_SLIDER_VAR = 100.0
FLOAT LESSERPOWER_COOLDOWN_SLIDER_VAR = 3.0
FLOAT scaleDamageDealt_VAR = 1.0
FLOAT scaleDamageTaken_VAR = 1.0
FLOAT DAMAGEDEALT_NOVICE_SLIDER_VAR = 2.0
FLOAT DAMAGETAKEN_NOVICE_SLIDER_VAR = 0.5
FLOAT DAMAGEDEALT_APPRENTICE_SLIDER_VAR = 1.5
FLOAT DAMAGETAKEN_APPRENTICE_SLIDER_VAR = 0.75
FLOAT DAMAGEDEALT_ADEPT_SLIDER_VAR = 1.0
FLOAT DAMAGETAKEN_ADEPT_SLIDER_VAR = 1.0
FLOAT DAMAGEDEALT_EXPERT_SLIDER_VAR = 0.75
FLOAT DAMAGETAKEN_EXPERT_SLIDER_VAR = 1.5
FLOAT DAMAGEDEALT_MASTER_SLIDER_VAR = 0.5
FLOAT DAMAGETAKEN_MASTER_SLIDER_VAR = 2.0
FLOAT DAMAGEDEALT_LEGENDARY_SLIDER_VAR = 0.25
FLOAT DAMAGETAKEN_LEGENDARY_SLIDER_VAR = 3.0
FLOAT WEAPONSCALE_PCMIN_SLIDER_VAR = 1.0
FLOAT WEAPONSCALE_PCMAX_SLIDER_VAR = 1.5
FLOAT WEAPONSCALE_NPCMIN_SLIDER_VAR = 1.0
FLOAT WEAPONSCALE_NPCMAX_SLIDER_VAR = 3.0
FLOAT ARMOR_SCALE_SLIDER_VAR = 0.12
FLOAT MAX_RESISTANCE_SLIDER_VAR = 85.0
FLOAT ARMOR_BASERESIST_SLIDER_VAR = 0.03
FLOAT ARMOR_MAXRESIST_SLIDER_VAR = 80.0
FLOAT PC_ARMORRATING_SLIDER_VAR = 1.4
FLOAT NPC_ARMORRATING_SLIDER_VAR = 2.5
FLOAT ENCUM_EFFECT_SLIDER_VAR = 0.3
FLOAT ENCUMWEAP_EFFECT_SLIDER_VAR = 0.15
FLOAT WEAPONDAMAGE_MULT_SLIDER_VAR = 1.0
FLOAT TWOHAND_ATKSPD_SLIDER_VAR = 1.5
FLOAT AUTOAIM_AREA_SLIDER_VAR = 6.0
FLOAT AUTOAIM_RANGE_SLIDER_VAR = 1800.0
FLOAT AUTOAIM_DEGREES_SLIDER_VAR = 1.0
FLOAT AUTOAIM_DEGREESTHIRD_SLIDER_VAR = 2.0
FLOAT STAMINA_POWERCOST_SLIDER_VAR = 2.0
FLOAT STAMINA_BLOCKCOSTMULT_SLIDER_VAR = 0.25
FLOAT STAMINA_BASHCOST_SLIDER_VAR = 35.0
FLOAT STAMINA_POWERBASHCOST_SLIDER_VAR = 55.0
FLOAT STAMINA_BLOCKCOSTBASE_SLIDER_VAR = 0.0
FLOAT BLOCK_SHIELD_SLIDER_VAR = 0.45
FLOAT BLOCK_WEAPON_SLIDER_VAR = 0.3
FLOAT WEAPON_REACH_SLIDER_VAR = 141.0
FLOAT BASH_REACH_SLIDER_VAR = 141.0
FLOAT AISEARCH_TIME_SLIDER_VAR = 15.0
FLOAT AISEARCH_TIMEATTACKED_SLIDER_VAR = 10.0
FLOAT SNEAKLEVEL_BASE_SLIDER_VAR = 10.0
FLOAT SNEAKDETECTION_SCALE_SLIDER_VAR = 0.4
FLOAT DETECTION_FOV_SLIDER_VAR = 190.0
FLOAT SNEAK_BASE_SLIDER_VAR = -15.0
FLOAT DETECTION_LIGHT_SLIDER_VAR = 15.0
FLOAT DETECTION_LIGHTEXT_SLIDER_VAR = 0.5
FLOAT DETECTION_SOUND_SLIDER_VAR = 1.0
FLOAT DETECTION_SOUNDLOS_SLIDER_VAR = 0.3
FLOAT PICKPOCKET_MAXCHANCE_SLIDER_VAR = 90.0
FLOAT PICKPOCKET_MINCHANCE_SLIDER_VAR = 0.0
FLOAT SNEAKMULT_MARKSMAN_SLIDER_VAR = 1.0
FLOAT SNEAKMULT_DAGGER_SLIDER_VAR = 1.0
FLOAT SNEAKMULT_TWOHAND_SLIDER_VAR = 1.0
FLOAT SNEAKMULT_ONEHAND_SLIDER_VAR = 1.0
FLOAT SNEAKMULT_UNARMED_SLIDER_VAR = 1.0
FLOAT SNEAKMULT_RUNE_SLIDER_VAR = 1.0
FLOAT SNEAKMULT_SEARCH_SLIDER_VAR = 1.0
FLOAT SNEAKMULT_SPELLMAG_SLIDER_VAR = 1.0
FLOAT SNEAKMULT_SPELLSEARCH_SLIDER_VAR = 1.0
FLOAT SNEAKMULT_SPELLDUR_SLIDER_VAR = 1.0
FLOAT SNEAKSCALE_PHYSICAL_SLIDER_VAR = 100.0
FLOAT SNEAKSCALE_SPELLMAG_SLIDER_VAR = 100.0
FLOAT SNEAKMULT_POISONMAG_SLIDER_VAR = 1.0
FLOAT SNEAKMULT_POISONDUR_SLIDER_VAR = 1.0
FLOAT SNEAKSCALE_POISONMAG_SLIDER_VAR = 100.0
FLOAT SNEAKSCALE_POISONDUR_SLIDER_VAR = 100.0
FLOAT LOCKPICK_VEASY_SLIDER_VAR = 30.0
FLOAT LOCKPICKDUR_VEASY_SLIDER_VAR = 2.0
FLOAT LOCKPICK_EASY_SLIDER_VAR = 15.0
FLOAT LOCKPICKDUR_EASY_SLIDER_VAR = 1.0
FLOAT LOCKPICK_AVERAGE_SLIDER_VAR = 7.5
FLOAT LOCKPICKDUR_AVERAGE_SLIDER_VAR = 0.75
FLOAT LOCKPICK_HARD_SLIDER_VAR = 3.75
FLOAT LOCKPICKDUR_HARD_SLIDER_VAR = 0.5
FLOAT LOCKPICK_VHARD_SLIDER_VAR = 1.875
FLOAT LOCKPICKDUR_VHARD_SLIDER_VAR = 0.25
FLOAT ALCHEMYMAG_MULT_SLIDER_VAR = 4.0
FLOAT ALCHEMYMAG_SCALE_SLIDER_VAR = 1.5
FLOAT BONUS_INGR_SLIDER_VAR = 0.0
FLOAT BONUS_POTION_SLIDER_VAR = 0.0
FLOAT CHARGECOST_POWER_SLIDER_VAR = 1.1
FLOAT ENCHANT_SCALING_SLIDER_VAR = 1.25
FLOAT CHARGECOST_MULT_SLIDER_VAR = 3.0
FLOAT ENCHANTPRICE_EFFECT_SLIDER_VAR = 8.0
FLOAT CHARGECOST_BASE_SLIDER_VAR = 0.005
FLOAT ENCHANTPRICE_SOUL_SLIDER_VAR = 0.12
FLOAT ENCHANT_CHARGE_SLIDER_VAR = 100.0
FLOAT ENCHANT_MAG_SLIDER_VAR = 100.0
FLOAT BONUS_ENCHANT_SLIDER_VAR = 0.0
FLOAT TEMPER_SUFFIX_SLIDER_VAR = 0.5825
FLOAT TEMPER_ARMOR_SLIDER_VAR = 10.0
FLOAT TEMPER_WEAPON_SLIDER_VAR = 10.0
FLOAT POTION_MAG_SLIDER_VAR = 1.0
FLOAT POTION_DUR_SLIDER_VAR = 1.0
FLOAT POTION_SCALEMAG_SLIDER_VAR = 100.0
FLOAT POTION_SCALEDUR_SLIDER_VAR = 100.0
FLOAT POISON_MAG_SLIDER_VAR = 1.0
FLOAT POISON_DUR_SLIDER_VAR = 1.0
FLOAT POISON_SCALEMAG_SLIDER_VAR = 100.0
FLOAT POISON_SCALEDUR_SLIDER_VAR = 100.0
FLOAT SCROLL_MAG_SLIDER_VAR = 1.0
FLOAT SCROLL_DUR_SLIDER_VAR = 1.0
FLOAT BARTER_BUYMIN_SLIDER_VAR = 1.05
FLOAT BARTER_SELLMAX_SLIDER_VAR = 0.95
FLOAT BARTER_MIN_SLIDER_VAR = 2.0
FLOAT BARTER_MAX_SLIDER_VAR = 3.3
FLOAT BUY_PRICE_SLIDER_VAR = 100.0
FLOAT SELL_PRICE_SLIDER_VAR = 100.0
INT VENDOR_RESPAWN_SLIDER_VAR = 2
INT TRAINING_NUMALLOWED_SLIDER_VAR = 5
INT TRAINING_JOURNEYMANCOST_SLIDER_VAR = 1
INT TRAINING_JOURNEYMANSKILL_SLIDER_VAR = 50
INT TRAINING_EXPERTCOST_SLIDER_VAR = 3
INT TRAINING_EXPERTSKILL_SLIDER_VAR = 75
INT TRAINING_MASTERCOST_SLIDER_VAR = 5
INT TRAINING_MASTERSKILL_SLIDER_VAR = 90
INT APOTHECARY_GOLD_SLIDER_VAR = 500
INT BLACKSMITH_GOLD_SLIDER_VAR = 1000
INT ORCBLACKSMITH_GOLD_SLIDER_VAR = 400
INT TOWNBLACKSMITH_GOLD_SLIDER_VAR = 500
INT INNKEERPER_GOLD_SLIDER_VAR = 100
INT MISCMERCHANT_GOLD_SLIDER_VAR = 750
INT SPELLMERCHANT_GOLD_SLIDER_VAR = 500
INT STREETVENDOR_GOLD_SLIDER_VAR = 50
FLOAT COMBAT_STAMINAREGEN_SLIDER_VAR = 0.35
FLOAT DAMAGESTAMINA_DELAY_SLIDER_VAR = 0.5
FLOAT BOWZOOM_REGENDELAY_SLIDER_VAR = 3.0
FLOAT COMBAT_MAGICKAREGEN_SLIDER_VAR = 0.33
FLOAT STAMINA_REGENDELAY_SLIDER_VAR = 5.0
FLOAT DAMAGEMAGICKA_DELAY_SLIDER_VAR = 0.5
FLOAT MAGICKA_REGENDELAY_SLIDER_VAR = 5.0
FLOAT AV_HEALRATE_SLIDER_VAR = 0.0
FLOAT AV_MAGICKARATE_SLIDER_VAR = 0.0
FLOAT AV_STAMINARATE_SLIDER_VAR = 0.0
FLOAT AV_CARRYWEIGHT_SLIDER_VAR = 300.0
FLOAT AV_SPEEDMULT_SLIDER_VAR = 100.0
FLOAT AV_UNARMEDDAMAGE_SLIDER_VAR = 4.0
FLOAT AV_MASS_SLIDER_VAR = 1.0
FLOAT AV_CRITCHANCE_SLIDER_VAR = 0.0
FLOAT AV_BOWSPEEDBONUSVAR_SLIDER_VAR = 1.0
INT TIME_SCALE_SLIDER_VAR = 20
FLOAT FALLHEIGHT_MINNPC_SLIDER_VAR = 450.0
FLOAT FALLHEIGHT_MIN_SLIDER_VAR = 600.0
FLOAT FALLHEIGHT_MULTNPC_SLIDER_VAR = 0.1
FLOAT FALLHEIGHT_MULT_SLIDER_VAR = 0.1
FLOAT FALLHEIGHT_EXPNPC_SLIDER_VAR = 1.65
FLOAT FALLHEIGHT_EXP_SLIDER_VAR = 1.45
FLOAT JUMP_HEIGHT_SLIDER_VAR = 76.0
FLOAT SWIM_BREATHBASE_SLIDER_VAR = 10.0
FLOAT SWIM_BREATHDAMAGE_SLIDER_VAR = 0.08
FLOAT SWIM_BREATHMULT_SLIDER_VAR = 0.2
FLOAT KILLCAM_CHANCE_SLIDER_VAR = 1.0
FLOAT DEATHCAMERA_TIME_SLIDER_VAR = 5.0
FLOAT KILLMOVE_CHANCE_SLIDER_VAR = 50.0
FLOAT DECAPITATION_CHANCE_SLIDER_VAR = 40.0
FLOAT SPRINT_DRAINBASE_SLIDER_VAR = 7.0
FLOAT SPRINT_DRAINMULT_SLIDER_VAR = 0.02
INT ARROW_RECOVERY_SLIDER_VAR = 33
INT DEATH_DROPCHANCE_SLIDER_VAR = 100
FLOAT CAMERA_SHAKETIME_SLIDER_VAR = 1.25
FLOAT FASTRAVEL_SPEED_SLIDER_VAR = 1.0
FLOAT HUDCOMPASS_DISTANEC_SLIDER_VAR = 20000.0
INT ATTACHED_ARROWS_SLIDER_VAR = 3
Int LightRadius_VAR = 512
Int LightDuration_VAR = 240
INT SPECIAL_LOOT_SLIDER_VAR = 90
FLOAT FRIENDHIT_TIMER_SLIDER_VAR = 10.0
FLOAT FRIENDHIT_INTERVAL_SLIDER_VAR = 0.5
INT FRIENDHIT_COMBAT_SLIDER_VAR = 3
INT FRIENDHIT_NONCOMBAT_SLIDER_VAR = 0
INT ALLYHIT_COMBAT_SLIDER_VAR = 1000
INT ALLYHIT_NONCOMBAT_SLIDER_VAR = 3
FLOAT COMBAT_DODGECHANCE_SLIDER_VAR = 1.0
FLOAT COMBAT_AIMOFFSET_SLIDER_VAR = 16.0
FLOAT COMBAT_FLEEHEALTH_SLIDER_VAR = 20.0
FLOAT DIALOGUE_PADDING_SLIDER_VAR = 0.5
FLOAT DIALOGUE_DISTANCE_SLIDER_VAR = 150.0
FLOAT FOLLOWER_SPACING_SLIDER_VAR = 192.0
FLOAT FOLLOWER_CATCHUP_SLIDER_VAR = 0.2
FLOAT LEVELSCALING_MULT_SLIDER_VAR = 1.0
FLOAT LEVELEDACTOR_EASY_SLIDER_VAR = 0.33
FLOAT LEVELEDACTOR_HARD_SLIDER_VAR = 1.0
FLOAT LEVELEDACTOR_MEDIUM_SLIDER_VAR = 0.67
FLOAT LEVELEDACTOR_VHARD_SLIDER_VAR = 1.25
INT RESPAWN_TIME_SLIDER_VAR = 240
FLOAT NPC_HEALTHBONUS_SLIDER_VAR = 5.0
INT LEVELUP_ATTRIBUTE_SLIDER_VAR = 10
FLOAT LEVELUP_CARRYWEIGHT_SLIDER_VAR = 5.0
FLOAT LEGENDARYRESET_LEVEL_SLIDER_VAR = 15.0
FLOAT LEVELUP_POWER_SLIDER_VAR = 1.95
FLOAT LEVELUP_BASE_SLIDER_VAR = 75.0
FLOAT LEVELUP_MULT_SLIDER_VAR = 25.0
FLOAT SKILLUSE_ALCHEMY_SLIDER_VAR = 0.75
FLOAT SKILLUSE_ALTERATION_SLIDER_VAR = 3.0
FLOAT SKILLUSE_BLOCK_SLIDER_VAR = 8.1
FLOAT SKILLUSE_CONJURATION_SLIDER_VAR = 2.1
FLOAT SKILLUSE_DESTRUCTION_SLIDER_VAR = 1.35
FLOAT SKILLUSE_ENCHANTING_SLIDER_VAR = 900.0
FLOAT SKILLUSE_HEAVYARMOR_SLIDER_VAR = 3.8
FLOAT SKILLUSE_ILLUSION_SLIDER_VAR = 4.6
FLOAT SKILLUSE_LIGHTARMOR_SLIDER_VAR = 4.0
FLOAT SKILLUSE_LOCKPICKING_SLIDER_VAR = 45.0
FLOAT SKILLUSE_MARKSMAN_SLIDER_VAR = 9.3
FLOAT SKILLUSE_ONEHANDED_SLIDER_VAR = 6.3
FLOAT SKILLUSE_PICKPOCKET_SLIDER_VAR = 8.1
FLOAT SKILLUSE_RESTORATION_SLIDER_VAR = 2.0
FLOAT SKILLUSE_SMITHING_SLIDER_VAR = 1.0
FLOAT SKILLUSE_SNEAK_SLIDER_VAR = 11.25
FLOAT SKILLUSE_SPEECHCRAFT_SLIDER_VAR = 0.36
FLOAT SKILLUSE_TWOHAND_SLIDER_VAR = 5.95
FLOAT RFORCE_MIN_SLIDER_VAR = 10.0
FLOAT RFORCE_MAX_SLIDER_VAR = 30.0
FLOAT MFORCE_MIN_SLIDER_VAR = 4.0
FLOAT MFORCE_MAX_SLIDER_VAR = 12.0
FLOAT SFORCE_SLIDER_VAR = 2.0
FLOAT GFORCE_SLIDER_VAR = 100.0
FLOAT FIRST_FOV_SLIDER_VAR = 65.0
FLOAT THIRD_FOV_SLIDER_VAR = 65.0
FLOAT XSENSITIVITY_SLIDER_VAR = 0.02
FLOAT YSENSITIVITY_SLIDER_VAR = 0.85
FLOAT COMBAT_SHOULDERY_SLIDER_VAR = -100.0
FLOAT COMBAT_SHOULDERZ_SLIDER_VAR = 20.0
FLOAT COMBAT_SHOULDERX_SLIDER_VAR = 0.0
FLOAT SHOULDERZ_SLIDER_VAR = -10.0
FLOAT SHOULDERX_SLIDER_VAR = 30.0
INT AUTOSAVE_COUNT_SLIDER_VAR = 3
BOOL SHOWCOMPASS_TOGGLE_VAR = true
BOOL DEPTHFIELD_TOGGLE_VAR = true
BOOL HAVOK_HIT_TOGGLE_VAR = false
FLOAT HAVOK_HIT_SLIDER_VAR = 50.0
BOOL SHOW_TUTORIAL_TOGGLE_VAR = true
FLOAT BOOK_SPEED_SLIDER_VAR = 1000.0
FLOAT FIRST_ARROWTILT_SLIDER_VAR = 2.0
FLOAT THIRD_ARROWTILT_SLIDER_VAR = 2.5
FLOAT FIRST_BOLTTILT_SLIDER_VAR = 2.0
BOOL NPC_USEAMMO_TOGGLE_VAR = false
FLOAT NAVMESH_DISTANCE_SLIDER_VAR = 4096.0
FLOAT FRICTION_LAND_SLIDER_VAR = 2.5
BOOL TREE_ANIMATION_TOGGLE_VAR = true
BOOL GORE_TOGGLE_VAR = false
INT CONSOLE_TEXT_SLIDER_VAR = 20
INT CONSOLE_PERCENT_SLIDER_VAR = 40
FLOAT MAP_YAW_SLIDER_VAR = 80.0
FLOAT MAP_PITCH_SLIDER_VAR = 75.0
BOOL VATS_TOGGLE_VAR = false
BOOL ALWAYS_ACTIVE_TOGGLE_VAR = false
BOOL ESSENTIAL_NPC_TOGGLE_VAR = true
BOOL LEGENDARY_BONUS_TOGGLE_VAR = false
FLOAT GBT_legendaryBonus_Float = 5.0
BOOL ARROW_FAMINE_TOGGLE_VAR = false
FLOAT GBT_arrowFamine_Float = 3.0
BOOL SNEAK_FATIGUE_TOGGLE_VAR = false
FLOAT GBT_sneakFatigue_Float = 3.0
BOOL TIMED_BLOCK_TOGGLE_VAR = false
FLOAT GBT_timeBlockWeapon_Float = 0.3
FLOAT GBT_timeBlockShield_Float = 0.5
FLOAT GBT_timeBlockReflect_Float = 0.0
FLOAT GBT_timeBlockWard_Float = 0.3
FLOAT GBT_timeBlockDamage_Float = 40.0
FLOAT GBT_timeBlockXP_Float = 5.0
BOOL ITEM_LIMITER_TOGGLE_VAR = false
INT GBT_limitLockpick_Int = 0
INT GBT_limitArrow_Int = 0
INT GBT_limitPotion_Int = 0
INT GBT_limitPoison_Int = 0
BOOL PLAYER_STAGGER_TOGGLE_VAR = false
FLOAT GBT_staggerTaken_Float = 1.0
FLOAT GBT_staggerImmunity_Float = 0.5
FLOAT GBT_staggerArmor_Float = 35.0
FLOAT GBT_staggerMagicka_Float = 200.0
FLOAT GBT_staggerMin_Float = 0.25
FLOAT GBT_staggerMax_Float = 3.0
BOOL NPC_STAGGER_TOGGLE_VAR = false
FLOAT GBT_MeleeStaggerMult_Float = 0.35
FLOAT GBT_MeleeStaggerBase_Float = 0.0
FLOAT GBT_MeleeStaggerWeight_Float = 35.0
FLOAT GBT_MeleeStaggerCD_Float = 3.5
BOOL BLEEDOUT_TOGGLE_VAR = false
FLOAT GBT_bleedoutBase_Float = 0.25
INT GBT_bleedoutMult_Int = 75
INT GBT_bleedoutLivesMax_Int = 3
BOOL ARMOR_CMBEXP_TOGGLE_VAR = false
FLOAT GBT_ArmorExp_Float = 25.0
FLOAT GBT_BlockExp_Float = 100.0
STRING FissFilename = "SkyTweak"
BOOL SliderModeVar = true
BOOL needReimport = true
BOOL isRegistered = false
BOOL ShowMessages = true
INT saveHotkey = -1
INT isQuickSave = 0
INT quickSaveIndex = 0
int TEMPER_SCALE_TOGGLE
int SHOUT_SCALE_SLIDER
int CRIT_SCALE_TOGGLE
int BLEED_SCALE_TOGGLE
int STAMINACOST_SCALE_TOGGLE
int ILLTARGLVL_SCALE_TOGGLE
int FRIENDLY_DAMAGE_TOGGLE
int TRAP_MAGNITUDE_SLIDER
int FRIENDLY_STAGGER_TOGGLE
int WEREDMG_DEALT_SLIDER
int WEREDMG_TAKEN_SLIDER
int POISON_DOSE_SLIDER
int DUALCAST_POWER_SLIDER
int DUALCAST_COST_SLIDER
int MAGICCOST_SCALE_SLIDER
int MAGIC_COST_SLIDER
int NPCMAGICCOST_SCALE_SLIDER
int NPCMAGIC_COST_SLIDER
int MAX_RUNES_SLIDER
int MAX_SUMMONED_SLIDER
int TELEKIN_DAMAGE_SLIDER
int TELEKIN_DUALMULT_SLIDER
int ALTMAG_SCALE_SLIDER
int CONJMAG_SCALE_SLIDER
int ALTDURNOTPARA_SCALE_SLIDER
int CONJDUR_SCALE_SLIDER
int ALTCOST_SCALE_SLIDER
int CONJCOST_SCALE_SLIDER
int ALTDURPARA_SCALE_SLIDER
int BOUNTMELEE_SCALE_SLIDER
int ALTCOSTDET_SCALE_SLIDER
int BOUNDBOW_SCALE_SLIDER
int DESMAG_SCALE_SLIDER
int HEALMAG_SCALE_SLIDER
int DESDUR_SCALE_SLIDER
int HEALDUR_SCALE_SLIDER
int DESCOST_SCALE_SLIDER
int HEALCOST_SCALE_SLIDER
int ILLMAG_SCALE_SLIDER
int NONHEALMAG_SCALE_SLIDER
int ILLDUR_SCALE_SLIDER
int NONHEALDUR_SCALE_SLIDER
int ILLCOST_SCALE_SLIDER
int NONHEALCOST_SCALE_SLIDER
int LESSERPOWER_COOLDOWN_SLIDER
int DAMAGEDEALTSCALE_OID
int DAMAGETAKENSCALE_OID
int DAMAGEDEALT_NOVICE_SLIDER
int DAMAGETAKEN_NOVICE_SLIDER
int DAMAGEDEALT_APPRENTICE_SLIDER
int DAMAGETAKEN_APPRENTICE_SLIDER
int DAMAGEDEALT_ADEPT_SLIDER
int DAMAGETAKEN_ADEPT_SLIDER
int DAMAGEDEALT_EXPERT_SLIDER
int DAMAGETAKEN_EXPERT_SLIDER
int DAMAGEDEALT_MASTER_SLIDER
int DAMAGETAKEN_MASTER_SLIDER
int DAMAGEDEALT_LEGENDARY_SLIDER
int DAMAGETAKEN_LEGENDARY_SLIDER
int WEAPONSCALE_PCMIN_SLIDER
int WEAPONSCALE_PCMAX_SLIDER
int WEAPONSCALE_NPCMIN_SLIDER
int WEAPONSCALE_NPCMAX_SLIDER
int ARMOR_SCALE_SLIDER
int MAX_RESISTANCE_SLIDER
int ARMOR_BASERESIST_SLIDER
int ARMOR_MAXRESIST_SLIDER
int PC_ARMORRATING_SLIDER
int NPC_ARMORRATING_SLIDER
int ENCUM_EFFECT_SLIDER
int ENCUMWEAP_EFFECT_SLIDER
int WEAPONDAMAGE_MULT_SLIDER
int TWOHAND_ATKSPD_SLIDER
int AUTOAIM_AREA_SLIDER
int AUTOAIM_RANGE_SLIDER
int AUTOAIM_DEGREES_SLIDER
int AUTOAIM_DEGREESTHIRD_SLIDER
int STAMINA_POWERCOST_SLIDER
int STAMINA_BLOCKCOSTMULT_SLIDER
int STAMINA_BASHCOST_SLIDER
int STAMINA_POWERBASHCOST_SLIDER
int STAMINA_BLOCKCOSTBASE_SLIDER
int BLOCK_SHIELD_SLIDER
int BLOCK_WEAPON_SLIDER
int WEAPON_REACH_SLIDER
int BASH_REACH_SLIDER
int AISEARCH_TIME_SLIDER
int AISEARCH_TIMEATTACKED_SLIDER
int SNEAKLEVEL_BASE_SLIDER
int SNEAKDETECTION_SCALE_SLIDER
int DETECTION_FOV_SLIDER
int SNEAK_BASE_SLIDER
int DETECTION_LIGHT_SLIDER
int DETECTION_LIGHTEXT_SLIDER
int DETECTION_SOUND_SLIDER
int DETECTION_SOUNDLOS_SLIDER
int PICKPOCKET_MAXCHANCE_SLIDER
int PICKPOCKET_MINCHANCE_SLIDER
int SNEAKMULT_MARKSMAN_SLIDER
int SNEAKMULT_DAGGER_SLIDER
int SNEAKMULT_TWOHAND_SLIDER
int SNEAKMULT_ONEHAND_SLIDER
int SNEAKMULT_UNARMED_SLIDER
int SNEAKMULT_RUNE_SLIDER
int SNEAKMULT_SEARCH_SLIDER
int SNEAKMULT_SPELLMAG_SLIDER
int SNEAKMULT_SPELLSEARCH_SLIDER
int SNEAKMULT_SPELLDUR_SLIDER
int SNEAKSCALE_PHYSICAL_SLIDER
int SNEAKSCALE_SPELLMAG_SLIDER
int SNEAKMULT_POISONMAG_SLIDER
int SNEAKMULT_POISONDUR_SLIDER
int SNEAKSCALE_POISONMAG_SLIDER
int SNEAKSCALE_POISONDUR_SLIDER
int LOCKPICK_VEASY_SLIDER
int LOCKPICKDUR_VEASY_SLIDER
int LOCKPICK_EASY_SLIDER
int LOCKPICKDUR_EASY_SLIDER
int LOCKPICK_AVERAGE_SLIDER
int LOCKPICKDUR_AVERAGE_SLIDER
int LOCKPICK_HARD_SLIDER
int LOCKPICKDUR_HARD_SLIDER
int LOCKPICK_VHARD_SLIDER
int LOCKPICKDUR_VHARD_SLIDER
int ALCHEMYMAG_MULT_SLIDER
int ALCHEMYMAG_SCALE_SLIDER
int BONUS_INGR_SLIDER
int BONUS_POTION_SLIDER
int CHARGECOST_POWER_SLIDER
int ENCHANT_SCALING_SLIDER
int CHARGECOST_MULT_SLIDER
int ENCHANTPRICE_EFFECT_SLIDER
int CHARGECOST_BASE_SLIDER
int ENCHANTPRICE_SOUL_SLIDER
int ENCHANT_CHARGE_SLIDER
int ENCHANT_MAG_SLIDER
int BONUS_ENCHANT_SLIDER
int TEMPER_SUFFIX_SLIDER
int TEMPER_ARMOR_SLIDER
int TEMPER_WEAPON_SLIDER
int POTION_MAG_SLIDER
int POTION_DUR_SLIDER
int POTION_SCALEMAG_SLIDER
int POTION_SCALEDUR_SLIDER
int POISON_MAG_SLIDER
int POISON_DUR_SLIDER
int POISON_SCALEMAG_SLIDER
int POISON_SCALEDUR_SLIDER
int SCROLL_MAG_SLIDER
int SCROLL_DUR_SLIDER
int BARTER_BUYMIN_SLIDER
int BARTER_SELLMAX_SLIDER
int BARTER_MIN_SLIDER
int BARTER_MAX_SLIDER
int BUY_PRICE_SLIDER
int SELL_PRICE_SLIDER
int VENDOR_RESPAWN_SLIDER
int TRAINING_NUMALLOWED_SLIDER
int TRAINING_JOURNEYMANCOST_SLIDER
int TRAINING_JOURNEYMANSKILL_SLIDER
int TRAINING_EXPERTCOST_SLIDER
int TRAINING_EXPERTSKILL_SLIDER
int TRAINING_MASTERCOST_SLIDER
int TRAINING_MASTERSKILL_SLIDER
int APOTHECARY_GOLD_SLIDER
int BLACKSMITH_GOLD_SLIDER
int ORCBLACKSMITH_GOLD_SLIDER
int TOWNBLACKSMITH_GOLD_SLIDER
int INNKEERPER_GOLD_SLIDER
int MISCMERCHANT_GOLD_SLIDER
int SPELLMERCHANT_GOLD_SLIDER
int STREETVENDOR_GOLD_SLIDER
int COMBAT_STAMINAREGEN_SLIDER
int AV_COMBATHEALTHREGENMULT_SLIDER
int DAMAGESTAMINA_DELAY_SLIDER
int BOWZOOM_REGENDELAY_SLIDER
int COMBAT_MAGICKAREGEN_SLIDER
int STAMINA_REGENDELAY_SLIDER
int DAMAGEMAGICKA_DELAY_SLIDER
int MAGICKA_REGENDELAY_SLIDER
int AV_HEALRATEMULT_SLIDER
int AV_HEALRATE_SLIDER
int AV_MAGICKARATEMULT_SLIDER
int AV_MAGICKARATE_SLIDER
int AV_STAMINARATEMULT_SLIDER
int AV_STAMINARATE_SLIDER
int AV_HEALTH_SLIDER
int AV_MAGICKA_SLIDER
int AV_STAMINA_SLIDER
int AV_DRAGONSOULS_SLIDER
int AV_SHOUTRECOVERYMULT_SLIDER
int AV_CARRYWEIGHT_SLIDER
int AV_SPEEDMULT_SLIDER
int AV_UNARMEDDAMAGE_SLIDER
int AV_MASS_SLIDER
int AV_CRITCHANCE_SLIDER
int AV_ALTERATIONPOWERMOD_SLIDER
int AV_CONJURATIONPOWERMOD_SLIDER
int AV_DESTRUCTIONPOWERMOD_SLIDER
int AV_ILLUSIONPOWERMOD_SLIDER
int AV_RESTORATIONPOWERMOD_SLIDER
int AV_BOWSTAGGERBONUS_SLIDER
int AV_BOWSPEEDBONUSVAR_SLIDER
int AV_LEFTWEAPONSPEEDMULT_SLIDER
int AV_WEAPONSPEEDMULT_SLIDER
int AV_MAGICRESIST_SLIDER
int AV_FIRERESIST_SLIDER
int AV_POISONRESIST_SLIDER
int AV_ELECTRICRESIST_SLIDER
int AV_DISEASERESIST_SLIDER
int AV_FROSTRESIST_SLIDER
int PERK_POINTS_SLIDER
int TIME_SCALE_SLIDER
int FALLHEIGHT_MINNPC_SLIDER
int FALLHEIGHT_MIN_SLIDER
int FALLHEIGHT_MULTNPC_SLIDER
int FALLHEIGHT_MULT_SLIDER
int FALLHEIGHT_EXPNPC_SLIDER
int FALLHEIGHT_EXP_SLIDER
int JUMP_HEIGHT_SLIDER
int SWIM_BREATHBASE_SLIDER
int SWIM_BREATHDAMAGE_SLIDER
int SWIM_BREATHMULT_SLIDER
int KILLCAM_CHANCE_SLIDER
int DEATHCAMERA_TIME_SLIDER
int KILLMOVE_CHANCE_SLIDER
int DECAPITATION_CHANCE_SLIDER
int SPRINT_DRAINBASE_SLIDER
int SPRINT_DRAINMULT_SLIDER
int ARROW_RECOVERY_SLIDER
int DEATH_DROPCHANCE_SLIDER
int CAMERA_SHAKETIME_SLIDER
int FASTRAVEL_SPEED_SLIDER
int HUDCOMPASS_DISTANEC_SLIDER
int ATTACHED_ARROWS_SLIDER
int LightRadius_OID
int LightDuration_OID
int SPECIAL_LOOT_SLIDER
int FRIENDHIT_TIMER_SLIDER
int FRIENDHIT_INTERVAL_SLIDER
int FRIENDHIT_COMBAT_SLIDER
int FRIENDHIT_NONCOMBAT_SLIDER
int ALLYHIT_COMBAT_SLIDER
int ALLYHIT_NONCOMBAT_SLIDER
int COMBAT_DODGECHANCE_SLIDER
int COMBAT_AIMOFFSET_SLIDER
int COMBAT_FLEEHEALTH_SLIDER
int DIALOGUE_PADDING_SLIDER
int DIALOGUE_DISTANCE_SLIDER
int FOLLOWER_SPACING_SLIDER
int FOLLOWER_CATCHUP_SLIDER
int LEVELSCALING_MULT_SLIDER
int LEVELEDACTOR_EASY_SLIDER
int LEVELEDACTOR_HARD_SLIDER
int LEVELEDACTOR_MEDIUM_SLIDER
int LEVELEDACTOR_VHARD_SLIDER
int RESPAWN_TIME_SLIDER
int NPC_HEALTHBONUS_SLIDER
int LEVELUP_ATTRIBUTE_SLIDER
int LEVELUP_CARRYWEIGHT_SLIDER
int LEGENDARYRESET_LEVEL_SLIDER
int LEVELUP_POWER_SLIDER
int LEVELUP_BASE_SLIDER
int LEVELUP_MULT_SLIDER
int SKILLUSE_ALCHEMY_SLIDER
int SKILLUSE_ALTERATION_SLIDER
int SKILLUSE_BLOCK_SLIDER
int SKILLUSE_CONJURATION_SLIDER
int SKILLUSE_DESTRUCTION_SLIDER
int SKILLUSE_ENCHANTING_SLIDER
int SKILLUSE_HEAVYARMOR_SLIDER
int SKILLUSE_ILLUSION_SLIDER
int SKILLUSE_LIGHTARMOR_SLIDER
int SKILLUSE_LOCKPICKING_SLIDER
int SKILLUSE_MARKSMAN_SLIDER
int SKILLUSE_ONEHANDED_SLIDER
int SKILLUSE_PICKPOCKET_SLIDER
int SKILLUSE_RESTORATION_SLIDER
int SKILLUSE_SMITHING_SLIDER
int SKILLUSE_SNEAK_SLIDER
int SKILLUSE_SPEECHCRAFT_SLIDER
int SKILLUSE_TWOHAND_SLIDER
int RFORCE_MIN_SLIDER
int RFORCE_MAX_SLIDER
int MFORCE_MIN_SLIDER
int MFORCE_MAX_SLIDER
int SFORCE_SLIDER
int GFORCE_SLIDER
int FIRST_FOV_SLIDER
int THIRD_FOV_SLIDER
int XSENSITIVITY_SLIDER
int YSENSITIVITY_SLIDER
int COMBAT_SHOULDERY_SLIDER
int COMBAT_SHOULDERZ_SLIDER
int COMBAT_SHOULDERX_SLIDER
int SHOULDERZ_SLIDER
int SHOULDERX_SLIDER
int AUTOSAVE_COUNT_SLIDER
int SHOWCOMPASS_TOGGLE
int DEPTHFIELD_TOGGLE
int HAVOK_HIT_TOGGLE
int HAVOK_HIT_SLIDER
int SHOW_TUTORIAL_TOGGLE
int BOOK_SPEED_SLIDER
int FIRST_ARROWTILT_SLIDER
int THIRD_ARROWTILT_SLIDER
int FIRST_BOLTTILT_SLIDER
int NPC_USEAMMO_TOGGLE
int NAVMESH_DISTANCE_SLIDER
int FRICTION_LAND_SLIDER
int TREE_ANIMATION_TOGGLE
int GORE_TOGGLE
int CONSOLE_TEXT_SLIDER
int CONSOLE_PERCENT_SLIDER
int MAP_YAW_SLIDER
int MAP_PITCH_SLIDER
int VATS_TOGGLE
int ALWAYS_ACTIVE_TOGGLE
int ESSENTIAL_NPC_TOGGLE
int LEGENDARY_BONUS_TOGGLE
int LEGENDARY_BONUS_SLIDER
int ARROW_FAMINE_TOGGLE
int ARROW_FAMINE_SLIDER
int SNEAK_FATIGUE_TOGGLE
int SNEAK_FATIGUE_SLIDER
int TIMED_BLOCK_TOGGLE
int TIMEDBLOCK_WEAPON_SLIDER
int TIMEDBLOCK_SHIELD_SLIDER
int TIMEDBLOCK_REFLECTTIME_SLIDER
int TIMEDBLOCK_REFLECTWARD_SLIDER
int TIMEDBLOCK_REFLECTDMG_SLIDER
int TIMEDBLOCK_EXP_SLIDER
int ITEM_LIMITER_TOGGLE
int ITEMLIMITER_LOCKPICK_SLIDER
int ITEMLIMITER_ARROW_SLIDER
int ITEMLIMITER_POTION_SLIDER
int ITEMLIMITER_POISON_SLIDER
int PLAYER_STAGGER_TOGGLE
int PLAYERSTAGGER_BASEDUR_SLIDER
int PLAYERSTAGGER_IMMUNITY_SLIDER
int PLAYERSTAGGER_ARMORWEIGHT_SLIDER
int PLAYERSTAGGER_MAGICKACOST_SLIDER
int PLAYERSTAGGER_MINTHRESH_SLIDER
int PLAYERSTAGGER_MAXTHRESH_SLIDER
int NPC_STAGGER_TOGGLE
int NPCSTAGGER_MULT_SLIDER
int NPCSTAGGER_BASE_SLIDER
int NPCSTAGGER_ARMORWEIGHT_SLIDER
int NPCSTAGGER_IMMUNITY_SLIDER
int BLEEDOUT_TOGGLE
int BLEEDOUT_LOSSBASE_SLIDER
int BLEEDOUT_LOSSMULT_SLIDER
int BLEEDOUT_MAXLIVES_SLIDER
int ARMOR_CMBEXP_TOGGLE
int ARMOR_CMBEXP_SLIDER
int BLOCK_CMBEXP_SLIDER
int INFO1_TEXT
int INFO2_TEXT
int INFO3_TEXT
int INFO4_TEXT
int INFO5_TEXT
int INFO6_TEXT
int LOADFROMFISS_OID
int SAVETOFISS_OID
int FISSFILENAME_OID
int SAVELOCAL_OID
int EXITGAME_OID
int SLIDERMODE_OID
int REIMPORT_OID
INT REGISTERSAVEKEY_OID
INT SHOWMESSAGE_OID
INT SAVEHOTKEY_OID
INT QUICKSAVE_OID
int CREDITS_TEXT
