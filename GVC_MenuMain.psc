scriptname GVC_MenuMain extends SKI_ConfigBase

ACTOR PROPERTY PlayerRef AUTO
OBJECTREFERENCE PROPERTY GVC_Toxicity_Count_Container AUTO
FORM PROPERTY Gold001 AUTO

INT FUNCTION GetVersion()
	return 2
ENDFUNCTION

EVENT OnVersionUpdate(int a_version)
	refreshPages()
ENDEVENT

EVENT OnConfigInit()
	ModName = "Grimy: Vile Concoctions"
	PlayerRef.AddSpell(GUISE_AB_Inventory_Hotkey)
	refreshPages()
ENDEVENT

FUNCTION refreshPages()
	Pages = new string[4]
	Pages[0] = "Setup"
	Pages[1] = "Settings"
	Pages[2] = "Perks"
	Pages[3] = "Info"
ENDFUNCTION

EVENT OnPageReset(string page)
	IF ( page == "Perks" )
		GrenadierOID_T = addToggleOption("Grenadier", PlayerRef.HasPerk(GVC_Perk_A01_Grenadier) )
		AlchemistOID_T = addToggleOption("Toxicity", PlayerRef.HasPerk(GVC_Perk_A02_Alchemist) )
		SapperOID_T = addToggleOption("Sapper", PlayerRef.HasPerk(GVC_Perk_A03_Sapper) )
		HeartyThirstOID_T = addToggleOption("Hearty Thirst", PlayerRef.HasPerk(GVC_Perk_A04_HeartyThirst) )
		ConcentratedPoisonOID_T = addToggleOption("Snakeblood", PlayerRef.HasPerk(GVC_Perk_A05_ConcentratedPoison) )
		ArtificerOID_T = addToggleOption("Artificer", PlayerRef.HasPerk(GVC_Perk_A06_Artificer) )
		GastromancyOID_T = addToggleOption("Gastromancy", PlayerRef.HasPerk(GVC_Perk_A07_Gastromancy) )
		NaturesBalmOID_T = addToggleOption("Alcohest", PlayerRef.HasPerk(GVC_Perk_A08_NaturesBalm) )
		LethalDoseOID_T = addToggleOption("Lethal Dose", PlayerRef.HasPerk(GVC_Perk_A09_LethalDose) )
		AromaticsOID_T = addToggleOption("Aromatics", PlayerRef.HasPerk(GVC_Perk_A10_Aromatics) )
		DesensitizationOID_T = addToggleOption("Desensitization", PlayerRef.HasPerk(GVC_Perk_A11_Desensitization) )
		EfficientFilteringOID_T = addToggleOption("Efficient Filtering", PlayerRef.HasPerk(GVC_Perk_A12_EfficientFiltering) )
		MithridizationOID_T = addToggleOption("Mithridization", PlayerRef.HasPerk(GVC_Perk_A13_Mithridization) )
	ELSEIF ( page == "Info" )
		Credits1OID_T = addTextOption("Modder:","Grimy Bunyip")
		addEmptyOption()
		Credits2OID_T = addTextOption("Mesh Artist:","SDD707")
		Credits5OID_T = addTextOption("Mortar Mesh:","Oaristys & Tony67")
		Credits3OID_T = addTextOption("Playtester:","XPaToSoNX")
		Credits4OID_T = addTextOption("Playtester:","Robsongolightly")
	ELSEIF ( page == "Setup" )
		GVC_AB_Hotkey_GrenadierOID_T = addToggleOption("Register Explosives Hotkey", PlayerRef.HasSpell(GVC_AB_Hotkey_Grenadier))
		explosivesHotkeyOID = addKeyMapOption("Explosives Hotkey", GVC_KeyNum_Grenade.GetValueInt() )
		Inventory_Hotkey_T = addToggleOption("Register Inventory Hotkeys", PlayerRef.hasSpell(GUISE_AB_Inventory_Hotkey))
		Extractor_HotkeyOID = addKeymapOption("Extractor Hotkey", GUISE_Hotkey_Extractor.GetValueInt() )
		AddKeyMapOptionST("COMBINED_KEY_OID","GUISE Combined Inventory Key",GUISE_Hotkey_Combined.GetValueInt())
		addSliderOptionST("LOADMESSAGE_SLIDER","GUISE Loading Message Frequency", GUISE_LoadingMessages.GetValue())
	ELSE ; ( page == "Settings" )
		SetCursorFillMode(TOP_TO_BOTTOM)
		header1OID = addHeaderOption("Toxicity")
		toxicityOID_S = addSliderOption("Current Toxicity", GVC_Toxicity_Count_Container.GetItemCount(GVC_Toxicity_Count), "{0}")
		maxToxicityOID_S = addSliderOption("Maximum Toxicity", GVC_MaxToxicity.GetValueInt(), "{0}")
		engineBaseOID_T = addToggleOption("Toggle Toxicity Engine", GVC_AB_Engine.GetValueInt())
		
		header4OID = addHeaderOption("Overdose")
		odVomitOID_T = addToggleOption("Overdose Expulsions", GVC_OD_Expulsions.GetValueInt())
		odHealthOID_S = addSliderOption("Overdose Damage Health", GVC_OD_Health.GetValue(), "{0}")
		odMagickaOID_S = addSliderOption("Overdose Damage Magicka", GVC_OD_Magicka.GetValue(), "{0}")
		odStaminaOID_S = addSliderOption("Overdose Damage Stamina", GVC_OD_Stamina.GetValue(), "{0}")
		odSlowOID_S = addSliderOption("Overdose Slow", GVC_OD_Slow.GetValue(), "{0}")
		odSkillsOID_S = addSliderOption("Overdose Skills", GVC_OD_Skills.GetValue(), "{0}")
		
		header5OID = addHeaderOption("Experience")
		xpPotionDurationOID_S = addSliderOption("Potion Experience Duration Mult", GVC_XP_PotionDuration.GetValue(), "{2}")
		xpPotionBaseOID_S = addSliderOption("Potion Experience Base", GVC_XP_PotionBase.GetValue(), "{0}")
		xpPoisonBaseOID_S = addSliderOption("Poison Experience Base", GVC_XP_PoisonBase.GetValue(), "{0}")
		xpExplGrenadeOID_S = addSliderOption("Grenade Explosion Experience", GVC_XP_ExplosionGrenade.GetValue(), "{0}")
		xpExplMineOID_S = addSliderOption("Mine Explosion Experience", GVC_XP_ExplosionMine.GetValue(), "{0}")
		xpExplArrowOID_S = addSliderOption("Arrow Explosion Experience", GVC_XP_ExplosionArrow.GetValue(), "{0}")
		xpExtractOID_S = addSliderOption("Extraction Experience",GVC_XP_Extraction.GetValue(),"{0}")
		
		SetCursorPosition(1)
		header2OID = addHeaderOption("Cooldown")
		potionCDOID_S = addSliderOption("Potion Cooldown", GVC_Base_Cooldown.GetValue(), "{1}")
		grenadeCDOID_S = addSliderOption("Grenade Cooldown", GVC_Grenade_Cooldown.GetValue(), "{1}")
		;hemoCDOID_S = addSliderOption("Hemotoxin Cooldown", GVC_Hemotoxin_Cooldown.GetValue(), "{1}")
		overdoseCDOID_S = addSliderOption("Overdose Cooldown", GVC_Overdose_Cooldown.GetValue(), "{1}")
		scaleCDOID_S = addSliderOption("Potion Cooldown Scaling", 1.0 - GVC_ScaleCooldown.GetValue()*100.0 , "{2}")
		
		header3OID = addHeaderOption("Balance")
		addSliderOptionST("ALCOHEST_COUNT", "Alcohest Refill Count", AlcohestCount)
		modExplOID_S = addSliderOption("Explosive Magnitude Mult", GVC_Base_ExplosiveMag.GetNthEntryValue(0,0), "{2}")
		scaleExplOID_S = addSliderOption("Explosive Magnitude Scaling", GVC_Base_ScaleExplosiveMag.GetNthEntryValue(0,1)*100.0 + 1.0, "{1}")
		sneakExplOID_S = addSliderOption("Explosive Sneak Mult", GVC_Base_SneakExplosion.GetNthEntryValue(0,0), "{2}")
		GVC_Base_ScaleAVModOID_T = addToggleOption("Alchemy Magic Effect Scaling", PlayerRef.HasPerk(GVC_Base_ScaleAVMod) )
		foodMagOID_S = addSliderOption("Food Magnitude Mult",GVC_Base_FoodMag.GetNthEntryValue(0,0), "{2}")
		foodDurOID_S = addSliderOption("Food Duration Mult",GVC_Base_FoodDur.GetNthEntryValue(0,0), "{2}")
		
		header6OID = addHeaderOption("Misc")
		CraftingMenu_OID = addToggleOption("Register Crafting Menu Hotkeys", PlayerRef.hasSpell(GUISE_AB_CraftingMenu_Hotkey))
		wateredDownOID_S = addKeyMapOption("Watered Down Key", GUISE_Hotkey_WateredDown.GetValueInt())
		gastroHealOID_S = addSliderOption("Gastromancy Heal", GVC_GastromancyHeal.GetValue(), "{1}")
		potionPowderOID_S = addSliderOption("Powders Per Potion",GVC_numPotionExtraction.GetValueInt())
	ENDIF
ENDEVENT

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

STATE ALCOHEST_COUNT
	EVENT OnSliderOpenST()
		SetSliderDialogStartValue(AlcohestCount)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0,100.0)
		SetSliderDialogInterval(1.0)
	ENDEVENT
	
	EVENT OnSliderAcceptST(float value)
		AlcohestCount = value AS INT
		SetSliderOptionValueST(value)
	ENDEVENT

	EVENT OnDefaultST()
		SetSliderOptionValueST(4.0)
	ENDEVENT
	
	EVENT OnHighlightST()
		SetInfoText("Number of potion doses restored with the alcohest perk.")
	ENDEVENT
ENDSTATE

FUNCTION togglePerk(PERK akPerk, int perkOID)
	IF PlayerRef.HasPerk(akPerk)
		IF ShowMessage("Refund a perk point?",true,"Refund Perk","No Perk Point")
			Game.ModPerkpoints(1)
		ENDIF
		PlayerRef.RemovePerk(akPerk)
		SetToggleOptionValue(perkOID,false)
	ELSE
		IF ShowMessage("Deduct a perk point?",true,"Deduct Perk","Free Perk")
			IF Game.GetPerkPoints() > 0
				Game.ModperkPoints(-1)
				PlayerRef.AddPerk(akPerk)
				SetToggleOptionValue(perkOID,true)
			ELSE
				ShowMessage("You don't have any perk points",false)
			ENDIF
		ELSE
			PlayerRef.AddPerk(akPerk)
			SetToggleOptionValue(perkOID,true)
		ENDIF
	ENDIF
ENDFUNCTION

FUNCTION toggleSpell(SPELL akSpell, int spellOID)
	IF PlayerRef.HasSpell(akSpell)
		PlayerRef.RemoveSpell(akSpell)
		SetToggleOptionValue(spellOID,false)
	ELSE
		PlayerRef.AddSpell(akSpell,false)
		SetToggleOptionValue(spellOID,true)
	ENDIF
ENDFUNCTION

FUNCTION setSlider(float sliderStart, float sliderDefault, float sliderMin, float sliderMax, float sliderInt)
	SetSliderDialogStartValue(sliderStart)
	SetSliderDialogDefaultValue(sliderDefault)
	SetSliderDialogRange(sliderMin, sliderMax)
	SetSliderDialogInterval(sliderInt)
ENDFUNCTION

bool FUNCTION setLoadoutPerks(Perk akPerk1, Perk akPerk2, Perk akPerk3, int level, int cost, String ActorValue, int OID1, int OID2)
	IF ( ( PlayerRef.GetBaseActorValue(ActorValue) >= level ) && ( PlayerRef.GetGoldAmount() >= cost ) && ( PlayerRef.HasPerk(akPerk3) ) )
		IF ( ShowMessage("Are you sure? This perk will cost " + cost + " gold and will remove " + akPerk2.GetName() + " if you already have it.") )
			PlayerRef.AddPerk(akPerk1)
			PlayerRef.RemovePerk(akPerk2)
			PlayerRef.RemoveItem(Gold001, cost, true)
			SetToggleOptionValue(OID1, PlayerRef.HasPerk(akPerk1))
			SetToggleOptionValue(OID2, PlayerRef.HasPerk(akPerk2))
			return true
		ENDIF
		return false
	ELSE
		ShowMessage("You need " + cost + " gold, a skill level of " + level + ", and the prerequisite perk before you can purchase this loadout perk.",false)
		return false
	ENDIF
ENDFUNCTION

FUNCTION SetOverhaulHotKey(int option, Globalvariable akGlobal, int keyCode, Spell akSpell, bool akBool)
	akGlobal.SetValueInt(keyCode)
	IF akBool
	SetKeyMapOptionValue(option, keyCode )
		PlayerRef.RemoveSpell(akSpell)
		PlayerRef.AddSpell(akSpell, false)
	ENDIF
ENDFUNCTION

FUNCTION RefundPerk(Perk akPerk)
	IF PlayerRef.HasPerk(akPerk)
		Game.AddPerkPoints(1)
		PlayerRef.RemovePerk(akPerk)
	ENDIF
ENDFUNCTION

EVENT onOptionSelect(int option)
	IF ( option == GrenadierOID_T )
		togglePerk(GVC_Perk_A01_Grenadier,GrenadierOID_T)
	ELSEIF ( option == AlchemistOID_T )
		togglePerk(GVC_Perk_A02_Alchemist,AlchemistOID_T)
	ELSEIF ( option == SapperOID_T )
		togglePerk(GVC_Perk_A03_Sapper,SapperOID_T)
	ELSEIF ( option == HeartyThirstOID_T )
		togglePerk(GVC_Perk_A04_HeartyThirst,HeartyThirstOID_T)
	ELSEIF ( option == ConcentratedPoisonOID_T )
		togglePerk(GVC_Perk_A05_ConcentratedPoison,ConcentratedPoisonOID_T)
	ELSEIF ( option == ArtificerOID_T )
		togglePerk(GVC_Perk_A06_Artificer,ArtificerOID_T)
	ELSEIF ( option == GastromancyOID_T )
		togglePerk(GVC_Perk_A07_Gastromancy,GastromancyOID_T)
	ELSEIF ( option == NaturesBalmOID_T )
		togglePerk(GVC_Perk_A08_NaturesBalm,NaturesBalmOID_T)
	ELSEIF ( option == LethalDoseOID_T )
		togglePerk(GVC_Perk_A09_LethalDose,LethalDoseOID_T)
	ELSEIF ( option == AromaticsOID_T )
		togglePerk(GVC_Perk_A10_Aromatics,AromaticsOID_T)
	ELSEIF ( option == DesensitizationOID_T )
		togglePerk(GVC_Perk_A11_Desensitization,DesensitizationOID_T)
	ELSEIF ( option == EfficientFilteringOID_T )
		togglePerk(GVC_Perk_A12_EfficientFiltering,EfficientFilteringOID_T)
	ELSEIF ( option == MithridizationOID_T )
		togglePerk(GVC_Perk_A13_Mithridization,MithridizationOID_T)
	ELSEIF ( option == engineBaseOID_T )
		 IF GVC_AB_Engine.GetValueInt()
			GVC_AB_Engine.SetValueInt(0)
		 ELSE
			GVC_AB_Engine.SetValueInt(1)
		 ENDIF
		SetToggleOptionValue(engineBaseOID_T, GVC_AB_Engine.GetValueInt())
	ELSEIF ( option == odVomitOID_T )
		 IF GVC_OD_Expulsions.GetValueInt()
			GVC_OD_Expulsions.SetValueInt(0)
		 ELSE
			GVC_OD_Expulsions.SetValueInt(1)
		 ENDIF
		SetToggleOptionValue(odVomitOID_T, GVC_OD_Expulsions.GetValueInt())
	ELSEIF ( option == GVC_Base_ScaleAVModOID_T )
		togglePerk(GVC_Base_ScaleAVMod,GVC_Base_ScaleAVModOID_T)
	ELSEIF ( option == GVC_AB_Hotkey_GrenadierOID_T )
		toggleSpell(GVC_AB_Hotkey_Grenadier,GVC_AB_Hotkey_GrenadierOID_T)
	ELSEIF ( option == CraftingMenu_OID )
		toggleSpell(GUISE_AB_CraftingMenu_Hotkey,CraftingMenu_OID)
	ELSEIF ( option == Inventory_Hotkey_T )
		toggleSpell(GUISE_AB_Inventory_Hotkey,Inventory_Hotkey_T)
	ENDIF
ENDEVENT
		
EVENT onOptionSliderOpen(int option)
	IF ( option == toxicityOID_S )
		setSlider(GVC_Toxicity_Count_Container.GetItemCount(GVC_Toxicity_Count), 0, 0, 10, 1)
	ELSEIF ( option == potionCDOID_S )
		setSlider(GVC_Base_Cooldown.GetValue(), 10.0, 0.0, 600.0, 0.1)
	ELSEIF ( option == maxToxicityOID_S )
		setSlider(GVC_MaxToxicity.GetValueInt(), 3, 0, 10, 1)
	ELSEIF ( option == grenadeCDOID_S )
		setSlider(GVC_Grenade_Cooldown.GetValue(), 10.0, 0.1, 600.0, 0.1)
	;ELSEIF ( option == hemoCDOID_S )
	;	setSlider(GVC_Hemotoxin_Cooldown.GetValue(), 15.0, 0.1, 600.0, 0.1)
	ELSEIF ( option == overdoseCDOID_S )
		setSlider(GVC_Overdose_Cooldown.GetValue(), 60.0, 0.0, 600.0, 0.1)
	ELSEIF ( option == scaleCDOID_S )
		setSlider(1.0 - GVC_ScaleCooldown.GetValue()*100.0, 0.6, 0.0, 1.0, 0.01)
	ELSEIF ( option == odHealthOID_S )
		setSlider(GVC_OD_Health.GetValue(), 100.0, 0.0, 1000.0, 1)
	ELSEIF ( option == odMagickaOID_S )
		setSlider(GVC_OD_Magicka.GetValue(), 100.0, 0.0, 1000.0, 1)
	ELSEIF ( option == odStaminaOID_S )
		setSlider(GVC_OD_Stamina.GetValue(), 100.0, 0.0, 1000.0, 1)
	ELSEIF ( option == odSlowOID_S )
		setSlider(GVC_OD_Slow.GetValue(), 50.0, 0.0, 200.0, 1)
	ELSEIF ( option == odSkillsOID_S )
		setSlider(GVC_OD_Skills.GetValue(), 15.0, 0.0, 200.0, 1)
	ELSEIF ( option == scaleExplOID_S )
		setSlider(GVC_Base_ScaleExplosiveMag.GetNthEntryValue(0,1)*100.0 + 1.0, 2.0, 1.0, 10.0, 0.1)
	ELSEIF ( option == xpPotionDurationOID_S )
		setSlider(GVC_XP_PotionDuration.GetValue(), 0.5, 0.0, 10.0, 0.01)
	ELSEIF ( option == sneakExplOID_S )
		setSlider(GVC_Base_SneakExplosion.GetNthEntryValue(0,0), 3.0, 1.0, 10.0, 0.01)
	ELSEIF ( option == modExplOID_S )
		setSlider(GVC_Base_ExplosiveMag.GetNthEntryValue(0,0), 1.0, 0.0, 10.0, 0.01)
	ELSEIF ( option == foodMagOID_S )
		setSlider(GVC_Base_FoodMag.GetNthEntryValue(0,0), 1.0, 0.0, 10.0, 0.01)
	ELSEIF ( option == foodDurOID_S )
		setSlider(GVC_Base_FoodDur.GetNthEntryValue(0,0), 1.0, 0.0, 10.0, 0.01)
	ELSEIF ( option == xpPotionBaseOID_S )
		setSlider(GVC_XP_PotionBase.GetValue(), 25.0, 0.0, 1000.0, 1)
	ELSEIF ( option == xpPoisonBaseOID_S )
		setSlider(GVC_XP_PoisonBase.GetValue(), 25.0, 0.0, 1000.0, 1)
	ELSEIF ( option == xpExplGrenadeOID_S )
		setSlider(GVC_XP_ExplosionGrenade.GetValue(), 50.0, 0.0, 1000.0, 1)
	ELSEIF ( option == gastroHealOID_S )
		setSlider(GVC_GastromancyHeal.GetValue(), 15.0, 0.0, 600.0, 0.1)
	ELSEIF ( option == xpExplMineOID_S )
		setSlider(GVC_XP_ExplosionMine.GetValue(), 100.0, 0.0, 1000.0, 1)
	ELSEIF ( option == xpExplArrowOID_S )
		setSlider(GVC_XP_ExplosionArrow.GetValue(), 10.0, 0.0, 1000.0, 1)
	ELSEIF ( option == xpExtractOID_S )
		setSlider(GVC_XP_Extraction.GetValue(), 25.0, 0, 1000.0, 1.0)
	ELSEIF ( option == potionPowderOID_S )
		setSlider(GVC_numPotionExtraction.GetValueInt(), 4.0, 1.0, 20.0, 1.0)
	ENDIF
ENDEVENT

EVENT OnOptionSliderAccept(int option, float value)
	IF ( option == toxicityOID_S )
		GVC_Toxicity_Count_Container.RemoveItem(GVC_Toxicity_Count, GVC_Toxicity_Count_Container.GetItemCount(GVC_Toxicity_Count), true)
		GVC_Toxicity_Count_Container.AddItem(GVC_Toxicity_Count, value AS INT, true)
		SetSliderOptionValue(toxicityOID_S, GVC_Toxicity_Count_Container.GetItemCount(GVC_Toxicity_Count),"{0}")
	ELSEIF ( option == potionCDOID_S )
		GVC_Base_Cooldown.SetValue(value)
		SetSliderOptionValue(potionCDOID_S, value,"{1}")
	ELSEIF ( option == maxToxicityOID_S )
		GVC_MaxToxicity.SetValueInt(value AS INT)
		SetSliderOptionValue(maxToxicityOID_S, value AS INT,"{0}")
	ELSEIF ( option == grenadeCDOID_S )
		GVC_Grenade_Cooldown.SetValue(value)
		SetSliderOptionValue(grenadeCDOID_S, value,"{1}")
	;ELSEIF ( option == hemoCDOID_S )
	;	GVC_Hemotoxin_Cooldown.SetValue(value)
	;	SetSliderOptionValue(hemoCDOID_S, value,"{1}")
	ELSEIF ( option == overdoseCDOID_S )
		GVC_Overdose_Cooldown.SetValue(value)
		SetSliderOptionValue(overdoseCDOID_S, value,"{1}")
	ELSEIF ( option == scaleCDOID_S )
		GVC_ScaleCooldown.SetValue(0.01-value/100.0)
		SetSliderOptionValue(scaleCDOID_S, value,"{2}")
	ELSEIF ( option == odHealthOID_S )
		GVC_OD_Health.SetValue(value)
		SetSliderOptionValue(odHealthOID_S, value,"{0}")
	ELSEIF ( option == odMagickaOID_S )
		GVC_OD_Magicka.SetValue(value)
		SetSliderOptionValue(odMagickaOID_S, value,"{0}")
	ELSEIF ( option == odStaminaOID_S )
		GVC_OD_Stamina.SetValue(value)
		SetSliderOptionValue(odStaminaOID_S, value,"{0}")
	ELSEIF ( option == odSlowOID_S )
		GVC_OD_Slow.SetValue(value)
		SetSliderOptionValue(odSlowOID_S, value,"{0}")
	ELSEIF ( option == odSkillsOID_S )
		GVC_OD_Skills.SetValue(value)
		SetSliderOptionValue(odSkillsOID_S, value,"{0}")
	ELSEIF ( option == scaleExplOID_S )
		IF value == 1.0
			PlayerRef.RemovePerk(GVC_Base_ScaleExplosiveMag)
		ELSE
			PlayerRef.AddPerk(GVC_Base_ScaleExplosiveMag)
		ENDIF
		GVC_Base_ScaleExplosiveMag.SetNthEntryValue(0,1, (value - 1.0)/100.0 )
		SetSliderOptionValue(scaleExplOID_S, value,"{1}")
	ELSEIF ( option == xpPotionDurationOID_S )
		GVC_XP_PotionDuration.SetValue(value)
		SetSliderOptionValue(xpPotionDurationOID_S, value,"{2}")
	ELSEIF ( option == sneakExplOID_S )
		IF value == 1.0
			PlayerRef.RemovePerk(GVC_Base_SneakExplosion)
		ELSE
			PlayerRef.AddPerk(GVC_Base_SneakExplosion)
		ENDIF
		GVC_Base_SneakExplosion.SetNthEntryValue(0,0,value)
		SetSliderOptionValue(sneakExplOID_S, value,"{2}")
	ELSEIF ( option == modExplOID_S )
		IF value == 1.0
			PlayerRef.RemovePerk(GVC_Base_ExplosiveMag)
		ELSE
			PlayerRef.AddPerk(GVC_Base_ExplosiveMag)
		ENDIF
		GVC_Base_ExplosiveMag.SetNthEntryValue(0,0,value)
		SetSliderOptionValue(modExplOID_S, value,"{2}")
	ELSEIF ( option == foodMagOID_S )
		IF value == 1.0
			PlayerRef.RemovePerk(GVC_Base_FoodMag)
		ELSE
			PlayerRef.AddPerk(GVC_Base_FoodMag)
		ENDIF
		GVC_Base_FoodMag.SetNthEntryValue(0,0,value)
		SetSliderOptionValue(foodMagOID_S, value,"{2}")
	ELSEIF ( option == foodDurOID_S )
		IF value == 1.0
			PlayerRef.RemovePerk(GVC_Base_FoodDur)
		ELSE
			PlayerRef.AddPerk(GVC_Base_FoodDur)
		ENDIF
		GVC_Base_FoodDur.SetNthEntryValue(0,0,value)
		SetSliderOptionValue(foodDurOID_S, value,"{2}")
	ELSEIF ( option == xpPotionBaseOID_S )
		GVC_XP_PotionBase.SetValue(value)
		SetSliderOptionValue(xpPotionBaseOID_S, value,"{0}")
	ELSEIF ( option == xpPoisonBaseOID_S )
		GVC_XP_PoisonBase.SetValue(value)
		SetSliderOptionValue(xpPoisonBaseOID_S, value,"{0}")
	ELSEIF ( option == xpExplGrenadeOID_S )
		GVC_XP_ExplosionGrenade.SetValue(value)
		SetSliderOptionValue(xpExplGrenadeOID_S, value,"{0}")
	ELSEIF ( option == gastroHealOID_S )
		GVC_GastromancyHeal.SetValue(value)
		SetSliderOptionValue(gastroHealOID_S, value,"{1}")
	ELSEIF ( option == xpExplMineOID_S )
		GVC_XP_ExplosionMine.SetValue(value)
		SetSliderOptionValue(xpExplMineOID_S, value,"{0}")
	ELSEIF ( option == xpExplArrowOID_S )
		GVC_XP_ExplosionArrow.SetValue(value)
		SetSliderOptionValue(xpExplArrowOID_S, value,"{0}")
	ELSEIF ( option == xpExtractOID_S )
		GVC_XP_Extraction.SetValue(value)
		SetSliderOptionValue(xpExtractOID_S, value,"{0}")
	ELSEIF ( option == potionPowderOID_S )
		GVC_numPotionExtraction.SetValueINT(value AS INT)
		SetSliderOptionValue(potionPowderOID_S, value,"{0}")
	ENDIF
ENDEVENT

EVENT OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	IF ( option == explosivesHotkeyOID )
		SetOverhaulHotKey(explosivesHotkeyOID, GVC_KeyNum_Grenade, keyCode, GVC_AB_Hotkey_Grenadier, PlayerRef.HasSpell(GVC_AB_Hotkey_Grenadier))
		PlayerRef.RemoveSpell(GVC_AB_Hotkey_Grenadier)
		PlayerRef.AddSpell(GVC_AB_Hotkey_Grenadier,false)
		SetToggleOptionValue(GVC_AB_Hotkey_GrenadierOID_T,true)
	ELSEIF ( option == WateredDownOID_S )
		GUISE_Hotkey_WateredDown.SetValueInt(keyCode)
		SetKeyMapOptionValue(WateredDownOID_S,keyCode)
	ELSEIF ( option == Extractor_HotkeyOID )
		GUISE_Hotkey_Extractor.SetValueInt(keyCode)
		SetKeyMapOptionValue(Extractor_HotkeyOID,keyCode)
	;ELSEIF ( option == hemoHotKeyOID )
	;	SetOverhaulHotKey(hemoHotKeyOID, GVC_KeyNum_Hemotoxin, keyCode, GVC_AB_Hotkey_Hemotoxin, PlayerRef.HasSpell(GVC_AB_Hotkey_Hemotoxin))
	;	PlayerRef.RemoveSpell(GVC_AB_Hotkey_Grenadier)
	;	PlayerRef.AddSpell(GVC_AB_Hotkey_Grenadier,false)
	;	SetToggleOptionValue(GVC_AB_Hotkey_HemotoxinOID_T,true)
	ENDIF
ENDEVENT

EVENT onOptionHighlight(int option)
	IF ( option == toxicityOID_S )
		SetInfoText("Your current level of toxicity.")
	ELSEIF ( option == potionCDOID_S )
		SetInfoText("The cooldown time between drinking potions.")
	ELSEIF ( option == maxToxicityOID_S )
		SetInfoText("Your maximum possible toxicity.")
	ELSEIF ( option == grenadeCDOID_S )
		SetInfoText("The cooldown time between throwing grenades.")
	ELSEIF ( option == engineBaseOID_T )
		SetInfoText("Enable or disable the Toxicity/Potion Cooldowns.")
	;ELSEIF ( option == hemoCDOID_S )
	;	SetInfoText("The cooldown time between applying hemotoxin.")
	ELSEIF ( option == overdoseCDOID_S )
		SetInfoText("The cooldown time for potion overdose.")
	ELSEIF ( option == odVomitOID_T )
		SetInfoText("Will the player vomit during an overdose?\nThe vomit will deal 20 damage, potentially hurting allies.")
	ELSEIF ( option == scaleCDOID_S )
		SetInfoText("Scales potion and overdose cooldown duration from 1.0x at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == odHealthOID_S )
		SetInfoText("Amount of Health lost during an overdose.")
	ELSEIF ( option == odMagickaOID_S )
		SetInfoText("Amount of Magicka lost during an overdose.")
	ELSEIF ( option == odStaminaOID_S )
		SetInfoText("Amount of Stamina lost during an overdose.")
	ELSEIF ( option == odSlowOID_S )
		SetInfoText("Amount by which the player's movement speed will be damaged while overdosed.")
	ELSEIF ( option == odSkillsOID_S )
		SetInfoText("Amount by which the player's skills will be damaged while overdosed.")
	ELSEIF ( option == scaleExplOID_S )
		SetInfoText("Scales explosives damage from 1.0x at lvl 0 to selected setting at lvl 100.")
	ELSEIF ( option == xpPotionDurationOID_S )
		SetInfoText("XP Gained for each second of duration on each potion effect.\nThis experience is not provided until the potion duration wears off, and will not be awarded if you overdose.\n571,425 experienced required to go from level 15 to 100.")
	ELSEIF ( option == sneakExplOID_S )
		SetInfoText("The base sneak mult for explosives, before perks.")
	ELSEIF ( option == modExplOID_S )
		SetInfoText("Multiplier for explosives damage.")
	ELSEIF ( option == foodMagOID_S )
		SetInfoText("Multiplier for food magnitude.")
	ELSEIF ( option == foodDurOID_S )
		SetInfoText("Multiplier for food duration.")
	ELSEIF ( option == xpPotionBaseOID_S )
		SetInfoText("Base XP Gained for each potion effect you gain.\n571,425 experienced required to go from level 15 to 100.")
	ELSEIF ( option == GVC_Base_ScaleAVModOID_T )
		SetInfoText("Makes Fortify Alchemy magic effects affect potion, poison, and explosives magnitude.")
	ELSEIF ( option == xpPoisonBaseOID_S )
		SetInfoText("XP Gained for each target you hit with a poison.\n571,425 experienced required to go from level 15 to 100.")
	ELSEIF ( option == xpExplGrenadeOID_S )
		SetInfoText("XP Gained for each target you hit with an explosion.\n571,425 experienced required to go from level 15 to 100.")
	ELSEIF ( option == gastroHealOID_S )
		SetInfoText("The amount of health healed by the Gastromancy perk.")
	ELSEIF ( option == xpExplMineOID_S )
		SetInfoText("XP Gained for each target you hit with an explosion.\n571,425 experienced required to go from level 15 to 100.")
	ELSEIF ( option == wateredDownOID_S )
		SetInfoText("Press this key in the alchemy menu to adjust how many potions you make per set of ingredients.\nMaking more potions decreases potion magnitude.")
	ELSEIF ( option == xpExplArrowOID_S )
		SetInfoText("XP Gained for each target you hit with an explosion.\n571,425 experienced required to go from level 15 to 100.")
	ELSEIF ( option == GVC_AB_Hotkey_GrenadierOID_T )
		SetInfoText("Enable/disable your throw Grenade/Proximity Mine Hotkey.\nYou can throw explosives while in combat or sneaking.\nClicking the hotkey out of combat will bring a menu to switch between explosives.")
	ELSEIF ( option == CraftingMenu_OID )
		SetInfoText("Enable/disable crafting menu hotkeys for all GUISE modules")
	ELSEIF ( option == Inventory_Hotkey_T )
		SetInfoText("Enable/disable inventory hotkeys. This is global for all of GUISE, so it will affect signature arms as well.")
	ELSEIF ( option == explosivesHotkeyOID )
		SetInfoText("Key to throw grenades without equipping them, but on a cooldown.\nYou can throw explosives while in combat or sneaking.\nClicking the hotkey out of combat will bring a menu to switch between explosives.")
	ELSEIF ( option == Extractor_HotkeyOID )
		SetInfoText("Pressing this key in the inventory will attempt to extract explosive powders from the selected item")
	ELSEIF ( option == Credits1OID_T )
		SetInfoText("Check out my other mods on Skyrim Nexus:\nhttp://skyrim.nexusmods.com/users/5910982")
	ELSEIF ( option == Credits2OID_T )
		SetInfoText("Provided meshes for proximity mines")
	ELSEIF ( option == Credits5OID_T )
		SetInfoText("Model resource used for mortar and pestle mesh:\nhttp://www.nexusmods.com/skyrim/mods/16525")
	ELSEIF ( option == xpExtractOID_S )
		SetInfoText("Experience provided per powder extracted.")
	ELSEIF ( option == potionPowderOID_S )
		SetInfoText("Number of powders extracted from a potion.")
	ELSEIF ( option == GrenadierOID_T )
		SetInfoText("Gain the ability to craft improvised explosives.")
	ELSEIF ( option == AlchemistOID_T )
		SetInfoText("Potion last thirty times longer. Alchemical effects increase toxicity. Start with a maximum toxicity of 3.")
	ELSEIF ( option == SapperOID_T )
		SetInfoText("Gain the ability to craft Proximity Mines.\nRequires level 30 alchemy and Grenadier.")
	ELSEIF ( option == HeartyThirstOID_T )
		SetInfoText("Restore potions are four times as effective. Drinking potions causes cooldowns with a base duration of 10 seconds.\nRequires level 30 alchemy and Grenadier or Toxicity.")
	ELSEIF ( option == ConcentratedPoisonOID_T )
		SetInfoText("Gain +1 poison dose every 10 poison resistance and lose poison doses for poison weakness.\n Consuming or extracting ingredients reveals all the effects.\nRequires level 30 alchemy and Grenadier or Lethal Dose.")
	ELSEIF ( option == ArtificerOID_T )
		SetInfoText("Gain the ability to craft explosive arrows.\nRequires level 45 alchemy and Sapper or Gastromancy.")
	ELSEIF ( option == GastromancyOID_T )
		SetInfoText("You no longer renerate health naturally. Eating food will restore 15 additional health. Gain +5 health for every player level. Up to 500.\nRequires level 45 alchemy and Hearty Thirst or Artificer.")
	ELSEIF ( option == NaturesBalmOID_T )
		SetInfoText("Mark up to 5 signature potions. When you wait, you use alcohest to refill your signature potions back up to 4 doses.\nRequires level 45 alchemy and Heaty Thirst or Lethal Dose.")
	ELSEIF ( option == LethalDoseOID_T )
		SetInfoText("Scales Poison Sneak Multiplier with Alchemy Level. Up to 3x at level 100.\nRequires level 45 alchemy and Snakeblood or Nature's Balm.")
	ELSEIF ( option == AromaticsOID_T )
		SetInfoText("Drinking restoration potions also affect nearby allies. Magnitude equals half of alchemy level.\nRequires level 60 alchemy and Artificer or Desensitization.")
	ELSEIF ( option == DesensitizationOID_T )
		SetInfoText("Fortify potions, that do not restore stats, no longer cause cooldowns.\nRequires level 60 alchemy and Lethal Dose or Aromatics.")
	ELSEIF ( option == EfficientFilteringOID_T )
		SetInfoText("Gain the ability to water down potions to produce more of them.\nRequires level 75 alchemy and Aromatics or Mithridization.")
	ELSEIF ( option == MithridizationOID_T )
		SetInfoText("+1 Maximum Toxicity. +50% Poison Resist.\nRequires level 75 alchemy and Desensitization or Efficient Filtering.")
	ENDIF
ENDEVENT

INT PROPERTY AlcohestCount AUTO
POTION[] PROPERTY SignaturePotionList AUTO
String[] Function GetPotionList()
	String[] retVal = new String[5]
	retVal[0] = GetPotionName(0)
	retVal[1] = GetPotionName(1)
	retVal[2] = GetPotionName(2)
	retVal[3] = GetPotionName(3)
	retVal[4] = GetPotionName(4)
	
	Return retVal
EndFunction

String Function GetPotionName(INT akIndex)
	String retString = ""
	If SignaturePotionList[akIndex] && SignaturePotionList[akIndex] != None
		retString = SignaturePotionList[akIndex].GetName()
	EndIf
	If retString == ""
		return "Empty"
	Endif
	Return retString
EndFunction

int xpExtractOID_S
int potionPowderOID_S
GLOBALVARIABLE PROPERTY GVC_numPotionExtraction AUTO
GLOBALVARIABLE PROPERTY GVC_XP_Extraction AUTO
GLOBALVARIABLE PROPERTy GUISE_Hotkey_WateredDown AUTO

PERK PROPERTY GVC_Perk_A01_Grenadier AUTO
PERK PROPERTY GVC_Perk_A02_Alchemist AUTO
PERK PROPERTY GVC_Perk_A03_Sapper AUTO
PERK PROPERTY GVC_Perk_A04_HeartyThirst AUTO
PERK PROPERTY GVC_Perk_A05_ConcentratedPoison AUTO
PERK PROPERTY GVC_Perk_A06_Artificer AUTO
PERK PROPERTY GVC_Perk_A07_Gastromancy AUTO
PERK PROPERTY GVC_Perk_A08_NaturesBalm AUTO
PERK PROPERTY GVC_Perk_A09_LethalDose AUTO
PERK PROPERTY GVC_Perk_A10_Aromatics AUTO
PERK PROPERTY GVC_Perk_A11_Desensitization AUTO
PERK PROPERTY GVC_Perk_A12_EfficientFiltering AUTO
PERK PROPERTY GVC_Perk_A13_Mithridization AUTO
int header1OID
int header2OID
int toxicityOID_S
FORM PROPERTY GVC_Toxicity_Count AUTO
int potionCDOID_S
GLOBALVARIABLE PROPERTY GVC_Base_Cooldown AUTO
int maxToxicityOID_S
GLOBALVARIABLE PROPERTY GVC_MaxToxicity AUTO
int grenadeCDOID_S
GLOBALVARIABLE PROPERTY GVC_Grenade_Cooldown AUTO
int engineBaseOID_T
GLOBALVARIABLE PROPERTY GVC_AB_Engine AUTO
;int hemoCDOID_S
;GLOBALVARIABLE PROPERTY GVC_Hemotoxin_Cooldown AUTO
int header4OID
int overdoseCDOID_S
GLOBALVARIABLE PROPERTY GVC_Overdose_Cooldown AUTO
int odVomitOID_T
GLOBALVARIABLE PROPERTY GVC_OD_Expulsions AUTO
int scaleCDOID_S
GLOBALVARIABLE PROPERTY GVC_ScaleCooldown AUTO
int odHealthOID_S
GLOBALVARIABLE PROPERTY GVC_OD_Health AUTO
int header3OID
int odMagickaOID_S
GLOBALVARIABLE PROPERTY GVC_OD_Magicka AUTO
int odStaminaOID_S
GLOBALVARIABLE PROPERTY GVC_OD_Stamina AUTO
int odSlowOID_S
GLOBALVARIABLE PROPERTY GVC_OD_Slow AUTO
int odSkillsOID_S
GLOBALVARIABLE PROPERTY GVC_OD_Skills AUTO
int scaleExplOID_S
int header5OID
int xpPotionDurationOID_S
GLOBALVARIABLE PROPERTY GVC_XP_PotionDuration AUTO
int sneakExplOID_S
int xpPotionBaseOID_S
GLOBALVARIABLE PROPERTY GVC_XP_PotionBase AUTO
int GVC_Base_ScaleAVModOID_T
int xpPoisonBaseOID_S
GLOBALVARIABLE PROPERTY GVC_XP_PoisonBase AUTO
int header6OID
int header7OID
int xpExplGrenadeOID_S
GLOBALVARIABLE PROPERTY GVC_XP_ExplosionGrenade AUTO
int gastroHealOID_S
GLOBALVARIABLE PROPERTY GVC_GastromancyHeal AUTO
int xpExplMineOID_S
GLOBALVARIABLE PROPERTY GVC_XP_ExplosionMine AUTO
int wateredDownOID_S
int xpExplArrowOID_S
GLOBALVARIABLE PROPERTY GVC_XP_ExplosionArrow AUTO
int modExplOID_S
int foodMagOID_S
int foodDurOID_S
GLOBALVARIABLE PROPERTY GUISE_LoadingMessages AUTO
PERK PROPERTY GVC_Base_FoodMag AUTO
PERK PROPERTY GVC_Base_FoodDur AUTO

int CraftingMenu_OID
SPELL PROPERTY GUISE_AB_CraftingMenu_Hotkey AUTO

int GVC_AB_Hotkey_GrenadierOID_T
int explosivesHotkeyOID
SPELL PROPERTY GVC_AB_Hotkey_Grenadier AUTO
GLOBALVARIABLE PROPERTY GVC_KeyNum_Grenade AUTO
;int GVC_AB_Hotkey_HemotoxinOID_T
;SPELL PROPERTY GVC_AB_Hotkey_Hemotoxin AUTO
;int hemoHotKeyOID
;GLOBALVARIABLE PROPERTY GVC_KeyNum_Hemotoxin AUTO
int Credits1OID_T
int Credits2OID_T
int Credits3OID_T
int Credits4OID_T
int Credits5OID_T

int GrenadierOID_T
int AlchemistOID_T
int SapperOID_T
int HeartyThirstOID_T
int ConcentratedPoisonOID_T
int ArtificerOID_T
int GastromancyOID_T
int NaturesBalmOID_T
int LethalDoseOID_T
int AromaticsOID_T
int DesensitizationOID_T
int EfficientFilteringOID_T
int MithridizationOID_T

PERK PROPERTY GVC_Base_ExplosiveMag AUTO
PERK PROPERTY GVC_Base_ScaleAVMod AUTO
PERK PROPERTY GVC_Base_ScaleExplosiveMag AUTO
PERK PROPERTY GVC_Base_SneakExplosion AUTO
PERK PROPERTY GVC_Cooldown AUTO
PERK PROPERTY GVC_CooldownFortify AUTO
PERK PROPERTY GVC_CooldownHealth AUTO
PERK PROPERTY GVC_CooldownMagicka AUTO
PERK PROPERTY GVC_CooldownStamina AUTO

INT Inventory_Hotkey_T
SPELL PROPERTY GUISE_AB_Inventory_Hotkey AUTO
INT Extractor_HotkeyOID
GLOBALVARIABLE PROPERTY GUISE_Hotkey_Extractor AUTO