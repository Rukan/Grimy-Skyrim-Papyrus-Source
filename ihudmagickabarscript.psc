Scriptname iHUDMagickaBarScript extends Quest 

import iHUDUtilityScript

GlobalVariable Property iHUDMagickaAlpha Auto
GlobalVariable Property iHUDMagickaFastFade auto


Function processMagickaBar()

	setAlpha()

	if iHUDMagickaFastFade.GetValueInt() == 1
		show(isMagickaBarNotFull())
	else
		show(true)
	endif
	
EndFunction


Function show(bool isVisible)
	setiHUDBool("_root.HUDMovieBaseInstance.Magica.MagickaMeter_mc", "_visible", isVisible)
EndFunction


Function setAlpha()
	setiHUDNumber("_root.HUDMovieBaseInstance.Magica", "_alpha", iHUDMagickaAlpha.GetValue())
EndFunction


bool Function isMagickaBarNotFull()
	return meterNotFull("Magica.MagickaMeter_mc")
EndFunction