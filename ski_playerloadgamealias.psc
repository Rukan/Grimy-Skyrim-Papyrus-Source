;/ Decompiled by Champollion V1.0.1
Source   : SKI_PlayerLoadGameAlias.psc
Modified : 2012-11-03 16:59:18
Compiled : 2015-08-18 03:20:44
User     : Sebastian
Computer : SEBASTIAN-PC
/;
scriptName SKI_PlayerLoadGameAlias extends ReferenceAlias

;-- Properties --------------------------------------

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

function OnPlayerLoadGame()

	(self.GetOwningQuest() as ski_questbase).OnGameReload()
endFunction

; Skipped compiler generated GetState
