Scriptname KRY_QD_PlayerAliasScript extends ReferenceAlias  

event OnPlayerLoadGame()
	(GetOwningQuest() as SKI_QuestBase).OnGameReload()
endEvent

