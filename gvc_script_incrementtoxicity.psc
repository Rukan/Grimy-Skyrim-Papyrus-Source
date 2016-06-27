Scriptname GVC_Script_IncrementToxicity extends activemagiceffect  

GLOBALVARIABLE PROPERTY GVC_MaxToxicity AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	GVC_MaxToxicity.SetValueInt(GVC_MaxToxicity.GetValueInt()+1)
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	GVC_MaxToxicity.SetValueInt(GVC_MaxToxicity.GetValueInt()+(-1))
ENDEVENT