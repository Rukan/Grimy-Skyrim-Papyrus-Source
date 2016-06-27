Scriptname GUI_MenuMain extends SKI_ConfigBase

ObjectReference[] PROPERTY objectList AUTO
ACTOR PROPERTY PlayerRef AUTO
SOUND PROPERTY UIMenuCancel AUTO
IMPORT FISSFactory
IMPORT GAME
IMPORT INPUT
IMPORT GrimyToolsPluginScript

INT FUNCTION GetVersion()
	return 6
ENDFUNCTION

EVENT OnVersionUpdate(int a_version)
	loadPages()
ENDEVENT

EVENT OnConfigInit()
	ModName = "Grimy Utilities"
	loadhotKeys()
	resetHealthPotionList()
	resetMagickaPotionList()
	resetStaminaPotionList()
	resetPoisonList()
	resetMisc1PotionList()
	resetMisc2PotionList()
ENDEVENT

Bool needConfig = false
Event OnConfigClose()
	If needConfig
		SKI_ConfigManager tempManager = (GetFormFromFile(0x00000802,"SkyUI.esp") AS SKI_ConfigManager)
		tempmanager.SetStage(1)
		needConfig = false
	EndIf
EndEvent

FUNCTION loadPages()
	Pages = new string[7]
	Pages[0] = "Hotkey Cast Spells"
	Pages[1] = "Hotkey Cast Balance"
	Pages[2] = "Utility Spells"
	Pages[3] = "Item Queue Tools"
	Pages[4] = "Perk Tools"
	Pages[5] = "Misc"
	Pages[6] = "MCM Renamer"
	renamerOID = new int[128]
ENDFUNCTION

EVENT OnKeyDown(Int KeyCode)
	IF ( IsLookingControlsEnabled() && !Utility.IsInMenuMode() && !((GUI_UILib as FORM) as UILIB_GRIMY).IsMenuOpen())
		IF ( KeyCode == wheelKey )
			PlayerRef.InterruptCast()
			INT wheelInt = (GUI_UILib As UIWheelMenu).OpenMenu(PlayerRef)
			IF wheelInt < 4
				IF wheelInt < 2
					IF wheelInt == 0
						HotCast(tempSpell1)
					ELSE ; wheelInt == 1
						HotCast(tempSpell2)
					ENDIF
				ELSE 
					IF wheelInt == 2
						HotCast(tempSpell3)
					ELSE ; wheelInt == 3
						HotCast(tempSpell4)
					ENDIF
				ENDIF				
			ELSE 
				IF wheelInt < 6
					IF wheelInt == 4
						HotCast(tempSpell5)
					ELSE ; wheelInt == 5
						HotCast(tempSpell6)
					ENDIF
				ELSE 
					IF wheelInt == 6
						HotCast(tempSpell7)
					ELSEIF wheelInt == 7
						HotCast(tempSpell8)
					ENDIF
				ENDIF			
			ENDIF
		ELSEIF ( KeyCode == hotKey1 ) && ( IsKeyPressed(Keymod1) || (Keymod1 == -1) )
			HotCast(tempSpell1)
		ELSEIF ( KeyCode == healthPotionHotKey )
			equipFromList(healthPotionList)
		ELSEIF ( KeyCode == hotKey2 ) && ( IsKeyPressed(Keymod2) || (Keymod2 == -1) )
			HotCast(tempSpell2)
		ELSEIF ( KeyCode == magickaPotionHotKey ) 
			equipFromList(magickaPotionList)
		ELSEIF ( KeyCode == hotKey3 ) && ( IsKeyPressed(Keymod3) || (Keymod3 == -1) )
			HotCast(tempSpell3)
		ELSEIF ( KeyCode == staminaPotionHotKey ) 
			equipFromList(staminaPotionList)
		ELSEIF ( KeyCode == hotKey4 ) && ( IsKeyPressed(Keymod4) || (Keymod4 == -1) )
			HotCast(tempSpell4)
		ELSEIF ( KeyCode == poisonHotKey ) 
			equipFromList(poisonList)
		ELSEIF ( KeyCode == hotKey5 ) && ( IsKeyPressed(Keymod5) || (Keymod5 == -1) )
			HotCast(tempSpell5)
		ELSEIF ( KeyCode == misc1PotionHotKey )
			equipFromList(misc1PotionList)
		ELSEIF ( KeyCode == hotKey6 ) && ( IsKeyPressed(Keymod6) || (Keymod6 == -1) )
			HotCast(tempSpell6)
		ELSEIF ( KeyCode == misc2PotionHotKey )
			equipFromList(misc2PotionList)
		ELSEIF ( KeyCode == hotKey7 ) && ( IsKeyPressed(Keymod7) || (Keymod7 == -1) )
			HotCast(tempSpell7)
		ELSEIF ( KeyCode == hotKey8 ) && ( IsKeyPressed(Keymod8) || (Keymod8 == -1) )
			HotCast(tempSpell8)
		ELSEIF ( KeyCode == hotKey9 ) && ( IsKeyPressed(Keymod9) || (Keymod9 == -1) )
			HotCast(tempSpell9)
		ELSEIF ( KeyCode == hotKey10 ) && ( IsKeyPressed(Keymod10) || (Keymod10 == -1) )
			HotCast(tempSpell10)
		ELSEIF ( KeyCode == hotKey11 ) && ( IsKeyPressed(Keymod11) || (Keymod11 == -1) )
			HotCast(tempSpell11)
		ENDIF
	ENDIF
ENDEVENT

float cooldownTime = 1.0
KEYWORD PROPERTY RitualSpellEffect AUTO
SOUND PROPERTY GUI_Sound AUTO
FUNCTION HotCast(SPELL akSpell)
	IF akSpell
		IF ( akSpell.HasKeyWord(RitualSpellEffect) )
			spellCost = akSpell.getEffectiveMagickaCost(PlayerRef)*ritualCostMult
		ELSE
			spellCost = akSpell.getEffectiveMagickaCost(PlayerRef)*costMult
		ENDIF

		IF ( canActionCast() && PlayerRef.GetActorValue("Magicka") >= spellCost )
			IF GetSpellSound(akSpell,3)
				SetSoundDescriptor(GUI_Sound, Game.GetForm(GetSpellSound(akSpell,3)) AS SOUNDDESCRIPTOR)
				GUI_Sound.Play(PlayerRef)
			ENDIF
			akSpell.Cast(PlayerRef)
			PlayerRef.DamageActorValue("Magicka", spellCost)
			akSpell.SendModEvent("SpellHotCast", "", 0.0)
			AdvanceSkill(akSpell.GetNthEffectMagicEffect(0).GetAssociatedSkill(),akSpell.GetMagickaCost()*experienceMult)
			canCast = false;
			IF ( akSpell.HasKeyWord(RitualSpellEffect) )
				Utility.Wait(akSpell.GetCastTime()*ritualCooldownMult)
			ELSE
				Utility.Wait(akSpell.GetCastTime()*cooldownMult)
			ENDIF
			canCast = true;
		ELSE
			UIMenuCancel.Play(PlayerRef)
		ENDIF
		SendModEvent("OnSpellHotCast")
	ENDIF
ENDFUNCTION

EVENT OnKeyUp(Int KeyCode, Float HoldTime)
	IF KeyCode != wheelKey
		PlayerRef.InterruptCast()
	ENDIF
ENDEVENT

EVENT OnPageReset(string page)
	loadPages()
	IF ( page == "Hotkey Cast Spells")
		setting01OID = addKeyMapOption("Hotcast Favorites Key",GUI_Hotkey_HotcastSpellSelect)
		setting02OID = addToggleOption("Register Spell Menu Keys",PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys))
		ForgetSpellOID = addKeyMapOption("Forget Spell Key",GUI_Hotkey_ForgetSpellKey)
		utility05_OID = addKeyMapOption("Add Spell To Mark Key",GUI_Hotkey_AddSpellToMark)
		utility11_OID = addKeyMapOption("Wheel Menu Hotkey",wheelKey)
		ResetKeysOID = addTextOption("Reset Key Bindings","GO!")
		setting03OID = addKeyMapOption("Key Modifier #1",Keymod1)
		setting04OID = addKeyMapOption("Hotkey #1",hotkey1)
		setting05OID = addKeyMapOption("Key Modifier #2",Keymod2)
		setting06OID = addKeyMapOption("Hotkey #2",hotkey2)
		setting07OID = addKeyMapOption("Key Modifier #3",Keymod3)
		setting08OID = addKeyMapOption("Hotkey #3",hotkey3)
		setting09OID = addKeyMapOption("Key Modifier #4",Keymod4)
		setting10OID = addKeyMapOption("Hotkey #4",hotkey4)
		setting11OID = addKeyMapOption("Key Modifier #5",Keymod5)
		setting12OID = addKeyMapOption("Hotkey #5",hotkey5)
		setting13OID = addKeyMapOption("Key Modifier #6",Keymod6)
		setting14OID = addKeyMapOption("Hotkey #6",hotkey6)
		setting15OID = addKeyMapOption("Key Modifier #7",Keymod7)
		setting16OID = addKeyMapOption("Hotkey #7",hotkey7)
		setting17OID = addKeyMapOption("Key Modifier #8",Keymod8)
		setting18OID = addKeyMapOption("Hotkey #8",hotkey8)
		setting19OID = addKeyMapOption("Key Modifier #9",Keymod9)
		setting20OID = addKeyMapOption("Hotkey #9",hotkey9)
		setting21OID = addKeyMapOption("Key Modifier #10",Keymod10)
		setting22OID = addKeyMapOption("Hotkey #10",hotkey10)
		setting23OID = addKeyMapOption("Key Modifier #11",Keymod11)
		setting24OID = addKeyMapOption("Hotkey #11",hotkey11)
	ELSEIF ( page == "Hotkey Cast Balance" )
		balance01OID = addSliderOption("Hotcast Cost Mult",costMult,"{1}x")
		balance02OID = addSliderOption("Hotcast Cooldown Mult",cooldownMult,"{1}x")
		balance03OID = addSliderOption("Hotcast Ritual Cost Mult",ritualCostMult,"{1}x")
		balance04OID = addSliderOption("Hotcast Ritual Cooldown Mult",ritualCooldownMult,"{1}x")
		balance05OID = addToggleOption("Block Hotcast while Attacking:", blockCastAttack )
		balance06OID = addToggleOption("Block Hotcast while Blocking:", blockCastBlock )
		balance07OID = addToggleOption("Block Hotcast while Bashing:", blockCastBash )
		balance08OID = addToggleOption("Block Hotcast while Staggered:", blockCastStagger )
		balance09OID = addToggleOption("Block Hotcast while Sprinting:", blockCastSprint )
		balance10OID = addToggleOption("Block Hotcast while Mounted:", blockCastMount )
		balance11OID = addToggleOption("Block Hotcast while in Killmove:", blockCastKill )
		balance12OID = addToggleOption("Block Hotcast while Casting:", blockCastSpell )
		balance13OID = addToggleOption("Block Hotcast while Jumping:", blockCastJump )
		balance14OID = addToggleOption("Block Hotcast while Bow Drawn:", blockCastBow )

		balance15OID = addSliderOption("Hotcast Experience Mult",experienceMult,"{1}x")

	ELSEIF ( page == "Item Queue Tools" )
		utility13_OID = addToggleOption("Register Inventory Hotkeys",PlayerRef.HasSpell(GUI_AB_InventoryHotkeys))
		utility14_OID = addKeyMapOption("Add to Queue Key",GUI_Hotkey_FavoriteGroup)

		healthPotionRegisteredOID = addToggleOption("Register Health Potion", isHealthPotionRegistered)
		healthPotionHotKeyOID = addKeyMapOption("Health Potion Hotkey", healthPotionHotKey)
		healthPotionMenuOID_M = addMenuOption("View List","")
		healthPotionResetOID = addTextOption("Reset List","")

		magickaPotionRegisteredOID = addToggleOption("Register Magicka Potion", isMagickaPotionRegistered)
		magickaPotionHotKeyOID = addKeyMapOption("Magicka Potion Hotkey", magickaPotionHotKey)
		magickaPotionMenuOID_M = addMenuOption("View List","")
		magickaPotionResetOID = addTextOption("Reset List","")

		staminaPotionRegisteredOID = addToggleOption("Register Stamina Potion", isStaminaPotionRegistered)
		staminaPotionHotKeyOID = addKeyMapOption("Stamina Potion Hotkey", staminaPotionHotKey)
		staminaPotionMenuOID_M = addMenuOption("View List","")
		staminaPotionResetOID = addTextOption("Reset List","")
		
		poisonRegisteredOID = addToggleOption("Register Poison", isPoisonRegistered)
		poisonHotKeyOID = addKeyMapOption("Poison Hotkey", poisonHotKey)
		poisonMenuOID_M = addMenuOption("View List","")
		poisonResetOID = addTextOption("Reset List","")
		
		misc1PotionRegisteredOID = addToggleOption("Register Miscellaneous Items", isMisc1PotionRegistered)
		misc1PotionHotKeyOID = addKeyMapOption("Miscellaneous Potion Hotkey", misc1PotionHotKey)
		misc1PotionMenuOID_M = addMenuOption("View List","")
		misc1PotionResetOID = addTextOption("Reset List","")
		
		misc2PotionRegisteredOID = addToggleOption("Register Miscellaneous Items", isMisc2PotionRegistered)
		misc2PotionHotKeyOID = addKeyMapOption("Miscellaneous Potion Hotkey", misc2PotionHotKey)
		misc2PotionMenuOID_M = addMenuOption("View List","")
		misc2PotionResetOID = addTextOption("Reset List","")
		
	ELSEIF ( page == "Misc")
		autoHealthPotionOID_T = addToggleOption("Register Auto Health Potion", PlayerRef.HasSpell(GUI_AB_AutoHealthPotion) )
		autoMagickaPotionOID_T = addToggleOption("Register Auto Magicka Potion", PlayerRef.HasSpell(GUI_AB_AutoMagickaPotion) )
		autoHealthPotionOID_S = addSliderOption("Auto Health Potion Percentage", GUI_Interval_AutoHealthPotion, "{2}" )
		autoMagickaPotionOID_S = addSliderOption("Auto Magicka Potion Percentage", GUI_Interval_AutoMagickaPotion, "{2}" )
		healthPotionCooldownOID = addSliderOption("Auto Health Potion Cooldown", GUI_Interval_AutoHealthPotionCooldown, "{2}" )
		magickaPotionCooldownOID = addSliderOption("Auto Magicka Potion Cooldown", GUI_Interval_AutoMagickaPotionCooldown, "{2}" )
		
		autoStaminaPotionOID_T = addToggleOption("Register Auto Stamina Potion", PlayerRef.HasSpell(GUI_AB_AutoStaminaPotion) )
		autoPoisonOID_T = addToggleOption("Register Auto Poison", PlayerRef.HasSpell(GUI_AB_AutoPoison) )
		autoStaminaPotionOID_S = addSliderOption("Auto Stamina Potion Percentage", GUI_Interval_AutoStaminaPotion, "{2}" )
		autoPoisonOID_S = addSliderOption("Auto Poison Interval", GUI_Interval_AutoPoison, "{0}" )
		staminaPotionCooldownOID = addSliderOption("Auto Stamina Potion Cooldown", GUI_Interval_AutoStaminaPotionCooldown, "{2}" )
		addEmptyOption()
				
		sneakRegisteredOID_T = addToggleOption("Register Toggle Sneak", PlayerRef.HasSpell(GUI_AB_SneakToggle) )
		sneakHotKeyOID = addKeyMapOption("Toggle Sneak Hotkey", GUI_Hotkey_SneakToggle )
		subtitleRegisteredOID_T = addToggleOption("Register Toggle Subtitles", PlayerRef.HasSpell(GUI_AB_SubtitleToggle) )
		subtitleHotKeyOID = addKeyMapOption("Toggle Subtitles Hotkey", GUI_Hotkey_SubtitleToggle )
		FISSsaveOID_T = addTextOption("Save to XML","")
		FISSloadOID_T = addTextOption("Load from XML","")
		achievementOID = addTextOption("Add All Achievements","")
		creditsOID_T = addTextOption("About Me:","Grimy Bunyip")
		
	ELSEIF ( page == "Perk Tools")
		REFUND_OID = addTextOption("Refund All Perks","Go!")
		AddEmptyOption()
		RF_OneHanded_OID = addTextOption("Refund OneHanded Perks","Go!")
		RF_TwoHanded_OID = addTextOption("Refund TwoHanded Perks","Go!")
		RF_Marksman_OID = addTextOption("Refund Marksman Perks","Go!")
		RF_Block_OID = addTextOption("Refund Block Perks","Go!")
		RF_Smithing_OID = addTextOption("Refund Smithing Perks","Go!")
		RF_HeavyArmor_OID = addTextOption("Refund HeavyArmor Perks","Go!")
		RF_LightArmor_OID = addTextOption("Refund LightArmor Perks","Go!")
		RF_Pickpocket_OID = addTextOption("Refund Pickpocket Perks","Go!")
		RF_Lockpicking_OID = addTextOption("Refund Lockpicking Perks","Go!")
		RF_Sneak_OID = addTextOption("Refund Sneak Perks","Go!")
		RF_Alchemy_OID = addTextOption("Refund Alchemy Perks","Go!")
		RF_Speechcraft_OID = addTextOption("Refund Speechcraft Perks","Go!")
		RF_Alteration_OID = addTextOption("Refund Alteration Perks","Go!")
		RF_Conjuration_OID = addTextOption("Refund Conjuration Perks","Go!")
		RF_Destruction_OID = addTextOption("Refund Destruction Perks","Go!")
		RF_Illusion_OID = addTextOption("Refund Illusion Perks","Go!")
		RF_Restoration_OID = addTextOption("Refund Restoration Perks","Go!")
		RF_Enchanting_OID = addTextOption("Refund Enchanting Perks","Go!")
		
	ELSEIF ( page == "MCM Renamer" )
		FORM tempForm = GetFormFromFile(0x00000802,"SkyUI.esp")
		IF tempForm && tempForm AS SKI_ConfigManager
			SKI_ConfigManager tempManager = tempForm AS SKI_ConfigManager
			
			IF tempManager.GetVersion() > 4
				ShowMessage("This MCM Renamer was built for an older version of SkyUI, it may not work")
			ENDIF
			
			INT mcmIndex = 0 
			SKI_ConfigBase tempBase = tempManager.GetModConfigs(mcmIndex)
			WHILE tempBase
				renamerOID[mcmIndex] = AddInputOption(tempBase.GetName(),tempBase.ModName)

				mcmIndex += 1
				IF mcmIndex >= 128
					tempBase = NONE 
				ELSE
					tempBase = tempManager.GetModConfigs(mcmIndex)
				ENDIF
			ENDWHILE
		ELSE 
			AddTextOption("SkyUI Not Found","ERROR")
		ENDIF
	
	ELSE
		SetCursorFillMode(TOP_TO_BOTTOM)
		addHeaderOption("Multi-Tools")
		utility01_OID = addToggleOption("Actor Tools",PlayerRef.HasSpell(GUI_AB_ActorTools))
		utility02_OID = addToggleOption("Object Tools",PlayerRef.HasSpell(GUI_AB_ObjectTools))
		utility07_OID = addToggleOption("Object Tools - Console Ref",PlayerRef.HasSpell(GUI_AB_ObjectToolsConsole))
		utility04_OID = addToggleOption("Player Tools",PlayerRef.HasSpell(GUI_AB_PlayerTools))
		
		addHeaderOption("Misc Tools")
		utility40_OID = addToggleOption("Reset Cell",PlayerRef.HasSpell(GUI_AB_ResetCell))
		setting02OID = addToggleOption("Register Spell Menu Keys",PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys))
		setting01OID = addKeyMapOption("Hotcast Favorites Key",GUI_Hotkey_HotcastSpellSelect)
		ForgetSpellOID = addKeyMapOption("Forget Spell Key",GUI_Hotkey_ForgetSpellKey)
		utility06_OID = addKeyMapOption("Force Equip Key",GUI_Hotkey_ForceEquip)
		
		addHeaderOption("Container Tools")
		utility09_OID = addToggleOption("Register Container Menu Keys",PlayerRef.HasSpell(GUI_AB_ContainerMenuHotkeys))
		utility10_OID = addKeyMapOption("Container Menu Key",GUI_hotkey_container)
		
		addHeaderOption("Barter Tools")
		utility15_OID = addToggleOption("Register Barter Menu Keys",PlayerRef.HasSpell(GUI_AB_BarterMenuHotkeys))
		utility16_OID = addKeyMapOption("Buy/Sell One",GUI_Hotkey_BarterSellOne)

		addHeaderOption("Crafting Tools")
		utility31_OID = addToggleOption("Register Crafting Hotkeys",PlayerRef.HasSpell(GUI_AB_CraftingHotkeys))
		utility32_OID = addKeyMapOption("Craft X Hotkey",GUI_Hotkey_CraftX)
		utility08_OID = addKeyMapOption("Forget Enchantment Hotkey",GUI_Hotkey_ForgetEnchantment)
		
		SetCursorPosition(1)
		
		addHeaderOption("Tempering Tools")
		utility13_OID = addToggleOption("Register Inventory Hotkeys",PlayerRef.HasSpell(GUI_AB_InventoryHotkeys))
		utility38_OID = addKeyMapOption("Inspect Hotkey",GUI_Hotkey_InspectKey)
		utility33_OID = addKeyMapOption("Temper Equipped Hotkey",GUI_Hotkey_TemperKey)
		utility34_OID = addSliderOption("Temper Hotkey Mult",GUI_Hotkey_TemperMag,"{2}")
		utility35_OID = addToggleOption("Register Degradation",PlayerRef.HasSpell(GUI_AB_Degradation))
		utility36_OID = addSliderOption("Armor Degradation Rate",GUI_DegradationRateArmor,"{2}")
		utility37_OID = addSliderOption("Weapon Degradation Rate",GUI_DegradationRateWeapon,"{2}")
		
		addHeaderOption("Marked Object/Actor Tools")
		
		utility03_OID = addToggleOption("Mark Object",PlayerRef.HasSpell(GUI_AB_MarkObject))
		utility05_OID = addKeyMapOption("Add Spell To Mark Key",GUI_Hotkey_AddSpellToMark)
		
		addHeaderOption("Persistent Form Information")
		addTextOption("# Player Made Weapon Enchants",GetWeaponEnchCount())
		addTextOption("# Player Made Armor Enchants",GetArmorEnchCount())

				
		
	ENDIF
ENDEVENT

FUNCTION SetMenuDialog(string[] getList, int pointer)	
	SetMenuDialogOptions(getList) 
	SetMenuDialogDefaultIndex(pointer)
	SetMenuDialogStartIndex(pointer)
ENDFUNCTION


EVENT OnOptionInputOpen(int option)
	INT mcmIndex = 0
	WHILE option != renamerOID[mcmIndex]
		mcmIndex += 1
	ENDWHILE
	IF mcmIndex < 128
		SKI_ConfigBase tempBase = (GetFormFromFile(0x00000802,"SkyUI.esp") AS SKI_ConfigManager).GetModConfigs(mcmIndex)
		SetInputDialogStartText(tempBase.ModName)
	ENDIF
ENDEVENT 

EVENT OnOptionInputAccept(int option, string sResult)
	INT mcmIndex = 0
	WHILE option != renamerOID[mcmIndex]
		mcmIndex += 1
	ENDWHILE
	
	IF mcmIndex < 128
		SKI_ConfigManager tempManager = (GetFormFromFile(0x00000802,"SkyUI.esp") AS SKI_ConfigManager)
		SKI_ConfigBase tempBase = tempManager.GetModConfigs(mcmIndex)
		tempManager.SetModName(mcmIndex,sResult)
		tempBase.ModName = sResult
		SetInputOptionValue(renamerOID[mcmIndex],sResult)
		needConfig = True
	ENDIF
ENDEVENT

EVENT OnOptionMenuOpen(int option) 
	IF ( option == healthPotionMenuOID_M )
        SetMenuDialog(healthPotionStringList,0)
	ELSEIF ( option == magickaPotionMenuOID_M )
		SetMenuDialog(magickaPotionStringList,0)
	ELSEIF ( option == staminaPotionMenuOID_M )
		SetMenuDialog(staminaPotionStringList,0)
	ELSEIF ( option == poisonMenuOID_M )
		SetMenuDialog(poisonStringList,0)
	ELSEIF ( option == misc1PotionMenuOID_M )
		SetMenuDialog(misc1PotionStringList,0)
	ELSEIF ( option == misc2PotionMenuOID_M )
		SetMenuDialog(misc2PotionStringList,0)
	ENDIF
ENDEVENT

EVENT onOptionSliderOpen(int option)
	IF ( option == balance01OID )
		setSlider(costMult,1.0,0.0,10.0,0.1)
	ELSEIF ( option == balance02OID )
		setSlider(cooldownMult,1.0,0.0,10.0,0.1)
	ELSEIF ( option == balance03OID )
		setSlider(ritualCostMult,1.0,0.0,10.0,0.1)
	ELSEIF ( option == balance04OID )
		setSlider(ritualCooldownMult,1.0,0.0,10.0,0.1)
	ELSEIF ( option == balance15OID )
		setSlider(experienceMult,1.0,0.0,10.0,0.1)
	;==========Inventory Tools=======
	ELSEIF ( option == utility34_OID )
		setSlider(GUI_Hotkey_TemperMag,1.0,0.0,10.0,0.01)
	ELSEIF ( option == utility36_OID )
		setSlider(GUI_DegradationRateArmor,1.0,0.0,100.0,0.01)
	ELSEIF ( option == utility37_OID )
		setSlider(GUI_DegradationRateWeapon,1.0,0.0,100.0,0.01)
	;==========Potion Tools==========
	ELSEIF ( option == autoPoisonOID_S )
		setSlider(GUI_Interval_AutoPoison, 1.0,0.0,100.0,1.0)
	ELSEIF ( option == autoHealthPotionOID_S )
		setSlider(GUI_Interval_AutoHealthPotion, 0.25,0.0,1.0,0.01)
	ELSEIF ( option == autoMagickaPotionOID_S )
		setSlider(GUI_Interval_AutoMagickaPotion, 0.25,0.0,1.0,0.01)
	ELSEIF ( option == autoStaminaPotionOID_S )
		setSlider(GUI_Interval_AutoStaminaPotion, 0.25,0.0,1.0,0.01)
	ELSEIF ( option == healthPotionCooldownOID )
		setSlider(GUI_Interval_AutoHealthPotionCooldown, 1.0,0.0,10.0,0.01)
	ELSEIF ( option == magickaPotionCooldownOID )
		setSlider(GUI_Interval_AutoMagickaPotionCooldown, 1.0,0.0,10.0,0.01)
	ELSEIF ( option == staminaPotionCooldownOID )
		setSlider(GUI_Interval_AutoStaminaPotionCooldown, 1.0,0.0,10.0,0.01)
	ENDIF
ENDEVENT

FUNCTION setSlider(float sliderStart, float sliderDefault, float sliderMin, float sliderMax, float sliderInt)
	SetSliderDialogStartValue(sliderStart)
	SetSliderDialogDefaultValue(sliderDefault)
	SetSliderDialogRange(sliderMin, sliderMax)
	SetSliderDialogInterval(sliderInt)
ENDFUNCTION

EVENT OnOptionSliderAccept(int option, float value)
	IF ( option == balance01OID )
		costMult = value
		SetSliderOptionValue(balance01OID, costMult,"{1}x")
	ELSEIF ( option == balance02OID )
		cooldownMult = value
		SetSliderOptionValue(balance02OID, cooldownMult,"{1}x")
	ELSEIF ( option == balance03OID )
		ritualCostMult = value
		SetSliderOptionValue(balance03OID, ritualCostMult,"{1}x")
	ELSEIF ( option == balance04OID )
		ritualCooldownMult = value
		SetSliderOptionValue(balance04OID, ritualCooldownMult,"{1}x")
	ELSEIF ( option == balance15OID )
		experienceMult = value
		SetSliderOptionValue(balance15OID, experienceMult,"{1}x")
	;==========Inventory Tools=======
	ELSEIF ( option == utility34_OID )
		GUI_Hotkey_TemperMag = value
		SetSliderOptionValue(utility34_OID, value, "{2}")
	ELSEIF ( option == utility36_OID )
		GUI_DegradationRateArmor = value
		SetSliderOptionValue(utility36_OID, value, "{2}")
	ELSEIF ( option == utility37_OID )
		GUI_DegradationRateWeapon = value
		SetSliderOptionValue(utility37_OID, value, "{2}")
	;==========Potion Tools==========
	ELSEIF ( option == autoPoisonOID_S )
		GUI_Interval_AutoPoison = value AS INT
		SetSliderOptionValue(autoPoisonOID_S, value,"{0}")
	ELSEIF ( option == autoHealthPotionOID_S )
		GUI_Interval_AutoHealthPotion = value
		SetSliderOptionValue(autoHealthPotionOID_S, value,"{2}")
	ELSEIF ( option == autoMagickaPotionOID_S )
		GUI_Interval_AutoMagickaPotion = value
		SetSliderOptionValue(autoMagickaPotionOID_S, value,"{2}")
	ELSEIF ( option == autoStaminaPotionOID_S )
		GUI_Interval_AutoStaminaPotion = value
		SetSliderOptionValue(autoStaminaPotionOID_S, value,"{2}")
	ELSEIF ( option == healthPotionCooldownOID )
		GUI_Interval_AutoHealthPotionCooldown = value
		SetSliderOptionValue(healthPotionCooldownOID, value,"{2}")
	ELSEIF ( option == magickaPotionCooldownOID )
		GUI_Interval_AutoMagickaPotionCooldown = value
		SetSliderOptionValue(magickaPotionCooldownOID, value,"{2}")
	ELSEIF ( option == staminaPotionCooldownOID )
		GUI_Interval_AutoStaminaPotionCooldown = value
		SetSliderOptionValue(staminaPotionCooldownOID, value,"{2}")
	ENDIF
ENDEVENT

EVENT OnOptionSelect(int option)
	IF ( option == setting02OID )
		toggleEquipSpell(GUI_AB_SpellMenuHotkeys, setting02OID)
		registerHotKeys()

	ELSEIF ( option == balance05OID )
		blockCastAttack = !blockCastAttack
		SetToggleOptionValue( balance05OID, blockCastAttack )
	ELSEIF ( option == balance06OID )
		blockCastBlock = !blockCastBlock
		SetToggleOptionValue( balance06OID, blockCastBlock )
	ELSEIF ( option == balance07OID )
		blockCastBash = !blockCastBash
		SetToggleOptionValue( balance07OID, blockCastBash )
	ELSEIF ( option == balance08OID )
		blockCastStagger = !blockCastStagger
		SetToggleOptionValue( balance08OID, blockCastStagger )
	ELSEIF ( option == balance09OID )
		blockCastSprint = !blockCastSprint
		SetToggleOptionValue( balance09OID, blockCastSprint )
	ELSEIF ( option == balance10OID )
		blockCastMount = !blockCastMount
		SetToggleOptionValue( balance10OID, blockCastMount )
	ELSEIF ( option == balance11OID )
		blockCastKill = !blockCastKill
		SetToggleOptionValue( balance11OID, blockCastKill )
	ELSEIF ( option == balance12OID )
		blockCastSpell = !blockCastSpell
		SetToggleOptionValue( balance12OID, blockCastSpell )
	ELSEIF ( option == balance13OID )
		blockCastJump = !blockCastJump
		SetToggleOptionValue( balance13OID, blockCastJump )
	ELSEIF ( option == balance14OID )
		blockCastBow = !blockCastBow
		SetToggleOptionValue( balance14OID, blockCastBow )
	;==========Utility Spells==========
	ELSEIF ( option == utility01_OID )
		toggleEquipSpell(GUI_AB_ActorTools, utility01_OID)
	ELSEIF ( option == utility02_OID )
		toggleEquipSpell(GUI_AB_ObjectTools, utility02_OID)
	ELSEIF ( option == utility07_OID )
		toggleEquipSpell(GUI_AB_ObjectToolsConsole, utility07_OID)
	ELSEIF ( option == utility04_OID )
		toggleEquipSpell(GUI_AB_PlayerTools, utility04_OID)
	ELSEIF ( option == utility03_OID )
		toggleEquipSpell(GUI_AB_MarkObject, utility03_OID)
	ELSEIF ( option == utility09_OID )
		toggleEquipSpell(GUI_AB_ContainerMenuHotkeys, utility09_OID)
	ELSEIF ( option == utility15_OID )
		toggleEquipSpell(GUI_AB_BarterMenuHotkeys, utility15_OID)
	ELSEIF ( option == utility13_OID )
		toggleEquipSpell(GUI_AB_InventoryHotkeys, utility13_OID)
	ELSEIF ( option == utility31_OID )
		toggleEquipSpell(GUI_AB_CraftingHotkeys, utility31_OID)
	ELSEIF ( option == utility35_OID )
		toggleEquipSpell(GUI_AB_Degradation, utility35_OID)
	ELSEIF ( option == utility40_OID )
		toggleEquipSpell(GUI_AB_ResetCell, utility40_OID)
	;==========Potion Tools==========
	ELSEIF ( option == healthPotionRegisteredOID )
		isHealthPotionRegistered = !isHealthPotionRegistered
		SetToggleOptionValue( healthPotionRegisteredOID, isHealthPotionRegistered )
		IF isHealthPotionRegistered
			RegisterForKey(healthPotionHotKey)
		ELSE
			UnregisterForKey(healthPotionHotKey)
			healthPotionHotKey = -1
			SetKeyMapOptionValue(healthPotionHotKeyOID, healthPotionHotKey)
		ENDIF
	ELSEIF ( option == magickaPotionRegisteredOID )
		isMagickaPotionRegistered = !isMagickaPotionRegistered
		SetToggleOptionValue(magickaPotionRegisteredOID, isMagickaPotionRegistered )
		IF isMagickaPotionRegistered
			RegisterForKey(magickaPotionHotKey)
		ELSE
			UnregisterForKey(magickaPotionHotKey)
			magickaPotionHotKey = -1
			SetKeyMapOptionValue(magickaPotionHotKeyOID, magickaPotionHotKey)
		ENDIF
	ELSEIF ( option == staminaPotionRegisteredOID )
		isStaminaPotionRegistered = !isStaminaPotionRegistered
		SetToggleOptionValue(staminaPotionRegisteredOID, isStaminaPotionRegistered )
		IF isStaminaPotionRegistered
			RegisterForKey(staminaPotionHotKey)
		ELSE
			UnregisterForKey(staminaPotionHotKey)
			staminaPotionHotKey = -1
			SetKeyMapOptionValue(staminaPotionHotKeyOID, staminaPotionHotKey)
		ENDIF
	ELSEIF ( option == poisonRegisteredOID )
		isPoisonRegistered = !isPoisonRegistered
		SetToggleOptionValue(poisonRegisteredOID, isPoisonRegistered )
		IF isPoisonRegistered
			RegisterForKey(poisonHotKey)
		ELSE
			UnregisterForKey(poisonHotKey)
			poisonHotKey = -1
			SetKeyMapOptionValue(poisonHotKeyOID, poisonHotKey)
		ENDIF
	ELSEIF ( option == misc1PotionRegisteredOID )
		isMisc1PotionRegistered = !isMisc1PotionRegistered
		SetToggleOptionValue( misc1PotionRegisteredOID, isMisc1PotionRegistered )
		IF isMisc1PotionRegistered
			RegisterForKey(misc1PotionHotKey)
		ELSE
			UnregisterForKey(misc1PotionHotKey)
			misc1PotionHotKey = -1
			SetKeyMapOptionValue(misc1PotionHotKeyOID, misc1PotionHotKey)
		ENDIF
	ELSEIF ( option == misc2PotionRegisteredOID )
		isMisc2PotionRegistered = !isMisc2PotionRegistered
		SetToggleOptionValue( misc2PotionRegisteredOID, isMisc2PotionRegistered )
		IF isMisc2PotionRegistered
			RegisterForKey(misc2PotionHotKey)
		ELSE
			UnregisterForKey(misc2PotionHotKey)
			misc2PotionHotKey = -1
			SetKeyMapOptionValue(misc2PotionHotKeyOID, misc2PotionHotKey)
		ENDIF
	ELSEIF ( option == healthPotionResetOID )
		IF ShowMessage("Are you sure you want to reset your health potion list?")
			resetHealthPotionList()
		ENDIF
	ELSEIF ( option == magickaPotionResetOID )
		IF ShowMessage("Are you sure you want to reset your magicka potion list?")
			resetMagickaPotionList()
		ENDIF
	ELSEIF ( option == staminaPotionResetOID )
		IF ShowMessage("Are you sure you want to reset your stamina potion list?")
			resetStaminaPotionList()
		ENDIF
	ELSEIF ( option == poisonResetOID )
		IF ShowMessage("Are you sure you want to reset your poison list?")
			resetPoisonList()
		ENDIF
	ELSEIF ( option == misc1PotionResetOID )
		IF ShowMessage("Are you sure you want to reset this miscellaneous potion list?")
			resetMisc1PotionList()
		ENDIF
	ELSEIF ( option == healthPotionResetOID )
		IF ShowMessage("Are you sure you want to reset this miscellaneous potion list?")
			resetMisc2PotionList()
		ENDIF
	;==========Miscellaneous==========
	ELSEIF ( option == sneakRegisteredOID_T )
		toggleSpell(GUI_AB_SneakToggle, sneakRegisteredOID_T)
	ELSEIF ( option == subtitleRegisteredOID_T )
		toggleSpell(GUI_AB_SubtitleToggle, subtitleRegisteredOID_T)
	ELSEIF ( option == autoPoisonOID_T )
		toggleSpell(GUI_AB_AutoPoison, autoPoisonOID_T)
	ELSEIF ( option == autoHealthPotionOID_T )
		toggleSpell(GUI_AB_AutoHealthPotion, autoHealthPotionOID_T)
	ELSEIF ( option == autoMagickaPotionOID_T )
		toggleSpell(GUI_AB_AutoMagickaPotion, autoMagickaPotionOID_T)
	ELSEIF ( option == autoStaminaPotionOID_T )
		toggleSpell(GUI_AB_AutoStaminaPotion, autoStaminaPotionOID_T)
	ELSEIF ( option == ResetKeysOID )
		IF ShowMessage("Are you sure you want to reset your key bindings?")		
			(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",0,"")
			(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",0,false)
			(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",1,"")
			(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",1,false)
			(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",2,"")
			(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",2,false)
			(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",3,"")
			(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",3,false)
			(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",4,"")
			(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",4,false)
			(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",5,"")
			(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",5,false)
			(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",6,"")
			(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",6,false)
			(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",7,"")
			(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",7,false)
			wheelKey = -1
			hotKey1 = -1
			hotKey2 = -1
			hotKey3 = -1
			hotKey4 = -1
			hotKey5 = -1
			hotKey6 = -1
			hotKey7 = -1
			hotKey8 = -1
			hotKey9 = -1
			hotKey10 = -1
			hotKey11 = -1
			Keymod1 = -1
			Keymod2 = -1
			Keymod3 = -1
			Keymod4 = -1
			Keymod5 = -1
			Keymod6 = -1
			Keymod7 = -1
			Keymod8 = -1
			Keymod9 = -1
			Keymod10 = -1
			Keymod11 = -1
			SetKeyMapOptionValue(setting03OID, -1, true)
			SetKeyMapOptionValue(setting05OID, -1, true)
			SetKeyMapOptionValue(setting07OID, -1, true)
			SetKeyMapOptionValue(setting09OID, -1, true)
			SetKeyMapOptionValue(setting11OID, -1, true)
			SetKeyMapOptionValue(setting13OID, -1, true)
			SetKeyMapOptionValue(setting15OID, -1, true)
			SetKeyMapOptionValue(setting17OID, -1, true)
			SetKeyMapOptionValue(setting19OID, -1, true)
			SetKeyMapOptionValue(setting21OID, -1, true)
			SetKeyMapOptionValue(setting23OID, -1, true)
			SetKeyMapOptionValue(setting04OID, -1, true)
			SetKeyMapOptionValue(setting06OID, -1, true)
			SetKeyMapOptionValue(setting08OID, -1, true)
			SetKeyMapOptionValue(setting10OID, -1, true)
			SetKeyMapOptionValue(setting12OID, -1, true)
			SetKeyMapOptionValue(setting14OID, -1, true)
			SetKeyMapOptionValue(setting16OID, -1, true)
			SetKeyMapOptionValue(setting18OID, -1, true)
			SetKeyMapOptionValue(setting20OID, -1, true)
			SetKeyMapOptionValue(setting22OID, -1, true)
			SetKeyMapOptionValue(setting24OID, -1)
		ENDIF
	ELSEIF ( option == FISSsaveOID_T )
		IF ( ShowMessage("Are you sure? This is may take a few seconds") )
			FISS_SAVE()
		ENDIF
	ELSEIF ( option == FISSloadOID_T )
		IF ( ShowMessage("Are you sure? This is may take a few seconds") )
			FISS_LOAD()
		ENDIF
	ELSEIF ( option == Refund_OID )
		INT i = 0
		i += RefundPerks("OneHanded")
		i += RefundPerks("TwoHanded")
		i += RefundPerks("Marksman")
		i += RefundPerks("Block")
		i += RefundPerks("Smithing")
		i += RefundPerks("HeavyArmor")
		i += RefundPerks("LightArmor")
		i += RefundPerks("Pickpocket")
		i += RefundPerks("Lockpicking")
		i += RefundPerks("Sneak")
		i += RefundPerks("Alchemy")
		i += RefundPerks("Speechcraft")
		i += RefundPerks("Alteration")
		i += RefundPerks("Conjuration")
		i += RefundPerks("Destruction")
		i += RefundPerks("Illusion")
		i += RefundPerks("Restoration")
		i += RefundPerks("Enchanting")
		ShowMessage(i + " Perk Points Refunded")
	ELSEIF  ( option == RF_OneHanded_OID )
		ShowMessage(RefundPerks("OneHanded") + " Perk Points Refunded")
	ELSEIF  ( option == RF_TwoHanded_OID )
		ShowMessage(RefundPerks("TwoHanded") + " Perk Points Refunded")
	ELSEIF  ( option == RF_Marksman_OID )
		ShowMessage(RefundPerks("Marksman") + " Perk Points Refunded")
	ELSEIF  ( option == RF_Block_OID )
		ShowMessage(RefundPerks("Block") + " Perk Points Refunded")
	ELSEIF  ( option == RF_Smithing_OID )
		ShowMessage(RefundPerks("Smithing") + " Perk Points Refunded")
	ELSEIF  ( option == RF_HeavyArmor_OID )
		ShowMessage(RefundPerks("HeavyArmor") + " Perk Points Refunded")
	ELSEIF  ( option == RF_LightArmor_OID )
		ShowMessage(RefundPerks("LightArmor") + " Perk Points Refunded")
	ELSEIF  ( option == RF_Pickpocket_OID )
		ShowMessage(RefundPerks("Pickpocket") + " Perk Points Refunded")
	ELSEIF  ( option == RF_Lockpicking_OID )
		ShowMessage(RefundPerks("Lockpicking") + " Perk Points Refunded")
	ELSEIF  ( option == RF_Sneak_OID )
		ShowMessage(RefundPerks("Sneak") + " Perk Points Refunded")
	ELSEIF  ( option == RF_Alchemy_OID )
		ShowMessage(RefundPerks("Alchemy") + " Perk Points Refunded")
	ELSEIF  ( option == RF_Speechcraft_OID )
		ShowMessage(RefundPerks("Speechcraft") + " Perk Points Refunded")
	ELSEIF  ( option == RF_Alteration_OID )
		ShowMessage(RefundPerks("Alteration") + " Perk Points Refunded")
	ELSEIF  ( option == RF_Conjuration_OID )
		ShowMessage(RefundPerks("Conjuration") + " Perk Points Refunded")
	ELSEIF  ( option == RF_Destruction_OID )
		ShowMessage(RefundPerks("Destruction") + " Perk Points Refunded")
	ELSEIF  ( option == RF_Illusion_OID )
		ShowMessage(RefundPerks("Illusion") + " Perk Points Refunded")
	ELSEIF  ( option == RF_Restoration_OID )
		ShowMessage(RefundPerks("Restoration") + " Perk Points Refunded")
	ELSEIF  ( option == RF_Enchanting_OID )
		ShowMessage(RefundPerks("Enchanting") + " Perk Points Refunded")
	ELSEIF ( option == achievementOID )
		IF ( ShowMessage("Are you sure? You can't remove your achievements") )
			AddAchievement(1)
			AddAchievement(2)
			AddAchievement(3)
			AddAchievement(4)
			AddAchievement(5)
			AddAchievement(6)
			AddAchievement(7)
			AddAchievement(8)
			AddAchievement(9)
			AddAchievement(10)
			AddAchievement(11)
			AddAchievement(12)
			AddAchievement(13)
			AddAchievement(14)
			AddAchievement(15)
			AddAchievement(16)
			AddAchievement(17)
			AddAchievement(18)
			AddAchievement(19)
			AddAchievement(20)
			AddAchievement(21)
			AddAchievement(22)
			AddAchievement(23)
			AddAchievement(24)
			AddAchievement(25)
			AddAchievement(26)
			AddAchievement(27)
			AddAchievement(28)
			AddAchievement(29)
			AddAchievement(30)
			AddAchievement(31)
			AddAchievement(32)
			AddAchievement(33)
			AddAchievement(34)
			AddAchievement(35)
			AddAchievement(36)
			AddAchievement(37)
			AddAchievement(38)
			AddAchievement(39)
			AddAchievement(40)
			AddAchievement(41)
			AddAchievement(42)
			AddAchievement(43)
			AddAchievement(44)
			AddAchievement(45)
			AddAchievement(46)
			AddAchievement(47)
			AddAchievement(48)
			AddAchievement(49)
			AddAchievement(50)
			AddAchievement(51)
			AddAchievement(52)
			AddAchievement(53)
			AddAchievement(54)
			AddAchievement(55)
			AddAchievement(56)
			AddAchievement(57)
			AddAchievement(58)
			AddAchievement(59)
			AddAchievement(60)
			AddAchievement(61)
			AddAchievement(62)
			AddAchievement(63)
			AddAchievement(64)
			AddAchievement(65)
			AddAchievement(66)
			AddAchievement(67)
			AddAchievement(68)
			AddAchievement(69)
			AddAchievement(70)
			AddAchievement(71)
			AddAchievement(72)
			AddAchievement(73)
			AddAchievement(74)
			AddAchievement(75)
		ENDIF
	ENDIF
ENDEVENT

FUNCTION toggleEquipSpell(Spell akSpell, int OID)
	IF ( PlayerRef.HasSpell(akSpell) )
		PlayerRef.RemoveSpell(akSpell)
	ELSE
		PlayerRef.AddSpell(akSpell,false)
		PlayerRef.EquipSpell(akSpell,1)
	ENDIF
	SetToggleOptionValue(OID, PlayerRef.HasSpell(akSpell))
ENDFUNCTION

FUNCTION toggleSpell(Spell akSpell, int OID)
	IF ( PlayerRef.HasSpell(akSpell) )
		PlayerRef.RemoveSpell(akSpell)
	ELSE
		PlayerRef.AddSpell(akSpell,false)
	ENDIF
	SetToggleOptionValue(OID, PlayerRef.HasSpell(akSpell))
ENDFUNCTION

EVENT OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	IF ( option == setting04OID )
		setHotKeyMap( setting04OID, hotkey1, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		hotkey1 = keyCode
	ELSEIF ( option == setting06OID )
		setHotKeyMap( setting06OID, hotkey2, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		hotkey2 = keyCode
	ELSEIF ( option == setting08OID )
		setHotKeyMap( setting08OID, hotkey3, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		hotkey3 = keyCode
	ELSEIF ( option == setting10OID )
		setHotKeyMap( setting10OID, hotkey4, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		hotkey4 = keyCode
	ELSEIF ( option == setting12OID )
		setHotKeyMap( setting12OID, hotkey5, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		hotkey5 = keyCode
	ELSEIF ( option == setting14OID )
		setHotKeyMap( setting14OID, hotkey6, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		hotkey6 = keyCode
	ELSEIF ( option == setting16OID )
		setHotKeyMap( setting16OID, hotkey7, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		hotkey7 = keyCode
	ELSEIF ( option == setting18OID )
		setHotKeyMap( setting18OID, hotkey8, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		hotkey8 = keyCode
	ELSEIF ( option == setting20OID )
		setHotKeyMap( setting20OID, hotkey9, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		hotkey9 = keyCode
	ELSEIF ( option == setting22OID )
		setHotKeyMap( setting22OID, hotkey10, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		hotkey10 = keyCode
	ELSEIF ( option == setting24OID )
		setHotKeyMap( setting24OID, hotkey11, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		hotkey11 = keyCode
		
	ELSEIF ( option == setting03OID )
		setHotKeyMap( setting03OID, Keymod1, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		Keymod1 = keyCode
	ELSEIF ( option == setting05OID )
		setHotKeyMap( setting05OID, Keymod2, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		Keymod2 = keyCode
	ELSEIF ( option == setting07OID )
		setHotKeyMap( setting07OID, Keymod3, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		Keymod3 = keyCode
	ELSEIF ( option == setting09OID )
		setHotKeyMap( setting09OID, Keymod4, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		Keymod4 = keyCode
	ELSEIF ( option == setting11OID )
		setHotKeyMap( setting11OID, Keymod5, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		Keymod5 = keyCode
	ELSEIF ( option == setting13OID )
		setHotKeyMap( setting13OID, Keymod6, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		Keymod6 = keyCode
	ELSEIF ( option == setting15OID )
		setHotKeyMap( setting15OID, Keymod7, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		Keymod7 = keyCode
	ELSEIF ( option == setting17OID )
		setHotKeyMap( setting17OID, Keymod8, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		Keymod8 = keyCode
	ELSEIF ( option == setting19OID )
		setHotKeyMap( setting19OID, Keymod9, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		Keymod9 = keyCode
	ELSEIF ( option == setting21OID )
		setHotKeyMap( setting21OID, Keymod10, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		Keymod10 = keyCode
	ELSEIF ( option == setting23OID )
		setHotKeyMap( setting23OID, Keymod11, keyCode, PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) )
		Keymod11 = keyCode
		
	ELSEIF ( option == utility32_OID )
		GUI_Hotkey_CraftX = keyCode
		setKeyMapOptionValue(utility32_OID,keyCode)
	ELSEIF ( option == utility08_OID )
		GUI_Hotkey_ForgetEnchantment = keyCode
		setKeyMapOptionValue(utility08_OID,keyCode)
	ELSEIF ( option == utility33_OID )
		GUI_Hotkey_TemperKey = keyCode
		setKeyMapOptionValue(utility33_OID,keyCode)
	ELSEIF ( option == utility38_OID )
		GUI_Hotkey_InspectKey = keyCode
		setKeyMapOptionValue(utility38_OID,keyCode)
		
	ELSEIF ( option == Utility05_OID )
		GUI_Hotkey_AddSpellToMark = keyCode
		setKeyMapOptionValue(Utility05_OID,keyCode)
		
	ELSEIF ( option == Utility11_OID )
		wheelKey = keyCode
		setKeyMapOptionValue(Utility11_OID,keyCode)
		
	ELSEIF ( option == setting01OID )
		GUI_Hotkey_HotcastSpellSelect = keyCode
		setKeyMapOptionValue(setting01OID,keyCode)
		
	ELSEIF ( option == ForgetSpellOID )
		GUI_Hotkey_ForgetSpellKey = keyCode
		setKeyMapOptionValue(ForgetSpellOID,keyCode)
		
		
	ELSEIF ( option == Utility06_OID )
		GUI_Hotkey_ForceEquip = keyCode
		setKeyMapOptionValue(Utility06_OID,keyCode)
		
	ELSEIF ( option == Utility10_OID )
		GUI_hotkey_container = keyCode
		setKeyMapOptionValue(Utility10_OID,keyCode)
		
	ELSEIF ( option == healthPotionHotKeyOID )
		setHotKeyMap( healthPotionHotKeyOID, healthPotionHotKey, keyCode, isHealthPotionRegistered )
		healthPotionHotKey = keyCode
	ELSEIF ( option == magickaPotionHotKeyOID )
		setHotKeyMap( magickaPotionHotKeyOID, magickaPotionHotKey, keyCode, isMagickaPotionRegistered )
		magickaPotionHotKey = keyCode
	ELSEIF ( option == staminaPotionHotKeyOID )
		setHotKeyMap( staminaPotionHotKeyOID, staminaPotionHotKey, keyCode, isStaminaPotionRegistered )
		staminaPotionHotKey = keyCode
	ELSEIF ( option == poisonHotKeyOID )
		setHotKeyMap( poisonHotKeyOID, poisonHotKey, keyCode, isPoisonRegistered )
		poisonHotKey = keyCode
	ELSEIF ( option == misc1PotionHotKeyOID )
		setHotKeyMap( misc1PotionHotKeyOID, misc1PotionHotKey, keyCode, isMisc1PotionRegistered )
		misc1PotionHotKey = keyCode
	ELSEIF ( option == misc2PotionHotKeyOID )
		setHotKeyMap( misc2PotionHotKeyOID, misc2PotionHotKey, keyCode, isMisc2PotionRegistered )
		misc2PotionHotKey = keyCode
	ELSEIF ( option == sneakHotKeyOID )
		GUI_Hotkey_SneakToggle = keyCode
		IF PlayerRef.HasSpell(GUI_AB_SneakToggle)
			PlayerRef.RemoveSpell(GUI_AB_SneakToggle)
			PlayerRef.AddSpell(GUI_AB_SneakToggle, false)
		ENDIF
		SetKeyMapOptionValue(sneakHotKeyOID, GUI_Hotkey_SneakToggle)
	ELSEIF ( option == subtitleHotKeyOID )
		GUI_Hotkey_SubtitleToggle = keyCode
		IF PlayerRef.HasSpell(GUI_AB_SubtitleToggle)
			PlayerRef.RemoveSpell(GUI_AB_SubtitleToggle)
			PlayerRef.AddSpell(GUI_AB_SubtitleToggle, false)
		ENDIF
		SetKeyMapOptionValue(subtitleHotKeyOID, GUI_Hotkey_SubtitleToggle)
	ENDIF
ENDEVENT

FUNCTION setHotKeyMap(int option, int hotkey, int KeyCode, bool canRegister)
	UnregisterForKey(hotkey)
	SetKeyMapOptionValue(option, KeyCode )
	IF ( canRegister )
		RegisterForKey(KeyCode)
	ENDIF
ENDFUNCTION

EVENT onOptionHighlight(int option)
	IF ( option == setting02OID )
		setInfoText("You must register your keys for hotkeys to work.\nYou should also unregister your keys when you aren't using them.\nAlso unregister your keys prior to uninstallation.")	
	ELSEIF ( (option == setting03OID) || (option == setting05OID) || (option == setting07OID) || (option == setting09OID) || (option == setting11OID) || (option == setting13OID) || (option == setting15OID) || (option == setting17OID) || (option == setting19OID) || (option == setting21OID) || (option == setting23OID) )
		setInfoText("Click to set a key modifier for this hotcast.\nFor example, if you set this to Shift, you will only cast when you click shift + the hotkey.")
	ELSEIF ( (option == setting04OID) || (option == setting06OID) || (option == setting08OID) || (option == setting10OID) || (option == setting12OID) || (option == setting14OID) || (option == setting16OID) || (option == setting18OID) || (option == setting20OID) || (option == setting22OID) || (option == setting24OID) )
		setInfoText("Click to set a new hotkey for this spell")
	ELSEIF ( option == FISSsaveOID_T )
		SetInfoText("Uses FISS to store your settings to a global XML.")
	ELSEIF ( option == FISSloadOID_T )
		SetInfoText("Uses FISS to load your settings from a global XML.")
	ELSEIF ( option == creditsOID_T )
		SetInfoText("Check out my other mods on Skyrim Nexus:\nhttp://skyrim.nexusmods.com/users/5910982")
	ELSEIF ( option == balance01OID )
		SetInfoText("Cost Mult for hotcast spells.\nDoes not affect spells you cast manually")
	ELSEIF ( option == balance02OID )
		SetInfoText("Cooldown mult for hotcast spells.\nBase cooldown is equal to the casting time of the spell\nDoes not affect spells you cast manually")
	ELSEIF ( option == balance03OID )
		SetInfoText("Cost Mult for ritual spells you hotcast.\nOverrides hotcast cooldown mult, does not stack.")
	ELSEIF ( option == balance04OID )
		SetInfoText("Cooldown mult for ritual spells you hotcast.\nBase cooldown is equal to the casting time of the spell\nOverrides hotcast cooldown mult, does not stack.")
	;==========Utility Spells==========
	ELSEIF ( option == utility01_OID )
		SetInfoText("This spell contains a number of utility and debug functions when you cast it on an actor")
	ELSEIF ( option == utility02_OID )
		SetInfoText("This spell contains a number of utility and debug functions when you cast it on any object or actor")
	ELSEIF ( option == utility04_OID )
		SetInfoText("This spell contains a number of utility and debug functions that affect the player")
	ELSEIF ( option == utility03_OID )
		SetInfoText("Use this spell to add an actor or object to a list.\nYou can use this spell to summon, teleport to, or remotely activate marks")
	ELSEIF ( option == utility05_OID )
		SetInfoText("Clicking this key from your magic menu will add the selected spell to a chosen mark.\nHotkey casting needs to be registered for this to work.")
	ELSEIF ( option == utility11_OID )
		SetInfoText("Clicking this key will bring up a wheel menu with the first 8 hotcast slots. Good if you use a controller.")
	ELSEIF ( option == utility06_OID )
		SetInfoText("Allows you to equip spells into certain slots if possible.\nUseful for equipping lesser powers into hand slots for example.\nNot all spells can be equipped into non-conventional slots though.")
	ELSEIF ( option == utility08_OID )
		SetInfoText("Clicking this button while highlighting an enchantment in a crafting menu, will allow you to forget an enchantment.")
	ELSEIF ( option == utility09_OID )
		SetInfoText("Activate hotkeys for inventory exchange and container menus.\nAllows you to equip items to NPCs and teach NPC's spelltomes.")
	ELSEIF ( option == utility15_OID )
		SetInfoText("Activate hotkeys for the barter menu.")
	ELSEIF ( option == utility16_OID )
		SetInfoText("Press this key to sell items one at a time in a barter menu.")
	ELSEIF ( option == utility32_OID )
		SetInfoText("May not work as intended if there are multiple recipes for the selected item.\nGrants smithing experience when using a forge, and alchemy experience when crafting explosives from GUISE.\nWill not grant experience from NEW crafting stations in other mods")
	ELSEIF ( option == utility33_OID )
		SetInfoText("This key allows you to temper equipped items from your inventory.\nHotkey tempering requires that at least one tempering recipe exists for that particular item.")
	ELSEIF ( option == utility38_OID )
		SetInfoText("Pressing this key in your inventory, spell menu, Container Menu, or crafting menu will allow you to view additional information about an item.\nOnly works in the respective menus if the hotkeys for that menu are registered.")
	ELSEIF ( option == utility34_OID )
		SetInfoText("This slider adjusts the magnitude of the hotkey tempering.\nHotkey tempering is rebalanced, providing a percent increase to weapon health instead of a flat bonus.\nHotkey tempering is unaffected by perks.")
	ELSEIF ( option == utility36_OID )
		SetInfoText("Your armor degrades any time you are hit.\nThis slider modifies how quickly it degrades.")
	ELSEIF ( option == utility37_OID )
		SetInfoText("Your weapons degrade any time you attack.\nThis slider modifies how quickly it degrades.")
	ELSEIF ( ( option == sneakRegisteredOID_T ) || ( option == sneakHotKeyOID ) )
		SetInfoText("This button makes you sneak but only while you are holding the sneak button down")
	ELSEIF ( ( option == autoPoisonOID_T ) || ( option == autoPoisonOID_S ) )
		SetInfoText("Immediately after performing an attack, a poison from the poison hotkey list will be equipped.\nThe slider is the interval before poison is applied again.\nUnequipping your weapon resets the interval counter.")
	ELSEIF ( ( option == autoHealthPotionOID_T ) || ( option == autoHealthPotionOID_S ) )
		SetInfoText("Immediately after you get hit by an attack, you may drink a potion from the health potion hotkey list.\nThe slider is the health percentage you must be below for you to drink a potion automatically.")
	ELSEIF ( ( option == autoMagickaPotionOID_T ) || ( option == autoMagickaPotionOID_S ) )
		SetInfoText("Immediately after you cast a spell, you may drink a potion from the magicka potion hotkey list.\nThe slider is the magicka percentage you must be below for you to drink a potion automatically.")
	ELSEIF ( ( option == autoStaminaPotionOID_T ) || ( option == autoStaminaPotionOID_S ) )
		SetInfoText("Immediately after you power attack or bash, you may drink a potion from the stamina potion hotkey list.\nThe slider is the stamina percentage you must be below for you to drink a potion automatically.")
	ELSEIF ( ( option == healthPotionHotKeyOID ) || ( option == magickaPotionHotKeyOID ) || ( option == staminaPotionHotKeyOID ) || ( option == poisonHotKeyOID ) || ( option == misc1PotionHotKeyOID ) || ( option == misc2PotionHotKeyOID ) )
		SetInfoText("Use this spells from the utility spells page to populate your potion lists.\nItems you deposit with this spell are loaded into your potion list from the bottom upwards, overwriting existing potions.\nYour list will not be depopulated if you remove items from the spell chest")
	ELSEIF ( ( option == subtitleHotKeyOID ) || ( option == subtitleRegisteredOID_T ) )
		SetInfoText("Toggles subtitles on and off, by Hypno88\nCheck out his mods at: http://skyrim.nexusmods.com/users/2618334/?\nSpecial thanks to Hypno88 for offering the source code for this.")
	ELSEIF ( option == Refund_OID )
		SetInfoText("This will refund all your perks for all your skills.\nNote that some perks, including both perks from mods and from vanilla, will retain their effects even after being removed")
	ENDIF
ENDEVENT

bool FUNCTION canActionCast()
	IF !canCast
		return false
	ELSEIF ( blockCastAttack && PlayerRef.GetAnimationVariableBool("IsAttacking") )
		return false
	ELSEIF ( blockCastBlock && PlayerRef.GetAnimationVariableBool("IsBlocking") )
		return false
	ELSEIF ( blockCastBash && PlayerRef.GetAnimationVariableBool("IsBashing") )
		return false
	ELSEIF ( blockCastSpell && (PlayerRef.GetAnimationVariableBool("IsCastingDual") || PlayerRef.GetAnimationVariableBool("IsCastingLeft") || PlayerRef.GetAnimationVariableBool("IsCastingRight") ) )
		return false
	ELSEIF ( blockCastStagger && PlayerRef.GetAnimationVariableBool("IsStaggering") )
		return false
	ELSEIF ( blockCastSprint && PlayerRef.IsSprinting() )
		return false
	ELSEIF ( blockCastMount && PlayerRef.IsOnMount() )
		return false
	ELSEIF ( blockCastKill && PlayerRef.IsInKillMove() )
		return false
	ELSEIF ( blockCastJump && PlayerRef.GetAnimationVariableBool("bInJumpState") )
		return false
	ELSEIF ( blockCastBow && PlayerRef.GetAnimationVariableBool("bBowDrawn") )
		return false
	ENDIF
	return true
ENDFUNCTION

FUNCTION loadhotKeys()
	loadPages()
	IF isHealthPotionRegistered
		RegisterForKey(healthPotionHotKey)
	ENDIF
	IF isMagickaPotionRegistered
		RegisterForKey(magickaPotionHotKey)
	ENDIF
	IF isStaminaPotionRegistered
		RegisterForKey(staminaPotionHotKey)
	ENDIF
	IF isPoisonRegistered
		RegisterForKey(poisonHotKey)
	ENDIF
	IF isMisc1PotionRegistered
		RegisterForKey(misc1PotionHotKey)
	ENDIF
	IF isMisc1PotionRegistered
		RegisterForKey(misc2PotionHotKey)
	ENDIF
	registerHotKeys()
ENDFUNCTION

FUNCTION registerHotKeys()
	IF  PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys) 
		RegisterForKey(wheelKey)
		RegisterForKey(hotKey1)
		RegisterForKey(hotKey2)
		RegisterForKey(hotKey3)
		RegisterForKey(hotKey4)
		RegisterForKey(hotKey5)
		RegisterForKey(hotKey6)
		RegisterForKey(hotKey7)
		RegisterForKey(hotKey8)
		RegisterForKey(hotKey9)
		RegisterForKey(hotKey10)
		RegisterForKey(hotKey11)
		RegisterForKey(Keymod1)
		RegisterForKey(Keymod2)
		RegisterForKey(Keymod3)
		RegisterForKey(Keymod4)
		RegisterForKey(Keymod5)
		RegisterForKey(Keymod6)
		RegisterForKey(Keymod7)
		RegisterForKey(Keymod8)
		RegisterForKey(Keymod9)
		RegisterForKey(Keymod10)
		RegisterForKey(Keymod11)
		canCast = true
	ELSE 
		UnregisterForKey(wheelKey)
		UnregisterForKey(hotKey1)
		UnregisterForKey(hotKey2)
		UnregisterForKey(hotKey3)
		UnregisterForKey(hotKey4)
		UnregisterForKey(hotKey5)
		UnregisterForKey(hotKey6)
		UnregisterForKey(hotKey7)
		UnregisterForKey(hotKey8)
		UnregisterForKey(hotKey9)
		UnregisterForKey(hotKey10)
		UnregisterForKey(hotKey11)
		UnregisterForKey(Keymod1)
		UnregisterForKey(Keymod2)
		UnregisterForKey(Keymod3)
		UnregisterForKey(Keymod4)
		UnregisterForKey(Keymod5)
		UnregisterForKey(Keymod6)
		UnregisterForKey(Keymod7)
		UnregisterForKey(Keymod8)
		UnregisterForKey(Keymod9)
		UnregisterForKey(Keymod10)
		UnregisterForKey(Keymod11)
		canCast = true;
	ENDIF
ENDFUNCTION

FUNCTION FISS_SAVE()
	FISSInterface fiss = FISSFactory.getFISS()
	If !fiss
		debug.MessageBox("FISS not installed. Saving disabled")	
		return
	endif
	
	fiss.beginSave("GrimyUtilities.xml","Grimy_Utilities")
	
	fiss.saveBool("fissExists",true)
	
	fiss.saveBool("canCast",canCast)
	fiss.saveFloat("spellCost",spellCost)
	fiss.saveFloat("cooldownMult",cooldownMult)
	fiss.saveFloat("costMult",costMult)
	fiss.saveFloat("ritualCooldownMult",ritualCooldownMult)
	fiss.saveFloat("ritualCostMult",ritualCostMult)
	fiss.saveBool("blockCastAttack",blockCastAttack)
	fiss.saveBool("blockCastBlock",blockCastBlock)
	fiss.saveBool("blockCastBash",blockCastBash)
	fiss.saveBool("blockCastStagger",blockCastStagger)
	fiss.saveBool("blockCastSprint",blockCastSprint)
	fiss.saveBool("blockCastMount",blockCastMount)
	fiss.saveBool("blockCastKill",blockCastKill)
	fiss.saveBool("blockCastSpell",blockCastSpell)
	fiss.saveBool("blockCastJump",blockCastJump)
	fiss.saveBool("blockCastBow",blockCastBow)
	
	fiss.saveFloat("experienceMult ",experienceMult )
	
	fiss.saveInt("hotkey1",hotkey1)
	fiss.saveInt("hotkey2",hotkey2)
	fiss.saveInt("hotkey3",hotkey3)
	fiss.saveInt("hotkey4",hotkey4)
	fiss.saveInt("hotkey5",hotkey5)
	fiss.saveInt("hotkey6",hotkey6)
	fiss.saveInt("hotkey7",hotkey7)
	fiss.saveInt("hotkey8",hotkey8)
	fiss.saveInt("hotkey9",hotkey9)
	fiss.saveInt("hotkey10",hotkey10)
	fiss.saveInt("hotkey11",hotkey11)
	
	fiss.saveInt("Keymod1",Keymod1)
	fiss.saveInt("Keymod2",Keymod2)
	fiss.saveInt("Keymod3",Keymod3)
	fiss.saveInt("Keymod4",Keymod4)
	fiss.saveInt("Keymod5",Keymod5)
	fiss.saveInt("Keymod6",Keymod6)
	fiss.saveInt("Keymod7",Keymod7)
	fiss.saveInt("Keymod8",Keymod8)
	fiss.saveInt("Keymod9",Keymod9)
	fiss.saveInt("Keymod10",Keymod10)
	fiss.saveInt("Keymod11",Keymod11)
	
	fiss.saveBool("isRegistered",PlayerRef.HasSpell(GUI_AB_SpellMenuHotkeys))
	
	fiss.saveInt("healthPotionHotKey",healthPotionHotKey)
	fiss.saveInt("magickaPotionHotKey",magickaPotionHotKey)
	fiss.saveInt("staminaPotionHotKey",staminaPotionHotKey)
	fiss.saveInt("poisonHotKey",poisonHotKey)
	fiss.saveInt("misc1PotionHotKey",misc1PotionHotKey)
	fiss.saveInt("misc2PotionHotKey",misc2PotionHotKey)
	
	fiss.saveBool("isHealthPotionRegistered",isHealthPotionRegistered)
	fiss.saveBool("isMagickaPotionRegistered",isMagickaPotionRegistered)
	fiss.saveBool("isStaminaPotionRegistered",isStaminaPotionRegistered)
	fiss.saveBool("ispoisonRegistered",ispoisonRegistered)
	fiss.saveBool("isMisc1PotionRegistered",isMisc1PotionRegistered)
	fiss.saveBool("isMisc2PotionRegistered",isMisc2PotionRegistered)
	
	fiss.saveBool("GUI_AB_ActorTools", PlayerRef.HasSpell(GUI_AB_ActorTools))
	fiss.saveBool("GUI_AB_ObjectTools", PlayerRef.HasSpell(GUI_AB_ObjectTools))
	fiss.saveBool("GUI_AB_ObjectToolsConsole", PlayerRef.HasSpell(GUI_AB_ObjectToolsConsole))
	fiss.saveBool("GUI_AB_PlayerTools", PlayerRef.HasSpell(GUI_AB_PlayerTools))
	fiss.saveBool("GUI_AB_MarkObject", PlayerRef.HasSpell(GUI_AB_MarkObject))
	
	fiss.saveBool("GUI_AB_ResetCell", PlayerRef.HasSpell(GUI_AB_ResetCell))

	fiss.saveBool("GUI_AB_CraftingHotkeys",PlayerRef.HasSpell(GUI_AB_CraftingHotkeys))
	fiss.saveBool("GUI_AB_ContainerMenuHotkeys",PlayerRef.HasSpell(GUI_AB_ContainerMenuHotkeys))
	fiss.saveBool("GUI_AB_ContainerMenuHotkeys",PlayerRef.HasSpell(GUI_AB_ContainerMenuHotkeys))
	fiss.saveBool("GUI_AB_BarterMenuHotkeys",PlayerRef.HasSpell(GUI_AB_BarterMenuHotkeys))
	fiss.saveInt("GUI_Hotkey_CraftX",GUI_Hotkey_CraftX)
	fiss.saveInt("GUI_Hotkey_ForgetEnchantment",GUI_Hotkey_ForgetEnchantment)
	fiss.saveInt("GUI_Hotkey_AddSpellToMark",GUI_Hotkey_AddSpellToMark)
	fiss.saveInt("GUI_Hotkey_HotcastSpellSelect",GUI_Hotkey_HotcastSpellSelect)
	fiss.saveInt("GUI_Hotkey_ForgetSpellKey",GUI_Hotkey_ForgetSpellKey)
	fiss.saveInt("GUI_Hotkey_ForceEquip",GUI_Hotkey_ForceEquip)
	fiss.saveInt("GUI_Hotkey_InspectKey",GUI_Hotkey_InspectKey)
	fiss.saveInt("GUI_Hotkey_TemperKey",GUI_Hotkey_TemperKey)
	fiss.saveFloat("GUI_Hotkey_TemperMag",GUI_Hotkey_TemperMag)
	fiss.saveInt("GUI_Hotkey_BarterSellOne",GUI_Hotkey_BarterSellOne)
	

	fiss.saveBool("GUI_AB_InventoryHotkeys", PlayerRef.HasSpell(GUI_AB_InventoryHotkeys))
	fiss.saveInt("GUI_Hotkey_FavoriteGroup",GUI_Hotkey_FavoriteGroup)
	
	fiss.saveBool("GUI_AB_AutoHealthPotion", PlayerRef.HasSpell(GUI_AB_AutoHealthPotion))
	fiss.saveBool("GUI_AB_AutoMagickaPotion", PlayerRef.HasSpell(GUI_AB_AutoMagickaPotion))
	fiss.saveBool("GUI_AB_AutoStaminaPotion", PlayerRef.HasSpell(GUI_AB_AutoStaminaPotion))
	fiss.saveBool("GUI_AB_AutoPoison", PlayerRef.HasSpell(GUI_AB_AutoPoison))
	
	fiss.saveInt("GUI_Interval_AutoPoison",GUI_Interval_AutoPoison)
	fiss.saveFloat("GUI_Interval_AutoHealthPotion",GUI_Interval_AutoHealthPotion)
	fiss.saveFloat("GUI_Interval_AutoMagickaPotion",GUI_Interval_AutoMagickaPotion)
	fiss.saveFloat("GUI_Interval_AutoStaminaPotion",GUI_Interval_AutoStaminaPotion)
	fiss.saveFloat("GUI_Interval_AutoHealthPotionCooldown",GUI_Interval_AutoHealthPotionCooldown)
	fiss.saveFloat("GUI_Interval_AutoMagickaPotionCooldown",GUI_Interval_AutoMagickaPotionCooldown)
	fiss.saveFloat("GUI_Interval_AutoStaminaPotionCooldown",GUI_Interval_AutoStaminaPotionCooldown)
	
	fiss.saveBool("GUI_AB_SneakToggle",PlayerRef.HasSpell(GUI_AB_SneakToggle))
	fiss.saveInt("GUI_Hotkey_SneakToggle",GUI_Hotkey_SneakToggle)
	fiss.saveBool("GUI_AB_SubtitleToggle",PlayerRef.HasSpell(GUI_AB_SubtitleToggle))
	fiss.saveInt("GUI_Hotkey_SubtitleToggle",GUI_Hotkey_SubtitleToggle)
	
	string saveResult = fiss.endSave()
	
	IF saveResult != ""
		debug.Trace(saveResult)
	ENDIF
ENDFUNCTION

FUNCTION FISS_LOAD()
	FISSInterface fiss = FISSFactory.getFISS()
	If !fiss
		debug.MessageBox("FISS not installed. Saving disabled")
		return
	endif
	
	fiss.beginLoad("GrimyUtilities.xml")

	IF fiss.loadBool("fissExists")
		canCast = fiss.loadBool("canCast")
		spellCost = fiss.loadFloat("spellCost")
		cooldownMult = fiss.loadFloat("cooldownMult")
		costMult = fiss.loadFloat("costMult")
		ritualCooldownMult = fiss.loadFloat("ritualCooldownMult")
		ritualCostMult = fiss.loadFloat("ritualCostMult")
		blockCastAttack = fiss.loadBool("blockCastAttack")
		blockCastBlock = fiss.loadBool("blockCastBlock")
		blockCastBash = fiss.loadBool("blockCastBash")
		blockCastStagger = fiss.loadBool("blockCastStagger")
		blockCastSprint = fiss.loadBool("blockCastSprint")
		blockCastMount = fiss.loadBool("blockCastMount")
		blockCastKill = fiss.loadBool("blockCastKill")
		blockCastSpell = fiss.loadBool("blockCastSpell")
		blockCastJump = fiss.loadBool("blockCastJump")
		blockCastBow = fiss.loadBool("blockCastBow")
		
		experienceMult = fiss.loadFloat("experienceMult ")
		
		hotkey1 = fiss.loadInt("hotkey1")
		hotkey2 = fiss.loadInt("hotkey2")
		hotkey3 = fiss.loadInt("hotkey3")
		hotkey4 = fiss.loadInt("hotkey4")
		hotkey5 = fiss.loadInt("hotkey5")
		hotkey6 = fiss.loadInt("hotkey6")
		hotkey7 = fiss.loadInt("hotkey7")
		hotkey8 = fiss.loadInt("hotkey8")
		hotkey9 = fiss.loadInt("hotkey9")
		hotkey10 = fiss.loadInt("hotkey10")
		hotkey11 = fiss.loadInt("hotkey11")
		
		Keymod1 = fiss.loadInt("Keymod1")
		Keymod2 = fiss.loadInt("Keymod2")
		Keymod3 = fiss.loadInt("Keymod3")
		Keymod4 = fiss.loadInt("Keymod4")
		Keymod5 = fiss.loadInt("Keymod5")
		Keymod6 = fiss.loadInt("Keymod6")
		Keymod7 = fiss.loadInt("Keymod7")
		Keymod8 = fiss.loadInt("Keymod8")
		Keymod9 = fiss.loadInt("Keymod9")
		Keymod10 = fiss.loadInt("Keymod10")
		Keymod11 = fiss.loadInt("Keymod11")
		
		fissLoadSpell(fiss.loadBool("isRegistered"),GUI_AB_SpellMenuHotkeys)
		
		healthPotionHotKey = fiss.loadInt("healthPotionHotKey")
		magickaPotionHotKey = fiss.loadInt("magickaPotionHotKey")
		staminaPotionHotKey = fiss.loadInt("staminaPotionHotKey")
		poisonHotKey = fiss.loadInt("poisonHotKey")
		misc1PotionHotKey = fiss.loadInt("misc1PotionHotKey")
		misc2PotionHotKey = fiss.loadInt("misc2PotionHotKey")
		
		fissLoadSpell(fiss.loadBool("GUI_AB_AutoHealthPotion"),GUI_AB_AutoHealthPotion)
		fissLoadSpell(fiss.loadBool("GUI_AB_AutoMagickaPotion"),GUI_AB_AutoMagickaPotion)
		fissLoadSpell(fiss.loadBool("GUI_AB_AutoStaminaPotion"),GUI_AB_AutoStaminaPotion)
		fissLoadSpell(fiss.loadBool("GUI_AB_AutoPoison"),GUI_AB_AutoPoison)
		
		isHealthPotionRegistered = fiss.loadBool("isHealthPotionRegistered")
		isMagickaPotionRegistered = fiss.loadBool("isMagickaPotionRegistered")
		isStaminaPotionRegistered = fiss.loadBool("isStaminaPotionRegistered")
		ispoisonRegistered = fiss.loadBool("ispoisonRegistered")
		isMisc1PotionRegistered = fiss.loadBool("isMisc1PotionRegistered")
		isMisc2PotionRegistered = fiss.loadBool("isMisc2PotionRegistered")
		
		GUI_Interval_AutoPoison = fiss.loadInt("GUI_Interval_AutoPoison")
		GUI_Interval_AutoHealthPotion = fiss.loadFloat("GUI_Interval_AutoHealthPotion")
		GUI_Interval_AutoMagickaPotion = fiss.loadFloat("GUI_Interval_AutoMagickaPotion")
		GUI_Interval_AutoStaminaPotion = fiss.loadFloat("GUI_Interval_AutoStaminaPotion")
		GUI_Interval_AutoHealthPotionCooldown = fiss.loadFloat("GUI_Interval_AutoHealthPotionCooldown")
		GUI_Interval_AutoMagickaPotionCooldown = fiss.loadFloat("GUI_Interval_AutoMagickaPotionCooldown")
		GUI_Interval_AutoStaminaPotionCooldown = fiss.loadFloat("GUI_Interval_AutoStaminaPotionCooldown")
		
		fissLoadSpell("GUI_AB_SneakToggle",GUI_AB_SneakToggle)
		GUI_Hotkey_SneakToggle = fiss.loadInt("GUI_Hotkey_SneakToggle")
		fissLoadSpell("GUI_AB_SubtitleToggle",GUI_AB_SubtitleToggle)
		GUI_Hotkey_SubtitleToggle = fiss.loadInt("GUI_Hotkey_SubtitleToggle")
		
		fissLoadSpell(fiss.loadBool("GUI_AB_ActorTools"), GUI_AB_ActorTools)
		fissLoadSpell(fiss.loadBool("GUI_AB_ObjectTools"), GUI_AB_ObjectTools)
		fissLoadSpell(fiss.loadBool("GUI_AB_ObjectToolsConsole"), GUI_AB_ObjectToolsConsole)
		fissLoadSpell(fiss.loadBool("GUI_AB_PlayerTools"), GUI_AB_PlayerTools)
		fissLoadSpell(fiss.loadBool("GUI_AB_MarkObject"), GUI_AB_MarkObject)
		
		fissLoadSpell(fiss.loadBool("GUI_AB_ResetCell"), GUI_AB_ResetCell)

		fissLoadSpell(fiss.loadBool("GUI_AB_CraftingHotkeys"), GUI_AB_CraftingHotkeys)
		fissLoadSpell(fiss.loadBool("GUI_AB_ContainerMenuHotkeys"), GUI_AB_ContainerMenuHotkeys)
		fissLoadSpell(fiss.loadBool("GUI_AB_ContainerMenuHotkeys"), GUI_AB_ContainerMenuHotkeys)
		fissLoadSpell(fiss.loadBool("GUI_AB_BarterMenuHotkeys"), GUI_AB_BarterMenuHotkeys)
		GUI_Hotkey_CraftX = fiss.loadInt("GUI_Hotkey_CraftX")
		GUI_Hotkey_ForgetEnchantment = fiss.loadInt("GUI_Hotkey_ForgetEnchantment")
		GUI_Hotkey_AddSpellToMark = fiss.loadInt("GUI_Hotkey_AddSpellToMark")
		GUI_Hotkey_HotcastSpellSelect = fiss.loadInt("GUI_Hotkey_HotcastSpellSelect")
		GUI_Hotkey_ForgetSpellKey = fiss.loadInt("GUI_Hotkey_ForgetSpellKey")
		GUI_Hotkey_ForceEquip = fiss.loadInt("GUI_Hotkey_ForceEquip")
		GUI_Hotkey_InspectKey = fiss.loadInt("GUI_Hotkey_InspectKey")
		GUI_Hotkey_TemperKey = fiss.loadInt("GUI_Hotkey_TemperKey")
		GUI_Hotkey_TemperMag = fiss.loadFloat("GUI_Hotkey_TemperMag")
		GUI_Hotkey_BarterSellOne = fiss.loadInt("GUI_Hotkey_BarterSellOne")
		
		fissLoadSpell(fiss.loadBool("GUI_AB_InventoryHotkeys"), GUI_AB_InventoryHotkeys)
		GUI_Hotkey_FavoriteGroup = fiss.loadInt("GUI_Hotkey_FavoriteGroup")
		
		string loadResult = fiss.endLoad()
		IF loadResult != ""
			debug.Trace(loadResult)
		ENDIF
		
		loadhotKeys()
		registerHotKeys()
		
		;reload your current page
		setToggleOptionValue(autoHealthPotionOID_T, PlayerRef.HasSpell(GUI_AB_AutoHealthPotion) )
		setToggleOptionValue(autoMagickaPotionOID_T, PlayerRef.HasSpell(GUI_AB_AutoMagickaPotion) )
		setSliderOptionValue(autoHealthPotionOID_S, GUI_Interval_AutoHealthPotion, "{2}" )
		setSliderOptionValue(autoMagickaPotionOID_S, GUI_Interval_AutoMagickaPotion, "{2}" )
		setSliderOptionValue(healthPotionCooldownOID, GUI_Interval_AutoHealthPotionCooldown, "{2}" )
		setSliderOptionValue(magickaPotionCooldownOID, GUI_Interval_AutoMagickaPotionCooldown, "{2}" )
			
		setToggleOptionValue(autoStaminaPotionOID_T, PlayerRef.HasSpell(GUI_AB_AutoStaminaPotion) )
		setToggleOptionValue(autoPoisonOID_T, PlayerRef.HasSpell(GUI_AB_AutoPoison) )
		setSliderOptionValue(autoStaminaPotionOID_S, GUI_Interval_AutoStaminaPotion, "{2}" )
		setSliderOptionValue(autoPoisonOID_S, GUI_Interval_AutoPoison, "{0}" )
		setSliderOptionValue(staminaPotionCooldownOID, GUI_Interval_AutoStaminaPotionCooldown, "{2}" )
			
		setToggleOptionValue(sneakRegisteredOID_T, PlayerRef.HasSpell(GUI_AB_SneakToggle) )
		setKeyMapOptionValue(sneakHotKeyOID, GUI_Hotkey_SneakToggle )
		setToggleOptionValue(subtitleRegisteredOID_T, PlayerRef.HasSpell(GUI_AB_SubtitleToggle) )
		setKeyMapOptionValue(subtitleHotKeyOID, GUI_Hotkey_SubtitleToggle )
	ENDIF
ENDFUNCTION

FUNCTION fissLoadSpell(BOOL akBool, SPELL akSpell)
	IF akBool
		PlayerRef.AddSpell(akSpell,false)
	ELSE 
		PlayerRef.RemoveSpell(akSpell)
	ENDIF
ENDFUNCTION

int FISSsaveOID_T;
int FISSloadOID_T
int creditsOID_T;
bool canCast = true;
float spellCost

float cooldownMult = 1.0;
float costMult = 1.0;
float ritualCooldownMult = 1.0;
float ritualCostMult = 1.0;
bool blockCastAttack = false;
bool blockCastBlock = false;
bool blockCastBash = false;
bool blockCastStagger = false;
bool blockCastSprint = false;
bool blockCastMount = false;
bool blockCastKill = false;
bool blockCastSpell = false;
bool blockCastJump = false;
bool blockCastBow = false;

int ForgetSpellOID;
int ResetKeysOID;
int setting01OID;
int setting02OID;
int setting03OID;
int setting04OID;
int setting05OID;
int setting06OID;
int setting07OID;
int setting08OID;
int setting09OID;
int setting10OID;
int setting11OID;
int setting12OID;
int setting13OID;
int setting14OID;
int setting15OID;
int setting16OID;
int setting17OID;
int setting18OID;
int setting19OID;
int setting20OID;
int setting21OID;
int setting22OID;
int setting23OID;
int setting24OID;

int balance01OID;
int balance02OID;
int balance03OID;
int balance04OID;
int balance05OID;
int balance06OID;
int balance07OID;
int balance08OID;
int balance09OID;
int balance10OID;
int balance11OID;
int balance12OID;
int balance13OID;
int balance14OID;

int balance15OID; exp slider
float experienceMult = 1.0;

int wheelkey = -1

SPELL tempSpell1
int hotkey1 = -1
int Keymod1 = -1

SPELL tempSpell2
int hotkey2 = -1
int Keymod2 = -1

SPELL tempSpell3
int hotkey3 = -1
int Keymod3 = -1

SPELL tempSpell4
int hotkey4 = -1
int Keymod4 = -1

SPELL tempSpell5
int hotkey5 = -1
int Keymod5 = -1

SPELL tempSpell6
int hotkey6 = -1
int Keymod6 = -1

SPELL tempSpell7
int hotkey7 = -1
int Keymod7 = -1

SPELL tempSpell8
int hotkey8 = -1
int Keymod8 = -1

SPELL tempSpell9
int hotkey9 = -1
int Keymod9 = -1

SPELL tempSpell10
int hotkey10 = -1
int Keymod10 = -1

SPELL tempSpell11
int hotkey11 = -1
int Keymod11 = -1

;==========Utility Spells==========
int[] renamerOID
int utility01_OID
int utility02_OID
int utility03_OID
int utility04_OID
int utility05_OID
int utility06_OID
int utility07_OID
int utility08_OID
int utility09_OID
int utility10_OID

int utility11_OID

int utility13_OID
int utility14_OID

int utility15_OID
int utility16_OID

int utility31_OID
int utility32_OID
int utility33_OID
int utility34_OID
int utility35_OID
int utility36_OID
int utility37_OID
int utility38_OID

int utility40_OID

SPELL PROPERTY GUI_AB_CraftingHotkeys AUTO
SPELL PROPERTY GUI_AB_ContainerMenuHotkeys AUTO
SPELL PROPERTY GUI_AB_BarterMenuHotkeys AUTO
SPELL PROPERTY GUI_AB_SpellMenuHotkeys AUTO
INT PROPERTY GUI_Hotkey_CraftX = 19 AUTO
INT PROPERTY GUI_Hotkey_ForgetEnchantment = 211 AUTO
INT PROPERTY GUI_Hotkey_HotcastSpellSelect = 34 AUTO
INT PROPERTY GUI_Hotkey_ForgetSpellKey = 211 AUTO
INT PROPERTY GUI_Hotkey_ForceEquip = -1 AUTO
INT PROPERTY GUI_Hotkey_InspectKey = 21 AUTO
INT PROPERTY GUI_Hotkey_AddSpellToMark = -1 AUTO
INT PROPERTY GUI_Hotkey_TemperKey = 22 AUTO
FLOAT PROPERTY GUI_Hotkey_TemperMag = 1.0 AUTO

INT PROPERTY GUI_Hotkey_BarterSellOne = 257 AUTO

INT PROPERTY GUI_hotkey_container = 19 AUTO

SPELL PROPERTY GUI_AB_ActorTools AUTO
SPELL PROPERTY GUI_AB_ObjectTools AUTO
SPELL PROPERTY GUI_AB_ObjectToolsConsole AUTO
SPELL PROPERTY GUI_AB_PlayerTools AUTO
SPELL PROPERTY GUI_AB_MarkObject AUTO

SPELL PROPERTY GUI_AB_ResetCell AUTO

SPELL PROPERTY GUI_AB_InventoryHotkeys AUTO
INT PROPERTY GUI_Hotkey_FavoriteGroup = 34 AUTO
SPELL PROPERTY GUI_AB_Degradation AUTO
FLOAT PROPERTY GUI_DegradationRateArmor = 1.0 AUTO
FLOAT PROPERTY GUI_DegradationRateWeapon = 1.0 AUTO
;==========Potion Tools==========
int tempCounter

int healthPotionHotKeyOID
int healthPotionRegisteredOID
int healthPotionMenuOID_M
int healthPotionResetOID

int healthPotionCooldownOID
int healthPotionHotKey = -1
bool isHealthPotionRegistered = false
FORM[] healthPotionList
string[] healthPotionStringList
FLOAT PROPERTY GUI_Interval_AutoHealthPotionCooldown = 1.0 AUTO

FUNCTION resetHealthPotionList()
	healthPotionList = new FORM[128]
	healthPotionStringList = new string[128]
	healthPotionList[0] = RestoreHealth01
	healthPotionList[1] = RestoreHealth02
	healthPotionList[2] = RestoreHealth03
	healthPotionList[3] = RestoreHealth04
	healthPotionList[4] = RestoreHealth05
	healthPotionList[5] = RestoreHealth06
	tempCounter = 0
	WHILE ( tempCounter < 6 )
		IF healthPotionList[tempCounter]
			healthPotionStringList[tempCounter] = tempCounter + ": " + healthPotionList[tempCounter].GetName()
		ELSE
			healthPotionStringList[tempCounter] = tempCounter + ": None"
		ENDIF
		tempCounter += 1
	ENDWHILE
	WHILE ( tempCounter < 128 )
		healthPotionList[tempCounter] = None
		healthPotionStringList[tempCounter] = tempCounter + ": None"
		tempCounter += 1
	ENDWHILE
ENDFUNCTION

FUNCTION insertHealthPotionList(INT akIndex, FORM akForm)
	healthPotionList[akIndex] = akForm
	healthPotionStringList[akIndex] = akIndex + ": " + akForm.GetName()
ENDFUNCTION

STRING[] FUNCTION getHealthPotionList()
	RETURN healthPotionStringList
ENDFUNCTION

FORM PROPERTY RestoreHealth01 AUTO
FORM PROPERTY RestoreHealth02 AUTO
FORM PROPERTY RestoreHealth03 AUTO
FORM PROPERTY RestoreHealth04 AUTO
FORM PROPERTY RestoreHealth05 AUTO
FORM PROPERTY RestoreHealth06 AUTO

int magickaPotionHotKeyOID
int magickaPotionRegisteredOID
int magickaPotionMenuOID_M
int magickaPotionResetOID

int magickaPotionCooldownOID
int magickaPotionHotKey = -1
bool isMagickaPotionRegistered = false
FORM[] magickaPotionList
string[] magickaPotionStringList
FLOAT PROPERTY GUI_Interval_AutoMagickaPotionCooldown = 1.0 AUTO

FUNCTION resetMagickaPotionList()
	magickaPotionList = new FORM[128]
	magickaPotionStringList = new string[128]
	magickaPotionList[0] = RestoreMagicka01
	magickaPotionList[1] = RestoreMagicka02
	magickaPotionList[2] = RestoreMagicka03
	magickaPotionList[3] = RestoreMagicka04
	magickaPotionList[4] = RestoreMagicka05
	magickaPotionList[5] = RestoreMagicka06
	tempCounter = 0
	WHILE ( tempCounter < 6 )
		IF ( magickaPotionList[tempCounter] == None )
			magickaPotionStringList[tempCounter] = tempCounter + ": None"
		ELSE
			magickaPotionStringList[tempCounter] = tempCounter + ": " + magickaPotionList[tempCounter].GetName()
		ENDIF
		tempCounter += 1
	ENDWHILE
	WHILE ( tempCounter < 128 )
		magickaPotionList[tempCounter] = None
		magickaPotionStringList[tempCounter] = tempCounter + ": None"
		tempCounter += 1
	ENDWHILE
ENDFUNCTION

FUNCTION insertMagickaPotionList(INT akIndex, FORM akForm)
	magickaPotionList[akIndex] = akForm
	magickaPotionStringList[akIndex] = akIndex + ": " + akForm.GetName()
ENDFUNCTION

STRING[] FUNCTION getMagickaPotionList()
	RETURN magickaPotionStringList
ENDFUNCTION

FORM PROPERTY RestoreMagicka01 AUTO
FORM PROPERTY RestoreMagicka02 AUTO
FORM PROPERTY RestoreMagicka03 AUTO
FORM PROPERTY RestoreMagicka04 AUTO
FORM PROPERTY RestoreMagicka05 AUTO
FORM PROPERTY RestoreMagicka06 AUTO

int staminaPotionHotKeyOID
int staminaPotionRegisteredOID
int staminaPotionMenuOID_M
int staminaPotionResetOID

int staminaPotionCooldownOID
int staminaPotionHotKey = -1
bool isStaminaPotionRegistered = false
FORM[] staminaPotionList
string[] staminaPotionStringList
FLOAT PROPERTY GUI_Interval_AutoStaminaPotionCooldown = 1.0 AUTO

FUNCTION resetStaminaPotionList()
	staminaPotionList = new FORM[128]
	staminaPotionStringList = new string[128]
	staminaPotionList[0] = RestoreStamina01
	staminaPotionList[1] = RestoreStamina02
	staminaPotionList[2] = RestoreStamina03
	staminaPotionList[3] = RestoreStamina04
	staminaPotionList[4] = RestoreStamina05
	staminaPotionList[5] = RestoreStamina06
	tempCounter = 0
	WHILE ( tempCounter < 6 )
		IF ( staminaPotionList[tempCounter] == None )
			staminaPotionStringList[tempCounter] = tempCounter + ": None"
		ELSE
			staminaPotionStringList[tempCounter] = tempCounter + ": " + staminaPotionList[tempCounter].GetName()
		ENDIF
		tempCounter += 1
	ENDWHILE
	WHILE ( tempCounter < 128 )
		staminaPotionList[tempCounter] = None
		staminaPotionStringList[tempCounter] = tempCounter + ": None"
		tempCounter += 1
	ENDWHILE
ENDFUNCTION

FUNCTION insertStaminaPotionList(INT akIndex, FORM akForm)
	staminaPotionList[akIndex] = akForm
	staminaPotionStringList[akIndex] = akIndex + ": " + akForm.GetName()
ENDFUNCTION

STRING[] FUNCTION getStaminaPotionList()
	RETURN staminaPotionStringList
ENDFUNCTION

FORM PROPERTY RestoreStamina01 AUTO
FORM PROPERTY RestoreStamina02 AUTO
FORM PROPERTY RestoreStamina03 AUTO
FORM PROPERTY RestoreStamina04 AUTO
FORM PROPERTY RestoreStamina05 AUTO
FORM PROPERTY RestoreStamina06 AUTO

int poisonHotKeyOID
int poisonRegisteredOID
int poisonMenuOID_M
int poisonOID
int poisonShowListOID
int poisonResetOID

int poisonMenuPointer = 0
int poisonMenuPointerOption = 0
int poisonHotKey = -1
bool ispoisonRegistered = false
FORM[] poisonList
string[] poisonStringList

FUNCTION resetPoisonList()
	poisonList = new FORM[128]
	poisonStringList = new string[128]
	poisonList[0] = DamageHealth01
	poisonList[1] = DamageHealthLinger01
	poisonList[2] = DamageHealth02
	poisonList[3] = DamageHealthLinger02
	poisonList[4] = DamageHealth03
	poisonList[5] = DamageHealthLinger03
	poisonList[6] = DamageHealth04
	poisonList[7] = DamageHealthLinger04
	poisonList[8] = DamageHealth05
	
	poisonList[9] = DamageStamina01
	poisonList[10] = DamageStaminaLinger01
	poisonList[11] = DamageMagicka01
	poisonList[12] = DamageMagickaLinger01
	poisonList[13] = DamageMagickaRecovery01
	poisonList[14] = DamageStaminaRate01
	poisonList[15] = DamageStamina02
	poisonList[16] = DamageStaminaLinger02
	poisonList[17] = DamageMagicka02
	poisonList[18] = DamageMagickaLinger02
	poisonList[19] = DamageMagickaRecovery02
	poisonList[20] = DamageStaminaRate02
	poisonList[21] = DamageStamina03
	poisonList[22] = DamageStaminaLinger03
	poisonList[23] = DamageMagicka03
	poisonList[24] = DamageMagickaLinger03
	poisonList[25] = DamageMagickaRecovery03
	poisonList[26] = DamageStaminaRate03
	poisonList[27] = DamageStamina04
	poisonList[28] = DamageStaminaLinger04
	poisonList[29] = DamageMagicka04
	poisonList[30] = DamageMagickaLinger04
	poisonList[31] = DamageMagickaRecovery04
	poisonList[32] = DamageStaminaRate04
	poisonList[33] = DamageStamina05
	poisonList[34] = DamageStaminaLinger05
	poisonList[35] = DamageMagicka05
	poisonList[36] = DamageMagickaLinger05
	poisonList[37] = DamageMagickaRecovery05
	tempCounter = 0
	WHILE ( tempCounter < 38 )
		IF ( poisonList[tempCounter] == None )
			poisonStringList[tempCounter] = tempCounter + ": None"
		ELSE
			poisonStringList[tempCounter] = tempCounter + ": " + poisonList[tempCounter].GetName()
		ENDIF
		tempCounter += 1
	ENDWHILE
	WHILE ( tempCounter < 128 )
		poisonList[tempCounter] = None
		poisonStringList[tempCounter] = tempCounter + ": None"
		tempCounter += 1
	ENDWHILE
ENDFUNCTION

FUNCTION insertPoisonList(INT akIndex, FORM akForm)
	poisonList[akIndex] = akForm
	poisonStringList[akIndex] = akIndex + ": " + akForm.GetName()
ENDFUNCTION

STRING[] FUNCTION getPoisonList()
	RETURN poisonStringList
ENDFUNCTION

FORM PROPERTY DamageHealth01 AUTO
FORM PROPERTY DamageHealth02 AUTO
FORM PROPERTY DamageHealth03 AUTO
FORM PROPERTY DamageHealth04 AUTO
FORM PROPERTY DamageHealth05 AUTO

FORM PROPERTY DamageHealthLinger01 AUTO
FORM PROPERTY DamageHealthLinger02 AUTO
FORM PROPERTY DamageHealthLinger03 AUTO
FORM PROPERTY DamageHealthLinger04 AUTO
FORM PROPERTY DamageHealthLinger05 AUTO

FORM PROPERTY DamageMagicka01 AUTO
FORM PROPERTY DamageMagicka02 AUTO
FORM PROPERTY DamageMagicka03 AUTO
FORM PROPERTY DamageMagicka04 AUTO
FORM PROPERTY DamageMagicka05 AUTO

FORM PROPERTY DamageMagickaLinger01 AUTO
FORM PROPERTY DamageMagickaLinger02 AUTO
FORM PROPERTY DamageMagickaLinger03 AUTO
FORM PROPERTY DamageMagickaLinger04 AUTO
FORM PROPERTY DamageMagickaLinger05 AUTO

FORM PROPERTY DamageMagickaRecovery01 AUTO
FORM PROPERTY DamageMagickaRecovery02 AUTO
FORM PROPERTY DamageMagickaRecovery03 AUTO
FORM PROPERTY DamageMagickaRecovery04 AUTO
FORM PROPERTY DamageMagickaRecovery05 AUTO

FORM PROPERTY DamageStamina01 AUTO
FORM PROPERTY DamageStamina02 AUTO
FORM PROPERTY DamageStamina03 AUTO
FORM PROPERTY DamageStamina04 AUTO
FORM PROPERTY DamageStamina05 AUTO

FORM PROPERTY DamageStaminaLinger01 AUTO
FORM PROPERTY DamageStaminaLinger02 AUTO
FORM PROPERTY DamageStaminaLinger03 AUTO
FORM PROPERTY DamageStaminaLinger04 AUTO
FORM PROPERTY DamageStaminaLinger05 AUTO

FORM PROPERTY DamageStaminaRate01 AUTO
FORM PROPERTY DamageStaminaRate02 AUTO
FORM PROPERTY DamageStaminaRate03 AUTO
FORM PROPERTY DamageStaminaRate04 AUTO

int misc1PotionHotKeyOID
int misc1PotionRegisteredOID
int misc1PotionMenuOID_M
int misc1PotionResetOID

int misc1PotionHotKey = -1
bool isMisc1PotionRegistered = false
FORM[] misc1PotionList
string[] misc1PotionStringList

FUNCTION resetMisc1PotionList()
	misc1PotionList = new FORM[128]
	misc1PotionStringList = new string[128]
	tempCounter = 0
	WHILE ( tempCounter < 128 )
		misc1PotionList[tempCounter] = None
		misc1PotionStringList[tempCounter] = tempCounter + ": None"
		tempCounter += 1
	ENDWHILE
ENDFUNCTION

FUNCTION insertMisc1List(INT akIndex, FORM akForm)
	misc1PotionList[akIndex] = akForm
	misc1PotionStringList[akIndex] = akIndex + ": " + akForm.GetName()
ENDFUNCTION

STRING[] FUNCTION getMisc1List()
	RETURN misc1PotionStringList
ENDFUNCTION

int misc2PotionHotKeyOID
int misc2PotionRegisteredOID
int misc2PotionMenuOID_M
int misc2PotionResetOID

int misc2PotionHotKey = -1
bool isMisc2PotionRegistered = false
FORM[] misc2PotionList
string[] misc2PotionStringList

FUNCTION resetMisc2PotionList()
	misc2PotionList = new FORM[128]
	misc2PotionStringList = new string[128]
	tempCounter = 0
	WHILE ( tempCounter < 128 )
		misc2PotionList[tempCounter] = None
		misc2PotionStringList[tempCounter] = tempCounter + ": None"
		tempCounter += 1
	ENDWHILE
ENDFUNCTION

FUNCTION insertMisc2List(INT akIndex, FORM akForm)
	misc2PotionList[akIndex] = akForm
	misc2PotionStringList[akIndex] = akIndex + ": " + akForm.GetName()
ENDFUNCTION

STRING[] FUNCTION getMisc2List()
	RETURN misc2PotionStringList
ENDFUNCTION

FUNCTION equipPoison()
	equipFromList(poisonList)
ENDFUNCTION

FUNCTION equipHealthPotion()
	equipFromList(healthPotionList)
ENDFUNCTION

FUNCTION equipMagickaPotion()
	equipFromList(magickaPotionList)
ENDFUNCTION

FUNCTION equipStaminaPotion()
	equipFromList(staminaPotionList)
ENDFUNCTION

FUNCTION equipFromList(FORM[] potionList)
	IF ( PlayerRef.GetItemCount(potionList[0]) > 0 )
		PlayerRef.EquipItem(potionList[0],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[1]) > 0 )
		PlayerRef.EquipItem(potionList[1],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[2]) > 0 )
		PlayerRef.EquipItem(potionList[2],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[3]) > 0 )
		PlayerRef.EquipItem(potionList[3],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[4]) > 0 )
		PlayerRef.EquipItem(potionList[4],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[5]) > 0 )
		PlayerRef.EquipItem(potionList[5],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[6]) > 0 )
		PlayerRef.EquipItem(potionList[6],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[7]) > 0 )
		PlayerRef.EquipItem(potionList[7],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[8]) > 0 )
		PlayerRef.EquipItem(potionList[8],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[9]) > 0 )
		PlayerRef.EquipItem(potionList[9],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[10]) > 0 )
		PlayerRef.EquipItem(potionList[10],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[11]) > 0 )
		PlayerRef.EquipItem(potionList[11],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[12]) > 0 )
		PlayerRef.EquipItem(potionList[12],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[13]) > 0 )
		PlayerRef.EquipItem(potionList[13],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[14]) > 0 )
		PlayerRef.EquipItem(potionList[14],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[15]) > 0 )
		PlayerRef.EquipItem(potionList[15],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[16]) > 0 )
		PlayerRef.EquipItem(potionList[16],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[17]) > 0 )
		PlayerRef.EquipItem(potionList[17],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[18]) > 0 )
		PlayerRef.EquipItem(potionList[18],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[19]) > 0 )
		PlayerRef.EquipItem(potionList[19],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[20]) > 0 )
		PlayerRef.EquipItem(potionList[20],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[21]) > 0 )
		PlayerRef.EquipItem(potionList[21],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[22]) > 0 )
		PlayerRef.EquipItem(potionList[22],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[23]) > 0 )
		PlayerRef.EquipItem(potionList[23],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[24]) > 0 )
		PlayerRef.EquipItem(potionList[24],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[25]) > 0 )
		PlayerRef.EquipItem(potionList[25],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[26]) > 0 )
		PlayerRef.EquipItem(potionList[26],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[27]) > 0 )
		PlayerRef.EquipItem(potionList[27],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[28]) > 0 )
		PlayerRef.EquipItem(potionList[28],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[29]) > 0 )
		PlayerRef.EquipItem(potionList[29],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[30]) > 0 )
		PlayerRef.EquipItem(potionList[30],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[31]) > 0 )
		PlayerRef.EquipItem(potionList[31],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[32]) > 0 )
		PlayerRef.EquipItem(potionList[32],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[33]) > 0 )
		PlayerRef.EquipItem(potionList[33],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[34]) > 0 )
		PlayerRef.EquipItem(potionList[34],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[35]) > 0 )
		PlayerRef.EquipItem(potionList[35],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[36]) > 0 )
		PlayerRef.EquipItem(potionList[36],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[37]) > 0 )
		PlayerRef.EquipItem(potionList[37],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[38]) > 0 )
		PlayerRef.EquipItem(potionList[38],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[39]) > 0 )
		PlayerRef.EquipItem(potionList[39],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[40]) > 0 )
		PlayerRef.EquipItem(potionList[40],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[41]) > 0 )
		PlayerRef.EquipItem(potionList[41],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[42]) > 0 )
		PlayerRef.EquipItem(potionList[42],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[43]) > 0 )
		PlayerRef.EquipItem(potionList[43],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[44]) > 0 )
		PlayerRef.EquipItem(potionList[44],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[45]) > 0 )
		PlayerRef.EquipItem(potionList[45],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[46]) > 0 )
		PlayerRef.EquipItem(potionList[46],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[47]) > 0 )
		PlayerRef.EquipItem(potionList[47],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[48]) > 0 )
		PlayerRef.EquipItem(potionList[48],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[49]) > 0 )
		PlayerRef.EquipItem(potionList[49],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[50]) > 0 )
		PlayerRef.EquipItem(potionList[50],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[51]) > 0 )
		PlayerRef.EquipItem(potionList[51],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[52]) > 0 )
		PlayerRef.EquipItem(potionList[52],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[53]) > 0 )
		PlayerRef.EquipItem(potionList[53],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[54]) > 0 )
		PlayerRef.EquipItem(potionList[54],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[55]) > 0 )
		PlayerRef.EquipItem(potionList[55],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[56]) > 0 )
		PlayerRef.EquipItem(potionList[56],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[57]) > 0 )
		PlayerRef.EquipItem(potionList[57],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[58]) > 0 )
		PlayerRef.EquipItem(potionList[58],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[59]) > 0 )
		PlayerRef.EquipItem(potionList[59],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[60]) > 0 )
		PlayerRef.EquipItem(potionList[60],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[61]) > 0 )
		PlayerRef.EquipItem(potionList[61],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[62]) > 0 )
		PlayerRef.EquipItem(potionList[62],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[63]) > 0 )
		PlayerRef.EquipItem(potionList[63],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[64]) > 0 )
		PlayerRef.EquipItem(potionList[64],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[65]) > 0 )
		PlayerRef.EquipItem(potionList[65],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[66]) > 0 )
		PlayerRef.EquipItem(potionList[66],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[67]) > 0 )
		PlayerRef.EquipItem(potionList[67],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[68]) > 0 )
		PlayerRef.EquipItem(potionList[68],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[69]) > 0 )
		PlayerRef.EquipItem(potionList[69],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[70]) > 0 )
		PlayerRef.EquipItem(potionList[70],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[71]) > 0 )
		PlayerRef.EquipItem(potionList[71],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[72]) > 0 )
		PlayerRef.EquipItem(potionList[72],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[73]) > 0 )
		PlayerRef.EquipItem(potionList[73],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[74]) > 0 )
		PlayerRef.EquipItem(potionList[74],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[75]) > 0 )
		PlayerRef.EquipItem(potionList[75],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[76]) > 0 )
		PlayerRef.EquipItem(potionList[76],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[77]) > 0 )
		PlayerRef.EquipItem(potionList[77],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[78]) > 0 )
		PlayerRef.EquipItem(potionList[78],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[79]) > 0 )
		PlayerRef.EquipItem(potionList[79],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[80]) > 0 )
		PlayerRef.EquipItem(potionList[80],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[81]) > 0 )
		PlayerRef.EquipItem(potionList[81],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[82]) > 0 )
		PlayerRef.EquipItem(potionList[82],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[83]) > 0 )
		PlayerRef.EquipItem(potionList[83],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[84]) > 0 )
		PlayerRef.EquipItem(potionList[84],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[85]) > 0 )
		PlayerRef.EquipItem(potionList[85],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[86]) > 0 )
		PlayerRef.EquipItem(potionList[86],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[87]) > 0 )
		PlayerRef.EquipItem(potionList[87],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[88]) > 0 )
		PlayerRef.EquipItem(potionList[88],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[89]) > 0 )
		PlayerRef.EquipItem(potionList[89],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[90]) > 0 )
		PlayerRef.EquipItem(potionList[90],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[91]) > 0 )
		PlayerRef.EquipItem(potionList[91],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[92]) > 0 )
		PlayerRef.EquipItem(potionList[92],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[93]) > 0 )
		PlayerRef.EquipItem(potionList[93],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[94]) > 0 )
		PlayerRef.EquipItem(potionList[94],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[95]) > 0 )
		PlayerRef.EquipItem(potionList[95],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[96]) > 0 )
		PlayerRef.EquipItem(potionList[96],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[97]) > 0 )
		PlayerRef.EquipItem(potionList[97],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[98]) > 0 )
		PlayerRef.EquipItem(potionList[98],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[99]) > 0 )
		PlayerRef.EquipItem(potionList[99],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[100]) > 0 )
		PlayerRef.EquipItem(potionList[100],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[101]) > 0 )
		PlayerRef.EquipItem(potionList[101],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[102]) > 0 )
		PlayerRef.EquipItem(potionList[102],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[103]) > 0 )
		PlayerRef.EquipItem(potionList[103],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[104]) > 0 )
		PlayerRef.EquipItem(potionList[104],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[105]) > 0 )
		PlayerRef.EquipItem(potionList[105],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[106]) > 0 )
		PlayerRef.EquipItem(potionList[106],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[107]) > 0 )
		PlayerRef.EquipItem(potionList[107],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[108]) > 0 )
		PlayerRef.EquipItem(potionList[108],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[109]) > 0 )
		PlayerRef.EquipItem(potionList[109],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[110]) > 0 )
		PlayerRef.EquipItem(potionList[110],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[111]) > 0 )
		PlayerRef.EquipItem(potionList[111],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[112]) > 0 )
		PlayerRef.EquipItem(potionList[112],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[113]) > 0 )
		PlayerRef.EquipItem(potionList[113],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[114]) > 0 )
		PlayerRef.EquipItem(potionList[114],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[115]) > 0 )
		PlayerRef.EquipItem(potionList[115],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[116]) > 0 )
		PlayerRef.EquipItem(potionList[116],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[117]) > 0 )
		PlayerRef.EquipItem(potionList[117],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[118]) > 0 )
		PlayerRef.EquipItem(potionList[118],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[119]) > 0 )
		PlayerRef.EquipItem(potionList[119],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[120]) > 0 )
		PlayerRef.EquipItem(potionList[120],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[121]) > 0 )
		PlayerRef.EquipItem(potionList[121],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[122]) > 0 )
		PlayerRef.EquipItem(potionList[122],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[123]) > 0 )
		PlayerRef.EquipItem(potionList[123],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[124]) > 0 )
		PlayerRef.EquipItem(potionList[124],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[125]) > 0 )
		PlayerRef.EquipItem(potionList[125],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[126]) > 0 )
		PlayerRef.EquipItem(potionList[126],false,true)
	ELSEIF ( PlayerRef.GetItemCount(potionList[127]) > 0 )
		PlayerRef.EquipItem(potionList[127],false,true)
	ENDIF
ENDFUNCTION

FUNCTION healthContainerFill(FORM akItem, int akSlot)
	healthPotionList[akSlot] = akItem
	healthPotionStringList[akSlot] = akSlot + ": " + healthPotionList[akSlot].GetName()
ENDFUNCTION

FUNCTION magickaContainerFill(FORM akItem, int akSlot)
	magickaPotionList[akSlot] = akItem
	magickaPotionStringList[akSlot] = akSlot + ": " + magickaPotionList[akSlot].GetName()
ENDFUNCTION

FUNCTION staminaContainerFill(FORM akItem, int akSlot)
	staminaPotionList[akSlot] = akItem
	staminaPotionStringList[akSlot] = akSlot + ": " + staminaPotionList[akSlot].GetName()
ENDFUNCTION

FUNCTION poisonContainerFill(FORM akItem, int akSlot)
	poisonList[akSlot] = akItem
	poisonStringList[akSlot] = akSlot + ": " + poisonList[akSlot].GetName()
ENDFUNCTION

FUNCTION misc1ContainerFill(FORM akItem, int akSlot)
	misc1PotionList[akSlot] = akItem
	misc1PotionStringList[akSlot] = akSlot + ": " + misc1PotionList[akSlot].GetName()
ENDFUNCTION

FUNCTION misc2ContainerFill(FORM akItem, int akSlot)
	misc2PotionList[akSlot] = akItem
	misc2PotionStringList[akSlot] = akSlot + ": " + misc2PotionList[akSlot].GetName()
ENDFUNCTION

;==========Actor Tools==========
int autoPoisonOID_T
int autoPoisonOID_S
int autoHealthPotionOID_T
int autoHealthPotionOID_S
int autoMagickaPotionOID_T
int autoMagickaPotionOID_S
int autoStaminaPotionOID_T
int autoStaminaPotionOID_S

SPELL PROPERTY GUI_AB_AutoPoison AUTO
SPELL PROPERTY GUI_AB_AutoHealthPotion AUTO
SPELL PROPERTY GUI_AB_AutoMagickaPotion AUTO	
SPELL PROPERTY GUI_AB_AutoStaminaPotion AUTO	
INT PROPERTY GUI_Interval_AutoPoison = 1 AUTO
FLOAT PROPERTY GUI_Interval_AutoHealthPotion = 0.25 AUTO
FLOAT PROPERTY GUI_Interval_AutoMagickaPotion = 0.25 AUTO
FLOAT PROPERTY GUI_Interval_AutoStaminaPotion = 0.25 AUTO
;==========Achievements==========
int sneakRegisteredOID_T
int sneakHotKeyOID

SPELL PROPERTY GUI_AB_SneakToggle AUTO
INT PROPERTY GUI_Hotkey_SneakToggle = -1 AUTO

int subtitleRegisteredOID_T
int subtitleHotKeyOID

SPELL PROPERTY GUI_AB_SubtitleToggle AUTO
INT PROPERTY GUI_Hotkey_SubtitleToggle = -1 AUTO

int achievementOID

;==========Perk Refunds==========
int Refund_OID
int RF_OneHanded_OID
int RF_TwoHanded_OID
int RF_Marksman_OID
int RF_Block_OID
int RF_Smithing_OID
int RF_HeavyArmor_OID
int RF_LightArmor_OID
int RF_Pickpocket_OID
int RF_Lockpicking_OID
int RF_Sneak_OID
int RF_Alchemy_OID
int RF_Speechcraft_OID
int RF_Alteration_OID
int RF_Conjuration_OID
int RF_Destruction_OID
int RF_Illusion_OID
int RF_Restoration_OID
int RF_Enchanting_OID

INT FUNCTION RefundPerks(STRING AVstring)
	ACTORVALUEINFO akAVI = ActorValueInfo.GetAVIByName(AVstring)
	IF akAVI
		PERK[] akPerks = akAVI.GetPerks(PlayerRef,false,true)
		IF akperks
			INT i = 0
			WHILE i < akPerks.Length
				IF PlayerRef.hasPerk(akperks[i])
					PlayerRef.RemovePerk(akperks[i])
					AddPerkPoints(1)
				ENDIF
				i += 1
			ENDWHILE
			RETURN i
		ELSE
			ShowMessage("Error loading perk tree")
		ENDIF
	ELSE
		ShowMessage("Unrecognized Actor Value")
	ENDIF
	RETURN 0
ENDFUNCTION

;==========Spell Manipulation==========
STRING[] FUNCTION getSpellNames()
	STRING[] retStrings = new STRING[12]
	retStrings[0] = "#1 " + parseName(tempSpell1)
	retStrings[1] = "#2 " + parseName(tempSpell2)
	retStrings[2] = "#3 " + parseName(tempSpell3)
	retStrings[3] = "#4 " + parseName(tempSpell4)
	retStrings[4] = "#5 " + parseName(tempSpell5)
	retStrings[5] = "#6 " + parseName(tempSpell6)
	retStrings[6] = "#7 " + parseName(tempSpell7)
	retStrings[7] = "#8 " + parseName(tempSpell8)
	retStrings[8] = "#9 " + parseName(tempSpell9)
	retStrings[9] = "#10 " + parseName(tempSpell10)
	retStrings[10] = "#11 " + parseName(tempSpell11)
	retStrings[11] = "Cancel"
	return retStrings
ENDFUNCTION

STRING FUNCTION parseName(SPELL akSpell)
	IF akSpell == None
		RETURN ""
	ELSE
		RETURN akSpell.getName()
	ENDIF
ENDFUNCTION

FUNCTION setSpell(INT akIndex, SPELL akSpell)
	IF akIndex < 6
		IF akIndex < 3
			IF akIndex == 0
				tempSpell1 = akSpell
				(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",0,tempSpell1.GetName())
				(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",0,true)
			ELSEIF akIndex == 1
				tempSpell2 = akSpell
				(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",1,tempSpell2.GetName())
				(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",1,true)
			ELSE
				tempSpell3 = akSpell
				(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",2,tempSpell3.GetName())
				(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",2,true)
			ENDIF
		ELSE
			IF akIndex == 3
				tempSpell4 = akSpell
				(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",3,tempSpell4.GetName())
				(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",3,true)
			ELSEIF akIndex == 4
				tempSpell5 = akSpell
				(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",4,tempSpell5.GetName())
				(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",4,true)
			ELSE
				tempSpell6 = akSpell
				(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionText",5,tempSpell6.GetName())
				(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",5,tempSpell6.GetName())
				(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",5,true)
			ENDIF
		ENDIF
	ELSE
		IF akIndex < 9
			IF akIndex == 6
				tempSpell7 = akSpell
				(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",6,tempSpell7.GetName())
				(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",6,true)
			ELSEIF akIndex == 7
				tempSpell8 = akSpell
				(GUI_UILib As UIWheelMenu).SetPropertyIndexString("optionLabelText",7,tempSpell8.GetName())
				(GUI_UILib As UIWheelMenu).SetPropertyIndexBool("optionEnabled",7,true)
			ELSE
				tempSpell9 = akSpell
			ENDIF
		ELSE
			IF akIndex == 9
				tempSpell10 = akSpell
			ELSE
				tempSpell11 = akSpell
			ENDIF
		ENDIF
	ENDIF
	
ENDFUNCTION

FUNCTION addToObjectList(INT akIndex, OBJECTREFERENCE akRef)
	objectList[akIndex] = akRef
ENDFUNCTION 

STRING FUNCTION getObjectString(OBJECTREFERENCE akRef)
	IF akRef
		RETURN akRef.GetDisplayName()
	ELSE
		RETURN "Empty Slot"
	ENDIF 
ENDFUNCTION

STRING[] FUNCTION getObjectListString()
	STRING[] returnList = new STRING[20]
	returnList[0] = getObjectString(objectList[0])
	returnList[1] = getObjectString(objectList[1])
	returnList[2] = getObjectString(objectList[2])
	returnList[3] = getObjectString(objectList[3])
	returnList[4] = getObjectString(objectList[4])
	returnList[5] = getObjectString(objectList[5])
	returnList[6] = getObjectString(objectList[6])
	returnList[7] = getObjectString(objectList[7])
	returnList[8] = getObjectString(objectList[8])
	returnList[9] = getObjectString(objectList[9])
	returnList[10] = getObjectString(objectList[10])
	returnList[11] = getObjectString(objectList[11])
	returnList[12] = getObjectString(objectList[12])
	returnList[13] = getObjectString(objectList[13])
	returnList[14] = getObjectString(objectList[14])
	returnList[15] = getObjectString(objectList[15])
	returnList[16] = getObjectString(objectList[16])
	returnList[17] = getObjectString(objectList[17])
	returnList[18] = getObjectString(objectList[18])
	returnList[19] = getObjectString(objectList[19])
	Return returnList
ENDFUNCTION

;==========Idles Tool==========

STRING[] PROPERTY IdlesList AUTO

Function fissSaveIdles()
	FISSInterface fiss = FISSFactory.getFISS()
	If !fiss
		Debug.Notification("Error, FISS is required for this feature.")
		RETURN
	ENDIF
	fiss.beginSave("GUI_Idles.xml","GUI_Idles")

	int i = 0
	While i < 30
		fiss.saveString("GUI_IDLE_" + i,IdlesList[i])
		i += 1
	EndWhile

	string saveResult = fiss.endSave()
	IF saveResult != ""
		debug.Trace(saveResult)
		RETURN
	ENDIF
	Debug.Notification("Done saving preset")
EndFunction 

Function fissLoadIdles()
	FISSInterface fiss = FISSFactory.getFISS()
	If !fiss
		Debug.Notification("Error, FISS is required for this feature.")
		RETURN
	ENDIF
	fiss.beginLoad("GUI_Idles.xml")

	int i = 0
	While i < 30
		IdlesList[i] = fiss.loadString("GUI_IDLE_" + i)
		i += 1
	EndWhile

	string loadResult = fiss.endLoad()
	IF loadResult != ""
		debug.Trace(loadResult)
		RETURN
	ENDIF
	Debug.Notification("Done loading preset")
EndFunction 

;==========Object Undo==========
ObjectReference undoRef
Float posX
Float posY
Float posZ
Function recordRef(ObjectReference akRef)
	undoRef = akRef
	posX = akRef.GetPositionX()
	posY = akRef.GetPositionY()
	posZ = akRef.GetPositionZ()
EndFunction

Function undoRef()
	If undoRef
		undoRef.SetPosition(posX,posY,posZ)
	EndIf
EndFunction

;==========Inspect Tools==========
IMPORT WornObject
IMPORT Math
Quest Property GUI_UILib AUTO
STRING[] PROPERTY slotMasks AUTO
FUNCTION inspectForm(FORM akForm)
	IF akForm AS WEAPON
		INT akIndex = ((GUI_UILib as FORM) as UILIB_GRIMY).ShowList("Inspect " + akForm.GetName(), getWeaponInfo(akForm AS WEAPON), 0, 0)
		IF akIndex == 3
			inspectForm((akForm AS WEAPON).GetEnchantment())
		ELSEIF akIndex == 11
			inspectForm((akForm AS WEAPON).GetCritEffect())
		ENDIF
	ELSEIF akForm AS ARMOR
		INT akIndex = ((GUI_UILib as FORM) as UILIB_GRIMY).ShowList("Inspect " + akForm.GetName(), getArmorInfo(akForm AS ARMOR), 0, 0)
		IF akIndex == 2
			inspectForm((akForm AS ARMOR).GetEnchantment())
		ENDIF
	ELSEIF akForm AS BOOK
		INT akIndex = ((GUI_UILib as FORM) as UILIB_GRIMY).ShowList("Inspect " + akForm.GetName(), getBookInfo(akForm AS BOOK), 0, 0)
		IF akIndex == 5 && (akForm AS BOOK).GetSpell()
			inspectForm((akForm AS BOOK).GetSpell())
		ENDIF
	ELSEIF akForm AS POTION
		INT akIndex = ((GUI_UILib as FORM) as UILIB_GRIMY).ShowList("Inspect " + akForm.GetName(), getPotionInfo(akForm AS POTION), 0, 0)
		IF ( akIndex >= 8 ) && ( akIndex <= (4 * (akForm AS POTION).GetNumEffects() + 8) )
			akIndex = ( akIndex - 8 ) / 4
			inspectForm((akForm AS POTION).GetNthEffectMagicEffect(akIndex))
		ENDIF
	ELSEIF akForm AS INGREDIENT
		INT akIndex = ((GUI_UILib as FORM) as UILIB_GRIMY).ShowList("Inspect " + akForm.GetName(), getIngrInfo(akForm AS INGREDIENT), 0, 0)
		IF ( akIndex >= 5 ) && ( akIndex <= (4 * (akForm AS INGREDIENT).GetNumEffects() + 5) )
			akIndex = ( akIndex - 5 ) / 4
			inspectForm((akForm AS INGREDIENT).GetNthEffectMagicEffect(akIndex))
		ENDIF
	ELSEIF akForm AS SCROLL
		INT akIndex = ((GUI_UILib as FORM) as UILIB_GRIMY).ShowList("Inspect " + akForm.GetName(), getScrollInfo(akForm AS SCROLL), 0, 0)
		IF ( akIndex >= 5 ) && ( akIndex <= (4 * (akForm AS SCROLL).GetNumEffects() + 5) )
			akIndex = ( akIndex - 5 ) / 4
			inspectForm((akForm AS SCROLL).GetNthEffectMagicEffect(akIndex))
		ENDIF
	ELSEIF akForm AS SPELL
		INT akIndex = ((GUI_UILib as FORM) as UILIB_GRIMY).ShowList("Inspect " + akForm.GetName(), getSpellInfo(akForm AS SPELL), 0, 0)
		IF ( akIndex >= 6 ) && ( akIndex <= (4 * (akForm AS SPELL).GetNumEffects() + 6) )
			akIndex = ( akIndex - 6 ) / 4
			inspectForm((akForm AS SPELL).GetNthEffectMagicEffect(akIndex))
		ENDIF
	ELSEIF akForm AS ENCHANTMENT
		INT akIndex = ((GUI_UILib as FORM) as UILIB_GRIMY).ShowList("Inspect " + akForm.GetName(), getEnchInfo(akForm AS ENCHANTMENT), 0, 0)
		IF akIndex == 2
			inspectForm((akForm AS ENCHANTMENT).GetBaseEnchantment())
		ELSEIF ( akIndex >= 4 ) && ( akIndex <= (4 * (akForm AS ENCHANTMENT).GetNumEffects() + 4) )
			akIndex = ( akIndex - 4 ) / 4
			inspectForm((akForm AS ENCHANTMENT).GetNthEffectMagicEffect(akIndex))
		ENDIF
	ELSEIF akForm AS SHOUT
		INT akIndex = ((GUI_UILib as FORM) as UILIB_GRIMY).ShowList("Inspect " + akForm.GetName(), getShoutInfo(akForm AS SHOUT), 0, 0)
		IF (akIndex <= 3 ) && ( akIndex >= 1)
			inspectForm((akForm AS SHOUT).GetNthSpell(akIndex - 1))
		ENDIF
	ELSEIF akForm AS MAGICEFFECT
		INT akIndex = ((GUI_UILib as FORM) as UILIB_GRIMY).ShowList("Inspect " + akForm.GetName(), getMGEFInfo(akForm AS MAGICEFFECT), 0, 0)
		IF akIndex == 25
			inspectForm((akForm AS MAGICEFFECT).GetEquipAbility())
		ENDIF
	ELSE
		((GUI_UILib as FORM) as UILIB_GRIMY).ShowList("Inspect " + akForm.GetName(), getFormInfo(akForm), 0, 0)
	ENDIF
ENDFUNCTION

FLOAT FUNCTION Max(FLOAT akFloat1, FLOAT akFloat2)
	IF akFloat1 > akFloat2
		RETURN akFloat1
	ELSE	
		RETURN akFloat2
	ENDIF
ENDFUNCTION

STRING[] FUNCTION getWeaponInfo(WEAPON akWeapon)
	STRING[] retVal = new STRING[100]
	retVal[0] = akWeapon AS FORM
	IF akWeapon == PlayerRef.GetEquippedWeapon(true) ; leftweapon
		retVal[1] = "Tempering Bonus: " + StringUtil.Substring(Max(18.0*( GetItemHealthPercent(PlayerRef, 0, 0) - 1.0 ) - 0.3,1.0) AS STRING,0,4)
		retVal[2] = "Item Charge: " + GetItemCharge(PlayerRef, 0, 0) + "/" + GetItemMaxCharge(PlayerRef, 0, 0) AS STRING
	ELSEIF akWeapon == PlayerRef.GetEquippedWeapon(false) ; rightweapon
		retVal[1] = "Tempering Bonus: " + StringUtil.Substring(Max(18.0*( GetItemHealthPercent(PlayerRef, 1, 0) - 1.0 )- 0.3,1.0) AS STRING,0,4)
		retVal[2] = "Item Charge: " + GetItemCharge(PlayerRef, 1, 0) + "/" + GetItemMaxCharge(PlayerRef, 1, 0) AS STRING
	ELSE
		retVal[1] = "Tempering Bonus: Unequipped"
		retVal[2] = "Item Charge: Unequipped"
	ENDIF
	
	IF akWeapon.GetEnchantment()
		IF akWeapon.GetEnchantment().GetBaseEnchantment()
			IF akWeapon.GetEnchantment().GetBaseEnchantment().PlayerKnows()
				retVal[3] = "Known Enchantment ~More"
			ELSE
				retVal[3] = "Disenchantable ~More"
			ENDIF
		ELSE
			retVal[3] = "Not Disenchantable ~More"
		ENDIF
	ELSE
		retVal[3] = "No Non-Player Enchantment"
	ENDIF
	retVal[4] = "Base Damage: " + akWeapon.GetBaseDamage()
	retVal[5] = "Crit Damage: " + akWeapon.GetCritDamage()
	retVal[6] = "Speed: " + akWeapon.GetSpeed()
	retVal[7] = "Stagger: " + akWeapon.GetStagger()
	retVal[8] = "Reach: " + akWeapon.GetReach()
	retVal[9] = "Skill: " + akWeapon.GetSkill()
	retVal[10] = "Element: " + akWeapon.GetResist()
	IF akWeapon.GetCritEffectOnDeath()
		IF akWeapon.GetCritEffect()
			retVal[11] = "Crit Effect: " + akWeapon.GetCritEffect().GetName() + " on death ~More"
		ELSE
			retVal[11] = "Crit Effect: Nothing on Death"
		ENDIF
	ELSE
		IF akWeapon.GetCritEffect()
			retVal[11] = "Crit Effect: " + akWeapon.GetCritEffect().GetName() + " ~More"
		ELSE
			retVal[11] = "Crit Effect: Nothing"
		ENDIF
	ENDIF
	retVal[12] = "Crit Mult: " + akWeapon.GetCritMultiplier()
	retVal[13] = "Min Range: " + akWeapon.GetMinRange()
	retVal[14] = "Max Range: " + akWeapon.GetMaxRange()
	
	
	retVal[15] = "Gold Value: " + akWeapon.GetGoldValue()
	retVal[16] = "Weight: " + akWeapon.GetWeight()
	retVal[17] = "World Model: " + akWeapon.GetWorldModelPath()
	retVal[18] = "Weapon Model: " + akWeapon.GetModelPath()
	retVal[19] = "Equip Model: " + akWeapon.GetEquippedModel()
	int i = 0
	int num = akWeapon.GetNumKeywords()
	WHILE ( i < 80 ) && ( i < num )
		retVal[i+20] = "Keyword" + (i + 1) + ": " + akWeapon.GetNthKeyword(i).GetString()
		i += 1
	ENDWHILE
	RETURN retVal
ENDFUNCTION

; tempering health equation: floor(18 * Health - 0.3) for non-cuirass items.
STRING[] FUNCTION getArmorInfo(ARMOR akArmor)
	STRING[] retVal = new STRING[100]
	retVal[0] = akArmor AS FORM
	IF PlayerRef.IsEquipped(akArmor)
		;IF LogicalAnd(akArmor.GetSlotMask(),0x00000004) > 0
		;	retVal[1] = "Tempering Bonus: " + StringUtil.Substring(Max(36.0*( GetItemHealthPercent(PlayerRef, 0, akArmor.GetSlotMask() ) - 1.0 ) - 0.3 ,1.0) AS STRING,0,4)
		;ELSE
			retVal[1] = "Tempering Bonus: " + StringUtil.Substring(Max(18.0*( GetItemHealthPercent(PlayerRef, 0, akArmor.GetSlotMask() ) - 1.0 ) - 0.3 ,1.0) AS STRING,0,4)
		;ENDIF
	ELSE
		retVal[1] = "Tempering Bonus: Unequipped"
	ENDIF
	
	IF akArmor.GetEnchantment()
		IF akArmor.GetEnchantment().GetBaseEnchantment()
			IF akArmor.GetEnchantment().GetBaseEnchantment().PlayerKnows()
				retVal[2] = "Known Enchantment ~More"
			ELSE
				retVal[2] = "Unknown Enchantment"
			ENDIF
		ELSE
			retVal[2] = "Not Disenchantable ~More"
		ENDIF
	ELSE
		retVal[2] = "No Non-Player Enchantment"
	ENDIF
	retVal[3] = "Armor Rating: " + akArmor.GetArmorRating()
	IF akArmor.GetWeightClass() == 0
		retVal[4] = "Weight Class: Light"
	ELSEIF akArmor.GetWeightClass() == 1
		retVal[4] = "Weight Class: Heavy"
	ELSE
		retVal[4] = "Weight Class: None"
	ENDIF
	retVal[5] = "Gold Value: " + akArmor.GetGoldValue()
	retVal[6] = "Gold Value: " + akArmor.GetGoldValue()
	retVal[7] = "Weight: " + akArmor.GetWeight()
	retVal[8] = "World Model: " + akArmor.GetWorldModelPath()
	retVal[9] = "Male Model: " + akArmor.GetModelPath(false)
	retVal[10] = "Female Model: " + akArmor.GetModelPath(true)
	int i = 0
	int j = 0
	int k = 1
	int akMask = akArmor.GetSlotMask()
	WHILE ( j < 31 )
		IF LogicalAnd(akMask,k) != 0
			retVal[i+11] = "Slot Mask: " + slotMasks[j]
			i += 1
		ENDIF
		j += 1
		k *= 2
	ENDWHILE
	j = 0
	int num = akArmor.GetNumKeywords()
	WHILE ( i < 89 ) && ( i < num )
		retVal[i+11] = "Keyword" + j + ": " + akArmor.GetNthKeyword(j).GetString()
		i += 1
		j += 1
	ENDWHILE
	RETURN retVal
ENDFUNCTION

STRING[] FUNCTION getBookInfo(BOOK akForm)
	STRING[] retVal = new STRING[100]
	retVal[0] = akForm
	IF akForm.IsRead()
		retVal[1] = "You have read this book"
	ELSE
		retVal[1] = "This book is unread"
	ENDIF
	retVal[2] = "Gold Value: " + akForm.GetGoldValue()
	retVal[3] = "Weight: " + akForm.GetWeight()
	retVal[4] = akForm.GetWorldModelPath()
	IF akForm.GetSpell()
		retVal[5] = "Spell: " + akForm.GetSpell() + " ~More"
	ELSE
		retVal[5] = "Spell: None"
	ENDIF
	int i = 0
	int num = akForm.GetNumKeywords()
	WHILE ( i < 94 ) && ( i < num )
		retVal[i+6] = "Keyword" + (i + 1) + ": " + akForm.GetNthKeyword(i).GetString()
		i += 1
	ENDWHILE
	RETURN retVal
ENDFUNCTION

STRING[] FUNCTION getIngrInfo(INGREDIENT akForm)
	STRING[] retVal = new STRING[101]
	retVal[0] = akForm
	retVal[1] = "Gold Value: " + akForm.GetGoldValue()
	retVal[2] = "Weight: " + akForm.GetWeight()
	retVal[3] = akForm.GetWorldModelPath()
	If akForm.IsHostile()
		retVal[4] = "Hostile Ingredient"
	Else
		retVal[4] = "Non-Hostile Ingredient"
	EndIf
	int num = akForm.GetNumEffects()
	int i = 0
	int j = 5
	WHILE ( i < num ) && ( i < 24 )
		IF akForm.GetIsNthEffectKnown(i)
			retVal[j] = akForm.GetNthEffectMagicEffect(i).GetName()
			retVal[j+1] = GetIngrMag(akForm,i)
			retVal[j+2] = GetIngrDur(akForm,i)
			retVal[j+3] = GetIngrArea(akForm,i)
			j += 4
		ELSE
			retVal[3*i+4] = "Unknown Effect"
			j += 1
		ENDIF
		i += 1
	ENDWHILE
	RETURN retVal
ENDFUNCTION

STRING FUNCTION GetIngrMag(INGREDIENT akForm,INT akIngrIndex)
	IF akForm.GetNthEffectMagnitude(akIngrIndex)
		RETURN "Magnitude: " + akForm.GetNthEffectMagnitude(akIngrIndex)
	ELSE
		RETURN "Magnitude: N/A"
	ENDIF
ENDFUNCTION

STRING FUNCTION GetIngrDur(INGREDIENT akForm,INT akIngrIndex)
	IF akForm.GetNthEffectDuration(akIngrIndex)
		RETURN "Duration: " + akForm.GetNthEffectDuration(akIngrIndex)
	ELSE
		RETURN "Duration: N/A"
	ENDIF
ENDFUNCTION

STRING FUNCTION GetIngrArea(INGREDIENT akForm,INT akIngrIndex)
	IF akForm.GetNthEffectArea(akIngrIndex)
		RETURN "Area: " + akForm.GetNthEffectArea(akIngrIndex)
	ELSE
		RETURN "Area: N/A"
	ENDIF
ENDFUNCTION

STRING[] FUNCTION getPotionInfo(POTION akForm)
	STRING[] retVal = new STRING[100]
	retVal[0] = akForm
	retVal[1] = "Gold Value: " + akForm.GetGoldValue()
	retVal[2] = "Weight: " + akForm.GetWeight()
	retVal[3] = akForm.GetWorldModelPath()
	IF akForm.IsHostile()
		retVal[4] = "Hostile Potion"
	ELSE 
		retVal[4] = "Non-Hostile Potion"
	ENDIF

	IF akForm.IsFood()
		retVal[5] = "Is Food"
	ELSE 
		retVal[5] = "Is Not Food"
	ENDIF
	
	IF akForm.IsPoison()
		retVal[6] = "Is Poison"
	ELSE 
		retVal[6] = "Is Not Poison"
	ENDIF
	
	retVal[7] = "Sound: " + akForm.GetUseSound()
	
	int i = 0
	int k = 0
	int num = akForm.GetNumEffects()
	WHILE ( i < 92 ) && ( k < num )
		retVal[i+8] = "Magic Effect " + (k + 1) + ": " + akForm.GetNthEffectMagicEffect(k).GetName() + " ~More"
		retVal[i+9] = GetPotionMag(akForm,k)
		retVal[i+10] = GetPotionDur(akForm,k)
		retVal[i+11] = GetPotionArea(akForm,k)	
		i += 4
		k += 1
	ENDWHILE
	int j = 0
	num = akForm.GetNumKeywords()
	WHILE ( i < 92 ) && ( j < num )
		retVal[i+8] = "Keyword" + (j + 1) + ": " + akForm.GetNthKeyword(j).GetString()
		i += 1
		j += 1
	ENDWHILE
	RETURN retVal
ENDFUNCTION

STRING FUNCTION GetPotionMag(POTION akForm,INT akPotionIndex)
	IF akForm.GetNthEffectMagnitude(akPotionIndex)
		RETURN "Magnitude: " + akForm.GetNthEffectMagnitude(akPotionIndex)
	ELSE
		RETURN "Magnitude: N/A"
	ENDIF
ENDFUNCTION

STRING FUNCTION GetPotionDur(POTION akForm,INT akPotionIndex)
	IF akForm.GetNthEffectDuration(akPotionIndex)
		RETURN "Duration: " + akForm.GetNthEffectDuration(akPotionIndex)
	ELSE
		RETURN "Duration: N/A"
	ENDIF
ENDFUNCTION

STRING FUNCTION GetPotionArea(POTION akForm,INT akPotionIndex)
	IF akForm.GetNthEffectArea(akPotionIndex)
		RETURN "Area: " + akForm.GetNthEffectArea(akPotionIndex)
	ELSE
		RETURN "Area: N/A"
	ENDIF
ENDFUNCTION

STRING[] FUNCTION getScrollInfo(Scroll akForm)
	STRING[] retVal = new STRING[100]
	retVal[0] = akForm
	retVal[1] = "Gold Value: " + akForm.GetGoldValue()
	retVal[2] = "Weight: " + akForm.GetWeight()
	retVal[3] = akForm.GetWorldModelPath()
	retVal[4] = "Cast Time: " + akForm.GetCastTime()
	
	int i = 0
	int k = 0
	int num = akForm.GetNumEffects()
	WHILE ( i < 95 ) && ( k < num )
		retVal[i+5] = "Magic Effect " + (k + 1) + ": " + akForm.GetNthEffectMagicEffect(k).GetName() + " ~More"
		retVal[i+6] = GetScrollMag(akForm,k)
		retVal[i+7] = GetScrollDur(akForm,k)
		retVal[i+8] = GetScrollArea(akForm,k)	
		i += 4
		k += 1
	ENDWHILE
	int j = 0
	num = akForm.GetNumKeywords()
	WHILE ( i < 95 ) && ( j < num )
		retVal[i+5] = "Keyword" + (j + 1) + ": " + akForm.GetNthKeyword(j).GetString()
		i += 1
		j += 1
	ENDWHILE
	RETURN retVal
ENDFUNCTION

STRING FUNCTION GetScrollMag(SCROLL akForm,INT akScrollIndex)
	IF akForm.GetNthEffectMagnitude(akScrollIndex)
		RETURN "Magnitude: " + akForm.GetNthEffectMagnitude(akScrollIndex)
	ELSE
		RETURN "Magnitude: N/A"
	ENDIF
ENDFUNCTION

STRING FUNCTION GetScrollDur(SCROLL akForm,INT akScrollIndex)
	IF akForm.GetNthEffectDuration(akScrollIndex)
		RETURN "Duration: " + akForm.GetNthEffectDuration(akScrollIndex)
	ELSE
		RETURN "Duration: N/A"
	ENDIF
ENDFUNCTION

STRING FUNCTION GetScrollArea(SCROLL akForm,INT akScrollIndex)
	IF akForm.GetNthEffectArea(akScrollIndex)
		RETURN "Area: " + akForm.GetNthEffectArea(akScrollIndex)
	ELSE
		RETURN "Area: N/A"
	ENDIF
ENDFUNCTION

STRING[] FUNCTION getShoutInfo(SHOUT akForm)
	STRING[] retVal = new STRING[10]
	retVal[0] = akForm
	retVal[1] = "1st Spell: " + akForm.GetNthSpell(0).GetName() + " ~More"
	retVal[2] = "2nd Spell: " + akForm.GetNthSpell(1).GetName() + " ~More"
	retVal[3] = "3rd Spell: " + akForm.GetNthSpell(2).GetName() + " ~More"
	retVal[4] = "1st Cooldown: " + akForm.GetNthRecoveryTime(0)
	retVal[5] = "2nd Cooldown: " + akForm.GetNthRecoveryTime(1)
	retVal[6] = "3rd Cooldown: " + akForm.GetNthRecoveryTime(2)
	retVal[7] = "1st Word: " + akForm.GetNthWordOfPower(0)
	retVal[8] = "2nd Word: " + akForm.GetNthWordOfPower(1)
	retVal[9] = "3rd Word: " + akForm.GetNthWordOfPower(2)
	RETURN retVal
ENDFUNCTION

STRING[] FUNCTION getMGEFInfo(MagicEffect akForm)
	STRING[] retVal = new STRING[100]
	retVal[0] = akForm
	retVal[1] = "Skill: " + akForm.GetAssociatedSkill()
	retVal[2] = "Resistance: " + akForm.GetResistance()
	retVal[3] = "Cast Time: " + akForm.GetCastTime()
	retVal[4] = "Skill Level: " + akForm.GetSkillLevel()
	retVal[5] = "Area: " + akForm.GetArea()
	retVal[6] = "Skill Use Mult: " + akForm.GetSkillUsageMult()
	retVal[7] = "Base Cost: " + akForm.GetBaseCost()
	retVal[8] = "Archetype: " + MagExtend.GetMGEFArchetype(akForm)
	retVal[9] = "1st AV: " + MagExtend.GetMGEFPrimaryAV(akForm)
	retVal[10] = "2nd AV: " + MagExtend.GetMGEFSecondaryAV(akForm)
	retVal[11] = "2nd AV Weight: " + MagExtend.GetMGEFSecondaryAVWeight(akForm)
	retVal[12] = "Taper Duration: " + MagExtend.GetMGEFTaperDuration(akForm)
	retVal[13] = "Taper Weight: " + MagExtend.GetMGEFTaperWeight(akForm)
	retVal[14] = "Taper Curve: " + MagExtend.GetMGEFTaperCurve(akForm)
	IF akForm.GetLight()
		retVal[15] = "Related Form: " + MagExtend.GetMGEFRelatedForm(akForm)
	ELSE
		retVal[15] = "Related Form: None"
	ENDIF
	IF akForm.GetLight()
		retVal[16] = "Light: " + akForm.GetLight()
	ELSE
		retVal[16] = "Light: None"
	ENDIF
	IF akForm.GetHitShader()
		retVal[17] = "Hit Shader: " + akForm.GetHitShader()
	ELSE
		retVal[17] = "Hit Shader: None"
	ENDIF
	IF akForm.GetEnchantShader()
		retVal[18] = "Enchant Shader: " + akForm.GetEnchantShader()
	ELSE
		retVal[18] = "Enchant Shader: None"
	ENDIF
	IF akForm.GetProjectile()
		retVal[19] = "Projectile: " + akForm.GetProjectile()
	ELSE
		retVal[19] = "Projectile: None"
	ENDIF
	IF akForm.GetExplosion()
		retVal[20] = "Explosion: " + akForm.GetExplosion()
	ELSE
		retVal[20] = "Explosion: None"
	ENDIF
	IF akForm.GetCastingArt()
		retVal[21] = "Casting Art: " + akForm.GetCastingArt()
	ELSE
		retVal[21] = "Casting Art: None"
	ENDIF
	IF akForm.GetHitEffectArt()
		retVal[22] = "Hit Effect Art: " + akForm.GetHitEffectArt()
	ELSE
		retVal[22] = "Hit Effect Art: None"
	ENDIF
	IF akForm.GetEnchantArt()
		retVal[23] = "Enchant Art: " + akForm.GetEnchantArt()
	ELSE
		retVal[23] = "Enchant Art: None"
	ENDIF
	IF akForm.GetImpactDataSet()
		retVal[24] = "Impact Data Set: " + akForm.GetImpactDataSet()
	ELSE
		retVal[24] = "Impact Data Set: None"
	ENDIF
	IF akForm.GetEquipAbility()
		retVal[25] = "Equip Ability: " + akForm.GetEquipAbility() + " ~More"
	ELSE
		retVal[25] = "Equip Ability: None"
	ENDIF
	IF akForm.GetImageSpaceMod()
		retVal[26] = "Imagespace Mod: " + akForm.GetImageSpaceMod()
	ELSE
		retVal[26] = "Imagespace Mod: None"
	ENDIF
	IF akForm.GetPerk()
		retVal[27] = "Perk: " + akForm.GetPerk()
	ELSE
		retVal[27] = "Perk: None"
	ENDIF
	
	int i = 0
	int j = 0
	IF akForm.IsEffectFlagSet(0x00000001)
		retVal[28+i] = "Hostile Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x00000002)
		retVal[28+i] = "Recover Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x00000004)
		retVal[28+i] = "Detrimental Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x00000010)
		retVal[28+i] = "No Hit Event Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x00000100)
		retVal[28+i] = "Dispel Keywords Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x00000200)
		retVal[28+i] = "No Duration Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x00000400)
		retVal[28+i] = "No Magnitude Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x00000800)
		retVal[28+i] = "No Area Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x00001000)
		retVal[28+i] = "Gory Visuals Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x00004000)
		retVal[28+i] = "Hide In UI Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x00008000)
		retVal[28+i] = "No Recast Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x00020000)
		retVal[28+i] = "Magnitude Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x00040000)
		retVal[28+i] = "Duration Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x04000000)
		retVal[28+i] = "Painless Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x08000000)
		retVal[28+i] = "No Hit Effect Flag"
		i += 1
	ENDIF
	IF akForm.IsEffectFlagSet(0x10000000)
		retVal[28+i] = "No Death Dispel Flag"
		i += 1
	ENDIF
	int num = akForm.GetNumKeywords()
	WHILE ( i < 72 ) && ( j < num )
		retVal[i+28] = "Keyword" + (j + 1) + ": " + akForm.GetNthKeyword(j).GetString()
		i += 1
		j += 1
	ENDWHILE
	RETURN retVal
ENDFUNCTION

STRING[] FUNCTION getSpellInfo(SPELL akForm)
	STRING[] retVal = new STRING[100]
	retVal[0] = akForm
	If akForm.IsHostile()
		retVal[1] = "Hostile Spell"
	Else
		retVal[1] = "Non-Hostile Spell"
	EndIf
	retVal[2] = "Cast Time: " + akForm.GetCastTime()
	retVal[3] = "Base Cost: " + akForm.GetMagickaCost()
	retVal[4] = "Effective Cost: " + akForm.GetEffectiveMagickaCost(PlayerRef)
	If akForm.GetPerk()
		retVal[5] = "Perk: " + akForm.GetPerk().GetName()
	Else
		retVal[5] = "Perk: None"
	EndIf

	int i = 0
	int k = 0
	int num = akForm.GetNumEffects()
	WHILE ( i < 94 ) && ( k < num )
		retVal[i+6] = "Magic Effect " + (k + 1) + ": " + akForm.GetNthEffectMagicEffect(k).GetName() + " ~More"
		retVal[i+7] = GetSpellMag(akForm,k)
		retVal[i+8] = GetSpellDur(akForm,k)
		retVal[i+9] = GetSpellArea(akForm,k)	
		i += 4
		k += 1
	ENDWHILE
	int j = 0
	num = akForm.GetNumKeywords()
	WHILE ( i < 94 ) && ( j < num )
		retVal[i+6] = "Keyword" + (j + 1) + ": " + akForm.GetNthKeyword(j).GetString()
		i += 1
		j += 1
	ENDWHILE
	RETURN retVal
ENDFUNCTION

STRING FUNCTION GetSpellMag(SPELL akForm,INT akSpellIndex)
	IF akForm.GetNthEffectMagnitude(akSpellIndex)
		RETURN "Magnitude: " + akForm.GetNthEffectMagnitude(akSpellIndex)
	ELSE
		RETURN "Magnitude: N/A"
	ENDIF
ENDFUNCTION

STRING FUNCTION GetSpellDur(SPELL akForm,INT akSpellIndex)
	IF akForm.GetNthEffectDuration(akSpellIndex)
		RETURN "Duration: " + akForm.GetNthEffectDuration(akSpellIndex)
	ELSE
		RETURN "Duration: N/A"
	ENDIF
ENDFUNCTION

STRING FUNCTION GetSpellArea(SPELL akForm,INT akSpellIndex)
	IF akForm.GetNthEffectArea(akSpellIndex)
		RETURN "Area: " + akForm.GetNthEffectArea(akSpellIndex)
	ELSE
		RETURN "Area: N/A"
	ENDIF
ENDFUNCTION

STRING[] FUNCTION getEnchInfo(ENCHANTMENT akForm)
	STRING[] retVal = new STRING[100]
	retVal[0] = akForm
	If akForm.IsHostile()
		retVal[1] = "Hostile Enchantment"
	Else
		retVal[1] = "Non-Hostile Enchantment"
	EndIf
	If akForm.GetBaseEnchantment()
		retVal[2] = "Base Enchantment: " + akForm.GetBaseEnchantment().GetName() + " ~More"
	Else
		retVal[2] = "Base Enchantment: None"
	EndIf
	If akForm.GetKeywordRestrictions()
		retVal[3] = "Keyword Restrictions: " + akForm.GetKeywordRestrictions()
	Else
		retVal[3] = "Keyword Restrictions: None"
	EndIf
	
	int i = 0
	int k = 0
	int num = akForm.GetNumEffects()
	WHILE ( i < 96 ) && ( k < num )
		retVal[i+4] = "Magic Effect " + (k + 1) + ": " + akForm.GetNthEffectMagicEffect(k).GetName()
		retVal[i+5] = GetEnchMag(akForm,k)
		retVal[i+6] = GetEnchDur(akForm,k)
		retVal[i+7] = GetEnchArea(akForm,k)	
		i += 4
		k += 1
	ENDWHILE
	int j = 0
	num = akForm.GetNumKeywords()
	WHILE ( i < 96 ) && ( j < num )
		retVal[i+4] = "Keyword" + (j + 1) + ": " + akForm.GetNthKeyword(j).GetString()
		i += 1
		j += 1
	ENDWHILE
	RETURN retVal
ENDFUNCTION 

STRING FUNCTION GetEnchMag(ENCHANTMENT akForm,INT akEnchIndex)
	IF akForm.GetNthEffectMagnitude(akEnchIndex)
		RETURN "Magnitude: " + akForm.GetNthEffectMagnitude(akEnchIndex)
	ELSE
		RETURN "Magnitude: N/A"
	ENDIF
ENDFUNCTION

STRING FUNCTION GetEnchDur(ENCHANTMENT akForm,INT akEnchIndex)
	IF akForm.GetNthEffectDuration(akEnchIndex)
		RETURN "Duration: " + akForm.GetNthEffectDuration(akEnchIndex)
	ELSE
		RETURN "Duration: N/A"
	ENDIF
ENDFUNCTION

STRING FUNCTION GetEnchArea(ENCHANTMENT akForm,INT akEnchIndex)
	IF akForm.GetNthEffectArea(akEnchIndex)
		RETURN "Area: " + akForm.GetNthEffectArea(akEnchIndex)
	ELSE
		RETURN "Area: N/A"
	ENDIF
ENDFUNCTION

STRING[] FUNCTION getFormInfo(FORM akForm)
	STRING[] retVal = new STRING[100]
	retVal[0] = akForm
	retVal[1] = "Gold Value: " + akForm.GetGoldValue()
	retVal[2] = "Weight: " + akForm.GetWeight()
	retVal[3] = akForm.GetWorldModelPath()
	int i = 0
	int num = akForm.GetNumKeywords()
	WHILE ( i < 96 ) && ( i < num )
		retVal[i+4] = "Keyword" + (i + 1) + ": " + akForm.GetNthKeyword(i).GetString()
		i += 1
	ENDWHILE
	RETURN retVal
ENDFUNCTION 