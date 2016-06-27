Scriptname GLD_Script_LocationalDamage extends activemagiceffect  

Import GrimyToolsPluginScript
Import Math

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Float startTime = Utility.GetCurrentRealTime()
	;Float deltaZ = GetRayTraceZ(Game.Getplayer(),akTarget,akTarget.GetWidth())
	;Debug.Notification("Target: " + akTarget.GetDisplayName() + " height delta: " + deltaZ + " Execution Time: " + (Utility.GetCurrentRealTime() - startTime))
	
	float distance = sqrt(pow(akTarget.GetPositionX() - Game.GetPlayer().GetPositionX(),2.0) + pow(akTarget.GetPositionY() - Game.GetPlayer().GetPositionY(),2.0))
	If (akTarget.GetWidth() < distance)
		distance -= akTarget.GetWidth()
	Else
		distance = 0
	EndIf
	Float deltaZ = Game.GetPlayer().GetPositionZ() - akTarget.GetPositionZ() + distance * Tan(-Game.GetPlayer().GetAngleX())
	
	Debug.Notification("Target: " + akTarget.GetDisplayName() + " height delta: " + deltaZ + " Execution Time: " + (Utility.GetCurrentRealTime() - startTime))
EndEvent 