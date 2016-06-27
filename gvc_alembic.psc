Scriptname GVC_Alembic extends ObjectReference  

ACTOR PROPERTY PlayerRef AUTO
OBJECTREFERENCE PROPERTY ExtractionBench AUTO
OBJECTREFERENCE PROPERTY GrenadesBench AUTO
OBJECTREFERENCE PROPERTY ArrowsBench AUTO
;MESSAGE PROPERTY GVCCraftMessageToolkit AUTO
STRING[] PROPERTY stringList AUTO
QUEST PROPERTY UILib AUTO

EVENT OnEquipped(ACTOR akActor)
	IF akActor == PlayerRef
		Utility.Wait(0.1)
		;int choice = GVCCraftMessageToolkit.Show()
		int choice = ((UILib AS FORM) AS UILIB_GRIMY).ShowList("What would you like to do?",stringList,0,0) AS INT
		IF choice == 0
			ExtractionBench.Activate(PlayerRef)
		ELSEIF choice == 1
			GrenadesBench.Activate(PlayerRef)
		ELSEIF choice == 2
			ArrowsBench.Activate(PlayerRef)
		ENDIF
		;GoToState("Waiting")
	ENDIF
ENDEVENT