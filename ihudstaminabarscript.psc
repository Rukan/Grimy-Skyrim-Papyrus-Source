Scriptname iHUDStaminaBarScript extends Quest 

import iHUDUtilityScript

GlobalVariable Property iHUDStaminaAlpha Auto
GlobalVariable Property iHUDStaminaFastFade auto


Function processStaminaBar()
	
	setAlpha()
	
	if iHUDStaminaFastFade.GetValueInt() == 1
		show(isStaminaBarNotFull())
	else
		show(true)
	endif
	
EndFunction


Function show(bool isVisible)
	setiHUDBool("_root.HUDMovieBaseInstance.Stamina.StaminaMeter_mc", "_visible", isVisible)
EndFunction


Function setAlpha()
	setiHUDNumber("_root.HUDMovieBaseInstance.Stamina", "_alpha", iHUDStaminaAlpha.GetValue())
EndFunction


bool Function isStaminaBarNotFull()
	return meterNotFull("Stamina.StaminaMeter_mc")
EndFunction

