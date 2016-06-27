Scriptname iHUDHealthBarScript extends Quest 

import iHUDUtilityScript

GlobalVariable Property iHUDHealthAlpha Auto
GlobalVariable Property iHUDHealthFastFade auto


Function processHealthBar()

	setAlpha()

	if iHUDHealthFastFade.GetValueInt() == 1
		show(isHealthBarNotFull())
	else 
		show(true)
	endif

EndFunction


Function show(bool isVisible)
	setiHUDBool("_root.HUDMovieBaseInstance.Health.HealthMeter_mc", "_visible", isVisible)
EndFunction


Function setAlpha()
	setiHUDNumber("_root.HUDMovieBaseInstance.Health", "_alpha", iHUDHealthAlpha.GetValue())
EndFunction


bool Function isHealthBarNotFull()
	return meterNotFull("Health.HealthMeter_mc.HealthLeft")
EndFunction
