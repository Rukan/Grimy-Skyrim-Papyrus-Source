Scriptname GVC_Extractor extends ObjectReference  

KEYWORD PROPERTY MagicAlchResistFire AUTO
KEYWORD PROPERTY MagicAlchResistFrost AUTO

KEYWORD PROPERTY MagicAlchWeaknessShock AUTO
KEYWORD PROPERTY MagicAlchWeaknessMagic AUTO
KEYWORD PROPERTY MagicAlchDamageHealth AUTO
KEYWORD PROPERTY MagicAlchWeaknessFrost AUTO
KEYWORD PROPERTY MagicAlchWeaknessFire AUTO
KEYWORD PROPERTY MagicAlchDamageMagicka AUTO
KEYWORD PROPERTY MagicAlchDamageStamina AUTO
KEYWORD PROPERTY MagicAlchHarmful AUTO

FORM PROPERTY GVC_INGR_BlastPowder AUTO
FORM PROPERTY GVC_INGR_FirePowder AUTO
FORM PROPERTY GVC_INGR_FrostPowder AUTO
FORM PROPERTY GVC_INGR_MagicPowder AUTO
FORM PROPERTY GVC_INGR_PoisonPowder AUTO
FORM PROPERTY GVC_INGR_ShockPowder AUTO

FORM PROPERTY GVCAlcohest AUTO

FORM PROPERTY ITMPotionUse AUTO
FORM PROPERTY DwarvenCenturionDynamo AUTO

EVENT OnItemAdded(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	IF akBaseItem AS POTION
		POTION tempPotion = akBaseItem AS POTION
		IF akBaseItem == GVCAlcohest
			makePowder(akBaseItem,aiItemCount,GVC_INGR_FirePowder,akSourceContainer)
		ELSEIF tempPotion.IsFood() && ( tempPotion.GetUseSound() == ITMPotionUse AS SOUNDDESCRIPTOR )
			makePowder(akBaseItem,aiItemCount,GVCAlcohest,akSourceContainer)
			RETURN
		ENDIF
	ENDIF

	IF akBaseItem.HasKeyword(MagicAlchResistFrost)
		makePowder(akBaseItem,aiItemCount,GVC_INGR_FrostPowder,akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(MagicAlchResistFire)
		makePowder(akBaseItem,aiItemCount,GVC_INGR_FirePowder,akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(MagicAlchWeaknessShock)
		makePowder(akBaseItem,aiItemCount,GVC_INGR_ShockPowder,akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(MagicAlchWeaknessMagic)
		makePowder(akBaseItem,aiItemCount,GVC_INGR_MagicPowder,akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(MagicAlchDamageHealth)
		makePowder(akBaseItem,aiItemCount,GVC_INGR_PoisonPowder,akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(MagicAlchWeaknessFrost)
		makePowder(akBaseItem,aiItemCount,GVC_INGR_FrostPowder,akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(MagicAlchWeaknessFire)
		makePowder(akBaseItem,aiItemCount,GVC_INGR_FirePowder,akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(MagicAlchDamageStamina)
		makePowder(akBaseItem,aiItemCount,GVC_INGR_FrostPowder,akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(MagicAlchDamageMagicka)
		makePowder(akBaseItem,aiItemCount,GVC_INGR_ShockPowder,akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(MagicAlchHarmful)
		makePowder(akBaseItem,aiItemCount,GVC_INGR_BlastPowder,akSourceContainer)

	ELSEIF akBaseItem == DwarvenCenturionDynamo
		Self.RemoveItem(akbaseItem,aiitemCount,true)
		Game.AdvanceSkill("Alchemy",GVC_XP_Extraction.GetValue()*100*aiitemCount)
		akSourceContainer.AddItem(GVC_INGR_FirePowder,aiItemCount*100,true)
		
	ELSEIF akBaseItem AS SOULGEM
		INT tempCount = (akBaseItem AS SOULGEM).GetSoulSize() 
		Self.RemoveItem(akbaseItem,aiitemCount,true)
		akSourceContainer.AddItem(GVC_INGR_MagicPowder,aiItemCount*tempCount*GVC_numPotionExtraction.GetValueInt(),true)
		Game.AdvanceSkill("Alchemy",GVC_XP_Extraction.GetValue()*tempCount*aiItemCount*GVC_numPotionExtraction.GetValueInt())
		
	ELSE
		Debug.Notification("That item cannot be decomposed")
		Self.RemoveItem(akbaseItem,aiitemCount,true,akSourceContainer)

	ENDIF
	IF akBaseItem AS INGREDIENT && (akSourceContainer AS ACTOR).HasPerk(GVC_Perk_A05_ConcentratedPoison)
		(akBaseItem AS INGREDIENT).LearnAllEffects()
	ENDIF
ENDEVENT
PERK PROPERTY GVC_Perk_A05_ConcentratedPoison AUTO

FUNCTION makePowder(FORM baseItem, INT count, FORM powder, ObjectReference sourceContainer)
	Self.RemoveItem(baseItem,count,true)
	IF baseItem AS POTION
		IF (baseItem AS POTION).IsFood()
			sourceContainer.AddItem(powder,count,true)
			Game.AdvanceSkill("Alchemy",GVC_XP_Extraction.GetValue()*count)
		ELSE
			sourceContainer.AddItem(powder,count*GVC_numPotionExtraction.GetValueInt(),true)
			Game.AdvanceSkill("Alchemy",GVC_XP_Extraction.GetValue()*GVC_numPotionExtraction.GetValueInt()*count)
		ENDIF
	ELSE
		sourceContainer.AddItem(powder,count,true)
		Game.AdvanceSkill("Alchemy",GVC_XP_Extraction.GetValue()*count)
	ENDIF
ENDFUNCTION
GLOBALVARIABLE PROPERTY GVC_numPotionExtraction AUTO
GLOBALVARIABLE PROPERTY GVC_XP_Extraction AUTO