Scriptname iHUDCompassScript extends Quest  

import iHUDUtilityScript

GlobalVariable Property iHUDCompassAlpha Auto
GlobalVariable Property iHUDShoutMeterHide Auto

bool isVisible
float currentAlpha

Function show(bool visible)
	isVisible = visible
	
	currentAlpha = calculateAlpha(isVisible)
	
	processCompass()
	processFloatingQuestMarker()
EndFunction

Function processCompass()
	if iHUDShoutMeterHide.GetValueInt() == 0
		setiHUDNumber("_root.HUDMovieBaseInstance.CompassShoutMeterHolder", "_alpha", iHUDCompassAlpha.getValue())
	else
		setiHUDNumber("_root.HUDMovieBaseInstance.CompassShoutMeterHolder", "_alpha", currentAlpha)
	endif
	
	setiHUDNumber("_root.HUDMovieBaseInstance.CompassShoutMeterHolder.Compass.DirectionRect", "_alpha", currentAlpha)
	setiHUDNumber("_root.HUDMovieBaseInstance.CompassShoutMeterHolder.Compass.CompassFrame", "_alpha", currentAlpha)
EndFunction

Function processFloatingQuestMarker()
	setiHUDNumber("_root.HUDMovieBaseInstance.FloatingQuestMarker_mc", "_alpha", currentAlpha)
EndFunction

float Function calculateAlpha(bool visible)
	return calculateBaseHUDAlpha(visible, iHUDCompassAlpha.getValue())
EndFUnction