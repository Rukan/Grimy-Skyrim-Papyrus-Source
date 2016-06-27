Scriptname GUI_Script_MarkActor extends activemagiceffect  

GUI_MenuMain PROPERTY MenuMain AUTO
QUEST PROPERTY UILib AUTO
STRING[] PROPERTY StringList AUTO

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	INT iResult = ((UILib as FORM) as UILIB_GRIMY).ShowList("What would you like to do?", StringList, 0, 0)
	IF iResult == 0
		OBJECTREFERENCE tempRef = Game.GetCurrentCrosshairRef()
		MenuMain.addToObjectList( ((UILib as FORM) as UILIB_GRIMY).ShowList("Select a slot", MenuMain.getObjectListString(), 0, 0), tempRef)
	ELSEIF iResult == 1
		OBJECTREFERENCE tempRef = Game.GetCurrentConsoleRef()
		MenuMain.addToObjectList( ((UILib as FORM) as UILIB_GRIMY).ShowList("Select a slot", MenuMain.getObjectListString(), 0, 0), tempRef)
	ELSEIF iResult == 2
		iResult = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select a mark", MenuMain.getObjectListString(), 0, 0)
		MenuMain.objectList[iResult].MoveTo(akCaster)
	ELSEIF iResult == 3
		iResult = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select a mark", MenuMain.getObjectListString(), 0, 0)
		akCaster.MoveTo(MenuMain.objectList[iResult])
	ELSEIF iResult == 4
		iResult = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select a mark", MenuMain.getObjectListString(), 0, 0)
		MenuMain.objectList[iResult].Activate(akCaster)
	ELSEIF iResult == 5
		iResult = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select a mark", MenuMain.getObjectListString(), 0, 0)
		akCaster.PlaceAtMe(MenuMain.objectList[iResult].GetBaseObject())
	ELSEIF iResult == 6
		iResult = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select a slot", MenuMain.getObjectListString(), 0, 0)
		MenuMain.objectList[iResult] = NONE
	ENDIF
ENDEVENT