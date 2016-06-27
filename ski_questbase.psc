;/ Decompiled by Champollion V1.0.1
Source   : SKI_QuestBase.psc
Modified : 2013-03-06 08:33:50
Compiled : 2015-08-18 03:20:44
User     : Sebastian
Computer : SEBASTIAN-PC
/;
scriptName SKI_QuestBase extends Quest hidden

;-- Properties --------------------------------------
Int property CurrentVersion auto hidden

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

function OnGameReload()

	; Empty function
endFunction

function OnVersionUpdateBase(Int a_version)

	; Empty function
endFunction

function OnVersionUpdate(Int a_version)

	; Empty function
endFunction

function CheckVersion()

	Int version = self.GetVersion()
	if CurrentVersion < version
		self.OnVersionUpdateBase(version)
		self.OnVersionUpdate(version)
		CurrentVersion = version
	endIf
endFunction

Int function GetVersion()

	return 1
endFunction

; Skipped compiler generated GotoState
