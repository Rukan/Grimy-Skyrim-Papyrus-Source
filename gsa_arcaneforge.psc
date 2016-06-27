Scriptname GSA_ArcaneForge extends ObjectReference  

LEVELEDITEM PROPERTY Payout AUTO
FORMLIST PROPERTY GSA_ForgeList AUTO
FLOAT value = 0.0
ACTOR PROPERTY PlayerRef AUTO
GLOBALVARIABLE PROPERTY GSA_ArcaneExp AUTO

EVENT OnItemAdded(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	IF GSA_ForgeList.HasForm(akBaseItem)
		value += aiItemCount * (0.05 + akBaseItem.GetGoldValue() / 1000.0 )
		Self.RemoveItem(akbaseItem,aiitemCount,true)
		GoToState("GiveLoot")
	ELSE
		Debug.Notification("This forge requires ingots or leather")
		Self.RemoveItem(akbaseItem,aiitemCount,true,akSourceContainer)
	ENDIF
ENDEVENT

STATE GiveLoot
	EVENT OnBeginState()
		WHILE	value >= 1.0
			value -= 1.0
			PlayerRef.Additem(Payout,1)
		ENDWHILE
		GoToState("")
	ENDEVENT

	EVENT OnItemAdded(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
		Debug.Notification("Busy crafting items")
		Game.AdvanceSkill("Smithing",GSA_ArcaneExp.GetValue())
		Self.RemoveItem(akbaseItem,aiitemCount,true,akSourceContainer)
	ENDEVENT
ENDSTATE