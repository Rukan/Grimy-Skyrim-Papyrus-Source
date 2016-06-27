Scriptname GSA_Extractor extends ObjectReference  

KEYWORD PROPERTY VendorItemOreIngot AUTO
KEYWORD PROPERTY ArmorMaterialIron AUTO
KEYWORD PROPERTY WeapMaterialIron AUTO
KEYWORD PROPERTY WeapMaterialDraugr AUTO
FORM PROPERTY IngotIron AUTO

KEYWORD PROPERTY ArmorMaterialSteel AUTO
KEYWORD PROPERTY WeapMaterialSteel AUTO
KEYWORD PROPERTY WeapMaterialDraugrHoned AUTO
KEYWORD PROPERTY ArmorMaterialSteelPlate AUTO
FORM PROPERTY IngotSteel AUTO

KEYWORD PROPERTY ArmorMaterialFalmer AUTO
KEYWORD PROPERTY WeapMaterialFalmer AUTO
KEYWORD PROPERTY WeapMaterialFalmerHoned AUTO
KEYWORD PROPERTY ArmorMaterialLeather AUTO
KEYWORD PROPERTY ArmorMaterialScaled AUTO
KEYWORD PROPERTY ArmorMaterialHide AUTO
KEYWORD PROPERTY VendorItemAnimalHide AUTO
FORM PROPERTy Leather01 AUTO

KEYWORD PROPERTY WeapMaterialSilver AUTO
FORM PROPERTY IngotSilver AUTO

KEYWORD PROPERTY ArmorMaterialOrcish AUTO
KEYWORD PROPERTY WeapMaterialOrcish AUTO
FORM PROPERTY IngotOrichalcum AUTO

KEYWORD PROPERTY ArmorMaterialGlass AUTO
KEYWORD PROPERTY WeapMaterialGlass AUTO
FORM PROPERTY IngotMalachite AUTO

KEYWORD PROPERTY ArmorMaterialElvenGilded AUTO
KEYWORD PROPERTY ArmorMaterialElven AUTO
KEYWORD PROPERTY WeapMaterialElven AUTO
FORM PROPERTY IngotIMoonstone AUTO

KEYWORD PROPERTY ArmorMaterialDaedric AUTO
KEYWORD PROPERTY WeapMaterialDaedric AUTO
KEYWORD PROPERTY ArmorMaterialEbony AUTO
KEYWORD PROPERTY WeapMaterialEbony AUTO
FORM PROPERTY IngotEbony AUTO

KEYWORD PROPERTY ArmorMaterialDwarven AUTO
KEYWORD PROPERTY WeapMaterialDwarven AUTO
FORM PROPERTY IngotDwarven AUTO

KEYWORD PROPERTY DLC2ArmorMaterialStalhrimLight AUTO
KEYWORD PROPERTY DLC2ArmorMaterialStalhrimHeavy AUTO
KEYWORD PROPERTY DLC2WeaponMaterialStalhrim AUTO
FORM PROPERTY DLC2OreStalhrim AUTO

KEYWORD PROPERTY DLC2ArmorMaterialNordicLight AUTO
KEYWORD PROPERTY DLC2ArmorMaterialNordicHeavy AUTO
KEYWORD PROPERTY DLC2WeaponMaterialNordic AUTO
FORM PROPERTY IngotQuicksilver AUTO

KEYWORD PROPERTY ClothingCirclet AUTO
KEYWORD PROPERTY ClothingNecklace AUTO
KEYWORD PROPERTY ClothingRing AUTO

LEVELEDITEM PROPERTY GrimyHarvestJeweler AUTO

FORM PROPERTY GAT_MagicInk AUTO
FORM PROPERTY PaperRoll AUTO

FORM PROPERTY Charcoal AUTO

KEYWORD PROPERTY ArmorLight AUTO
KEYWORD PROPERTY ArmorHeavy AUTO
KEYWORD PROPERTY ArmorShield AUTO
	
EVENT OnItemAdded(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	IF akBaseItem AS SCROLL
		salvageMaterials(akBaseItem, aiItemCount, GrimyArcaneDust, akSourceContainer)
	ENDIF

	IF akBaseItem.HasKeyword(VendorItemoreIngot)
		IF StringUtil.Find(akBaseItem.GetName(),"Dwemer") > -1
			salvageMaterials(akBaseItem, aiItemCount, IngotDwarven, akSourceContainer)
		ELSEIF StringUtil.Find(akBaseItem.GetName(),"Ingot") > -1
			Debug.Notification("That's already an ingot")
		ELSE 
			salvageMaterials(akBaseItem, aiItemCount, IngotIron, akSourceContainer)
		ENDIF

	ELSEIF akBaseItem.HasKeyword(ArmorMaterialIron) || akBaseItem.HasKeyword(WeapMaterialIron) || akBaseItem.HasKeyword(WeapMaterialDraugr)
		salvageMaterials(akBaseItem, aiItemCount, IngotIron, akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(ArmorMaterialSteel) || akBaseItem.HasKeyword(WeapMaterialSteel) || akBaseItem.HasKeyword(WeapMaterialDraugrHoned) || akBaseItem.HasKeyword(ArmorMaterialSteelPlate)
		salvageMaterials(akBaseItem, aiItemCount, IngotSteel, akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(ArmorMaterialLeather) || akBaseItem.HasKeyword(ArmorMaterialFalmer) || akBaseItem.HasKeyword(WeapMaterialFalmer) || akBaseItem.HasKeyword(WeapMaterialFalmerHoned) || akBaseItem.HasKeyword(ArmorMaterialScaled) || akBaseItem.HasKeyword(ArmorMaterialHide) || akBaseItem.HasKeyword(VendorItemAnimalHide)
		salvageMaterials(akBaseItem, aiItemCount, Leather01, akSourceContainer)

	ELSEIF akBaseItem AS BOOK
		IF (akbaseItem AS BOOK).GetSpell()
			salvageMaterials(akBaseItem, aiItemCount, GAT_MagicInk , akSourceContainer)
		ELSE
			salvageMaterials(akBaseItem, aiItemCount, PaperRoll , akSourceContainer)
		ENDIF

	ELSEIF akBaseItem.HasKeyword(ArmorMaterialOrcish) || akBaseItem.HasKeyword(WeapMaterialOrcish)
		salvageMaterials(akBaseItem, aiItemCount, IngotOrichalcum, akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(ArmorMaterialGlass) || akBaseItem.HasKeyword(WeapMaterialGlass)
		salvageMaterials(akBaseItem, aiItemCount, IngotMalachite, akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(ArmorMaterialElvenGilded) || akBaseItem.HasKeyword(ArmorMaterialElven) || akBaseItem.HasKeyword(WeapMaterialElven)
		salvageMaterials(akBaseItem, aiItemCount, IngotIMoonstone, akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(ArmorMaterialDwarven) || akBaseItem.HasKeyword(WeapMaterialDwarven)
		salvageMaterials(akBaseItem, aiItemCount, IngotDwarven, akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(ArmorMaterialDaedric) || akBaseItem.HasKeyword(WeapMaterialDaedric) || akBaseItem.HasKeyword(ArmorMaterialEbony) || akBaseItem.HasKeyword(WeapMaterialEbony)
		salvageMaterials(akBaseItem, aiItemCount, IngotEbony, akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(WeapMaterialSilver)
		salvageMaterials(akBaseItem, aiItemCount, IngotSilver, akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(DLC2ArmorMaterialStalhrimLight) || akBaseItem.HasKeyword(DLC2ArmorMaterialStalhrimHeavy) || akBaseItem.HasKeyword(DLC2WeaponMaterialStalhrim)
		salvageMaterials(akBaseItem, aiItemCount, DLC2OreStalhrim, akSourceContainer)

	ELSEIF akBaseItem.HasKeyword(DLC2ArmorMaterialNordicLight) || akBaseItem.HasKeyword(DLC2ArmorMaterialNordicHeavy) || akBaseItem.HasKeyword(DLC2WeaponMaterialNordic)
		salvageMaterials(akBaseItem, aiItemCount, IngotQuicksilver, akSourceContainer)
		
	ELSEIF akBaseItem AS WEAPON
		salvageMaterials(akBaseItem, aiItemCount, IngotSteel, akSourceContainer)
		
	ELSEIF akBaseitem.HasKeyword(ArmorLight)
		salvageMaterials(akBaseItem, aiItemCount, Leather01, akSourceContainer)
	ELSEIF akBaseitem.HasKeyword(ArmorHeavy) || akBaseitem.HasKeyword(ArmorShield)
		salvageMaterials(akBaseItem, aiItemCount, IngotSteel, akSourceContainer)
	ELSEIF akBaseItem.HasKeyword(ClothingRing) || akBaseItem.HasKeyword(ClothingNecklace) || akBaseItem.HasKeyword(ClothingCirclet)
		salvageMaterials(akBaseItem, aiItemCount, GrimyHarvestJeweler, akSourceContainer)
	
	ELSEIF akBaseItem AS SOULGEM
		Self.RemoveItem(akBaseItem, aiItemCount, true)
		INT tempCount = (akBaseItem AS SOULGEM).GetSoulSize() 
		akSourceContainer.Additem(GrimyArcaneDust, tempCount * aiItemCount, true)
		Game.AdvanceSkill("Smithing", aiitemCount * tempCount * GSA_SalvageExp.GetValue())
		
	ELSEIF StringUtil.Find(akBaseItem.GetName(),"wood") > -1
		salvageMaterials(akBaseitem, aiItemCount, Charcoal, akSourceContainer)
	ELSE
		Debug.Notification("That item cannot be salvaged")
		Self.RemoveItem(akbaseItem,aiItemCount,true,akSourceContainer)
	ENDIF
ENDEVENT

FUNCTION salvageMaterials(FORM baseItem, INT count, FORM powder, ObjectReference sourceContainer)
	IF baseItem AS AMMO
		Self.RemoveItem(baseItem,count,true)
		sourceContainer.AddItem(powder,count / 15 ,true)
		Game.AdvanceSkill("Smithing",( count / 15 ) * GSA_SalvageExp.GetValue())
	ELSEIF baseItem AS SCROLL
		Self.RemoveItem(baseItem,count,true)
		sourceContainer.AddItem(Charcoal,count ,true)
		sourceContainer.AddItem(powder,count * baseItem.GetGoldValue()/100 + 1 ,true)
		Game.AdvanceSkill("Smithing",( count * baseItem.GetGoldValue()/100 + 1 ) * GSA_SalvageExp.GetValue())
	ELSEIF baseItem AS WEAPON 
		Self.RemoveItem(baseItem,count,true)
		INT tempCount = (baseItem.GetWeight()/GSA_WeightPerIngot.GetValue() - 0.1) AS INT + 1
		sourceContainer.AddItem(GrimyArcaneDust,count * 15,true)
		sourceContainer.AddItem(powder,count * tempCount,true)
		Game.AdvanceSkill("Enchanting",count * GrimyGlobal_EnchantingExp.GetValue())
		Game.AdvanceSkill("Smithing",count * tempCount * GSA_SalvageExp.GetValue())
		
	ELSEIF baseItem AS ARMOR 
		Self.RemoveItem(baseItem,count,true)
		INT tempCount = (baseItem.GetWeight()/GSA_WeightPerIngot.GetValue() - 0.1) AS INT + 1
		sourceContainer.AddItem(GrimyArcaneDust,count * 15,true)
		sourceContainer.AddItem(powder,count * tempCount,true)
		Game.AdvanceSkill("Enchanting",count * GrimyGlobal_EnchantingExp.GetValue())
		Game.AdvanceSkill("Smithing",count * tempCount * GSA_SalvageExp.GetValue())
		
	ELSE
		Self.RemoveItem(baseItem,count,true)
		INT tempCount = (baseItem.GetWeight()/GSA_WeightPerIngot.GetValue() - 0.1) AS INT + 1
		sourceContainer.AddItem(powder,count * tempCount,true)
		Game.AdvanceSkill("Smithing",count * tempCount * GSA_SalvageExp.GetValue())
	ENDIF
ENDFUNCTION
GLOBALVARIABLE PROPERTY GSA_WeightPerIngot AUTO
GLOBALVARIABLE PROPERTY GSA_SalvageExp AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_EnchantingExp AUTO
FORM PROPERTY GrimyArcaneDust AUTO