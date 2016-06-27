;/ Decompiled by Champollion V1.0.1
Source   : UILIB_1.psc
Modified : 2014-08-20 11:16:49
Compiled : 2015-05-02 11:41:25
User     : Rukan
Computer : RUKAN-PC
/;
scriptName UILIB_1 extends Form
{SkyUILib API - Version 1}

;-- Properties --------------------------------------

;-- Variables ---------------------------------------
String sInput
Bool bMenuOpen
String sInitialText
String sTitle
Int iStartIndex
Int iDefaultIndex
String[] sOptions
Int iInput

;-- Functions ---------------------------------------

function ListMenu_SetData(String asTitle, String[] asOptions, Int aiStartIndex, Int aiDefaultIndex) global

	ui.InvokeNumber("CustomMenu", "_root.listDialog.setPlatform", (game.UsingGamepad() as Int) as Float)
	ui.InvokeStringA("CustomMenu", "_root.listDialog.initListData", asOptions)
	Int iHandle = uicallback.Create("CustomMenu", "_root.listDialog.initListParams")
	if iHandle
		uicallback.PushString(iHandle, asTitle)
		uicallback.PushInt(iHandle, aiStartIndex)
		uicallback.PushInt(iHandle, aiDefaultIndex)
		uicallback.Send(iHandle)
	endIf
endFunction

function TextInputMenu_Release(Form akClient) global

	akClient.UnregisterForModEvent("UILIB_1_textInputOpen")
	akClient.UnregisterForModEvent("UILIB_1_textInputClose")
endFunction

function TextInputMenu_SetData(String asTitle, String asInitialText) global

	ui.InvokeNumber("CustomMenu", "_root.textInputDialog.setPlatform", (game.UsingGamepad() as Int) as Float)
	String[] sData = new String[2]
	sData[0] = asTitle
	sData[1] = asInitialText
	ui.InvokeStringA("CustomMenu", "_root.textInputDialog.initData", sData)
endFunction

Bool function NotificationMenu_PrepareArea() global

	Int iVersion = ui.GetInt("HUD Menu", "_global.uilib_1.NotificationArea.UILIB_VERSION")
	if iVersion == 0
		Int iHandle = uicallback.Create("HUD Menu", "_root.HUDMovieBaseInstance.createEmptyMovieClip")
		if !iHandle
			return false
		endIf
		uicallback.PushString(iHandle, "uilib_1_notificationAreaContainer")
		uicallback.PushInt(iHandle, -16380)
		if !uicallback.Send(iHandle)
			return false
		endIf
		ui.InvokeString("HUD Menu", "_root.HUDMovieBaseInstance.uilib_1_notificationAreaContainer.loadMovie", "uilib/uilib_1_notificationarea.swf")
		utility.Wait(0.500000)
		iVersion = ui.GetInt("HUD Menu", "_global.uilib_1.NotificationArea.UILIB_VERSION")
		if iVersion == 0
			ui.InvokeString("HUD Menu", "_root.HUDMovieBaseInstance.uilib_1_notificationAreaContainer.loadMovie", "exported/uilib/uilib_1_notificationarea.swf")
			utility.Wait(0.500000)
			iVersion = ui.GetInt("HUD Menu", "_global.uilib_1.NotificationArea.UILIB_VERSION")
			if iVersion == 0
				debug.Trace("===== UILib: Notification injection failed =====", 0)
				return false
			endIf
			ui.InvokeString("HUD Menu", "_root.HUDMovieBaseInstance.uilib_1_notificationAreaContainer.SetRootPath", "exported/")
		endIf
	endIf
	return true
endFunction

function TextInputMenu_Open(Form akClient) global

	akClient.RegisterForModEvent("UILIB_1_textInputOpen", "OnTextInputOpen")
	akClient.RegisterForModEvent("UILIB_1_textInputClose", "OnTextInputClose")
	ui.OpenCustomMenu("uilib/uilib_1_textinputmenu", 0)
endFunction

function ListMenu_Open(Form akClient) global

	akClient.RegisterForModEvent("UILIB_1_listMenuOpen", "OnListMenuOpen")
	akClient.RegisterForModEvent("UILIB_1_listMenuClose", "OnListMenuClose")
	ui.OpenCustomMenu("uilib/uilib_1_listmenu", 0)
endFunction

function ListMenu_Release(Form akClient) global

	akClient.UnregisterForModEvent("UILIB_1_listMenuOpen")
	akClient.UnregisterForModEvent("UILIB_1_listMenuClose")
endFunction

function OnListMenuClose(String asEventName, String asStringArg, Float afInput, Form akSender)

	if asEventName == "UILIB_1_listMenuClose"
		iInput = afInput as Int
		bMenuOpen = false
	endIf
endFunction

function OnTextInputClose(String asEventName, String asInput, Float afCancelled, Form akSender)

	if asEventName == "UILIB_1_textInputClose"
		if afCancelled as Bool
			sInput = ""
		else
			sInput = asInput
		endIf
		bMenuOpen = false
	endIf
endFunction

function ShowNotificationIcon(String asMessage, String asIconPath, Int aiIconFrame, String asColor)

	if !UILIB_1.NotificationMenu_PrepareArea()
		return 
	endIf
	Int iHandle = uicallback.Create("HUD Menu", "_root.HUDMovieBaseInstance.uilib_1_notificationAreaContainer.notificationArea.ShowIconMessage")
	if iHandle
		uicallback.PushString(iHandle, asMessage)
		uicallback.PushString(iHandle, asColor)
		uicallback.PushString(iHandle, asIconPath)
		uicallback.PushInt(iHandle, aiIconFrame)
		uicallback.Send(iHandle)
	endIf
endFunction

function ShowNotification(String asMessage, String asColor)

	if !UILIB_1.NotificationMenu_PrepareArea()
		return 
	endIf
	Int iHandle = uicallback.Create("HUD Menu", "_root.HUDMovieBaseInstance.uilib_1_notificationAreaContainer.notificationArea.ShowMessage")
	if iHandle
		uicallback.PushString(iHandle, asMessage)
		uicallback.PushString(iHandle, asColor)
		uicallback.Send(iHandle)
	endIf
endFunction

String function ShowTextInput(String asTitle, String asInitialText)

	if bMenuOpen
		return ""
	endIf
	bMenuOpen = true
	sInput = ""
	sTitle = asTitle
	sInitialText = asInitialText
	UILIB_1.TextInputMenu_Open(self as Form)
	while bMenuOpen
		utility.WaitMenuMode(0.100000)
	endWhile
	UILIB_1.TextInputMenu_Release(self as Form)
	return sInput
endFunction

function OnTextInputOpen(String asEventName, String asStringArg, Float afNumArg, Form akSender)

	if asEventName == "UILIB_1_textInputOpen"
		UILIB_1.TextInputMenu_SetData(sTitle, sInitialText)
	endIf
endFunction

; Skipped compiler generated GotoState

function OnListMenuOpen(String asEventName, String asStringArg, Float afNumArg, Form akSender)

	if asEventName == "UILIB_1_listMenuOpen"
		UILIB_1.ListMenu_SetData(sTitle, sOptions, iStartIndex, iDefaultIndex)
	endIf
endFunction

Int function ShowList(String asTitle, String[] asOptions, Int aiStartIndex, Int aiDefaultIndex)

	if bMenuOpen
		return -1
	endIf
	bMenuOpen = true
	iInput = -1
	sTitle = asTitle
	sOptions = asOptions
	iStartIndex = aiStartIndex
	iDefaultIndex = aiDefaultIndex
	UILIB_1.ListMenu_Open(self as Form)
	while bMenuOpen
		utility.WaitMenuMode(0.100000)
	endWhile
	UILIB_1.ListMenu_Release(self as Form)
	return iInput
endFunction

; Skipped compiler generated GetState
