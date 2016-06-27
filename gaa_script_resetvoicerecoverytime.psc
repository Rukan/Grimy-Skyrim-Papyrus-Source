Scriptname GAA_Script_ResetVoiceRecoveryTime extends ActiveMagicEffect  

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	akCaster.SetVoiceRecoveryTime(0.0)
ENDEVENT