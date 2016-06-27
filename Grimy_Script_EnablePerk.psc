Scriptname Grimy_Script_EnablePerk extends activemagiceffect  

PERK PROPERTY akPerk AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.AddPerk(akPerk)
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.RemovePerk(akPerk)
ENDEVENT