scriptName GrimyMenuMainPlayerRef extends ReferenceAlias

grimymenumain property Main_Menu auto

Event OnInit()
	Main_Menu.RegisterEverything()
	Main_Menu.importSettings()
EndEvent

event OnPlayerLoadGame()
	(GetOwningQuest() as SKI_QuestBase).OnGameReload()
	Main_Menu.RegisterEverything()
	Main_Menu.importSettings()
EndEvent 