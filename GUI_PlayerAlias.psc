scriptName GUI_PlayerAlias extends ReferenceAlias

gui_menumain property Main_Menu auto

Event OnPlayerLoadGame()
	Main_Menu.loadhotKeys()
EndEvent