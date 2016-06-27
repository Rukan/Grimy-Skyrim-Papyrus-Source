scriptName GBT_Script_LegendaryBonus extends activemagiceffect

GrimyMenuMain Property GBT_Main_Menu Auto
actor property PlayerRef auto

Float alchemyBonus = 0.000000
Float lockpickingBonus = 0.000000
Float enchantingBonus = 0.000000
Float speechBonus = 0.000000
Float heavyArmorBonus = 0.000000
Float conjurationBonus = 0.000000
Float archeryBonus = 0.000000
Float lightArmorBonus = 0.000000
Float illusionBonus = 0.000000
Float pickpocketBonus = 0.000000
Float destructionBonus = 0.000000
Float restorationBonus = 0.000000
Float alterationBonus = 0.000000
Float twoHandedBonus = 0.000000
Float smithingBonus = 0.000000
Float oneHandedBonus = 0.000000
Float sneakBonus = 0.000000
Float blockBonus = 0.000000

Event OnEffectFinish(actor akTarget, actor akCaster)
	UnregisterForMenu("TweenMenu")
	PlayerRef.SetActorValue("AlchemyPowerMod", PlayerRef.GetBaseActorValue("AlchemyPowerMod") - alchemyBonus)
	PlayerRef.SetActorValue("LightArmorPowerMod", PlayerRef.GetBaseActorValue("LightArmorPowerMod") - lightArmorBonus)
	PlayerRef.SetActorValue("LockpickingPowerMod", PlayerRef.GetBaseActorValue("LockpickingPowerMod") - lockpickingBonus)
	PlayerRef.SetActorValue("PickPocketPowerMod", PlayerRef.GetBaseActorValue("PickPocketPowerMod") - pickpocketBonus)
	PlayerRef.SetActorValue("SneakPowerMod", PlayerRef.GetBaseActorValue("SneakPowerMod") - sneakBonus)
	PlayerRef.SetActorValue("SpeechcraftPowerMod", PlayerRef.GetBaseActorValue("SpeechcraftPowerMod") - speechBonus)
	PlayerRef.SetActorValue("AlterationPowerMod", PlayerRef.GetBaseActorValue("AlterationPowerMod") - alterationBonus)
	PlayerRef.SetActorValue("ConjurationPowerMod", PlayerRef.GetBaseActorValue("ConjurationPowerMod") - conjurationBonus)
	PlayerRef.SetActorValue("DestructionPowerMod", PlayerRef.GetBaseActorValue("DestructionPowerMod") - destructionBonus)
	PlayerRef.SetActorValue("EnchantingPowerMod", PlayerRef.GetBaseActorValue("EnchantingPowerMod") - enchantingBonus)
	PlayerRef.SetActorValue("IllusionPowerMod", PlayerRef.GetBaseActorValue("IllusionPowerMod") - illusionBonus)
	PlayerRef.SetActorValue("RestorationPowerMod", PlayerRef.GetBaseActorValue("RestorationPowerMod") - restorationBonus)
	PlayerRef.SetActorValue("MarksmanPowerMod", PlayerRef.GetBaseActorValue("MarksmanPowerMod") - archeryBonus)
	PlayerRef.SetActorValue("BlockPowerMod", PlayerRef.GetBaseActorValue("BlockPowerMod") - blockBonus)
	PlayerRef.SetActorValue("HeavyArmorPowerMod", PlayerRef.GetBaseActorValue("HeavyArmorPowerMod") - heavyArmorBonus)
	PlayerRef.SetActorValue("OneHandedPowerMod", PlayerRef.GetBaseActorValue("OneHandedPowerMod") - oneHandedBonus)
	PlayerRef.SetActorValue("SmithingPowerMod", PlayerRef.GetBaseActorValue("SmithingPowerMod") - smithingBonus)
	PlayerRef.SetActorValue("TwoHandedPowerMod", PlayerRef.GetBaseActorValue("TwoHandedPowerMod") - twoHandedBonus)
EndEvent

Event OnMenuClose(String MenuName)
	if MenuName == "TweenMenu"
		PlayerRef.SetActorValue("AlchemyPowerMod", PlayerRef.GetBaseActorValue("AlchemyPowerMod") - alchemyBonus + self.calcLegendaryBonus("Alchemy"))
		alchemyBonus = self.calcLegendaryBonus("Alchemy")
		PlayerRef.SetActorValue("LightArmorPowerMod", PlayerRef.GetBaseActorValue("LightArmorPowerMod") - lightArmorBonus + self.calcLegendaryBonus("LightArmor"))
		lightArmorBonus = self.calcLegendaryBonus("LightArmor")
		PlayerRef.SetActorValue("LockpickingPowerMod", PlayerRef.GetBaseActorValue("LockpickingPowerMod") - lockpickingBonus + self.calcLegendaryBonus("Lockpicking"))
		lockpickingBonus = self.calcLegendaryBonus("Lockpicking")
		PlayerRef.SetActorValue("PickPocketPowerMod", PlayerRef.GetBaseActorValue("PickPocketPowerMod") - pickpocketBonus + self.calcLegendaryBonus("Pickpocket"))
		pickpocketBonus = self.calcLegendaryBonus("Pickpocket")
		PlayerRef.SetActorValue("SneakPowerMod", PlayerRef.GetBaseActorValue("SneakPowerMod") - sneakBonus + self.calcLegendaryBonus("Sneak"))
		sneakBonus = self.calcLegendaryBonus("Sneak")
		PlayerRef.SetActorValue("SpeechcraftPowerMod", PlayerRef.GetBaseActorValue("SpeechcraftPowerMod") - speechBonus + self.calcLegendaryBonus("Speechcraft"))
		speechBonus = self.calcLegendaryBonus("Speechcraft")
		PlayerRef.SetActorValue("AlterationPowerMod", PlayerRef.GetBaseActorValue("AlterationPowerMod") - alterationBonus + self.calcLegendaryBonus("Alteration"))
		alterationBonus = self.calcLegendaryBonus("Alteration")
		PlayerRef.SetActorValue("ConjurationPowerMod", PlayerRef.GetBaseActorValue("ConjurationPowerMod") - conjurationBonus + self.calcLegendaryBonus("Conjuration"))
		conjurationBonus = self.calcLegendaryBonus("Conjuration")
		PlayerRef.SetActorValue("DestructionPowerMod", PlayerRef.GetBaseActorValue("DestructionPowerMod") - destructionBonus + self.calcLegendaryBonus("Destruction"))
		destructionBonus = self.calcLegendaryBonus("Destruction")
		PlayerRef.SetActorValue("EnchantingPowerMod", PlayerRef.GetBaseActorValue("EnchantingPowerMod") - enchantingBonus + self.calcLegendaryBonus("Enchanting"))
		enchantingBonus = self.calcLegendaryBonus("Enchanting")
		PlayerRef.SetActorValue("IllusionPowerMod", PlayerRef.GetBaseActorValue("IllusionPowerMod") - illusionBonus + self.calcLegendaryBonus("Illusion"))
		illusionBonus = self.calcLegendaryBonus("Illusion")
		PlayerRef.SetActorValue("RestorationPowerMod", PlayerRef.GetBaseActorValue("RestorationPowerMod") - restorationBonus + self.calcLegendaryBonus("Restoration"))
		restorationBonus = self.calcLegendaryBonus("Restoration")
		PlayerRef.SetActorValue("MarksmanPowerMod", PlayerRef.GetBaseActorValue("MarksmanPowerMod") - archeryBonus + self.calcLegendaryBonus("Marksman"))
		archeryBonus = self.calcLegendaryBonus("Marksman")
		PlayerRef.SetActorValue("BlockPowerMod", PlayerRef.GetBaseActorValue("BlockPowerMod") - blockBonus + self.calcLegendaryBonus("Block"))
		blockBonus = self.calcLegendaryBonus("Block")
		PlayerRef.SetActorValue("HeavyArmorPowerMod", PlayerRef.GetBaseActorValue("HeavyArmorPowerMod") - heavyArmorBonus + self.calcLegendaryBonus("HeavyArmor"))
		heavyArmorBonus = self.calcLegendaryBonus("HeavyArmor")
		PlayerRef.SetActorValue("OneHandedPowerMod", PlayerRef.GetBaseActorValue("OneHandedPowerMod") - oneHandedBonus + self.calcLegendaryBonus("OneHanded"))
		oneHandedBonus = self.calcLegendaryBonus("OneHanded")
		PlayerRef.SetActorValue("SmithingPowerMod", PlayerRef.GetBaseActorValue("SmithingPowerMod") - smithingBonus + self.calcLegendaryBonus("Smithing"))
		smithingBonus = self.calcLegendaryBonus("Smithing")
		PlayerRef.SetActorValue("TwoHandedPowerMod", PlayerRef.GetBaseActorValue("TwoHandedPowerMod") - twoHandedBonus + self.calcLegendaryBonus("TwoHanded"))
		twoHandedBonus = self.calcLegendaryBonus("TwoHanded")
	endIf
EndEvent

Float function calcLegendaryBonus(String actorValue)
	if game.GetSkillLegendaryLevel(actorValue) as Float > 0.000000
		return game.GetSkillLegendaryLevel(actorValue) as Float * GBT_Main_Menu.GetGBT_legendaryBonus_Float()
	else
		return 0.000000
	endIf
endFunction

Event OnPlayerLoadGame()
	self.RegisterForMenu("TweenMenu")
EndEvent

Event OnEffectStart(actor akTarget, actor akCaster)
	self.RegisterForMenu("TweenMenu")
EndEvent
