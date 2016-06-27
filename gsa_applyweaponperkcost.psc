Scriptname GSA_ApplyWeaponPerkCost extends activemagiceffect  

PERK[] PROPERTY PerkList AUTO
ACTOR PROPERTY PlayerRef AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	PerkList[GetDuration() AS INT].SetNthEntryValue(0,0,1.0-GetMagnitude()/100.0)
	PlayerRef.AddPerk(PerkList[GetDuration() AS INT])
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	PlayerRef.RemovePerk(PerkList[GetDuration() AS INT])
ENDEVENT