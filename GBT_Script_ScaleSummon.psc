scriptName GBT_Script_ScaleSummon extends activemagiceffect

globalvariable property GBT_scaleSummon_Float auto
Float akScale

function OnEffectStart(Actor akTarget, Actor akCaster)
	akScale = GBT_scaleSummon_Float.GetValue() - 1.00000
	akTarget.ModActorValue("Health", akScale * akTarget.GetBaseActorValue("Health") + 9999.00)
	akTarget.ModActorValue("Magicka", akScale * akTarget.GetBaseActorValue("Magicka"))
	akTarget.ModActorValue("Stamina", akScale * akTarget.GetBaseActorValue("Stamina"))
	akTarget.ModActorValue("Onehanded", akScale * akTarget.GetBaseActorValue("Onehanded"))
	akTarget.ModActorValue("TwoHanded", akScale * akTarget.GetBaseActorValue("TwoHanded"))
	akTarget.ModActorValue("Marksman", akScale * akTarget.GetBaseActorValue("Marksman"))
	akTarget.ModActorValue("Destruction", akScale * akTarget.GetBaseActorValue("Destruction"))
endFunction 