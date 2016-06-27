Scriptname GELO_Whisperer extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	updateShouts()
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	ThrowVoiceShout.SetNthRecoveryTime(0,5.0)
	ThrowVoiceShout.SetNthRecoveryTime(1,10.0)
	ThrowVoiceShout.SetNthRecoveryTime(2,15.0)
	AuraWhisperShout.SetNthRecoveryTime(0,30.0)
	AuraWhisperShout.SetNthRecoveryTime(1,40.0)
	AuraWhisperShout.SetNthRecoveryTime(2,50.0)
ENDEVENT

EVENT OnPlayerLoadGame()
	updateShouts()
ENDEVENT

FUNCTION updateShouts()
	ThrowVoiceShout.SetNthRecoveryTime(0,1.0)
	ThrowVoiceShout.SetNthRecoveryTime(1,2.0)
	ThrowVoiceShout.SetNthRecoveryTime(2,3.0)
	AuraWhisperShout.SetNthRecoveryTime(0,3.0)
	AuraWhisperShout.SetNthRecoveryTime(1,4.0)
	AuraWhisperShout.SetNthRecoveryTime(2,5.0)
ENDFUNCTION

SHOUT PROPERTY AuraWhisperShout AUTO
SHOUT PROPERTY ThrowVoiceShout AUTO