Scriptname GVC_Script_RapidCatalysis extends activemagiceffect  

GLOBALVARIABLE PROPERTY GVC_Base_Cooldown AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	GVC_Base_Cooldown.SetValue(GVC_Base_Cooldown.GetValue()/2)
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	GVC_Base_Cooldown.SetValue(GVC_Base_Cooldown.GetValue()*2)
ENDEVENT