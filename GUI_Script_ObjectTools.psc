Scriptname GUI_Script_ObjectTools extends activemagiceffect  

QUEST PROPERTY UILib AUTO
STRING[] PROPERTY StringList AUTO
STRING[] PROPERTY MotionTypeList AUTO
message property GUI_LockQuery auto
Bool Property IsConsoleRef Auto
GUI_MenuMain Property MainMenu Auto
Actor Property PlayerRef Auto

Event OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	OBJECTREFERENCE tempObject
	If IsConsoleRef
		tempObject = Game.GetCurrentConsoleRef()	
	Else
		tempObject = Game.GetCurrentCrosshairRef()
	EndIf
	If tempObject
		Int result = ((UILib as FORM) as UILIB_GRIMY).ShowList(tempObject.GetDisplayName(), stringList, 0, 0)
		
		If result == 1
			String sResult = ((UILib as form) as uilib_grimy).ShowTextInput("Set Name", tempObject.GetDisplayName())
			tempObject.SetDisplayName(sResult)
		ElseIf result == 2
			MainMenu.recordRef(tempObject)
			Float posX = tempObject.GetPositionX()
			Float posY = tempObject.GetPositionY()
			Float posZ = tempObject.GetPositionZ()
			String ResultX = ((UILib as form) as uilib_grimy).ShowTextInput("Set X Position (70 = 1 meter, 21.3 = 1 foot)", posX as String)
			String ResultY = ((UILib as form) as uilib_grimy).ShowTextInput("Set Y Position (70 = 1 meter, 21.3 = 1 foot)", posY as String)
			String ResultZ = ((UILib as form) as uilib_grimy).ShowTextInput("Set Z Position (70 = 1 meter, 21.3 = 1 foot)", posZ as String)
			if ResultX != ""
				posX = ResultX as Float
			endIf
			if ResultY != ""
				posY = ResultY as Float
			endIf
			if ResultZ != ""
				posZ = ResultZ as Float
			endIf
			tempObject.SetPosition(posX, posY, posZ)
		ElseIf result == 3
			MainMenu.undoRef()
		ElseIf result == 4
			Float posX = tempObject.GetAngleX()
			Float posY = tempObject.GetAngleY()
			Float posZ = tempObject.GetAngleZ()
			Float ResultX = ((UILib as form) as uilib_grimy).ShowTextInput("Set X Angle", posX as String) as Float
			Float ResultY = ((UILib as form) as uilib_grimy).ShowTextInput("Set Y Angle", posY as String) as Float
			Float ResultZ = ((UILib as form) as uilib_grimy).ShowTextInput("Set Z Angle", posZ as String) as Float
			tempObject.SetAngle(ResultX, ResultY, ResultZ)
		ElseIf result == 5
			Float scale = tempObject.GetScale()
			Float fResult = ((UILib as form) as uilib_grimy).ShowTextInput("Set Scale", scale as String) as Float
			if fResult == 0.000000
				fResult = scale
			endIf
			tempObject.SetScale(fResult)
			debug.Notification("You may need to pick up and drop this object for the scale to update")
		ElseIf result == 6
			Int iResult = ((UILib as form) as uilib_grimy).ShowList("Motion Type", MotionTypeList, 0, 0) + 1
			tempObject.SetMotionType(iResult, true)
		ElseIf result == 7
			if tempObject.IsActivationBlocked()
				tempObject.BlockActivation(false)
				debug.Notification("This object no longer blocks activation")
			else
				tempObject.BlockActivation(true)
				debug.Notification("This object blocks activation")
			endIf
		ElseIf result == 8
			akCaster.AddItem(tempObject.GetKey() as form, 1, false)
		ElseIf result == 9
			Int index = GUI_LockQuery.Show()
			if index == 0
				Int iResult = ((UILib as form) as uilib_grimy).ShowTextInput("Set Lock Level", tempObject.GetLockLevel() as String) as Int
				tempObject.SetLockLevel(iResult)
				tempObject.Lock(true, true)
			elseIf index == 1
				Int iResult = ((UILib as form) as uilib_grimy).ShowTextInput("Set Lock Level", tempObject.GetLockLevel() as String) as Int
				tempObject.SetLockLevel(iResult)
				tempObject.Lock(true, false)
			else
				tempObject.Lock(false, false)
			endIf
		ElseIf result == 10
			String sResult = ((UILib as form) as uilib_grimy).ShowTextInput("Adjust Tempering", tempObject.GetItemHealthPercent() as String)
			tempObject.SetItemHealthPercent(sResult as Float)
		ElseIf result == 11
			String sResult = ((UILib as form) as uilib_grimy).ShowTextInput("Maximum Charge", tempObject.GetItemMaxCharge() as String)
			tempObject.SetItemMaxCharge(sResult as Float)
		ElseIf result == 12
			Int iResult = ((UILib as form) as uilib_grimy).ShowList("Clear Selected Alias", showAliaslist(tempObject), 0, 0) - 1
			If iResult > -1
				tempObject.GetNthReferenceAlias(iResult).Clear()
			EndIf
		ElseIf Result == 13
			MainMenu.inspectForm(tempObject.GetBaseObject())
		ElseIf Result == 14
			CleanseEnchantment(tempObject)
		EndIf
	EndIf
EndEvent

Function CleanseEnchantment(ObjectReference akRef)
	FORM akForm = akRef.GetBaseObject()
	If akForm As Armor
		If akRef.GetEnchantment()
			akRef.SetEnchantment(None,0.0)
			akRef.Activate(PlayerRef)
			Return
		ElseIf (akForm As Armor).GetEnchantment() && GrimyToolsPluginScript.GetArmorTemplate(akForm As Armor)
			akRef.Delete()
			akRef = None
			PlayerRef.AddItem(GrimyToolsPluginScript.GetArmorTemplate(akForm As Armor))
			Return
		Else
			Debug.Notification("That item cannot have its enchantment removed")
		EndIf
	ElseIf akForm As Weapon
		If akRef.GetEnchantment()
			akRef.SetEnchantment(None,0.0)
			akRef.Activate(PlayerRef)
			Return
		ElseIf (akForm As Weapon).GetEnchantment() && (akForm As Weapon).GetTemplate()
			akRef.Delete()
			PlayerRef.AddItem((akForm As Weapon).GetTemplate())
			akRef = None
			Return
		Else
			Debug.Notification("That item cannot have its enchantment removed")
		EndIf
	Else
		Debug.Notification("That item isn't a weapon or armor.")
	EndIf
EndFunction

string[] Function showAliaslist(ObjectReference akRef)
	string[] aliasList = new string[128]
	aliasList[0] = "Cancel"
	
	int i = 1
	int numRef = akRef.GetNumReferenceAliases() + 1
	while i < numRef
		aliasList[i] = akRef.GetNthReferenceAlias(-1+i).GetName()
		i += 1
	EndWhile
	while i < 128
		aliasList[i] = ""
		i += 1
	EndWhile
	Return aliasList
EndFunction 