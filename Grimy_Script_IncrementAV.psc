Scriptname Grimy_Script_IncrementAV extends activemagiceffect  

String Property AV1 Auto
String Property AV2 Auto
Float akMag

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akMag = GetMagnitude()/100.0
	akTarget.ModActorValue(AV1,akMag)
	akTarget.ModActorValue(AV2,akMag)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.ModActorValue(AV1,-akMag)
	akTarget.ModActorValue(AV2,-akMag)
EndEvent