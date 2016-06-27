Scriptname iHUDCrosshairScript extends Quest 

import iHUDUtilityScript

GlobalVariable Property iHUDSneakMeterEnabled Auto
GlobalVariable Property iHUDCrosshairAlpha Auto
GlobalVariable Property iHUDForceCrosshairEnabled Auto

bool isVisible
float currentAlpha
float sneakMeterAlphaOverride

float originalCrosshairInstanceY
float originalCrosshairAlertY
bool calibrated = false

float offset = -5000.0

Function calibrate()
	originalCrosshairInstanceY = getiHUDNumber("_root.HUDMovieBaseInstance.CrosshairInstance", "_y")
	originalCrosshairAlertY = getiHUDNumber("_root.HUDMovieBaseInstance.CrosshairAlert", "_y")
	
	calibrated = true
EndFunction

Function setOriginalY()
	 setiHUDNumber("_root.HUDMovieBaseInstance.CrosshairInstance", "_y", originalCrosshairInstanceY)
	 setiHUDNumber("_root.HUDMovieBaseInstance.CrosshairAlert", "_y", originalCrosshairAlertY)
EndFunction

Function setOffsetY()
	 setiHUDNumber("_root.HUDMovieBaseInstance.CrosshairInstance", "_y", originalCrosshairInstanceY + offset)
	 setiHUDNumber("_root.HUDMovieBaseInstance.CrosshairAlert", "_y", originalCrosshairAlertY + offset)
EndFunction

Function show(bool visible)
	isVisible = visible
	
	currentAlpha = calculateAlpha(isVisible)
	sneakMeterAlphaOverride = calculateAlpha(isStealthMeterVisible())
	
	processCrosshair()
	processStealthMeter(sneakMeterAlphaOverride)
EndFunction

Function showSneakMeter()
	processStealthMeter(calculateAlpha(true))
EndFunction

Function processCrosshair()	
	bool showCrosshair = isVisible && !isStealthMeterVisible()

	if iHUDForceCrosshairEnabled.GetValueInt() == 1 
		moveCrosshair(showCrosshair)
	elseif calibrated
		setOriginalY()
		calibrated = false
	endif
		
	setiHUDBool("_root.HUDMovieBaseInstance.CrosshairInstance", "_visible", showCrosshair)
	setiHUDBool("_root.HUDMovieBaseInstance.CrosshairAlert", "_visible", showCrosshair)
	
	setiHUDNumber("_root.HUDMovieBaseInstance.CrosshairInstance", "_alpha", currentAlpha)
	setiHUDNumber("_root.HUDMovieBaseInstance.CrosshairAlert", "_alpha", currentAlpha)

EndFunction

Function moveCrosshair(bool showCrosshair)
	if !calibrated
		calibrate()
	endif
	
	if showCrosshair
		setOriginalY()
	else
		setOffsetY()
	endif
EndFunction

Function processStealthMeter(float alpha)
	setiHUDNumber("_root.HUDMovieBaseInstance.StealthMeterInstance", "_alpha", alpha)
EndFunction

bool Function isStealthMeterVisible()
	return iHUDSneakMeterEnabled.GetValueInt() == 1 && Game.GetPlayer().isSneaking()
EndFunction

float Function calculateAlpha(bool visible)
	return calculateBaseHUDAlpha(visible, iHUDCrosshairAlpha.getValue())
EndFUnction