Scriptname KRY_QD_MCMScript extends SKI_ConfigBase

import FISSFactory

int OIDDA02				;Boethiah's Calling, constant
int OIDDA04				;Discerning the Transmundane, not constant
int OIDDA06				;the Cursed Tribe, not constant
int OIDDA08				;the Whispering Door, not constant 
int OIDDA09				;The Break of Dawn, constant
int OIDDA13				;The Only Cure, not constant
int OIDDA14				;A Night to Remember (new global)
int OIDDA07				;Pieces of the Past (new global)
int OIDDGQuestStart
int OIDDGVampAttacks
int OIDDGVampLord
int OIDDGScout
int OIDDGMaxWait
int OIDDGMinWait
int OIDDBMinLevel
int OIDDBRandomChance
int OIDHFMinLevel
int OIDMS06				;The Wolf Queen Awakened
int OIDMS04				;Unfathomable Depths
int OIDFFR09			;Grimsever's Return
int OIDFavor153			;Kill the Giant (Jarl Dawnstar)
int OIDFavor157			;Dungeon Delving (Jarl Markarth)
int OIDFavor109			;Kill the Vampire (Jarl Solitude)
int OIDDragonWait
int OIDDragonChance
int OIDDBEbonyWarrior
int OIDDBDeathbrand
int OIDDGWerewolves		;random werewolf encounters
int OIDWEBountyAmount 	;v2  
int OIDWEBountyChance 	;v2
int OIDMeridiaVamp		;v2
int OIDWEThalmorMinLvl	;v2
int OIDWEThalmorQuests	;v2
int OIDWEHiredThugsAmt	;v2
int OIDWEAssassinLvl	;v2
int OIDWEAssassinAssault;v2
int OIDWEAssassinMurder	;v2
int OID_SavePreset		; save preset
int OID_LoadPreset		; load preset

float DA02Val = 30.0
float DA04Val = 15.0
float DA06Val = 9.0
float DA08Val = 20.0
float DA09Val = 12.0
float DA13Val = 12.0
float DA14Val = 14.0
float DA07Val = 20.0
float DGQuestVal = 10.0
float VampAttackVal = 8.0
float VampLordVal = 25.0
float DGScoutVal = 25.0
float DGMaxWaitVal = 20.0
float DGMinWaitVal = 1.0
float DBMinLevelVal = 25.0
float DBAttackChanceVal = 100.0
float HFMinLevelVal = 9.0
float MS06Val = 10.0
float MS04Val = 14.0
float FFR09Val = 14.0
float Favor153Val = 22.0
float Favor157Val = 20.0
float Favor109Val = 10.0
float DragonWaitVal = 3.0
float DragonChanceVal = 100.0
float EbonyWarriorVal = 80.0
float DeathbrandVal = 36.0
float WEBountyAmtVal = 1000.0
float WEBountyChanceVal = 25.0
float WEThalmorVal = 8.0	
float WEHiredThugsAmtVal = 0.0
float WEAssassinLvlVal = 5.0
float WEAssassinAVal = 0.0
float WEAssassinMVal = 0.0

GlobalVariable property DA02MinLevel auto
GlobalVariable property DA04MinLevel auto
GlobalVariable property DA06MinLevel auto
GlobalVariable property DA08MinLevel auto
GlobalVariable property DA09MinLevel auto
GlobalVariable property DA13MinLevel auto
GlobalVariable property DA14MinLevel_KRY auto
GlobalVariable property DA07MinLevel_KRY auto
GlobalVariable property DLC1VQMinLevel auto
GlobalVariable property DLC1VQMinLevelVampireAttacks auto
GlobalVariable property DLC1RadiantDisguisedVampireLordChance auto
GlobalVariable property DLC1ScoutPatrolChance auto
GlobalVariable property DLC1EclipseAttackNextMaxWait auto 
GlobalVariable property DLC1EclipseAttackNextWait auto
GlobalVariable property DLC2QuestStartSelection_KRY auto
GlobalVariable property DLC2CultistAttackMinLevel_KRY auto
GlobalVariable property DLC2WE09Chance auto
GlobalVariable property MS06MinLevel auto
GlobalVariable property MS04MinLevel auto
GlobalVariable property FFRiften09Gate auto
GlobalVariable property Favor153MinLevel_KRY auto
GlobalVariable property Favor157MinLevel_KRY auto
GlobalVariable property Favor109MinLevel_KRY auto
GlobalVariable property WIWaitDragon auto
GlobalVariable property RandomDragonChance_KRY auto
GlobalVariable property WerewolfEncounters_KRY auto
GlobalVariable property DLC2EbonyWarriorMinLevel_KRY auto
GlobalVariable property DLC2dunHaknirTreasureQSTMinLevel auto
GlobalVariable property WEbountyCollectorCrimeGoldRequirement auto
GlobalVariable property WEBountyCollectorChance auto
GlobalVariable property MeridiaNoVampire_KRY auto
GlobalVariable property QuestLockThalmorSquad_KRY auto
GlobalVariable property MinLevelThalmorSquad_KRY auto
GlobalVariable property HiredThugsStolenItemMinValue_KRY auto
GlobalVariable property DBAssassinMinLevel_KRY auto
GlobalVariable property DBAssassinMinAssaults_KRY auto
GlobalVariable property DBAssassinMinMurders_KRY auto

string[] DLC2CultistAttackList
int OIDDBCultAttackMenu
int DBQuestSelection = 1
int msgshown = 1

BYOHHouseBuildingScript Property BYOHHouseBuilding auto


event OnConfigInit()
	parent.OnInit()

	DLC2CultistAttackList = new string[10]
	DLC2CultistAttackList[0] = "After the Graybeards summon the Dragonborn"
	DLC2CultistAttackList[1] = "After Way of the Voice (default)"
	DLC2CultistAttackList[2] = "After The Horn of Jurgen Windcaller"
	DLC2CultistAttackList[3] = "After A Blade in the Dark"
	DLC2CultistAttackList[4] = "After Alduin's Wall"
	DLC2CultistAttackList[5] = "After The Throat of the World"
	DLC2CultistAttackList[6] = "After Elder Knowledge"
	DLC2CultistAttackList[7] = "After Alduin's Bane"
	DLC2CultistAttackList[8] = "After Dragonslayer"
	DLC2CultistAttackList[9] = "Timing Unknown"
endEvent


event OnPageReset(string page)
	SetTitleText("Quest Conditions")
	SetCursorFillMode(TOP_TO_BOTTOM)
	int hasFiss = game.getModByName("FISS.esp")
	If (0 < hasFiss && hasFiss < 255)
		SetCursorPosition(0)
		AddHeaderOption("Presets")
		OID_LoadPreset = AddTextOption("Load Preset","")
		OID_SavePreset = AddTextOption("Save Current Settings","")
		AddEmptyOption()	
	EndIf
	AddHeaderOption("Dawnguard")
		OIDDGVampAttacks = AddSliderOption("Vampire Attacks", VampAttackVal, "{0}")
		OIDDGQuestStart = AddSliderOption("Dawnguard Recruitment", DGQuestVal, "{0}")
		OIDDGVampLord = AddSliderOption("Disguised Vampire Chance", VampLordVal, "{0}")
		OIDDGScout = AddSliderOption("Scouting Party Chance", DGScoutVal, "{0}")
		OIDDGMinWait = AddSliderOption("Min Days Between Attacks", DGMinWaitVal, "{0}")
		OIDDGMaxWait = AddSliderOption("Max Days Between Attacks", DGMaxWaitVal, "{0}")	
	AddHeaderOption("Hearthfire")
		OIDHFMinLevel = AddSliderOption("Minimum Level", HFMinLevelVal, "{0}")
	AddHeaderOption("Dragonborn")
		OIDDBCultAttackMenu = AddMenuOption("", DLC2CultistAttackList[DBQuestSelection])
		OIDDBMinLevel = AddSliderOption("Minimum Level", DBMinLevelVal, "{0}")
		OIDDBRandomChance = AddSliderOption("Cultist Attack Chance", DBAttackChanceVal, "{0}")
	AddHeaderOption("Dragon Attacks")
		OIDDragonWait = AddSliderOption("Min Days Between Attacks", DragonWaitVal, "{0}")
		OIDDragonChance = AddSliderOption("Dragon Attack Chance", DragonChanceVal, "{0}")

	SetCursorPosition(1)		;start right-hand column
	AddHeaderOption("Daedric Quests")
		OIDDA06 = AddSliderOption("The Cursed Tribe", DA06Val, "{0}")
		OIDDA09 = AddSliderOption("The Break of Dawn", DA09Val, "{0}")
		OIDMeridiaVamp = AddToggleOption("The Break of Dawn: No Vampires", MeridiaNoVampire_KRY.getValueInt())
		OIDDA13 = AddSliderOption("The Only Cure", DA13Val, "{0}")
		OIDDA14 = AddSliderOption("A Night to Remember", DA14Val, "{0}")
		OIDDA04 = AddSliderOption("Discerning the Transmundane", DA04Val, "{0}")
		OIDDA08 = AddSliderOption("The Whispering Door", DA08Val, "{0}")
		OIDDA07 = AddSliderOption("Pieces of the Past", DA07Val, "{0}")
		OIDDA02 = AddSliderOption("Boethiah's Calling", DA02Val, "{0}")	
	AddHeaderOption("Misc Quests")
		OIDMS06 = AddSliderOption("The Wolf Queen Awakened", MS06Val, "{0}")
		OIDMS04 = AddSliderOption("Unfathomable Depths", MS04Val, "{0}")
		OIDFFR09 = AddSliderOption("Grimsever's Return", FFR09Val, "{0}")
		OIDFavor153 = AddSliderOption("Kill the Giant", Favor153Val, "{0}")
		OIDFavor157 = AddSliderOption("Dungeon Delving", Favor157Val, "{0}")
		OIDFavor109 = AddSliderOption("Kill the Vampire", Favor109Val, "{0}")
		OIDDBDeathbrand = AddSliderOption("Deathbrand", DeathbrandVal, "{0}")
		OIDDBEbonyWarrior = AddSliderOption("Ebony Warrior", EbonyWarriorVal, "{0}")
	AddHeaderOption("World Encounters")
		OIDDGWerewolves = AddToggleOption("Werewolf Encounters", WerewolfEncounters_KRY.getValueInt())
		OIDWEThalmorMinLvl = AddSliderOption("Thalmor Squad: Min Level", WEThalmorVal, "{0}")		
		OIDWEThalmorQuests = AddToggleOption("Thalmor Squad: Quest Requirement", QuestLockThalmorSquad_KRY.getValueInt())
		OIDWEHiredThugsAmt = AddSliderOption("Hired Thugs: Stolen Item Value", WEHiredThugsAmtVal, "{0}")
		OIDWEAssassinLvl = AddSliderOption("Hired Assassin: Min Level", WEAssassinLvlVal, "{0}")
		OIDWEAssassinAssault = AddSliderOption("Hired Assassin: Assaults", WEAssassinAVal, "{0}")
		OIDWEAssassinMurder = AddSliderOption("Hired Assassin: Murders", WEAssassinMVal, "{0}")
		OIDWEBountyAmount = AddSliderOption("Bounty Collector: Required Bounty", WEBountyAmtVal, "{0}")
		OIDWEBountyChance = AddSliderOption("Bounty Collector: Chance", WEBountyChanceVal, "{0}")
	endEvent

event OnOptionMenuOpen(int option)
	if (option == OIDDBCultAttackMenu)
		SetMenuDialogOptions(DLC2CultistAttackList)
		SetMenuDialogStartIndex(DBQuestSelection)
		SetMenuDialogDefaultIndex(1)
	endIf
endEvent


event OnOptionMenuAccept(int option, int index)
	if (option == OIDDBCultAttackMenu)
		DBQuestSelection = index
		SetMenuOptionValue(OIDDBCultAttackMenu, DLC2CultistAttackList[DBQuestSelection])
		if DBQuestSelection <= 8
			DLC2QuestStartSelection_KRY.Setvalue(DBQuestSelection)
		else
			int randomquest = Utility.RandomInt(2, 8)
			DLC2QuestStartSelection_KRY.SetvalueInt(randomquest)
		endif
	endIf
endEvent

Event OnOptionSelect(int option)
	If (option == OIDDGWerewolves)
		if WerewolfEncounters_KRY.GetValueInt() == 0
			WerewolfEncounters_KRY.setValue(1)
		else
			WerewolfEncounters_KRY.setValue(0)
		endif		
	ElseIf (option == OIDMeridiaVamp)
		if MeridiaNoVampire_KRY.GetValueInt() == 0
			MeridiaNoVampire_KRY.setValue(1)
		else
			MeridiaNoVampire_KRY.setValue(0)
		endif	
	ElseIf (option == OIDWEThalmorQuests)
		if QuestLockThalmorSquad_KRY.GetValueInt() == 0
			QuestLockThalmorSquad_KRY.setValue(1)
		else
			QuestLockThalmorSquad_KRY.setValue(0)
		endif			
	ElseIf (option == OID_LoadPreset)
		BeginLoadPreset()
	ElseIf (option == OID_SavePreset)	
		BeginSavePreset()
	endif
	ForcePageReset()
endEvent

event OnOptionSliderOpen(int option)
	if (option == OIDDA02)
		SetSliderDialogStartValue(DA02Val)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDA04)
		SetSliderDialogStartValue(DA04Val)
		SetSliderDialogDefaultValue(15)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDA06)
		SetSliderDialogStartValue(DA06Val)
		SetSliderDialogDefaultValue(9)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDA08)
		SetSliderDialogStartValue(DA08Val)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDA09)
		SetSliderDialogStartValue(DA09Val)
		SetSliderDialogDefaultValue(12)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDA13)
		SetSliderDialogStartValue(DA13Val)
		SetSliderDialogDefaultValue(12)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDA14)
		SetSliderDialogStartValue(DA14Val)
		SetSliderDialogDefaultValue(14)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDA07)
		SetSliderDialogStartValue(DA07Val)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDGVampAttacks)
		SetSliderDialogStartValue(VampAttackVal)
		SetSliderDialogDefaultValue(8)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDGQuestStart)
		SetSliderDialogStartValue(DGQuestVal)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDGVampLord)
		SetSliderDialogStartValue(VampLordVal)
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDGScout)
		SetSliderDialogStartValue(DGScoutVal)
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDGMinWait)
		SetSliderDialogStartValue(DGMinWaitVal)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDGMaxWait)
		SetSliderDialogStartValue(DGMaxWaitVal)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(1.0, 200.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDBMinLevel)
		SetSliderDialogStartValue(DBMinLevelVal)
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDHFMinLevel)
		SetSliderDialogStartValue(HFMinLevelVal)
		SetSliderDialogDefaultValue(9)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDMS06)
		SetSliderDialogStartValue(MS06Val)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDMS04)
		SetSliderDialogStartValue(MS04Val)
		SetSliderDialogDefaultValue(14)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDFFR09)
		SetSliderDialogStartValue(FFR09Val)
		SetSliderDialogDefaultValue(14)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDFavor153)
		SetSliderDialogStartValue(Favor153Val)
		SetSliderDialogDefaultValue(22)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDFavor157)
		SetSliderDialogStartValue(Favor157Val)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDFavor109)
		SetSliderDialogStartValue(Favor109Val)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDragonWait)
		SetSliderDialogStartValue(DragonWaitVal)
		SetSliderDialogDefaultValue(3)
		SetSliderDialogRange(1.0, 200.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDragonChance)
		SetSliderDialogStartValue(DragonChanceVal)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDBRandomChance)
		SetSliderDialogStartValue(DBAttackChanceVal)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDBDeathbrand)
		SetSliderDialogStartValue(DeathbrandVal)
		SetSliderDialogDefaultValue(36)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDDBEbonyWarrior)
		SetSliderDialogStartValue(EbonyWarriorVal)
		SetSliderDialogDefaultValue(80)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDWEBountyAmount)
		SetSliderDialogStartValue(WEBountyAmtVal)
		SetSliderDialogDefaultValue(1000)
		SetSliderDialogRange(500.0, 50000.0)
		SetSliderDialogInterval(500.0)		
	elseIf (option == OIDWEBountyChance)
		SetSliderDialogStartValue(WEBountyChanceVal)
		SetSliderDialogDefaultValue(25)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)	
	elseIf (option == OIDWEThalmorMinLvl)
		SetSliderDialogStartValue(WEThalmorVal)
		SetSliderDialogDefaultValue(8)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDWEHiredThugsAmt)
		SetSliderDialogStartValue(WEHiredThugsAmtVal)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(25.0)	
	elseIf (option == OIDWEAssassinLvl)
		SetSliderDialogStartValue(WEAssassinLvlVal)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0.0, 101.0)
		SetSliderDialogInterval(1.0)
	elseIf (option == OIDWEAssassinAssault)
		SetSliderDialogStartValue(WEAssassinAVal)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)	
	elseIf (option == OIDWEAssassinMurder)
		SetSliderDialogStartValue(WEAssassinMVal)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)	
	endif
endEvent

event OnOptionSliderAccept(int option, float value)
	if (option == OIDDA02)
		DA02Val = value
		SetSliderOptionValue(OIDDA02, DA02Val, "{0}")
		if DA02Val > 100
			DA02MinLevel.Setvalue(999)
			DisableQuestMessage()
		else
			DA02MinLevel.Setvalue(DA02Val)
		endif
	elseIf (option == OIDDA04)
		DA04Val = value
		SetSliderOptionValue(OIDDA04, DA04Val, "{0}")
		if DA04Val > 100
			DA04MinLevel.Setvalue(999)
			DisableQuestMessage()
		else
			DA04MinLevel.Setvalue(DA04Val)
		endif
	elseIf (option == OIDDA06)
		DA06Val = value
		SetSliderOptionValue(OIDDA06, DA06Val, "{0}")
		if DA06Val > 100
			DA06MinLevel.Setvalue(999)
			DisableQuestMessage()
		else
			DA06MinLevel.Setvalue(DA06Val)
		endif
	elseIf (option == OIDDA08)
		DA08Val = value
		SetSliderOptionValue(OIDDA08, DA08Val, "{0}")
		if DA08Val > 100
			DA08MinLevel.Setvalue(999)
			DisableQuestMessage()
		else
			DA08MinLevel.Setvalue(DA08Val)
		endif
	elseIf (option == OIDDA09)
		DA09Val = value
		SetSliderOptionValue(OIDDA09, DA09Val, "{0}")
		if DA09Val > 100
			DA09MinLevel.Setvalue(999)
			DisableQuestMessage()
		else
			DA09MinLevel.Setvalue(DA09Val)
		endif
	elseIf (option == OIDDA13)
		DA13Val = value
		SetSliderOptionValue(OIDDA13, DA13Val, "{0}")
		if DA13Val > 100
			DA13MinLevel.Setvalue(999)
			DisableQuestMessage()
		else
			DA13MinLevel.Setvalue(DA13Val)
		endif
	elseIf (option == OIDDA14)
		DA14Val = value
		SetSliderOptionValue(OIDDA14, DA14Val, "{0}")
		if DA14Val > 100
			DA14MinLevel_KRY.Setvalue(999)
			DisableQuestMessage()
		else
			DA14MinLevel_KRY.Setvalue(DA14Val)
		endif
	elseIf (option == OIDDA07)
		DA07Val = value
		SetSliderOptionValue(OIDDA07, DA07Val, "{0}")
		if DA07Val > 100
			DA07MinLevel_KRY.Setvalue(999)
			DisableQuestMessage()
		else
			DA07MinLevel_KRY.Setvalue(DA07Val)
		endif
	elseIf (option == OIDDGVampAttacks)
		VampAttackVal = value
		SetSliderOptionValue(OIDDGVampAttacks, VampAttackVal, "{0}")
		if VampAttackVal > 100
			DLC1VQMinLevelVampireAttacks.Setvalue(999)
			DisableQuestMessage()
		else
			DLC1VQMinLevelVampireAttacks.Setvalue(VampAttackVal)
		endif
	elseIf (option == OIDDGQuestStart)
		DGQuestVal = value
		SetSliderOptionValue(OIDDGQuestStart, DGQuestVal, "{0}")
		if DGQuestVal > 100
			DLC1VQMinLevel.Setvalue(999)
			DisableQuestMessage()
		else
			DLC1VQMinLevel.Setvalue(DGQuestVal)
		endif
	elseIf (option == OIDDGVampLord)
		VampLordVal = value
		SetSliderOptionValue(OIDDGVampLord, VampLordVal, "{0}")
		DLC1RadiantDisguisedVampireLordChance.Setvalue(VampLordVal)
	elseIf (option == OIDDGScout)
		DGScoutVal = value
		SetSliderOptionValue(OIDDGScout, DGScoutVal, "{0}")
		DLC1ScoutPatrolChance.Setvalue(DGScoutVal)
	elseIf (option == OIDDGMinWait)
		DGMinWaitVal = value
		SetSliderOptionValue(OIDDGMinWait, DGMinWaitVal, "{0}")
		DLC1EclipseAttackNextWait.Setvalue(DGMinWaitVal)
	elseIf (option == OIDDGMaxWait)
		DGMaxWaitVal = value
		SetSliderOptionValue(OIDDGMaxWait, DGMaxWaitVal, "{0}")
		DLC1EclipseAttackNextMaxWait.Setvalue(DGMaxWaitVal)
	elseIf (option == OIDDBMinLevel)
		DBMinLevelVal = value
		SetSliderOptionValue(OIDDBMinLevel, DBMinLevelVal, "{0}")
		if DBMinLevelVal > 100
			DLC2CultistAttackMinLevel_KRY.Setvalue(999)
		else
			DLC2CultistAttackMinLevel_KRY.Setvalue(DBMinLevelVal)
		endif
	elseIf (option == OIDHFMinLevel)
		HFMinLevelVal = value
		SetSliderOptionValue(OIDHFMinLevel, HFMinLevelVal, "{0}")
		if HFMinLevelVal > 100
			BYOHHouseBuilding.iMinIntroLetterLevel = 999
			DisableQuestMessage()
		else
			BYOHHouseBuilding.iMinIntroLetterLevel = HFMinLevelVal as int
		endif
	elseIf (option == OIDMS06)
		MS06Val = value
		SetSliderOptionValue(OIDMS06, MS06Val, "{0}")
		if MS06Val > 100
			MS06MinLevel.Setvalue(999)
			DisableQuestMessage()
		else
			MS06MinLevel.Setvalue(MS06Val)
		endif
	elseIf (option == OIDMS04)
		MS04Val = value
		SetSliderOptionValue(OIDMS04, MS04Val, "{0}")
		if MS04Val > 100
			MS04MinLevel.Setvalue(999)
			DisableQuestMessage()
		else
			MS04MinLevel.Setvalue(MS04Val)
		endif
	elseIf (option == OIDFFR09)
		FFR09Val = value
		SetSliderOptionValue(OIDFFR09, FFR09Val, "{0}")
		if FFR09Val > 100
			FFRiften09Gate.Setvalue(999)
			DisableQuestMessage()
		else
			FFRiften09Gate.Setvalue(FFR09Val)
		endif
	elseIf (option == OIDFavor153)
		Favor153Val = value
		SetSliderOptionValue(OIDFavor153, Favor153Val, "{0}")
		If Favor153Val > 100
			Favor153MinLevel_KRY.Setvalue(999)
			DisableQuestMessage()
		else
			Favor153MinLevel_KRY.Setvalue(Favor153Val)
		endif
	elseIf (option == OIDFavor157)
		Favor157Val = value
		SetSliderOptionValue(OIDFavor157, Favor157Val, "{0}")
		If Favor157Val > 100
			Favor157MinLevel_KRY.Setvalue(999)
			DisableQuestMessage()
		else
			Favor157MinLevel_KRY.Setvalue(Favor157Val)
		endif
	elseIf (option == OIDFavor109)
		Favor109Val = value
		SetSliderOptionValue(OIDFavor109, Favor109Val, "{0}")
		If Favor109Val > 100
			Favor109MinLevel_KRY.Setvalue(999)
			DisableQuestMessage()
		else
			Favor109MinLevel_KRY.Setvalue(Favor109Val)
		endif
	elseIf (option == OIDDragonWait)
		DragonWaitVal = value
		SetSliderOptionValue(OIDDragonWait, DragonWaitVal, "{0}")
		WIWaitDragon.Setvalue(DragonWaitVal)
	elseIf (option == OIDDragonChance)
		DragonChanceVal = value
		SetSliderOptionValue(OIDDragonChance, DragonChanceVal, "{0}")
		RandomDragonChance_KRY.Setvalue(DragonChanceVal)
	elseIf (option == OIDDBRandomChance)
		DBAttackChanceVal = value
		SetSliderOptionValue(OIDDBRandomChance, DBAttackChanceVal, "{0}")
		DLC2WE09Chance.Setvalue(DBAttackChanceVal)
	elseIf (option == OIDDBDeathbrand)
		DeathbrandVal = value
		SetSliderOptionValue(OIDDBDeathbrand, DeathbrandVal, "{0}")
		If DeathbrandVal > 100
			DLC2dunHaknirTreasureQSTMinLevel.Setvalue(999)
			DisableQuestMessage()
		else
			DLC2dunHaknirTreasureQSTMinLevel.Setvalue(DeathbrandVal)
		endif
	elseIf (option == OIDDBEbonyWarrior)
		EbonyWarriorVal = value
		SetSliderOptionValue(OIDDBEbonyWarrior, EbonyWarriorVal, "{0}")
		If EbonyWarriorVal > 100
			DLC2EbonyWarriorMinLevel_KRY.Setvalue(999)
			DisableQuestMessage()
		else
			DLC2EbonyWarriorMinLevel_KRY.Setvalue(EbonyWarriorVal)
		endif
	elseIf (option == OIDWEBountyAmount)
		WEBountyAmtVal = value
		SetSliderOptionValue(OIDWEBountyAmount, WEBountyAmtVal, "{0}")
		WEbountyCollectorCrimeGoldRequirement.SetValue(WEBountyAmtVal)
	elseIf (option == OIDWEBountyChance)
		WEBountyChanceVal = value
		SetSliderOptionValue(OIDWEBountyChance, WEBountyChanceVal, "{0}")
		WEBountyCollectorChance.SetValue(WEBountyChanceVal)	
	elseIf (option == OIDWEThalmorMinLvl)
		WEThalmorVal = value
		SetSliderOptionValue(OIDWEThalmorMinLvl, WEThalmorVal, "{0}")
		If WEThalmorVal > 100
			MinLevelThalmorSquad_KRY.Setvalue(999)
			DisableQuestMessage()
		else
			MinLevelThalmorSquad_KRY.Setvalue(WEThalmorVal)
		endif		
	elseIf (option == OIDWEHiredThugsAmt)
		WEHiredThugsAmtVal = value
		SetSliderOptionValue(OIDWEHiredThugsAmt, WEHiredThugsAmtVal, "{0}")
		HiredThugsStolenItemMinValue_KRY.SetValue(WEHiredThugsAmtVal)	
	elseIf (option == OIDWEAssassinLvl)
		WEAssassinLvlVal = value
		SetSliderOptionValue(OIDWEAssassinLvl, WEAssassinLvlVal, "{0}")
		If WEAssassinLvlVal > 100
			DBAssassinMinLevel_KRY.Setvalue(999)
			DisableQuestMessage()
		else
			DBAssassinMinLevel_KRY.Setvalue(WEAssassinLvlVal)
		endif	
	elseIf (option == OIDWEAssassinAssault)
		WEAssassinAVal = value
		SetSliderOptionValue(OIDWEAssassinAssault, WEAssassinAVal, "{0}")
		DBAssassinMinAssaults_KRY.SetValue(WEAssassinAVal)		
	elseIf (option == OIDWEAssassinMurder)
		WEAssassinMVal = value
		SetSliderOptionValue(OIDWEAssassinMurder, WEAssassinMVal, "{0}")
		DBAssassinMinMurders_KRY.SetValue(WEAssassinMVal)			
	endIf
endEvent

event OnOptionDefault(int option)
	if (option == OIDDA02)
		DA02Val = 30
		SetSliderOptionValue(OIDDA02, DA02Val, "{0}")	
		DA02MinLevel.Setvalue(DA02Val)
	elseIf (option == OIDDA04)
		DA04Val = 15
		SetSliderOptionValue(OIDDA04, DA04Val, "{0}")
		DA04MinLevel.Setvalue(DA04Val)
	elseIf (option == OIDDA06)
		DA06Val = 9
		SetSliderOptionValue(OIDDA06, DA06Val, "{0}")
		DA06MinLevel.Setvalue(DA06Val)
	elseIf (option == OIDDA08)
		DA08Val = 20
		SetSliderOptionValue(OIDDA08, DA08Val, "{0}")
		DA08MinLevel.Setvalue(DA08Val)
	elseIf (option == OIDDA09)
		DA09Val = 12
		SetSliderOptionValue(OIDDA09, DA09Val, "{0}")
		DA09MinLevel.Setvalue(DA09Val)
	elseIf (option == OIDDA13)
		DA13Val = 12
		SetSliderOptionValue(OIDDA13, DA13Val, "{0}")
		DA13MinLevel.Setvalue(DA13Val)
	elseIf (option == OIDDA14)
		DA14Val = 14
		SetSliderOptionValue(OIDDA14, DA14Val, "{0}")
		DA14MinLevel_KRY.Setvalue(DA14Val)
	elseIf (option == OIDDA07)
		DA07Val = 20
		SetSliderOptionValue(OIDDA07, DA07Val, "{0}")
		DA07MinLevel_KRY.Setvalue(DA07Val)
	elseIf (option == OIDDGVampAttacks)
		VampAttackVal = 8
		SetSliderOptionValue(OIDDGVampAttacks, VampAttackVal, "{0}")
		DLC1VQMinLevelVampireAttacks.Setvalue(VampAttackVal)
	elseIf (option == OIDDGQuestStart)
		DGQuestVal = 0
		SetSliderOptionValue(OIDDGQuestStart, DGQuestVal, "{0}")
		DLC1VQMinLevel.Setvalue(DGQuestVal)
	elseIf (option == OIDDGVampLord)
		VampLordVal = 25
		SetSliderOptionValue(OIDDGVampLord, VampLordVal, "{0}")
		DLC1RadiantDisguisedVampireLordChance.Setvalue(VampLordVal)
	elseIf (option == OIDDGScout)
		DGScoutVal = 25
		SetSliderOptionValue(OIDDGScout, DGScoutVal, "{0}")
		DLC1ScoutPatrolChance.Setvalue(DGScoutVal)
	elseIf (option == OIDDGMinWait)
		DGMinWaitVal = 1
		SetSliderOptionValue(OIDDGMinWait, DGMinWaitVal, "{0}")
		DLC1EclipseAttackNextWait.Setvalue(DGMinWaitVal)
	elseIf (option == OIDDGMaxWait)
		DGMaxWaitVal = 20
		SetSliderOptionValue(OIDDGMaxWait, DGMaxWaitVal, "{0}")
		DLC1EclipseAttackNextMaxWait.Setvalue(DGMaxWaitVal)
	elseIf (option == OIDDBMinLevel)
		DBMinLevelVal = 25
		SetSliderOptionValue(OIDDBMinLevel, DBMinLevelVal, "{0}")
		DLC2CultistAttackMinLevel_KRY.Setvalue(DBMinLevelVal)
	elseIf (option == OIDHFMinLevel)
		HFMinLevelVal = 9
		SetSliderOptionValue(OIDHFMinLevel, HFMinLevelVal, "{0}")
		BYOHHouseBuilding.iMinIntroLetterLevel = HFMinLevelVal as int
	elseIf (option == OIDMS06)
		MS06Val = 10
		SetSliderOptionValue(OIDMS06, MS06Val, "{0}")
		MS06MinLevel.Setvalue(MS06Val)
	elseIf (option == OIDMS04)
		MS04Val = 14
		SetSliderOptionValue(OIDMS04, MS04Val, "{0}")
		MS04MinLevel.Setvalue(MS04Val)
	elseIf (option == OIDFFR09)
		FFR09Val = 14
		SetSliderOptionValue(OIDFFR09, FFR09Val, "{0}")
		FFRiften09Gate.Setvalue(FFR09Val)
	elseIf (option == OIDFavor153)
		Favor153Val = 22
		SetSliderOptionValue(OIDFavor153, Favor153Val, "{0}")
		Favor153MinLevel_KRY.Setvalue(Favor153Val)
	elseIf (option == OIDFavor157)
		Favor157Val = 20
		SetSliderOptionValue(OIDFavor157, Favor157Val, "{0}")
		Favor157MinLevel_KRY.Setvalue(Favor157Val)
	elseIf (option == OIDFavor109)
		Favor109Val = 10
		SetSliderOptionValue(OIDFavor109, Favor109Val, "{0}")
		Favor109MinLevel_KRY.Setvalue(Favor109Val)
	elseIf (option == OIDDragonWait)
		DragonWaitVal = 3
		SetSliderOptionValue(OIDDragonWait, DragonWaitVal, "{0}")
		WIWaitDragon.Setvalue(DragonWaitVal)
	elseIf (option == OIDDragonChance)
		DragonChanceVal = 100
		SetSliderOptionValue(OIDDragonChance, DragonChanceVal, "{0}")
		RandomDragonChance_KRY.Setvalue(DragonChanceVal)
	elseIf (option == OIDDBRandomChance)
		DBAttackChanceVal = 100
		SetSliderOptionValue(OIDDBRandomChance, DBAttackChanceVal, "{0}")
		DLC2WE09Chance.Setvalue(DBAttackChanceVal)
	elseIf (option == OIDDBDeathbrand)
		DeathbrandVal = 36
		SetSliderOptionValue(OIDDBDeathbrand, DeathbrandVal, "{0}")
		DLC2dunHaknirTreasureQSTMinLevel.Setvalue(DeathbrandVal)
	elseIf (option == OIDDBEbonyWarrior)
		EbonyWarriorVal = 80
		SetSliderOptionValue(OIDDBEbonyWarrior, EbonyWarriorVal, "{0}")
		DLC2EbonyWarriorMinLevel_KRY.Setvalue(EbonyWarriorVal)
	elseIf (option == OIDWEBountyAmount)
		WEBountyAmtVal = 1000
		SetSliderOptionValue(OIDWEBountyAmount, WEBountyAmtVal, "{0}")
		WEbountyCollectorCrimeGoldRequirement.SetValue(WEBountyAmtVal)
	elseIf (option == OIDWEBountyChance)
		WEBountyChanceVal = 25
		SetSliderOptionValue(OIDWEBountyChance, WEBountyChanceVal, "{0}")
		WEBountyCollectorChance.SetValue(WEBountyChanceVal)		
	elseIf (option == OIDWEThalmorMinLvl)
		WEThalmorVal = 8
		SetSliderOptionValue(OIDWEThalmorMinLvl, WEThalmorVal, "{0}")
		MinLevelThalmorSquad_KRY.Setvalue(WEThalmorVal)	
	elseIf (option == OIDWEHiredThugsAmt)
		WEHiredThugsAmtVal = 0
		SetSliderOptionValue(OIDWEHiredThugsAmt, WEHiredThugsAmtVal, "{0}")
		HiredThugsStolenItemMinValue_KRY.SetValue(WEHiredThugsAmtVal)	
	elseIf (option == OIDWEAssassinLvl)
		WEAssassinLvlVal = 5
		SetSliderOptionValue(OIDWEAssassinLvl, WEAssassinLvlVal, "{0}")
		DBAssassinMinLevel_KRY.Setvalue(WEAssassinLvlVal)
	elseIf (option == OIDWEAssassinAssault)
		WEAssassinAVal = 0
		SetSliderOptionValue(OIDWEAssassinAssault, WEAssassinAVal, "{0}")
		DBAssassinMinAssaults_KRY.SetValue(WEAssassinAVal)		
	elseIf (option == OIDWEAssassinMurder)
		WEAssassinMVal = 0
		SetSliderOptionValue(OIDWEAssassinMurder, WEAssassinMVal, "{0}")
		DBAssassinMinMurders_KRY.SetValue(WEAssassinMVal)			
	endIf
endEvent

event OnOptionHighlight(int option)
	if (option == OIDDA02)
		SetInfoText("This is the minimum level you must reach before the quest Boethiah's Calling will start.\nThe book 'Boethiah's Proving' will not appear in dungeons, and cultists will not attack before this level is reached.  Default: 30")
	elseIf (option == OIDDA04)
		SetInfoText("This is the minimum level you must reach before completing Discerning the Transmundane.\nYou will still be able to complete the main quest, but the part of the quest involving the daedric prince will not proceed.  Default: 15")
	elseIf (option == OIDDA06)
		SetInfoText("This is the minimum level you must reach before the quest The Cursed Tribe will start.\nDefault: 9")
	elseIf (option == OIDDA08)
		SetInfoText("This is the minimum level you must reach before the quest The Whispering Door will start.\nDefault: 20")
	elseIf (option == OIDDA09)
		SetInfoText("This is the minimum level you must reach before the quest The Break of Dawn will start.\nDefault: 12")
	elseIf (option == OIDDA13)
		SetInfoText("This is the minimum level you must reach before the quest The Only Cure will start.\nDefault: 12")
	elseIf (option == OIDDA14)
		SetInfoText("This is the minimum level you must reach before the quest A Night to Remember will start.\nDefault: 14")
	elseIf (option == OIDDA07)
		SetInfoText("This is the minimum level you must reach before the quest Pieces of the Past will start.\nDefault: 20")
	elseIf (option == OIDDGVampAttacks)
		SetInfoText("This is the level at which vampire attacks begin to occur in cities.\nIncreasing this value will also prevent further vampire attacks from occuring even after the quest has started. This will not affect attacks that occur during the eclipse. Default: 8")
	elseIf (option == OIDDGQuestStart)
		SetInfoText("At this point you'll begin hearing rumors about Dawnguard, and the Dawnguard will begin active recruitment.\nYou can still begin the quest prior to this level by visiting Dayspring Canyon.\nDefault: 10")
	elseIf (option == OIDDGVampLord)
		SetInfoText("This is the percent chance that the player will be attacked by a disguised vampire.\nSet to 0 to disable this type of encounter.  Default: 25")
	elseIf (option == OIDDGScout)
		SetInfoText("This is the percent chance for random Dawnguard/vampire scouts to attack the headquarters of the other.\nDefault: 25")
	elseIf (option == OIDDGMinWait)
		SetInfoText("This is the minimum number of days between vampire attacks.\nThis value affects BOTH eclipse & non-eclipse attacks.\nDefault: 1")
	elseIf (option == OIDDGMaxWait)
		SetInfoText("This is the maximum number of days between vampire attacks.\nThis value affects BOTH eclipse & non-eclipse attacks.\nDefault: 20")
	elseIf (option == OIDDBMinLevel)
		SetInfoText("This is the minimum level you must reach before the Dragonborn quest will start. This is in addition to the quest requirement listed above.  However, if in Solstheim, the quest may start regardless of player level. \nDefault: 25")
	elseIf (option == OIDDBCultAttackMenu)
		SetInfoText("This part of the main quest must be completed before the Dragonborn quest will start.\nDefault: Way of the Voice.")
	elseIf (option == OIDHFMinLevel)
		SetInfoText("This is the minimum level you must reach before the Hearthfire land purchase quests will start.\nDefault: 9")
	elseIf (option == OIDMS06)
		SetInfoText("This is the minimum level you must reach before the quest The Wolf Queen Awakened will start.\nDefault: 10")
	elseIf (option == OIDMS04)
		SetInfoText("This is the minimum level you must reach before the quest Unfathomable Depths will start.\nDefault: 14")
	elseIf (option == OIDFFR09)
		SetInfoText("This is the minimum level you must reach before the quest Grimsever's Return will start.\nDefault: 14")
	elseIf (option == OIDFavor153)
		SetInfoText("This is the minimum level you must reach before you can receive the quest Kill the Giant (Dawnstar).\nThis quest must be completed before you can purchase land in the Pale.\nDefault: 22")
	elseIf (option == OIDFavor157)
		SetInfoText("This is the minimum level you must reach before you can receive the quest Dungeon Delving (Markarth).\nDefault: 20")
	elseIf (option == OIDFavor109)
		SetInfoText("This is the minimum level you must reach before you can receive the quest Kill the Vampire (Solitude).\nDefault: 10")
	elseIf (option == OIDDragonWait)
		SetInfoText("This is the minimum number of days between random dragon encounters.\nAfter completing the main quest, 3 days will be added to this value.\nDefault: 3")
	elseIf (option == OIDDragonChance)
		SetInfoText("This is the percent chance that the player will encounter a random dragon.\nSet to 0 to disable this type of encounter.  Default: 100")
	elseIf (option == OIDDBRandomChance)
		SetInfoText("This is the percent chance that the player will be attacked by random cultists. This encounter also requires that you have completed the main quest stage selected above.  However, if you are in Solstheim, the minimum level requirement will be ignored. Set to 0 to disable this type of encounter.  Default: 100")
	elseIf (option == OIDDBDeathbrand)
		SetInfoText("This is the minimum level you must reach before the quest Deathbrand will start.\nDefault: 36")
	elseIf (option == OIDDBEbonyWarrior)
		SetInfoText("This is the minimum level you must reach before the quest The Ebony Warrior will start.\nDefault: 80")
	elseIf (option == OIDDGWerewolves)
		SetInfoText("Checking this box will allow the random werewolf encounters added by Dawnguard to occur regardless of whether or not the player has completed the Companion's quest Proving Honor.  Default: off")
	elseIf (option == OIDWEBountyAmount)
		SetInfoText("The amount of gold that your bounty must reach before bounty collectors will be sent for your character.\nDefault: 1000")
	elseIf (option == OIDWEBountyChance)
		SetInfoText("This is the percent chance that a bounty collector will come after you once your bounty has reached the required amount.  Default: 25")
	elseIf (option == OIDWEThalmorMinLvl)
		SetInfoText("This is the minimum level you must reach before Thalmor Execution Squads will be sent after your character.\nDefault: 8")
	elseIf (option == OIDWEAssassinLvl)
		SetInfoText("This is the minimum level you must reach before a Dark Brotherhood Assassin will be sent after your character.  Default: 5")
	elseIf (option == OIDWEHiredThugsAmt)
		SetInfoText("The value of the item you steal must be at least this amount in order to trigger the Hired Thugs event.\nDefault: 0")
	elseIf (option == OIDWEAssassinAssault)
		SetInfoText("The minimum number of assaults required before a Dark Brotherhood Assassin will be sent after your character.  Default: 0")
	elseIf (option == OIDWEAssassinMurder)
		SetInfoText("The minimum number of murders required before a Dark Brotherhood Assassin will be sent after your character.  Default: 0")
	elseIf (option == OIDMeridiaVamp)
		SetInfoText("Checking this box will prevent Meridia's quest from starting if the player is a vampire.\nDefault: off")
	elseIf (option == OIDWEThalmorQuests)
		SetInfoText("Checking this box will prevent Thalmor Execution Squads for coming for your character until after Diplomatic Immunity or until after taking Whiterun as a Stormcloak.\nDefault: off")
	endIf
endEvent

Function DisableQuestMessage()
	if msgshown <= 5
		ShowMessage("Setting the level requirement to 101 will delay this quest indefinitely.", false, "Okay")
		msgshown = msgshown + 1
	endif	
EndFunction

Function BeginLoadPreset()
	if !ShowMessage("Are you sure? Loading this preset will overwrite the current settings.", true, "Load", "Cancel")
		return
	endif
	If !ShowMessage("Please do not leave the MCM menu until a new messagebox shows the load is complete.", true, "Begin Load", "Cancel")
		Return
	EndIf

	FISSInterface fiss = FISSFactory.getFISS()
	If (!fiss)
		Debug.MessageBox("FISS not installed. Loading disabled.")
		return
	EndIf

	fiss.beginLoad("TimingIsEverythingPresets.xml")

	OnOptionSliderAccept(OIDDA02, fiss.loadFloat("DA02MinLevel"))
	OnOptionSliderAccept(OIDDA04, fiss.loadFloat("DA04MinLevel"))
	OnOptionSliderAccept(OIDDA06, fiss.loadFloat("DA06MinLevel"))
	OnOptionSliderAccept(OIDDA08, fiss.loadFloat("DA08MinLevel"))
	OnOptionSliderAccept(OIDDA09, fiss.loadFloat("DA09MinLevel"))
	OnOptionSliderAccept(OIDDA13, fiss.loadFloat("DA13MinLevel"))
	OnOptionSliderAccept(OIDDA14, fiss.loadFloat("DA14MinLevel_KRY"))
	OnOptionSliderAccept(OIDDA07, fiss.loadFloat("DA07MinLevel_KRY"))
	OnOptionSliderAccept(OIDDGQuestStart, fiss.loadFloat("DLC1VQMinLevel"))
	OnOptionSliderAccept(OIDDGVampAttacks, fiss.loadFloat("DLC1VQMinLevelVampireAttacks"))
	OnOptionSliderAccept(OIDDGVampLord, fiss.loadFloat("DLC1RadiantDisguisedVampireLordChance"))
	OnOptionSliderAccept(OIDDGScout, fiss.loadFloat("DLC1ScoutPatrolChance"))
	OnOptionSliderAccept(OIDDGMinWait, fiss.loadFloat("DLC1EclipseAttackNextWait"))
	OnOptionSliderAccept(OIDDGMaxWait, fiss.loadFloat("DLC1EclipseAttackNextMaxWait"))
	OnOptionMenuAccept(OIDDBCultAttackMenu, fiss.loadInt ("DLC2QuestStartSelection_KRY"))					; OptionMenuAccept
	OnOptionSliderAccept(OIDDBMinLevel, fiss.loadFloat("DLC2CultistAttackMinLevel_KRY"))
	OnOptionSliderAccept(OIDHFMinLevel, fiss.loadFloat("BYOHHouseBuilding"))								; Hearthfire
	OnOptionSliderAccept(OIDDBRandomChance, fiss.loadFloat("DLC2WE09Chance"))
	OnOptionSliderAccept(OIDMS06, fiss.loadFloat("MS06MinLevel"))
	OnOptionSliderAccept(OIDMS04, fiss.loadFloat("MS04MinLevel"))
	OnOptionSliderAccept(OIDFFR09, fiss.loadFloat("FFRiften09Gate"))
	OnOptionSliderAccept(OIDFavor153, fiss.loadFloat("Favor153MinLevel_KRY"))
	OnOptionSliderAccept(OIDFavor157, fiss.loadFloat("Favor157MinLevel_KRY"))
	OnOptionSliderAccept(OIDFavor109, fiss.loadFloat("Favor109MinLevel_KRY"))
	OnOptionSliderAccept(OIDDragonWait, fiss.loadFloat("WIWaitDragon"))
	OnOptionSliderAccept(OIDDragonChance, fiss.loadFloat("RandomDragonChance_KRY"))
	WerewolfEncounters_KRY.SetValue(fiss.loadFloat("WerewolfEncounters_KRY"))								; SetValue
	OnOptionSliderAccept(OIDDBEbonyWarrior, fiss.loadFloat("DLC2EbonyWarriorMinLevel_KRY"))
	OnOptionSliderAccept(OIDDBDeathbrand, fiss.loadFloat("DLC2dunHaknirTreasureQSTMinLevel"))
	OnOptionSliderAccept(OIDWEBountyAmount, fiss.loadFloat("WEbountyCollectorCrimeGoldRequirement"))
	OnOptionSliderAccept(OIDWEBountyChance, fiss.loadFloat("WEBountyCollectorChance"))
	MeridiaNoVampire_KRY.SetValue(fiss.loadFloat("MeridiaNoVampire_KRY"))	
	QuestLockThalmorSquad_KRY.SetValue(fiss.loadFloat("QuestLockThalmorSquad_KRY"))	
	OnOptionSliderAccept(OIDWEThalmorMinLvl, fiss.loadFloat("WEThalmorVal"))
	OnOptionSliderAccept(OIDWEHiredThugsAmt, fiss.loadFloat("WEHiredThugsAmtVal"))
	OnOptionSliderAccept(OIDWEAssassinLvl, fiss.loadFloat("WEAssassinLvlVal"))
	OnOptionSliderAccept(OIDWEAssassinAssault, fiss.loadFloat("WEAssassinAVal"))
	OnOptionSliderAccept(OIDWEAssassinMurder, fiss.loadFloat("WEAssassinMVal"))		
	
	string loadResult = fiss.endLoad()	; check the result
	If (loadResult != "")
		ShowMessage("Error reading preset file.")
	Else
		ShowMessage("Preset has been loaded successfully!", false, "Okay")
	EndIf
EndFunction
	
	
Function BeginSavePreset()
	if !ShowMessage("Are you sure? This will overwrite the existing preset with your current settings.", true, "Save", "Cancel")
		return
	endif
	if !ShowMessage("Please do not leave the MCM menu until a new messagebox shows the save is complete.", true, "Begin Save", "Cancel")
		return
	endif

	FISSInterface fiss = FISSFactory.getFISS()
	If (!fiss)
		Debug.MessageBox("FISS not installed. Saving disabled.")
		return
	EndIf

	fiss.beginSave("TimingIsEverythingPresets.xml", "TimingIsEverything")
	
	fiss.saveFloat("DA02MinLevel", DA02Val)
	fiss.saveFloat("DA04MinLevel", DA04Val)
	fiss.saveFloat("DA06MinLevel", DA06Val) 
	fiss.saveFloat("DA08MinLevel", DA08Val) 
	fiss.saveFloat("DA09MinLevel", DA09Val) 
	fiss.saveFloat("DA13MinLevel", DA13Val) 
	fiss.saveFloat("DA14MinLevel_KRY", DA14Val) 
	fiss.saveFloat("DA07MinLevel_KRY", DA07Val) 
	fiss.saveFloat("DLC1VQMinLevel", DGQuestVal) 
	fiss.saveFloat("DLC1VQMinLevelVampireAttacks", VampAttackVal) 
	fiss.saveFloat("DLC1RadiantDisguisedVampireLordChance", VampLordVal) 
	fiss.saveFloat("DLC1ScoutPatrolChance", DGScoutVal) 
	fiss.saveFloat("DLC1EclipseAttackNextMaxWait", DGMaxWaitVal)  
	fiss.saveFloat("DLC1EclipseAttackNextWait", DGMinWaitVal) 
	fiss.saveInt("DLC2QuestStartSelection_KRY", DBQuestSelection) 				
	fiss.saveFloat("DLC2CultistAttackMinLevel_KRY", DBMinLevelVal) 
	fiss.saveFloat("BYOHHouseBuilding", HFMinLevelVal)						
	fiss.saveFloat("DLC2WE09Chance", DBAttackChanceVal) 
	fiss.saveFloat("MS06MinLevel", MS06Val) 
	fiss.saveFloat("MS04MinLevel", MS04Val) 
	fiss.saveFloat("FFRiften09Gate", FFR09Val) 
	fiss.saveFloat("Favor153MinLevel_KRY", Favor153Val) 
	fiss.saveFloat("Favor157MinLevel_KRY", Favor157Val) 
	fiss.saveFloat("Favor109MinLevel_KRY", Favor109Val) 
	fiss.saveFloat("WIWaitDragon", DragonWaitVal) 
	fiss.saveFloat("RandomDragonChance_KRY", DragonChanceVal) 
	fiss.saveFloat("WerewolfEncounters_KRY", WerewolfEncounters_KRY.getValue())					
	fiss.saveFloat("DLC2dunHaknirTreasureQSTMinLevel", DeathbrandVal) 
	fiss.saveFloat("DLC2EbonyWarriorMinLevel_KRY", EbonyWarriorVal) 
	fiss.saveFloat("WEbountyCollectorCrimeGoldRequirement", WEBountyAmtVal) 
	fiss.saveFloat("WEBountyCollectorChance", WEBountyChanceVal) 
	fiss.saveFloat("MeridiaNoVampire_KRY", MeridiaNoVampire_KRY.getValue())			
	fiss.saveFloat("QuestLockThalmorSquad_KRY", QuestLockThalmorSquad_KRY.getValue())		
	fiss.saveFloat("WEThalmorVal", WEThalmorVal)
	fiss.saveFloat("WEHiredThugsAmtVal", WEHiredThugsAmtVal)
	fiss.saveFloat("WEAssassinLvlVal", WEAssassinLvlVal)
	fiss.saveFloat("WEAssassinAVal", WEAssassinAVal)
	fiss.saveFloat("WEAssassinMVal", WEAssassinMVal)		

	string saveResult = fiss.endSave()	
	; check the result
	If (saveResult != "")
		ShowMessage("Error saving preset file.")
	Else
		ShowMessage("Your settings has been successfully saved!", false, "Okay")
	EndIf
EndFunction

