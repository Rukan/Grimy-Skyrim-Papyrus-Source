scriptName GUI_Script_SubtitleToggle extends activemagiceffect

GUI_MenuMain Property MenuMain auto
message property GUI_GeneralSubtitlesOn auto
actor property PlayerRef auto
message property GUI_GeneralSubtitlesOff auto
import Game
import Utility

Event OnKeyDown(Int KeyCode)
	if IsLookingControlsEnabled() && !IsInMenuMode()
		SetINIBool("bGeneralSubtitles:Interface", !GetINIBool("bGeneralSubtitles:Interface"))
		if GetINIBool("bGeneralSubtitles:Interface")
			SetINIBool("bDialogueSubtitles:Interface", true)
			GUI_GeneralSubtitlesOn.Show()
		else
			SetINIBool("bDialogueSubtitles:Interface", true)
			GUI_GeneralSubtitlesOff.Show()
		endIf
	endIf
EndEvent

Event OnEffectStart(actor akTarget, actor akCaster)
	RegisterForKey(MenuMain.GUI_Hotkey_SubtitleToggle)
EndEvent

Event OnPlayerLoadGame()
	RegisterForKey(MenuMain.GUI_Hotkey_SubtitleToggle)
EndEvent
