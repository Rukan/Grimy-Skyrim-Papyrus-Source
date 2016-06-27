Scriptname GSA_BladeOilEffect extends activemagiceffect  

PERK[] PROPERTY bladeOilList AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	bladeOilList[Self.GetDuration() AS INT].SetNthEntryValue(0,0,1.0+Self.GetMagnitude()/100.0)
	akTarget.addPerk(bladeOilList[Self.GetDuration() AS INT])
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.removePerk(bladeOilList[Self.GetDuration() AS INT])
ENDEVENT