Scriptname GSA_SmithingKit extends ObjectReference  

ACTOR PROPERTY PlayerRef AUTO
OBJECTREFERENCE PROPERTY ExtractionBench AUTO
OBJECTREFERENCE PROPERTY UpgradeBench AUTO
OBJECTREFERENCE PROPERTY WeaponForge AUTO
OBJECTREFERENCE PROPERTY ArmorForge AUTO
OBJECTREFERENCE PROPERTY JewelryForge AUTO
;MESSAGE PROPERTY GSACraftMessageToolkit AUTO
PERK PROPERTY GSA_Perk_Salvage AUTO
PERK PROPERTY GSA_Perk_SignatureArms2 AUTO
PERK PROPERTY GSA_Perk_Crafting AUTO
STRING[] PROPERTY stringList AUTO
QUEST PROPERTY UILib AUTO

EVENT OnEquipped(ACTOR akActor)
	IF akActor == PlayerRef
		Utility.Wait(0.1)
		;int choice = GSACraftMessageToolkit.Show()
		int choice = ((UILib AS FORM) AS UILIB_GRIMY).ShowList("What would you like to do?",stringList,0,0) AS INT
		IF choice == 0
			ExtractionBench.Activate(PlayerRef)
		ELSEIF choice == 1
			UpgradeBench.Activate(PlayerRef)
		ELSEIF choice == 2
			IF PlayerRef.hasPerk(GSA_Perk_SignatureArms2)
				WeaponForge.Activate(PlayerRef)
			ELSE
				Debug.notification("You are missing a perk to do that")
			ENDIF
		ELSEIF choice == 3
			IF PlayerRef.hasPerk(GSA_Perk_Salvage)
				ArmorForge.Activate(PlayerRef)
			ELSE
				Debug.notification("You are missing a perk to do that")
			ENDIF
		ELSEIF choice == 4
			IF PlayerRef.hasPerk(GSA_Perk_Crafting)
				JewelryForge.Activate(PlayerRef)
			ELSE
				Debug.notification("You are missing a perk to do that")
			ENDIF
		ENDIF
	ENDIF
ENDEVENT