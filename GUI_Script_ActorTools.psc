Scriptname GUI_Script_ActorTools extends activemagiceffect  

QUEST PROPERTY UILib AUTO
GUI_MenuMain PROPERTY MenuMain AUTO
STRING[] PROPERTY StringList AUTO
STRING[] PROPERTY AVStringList AUTO
STRING[] PROPERTY RelationshipRanks AUTO
STRING[] PROPERTY FactionList AUTO
FORMLIST PROPERTY GUI_FactionList AUTO 
IMPORT ActorValueInfo
IMPORT StringUtil
ACTOR PROPERTY PlayerRef AUTO

FACTION PROPERTY DunPlayerAllyFaction AUTO
FACTION PROPERTY DismissedFollowerFaction AUTO

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	OBJECTREFERENCE tempRef = Game.GetCurrentCrosshairRef()
	IF tempRef
		IF tempRef AS ACTOR
			ACTOR akActor = tempRef AS ACTOR
			INT result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Actor Tools", stringList, 0, 0) - 1

			IF result == 0 ; SHOW STATS
				(UILib as uistatsmenu).OpenMenu(akActor)
			ELSEIF result == 1 ; Show Magic Menu
				(UILib AS uimagicmenu).OpenMenu(akActor,PlayerRef)
				(UILib AS uimagicmenu).SetPropertyForm("receivingActor",PlayerRef)
			ELSEIF result == 2
				Int akRel = akActor.GetRelationshipRank(PlayerRef) + 4
				result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Current Relationship Rank: " + RelationshipRanks[akRel], RelationshipRanks, akRel, akRel)
				akActor.SetRelationshipRank(PlayerRef,result - 4)
			ELSEIF result == 3
				akActor.OpenInventory(True)
			ELSEIF result == 4
				akActor.ShowBarterMenu()
			ELSEIF result == 5
				akActor.ShowGiftMenu(true,None,True,True)
			ELSEIF result == 6
				akActor.ShowGiftMenu(false,None,True,True)
			ELSEIF result == 7
				Debug.Notification(akActor.ShowGiftMenu(True,None,True,True) + "Favor Points Gained")
			ELSEIF result == 8
				IF akActor.IsPlayerTeammate()
					Debug.Notification(akActor.GetDisplayName() + " is no longer a teammate")
					akActor.SetPlayerTeammate(false,false)
				ELSE
					Debug.Notification(akActor.GetDisplayName() + " is a teammate")
					akActor.SetPlayerTeammate()
				ENDIF
			ELSEIF result == 9
				akActor.UnequipAll()
			ELSEIF result == 10
				akActor.SetRestrained(True)
			ELSEIF result == 11
				akActor.SetRestrained(False)
			ELSEIF result == 12
				ACTORBASE akBase = akActor.GetActorBase()
				IF akBase.IsInvulnerable()
					akBase.SetInvulnerable(false)
					Debug.Notification(akActor.GetDisplayName() + " is no longer invulnerable")
				ELSE 
					akBase.SetInvulnerable(true)
					Debug.Notification(akActor.GetDisplayName() + " is now invulnerable")
				ENDIF 
			ELSEIF result == 13
				ACTORBASE akBase = akActor.GetActorBase()
				IF akBase.IsProtected()
					akBase.SetProtected(false)
					Debug.Notification(akActor.GetDisplayName() + " is no longer protected")
				ELSE 
					akBase.SetProtected(true)
					Debug.Notification(akActor.GetDisplayName() + " is now protected")
				ENDIF 
			ELSEIF result == 14
				ACTORBASE akBase = akActor.GetActorBase()
				IF akBase.IsEssential()
					akBase.SetEssential(false)
					Debug.Notification(akActor.GetDisplayName() + " is no longer essential")
				ELSE 
					akBase.SetEssential(true)
					Debug.Notification(akActor.GetDisplayName() + " is now essential")
				ENDIF 
			ELSEIF result == 15
				IF akActor.IsGhost()
					akActor.SetGhost(false)
					Debug.Notification(akActor.GetDisplayName() + " is no longer a ghost")
				ELSE 
					akActor.SetGhost(true)
					Debug.Notification(akActor.GetDisplayName() + " is now a ghost")
				ENDIF 
			ELSEIF result == 16
				akActor.SetPlayerControls(true)
				akActor.EnableAI()
			ELSEIF result == 17
				akActor.SetPlayerControls(false)
				akActor.EnableAI()
			ELSEIF result == 18
				result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Add To Faction", FactionList, 0, 0)
				akActor.AddToFaction(GUI_FactionList.GetAt(result) AS FACTION)
			ELSEIF result == 19
				result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Remove From Faction", FactionList, 0, 0)
				akActor.RemoveFromFaction(GUI_FactionList.GetAt(result) AS FACTION)
			ELSEIF result == 20
				akActor.AllowPCDialogue(true)
			ELSEIF result == 21
				akActor.AllowPCDialogue(false)
			ELSEIF result == 22
				result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Play Idle", MenuMain.IdlesList , 0, 0)
				Debug.SendAnimationEvent(tempRef, MenuMain.IdlesList[result])
			ELSEIF result == 23 ; Edit Idle List
				result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Edit Idle Slot", MenuMain.IdlesList , 0, 0)
				String sResult = ((UILib AS FORM) AS UILIB_GRIMY).ShowTextInput("Enter New Idle",MenuMain.IdlesList[result])
				MenuMain.IdlesList[result] = sResult
			ELSEIF result == 24 ; save idle presets
				MenuMain.fissSaveIdles()
			ELSEIF result == 25 ; load idle presets
				MenuMain.fissLoadIdles()
			ENDIF
		ENDIF
	ENDIF
ENDEVENT


	;Debug.Notification("Loading Stats...")
	;STRING[] actorStats = new STRING[36]
	;actorStats[0] = "Level " + akActor.GetLevel()
	;actorStats[1] = getAVStats(parse(AVStringList[1]),akActor)
	;actorStats[2] = getAVStats(parse(AVStringList[2]),akActor)
	;actorStats[3] = getAVStats(parse(AVStringList[3]),akActor)
	;actorStats[4] = "Carry Weight: " + akActor.GetAV("InventoryWeight") + " / " + akActor.GetAV("CarryWeight")
	;actorStats[5] = getAVStats(parse(AVStringList[5]),akActor)
	;actorStats[6] = getAVStats(parse(AVStringList[6]),akActor)
	;actorStats[7] = getAVStats(parse(AVStringList[7]),akActor)
	;actorStats[8] = getAVStats(parse(AVStringList[8]),akActor)
	;actorStats[9] = getAVStats(parse(AVStringList[9]),akActor)
	;actorStats[10] = getAVStats(parse(AVStringList[10]),akActor)
	;actorStats[11] = getAVStats(parse(AVStringList[11]),akActor)
	;actorStats[12] = getAVStats(parse(AVStringList[12]),akActor)
	;actorStats[13] = getAVStats(parse(AVStringList[13]),akActor)
	;actorStats[14] = getAVStats(parse(AVStringList[14]),akActor)
	;actorStats[15] = getAVStats(parse(AVStringList[15]),akActor)
	;actorStats[16] = getAVStats(parse(AVStringList[16]),akActor)
	;actorStats[17] = getAVStats(parse(AVStringList[17]),akActor)
	;actorStats[18] = getAVStats(parse(AVStringList[18]),akActor)
	;actorStats[19] = getAVStats(parse(AVStringList[19]),akActor)
	;actorStats[20] = getAVStats(parse(AVStringList[20]),akActor)
	;actorStats[21] = getAVStats(parse(AVStringList[21]),akActor)
	;actorStats[22] = getAVStats(parse(AVStringList[22]),akActor)
	;actorStats[23] = getAVStats(parse(AVStringList[23]),akActor)
	;actorStats[24] = getAVStats(parse(AVStringList[24]),akActor)
	;actorStats[25] = getAVStats(parse(AVStringList[25]),akActor)
	;actorStats[26] = getAVStats(parse(AVStringList[26]),akActor)
	;actorStats[27] = getAVStats(parse(AVStringList[27]),akActor)
	;actorStats[28] = getAVStats(parse(AVStringList[28]),akActor)
	;actorStats[29] = getAVStats(parse(AVStringList[29]),akActor)
	;actorStats[30] = getAVStats(parse(AVStringList[30]),akActor)
	;actorStats[31] = getAVStats(parse(AVStringList[31]),akActor)
	;actorStats[32] = getAVStats(parse(AVStringList[32]),akActor)
	;actorStats[33] = getAVStats(parse(AVStringList[33]),akActor)
	;actorStats[34] = getAVStats(parse(AVStringList[34]),akActor)
	;actorStats[35] = getAVStats(parse(AVStringList[35]),akActor)
	;((UILib as FORM) as UILIB_GRIMY).ShowList(akActor.GetDisplayName() + "'s Stats", actorStats, 0, 0)

;STRING FUNCTION GetAVStats(STRING actorValue,ACTOR akActor)
;	ACTORVALUEINFO akAVI = GetAVIByName(actorValue)
;	IF akAVI
;		FLOAT akCurrent = akAVI.GetCurrentValue(akActor)
;		FLOAT akBase =akAVI.GetBaseValue(akActor)
;		FLOAT akMax = akAVI.GetMaximumValue(akActor)
;		RETURN actorValue + ": " + akCurrent + " / ( " + akBase + " + " + (akMax - akBase) + " )"
;	ELSE
;		RETURN "Error: " + actorValue + " is not a recognized actor value"
;	ENDIF
;ENDFUNCTION

;STRING FUNCTION parse(STRING akString)
;	RETURN subString(akString,0,-1+GetLength(akString))
;ENDFUNCTION 