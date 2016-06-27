Scriptname GELO_MenuMain extends SKI_ConfigBase  

INT FUNCTION GetVersion()
	return 11
ENDFUNCTION

EVENT OnVersionUpdate(int a_version)
	refreshPages()
ENDEVENT

EVENT OnConfigInit()
	ModName = "Grimy: Enchanted Loot"
	refreshPages()
ENDEVENT

FUNCTION refreshPages()
	Pages = new string[4]
	Pages[0] = "Setup"
	Pages[1] = "Settings"
	Pages[2] = "Perks"
	Pages[3] = "Loot Injector"
ENDFUNCTION

EVENT OnPageReset(string page)
	SetCursorFillMode(LEFT_TO_RIGHT)
	IF page == "Perks"
		AddToggleOptionST("ENCHANTER01_TOGGLE", "Identification", PlayerRef.HasPerk(GrimyPerkEnch20OffenseSlot))
		AddToggleOptionST("CHAOS_TOGGLE", "Tinkerer", PlayerRef.HasPerk(GrimyPerkEnch30Tinkerer))
		AddToggleOptionST("ORDER_TOGGLE", "Warden", PlayerRef.HasPerk(GrimyPerkEnch30Warden))
		AddToggleOptionST("OVERLOAD_TOGGLE", "Overload", PlayerRef.HasPerk(GrimyPerkEnch50Overload))
		AddToggleOptionST("REFINEMENT_TOGGLE", "Refinement", PlayerRef.HasPerk(GrimyPerkEnch50Misc))
		AddToggleOptionST("BASELINE_TOGGLE", "Transcription", PlayerRef.HasPerk(GrimyPerkEnch50Transcription))
		AddToggleOptionST("EPIC_TOGGLE", "Arcane Inspiration", PlayerRef.HasPerk(GrimyPerkEnch70Epic))
		AddToggleOptionST("AMPLIFIER_TOGGLE", "Amplification", PlayerRef.HasPerk(GrimyPerkEnch70Amplifier))
		AddToggleOptionST("PERFECT_TOGGLE", "Forbidden Knowledge", PlayerRef.HasPerk(GrimyPerkEnch90Perfectionist))
	ELSEIF page == "Loot Injector"
		AddHeaderOption("Loot Injector is no longer necessary")
		AddHeaderOption("")
		AddTextOptionST("INJECT_TEXT", "Inject Loot Lists", "Go!")
		AddTextOptionST("REVERT_TEXT", "Revert Loot Lists", "Go!")
		AddSliderOptionST("LOOTLEVEL_SLIDER", "Loot Level Cap" ,lootCap,"{0}")
		AddTextOptionST("ENCHANTOPEDIA_TEXT", "Add enchantopedia to inventory", "Go!")
		AddHeaderOption("Injection Counters")
		AddHeaderOption("")
		
		addTextOptionST("HEAVY1_TEXT","HeavyArmor1 Loot List Count",LItemEnchArmorHeavyAll.GetNumForms())
		addTextOptionST("LIGHT1_TEXT","LightArmor1 Loot List Count",LItemEnchArmorLightAll.GetNumForms())
		addTextOptionST("HEAVY2_TEXT","HeavyArmor2 Loot List Count",LItemEnchArmorHeavyAllNoDragon.GetNumForms())
		addTextOptionST("LIGHT2_TEXT","LightArmor2 Loot List Count",LItemEnchArmorLightAllNoDragon.GetNumForms())
		addTextOptionST("HEAVY3_TEXT","HeavyArmor3 Loot List Count",DLC2LItemEnchArmorHeavyAll.GetNumForms())
		addTextOptionST("LIGHT3_TEXT","LightArmor3 Loot List Count",DLC2LItemEnchArmorLightAll.GetNumForms())
		
		addTextOptionST("WEAPON1_TEXT","Weapon1 Loot List Count",LItemEnchWeaponAny.GetNumForms())
		addTextOptionST("WEAPON2_TEXT","Weapon2 Loot List Count",LItemEnchWeaponAnySpecial.GetNumForms())
		addTextOptionST("WEAPON3_TEXT","Weapon3 Loot List Count",DLC2LItemEnchWeaponAny.GetNumForms())
		addTextOptionST("WEAPON4_TEXT","Weapon4 Loot List Count",DLC2LItemEnchWeaponAnyBest.GetNumForms())
		addTextOptionST("WEAPON5_TEXT","Weapon5 Loot List Count",DLC2LItemEnchWeaponAnySpecial.GetNumForms())
		addTextOptionST("WEAPON6_TEXT","Weapon6 Loot List Count",LItemEnchWeaponBlacksmithAny.GetNumForms())
		
		addTextOptionST("ROBE1_TEXT","Jewelry1 Loot List Count",LItemEnchJewelryAll.GetNumForms())
		addTextOptionST("ROBE2_TEXT","Robe1 Loot List Count",LItemEnchRobes75.GetNumForms())
		addTextOptionST("ROBE3_TEXT","Jewelry2 Loot List Count",LItemEnchJewelryAll15.GetNumForms())
		addTextOptionST("ROBE4_TEXT","Robe2 Loot List Count",LootEnchRobes15.GetNumForms())
		addTextOptionST("ROBE5_TEXT","Jewelry3 Loot List Count",LItemEnchJewelryAll75.GetNumForms())
	ELSEIF page == "Setup"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddToggleOptionST("REGISTER_INVENTORY_KEYS","Register Inventory Hotkeys",PlayerRef.HasSpell(GUISE_AB_Inventory_Hotkey))
		AddKeyMapOptionST("COMBINED_KEY_OID","GUISE Combined Inventory Key",GUISE_Hotkey_Combined.GetValueInt())
		addSliderOptionST("LOADMESSAGE_SLIDER","GUISE Loading Message Frequency", GUISE_LoadingMessages.GetValue())
	ELSE
		SetCursorFillMode(TOP_TO_BOTTOM)
		
		AddHeaderOption("Property Rolls")
		AddSliderOptionST("MAXROLL_SLIDER", "Maximum Property Roll" ,GrimyGlobal_MaxRoll.GetValue()*100.0,"{0}%")
		AddSliderOptionST("MINROLL_SLIDER", "Mininum Property Roll" ,GrimyGlobal_MinRoll.GetValue()*100.0,"{0}%")
		AddSliderOptionST("ENCHWEAPON_SLIDER", "Weapon Enchantment Magnitude" ,GrimyPerkBalanceEnchWeapons.GetNthEntryValue(0,0),"{2}")
		
		AddHeaderOption("Armor Slot Chances")
		AddSliderOptionST("CORE_SLIDER", "Armor Slot 1 Chance" ,GrimyGlobal_CoreRoll.GetValue()*100.0,"{0}%")
		AddSliderOptionST("OFFENSE_SLIDER", "Armor Slot 2 Chance" ,GrimyGlobal_OffenseRoll.GetValue()*100.0,"{0}%")
		AddSliderOptionST("DEFENSE_SLIDER", "Armor Slot 3 Chance" ,GrimyGlobal_DefenseRoll.GetValue()*100.0,"{0}%")
		AddSliderOptionST("UTILITY_SLIDER", "Armor Slot 4 Chance" ,GrimyGlobal_UtilityRoll.GetValue()*100.0,"{0}%")
		AddSliderOptionST("MISC_SLIDER", "Armor Slot 5 Chance" ,GrimyGlobal_MiscRoll.GetValue()*100.0,"{0}%")
		AddSliderOptionST("EPIC_SLIDER", "Armor Slot 6 Chance" ,GrimyGlobal_EpicRoll.GetValue()*100.0,"{0}%")
		
		AddHeaderOption("Weapon Charges")
		AddSliderOptionST("MAXCHARGE_SLIDER", "Max Charge" ,GrimyGlobal_ChargeMax.GetValue())
		AddSliderOptionST("MINCHARGE_SLIDER", "Min Charge" ,GrimyGlobal_ChargeMin.GetValue())
		AddSliderOptionST("CHARGECOST_SLIDER", "Charge Cost" ,GrimyGlobal_ChargeCost.GetValue(),"{1}")
		
		
		SetCursorPosition(1)
		
		AddHeaderOption("Experience")
		AddSliderOptionST("ENCHEXP_SLIDER", "Enchanting Experience" ,GrimyGlobal_EnchantingExp.GetValue(),"{2}")
		AddSliderOptionST("DISENCHEXP_SLIDER", "Disenchanting Expperience" ,GrimyGlobal_DisenchantingExp.GetValue(),"{2}")
		AddSliderOptionST("SOCKETEXP_SLIDER", "Socketing Experience" ,GrimyGlobal_SocketingExp.GetValue(),"{2}")

		AddHeaderOption("Weapon Slot Chances")
		AddSliderOptionST("DAMAGE_SLIDER", "Weapon Slot 1 Chance" ,GrimyGlobal_WeaponDamageRoll.GetValue()*100.0,"{0}%")
		AddSliderOptionST("ATTRIBUTE_SLIDER", "Weapon Slot 2 Chance" ,GrimyGlobal_WeaponAttributeRoll.GetValue()*100.0,"{0}%")
		AddSliderOptionST("DRAIN_SLIDER", "Weapon Slot 3 Chance" ,GrimyGlobal_WeaponDrainRoll.GetValue()*100.0,"{0}%")
		AddSliderOptionST("AMPLIFIER_SLIDER", "Weapon Slot 4 Chance" ,GrimyGlobal_AmplifierRoll.GetValue()*100.0,"{0}%")
		
		AddHeaderOption("Miscellaneous")
		AddSliderOptionST("IRREGULAR_SLIDER", "Irregular Chance" ,GrimyGlobal_Irregular.GetValue()*100.0,"{0}%")
		AddSliderOptionST("OVERLOAD_SLIDER", "Overload Chance" ,GrimyGlobal_Overload.GetValue()*100.0,"{0}%")
		AddSliderOptionST("PERFECT_SLIDER", "Perfect Chance" ,GrimyGlobal_PerfectRoll.GetValue()*100.0,"{0}%")
		AddSliderOptionST("HARVEST_SLIDER", "Harvest Chance" ,100.0 - GrimyGlobal_HarvestNone.GetValue(),"{0}%")
		AddSliderOptionST("ARCANE_SLIDER", "Soul Residue Chance" ,100.0 - GrimyGlobal_NoArcaneDust.GetValue(),"{0}%")
		AddSliderOptionST("SIGIL_SLIDER", "Sigil Stone Chance" ,100.0 - GrimyGlobal_NoSigil.GetValue(),"{0}%")
		addSliderOptionST("REFILL_SCROLL_COUNT", "Transcription Restock Count", ScrollCount)
	ENDIF
ENDEVENT

STATE REFILL_SCROLL_COUNT
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(ScrollCount)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		ScrollCount = value AS INT
		SetSliderOptionValueST(value)
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(3.0)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Number of scrolls restocked with the transcription perk.")
	ENDEVENT
ENDSTATE

SPELL PROPERTY GUISE_AB_Inventory_Hotkey AUTO
STATE REGISTER_INVENTORY_KEYS
	EVENT OnSelectST()
		IF PlayerRef.HasSpell(GUISE_AB_Inventory_Hotkey)
			PlayerRef.RemoveSpell(GUISE_AB_Inventory_Hotkey)
			SetToggleOptionValueST(false)
		ELSE
			PlayerRef.AddSpell(GUISE_AB_Inventory_Hotkey)
			SetToggleOptionValueST(true)
		ENDIF
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemoveSpell(GUISE_AB_Inventory_Hotkey)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Register your inventory hotkeys. This enables you to salvage and craft materials directly from your inventory.")
	ENDEVENT	
ENDSTATE

GLOBALVARIABLE PROPERTY GUISE_Hotkey_Combined AUTO
STATE COMBINED_KEY_OID
	EVENT OnKeyMapChangeST(int a_keyCode, string a_conflictControl, string a_conflictName)
		GUISE_Hotkey_Combined.SetValueInt(a_keyCode)
		SetKeyMapOptionValueST(a_keyCode)
	ENDEVENT

	EVENT OnDefaultST()
		GUISE_Hotkey_Combined.SetValueInt(8)
		SetKeyMapOptionValueST(8)
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("Clicking this button in your inventory opens a menu for GUISE's inventory abilities.")
	ENDEVENT	
ENDSTATE

STATE ENCHANTOPEDIA_TEXT
	EVENT OnSelectST()
		PlayerRef.AddItem(GrimyEnchantingCatalogue,1)
		ShowMessage("Enchantopedia Added")
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("Adds an encyclopedia with descriptions of all the epic enchantment properties.")
	ENDEVENT
ENDSTATE
FORM PROPERTY GrimyEnchantingCatalogue AUTO

FUNCTION RefreshInjectionCounters()
	setTextOptionValueST(LItemEnchArmorHeavyAll.GetNumForms(),true,"HEAVY1_TEXT")
	setTextOptionValueST(LItemEnchArmorLightAll.GetNumForms(),true,"LIGHT1_TEXT")
	setTextOptionValueST(LItemEnchArmorHeavyAllNoDragon.GetNumForms(),true,"HEAVY2_TEXT")
	setTextOptionValueST(LItemEnchArmorLightAllNoDragon.GetNumForms(),true,"LIGHT2_TEXT")
	setTextOptionValueST(DLC2LItemEnchArmorHeavyAll.GetNumForms(),true,"HEAVY3_TEXT")
	setTextOptionValueST(DLC2LItemEnchArmorLightAll.GetNumForms(),true,"LIGHT3_TEXT")
	
	setTextOptionValueST(LItemEnchWeaponAny.GetNumForms(),true,"WEAPON1_TEXT")
	setTextOptionValueST(LItemEnchWeaponAnySpecial.GetNumForms(),true,"WEAPON2_TEXT")
	setTextOptionValueST(DLC2LItemEnchWeaponAny.GetNumForms(),true,"WEAPON3_TEXT")
	setTextOptionValueST(DLC2LItemEnchWeaponAnyBest.GetNumForms(),true,"WEAPON4_TEXT")
	setTextOptionValueST(DLC2LItemEnchWeaponAnySpecial.GetNumForms(),true,"WEAPON5_TEXT")
	setTextOptionValueST(LItemEnchWeaponBlacksmithAny.GetNumForms(),true,"WEAPON6_TEXT")
	
	setTextOptionValueST(LItemEnchJewelryAll.GetNumForms(),true,"ROBE1_TEXT")
	setTextOptionValueST(LItemEnchRobes75.GetNumForms(),true,"ROBE2_TEXT")
	setTextOptionValueST(LItemEnchJewelryAll15.GetNumForms(),true,"ROBE3_TEXT")
	setTextOptionValueST(LootEnchRobes15.GetNumForms(),true,"ROBE4_TEXT")
	setTextOptionValueST(LItemEnchJewelryAll75.GetNumForms(),false,"ROBE5_TEXT")
ENDFUNCTION

GLOBALVARIABLE PROPERTY GUISE_LoadingMessages AUTO
STATE LOADMESSAGE_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GUISE_LoadingMessages.GetValue())
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GUISE_LoadingMessages.SetValue(value)
		SetSliderOptionValueST(value)
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(10.0)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Adjust the frequency of GUISE loading screen tips.\nProvides messages for all GUISE modules")
	ENDEVENT
ENDSTATE

STATE INJECT_TEXT
	EVENT OnSelectST()
		injectLootOnce()
		ShowMessage("Loot has been injected.\nThis will not affect loot that has already loaded into the game.\nThat loot will reset after 48 game hours though.")
		RefreshInjectionCounters()
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("Inject one set of GELO loot into general enchanted item lists.\nThis option tends to affect vendors more than dungeon loot.\nLoot mods may impact of each injection. (usually lower it if they also add new loot)")
	ENDEVENT
ENDSTATE

STATE REVERT_TEXT
	EVENT OnSelectST()
		revertLoot()
		ShowMessage("Loot has been reverted.\nThis will not affect loot that has already loaded into the game.\nThat loot will reset after 48 game hours though.")
		RefreshInjectionCounters()
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("Revert all relevant loot tables to their vanilla settings.\nThis may affect other loot mods that inject loot via script.")
	ENDEVENT
ENDSTATE

STATE ENCHWEAPON_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyPerkBalanceEnchWeapons.GetNthEntryValue(0,0))
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0,10.0)
		SetSliderDialogInterval(0.01)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyPerkBalanceEnchWeapons.SetNthEntryValue(0,0,value)
		IF value == 1.0
			PlayerRef.RemovePerk(GrimyPerkBalanceEnchWeapons)
		ELSE
			PlayerRef.AddPerk(GrimyPerkBalanceEnchWeapons)
		ENDIF
		SetSliderOptionValueST(value)
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(1.0)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Multiplier for how powerful your randomized weapon enchantments are. Retroactive.")
	ENDEVENT
ENDSTATE
PERK PROPERTY GrimyPerkBalanceEnchWeapons AUTO

STATE MAXROLL_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_MaxRoll.GetValue()*100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0,1000.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_MaxRoll.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(100.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Determines how high your properties can roll.")
	ENDEVENT
ENDSTATE

STATE MINROLL_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_MinRoll.GetValue()*100.0)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_MinRoll.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(0.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Determines how low your properties can roll.")
	ENDEVENT
ENDSTATE

STATE MAXCHARGE_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_ChargeMax.GetValue())
		SetSliderDialogDefaultValue(3000.0)
		SetSliderDialogRange(GrimyGlobal_MinRoll.GetValue(),10000.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		IF value > GrimyGlobal_ChargeMin.GetValue()
			GrimyGlobal_ChargeMax.SetValue(value)
		ENDIF
		SetSliderOptionValueST(GrimyGlobal_ChargeMax.GetValue())
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(3000.0)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Determines how high your weapon charges can roll.")
	ENDEVENT
ENDSTATE

STATE MINCHARGE_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_ChargeMin.GetValue())
		SetSliderDialogDefaultValue(250.0)
		SetSliderDialogRange(0.0,GrimyGlobal_ChargeMax.GetValue())
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		IF value < GrimyGlobal_ChargeMax.GetValue()
			GrimyGlobal_ChargeMin.SetValue(value)
		ENDIF
		SetSliderOptionValueST(GrimyGlobal_ChargeMin.GetValue())
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(250.0)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Determines how low your weapon charges can roll.")
	ENDEVENT
ENDSTATE


STATE CHARGECOST_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_ChargeCost.GetValue())
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(0.1)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_ChargeCost.SetValue(value)
		SetSliderOptionValueST(value,"{1}")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(10.0,"{1}")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("How much weapon charges are consumed when you attack.")
	ENDEVENT
ENDSTATE

STATE IRREGULAR_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_Irregular.GetValue()*100.0)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_Irregular.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(15.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Determines the probability of an item having an Irregularity\nWhich when a primary property rolls another primary property it normally cannot roll.")
	ENDEVENT
ENDSTATE

STATE OVERLOAD_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_Overload.GetValue()*100.0)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_Overload.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(0.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Determines the probability of an item having an overload\nWhich is when a primary property is doubled.\nBut another primary property is replaced with a negative property.")
	ENDEVENT
ENDSTATE

STATE PERFECT_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_PerfectRoll.GetValue()*100.0)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_PerfectRoll.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(0.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Determines the probability that any given property rolls the maximum possible.")
	ENDEVENT
ENDSTATE

STATE CORE_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_CoreRoll.GetValue()*100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_CoreRoll.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(100.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Chance to get a core property.")
	ENDEVENT
ENDSTATE

STATE OFFENSE_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_OffenseRoll.GetValue()*100.0)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_OffenseRoll.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(0.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Chance to get an offensive property.")
	ENDEVENT
ENDSTATE

STATE DEFENSE_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_DefenseRoll.GetValue()*100.0)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_DefenseRoll.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(0.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Chance to get a defensive property.")
	ENDEVENT
ENDSTATE

STATE UTILITY_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_UtilityRoll.GetValue()*100.0)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_UtilityRoll.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(0.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Chance to get a utility property.")
	ENDEVENT
ENDSTATE

STATE MISC_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_MiscRoll.GetValue()*100.0)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_MiscRoll.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(10.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Chance to get a miscellaneous property.")
	ENDEVENT
ENDSTATE

STATE EPIC_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_EpicRoll.GetValue()*100.0)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_EpicRoll.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(10.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Chance to get an epic property.")
	ENDEVENT
ENDSTATE

STATE DAMAGE_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_WeaponDamageRoll.GetValue()*100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_WeaponDamageRoll.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(100.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Determines the probability that weapons roll with an elemental damage property.")
	ENDEVENT
ENDSTATE

STATE ATTRIBUTE_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_WeaponAttributeRoll.GetValue()*100.0)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_WeaponAttributeRoll.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(0.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Determines the probability that weapons roll with an attribute damaging property.")
	ENDEVENT
ENDSTATE

STATE DRAIN_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_WeaponDrainRoll.GetValue()*100.0)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_WeaponDrainRoll.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(0.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Determines the probability that weapons roll with an attribute draining property.")
	ENDEVENT
ENDSTATE

STATE AMPLIFIER_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_AmplifierRoll.GetValue()*100.0)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_AmplifierRoll.SetValue(value/100.0)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(10.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Determines the probability that weapons roll with an amplifier property.")
	ENDEVENT
ENDSTATE

STATE HARVEST_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(100.0 - GrimyGlobal_HarvestNone.GetValue())
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_HarvestNone.SetValue(100.0 - value)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(20.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Determines the probability that the harvest enchantment takes effect.")
	ENDEVENT
ENDSTATE

STATE ARCANE_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(100.0 - GrimyGlobal_NoArcaneDust.GetValue())
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_NoArcaneDust.SetValue(100.0 - value)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(5.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Chance of looting an arcane dust from an enemy with the Soul Residue enchantment.")
	ENDEVENT
ENDSTATE

STATE SIGIL_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(100.0 - GrimyGlobal_NoSigil.GetValue())
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_NoSigil.SetValue(100.0 - value)
		SetSliderOptionValueST(value,"{0}%")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(1.0,"{0}%")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Chance of looting a sigil stone from an enemy with the Sigil Seeker enchantment.")
	ENDEVENT
ENDSTATE
		
STATE ENCHEXP_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_EnchantingExp.GetValue())
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0,10.0)
		SetSliderDialogInterval(0.01)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_EnchantingExp.SetValue(value)
		SetSliderOptionValueST(value,"{2}")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(1.0)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("How much experience you gain for enchanting or re-enchanting an item.\n Normal enchanting provides 1.0 experience per item.")
	ENDEVENT
ENDSTATE

STATE DISENCHEXP_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_DisenchantingExp.GetValue())
		SetSliderDialogDefaultValue(0.1)
		SetSliderDialogRange(0.0,10.0)
		SetSliderDialogInterval(0.01)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_DisenchantingExp.SetValue(value)
		SetSliderOptionValueST(value)
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(0.1)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("How much experience you gain for disenchanting an item item into arcane dust.\n Normal disenchanting provides 1.0 experience per 400 gold an item is worth.")
	ENDEVENT
ENDSTATE

STATE SOCKETEXP_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GrimyGlobal_SocketingExp.GetValue())
		SetSliderDialogDefaultValue(0.1)
		SetSliderDialogRange(0.0,10.0)
		SetSliderDialogInterval(0.01)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GrimyGlobal_SocketingExp.SetValue(value)
		SetSliderOptionValueST(value)
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(0.1)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("How much experience you gain, per gem, for socketing a gem.")
	ENDEVENT
ENDSTATE


;===============================
;==========Perk States==========
;===============================

FUNCTION togglePerk(PERK akPerk)
	IF PlayerRef.HasPerk(akPerk)
		IF ShowMessage("Refund a perk point?",true,"Refund Perk","No Perk Point")
			Game.ModPerkpoints(1)
		ENDIF
		PlayerRef.RemovePerk(akPerk)
		SetToggleOptionValueST(false)
	ELSE
		IF ShowMessage("Deduct a perk point?",true,"Deduct Perk","Free Perk")
			IF Game.GetPerkPoints() > 0
				Game.ModperkPoints(-1)
				PlayerRef.AddPerk(akPerk)
				SetToggleOptionValueST(true)
			ELSE
				ShowMessage("You don't have any perk points",false)
			ENDIF
		ELSE
			PlayerRef.AddPerk(akPerk)
			SetToggleOptionValueST(true)
		ENDIF
	ENDIF
ENDFUNCTION

STATE ENCHANTER01_TOGGLE
	EVENT OnSelectST()
		togglePerk(GrimyPerkEnch20OffenseSlot)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GrimyPerkEnch20OffenseSlot)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Gain the ability to identify non-player made enchantments. Increase enchanting power by 1% per enchanting level.")
	ENDEVENT
ENDSTATE

STATE CHAOS_TOGGLE
	EVENT OnSelectST()
		togglePerk(GrimyPerkEnch30Tinkerer)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GrimyPerkEnch30Tinkerer)
		SetToggleOptionValueST(false)
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("Identification provides an additional utility property on armor and attribute property on weapons.\nRequires Enchanter at level 30.")
	ENDEVENT
ENDSTATE

STATE ORDER_TOGGLE
	EVENT OnSelectST()
		togglePerk(GrimyPerkEnch30Warden)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GrimyPerkEnch30Warden)
		SetToggleOptionValueST(false)
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("Identification provides an additional defensive property on armor and attribute property on weapons.\nRequires Identification and level 30")
	ENDEVENT
ENDSTATE

STATE REFINEMENT_TOGGLE
	EVENT OnSelectST()
		togglePerk(GrimyPerkEnch50Misc)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GrimyPerkEnch50Misc)
		SetToggleOptionValueST(false)
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("Increase chance to identify a miscellaneous property on armor from 10% to 60%.\n Requires Identification and level 40.")
	ENDEVENT
ENDSTATE

STATE BASELINE_TOGGLE
	EVENT OnSelectST()
		togglePerk(GrimyPerkEnch50Transcription)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GrimyPerkEnch50Transcription)
		SetToggleOptionValueST(false)
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("Increases your minimum property roll by 40%. Doubles the magnitude of scrolls.\nGrants the ability to copy magic scrolls with arcane dust, using an inventory hotkey and restock them by waiting.\n Requires Warden OR Perfectionist, and level 50.")
	ENDEVENT
ENDSTATE

STATE OVERLOAD_TOGGLE
	EVENT OnSelectST()
		togglePerk(GrimyPerkEnch50Overload)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GrimyPerkEnch50Overload)
		SetToggleOptionValueST(false)
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("15% chance to supercharge a primary property while corrupting another.\nGain the ability to apply more enchantment effects to traditional enchantments, at the cost of enchantment power.\n Requires Tinkerer OR Amplification, and level 50.")
	ENDEVENT
ENDSTATE

STATE EPIC_TOGGLE
	EVENT OnSelectST()
		togglePerk(GrimyPerkEnch70Epic)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GrimyPerkEnch70Epic)
		SetToggleOptionValueST(false)
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("Increase chance to identify an epic property on armor from 10% to 60%.\n Requires Refinement and level 60.")
	ENDEVENT
ENDSTATE

STATE AMPLIFIER_TOGGLE
	EVENT OnSelectST()
		togglePerk(GrimyPerkEnch70Amplifier)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GrimyPerkEnch70Amplifier)
		SetToggleOptionValueST(false)
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("Increase chance to identify an amplifier property on armor from 10% to 60%.\n Requires Overload OR Perfectionist, and level 70")
	ENDEVENT
ENDSTATE

STATE PERFECT_TOGGLE
	EVENT OnSelectST()
		togglePerk(GrimyPerkEnch90Perfectionist)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GrimyPerkEnch90Perfectionist)
		SetToggleOptionValueST(false)
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("10% higher chance of perfect property roll.\nYou can now learn enchantments from items that cannot be disenchanted.\n Requires Amplification OR Baseline and level 90.")
	ENDEVENT
ENDSTATE

ACTOR PROPERTY PlayerRef AUTO

GLOBALVARIABLE PROPERTY GrimyGlobal_MaxRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_MinRoll AUTO

GLOBALVARIABLE PROPERTY GrimyGlobal_ChargeMax AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_ChargeMin AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_ChargeCost AUTO

GLOBALVARIABLE PROPERTY GrimyGlobal_Irregular AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_Overload AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_PerfectRoll AUTO

GLOBALVARIABLE PROPERTY GrimyGlobal_CoreRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_OffenseRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_DefenseRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_UtilityRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_EpicRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_MiscRoll AUTO

GLOBALVARIABLE PROPERTY GrimyGlobal_WeaponDamageRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_WeaponAttributeRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_WeaponDrainRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_AmplifierRoll AUTO

GLOBALVARIABLE PROPERTY GrimyGlobal_HarvestNone AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_NoArcaneDust AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_NoSigil AUTO

GLOBALVARIABLE PROPERTY GrimyGlobal_EnchantingExp AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_DisenchantingExp AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_SocketingExp AUTO

PERK PROPERTY GrimyPerkEnch20OffenseSlot AUTO
PERK PROPERTY GrimyPerkEnch30Tinkerer AUTO
PERK PROPERTY GrimyPerkEnch30Warden AUTO
PERK PROPERTY GrimyPerkEnch50Misc AUTO
PERK PROPERTY GrimyPerkEnch50Transcription AUTO
PERK PROPERTY GrimyPerkEnch50Overload AUTO
PERK PROPERTY GrimyPerkEnch70Epic AUTO
PERK PROPERTY GrimyPerkEnch70Amplifier AUTO
PERK PROPERTY GrimyPerkEnch90Perfectionist AUTO

;======================================
;==========Leveled Item Lists==========
;======================================
FUNCTION injectLootOnce()
	LItemEnchRobes75.AddForm(GrimyLItemClothingRobe,1,1)
	LItemEnchRobes75.AddForm(GrimyLItemClothingRobe,1,1)
	LItemEnchRobes75.AddForm(GrimyLItemClothingRobe,1,1)
	LItemEnchRobes75.AddForm(GrimyLItemClothingRobe,1,1)
	LItemEnchRobes75.AddForm(GrimyLItemClothingRobe,1,1)
	LootEnchRobes10.AddForm(GrimyLItemClothingRobe,1,1)
	LootEnchRobes10.AddForm(GrimyLItemClothingRobe,1,1)
	LootEnchRobes10.AddForm(GrimyLItemClothingRobe,1,1)
	LootEnchRobes10.AddForm(GrimyLItemClothingRobe,1,1)
	LootEnchRobes10.AddForm(GrimyLItemClothingRobe,1,1)
	LootEnchRobes15.AddForm(GrimyLItemClothingRobe,1,1)
	LootEnchRobes15.AddForm(GrimyLItemClothingRobe,1,1)
	LootEnchRobes15.AddForm(GrimyLItemClothingRobe,1,1)
	LootEnchRobes15.AddForm(GrimyLItemClothingRobe,1,1)
	LootEnchRobes15.AddForm(GrimyLItemClothingRobe,1,1)
	
	LItemEnchJewelryAll.AddForm(GrimyLItemClothingAmulet,1,1)
	LItemEnchJewelryAll.AddForm(GrimyLitemClothingRing,1,1)
	LItemEnchJewelryAll.AddForm(GrimyLitemClothingRing,1,1)
	LItemEnchJewelryAll15.AddForm(GrimyLItemClothingAmulet,1,1)
	LItemEnchJewelryAll15.AddForm(GrimyLitemClothingRing,1,1)
	LItemEnchJewelryAll15.AddForm(GrimyLitemClothingRing,1,1)
	LItemEnchJewelryAll75.AddForm(GrimyLItemClothingAmulet,1,1)
	LItemEnchJewelryAll75.AddForm(GrimyLitemClothingRing,1,1)
	LItemEnchJewelryAll75.AddForm(GrimyLitemClothingRing,1,1)
	
	LItemEnchArmorHeavyAll.AddForm(GrimyLItemHeavyBoot,1,1)
	LItemEnchArmorHeavyAllNoDragon.AddForm(GrimyLItemHeavyBoot,1,1)
	DLC2LItemEnchArmorHeavyAll.AddForm(GrimyLItemHeavyBoot,1,1)

	LItemEnchArmorHeavyAll.AddForm(GrimyLItemHeavyChest,1,1)
	LItemEnchArmorHeavyAllNoDragon.AddForm(GrimyLItemHeavyChest,1,1)
	DLC2LItemEnchArmorHeavyAll.AddForm(GrimyLItemHeavyChest,1,1)
	
	LItemEnchArmorHeavyAll.AddForm(GrimyLItemHeavyGlove,1,1)
	LItemEnchArmorHeavyAllNoDragon.AddForm(GrimyLItemHeavyGlove,1,1)
	DLC2LItemEnchArmorHeavyAll.AddForm(GrimyLItemHeavyGlove,1,1)
	
	LItemEnchArmorHeavyAll.AddForm(GrimyLItemHeavyHelm,1,1)
	LItemEnchArmorHeavyAllNoDragon.AddForm(GrimyLItemHeavyHelm,1,1)
	DLC2LItemEnchArmorHeavyAll.AddForm(GrimyLItemHeavyHelm,1,1)
	
	LItemEnchArmorHeavyAll.AddForm(GrimyLItemHeavyShield,1,1)
	LItemEnchArmorHeavyAllNoDragon.AddForm(GrimyLItemHeavyShield,1,1)
	DLC2LItemEnchArmorHeavyAll.AddForm(GrimyLItemHeavyShield,1,1)

	LItemEnchArmorLightAll.AddForm(GrimyLItemLightBoot,1,1)
	LItemEnchArmorLightAllNoDragon.AddForm(GrimyLItemLightBoot,1,1)
	DLC2LItemEnchArmorLightAll.AddForm(GrimyLItemLightBoot,1,1)

	LItemEnchArmorLightAll.AddForm(GrimyLItemLightChest,1,1)
	LItemEnchArmorLightAllNoDragon.AddForm(GrimyLItemLightChest,1,1)
	DLC2LItemEnchArmorLightAll.AddForm(GrimyLItemLightChest,1,1)

	LItemEnchArmorLightAll.AddForm(GrimyLItemLightGlove,1,1)
	LItemEnchArmorLightAllNoDragon.AddForm(GrimyLItemLightGlove,1,1)
	DLC2LItemEnchArmorLightAll.AddForm(GrimyLItemLightGlove,1,1)

	LItemEnchArmorLightAll.AddForm(GrimyLItemLightHelm,1,1)
	LItemEnchArmorLightAllNoDragon.AddForm(GrimyLItemLightHelm,1,1)
	DLC2LItemEnchArmorLightAll.AddForm(GrimyLItemLightHelm,1,1)
	
	LItemEnchArmorLightAll.AddForm(GrimyLItemLightShield,1,1)
	LItemEnchArmorLightAllNoDragon.AddForm(GrimyLItemLightShield,1,1)
	DLC2LItemEnchArmorLightAll.AddForm(GrimyLItemLightShield,1,1)

	LItemEnchWeaponAny.AddForm(GrimyLItemWeapon1H,1,1)
	LItemEnchWeaponAny.AddForm(GrimyLItemWeapon1H,1,1)
	LItemEnchWeaponAny.AddForm(GrimyLItemWeapon2H,1,1)
	LItemEnchWeaponAny.AddForm(GrimyLitemWeaponBow,1,1)
	LItemEnchWeaponAnySpecial.AddForm(GrimyLItemWeapon1H,1,1)
	LItemEnchWeaponAnySpecial.AddForm(GrimyLItemWeapon1H,1,1)
	LItemEnchWeaponAnySpecial.AddForm(GrimyLItemWeapon2H,1,1)
	LItemEnchWeaponAnySpecial.AddForm(GrimyLitemWeaponBow,1,1)
	DLC2LItemEnchWeaponAny.AddForm(GrimyLItemWeapon1H,1,1)
	DLC2LItemEnchWeaponAny.AddForm(GrimyLItemWeapon1H,1,1)
	DLC2LItemEnchWeaponAny.AddForm(GrimyLItemWeapon2H,1,1)
	DLC2LItemEnchWeaponAny.AddForm(GrimyLitemWeaponBow,1,1)
	DLC2LItemEnchWeaponAnyBest.AddForm(GrimyLItemWeapon1H,1,1)
	DLC2LItemEnchWeaponAnyBest.AddForm(GrimyLItemWeapon1H,1,1)
	DLC2LItemEnchWeaponAnyBest.AddForm(GrimyLItemWeapon2H,1,1)
	DLC2LItemEnchWeaponAnyBest.AddForm(GrimyLitemWeaponBow,1,1)
	DLC2LItemEnchWeaponAnySpecial.AddForm(GrimyLItemWeapon1H,1,1)
	DLC2LItemEnchWeaponAnySpecial.AddForm(GrimyLItemWeapon1H,1,1)
	DLC2LItemEnchWeaponAnySpecial.AddForm(GrimyLItemWeapon2H,1,1)
	DLC2LItemEnchWeaponAnySpecial.AddForm(GrimyLitemWeaponBow,1,1)
	
	LItemEnchWeaponBlacksmithAny.AddForm(GrimyLItemWeapon1H,1,1)
	LItemEnchWeaponBlacksmithAny.AddForm(GrimyLItemWeapon2H,1,1)
	LItemEnchWeaponBlacksmithAny.AddForm(GrimyLitemWeaponBow,1,1)
ENDFUNCTION

FUNCTION revertLoot()
	LItemEnchRobes75.Revert()
	LootEnchRobes10.Revert()
	LootEnchRobes15.Revert()
	LItemEnchJewelryAll.Revert()
	LItemEnchJewelryAll15.Revert()
	LItemEnchJewelryAll75.Revert()

	LItemEnchArmorHeavyAll.Revert()
	LItemEnchArmorHeavyAllNoDragon.Revert()
	DLC2LItemEnchArmorHeavyAll.Revert()
	LItemEnchArmorLightAll.Revert()
	LItemEnchArmorLightAllNoDragon.Revert()
	DLC2LItemEnchArmorLightAll.Revert()

	LItemEnchWeaponAny.Revert()
	LItemEnchWeaponAnySpecial.Revert()
	DLC2LItemEnchWeaponAny.Revert()
	DLC2LItemEnchWeaponAnyBest.Revert()
	DLC2LItemEnchWeaponAnySpecial.Revert()
	LItemEnchWeaponBlacksmithAny.Revert()
ENDFUNCTION

LEVELEDITEM PROPERTY GrimyLItemClothingAmulet AUTO
LEVELEDITEM PROPERTY GrimyLitemClothingRing AUTO
LEVELEDITEM PROPERTY GrimyLItemClothingRobe AUTO

LEVELEDITEM PROPERTY LItemEnchRobes75 AUTO
LEVELEDITEM PROPERTY LootEnchRobes10 AUTO
LEVELEDITEM PROPERTY LootEnchRobes15 AUTO
LEVELEDITEM PROPERTY LItemEnchJewelryAll AUTO
LEVELEDITEM PROPERTY LItemEnchJewelryAll15 AUTO
LEVELEDITEM PROPERTY LItemEnchJewelryAll75 AUTO

LEVELEDITEM PROPERTY GrimyLItemHeavyBoot AUTO
LEVELEDITEM PROPERTY GrimyLItemHeavyChest AUTO
LEVELEDITEM PROPERTY GrimyLItemHeavyGlove AUTO
LEVELEDITEM PROPERTY GrimyLItemHeavyHelm AUTO
LEVELEDITEM PROPERTY GrimyLItemHeavyShield AUTO

LEVELEDITEM PROPERTY LItemEnchArmorHeavyAll AUTO
LEVELEDITEM PROPERTY LItemEnchArmorHeavyAllNoDragon AUTO
LEVELEDITEM PROPERTY DLC2LItemEnchArmorHeavyAll AUTO

LEVELEDITEM PROPERTY GrimyLItemLightBoot AUTO
LEVELEDITEM PROPERTY GrimyLItemLightChest AUTO
LEVELEDITEM PROPERTY GrimyLItemLightGlove AUTO
LEVELEDITEM PROPERTY GrimyLItemLightHelm AUTO
LEVELEDITEM PROPERTY GrimyLItemLightShield AUTO

LEVELEDITEM PROPERTY LItemEnchArmorLightAll AUTO
LEVELEDITEM PROPERTY LItemEnchArmorLightAllNoDragon AUTO
LEVELEDITEM PROPERTY DLC2LItemEnchArmorLightAll AUTO

LEVELEDITEM PROPERTY GrimyLItemWeapon1H AUTO
LEVELEDITEM PROPERTY GrimyLItemWeapon2H AUTO
LEVELEDITEM PROPERTY GrimyLitemWeaponBow AUTO

LEVELEDITEM PROPERTY LItemEnchWeaponAny AUTO
LEVELEDITEM PROPERTY LItemEnchWeaponAnySpecial AUTO
LEVELEDITEM PROPERTY DLC2LItemEnchWeaponAny AUTO
LEVELEDITEM PROPERTY DLC2LItemEnchWeaponAnyBest AUTO
LEVELEDITEM PROPERTY DLC2LItemEnchWeaponAnySpecial AUTO
LEVELEDITEM PROPERTY LItemEnchWeaponBlacksmithAny AUTO

;======================================
;==========Drop Level Scaler===========
;======================================

LEVELEDITEM PROPERTY GrimyLItemCommonHeavyBoot AUTO
LEVELEDITEM PROPERTY GrimyLItemCommonHeavyChest AUTO
LEVELEDITEM PROPERTY GrimyLItemCommonHeavyGlove AUTO
LEVELEDITEM PROPERTY GrimyLItemCommonHeavyHelm AUTO
LEVELEDITEM PROPERTY GrimyLItemCommonHeavyShield AUTO

LEVELEDITEM PROPERTY GrimyLItemCommonLightBoot AUTO
LEVELEDITEM PROPERTY GrimyLItemCommonLightChest AUTO
LEVELEDITEM PROPERTY GrimyLItemCommonLightGlove AUTO
LEVELEDITEM PROPERTY GrimyLItemCommonLightHelm AUTO
LEVELEDITEM PROPERTY GrimyLItemCommonLightShield AUTO

LEVELEDITEM PROPERTY GrimyLItemRareHeavyBoot AUTO
LEVELEDITEM PROPERTY GrimyLItemRareHeavyChest AUTO
LEVELEDITEM PROPERTY GrimyLItemRareHeavyGlove AUTO
LEVELEDITEM PROPERTY GrimyLItemRareHeavyHelm AUTO
LEVELEDITEM PROPERTY GrimyLItemRareHeavyShield AUTO

LEVELEDITEM PROPERTY GrimyLItemRareLightBoot AUTO
LEVELEDITEM PROPERTY GrimyLItemRareLightChest AUTO
LEVELEDITEM PROPERTY GrimyLItemRareLightGlove AUTO
LEVELEDITEM PROPERTY GrimyLItemRareLightHelm AUTO
LEVELEDITEM PROPERTY GrimyLItemRareLightShield AUTO

LEVELEDITEM PROPERTY GrimyLitemWeaponBattleaxe AUTO
;LEVELEDITEM PROPERTY GrimyLitemWeaponBow AUTO
LEVELEDITEM PROPERTY GrimyLitemWeaponDagger AUTO
LEVELEDITEM PROPERTY GrimyLitemWeaponGreatsword AUTO
LEVELEDITEM PROPERTY GrimyLitemWeaponMace AUTO
LEVELEDITEM PROPERTY GrimyLitemWeaponSword AUTO
LEVELEDITEM PROPERTY GrimyLitemWeaponWarAxe AUTO
LEVELEDITEM PROPERTY GrimyLitemWeaponWarhammer AUTO

FUNCTION adjustDropLevel(FLOAT akPercentage, LEVELEDITEM akLItem, INT akIndex)
	akLItem.SetNthLevel(akIndex, (akLItem.GetNthLevel(akIndex) * akPercentage) AS INT)
	IF akIndex < akLItem.GetNumForms()
		adjustDroplevel(akPercentage,akLItem,akIndex + 1)	
	ENDIF
ENDFUNCTION

FUNCTION revertAllDropLevels()
	GrimyLItemCommonHeavyBoot.SetNthLevel(0,1)
	GrimyLItemCommonHeavyBoot.SetNthLevel(1,10)
	GrimyLItemCommonHeavyBoot.SetNthLevel(2,10)
	GrimyLItemCommonHeavyBoot.SetNthLevel(3,15)
	GrimyLItemCommonHeavyBoot.SetNthLevel(4,20)
	GrimyLItemCommonHeavyBoot.SetNthLevel(5,25)
	GrimyLItemCommonHeavyBoot.SetNthLevel(6,35)
	GrimyLItemCommonHeavyBoot.SetNthLevel(7,40)
	GrimyLItemCommonHeavyBoot.SetNthLevel(8,45)
	GrimyLItemCommonHeavyBoot.SetNthLevel(9,50)
	GrimyLItemCommonHeavyBoot.SetNthLevel(10,55)
	GrimyLItemCommonHeavyBoot.SetNthLevel(11,65)
	GrimyLItemCommonHeavyBoot.SetNthLevel(12,70)
	GrimyLItemCommonHeavyBoot.SetNthLevel(13,75)
	
	GrimyLItemCommonHeavyChest.SetNthLevel(0,1)
	GrimyLItemCommonHeavyChest.SetNthLevel(1,5)
	GrimyLItemCommonHeavyChest.SetNthLevel(2,10)
	GrimyLItemCommonHeavyChest.SetNthLevel(3,10)
	GrimyLItemCommonHeavyChest.SetNthLevel(4,15)
	GrimyLItemCommonHeavyChest.SetNthLevel(5,15)
	GrimyLItemCommonHeavyChest.SetNthLevel(6,15)
	GrimyLItemCommonHeavyChest.SetNthLevel(7,20)
	GrimyLItemCommonHeavyChest.SetNthLevel(8,25)
	GrimyLItemCommonHeavyChest.SetNthLevel(9,35)
	GrimyLItemCommonHeavyChest.SetNthLevel(10,40)
	GrimyLItemCommonHeavyChest.SetNthLevel(11,45)
	GrimyLItemCommonHeavyChest.SetNthLevel(12,50)
	GrimyLItemCommonHeavyChest.SetNthLevel(13,55)
	GrimyLItemCommonHeavyChest.SetNthLevel(14,65)
	GrimyLItemCommonHeavyChest.SetNthLevel(15,70)
	GrimyLItemCommonHeavyChest.SetNthLevel(16,75)

	GrimyLItemCommonHeavyGlove.SetNthLevel(0,1)
	GrimyLItemCommonHeavyGlove.SetNthLevel(1,10)
	GrimyLItemCommonHeavyGlove.SetNthLevel(2,10)
	GrimyLItemCommonHeavyGlove.SetNthLevel(3,15)
	GrimyLItemCommonHeavyGlove.SetNthLevel(4,20)
	GrimyLItemCommonHeavyGlove.SetNthLevel(5,25)
	GrimyLItemCommonHeavyGlove.SetNthLevel(6,35)
	GrimyLItemCommonHeavyGlove.SetNthLevel(7,40)
	GrimyLItemCommonHeavyGlove.SetNthLevel(8,45)
	GrimyLItemCommonHeavyGlove.SetNthLevel(9,50)
	GrimyLItemCommonHeavyGlove.SetNthLevel(10,55)
	GrimyLItemCommonHeavyGlove.SetNthLevel(11,65)
	GrimyLItemCommonHeavyGlove.SetNthLevel(12,70)
	GrimyLItemCommonHeavyGlove.SetNthLevel(13,75)

	GrimyLItemCommonHeavyHelm.SetNthLevel(0,1)
	GrimyLItemCommonHeavyHelm.SetNthLevel(1,10)
	GrimyLItemCommonHeavyHelm.SetNthLevel(2,10)
	GrimyLItemCommonHeavyHelm.SetNthLevel(3,15)
	GrimyLItemCommonHeavyHelm.SetNthLevel(4,20)
	GrimyLItemCommonHeavyHelm.SetNthLevel(5,25)
	GrimyLItemCommonHeavyHelm.SetNthLevel(6,35)
	GrimyLItemCommonHeavyHelm.SetNthLevel(7,40)
	GrimyLItemCommonHeavyHelm.SetNthLevel(8,45)
	GrimyLItemCommonHeavyHelm.SetNthLevel(9,50)
	GrimyLItemCommonHeavyHelm.SetNthLevel(10,55)
	GrimyLItemCommonHeavyHelm.SetNthLevel(11,65)
	GrimyLItemCommonHeavyHelm.SetNthLevel(12,70)
	GrimyLItemCommonHeavyHelm.SetNthLevel(13,75)

	GrimyLItemCommonHeavyShield.SetNthLevel(0,1)
	GrimyLItemCommonHeavyShield.SetNthLevel(1,5)
	GrimyLItemCommonHeavyShield.SetNthLevel(2,10)
	GrimyLItemCommonHeavyShield.SetNthLevel(3,15)
	GrimyLItemCommonHeavyShield.SetNthLevel(4,20)
	GrimyLItemCommonHeavyShield.SetNthLevel(5,25)
	GrimyLItemCommonHeavyShield.SetNthLevel(6,45)
	GrimyLItemCommonHeavyShield.SetNthLevel(7,50)
	GrimyLItemCommonHeavyShield.SetNthLevel(8,55)
	GrimyLItemCommonHeavyShield.SetNthLevel(9,65)
	GrimyLItemCommonHeavyShield.SetNthLevel(10,75)

	GrimyLItemCommonLightBoot.SetNthLevel(0,1)
	GrimyLItemCommonLightBoot.SetNthLevel(1,10)
	GrimyLItemCommonLightBoot.SetNthLevel(2,20)
	GrimyLItemCommonLightBoot.SetNthLevel(3,25)
	GrimyLItemCommonLightBoot.SetNthLevel(4,30)
	GrimyLItemCommonLightBoot.SetNthLevel(5,35)
	GrimyLItemCommonLightBoot.SetNthLevel(6,40)
	GrimyLItemCommonLightBoot.SetNthLevel(7,60)
	GrimyLItemCommonLightBoot.SetNthLevel(8,65)
	GrimyLItemCommonLightBoot.SetNthLevel(9,70)

	GrimyLItemCommonLightChest.SetNthLevel(0,1)
	GrimyLItemCommonLightChest.SetNthLevel(1,10)
	GrimyLItemCommonLightChest.SetNthLevel(2,10)
	GrimyLItemCommonLightChest.SetNthLevel(3,10)
	GrimyLItemCommonLightChest.SetNthLevel(4,10)
	GrimyLItemCommonLightChest.SetNthLevel(5,10)
	GrimyLItemCommonLightChest.SetNthLevel(6,20)
	GrimyLItemCommonLightChest.SetNthLevel(7,25)
	GrimyLItemCommonLightChest.SetNthLevel(8,30)
	GrimyLItemCommonLightChest.SetNthLevel(9,35)
	GrimyLItemCommonLightChest.SetNthLevel(10,40)
	GrimyLItemCommonLightChest.SetNthLevel(11,40)
	GrimyLItemCommonLightChest.SetNthLevel(12,50)
	GrimyLItemCommonLightChest.SetNthLevel(13,60)
	GrimyLItemCommonLightChest.SetNthLevel(14,65)
	GrimyLItemCommonLightChest.SetNthLevel(15,70)

	GrimyLItemCommonLightGlove.SetNthLevel(0,1)
	GrimyLItemCommonLightGlove.SetNthLevel(1,20)
	GrimyLItemCommonLightGlove.SetNthLevel(2,25)
	GrimyLItemCommonLightGlove.SetNthLevel(3,30)
	GrimyLItemCommonLightGlove.SetNthLevel(4,35)
	GrimyLItemCommonLightGlove.SetNthLevel(5,40)
	GrimyLItemCommonLightGlove.SetNthLevel(6,60)
	GrimyLItemCommonLightGlove.SetNthLevel(7,65)
	GrimyLItemCommonLightGlove.SetNthLevel(8,70)

	GrimyLItemCommonLightHelm.SetNthLevel(0,1)
	GrimyLItemCommonLightHelm.SetNthLevel(1,10)
	GrimyLItemCommonLightHelm.SetNthLevel(2,20)
	GrimyLItemCommonLightHelm.SetNthLevel(3,25)
	GrimyLItemCommonLightHelm.SetNthLevel(4,30)
	GrimyLItemCommonLightHelm.SetNthLevel(5,35)
	GrimyLItemCommonLightHelm.SetNthLevel(6,40)
	GrimyLItemCommonLightHelm.SetNthLevel(7,60)
	GrimyLItemCommonLightHelm.SetNthLevel(8,65)
	GrimyLItemCommonLightHelm.SetNthLevel(9,70)

	GrimyLItemCommonLightShield.SetNthLevel(0,1)
	GrimyLItemCommonLightShield.SetNthLevel(1,30)
	GrimyLItemCommonLightShield.SetNthLevel(2,35)
	GrimyLItemCommonLightShield.SetNthLevel(3,60)
	GrimyLItemCommonLightShield.SetNthLevel(4,65)
	GrimyLItemCommonLightShield.SetNthLevel(5,70)

	GrimyLItemRareHeavyBoot.SetNthLevel(0,1)
	GrimyLItemRareHeavyBoot.SetNthLevel(1,40)
	GrimyLItemRareHeavyBoot.SetNthLevel(2,50)
	GrimyLItemRareHeavyBoot.SetNthLevel(3,60)

	GrimyLItemRareHeavyChest.SetNthLevel(0,1)
	GrimyLItemRareHeavyChest.SetNthLevel(1,40)
	GrimyLItemRareHeavyChest.SetNthLevel(2,50)
	GrimyLItemRareHeavyChest.SetNthLevel(3,60)

	GrimyLItemRareHeavyGlove.SetNthLevel(0,1)
	GrimyLItemRareHeavyGlove.SetNthLevel(1,40)
	GrimyLItemRareHeavyGlove.SetNthLevel(2,50)
	GrimyLItemRareHeavyGlove.SetNthLevel(3,60)

	GrimyLItemRareHeavyHelm.SetNthLevel(0,1)
	GrimyLItemRareHeavyHelm.SetNthLevel(1,40)
	GrimyLItemRareHeavyHelm.SetNthLevel(2,50)
	GrimyLItemRareHeavyHelm.SetNthLevel(3,60)

	GrimyLItemRareHeavyHelm.SetNthLevel(0,1)
	GrimyLItemRareHeavyHelm.SetNthLevel(1,60)

	GrimyLItemRareLightBoot.SetNthLevel(0,1)
	GrimyLItemRareLightBoot.SetNthLevel(1,20)
	GrimyLItemRareLightBoot.SetNthLevel(2,30)
	GrimyLItemRareLightBoot.SetNthLevel(3,40)
	GrimyLItemRareLightBoot.SetNthLevel(4,50)
	GrimyLItemRareLightBoot.SetNthLevel(5,60)
	GrimyLItemRareLightBoot.SetNthLevel(6,70)

	GrimyLItemRareLightChest.SetNthLevel(0,1)
	GrimyLItemRareLightChest.SetNthLevel(1,10)
	GrimyLItemRareLightChest.SetNthLevel(2,20)
	GrimyLItemRareLightChest.SetNthLevel(3,30)
	GrimyLItemRareLightChest.SetNthLevel(4,40)
	GrimyLItemRareLightChest.SetNthLevel(5,50)
	GrimyLItemRareLightChest.SetNthLevel(6,60)
	GrimyLItemRareLightChest.SetNthLevel(7,70)

	GrimyLItemRareLightGlove.SetNthLevel(0,1)
	GrimyLItemRareLightGlove.SetNthLevel(1,20)
	GrimyLItemRareLightGlove.SetNthLevel(2,30)
	GrimyLItemRareLightGlove.SetNthLevel(3,40)
	GrimyLItemRareLightGlove.SetNthLevel(4,50)
	GrimyLItemRareLightGlove.SetNthLevel(5,60)
	GrimyLItemRareLightGlove.SetNthLevel(6,70)

	GrimyLItemRareLightHelm.SetNthLevel(0,1)
	GrimyLItemRareLightHelm.SetNthLevel(1,20)
	GrimyLItemRareLightHelm.SetNthLevel(2,30)
	GrimyLItemRareLightHelm.SetNthLevel(3,40)
	GrimyLItemRareLightHelm.SetNthLevel(4,50)
	GrimyLItemRareLightHelm.SetNthLevel(5,70)

	GrimyLItemRareLightShield.SetNthLevel(0,1)
	
	GrimyLitemWeaponBattleaxe.SetNthLevel(0,1)
	GrimyLitemWeaponBattleaxe.SetNthLevel(1,10)
	GrimyLitemWeaponBattleaxe.SetNthLevel(2,20)
	GrimyLitemWeaponBattleaxe.SetNthLevel(3,30)
	GrimyLitemWeaponBattleaxe.SetNthLevel(4,35)
	GrimyLitemWeaponBattleaxe.SetNthLevel(5,40)
	GrimyLitemWeaponBattleaxe.SetNthLevel(6,45)
	GrimyLitemWeaponBattleaxe.SetNthLevel(7,50)
	GrimyLitemWeaponBattleaxe.SetNthLevel(8,55)
	GrimyLitemWeaponBattleaxe.SetNthLevel(9,60)
	GrimyLitemWeaponBattleaxe.SetNthLevel(10,70)
	GrimyLitemWeaponBattleaxe.SetNthLevel(11,75)

	GrimyLitemWeaponBow.SetNthLevel(0,1)
	GrimyLitemWeaponBow.SetNthLevel(1,10)
	GrimyLitemWeaponBow.SetNthLevel(2,20)
	GrimyLitemWeaponBow.SetNthLevel(3,30)
	GrimyLitemWeaponBow.SetNthLevel(4,35)
	GrimyLitemWeaponBow.SetNthLevel(5,40)
	GrimyLitemWeaponBow.SetNthLevel(6,45)
	GrimyLitemWeaponBow.SetNthLevel(7,55)
	GrimyLitemWeaponBow.SetNthLevel(8,60)
	GrimyLitemWeaponBow.SetNthLevel(9,70)
	GrimyLitemWeaponBow.SetNthLevel(10,75)

	GrimyLitemWeaponDagger.SetNthLevel(0,1)
	GrimyLitemWeaponDagger.SetNthLevel(1,10)
	GrimyLitemWeaponDagger.SetNthLevel(2,20)
	GrimyLitemWeaponDagger.SetNthLevel(3,30)
	GrimyLitemWeaponDagger.SetNthLevel(4,40)
	GrimyLitemWeaponDagger.SetNthLevel(5,45)
	GrimyLitemWeaponDagger.SetNthLevel(6,50)
	GrimyLitemWeaponDagger.SetNthLevel(7,55)
	GrimyLitemWeaponDagger.SetNthLevel(8,60)
	GrimyLitemWeaponDagger.SetNthLevel(9,70)
	GrimyLitemWeaponDagger.SetNthLevel(10,75)

	GrimyLitemWeaponGreatsword.SetNthLevel(0,1)
	GrimyLitemWeaponGreatsword.SetNthLevel(1,10)
	GrimyLitemWeaponGreatsword.SetNthLevel(2,15)
	GrimyLitemWeaponGreatsword.SetNthLevel(3,20)
	GrimyLitemWeaponGreatsword.SetNthLevel(4,30)
	GrimyLitemWeaponGreatsword.SetNthLevel(5,35)
	GrimyLitemWeaponGreatsword.SetNthLevel(6,40)
	GrimyLitemWeaponGreatsword.SetNthLevel(7,45)
	GrimyLitemWeaponGreatsword.SetNthLevel(8,50)
	GrimyLitemWeaponGreatsword.SetNthLevel(9,55)
	GrimyLitemWeaponGreatsword.SetNthLevel(10,60)
	GrimyLitemWeaponGreatsword.SetNthLevel(11,70)
	GrimyLitemWeaponGreatsword.SetNthLevel(12,75)

	GrimyLitemWeaponMace.SetNthLevel(0,1)
	GrimyLitemWeaponMace.SetNthLevel(1,10)
	GrimyLitemWeaponMace.SetNthLevel(2,20)
	GrimyLitemWeaponMace.SetNthLevel(3,30)
	GrimyLitemWeaponMace.SetNthLevel(4,40)
	GrimyLitemWeaponMace.SetNthLevel(5,45)
	GrimyLitemWeaponMace.SetNthLevel(6,50)
	GrimyLitemWeaponMace.SetNthLevel(7,55)
	GrimyLitemWeaponMace.SetNthLevel(8,60)
	GrimyLitemWeaponMace.SetNthLevel(9,70)
	GrimyLitemWeaponMace.SetNthLevel(10,75)

	GrimyLitemWeaponSword.SetNthLevel(0,1)
	GrimyLitemWeaponSword.SetNthLevel(1,10)
	GrimyLitemWeaponSword.SetNthLevel(2,15)
	GrimyLitemWeaponSword.SetNthLevel(3,20)
	GrimyLitemWeaponSword.SetNthLevel(4,30)
	GrimyLitemWeaponSword.SetNthLevel(5,35)
	GrimyLitemWeaponSword.SetNthLevel(6,40)
	GrimyLitemWeaponSword.SetNthLevel(7,45)
	GrimyLitemWeaponSword.SetNthLevel(8,50)
	GrimyLitemWeaponSword.SetNthLevel(9,55)
	GrimyLitemWeaponSword.SetNthLevel(10,60)
	GrimyLitemWeaponSword.SetNthLevel(11,70)
	GrimyLitemWeaponSword.SetNthLevel(12,75)

	GrimyLitemWeaponWarAxe.SetNthLevel(0,1)
	GrimyLitemWeaponWarAxe.SetNthLevel(1,10)
	GrimyLitemWeaponWarAxe.SetNthLevel(2,20)
	GrimyLitemWeaponWarAxe.SetNthLevel(3,30)
	GrimyLitemWeaponWarAxe.SetNthLevel(4,35)
	GrimyLitemWeaponWarAxe.SetNthLevel(5,40)
	GrimyLitemWeaponWarAxe.SetNthLevel(6,45)
	GrimyLitemWeaponWarAxe.SetNthLevel(7,50)
	GrimyLitemWeaponWarAxe.SetNthLevel(8,55)
	GrimyLitemWeaponWarAxe.SetNthLevel(9,60)
	GrimyLitemWeaponWarAxe.SetNthLevel(10,70)
	GrimyLitemWeaponWarAxe.SetNthLevel(11,75)

	GrimyLitemWeaponWarhammer.SetNthLevel(0,1)
	GrimyLitemWeaponWarhammer.SetNthLevel(1,10)
	GrimyLitemWeaponWarhammer.SetNthLevel(2,20)
	GrimyLitemWeaponWarhammer.SetNthLevel(3,30)
	GrimyLitemWeaponWarhammer.SetNthLevel(4,40)
	GrimyLitemWeaponWarhammer.SetNthLevel(5,45)
	GrimyLitemWeaponWarhammer.SetNthLevel(6,50)
	GrimyLitemWeaponWarhammer.SetNthLevel(7,55)
	GrimyLitemWeaponWarhammer.SetNthLevel(8,60)
	GrimyLitemWeaponWarhammer.SetNthLevel(9,70)
	GrimyLitemWeaponWarhammer.SetNthLevel(10,75)

ENDFUNCTION
	
FUNCTION adjustAllDropLevels(FLOAT akPercentage)
	adjustDropLevel(akPercentage, GrimyLItemCommonHeavyBoot, 0)
	adjustDropLevel(akPercentage, GrimyLItemCommonHeavyChest, 0)
	adjustDropLevel(akPercentage, GrimyLItemCommonHeavyGlove, 0)
	adjustDropLevel(akPercentage, GrimyLItemCommonHeavyHelm, 0)
	adjustDropLevel(akPercentage, GrimyLItemCommonHeavyShield, 0)

	adjustDropLevel(akPercentage, GrimyLItemCommonLightBoot, 0)
	adjustDropLevel(akPercentage, GrimyLItemCommonLightChest, 0)
	adjustDropLevel(akPercentage, GrimyLItemCommonLightGlove, 0)
	adjustDropLevel(akPercentage, GrimyLItemCommonLightHelm, 0)
	adjustDropLevel(akPercentage, GrimyLItemCommonLightShield, 0)

	adjustDropLevel(akPercentage, GrimyLItemRareHeavyBoot, 0)
	adjustDropLevel(akPercentage, GrimyLItemRareHeavyChest, 0)
	adjustDropLevel(akPercentage, GrimyLItemRareHeavyGlove, 0)
	adjustDropLevel(akPercentage, GrimyLItemRareHeavyHelm, 0)
	adjustDropLevel(akPercentage, GrimyLItemRareHeavyShield, 0)

	adjustDropLevel(akPercentage, GrimyLItemRareLightBoot, 0)
	adjustDropLevel(akPercentage, GrimyLItemRareLightChest, 0)
	adjustDropLevel(akPercentage, GrimyLItemRareLightGlove, 0)
	adjustDropLevel(akPercentage, GrimyLItemRareLightHelm, 0)
	adjustDropLevel(akPercentage, GrimyLItemRareLightShield, 0)

	adjustDropLevel(akPercentage, GrimyLitemWeaponBattleaxe, 0)
	adjustDropLevel(akPercentage, GrimyLitemWeaponBow, 0)
	adjustDropLevel(akPercentage, GrimyLitemWeaponDagger, 0)
	adjustDropLevel(akPercentage, GrimyLitemWeaponGreatsword, 0)
	adjustDropLevel(akPercentage, GrimyLitemWeaponMace, 0)
	adjustDropLevel(akPercentage, GrimyLitemWeaponSword, 0)
	adjustDropLevel(akPercentage, GrimyLitemWeaponWarAxe, 0)
	adjustDropLevel(akPercentage, GrimyLitemWeaponWarhammer, 0)
ENDFUNCTION


STATE LOOTLEVEL_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(lootCap)
		SetSliderDialogDefaultValue(75.0)
		SetSliderDialogRange(0.0,150.0)
		SetSliderDialogInterval(0.1)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		revertAllDropLevels()
		adjustAllDropLevels(value/75.0)
		lootCap = value
		SetSliderOptionValueST(lootCap,"{0}")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(lootCap)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Multiplier that determines the level distribution of loot.\n By default, you need to reach level 75 to unlock all of GELO's loot.")
	ENDEVENT
ENDSTATE
FLOAT lootCap = 75.0

INT PROPERTY ScrollCount AUTO
SCROLL[] PROPERTY SignatureScrollList AUTO
String[] Function GetScrollList()
	String[] retVal = new String[5]
	retVal[0] = GetScrollName(0)
	retVal[1] = GetScrollName(1)
	retVal[2] = GetScrollName(2)
	retVal[3] = GetScrollName(3)
	retVal[4] = GetScrollName(4)
	
	Return retVal
EndFunction

String Function GetScrollName(INT akIndex)
	If SignatureScrollList[akIndex]
		Return SignatureScrollList[akIndex].GetName()
	Else
		Return "Empty"
	EndIf
EndFunction 