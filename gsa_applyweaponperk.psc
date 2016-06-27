Scriptname GSA_ApplyWeaponPerk extends activemagiceffect  

PERK[] PROPERTY PerkList AUTO
ACTOR PROPERTY PlayerRef AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	PerkList[GetDuration() AS INT].SetNthEntryValue(0,0,GetMagnitude())
	PlayerRef.AddPerk(PerkList[GetDuration() AS INT])
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	PlayerRef.RemovePerk(PerkList[GetDuration() AS INT])
ENDEVENT