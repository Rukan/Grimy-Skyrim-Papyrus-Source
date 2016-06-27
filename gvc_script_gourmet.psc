Scriptname GVC_Script_Gourmet extends activemagiceffect  

GLOBALVARIABLE PROPERTY GVC_GastromancyHeal AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	GVC_GastromancyHeal.SetValue(GVC_GastromancyHeal.GetValueInt()+10.0)
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	GVC_GastromancyHeal.SetValue(GVC_GastromancyHeal.GetValueInt()+(-10.0))
ENDEVENT