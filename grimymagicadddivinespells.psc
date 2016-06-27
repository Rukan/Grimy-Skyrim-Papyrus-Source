Scriptname GrimyMagicAddDivineSpells extends activemagiceffect  

Spell property GrimyAkatoshSpell auto
Spell property GrimyArkaySpell auto
Spell property GrimyDibellaSpell auto
Spell property GrimyJulianosSpell auto
Spell property GrimyKynarethSpell auto
Spell property GrimyMaraSpell auto
Spell property GrimyStendarrSpell auto
Spell property GrimyTalosSpell auto
Spell property GrimyZenitharSpell auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akCaster.AddSpell(GrimyAkatoshSpell, false)
	akCaster.AddSpell(GrimyArkaySpell, false)
	akCaster.AddSpell(GrimyDibellaSpell, false)
	akCaster.AddSpell(GrimyJulianosSpell, false)
	akCaster.AddSpell(GrimyKynarethSpell, false)
	akCaster.AddSpell(GrimyMaraSpell, false)
	akCaster.AddSpell(GrimyStendarrSpell, false)
	akCaster.AddSpell(GrimyTalosSpell, false)
	akCaster.AddSpell(GrimyZenitharSpell, false)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akCaster.RemoveSpell(GrimyAkatoshSpell)
	akCaster.RemoveSpell(GrimyArkaySpell)
	akCaster.RemoveSpell(GrimyDibellaSpell)
	akCaster.RemoveSpell(GrimyJulianosSpell)
	akCaster.RemoveSpell(GrimyKynarethSpell)
	akCaster.RemoveSpell(GrimyMaraSpell)
	akCaster.RemoveSpell(GrimyStendarrSpell)
	akCaster.RemoveSpell(GrimyTalosSpell)
	akCaster.RemoveSpell(GrimyZenitharSpell)
EndEvent