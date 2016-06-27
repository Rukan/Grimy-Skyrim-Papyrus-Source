Scriptname GELO_EnchantSelf extends ActiveMagicEffect  

GELO_IdentifyUtil PROPERTY IdentifyUtil AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	IdentifyUtil.IdentifyCrosshairRef()
ENDEVENT 