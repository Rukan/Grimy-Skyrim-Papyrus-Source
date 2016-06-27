Scriptname GrimyMagicAddTeleports extends activemagiceffect  

Spell property GrimyTeleportDawnstar auto
Spell property GrimyTeleportFalkreath auto
Spell property GrimyTeleportMarkarth auto
Spell property GrimyTeleportMorthal auto
Spell property GrimyTeleportRiften auto
Spell property GrimyTeleportSolitude auto
Spell property GrimyTeleportWhiterun auto
Spell property GrimyTeleportWindhelm auto
Spell property GrimyTeleportWinterhold auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akCaster.AddSpell(GrimyTeleportDawnstar, false)
	akCaster.AddSpell(GrimyTeleportFalkreath, false)
	akCaster.AddSpell(GrimyTeleportMarkarth, false)
	akCaster.AddSpell(GrimyTeleportMorthal, false)
	akCaster.AddSpell(GrimyTeleportRiften, false)
	akCaster.AddSpell(GrimyTeleportSolitude, false)
	akCaster.AddSpell(GrimyTeleportWhiterun, false)
	akCaster.AddSpell(GrimyTeleportWindhelm, false)
	akCaster.AddSpell(GrimyTeleportWinterhold, false)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akCaster.RemoveSpell(GrimyTeleportDawnstar)
	akCaster.RemoveSpell(GrimyTeleportFalkreath)
	akCaster.RemoveSpell(GrimyTeleportMarkarth)
	akCaster.RemoveSpell(GrimyTeleportMorthal)
	akCaster.RemoveSpell(GrimyTeleportRiften)
	akCaster.RemoveSpell(GrimyTeleportSolitude)
	akCaster.RemoveSpell(GrimyTeleportWhiterun)
	akCaster.RemoveSpell(GrimyTeleportWindhelm)
	akCaster.RemoveSpell(GrimyTeleportWinterhold)
EndEvent