scriptName GBT_Script_Monitor_EnableOnHit extends activemagiceffect

spell property GBT_abEnableOnHit_NPC auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	GBT_abEnableOnHit_NPC.Cast(akTarget, akTarget)
EndEvent