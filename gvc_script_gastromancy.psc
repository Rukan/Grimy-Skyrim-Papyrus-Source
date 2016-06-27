Scriptname GVC_Script_Gastromancy extends activemagiceffect  

SPELL PROPERTY GVC_AB_GastromancyHealth AUTO
ACTOR target
FLOAT oldHealthBonus

EVENT OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	IF (akBaseObject AS POTION).IsFood()
		PlayerRef.RestoreActorValue("Health",GVC_GastromancyHeal.GetValue())
	ENDIF
ENDEVENT

EVENT OnPlayerLoadGame()
	GVC_AB_GastromancyHealth.SetNthEffectMagnitude(0,oldHealthBonus)
	RegisterForMenu("LevelUp Menu")
ENDEVENT

EVENT OnEffectStart (ACTOR akTarget, ACTOR akCaster)
	RegisterForMenu("LevelUp Menu")
	target = akTarget
	oldHealthBonus = 5.0 * akTarget.GetLevel()
	IF oldHealthBonus > 500.0
		oldHealthBonus = 500.0
	ENDIF
	Debug.Notification("Gastromancy: " + oldHealthBonus)
	GVC_AB_GastromancyHealth.SetNthEffectMagnitude(0,oldHealthBonus)
	akTarget.AddSpell(GVC_AB_GastromancyHealth,false)
ENDEVENT

EVENT OnEffectFinish(ACTOR akTarget, ACTOR akCaster)
	GVC_AB_GastromancyHealth.SetNthEffectMagnitude(0,oldHealthBonus)
	akTarget.RemoveSpell(GVC_AB_GastromancyHealth)
ENDEVENT

EVENT OnMenuOpen(STRING MenuName)
	target.RemoveSpell(GVC_AB_GastromancyHealth)
	oldHealthBonus = 5.0 * target.GetLevel()
	IF oldHealthBonus > 500.0
		oldHealthBonus = 500.0
	ENDIF
	GVC_AB_GastromancyHealth.SetNthEffectMagnitude(0,oldHealthBonus)
	target.AddSpell(GVC_AB_GastromancyHealth,false)
ENDEVENT

ACTOR PROPERTY PlayerRef AUTO
GLOBALVARIABLE PROPERTY GVC_GastromancyHeal AUTO