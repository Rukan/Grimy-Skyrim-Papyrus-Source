scriptName GUI_Script_SneakToggle extends activemagiceffect

GUI_MenuMain Property MenuMain auto
actor property PlayerRef auto
Import Game
Import Utility

Event OnPlayerLoadGame()
	RegisterForKey(MenuMain.GUI_Hotkey_SneakToggle)
EndEvent

Event OnKeyUp(Int KeyCode, Float HoldTime)
	if PlayerRef.IsSneaking() && IsLookingControlsEnabled() && !IsInMenuMode()
		PlayerRef.StartSneaking()
	endIf
EndEvent

Event OnEffectStart(actor akTarget, actor akCaster)
	RegisterForKey(MenuMain.GUI_Hotkey_SneakToggle)
EndEvent

Event OnKeyDown(Int KeyCode)
	if !PlayerRef.IsSneaking() && IsLookingControlsEnabled() && !IsInMenuMode()
		PlayerRef.StartSneaking()
	endIf
EndEvent
