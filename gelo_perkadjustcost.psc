Scriptname GELO_PerkAdjustCost extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	akPerk.SetNthEntryValue(0,0,1-self.GetMagnitude()/100)

ENDEVENT

EVENT OnPlayerLoadGame()
	akPerk.SetNthEntryValue(0,0,1-self.GetMagnitude()/100)
ENDEVENT

EVENT OnInit()
	akPerk.SetNthEntryValue(0,0,1-self.GetMagnitude()/100)
ENDEVENT

PERK PROPERTY akPerk AUTO	