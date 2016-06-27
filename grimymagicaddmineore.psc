Scriptname GrimyMagicAddMineOre extends activemagiceffect  

SPELL PROPERTY GrimyPerkSpellMineOre AUTO
FORMLIST PROPERTY mineOreToolsList AUTO
FORM PROPERTY GrimyMagicSpellMineOre AUTO

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akCaster.AddSpell(GrimyPerkSpellMineOre, false)
	IF !mineOreToolsList.HasForm(GrimyPerkSpellMineOre)
		mineOreToolsList.AddForm(GrimyPerkSpellMineOre)
	ENDIF
	IF !mineOreToolsList.HasForm(GrimyMagicSpellMineOre)
		mineOreToolsList.AddForm(GrimyMagicSpellMineOre)
	ENDIF
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akCaster.RemoveSpell(GrimyPerkSpellMineOre)
	IF mineOreToolsList.HasForm(GrimyPerkSpellMineOre)
		mineOreToolsList.RemoveAddedForm(GrimyPerkSpellMineOre)
	ENDIF
	IF mineOreToolsList.HasForm(GrimyMagicSpellMineOre)
		mineOreToolsList.RemoveAddedForm(GrimyMagicSpellMineOre)
	ENDIF
EndEvent