Scriptname GAA_Script_Hemotoxin extends activemagiceffect  

POTION PROPERTY GVC_Hemotoxin AUTO
FORM PROPERTY GVC_Toxicity_Count AUTO
OBJECTREFERENCE PROPERTY GVC_Toxicity_Count_Container AUTO

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	INT toxicity = GVC_Toxicity_Count_Container.GetItemCount(GVC_Toxicity_Count)
	GVC_Hemotoxin.SetNthEffectMagnitude(0,7.5*toxicity)
	GVC_Hemotoxin.SetNthEffectMagnitude(0,0.1*toxicity)
	akCaster.DamageAV("Health",20.0)
	akCaster.EquipItem(GVC_Hemotoxin, false, true)
ENDEVENT