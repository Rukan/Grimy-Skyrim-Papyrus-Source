Scriptname GVC_Hotkey_Reset extends activemagiceffect  

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	PlayerRef.RemoveSpell(GVC_AB_Hotkey)
	Utility.Wait(0.1)
	PlayerRef.AddSpell(GVC_AB_Hotkey, false)
ENDEVENT

ACTOR PROPERTY PlayerRef AUTO
SPELL PROPERTY GVC_AB_Hotkey AUTO