Scriptname GUI_Script_PlayerTools extends activemagiceffect  

QUEST PROPERTY UILib AUTO
GUI_MenuMain PROPERTY MenuMain AUTO
STRING[] PROPERTY StringList AUTO
STRING[] PROPERTY SkillList AUTO
message property GUI_LockQuery auto
Actor Property PlayerRef Auto

Event OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	Int result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Player Tools", stringList, 0, 0) - 1
	If result == 0
		String sResult = ((UILib as form) as uilib_grimy).ShowTextInput("Set Name", PlayerRef.GetDisplayName())
		PlayerRef.SetDisplayName(sResult)
	ELSEIF result == 1
		ACTORBASE akBase = PlayerRef.GetActorBase()
		IF akBase.IsInvulnerable()
			akBase.SetInvulnerable(false)
			Debug.Notification(PlayerRef.GetDisplayName() + " is no longer invulnerable")
		ELSE 
			akBase.SetInvulnerable(true)
			Debug.Notification(PlayerRef.GetDisplayName() + " is now invulnerable")
		ENDIF 
	ELSEIF result == 2
		ACTORBASE akBase = PlayerRef.GetActorBase()
		IF akBase.IsProtected()
			akBase.SetProtected(false)
			Debug.Notification(PlayerRef.GetDisplayName() + " is no longer protected")
		ELSE 
			akBase.SetProtected(true)
			Debug.Notification(PlayerRef.GetDisplayName() + " is now protected")
		ENDIF 
	ELSEIF result == 3
		ACTORBASE akBase = PlayerRef.GetActorBase()
		IF akBase.IsEssential()
			akBase.SetEssential(false)
			Debug.Notification(PlayerRef.GetDisplayName() + " is no longer essential")
		ELSE 
			akBase.SetEssential(true)
			Debug.Notification(PlayerRef.GetDisplayName() + " is now essential")
		ENDIF 
	ELSEIF result == 4
		IF PlayerRef.IsGhost()
			PlayerRef.SetGhost(false)
			Debug.Notification(PlayerRef.GetDisplayName() + " is no longer a ghost")
		ELSE 
			PlayerRef.SetGhost(true)
			Debug.Notification(PlayerRef.GetDisplayName() + " is now a ghost")
		ENDIF
	ELSEIF result == 5 
		result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Play Idle", MenuMain.IdlesList , 0, 0)
		Debug.SendAnimationEvent(PlayerRef, MenuMain.IdlesList[result])
	ELSEIF result == 6 ; Edit Idle List
		result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Edit Idle Slot", MenuMain.IdlesList , 0, 0)		
		String sResult = ((UILib AS FORM) AS UILIB_GRIMY).ShowTextInput("Enter New Idle",MenuMain.IdlesList[result])
		MenuMain.IdlesList[result] = sResult
	ELSEIF result == 7 ; save idle presets
		MenuMain.fissSaveIdles()
	ELSEIF result == 8 ; load idle presets
		MenuMain.fissLoadIdles()
	ElseIf result == 9
		Int iResult = ((UILib as form) as uilib_grimy).ShowList("Clear Selected Alias", showAliaslist(PlayerRef), 0, 0) - 1
		If iResult > -1
			PlayerRef.GetNthReferenceAlias(iResult).Clear()
		EndIf
	ElseIf result == 10
		Int iResult = GrimyToolsPluginScript.HexString2Int( ((UILib as form) as uilib_grimy).ShowTextInput("Enter Perk FormID:", "0x12345678") )
		FORM tempForm = Game.GetForm(iResult)
		If tempForm && tempForm As Perk
			PERK tempPerk = tempForm As Perk
			iResult = ((UILib as form) as uilib_grimy).ShowList("Perk Editor: Edit Perk Entry", showPerkEntryList(tempPerk), 0, 0) - 1
			
			If canEditEntry(tempPerk,iResult)
				FLOAT fResult = ((UILib as form) as uilib_grimy).ShowTextInput("Adjust Perk Entry Value", tempPerk.GetNthEntryValue(iResult,1)) AS FLOAT
				tempPerk.SetNthEntryValue(iResult,1,fResult)
			EndIf
		Else
			Debug.Notification("Invalid FormID")
		EndIf
	;	Int iResult = ((UILib as form) as uilib_grimy).ShowList("Perk Editor: Select Skill", SkillList, 0, 0)
	;	If( iResult >= 1 ) && ( iResult <= 18 )
	;		ActorValueInfo akAVI = ActorValueInfo.GetAVIByID(iResult + 5)
	;		Perk[] perkList = akAVI.GetPerks(PlayerRef,true,true)
	;		iResult = ((UILib as form) as uilib_grimy).ShowList("Perk Editor: Select Perk", showPerkList(perkList), 0, 0) - 1
	;		int iResult2 = ((UILib as form) as uilib_grimy).ShowList("Perk Editor: Edit Perk Entry", showPerkEntryList(perkList[iResult]), 0, 0) - 1
	;		If canEditEntry(perkList[iResult],iResult2)
	;			FLOAT fResult = ((UILib as form) as uilib_grimy).ShowTextInput("Adjust Perk Entry Value", perkList[iResult].GetNthEntryValue(iResult2,1)) AS FLOAT
	;			perkList[iResult].SetNthEntryValue(iResult2,1,fResult)
	;		EndIf
	;	EndIf
	EndIf
EndEvent

Bool Function canEditEntry(Perk akPerk, Int i)
	If akPerk.GetNthEntryQuest(i)
		Return False
	ElseIf akPerk.GetNthEntrySpell(i)
		Return False
	ElseIf akPerk.GetNthEntryLeveledList(i)
		Return False
	EndIf
	Return True
EndFunction

String[] Function showPerkEntryList(Perk akPerk)
	String[] returnList = new String[128]
	returnList[0] = "Cancel"
	int i = 1
	int numEntries = akPerk.GetNumEntries()
	While i < numEntries + 1 && i < 128
		If akPerk.GetNthEntryQuest(-1+i)
			returnList[i] = "Quest Entry: Uneditable"
		ElseIf akPerk.GetNthEntrySpell(-1+i)
			returnList[i] = "Spell Entry: Uneditable"
		ElseIf akPerk.GetNthEntryLeveledList(-1+i)
			returnList[i] = "Leveled List Entry: Uneditable"
		Else
			returnList[i] = "Slot " + i + " Entry Value: " + akPerk.GetNthEntryValue(-1+i,1)
		EndIf
		i += 1
	EndWhile
	Return returnList
EndFunction

String[] Function showPerkList(Perk[] perkList)
	String[] returnList = new String[128]
	returnList[0] = "Cancel"
	int i = 1
	int numPerks = perkList.Length
	While i < numPerks + 1 && i < 128
		returnList[i] = perkList[-1+i].GetName()
		i += 1
	EndWhile
	return returnList
EndFunction

string[] Function showAliaslist(ObjectReference akRef)
	string[] aliasList = new string[128]
	aliasList[0] = "Cancel"
	
	int i = 1
	int numRef = akRef.GetNumReferenceAliases() + 1
	while i < numRef + 1 && i < 128
		aliasList[i] = akRef.GetNthReferenceAlias(-1+i).GetName()
		i += 1
	EndWhile
	Return aliasList
EndFunction 