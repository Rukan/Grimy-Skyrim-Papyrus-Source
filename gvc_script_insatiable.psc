Scriptname GVC_Script_Insatiable extends activemagiceffect  

GLOBALVARIABLE PROPERTY GVC_GastromancyHeal AUTO
ACTOR PROPERTY PlayerRef AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	GVC_GastromancyHeal.SetValue(GVC_GastromancyHeal.GetValueInt()+20.0)
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	GVC_GastromancyHeal.SetValue(GVC_GastromancyHeal.GetValueInt()+(-20.0))
ENDEVENT

EVENT OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Debug.Notification("Insatiable Detected: " + (akBaseItem AS POTION).IsFood() + " and " + PlayerRef.GetActorValuePercentage("Health"))
	IF (akBaseItem AS POTION).IsFood()
		PlayerRef.EquipItem(akbaseItem,false,true)
	ENDIF
ENDEVENT