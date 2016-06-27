Scriptname GSA_MenuMain extends SKI_ConfigBase  

INT FUNCTION GetVersion()
	return 3
ENDFUNCTION

EVENT OnVersionUpdate(int a_version)
	refreshPages()
ENDEVENT

EVENT OnConfigInit()
	ModName = "Grimy: Signature Arms"
	;11 master schematics
	LItemScroll100Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll100Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll100Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll100Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll100Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll100Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll100Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll100Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll100Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll100Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll100Skill.AddForm(GSA_Litem_Schematics,1,1)
	
	;13 expert schematics
	LItemScroll75Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll75Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll75Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll75Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll75Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll75Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll75Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll75Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll75Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll75Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll75Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll75Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll75Skill.AddForm(GSA_Litem_Schematics,1,1)
	
	;17 adept schematics
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
	
	;16 apprentice schematics
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
	refreshPages()
ENDEVENT

FUNCTION refreshPages()
	Pages = new string[5]
	Pages[0] = "Settings"
	Pages[1] = "Armor Properties"
	Pages[2] = "Weapon Properties"
	Pages[3] = "Perks"
	Pages[4] = "Loot Injector"
ENDFUNCTION

EVENT OnPageReset(string page)
	IF page == "Armor Properties"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddInputOptionST("LIGHT_HELMET_RENAME","Edit", orName(LightHelmetAlias.GetMyName(),"Light Helmet"))
		AddTextOption(LightHelmetAlias.GetNameSlot(0),LightHelmetAlias.GetMagSlot(0))
		AddTextOption(LightHelmetAlias.GetNameSlot(1),LightHelmetAlias.GetMagSlot(1))
		AddTextOption(LightHelmetAlias.GetNameSlot(2),LightHelmetAlias.GetMagSlot(2))
		AddInputOptionST("LIGHT_CUIRASS_RENAME","Edit", orName(LightCuirassAlias.GetMyName(),"Light Cuirass"))
		AddTextOption(LightCuirassAlias.GetNameSlot(0),LightCuirassAlias.GetMagSlot(0))
		AddTextOption(LightCuirassAlias.GetNameSlot(1),LightCuirassAlias.GetMagSlot(1))
		AddTextOption(LightCuirassAlias.GetNameSlot(2),LightCuirassAlias.GetMagSlot(2))
		AddInputOptionST("LIGHT_GAUNTLETS_RENAME","Edit", orName(LightGauntletsAlias.GetMyName(),"Light Gauntlets"))
		AddTextOption(LightGauntletsAlias.GetNameSlot(0),LightGauntletsAlias.GetMagSlot(0))
		AddTextOption(LightGauntletsAlias.GetNameSlot(1),LightGauntletsAlias.GetMagSlot(1))
		AddTextOption(LightGauntletsAlias.GetNameSlot(2),LightGauntletsAlias.GetMagSlot(2))
		AddInputOptionST("LIGHT_BOOTS_RENAME","Edit", orName(LightBootsAlias.GetMyName(),"Light Boots"))
		AddTextOption(LightBootsAlias.GetNameSlot(0),LightBootsAlias.GetMagSlot(0))
		AddTextOption(LightBootsAlias.GetNameSlot(1),LightBootsAlias.GetMagSlot(1))
		AddTextOption(LightBootsAlias.GetNameSlot(2),LightBootsAlias.GetMagSlot(2))
		AddInputOptionST("LIGHT_SHIELD_RENAME","Edit", orName(LightShieldAlias.GetMyName(),"Light Shield"))
		AddTextOption(LightShieldAlias.GetNameSlot(0),LightShieldAlias.GetMagSlot(0))
		AddTextOption(LightShieldAlias.GetNameSlot(1),LightShieldAlias.GetMagSlot(1))
		AddTextOption(LightShieldAlias.GetNameSlot(2),LightShieldAlias.GetMagSlot(2))
		SetCursorPosition(1)
		AddInputOptionST("HEAVY_HELMET_RENAME","Edit", orName(HeavyHelmetAlias.GetMyName(),"Heavy Helmet"))
		AddTextOption(HeavyHelmetAlias.GetNameSlot(0),HeavyHelmetAlias.GetMagSlot(0))
		AddTextOption(HeavyHelmetAlias.GetNameSlot(1),HeavyHelmetAlias.GetMagSlot(1))
		AddTextOption(HeavyHelmetAlias.GetNameSlot(2),HeavyHelmetAlias.GetMagSlot(2))
		AddInputOptionST("HEAVY_CUIRASS_RENAME","Edit", orName(HeavyCuirassAlias.GetMyName(),"Heavy Cuirass"))
		AddTextOption(HeavyCuirassAlias.GetNameSlot(0),HeavyCuirassAlias.GetMagSlot(0))
		AddTextOption(HeavyCuirassAlias.GetNameSlot(1),HeavyCuirassAlias.GetMagSlot(1))
		AddTextOption(HeavyCuirassAlias.GetNameSlot(2),HeavyCuirassAlias.GetMagSlot(2))
		AddInputOptionST("HEAVY_GAUNTLETS_RENAME","Edit", orName(HeavyGauntletsAlias.GetMyName(),"Heavy Gauntlets"))
		AddTextOption(HeavyGauntletsAlias.GetNameSlot(0),HeavyGauntletsAlias.GetMagSlot(0))
		AddTextOption(HeavyGauntletsAlias.GetNameSlot(1),HeavyGauntletsAlias.GetMagSlot(1))
		AddTextOption(HeavyGauntletsAlias.GetNameSlot(2),HeavyGauntletsAlias.GetMagSlot(2))
		AddInputOptionST("HEAVY_BOOTS_RENAME","Edit", orName(HeavyBootsAlias.GetMyName(),"Heavy Boots"))
		AddTextOption(HeavyBootsAlias.GetNameSlot(0),HeavyBootsAlias.GetMagSlot(0))
		AddTextOption(HeavyBootsAlias.GetNameSlot(1),HeavyBootsAlias.GetMagSlot(1))
		AddTextOption(HeavyBootsAlias.GetNameSlot(2),HeavyBootsAlias.GetMagSlot(2))
		AddInputOptionST("HEAVY_SHIELD_RENAME","Edit", orName(HeavyShieldAlias.GetMyName(),"Heavy Shield"))
		AddTextOption(HeavyShieldAlias.GetNameSlot(0),HeavyShieldAlias.GetMagSlot(0))
		AddTextOption(HeavyShieldAlias.GetNameSlot(1),HeavyShieldAlias.GetMagSlot(1))
		AddTextOption(HeavyShieldAlias.GetNameSlot(2),HeavyShieldAlias.GetMagSlot(2))
	ELSEIF page == "Weapon Properties"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddInputOptionST("BOW_RENAME","Edit", orName(BowAlias.GetMyName(),"Bow"))
		AddTextOption(BowAlias.GetNameSlot(0),BowAlias.GetMagSlot(0))
		AddTextOption(BowAlias.GetNameSlot(1),BowAlias.GetMagSlot(1))
		AddTextOption(BowAlias.GetNameSlot(2),BowAlias.GetMagSlot(2))
		AddTextOption(BowAlias.getOilName(),BowAlias.getOilMag())
		AddInputOptionST("SWORD_RENAME","Edit", orName(SwordAlias.GetMyName(),"Sword"))
		AddTextOption(SwordAlias.GetNameSlot(0),SwordAlias.GetMagSlot(0))
		AddTextOption(SwordAlias.GetNameSlot(1),SwordAlias.GetMagSlot(1))
		AddTextOption(SwordAlias.GetNameSlot(2),SwordAlias.GetMagSlot(2))
		AddTextOption(SwordAlias.getOilName(),SwordAlias.getOilMag())
		AddInputOptionST("WARAXE_RENAME","Edit", orName(WarAxeAlias.GetMyName(),"War Axe"))
		AddTextOption(WarAxeAlias.GetNameSlot(0),WarAxeAlias.GetMagSlot(0))
		AddTextOption(WarAxeAlias.GetNameSlot(1),WarAxeAlias.GetMagSlot(1))
		AddTextOption(WarAxeAlias.GetNameSlot(2),WarAxeAlias.GetMagSlot(2))
		AddTextOption(WarAxeAlias.getOilName(),WarAxeAlias.getOilMag())
		AddInputOptionST("MACE_RENAME","Edit", orName(MaceAlias.GetMyName(),"Mace"))
		AddTextOption(MaceAlias.GetNameSlot(0),MaceAlias.GetMagSlot(0))
		AddTextOption(MaceAlias.GetNameSlot(1),MaceAlias.GetMagSlot(1))
		AddTextOption(MaceAlias.GetNameSlot(2),MaceAlias.GetMagSlot(2))
		AddTextOption(MaceAlias.getOilName(),MaceAlias.getOilMag())
		AddInputOptionST("DAGGER_RENAME","Edit", orName(DaggerAlias.GetMyName(),"Dagger"))
		AddTextOption(DaggerAlias.GetNameSlot(0),DaggerAlias.GetMagSlot(0))
		AddTextOption(DaggerAlias.GetNameSlot(1),DaggerAlias.GetMagSlot(1))
		AddTextOption(DaggerAlias.GetNameSlot(2),DaggerAlias.GetMagSlot(2))
		AddTextOption(DaggerAlias.getOilName(),DaggerAlias.getOilMag())
		
		SetCursorPosition(1)
		AddInputOptionST("CROSSBOW_RENAME","Edit", orName(CrossbowAlias.GetMyName(),"Crossbow"))
		AddTextOption(CrossbowAlias.GetNameSlot(0),CrossbowAlias.GetMagSlot(0))
		AddTextOption(CrossbowAlias.GetNameSlot(1),CrossbowAlias.GetMagSlot(1))
		AddTextOption(CrossbowAlias.GetNameSlot(2),CrossbowAlias.GetMagSlot(2))
		AddTextOption(CrossbowAlias.getOilName(),CrossbowAlias.getOilMag())
		AddInputOptionST("GREATSWORD_RENAME","Edit", orName(GreatswordAlias.GetMyName(),"Greatsword"))
		AddTextOption(GreatswordAlias.GetNameSlot(0),GreatswordAlias.GetMagSlot(0))
		AddTextOption(GreatswordAlias.GetNameSlot(1),GreatswordAlias.GetMagSlot(1))
		AddTextOption(GreatswordAlias.GetNameSlot(2),GreatswordAlias.GetMagSlot(2))
		AddTextOption(GreatswordAlias.getOilName(),GreatswordAlias.getOilMag())
		AddInputOptionST("BATTLEAXE_RENAME","Edit", orName(BattleaxeAlias.GetMyName(),"Battleaxe"))
		AddTextOption(BattleaxeAlias.GetNameSlot(0),BattleaxeAlias.GetMagSlot(0))
		AddTextOption(BattleaxeAlias.GetNameSlot(1),BattleaxeAlias.GetMagSlot(1))
		AddTextOption(BattleaxeAlias.GetNameSlot(2),BattleaxeAlias.GetMagSlot(2))
		AddTextOption(BattleaxeAlias.getOilName(),BattleaxeAlias.getOilMag())
		AddInputOptionST("WARHAMMER_RENAME","Edit", orName(WarhammerAlias.GetMyName(),"Warhammer"))
		AddTextOption(WarhammerAlias.GetNameSlot(0),WarhammerAlias.GetMagSlot(0))
		AddTextOption(WarhammerAlias.GetNameSlot(1),WarhammerAlias.GetMagSlot(1))
		AddTextOption(WarhammerAlias.GetNameSlot(2),WarhammerAlias.GetMagSlot(2))
		AddTextOption(WarhammerAlias.getOilName(),WarhammerAlias.getOilMag())
	ELSEIF page == "Perks"
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddToggleOptionST("SIG_ARMOR_1","Signature Armor",PlayerRef.HasPerk(GSA_Perk_SignatureArmor))
		AddToggleOptionST("SIG_WEAPON_1","Signature Arms",PlayerRef.HasPerk(GSA_Perk_SignatureArms))
		
		AddToggleOptionST("SALVAGE_SLOT","Arcane Armor Forge",PlayerRef.HasPerk(GSA_Perk_Salvage))
		AddToggleOptionST("SIG_WEAPON_2","Arcane Weapon Forge",PlayerRef.HasPerk(GSA_Perk_SignatureArms2))
		
		AddToggleOptionST("SIG_ARTS","Signature Arts",PlayerRef.HasPerk(GSA_Perk_AbilitySlot))
		AddToggleOptionST("SIG_WEAPON_3","Cutting Edge",PlayerRef.HasPerk(GSA_Perk_SignatureArms3))
		
		AddToggleOptionST("CRAFTING","Arcane Crafts",PlayerRef.HasPerk(GSA_Perk_Crafting))
		AddToggleOptionST("BLADE_OILS","Blade Oils",PlayerRef.HasPerk(GSA_Perk_BladeOils))
	ELSEIF page == "Loot Injector"
		AddTextOptionST("REVERT_LISTS","Revert All Lists","Revert")
		AddSliderOptionST("INJECTION_SLIDER","Injections Per Click",Injection_Count AS FLOAT)
		AddHeaderOption("")
		AddHeaderOption("")
		blacksmith1 = AddTextOption("Master Scroll List",LItemScroll100Skill.GetNumForms())
		blacksmith2 = AddTextOption("Expert Scroll List",LItemScroll75Skill.GetNumForms())
		blacksmith3 = AddTextOption("Adept Scroll List",LItemScroll50Skill.GetNumForms())
		blacksmith4 = AddTextOption("Apprentice Scroll List",LItemScroll25Skill.GetNumForms())
		AddHeaderOption("")
		AddHeaderOption("")
		AddTextOptionST("INJECT_100","Inject Manuals","Master Scroll List")
		AddTextOptionST("INJECT_100S","Inject Schematics","Master Scroll List")
		AddTextOptionST("INJECT_75","Inject Manuals","Expert Scroll List")
		AddTextOptionST("INJECT_75S","Inject Schematics","Expert Scroll List")
		AddTextOptionST("INJECT_50","Inject Manuals","Adept Scroll List")
		AddTextOptionST("INJECT_50S","Inject Schematics","Adept Scroll List")
		AddTextOptionST("INJECT_25","Inject Manuals","Apprentice Scroll List")
		AddTextOptionST("INJECT_25S","Inject Schematics","Apprentice Scroll List")
	ELSE ; page == "Settings"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Balance Settings")
		AddSliderOptionST("UPGRADE_SCALE_SLIDER","Upgrade Scaling",(GSA_BPerk_UpgradeScaling.GetNthEntryValue(0,1)*10000.0)+100.0,"{0}%")
		AddSliderOptionST("UPGRADE_MAG_SLIDER","Upgrade Magnitude",GSA_BPerk_UpgradeMag.GetNthEntryValue(0,1)*100.0,"{0}%")
		AddSliderOptionST("SALVAGE_RATIO_SLIDER","Salvage Ratio",GSA_WeightPerIngot.GetValue(),"{1}")
		AddToggleOptionST("TEMPER_TOGGLE","Enable Signature Tempering", GSA_CanTemper.GetValueInt())
		
		AddHeaderOption("Experience Settings")
		AddSliderOptionST("SALVAGE_EXP_SLIDER","Salvage Experience",GSA_SalvageExp.GetValue(),"{1}")
		AddSliderOptionST("ARCANE_EXP_SLIDER","Unidentified Crafting Experience",GSA_ArcaneExp.GetValue(),"{1}")
		
		AddHeaderOption("UI Settings")
		AddToggleOptionST("REEQUIP_TOGGLE","Re-Equip On Load", playerAlias.swapToggle)
		addSliderOptionST("LOADMESSAGE_SLIDER","GUISE Loading Message Frequency", GUISE_LoadingMessages.GetValue())
		
		SetCursorPosition(1)
		AddHeaderOption("Hotkeys")
		AddToggleOptionST("REGISTER_INVENTORY_KEYS","Register Inventory Hotkeys",PlayerRef.HasSpell(GUISE_AB_Inventory_Hotkey))
		AddKeyMapOptionST("SALVAGE_KEY_OID","Salvage Key",GUISE_Hotkey_Salvage.GetValueInt())
		AddKeyMapOptionST("COMBINED_KEY_OID","Combined GUISE Inventory Key",GUISE_Hotkey_Combined.GetValueInt())
	ENDIF
ENDEVENT

STRING FUNCTION orName(STRING akString, STRING akDefault)
	IF akString == "None"
		RETURN akDefault
	ELSEIF StringUtil.GetLength(akString) > 30
		RETURN StringUtil.Substring(akString,0,28) + "..."
	ELSE
		RETURN akString
	ENDIF
ENDFUNCTION

STATE REVERT_LISTS
	EVENT OnSelectST()
		LItemScroll100Skill.Revert()
		LItemScroll75Skill.Revert()
		LItemScroll50Skill.Revert()
		LItemScroll25Skill.Revert()
		SetTextOptionValue(blacksmith1,LItemScroll100Skill.GetNumForms(),true)
		SetTextOptionValue(blacksmith2,LItemScroll75Skill.GetNumForms(),true)
		SetTextOptionValue(blacksmith3,LItemScroll50Skill.GetNumForms(),true)
		SetTextOptionValue(blacksmith4,LItemScroll25Skill.GetNumForms(),false)
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("Resets ALL script based loot changes to the spell tome leveled lists.\nThis includes script based changes made by mods outside of Signature Arms.\nMay take up to 48 game hours to update.")
	ENDEVENT
ENDSTATE

STATE INJECT_100
	EVENT OnSelectST()
		int index = 0
		WHILE index < Injection_Count
			LItemScroll100Skill.AddForm(GSA_Litem_Books,1,1)
			index += 1
		ENDWHILE
		SetTextOptionValue(blacksmith1,LItemScroll100Skill.GetNumForms())
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("This injects manuals, which when read, teach you how to craft upgrade schematics.\nThis loot list normally contains just master level scrolls.\nMay take up to 48 game hours to update.")
	ENDEVENT
ENDSTATE

STATE INJECT_75
	EVENT OnSelectST()
		int index = 0
		WHILE index < Injection_Count
			LItemScroll75Skill.AddForm(GSA_Litem_Books,1,1)
			index += 1
		ENDWHILE
		SetTextOptionValue(blacksmith2,LItemScroll75Skill.GetNumForms())
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("This injects manuals, which when read, teach you how to craft upgrade schematics.\nThis loot list normally contains just master level scrolls.\nMay take up to 48 game hours to update.")
	ENDEVENT
ENDSTATE

STATE INJECT_50
	EVENT OnSelectST()
		int index = 0
		WHILE index < Injection_Count
			LItemScroll50Skill.AddForm(GSA_Litem_Books,1,1)
			index += 1
		ENDWHILE
		SetTextOptionValue(blacksmith3,LItemScroll50Skill.GetNumForms())
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("This injects manuals, which when read, teach you how to craft upgrade schematics.\nThis loot list normally contains just master level scrolls.\nMay take up to 48 game hours to update.")
	ENDEVENT
ENDSTATE

STATE INJECT_25
	EVENT OnSelectST()
		int index = 0
		WHILE index < Injection_Count
			LItemScroll25Skill.AddForm(GSA_Litem_Books,1,1)
			index += 1
		ENDWHILE
		SetTextOptionValue(blacksmith4,LItemScroll25Skill.GetNumForms())
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("This injects manuals, which when read, teach you how to craft upgrade schematics.\nThis loot list normally contains just master level scrolls.\nMay take up to 48 game hours to update.")
	ENDEVENT
ENDSTATE

STATE INJECT_100S
	EVENT OnSelectST()
		int index = 0
		WHILE index < Injection_Count
			LItemScroll100Skill.AddForm(GSA_Litem_Schematics,1,1)
			index += 1
		ENDWHILE
		SetTextOptionValue(blacksmith1,LItemScroll100Skill.GetNumForms())
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("This injects schematics instead of manuals. Good for more loot focused playthroughs.\nThis loot list normally contains just master level scrolls.\nMay take up to 48 game hours to update.")
	ENDEVENT
ENDSTATE

STATE INJECT_75S
	EVENT OnSelectST()
		int index = 0
		WHILE index < Injection_Count
			LItemScroll75Skill.AddForm(GSA_Litem_Schematics,1,1)
			index += 1
		ENDWHILE
		SetTextOptionValue(blacksmith2,LItemScroll75Skill.GetNumForms())
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("This injects schematics instead of manuals. Good for more loot focused playthroughs.\nThis loot list normally contains just master level scrolls.\nMay take up to 48 game hours to update.")
	ENDEVENT
ENDSTATE

STATE INJECT_50S
	EVENT OnSelectST()
		int index = 0
		WHILE index < Injection_Count
			LItemScroll50Skill.AddForm(GSA_Litem_Schematics,1,1)
			index += 1
		ENDWHILE
		SetTextOptionValue(blacksmith3,LItemScroll50Skill.GetNumForms())
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("This injects schematics instead of manuals. Good for more loot focused playthroughs.\nThis loot list normally contains just master level scrolls.\nMay take up to 48 game hours to update.")
	ENDEVENT
ENDSTATE

STATE INJECT_25S
	EVENT OnSelectST()
		int index = 0
		WHILE index < Injection_Count
			LItemScroll25Skill.AddForm(GSA_Litem_Schematics,1,1)
			index += 1
		ENDWHILE
		SetTextOptionValue(blacksmith4,LItemScroll25Skill.GetNumForms())
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("This injects schematics instead of manuals. Good for more loot focused playthroughs.\nThis loot list normally contains just master level scrolls.\nMay take up to 48 game hours to update.")
	ENDEVENT
ENDSTATE

STATE INJECTION_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(Injection_Count)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		Injection_Count = value AS INT
		SetSliderOptionValueST(value)
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(1.0)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("How many times you inject per click")
	ENDEVENT
ENDSTATE

STATE ARCANE_EXP_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GSA_ArcaneExp.GetValue())
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(0.1)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GSA_ArcaneExp.SetValue(value)
		SetSliderOptionValueST(value)
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(50.0)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Smithing experience generated when crafting an unidentified item.")
	ENDEVENT
ENDSTATE
GLOBALVARIABLE PROPERTY GSA_ArcaneExp AUTO

STATE SALVAGE_EXP_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GSA_SalvageExp.GetValue())
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(0.1)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GSA_SalvageExp.SetValue(value)
		SetSliderOptionValueST(value)
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(15.0)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Smithing experience generated per resource generated from salvaging.\nYou gain at least 1 resource per 10 unit weight by default.")
	ENDEVENT
ENDSTATE
GLOBALVARIABLE PROPERTY GSA_SalvageExp AUTO

STATE SALVAGE_RATIO_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GSA_WeightPerIngot.GetValue())
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GSA_WeightPerIngot.SetValue(value)
		SetSliderOptionValueST(value,"{1}")
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(10.0,"{1}")
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("You gain 1 resource per this unit weight when salvaging, plus at least one resource.")
	ENDEVENT
ENDSTATE

GLOBALVARIABLE PROPERTY GSA_WeightPerIngot AUTO

int Injection_Count = 1
int blacksmith1
int blacksmith2
int blacksmith3
int blacksmith4
LEVELEDITEM PROPERTY LItemScroll100Skill AUTO
LEVELEDITEM PROPERTY LItemScroll75Skill AUTO
LEVELEDITEM PROPERTY LItemScroll50Skill AUTO
LEVELEDITEM PROPERTY LItemScroll25Skill AUTO
FORM PROPERTY GSA_Litem_Books AUTO
FORM PROPERTY GSA_Litem_Schematics AUTO
GLOBALVARIABLE PROPERTY GSA_CanTemper AUTO

GSA_MenuMainPlayerRef PROPERTY playerAlias AUTO
STATE REEQUIP_TOGGLE
	EVENT OnSelectST()
		IF playerAlias.swapToggle
			playerAlias.swapToggle = false
			SetToggleOptionValueST(false)
		ELSE
			playerAlias.swapToggle = true
			SetToggleOptionValueST(true)
		ENDIF
	ENDEVENT
	
	EVENT OnDefaultST()
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("If this is checked, the player will re-equip any signature weapons when the game loads.\n This is done to refresh the appearance of your signature weapon.")
	ENDEVENT
ENDSTATE

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

STATE TEMPER_TOGGLE
	EVENT OnSelectST()
		IF GSA_CanTemper.GetValueInt()
			GSA_CanTemper.SetValueInt(0)
			SetToggleOptionValueST(false)
		ELSE
			GSA_CanTemper.SetValueInt(1)
			SetToggleOptionValueST(true)
		ENDIF
	ENDEVENT
	
	EVENT OnDefaultST()
		GSA_CanTemper.SetValueInt(0)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("It'd be pretty OP if you could temper your signature items ontop of upgrading the, but if you can if you want.")
	ENDEVENT
ENDSTATE

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
				Game.ModPerkPoints(-1)
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

STATE SIG_ARMOR_1
	EVENT OnSelectST()
		togglePerk(GSA_Perk_SignatureArmor)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GSA_Perk_SignatureArmor)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("This perk unlocks the ability to engrave armors as signature armors, craft upgrades, and apply upgrades to signature armors.")
	ENDEVENT
ENDSTATE

STATE SIG_WEAPON_1
	EVENT OnSelectST()
		togglePerk(GSA_Perk_SignatureArms)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GSA_Perk_SignatureArms)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("This perk unlocks the ability to engrave weapons as signature weapons, craft upgrades, and apply upgrades to signature weapons.")
	ENDEVENT
ENDSTATE

STATE SIG_WEAPON_2
	EVENT OnSelectST()
		togglePerk(GSA_Perk_SignatureArms2)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GSA_Perk_SignatureArms2)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Requires Signature Weapons and level 40 smithing.\n+1 Weapon Upgrade Slot. Gain the ability to craft random unidentified weapons with ingots and leather.")
	ENDEVENT
ENDSTATE

STATE SIG_WEAPON_3
	EVENT OnSelectST()
		togglePerk(GSA_Perk_SignatureArms3)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GSA_Perk_SignatureArms3)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Requires Extra Weapon Slot Perk and level 80 smithing.\nCan craft crit effect upgrades.\nAdds an additional upgrade slot.")
	ENDEVENT
ENDSTATE

STATE BLADE_OILS
	EVENT OnSelectST()
		togglePerk(GSA_Perk_BladeOils)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GSA_Perk_BladeOils)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Requires level 60 smithing and Cutting Edge Perk or Smithing Perk or Signature Arts Perk.\nCan craft blade oil upgrades.\nBlade oils do not use an upgrade slot, but limit 1 oil per signature weapon.")
	ENDEVENT
ENDSTATE

STATE SALVAGE_SLOT
	EVENT OnSelectST()
		togglePerk(GSA_Perk_Salvage)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GSA_Perk_Salvage)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Requires level 50 smithing and Signature Armors Perk.\n+1 Armor Upgrade Slot. Gain the ability to craft random unidentified armor with ingots and leather.")
	ENDEVENT
ENDSTATE

STATE CRAFTING
	EVENT OnSelectST()
		togglePerk(GSA_Perk_Crafting)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GSA_Perk_Crafting)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Requires level 30 smithing and Signature Armors Perk or Signature Weapons Perk.\nGain all vanilla smithing perks scaled to smithing level.\nGain the ability to craft random unidentified jewelry and robes with gems, silver, and gold ingots.")
	ENDEVENT
ENDSTATE

STATE SIG_ARTS
	EVENT OnSelectST()
		togglePerk(GSA_Perk_AbilitySlot)
	ENDEVENT
	
	EVENT OnDefaultST()
		PlayerRef.RemovePerk(GSA_Perk_AbilitySlot)
		SetToggleOptionValueST(false)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Requires level 70 smithing and Salvage Perk or Blade Oils Perk.\nYou can craft armor upgrades that modify your armored arts abilities.\n +1 Armor Upgrade Slot.")
	ENDEVENT
ENDSTATE

PERK PROPERTY GSA_Perk_SignatureArmor AUTO
PERK PROPERTY GSA_Perk_AbilitySlot AUTO
PERK PROPERTY GSA_Perk_BladeOils AUTO
PERK PROPERTY GSA_Perk_Crafting AUTO
PERK PROPERTY GSA_Perk_Salvage AUTO
PERK PROPERTY GSA_Perk_SignatureArms AUTO
PERK PROPERTY GSA_Perk_SignatureArms2 AUTO
PERK PROPERTY GSA_Perk_SignatureArms3 AUTO

STATE UPGRADE_SCALE_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue((GSA_BPerk_UpgradeScaling.GetNthEntryValue(0,1)*10000.0)+100.0)
		SetSliderDialogDefaultValue(200.0)
		SetSliderDialogRange(100.0,1000.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GSA_BPerk_UpgradeScaling.SetNthEntryValue(0,1,(value/10000.0) - 0.01)
		IF value == 100.0
			PlayerRef.RemovePerk(GSA_BPerk_UpgradeScaling)
		ELSE
			PlayerRef.AddPerk(GSA_BPerk_UpgradeScaling)
		ENDIF
		SetSliderOptionValueST(value)
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(200.0)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Determines how much your upgrades improve with smithing level.\n100% means no change from smithing level.\n200% means upgrades are twice as powerful at level 100.")
	ENDEVENT
ENDSTATE
PERK PROPERTY GSA_BPerk_UpgradeScaling AUTO

STATE UPGRADE_MAG_SLIDER
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(GSA_BPerk_UpgradeMag.GetNthEntryValue(0,1)*100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0,1000.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		GSA_BPerk_UpgradeMag.SetNthEntryValue(0,1,value/100.0)
		IF value == 100.0
			PlayerRef.RemovePerk(GSA_BPerk_UpgradeMag)
		ELSE
			PlayerRef.AddPerk(GSA_BPerk_UpgradeMag)
		ENDIF
		SetSliderOptionValueST(value)
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(100.0)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Multiplier for the magnitude of your upgrade effects.")
	ENDEVENT
ENDSTATE
PERK PROPERTY GSA_BPerk_UpgradeMag AUTO

GSA_WeaponAlias PROPERTY BattleaxeAlias AUTO
GSA_WeaponAlias PROPERTY BowAlias AUTO
GSA_WeaponAlias PROPERTY CrossbowAlias AUTO
GSA_WeaponAlias PROPERTY DaggerAlias AUTO
GSA_WeaponAlias PROPERTY GreatswordAlias AUTO
GSA_WeaponAlias PROPERTY MaceAlias AUTO
GSA_WeaponAlias PROPERTY SwordAlias AUTO
GSA_WeaponAlias PROPERTY WarAxeAlias AUTO
GSA_WeaponAlias PROPERTY WarhammerAlias AUTO

GSA_ArmorAlias PROPERTY LightHelmetAlias AUTO
GSA_ArmorAlias PROPERTY LightCuirassAlias AUTO
GSA_ArmorAlias PROPERTY LightGauntletsAlias AUTO
GSA_ArmorAlias PROPERTY LightBootsAlias AUTO
GSA_ArmorAlias PROPERTY LightShieldAlias AUTO

GSA_ArmorAlias PROPERTY HeavyHelmetAlias AUTO
GSA_ArmorAlias PROPERTY HeavyCuirassAlias AUTO
GSA_ArmorAlias PROPERTY HeavyGauntletsAlias AUTO
GSA_ArmorAlias PROPERTY HeavyBootsAlias AUTO
GSA_ArmorAlias PROPERTY HeavyShieldAlias AUTO

ACTOR PROPERTY PlayerRef AUTO

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

GLOBALVARIABLE PROPERTY GUISE_Hotkey_Salvage AUTO
GLOBALVARIABLE PROPERTY GUISE_Hotkey_Combined AUTO

STATE SALVAGE_KEY_OID
	EVENT OnKeyMapChangeST(int a_keyCode, string a_conflictControl, string a_conflictName)
		GUISE_Hotkey_Salvage.SetValueInt(a_keyCode)
		SetKeyMapOptionValueST(a_keyCode)
	ENDEVENT

	EVENT OnDefaultST()
		GUISE_Hotkey_Salvage.SetValueInt(2)
		SetKeyMapOptionValueST(2)
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("Clicking this button in your inventory will salvage armor and weapons into other materials.")
	ENDEVENT	
ENDSTATE
STATE COMBINED_KEY_OID
	EVENT OnKeyMapChangeST(int a_keyCode, string a_conflictControl, string a_conflictName)
		GUISE_Hotkey_Combined.SetValueInt(a_keyCode)
		SetKeyMapOptionValueST(a_keyCode)
	ENDEVENT

	EVENT OnDefaultST()
		GUISE_Hotkey_Combined.SetValueInt(5)
		SetKeyMapOptionValueST(5)
	ENDEVENT

	EVENT OnHighlightST()
		SetInfoText("Clicking this button in your inventory will bring up a menu with all of GUISE's inventory options.")
	ENDEVENT	
ENDSTATE

STATE LIGHT_HELMET_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(LightHelmetAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		LightHelmetAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE LIGHT_CUIRASS_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(LightCuirassAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		LightCuirassAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE LIGHT_GAUNTLETS_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(LightGauntletsAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		LightGauntletsAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE LIGHT_BOOTS_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(LightBootsAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		LightBootsAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE LIGHT_SHIELD_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(LightShieldAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		LightShieldAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE HEAVY_HELMET_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(HeavyHelmetAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		HeavyHelmetAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE HEAVY_CUIRASS_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(HeavyCuirassAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		HeavyCuirassAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE HEAVY_GAUNTLETS_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(HeavyGauntletsAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		HeavyGauntletsAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE HEAVY_BOOTS_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(HeavyBootsAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		HeavyBootsAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE HEAVY_SHIELD_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(HeavyShieldAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		HeavyShieldAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE BOW_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(BowAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		BowAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE SWORD_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(SwordAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		SwordAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE WARAXE_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(WarAxeAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		WarAxeAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE MACE_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(MaceAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		MaceAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE DAGGER_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(DaggerAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		DaggerAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE CROSSBOW_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(CrossbowAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		CrossbowAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE GREATSWORD_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(GreatswordAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		GreatswordAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE BATTLEAXE_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(BattleaxeAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		BattleaxeAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE

STATE WARHAMMER_RENAME
	EVENT OnInputOpenST()
		SetInputDialogStartText(WarhammerAlias.GetMyName())
	ENDEVENT
	
	EVENT OnInputAcceptST(STRING a_input)
		WarhammerAlias.SetMyName(a_input)
		SetInputOptionValueST(a_input)
	ENDEVENT
ENDSTATE