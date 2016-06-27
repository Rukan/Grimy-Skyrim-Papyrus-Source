Scriptname iHUDEnemyHealthScript extends Quest 

import iHUDUtilityScript

float iHUDEnemyHealthOrigY
float offset = -5000.0

GlobalVariable Property iHUDEnemyHealthEnabled Auto

bool calibrated

Function calibrate()
	if !calibrated
		iHUDEnemyHealthOrigY = getiHUDNumber("_root.HUDMovieBaseInstance.EnemyHealth_mc", "_y")
		calibrated = true
	endif
EndFunction

Function reset()
	setOriginalY()
	calibrated = false
EndFunction

Function processEnemyHealth()	
	if iHUDEnemyHealthEnabled.GetValueInt() == 1
		setOriginalY()
	elseif iHUDEnemyHealthEnabled.GetValueInt() == 0
		setOffsetY()
	endif
EndFunction

Function setOriginalY()
	if calibrated	
		setiHUDNumber("_root.HUDMovieBaseInstance.EnemyHealth_mc", "_y", iHUDEnemyHealthOrigY)
	endif
EndFunction

Function setOffsetY()
	if !calibrated
		calibrate()
	endif
	
	setiHUDNumber("_root.HUDMovieBaseInstance.EnemyHealth_mc", "_y", iHUDEnemyHealthOrigY + offset)
EndFunction