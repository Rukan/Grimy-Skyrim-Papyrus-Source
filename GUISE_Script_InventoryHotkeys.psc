Scriptname GUISE_Script_InventoryHotkeys extends activemagiceffect  

QUEST PROPERTY UILib AUTO
GVC_MenuMain Property GVC_MainMenu AUTO
GELO_MenuMain Property GELO_MainMenu AUTO
GELO_IdentifyUtil Property GELO_Util AUTO
GLOBALVARIABLE PROPERTY GUISE_Hotkey_Salvage AUTO
GLOBALVARIABLE PROPERTY GUISE_Hotkey_Extractor AUTO
GLOBALVARIABLE PROPERTY GUISE_Hotkey_Combined AUTO
STRING[] PROPERTY CombinedList AUTO
IMPORT GrimyToolsPluginScript
IMPORT Debug
IMPORT Game
IMPORT UI

ACTOR PROPERTY PlayerRef AUTO

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	RegisterForMenu("InventoryMenu")
ENDEVENT

EVENT OnPlayerLoadGame()
	RegisterForMenu("InventoryMenu")
ENDEVENT

EVENT OnMenuOpen(String MenuName)
	registerKeys()
ENDEVENT

EVENT OnMenuClose(String MenuName)
	UnregisterForAllKeys()
ENDEVENT

FUNCTION registerKeys()
	RegisterForKey(GUISE_Hotkey_Salvage.GetValueInt())
	RegisterForKey(GUISE_Hotkey_Extractor.GetValueInt())
	RegisterForKey(GUISE_Hotkey_Combined.GetValueInt())
ENDFUNCTION

PERK PROPERTY GSA_Perk_Salvage AUTO
PERK PROPERTY GSA_Perk_SignatureArms2 AUTO
PERK PROPERTY GSA_Perk_Crafting AUTO
PERK PROPERTY GrimyPerkEnch50Transcription AUTO
PERK PROPERTY GrimyPerkEnch90Perfectionist AUTO
PERK PROPERTY GrimyPerkEnch20OffenseSlot AUTO
KEYWORD PROPERTY GSA_UpgradeScroll AUTO
EVENT OnKeyDown(Int KeyCode)
	IF !isMenuOpen("Console") && !isMenuOpen("CustomMenu") && !((UILib as FORM) as UILIB_GRIMY).IsMenuOpen()
		INT CombinedIndex = -1
		IF KeyCode == GUISE_Hotkey_Combined.GetValueInt()
			CombinedIndex = ((UILib as FORM) as UILIB_GRIMY).ShowList("Inventory Abilities", CombinedList, 0, 0)
		ELSEIF KeyCode == GUISE_Hotkey_Salvage.GetValueInt()
			CombinedIndex = 2
		ELSEIF KeyCode == GUISE_Hotkey_Extractor.GetValueInt()
			CombinedIndex = 3
		ENDIF
			
		IF CombinedIndex == 1 
			IF PlayerRef.HasPerk(GrimyPerkEnch20OffenseSlot)
				GELO_Util.QuickIdentifyForm(GetFormEx(GetInt("InventoryMenu", "_root.Menu_mc.inventoryLists.itemList.selectedEntry.formId")))
			ELSE 
				Notification("You are missing the required perk for that")
			ENDIF
		ELSEIF CombinedIndex == 2
			doSalvage(GetFormEx(GetInt("InventoryMenu", "_root.Menu_mc.inventoryLists.itemList.selectedEntry.formId")))
		ELSEIF CombinedIndex == 3
			doExtractor(GetFormEx(GetInt("InventoryMenu", "_root.Menu_mc.inventoryLists.itemList.selectedEntry.formId")))
		ELSEIF CombinedIndex == 4
			IF PlayerRef.HasPerk(GSA_Perk_Salvage)
				doArcaneArmor(GetFormEx(GetInt("InventoryMenu", "_root.Menu_mc.inventoryLists.itemList.selectedEntry.formId")))
			ELSE
				Notification("You are missing the required perk for that")
			ENDIF
		ELSEIF CombinedIndex == 5
			IF PlayerRef.HasPerk(GSA_Perk_SignatureArms2)
				doArcaneWeapon(GetFormEx(GetInt("InventoryMenu", "_root.Menu_mc.inventoryLists.itemList.selectedEntry.formId")))
			ELSE
				Notification("You are missing the required perk for that")
			ENDIF
		ELSEIF CombinedIndex == 6
			IF PlayerRef.HasPerk(GSA_Perk_Crafting)
				doArcaneJewelry(GetFormEx(GetInt("InventoryMenu", "_root.Menu_mc.inventoryLists.itemList.selectedEntry.formId")))
			ELSE
				Notification("You are missing the required perk for that")
			ENDIF
		ELSEIF CombinedIndex == 7
			FORM akForm = GetFormEx(GetInt("InventoryMenu", "_root.Menu_mc.inventoryLists.itemList.selectedEntry.formId"))
			IF !PlayerRef.HasPerk(GrimyPerkEnch50Transcription)
				Notification("You are missing a perk for that")
			IF akForm AS SCROLL
				ELSEIF akForm.HasKeyword(GSA_UpgradeScroll)
					Notification("You can only copy magic scrolls")
				ELSEIF ( PlayerRef.GetItemCount(Charcoal) > 0 ) && ( PlayerRef.GetItemCount(PaperRoll) > 0 ) && ( PlayerRef.GetItemCount(GrimyArcaneDust) > 0 )
					PlayerRef.RemoveItem(Charcoal)
					PlayerRef.RemoveItem(PaperRoll)
					PlayerRef.RemoveItem(GrimyArcaneDust)
					PlayerRef.Additem(akForm)
				ELSE
					Notification("Copying a magic scroll requires charcoal, a roll of paper, and arcane dust")
				ENDIF
			ELSE
				Notification("That item is not a scroll")
			ENDIF
		ELSEIF CombinedIndex == 8
			MarkSignaturePotion()
		ELSEIF CombinedIndex == 9
			FORM akForm = GetFormEx(GetInt("InventoryMenu", "_root.Menu_mc.inventoryLists.itemList.selectedEntry.formId"))
			IF akFORM AS SCROLL && !akForm.HasKeyword(GSA_UpgradeScroll)
				SCROLL tempScroll = akFORM AS SCROLL
				CombinedIndex = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select Signature Scroll Slot", GELO_MainMenu.GetScrollList(), 0, 0)
				GELO_MainMenu.SignatureScrollList[CombinedIndex] = tempScroll
			ELSE 
				Notification("You can only mark scrolls")
			ENDIF
		ELSEIF CombinedIndex == 10
			FORM akForm = GetFormEx(GetInt("InventoryMenu", "_root.Menu_mc.inventoryLists.itemList.selectedEntry.formId"))
			playerKnowsEnchant(akForm, True)
		ENDIF
	ENDIF
ENDEVENT

IMPORT KMXPotionUtil
Function MarkSignaturePotion()
	FORM akForm = GetFormEx(GetInt("InventoryMenu", "_root.Menu_mc.inventoryLists.itemList.selectedEntry.formId"))
	IF akFORM AS POTION
		POTION tempPotion = akFORM AS POTION
		IF !tempPotion.IsFood()
			INT index = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select Signature Potion Slot", GVC_MainMenu.GetPotionList(), 0, 0)
			
			IF tempPotion.GetFormID() >= 0xFF000000
				IncPotionRefCount(tempPotion,1)
			ENDIF
			PlayerRef.RemoveItem(tempPotion,1,true)
			POTION oldPotion = GVC_MainMenu.SignaturePotionList[index]
			IF oldPotion != None && oldPotion.GetFormID() >= 0xFF000000
				PlayerRef.AddItem(oldPotion,1,true)
				Notification("You find your stashed copy of " + oldPotion.GetName())
			ELSE
				Notification("You stash a copy of " + tempPotion.GetName() + " to refill from.")
			ENDIF
			
			GVC_MainMenu.SignaturePotionList[index] = tempPotion
		ELSE
			Notification("You can only mark potions")
		ENDIF
	ELSE 
		Notification("You can only mark potions")
	ENDIF
EndFunction

Function playerKnowsEnchant(Form akForm, Bool akBool)
	IF akForm
		IF akForm AS Weapon
			Weapon akWeapon = akForm AS Weapon
			If akWeapon.GetEnchantment()
				Enchantment akEnch = akWeapon.GetEnchantment()
				If akEnch.GetBaseEnchantment()
					akEnch.GetBaseEnchantment().SetPlayerKnows(akBool)
				ElseIf PlayerRef.hasPerk(GrimyPerkEnch90Perfectionist)
					akEnch.SetPlayerKnows(akBool)
				Else
					Notification("You need the forbidden knowledge perk to learn this enchantment")
				EndIf
			Else
				Notification("This armor has no generic enchantment to learn. You cannot learn player made enchantments")
			EndIf
		ELSEIF akForm AS Armor
			Armor akArmor = akForm AS Armor
			If akArmor.GetEnchantment()
				Enchantment akEnch = akArmor.GetEnchantment()
				If akEnch.GetBaseEnchantment()
					akEnch.GetBaseEnchantment().SetPlayerKnows(akBool)
				ElseIf PlayerRef.hasPerk(GrimyPerkEnch90Perfectionist)
					akEnch.SetPlayerKnows(akBool)
				Else
					Notification("You need the forbidden knowledge perk to learn this enchantment")
				EndIf
			Else
				Notification("This armor has no generic enchantment to learn. You cannot learn player made enchantments")
			EndIf
		Else
			Notification("You can only learn enchantments from weapons and armor")
		EndIf
	ENDIF
EndFunction

KEYWORD PROPERTY VendorItemStaff AUTO
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

bool isAmmo = false

KEYWORD PROPERTY ArmorLight AUTO
KEYWORD PROPERTY ArmorHeavy AUTO
KEYWORD PROPERTY ArmorShield AUTO

GLOBALVARIABLE PROPERTY GSA_WeightPerIngot AUTO
GLOBALVARIABLE PROPERTY GSA_SalvageExp AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_EnchantingExp AUTO
FORM PROPERTY GrimyArcaneDust AUTO

FUNCTION doSalvage(FORM akForm)
	IF akForm AS SCROLL
		salvageMaterials(akForm, GrimyArcaneDust)
	ENDIF

	IF akForm.HasKeyword(VendorItemoreIngot)
		IF StringUtil.Find(akForm.GetName(),"Dwemer") > -1
			salvageMaterials(akForm, IngotDwarven)
		ELSEIF StringUtil.Find(akForm.GetName(),"Ingot") > -1
			Notification("That's already an ingot")
		ELSE
			salvageMaterials(akForm, IngotIron)
		ENDIF
	ELSEIF akForm.HasKeyword(ArmorMaterialIron) || akForm.HasKeyword(WeapMaterialIron) || akForm.HasKeyword(WeapMaterialDraugr)
		salvageMaterials(akForm, IngotIron)

	ELSEIF akForm.HasKeyword(ArmorMaterialSteel) || akForm.HasKeyword(WeapMaterialSteel) || akForm.HasKeyword(WeapMaterialDraugrHoned) || akForm.HasKeyword(ArmorMaterialSteelPlate)
		salvageMaterials(akForm, IngotSteel)

	ELSEIF akForm.HasKeyword(ArmorMaterialLeather) || akForm.HasKeyword(ArmorMaterialFalmer) || akForm.HasKeyword(WeapMaterialFalmer) || akForm.HasKeyword(WeapMaterialFalmerHoned) || akForm.HasKeyword(ArmorMaterialScaled) || akForm.HasKeyword(ArmorMaterialHide) || akForm.HasKeyword(VendorItemAnimalHide)
		salvageMaterials(akForm, Leather01)

	ELSEIF akForm AS BOOK
		IF (akForm AS BOOK).GetSpell()	
			salvageMaterials(akForm, GAT_MagicInk )
		ELSE
			salvageMaterials(akForm, PaperRoll )
		ENDIF

	ELSEIF akForm.HasKeyword(ArmorMaterialOrcish) || akForm.HasKeyword(WeapMaterialOrcish)
		salvageMaterials(akForm, IngotOrichalcum)

	ELSEIF akForm.HasKeyword(ArmorMaterialGlass) || akForm.HasKeyword(WeapMaterialGlass)
		salvageMaterials(akForm, IngotMalachite)

	ELSEIF akForm.HasKeyword(ArmorMaterialElvenGilded) || akForm.HasKeyword(ArmorMaterialElven) || akForm.HasKeyword(WeapMaterialElven)
		salvageMaterials(akForm, IngotIMoonstone)

	ELSEIF akForm.HasKeyword(ArmorMaterialDwarven) || akForm.HasKeyword(WeapMaterialDwarven)
		salvageMaterials(akForm, IngotDwarven)

	ELSEIF akForm.HasKeyword(ArmorMaterialDaedric) || akForm.HasKeyword(WeapMaterialDaedric) || akForm.HasKeyword(ArmorMaterialEbony) || akForm.HasKeyword(WeapMaterialEbony)
		salvageMaterials(akForm, IngotEbony)

	ELSEIF akForm.HasKeyword(WeapMaterialSilver)
		salvageMaterials(akForm, IngotSilver)

	ELSEIF akForm.HasKeyword(DLC2ArmorMaterialStalhrimLight) || akForm.HasKeyword(DLC2ArmorMaterialStalhrimHeavy) || akForm.HasKeyword(DLC2WeaponMaterialStalhrim)
		salvageMaterials(akForm, DLC2OreStalhrim)

	ELSEIF akForm.HasKeyword(DLC2ArmorMaterialNordicLight) || akForm.HasKeyword(DLC2ArmorMaterialNordicHeavy) || akForm.HasKeyword(DLC2WeaponMaterialNordic)
		salvageMaterials(akForm, IngotQuicksilver)
		
	ELSEIF akForm AS WEAPON
		salvageMaterials(akForm, IngotSteel)
		
	ELSEIF akForm.HasKeyword(ArmorLight)
		salvageMaterials(akForm, Leather01)
	ELSEIF akForm.HasKeyword(ArmorHeavy) || akForm.HasKeyword(ArmorShield)
		salvageMaterials(akForm, IngotSteel)
	ELSEIF akForm.HasKeyword(ClothingRing) || akForm.HasKeyword(ClothingNecklace) || akForm.HasKeyword(ClothingCirclet)
		salvageMaterials(akForm, GrimyHarvestJeweler)
	
	ELSEIF akForm AS SOULGEM
		INT akCount = PlayerRef.GetItemCount(akForm)
		INT tempCount = (akForm AS SOULGEM).GetSoulSize() 
		PlayerRef.RemoveItem(akForm, akCount, true)
		PlayerRef.Additem(GrimyArcaneDust, tempCount * akCount)
		AdvanceSkill("Smithing", akCount * tempCount * GSA_SalvageExp.GetValue())
		
	ELSEIF StringUtil.Find(akForm.GetName(),"Wood") > -1
		salvageMaterials(akForm, Charcoal)
	ELSE
		Notification("That item cannot be salvaged")
	ENDIF
ENDFUNCTION

FUNCTION salvageMaterials(FORM baseItem, FORM powder)
	INT count = PlayerRef.GetItemCount(baseItem)
	IF baseItem AS AMMO
		PlayerRef.RemoveItem(baseItem,count,true)
		PlayerRef.AddItem(powder,count / 15 )
		AdvanceSkill("Smithing",( count / 15 ) * GSA_SalvageExp.GetValue())
	ELSEIF baseItem AS SCROLL
		PlayerRef.RemoveItem(baseItem,count,true)
		PlayerRef.AddItem(Charcoal,count)
		PlayerRef.AddItem(powder,count * baseItem.GetGoldValue()/100 + 1 )
		AdvanceSkill("Smithing", ( count * baseItem.GetGoldValue()/100 + 1 ) * GSA_SalvageExp.GetValue())
	ELSEIF baseItem AS WEAPON 
		IF (baseItem AS WEAPON).GetEnchantment()
			PlayerRef.RemoveItem(baseItem,count,true)
			INT tempCount = (baseItem.GetWeight()/GSA_WeightPerIngot.GetValue() - 0.1) AS INT + 1
			PlayerRef.AddItem(powder,count * tempCount)
			PlayerRef.AddItem(GrimyArcaneDust,count*15)
			AdvanceSkill("Enchanting",count * GrimyGlobal_EnchantingExp.GetValue())
			AdvanceSkill("Smithing",count * tempCount * GSA_SalvageExp.GetValue())
		ELSE
			IterativeSalvage(baseItem, powder)
		ENDIF
	ELSEIF baseItem AS ARMOR
		IF (baseitem AS ARMOR).GetEnchantment()
			PlayerRef.RemoveItem(baseItem,count,true)
			INT tempCount = (baseItem.GetWeight()/GSA_WeightPerIngot.GetValue() - 0.1) AS INT + 1
			PlayerRef.AddItem(powder,count * tempCount)
			PlayerRef.AddItem(GrimyArcaneDust,count*15)
			AdvanceSkill("Enchanting",count * GrimyGlobal_EnchantingExp.GetValue())
			AdvanceSkill("Smithing",count * tempCount * GSA_SalvageExp.GetValue())
		ELSE
			IterativeSalvage(baseItem, powder)
		ENDIF
	ELSE
		PlayerRef.RemoveItem(baseItem,count,true)
		INT tempCount = (baseItem.GetWeight()/GSA_WeightPerIngot.GetValue() - 0.1) AS INT + 1
		PlayerRef.AddItem(powder,count * tempCount)
		AdvanceSkill("Smithing",count * tempCount * GSA_SalvageExp.GetValue())
	ENDIF
ENDFUNCTION

FUNCTION IterativeSalvage(FORM baseItem, FORM powder)
	;Notification("Salvaging weapons/armor may lag, in order to not accidentally salvage player enchanted items")
	INT tempCount = (baseItem.GetWeight()/GSA_WeightPerIngot.GetValue() - 0.1) AS INT + 1
	OBJECTREFERENCE iterativeRef = PlayerRef.DropObject(baseItem)

	INT count = 0
	WHILE iterativeRef
		IF iterativeRef.GetEnchantment() == NONE
			;Safe to salvage, procede to do so
			iterativeRef.Delete()
			count += 1
			IF PlayerRef.GetItemCount(baseItem) > 0
				;still more items left to process
				iterativeRef = PlayerRef.DropObject(baseItem)
			ELSE
				;no more items left, terminate
				iterativeRef = None
			ENDIF
		ELSE
			;This one has a player made enchantment! return it and terminate
			PlayerRef.AddItem(iterativeRef,1,true)
			iterativeRef = None
		ENDIF
	ENDWHILE

	IF count > 0
		PlayerRef.AddItem(powder,count * tempCount + 1)
		AdvanceSkill("Smithing",count * tempCount * GSA_SalvageExp.GetValue())
	ENDIF
ENDFUNCTION 

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
GLOBALVARIABLE PROPERTY GVC_numPotionExtraction AUTO
GLOBALVARIABLE PROPERTY GVC_XP_Extraction AUTO

FUNCTION doExtractor(FORM akForm)
	IF akForm AS POTION
		POTION tempPotion = akForm AS POTION
		IF akForm == GVCAlcohest
			makePowder(akForm,GVC_INGR_FirePowder)
		ELSEIF tempPotion.IsFood() && ( tempPotion.GetUseSound() == ITMPotionUse AS SOUNDDESCRIPTOR )
			makePowder(akForm,GVCAlcohest)
			RETURN
		ENDIF
	ENDIF
		
	IF akForm.HasKeyword(MagicAlchResistFrost)
		makePowder(akForm,GVC_INGR_FrostPowder)

	ELSEIF akForm.HasKeyword(MagicAlchResistFire)
		makePowder(akForm,GVC_INGR_FirePowder)

	ELSEIF akForm.HasKeyword(MagicAlchWeaknessShock)
		makePowder(akForm,GVC_INGR_ShockPowder)

	ELSEIF akForm.HasKeyword(MagicAlchWeaknessMagic)
		makePowder(akForm,GVC_INGR_MagicPowder)

	ELSEIF akForm.HasKeyword(MagicAlchDamageHealth)
		makePowder(akForm,GVC_INGR_PoisonPowder)

	ELSEIF akForm.HasKeyword(MagicAlchWeaknessFrost)
		makePowder(akForm,GVC_INGR_FrostPowder)

	ELSEIF akForm.HasKeyword(MagicAlchWeaknessFire)
		makePowder(akForm,GVC_INGR_FirePowder)

	ELSEIF akForm.HasKeyword(MagicAlchDamageStamina)
		makePowder(akForm,GVC_INGR_FrostPowder)

	ELSEIF akForm.HasKeyword(MagicAlchDamageMagicka)
		makePowder(akForm,GVC_INGR_ShockPowder)

	ELSEIF akForm.HasKeyword(MagicAlchHarmful)
		makePowder(akForm,GVC_INGR_BlastPowder)


	ELSEIF akForm == DwarvenCenturionDynamo
		INT count = PlayerRef.GetItemCount(akForm)
		PlayerRef.RemoveItem(akForm,count,true)
		AdvanceSkill("Alchemy",GVC_XP_Extraction.GetValue()*100*count)
		PlayerRef.AddItem(GVC_INGR_FirePowder,count*100)
		
	ELSEIF akForm AS SOULGEM
		INT akCount = PlayerRef.GetItemCount(akForm)
		INT tempCount = (akForm AS SOULGEM).GetSoulSize() 
		PlayerRef.RemoveItem(akForm, akCount, true)
		PlayerRef.Additem(GVC_INGR_MagicPowder, tempCount * akCount * GVC_numPotionExtraction.GetValueInt() )
		AdvanceSkill("Alchemy",GVC_XP_Extraction.GetValue() * tempCount * akCount * GVC_numPotionExtraction.GetValueInt())

	ELSE
		Notification("That item cannot be decomposed")
	ENDIF
	IF akForm AS INGREDIENT && PlayerRef.HasPerk(GVC_Perk_A05_ConcentratedPoison)
		(akForm AS INGREDIENT).LearnAllEffects()
	ENDIF
ENDFUNCTION
PERK PROPERTY GVC_Perk_A05_ConcentratedPoison AUTO

FUNCTION makePowder(FORM baseItem, FORM powder)
	INT count = PlayerRef.GetItemCount(baseItem)
	PlayerRef.RemoveItem(baseItem,count,true)
	IF baseItem AS POTION
		IF (baseItem AS POTION).IsFood()
			PlayerRef.AddItem(powder,count)
			AdvanceSkill("Alchemy",GVC_XP_Extraction.GetValue()*count)
		ELSE
			PlayerRef.AddItem(powder,count*GVC_numPotionExtraction.GetValueInt())
			AdvanceSkill("Alchemy",GVC_XP_Extraction.GetValue()*GVC_numPotionExtraction.GetValueInt()*count)
		ENDIF
	ELSE
		PlayerRef.AddItem(powder,count)
		AdvanceSkill("Alchemy",GVC_XP_Extraction.GetValue()*count)
	ENDIF
ENDFUNCTION

LEVELEDITEM PROPERTY GrimyLItemWeapon AUTO
FORMLIST PROPERTY GSA_ForgeList AUTO
GLOBALVARIABLE PROPERTY GSA_ArcaneExp AUTO

FUNCTION doArcaneWeapon(FORM akForm)
	IF GSA_ForgeList.HasForm(akForm)
		INT count = PlayerRef.GetItemCount(akForm)
		arcaneValue += count * (0.05 + akForm.GetGoldValue() / 1000.0 )
		PlayerRef.RemoveItem(akForm,count,true)
		GoToState("GiveWeaponLoot")
	ELSE
		Notification("This forge requires ingots or leather")
	ENDIF
ENDFUNCTION

STATE GiveWeaponLoot
	EVENT OnBeginState()
		WHILE arcaneValue >= 1.0
			arcaneValue -= 1.0
			AdvanceSkill("Smithing",GSA_ArcaneExp.GetValue())
			PlayerRef.Additem(GrimyLItemWeapon,1)
		ENDWHILE
		GoToState("")
	ENDEVENT

	EVENT OnKeyDown(int KeyCode)
		Notification("Busy crafting items")
	ENDEVENT
ENDSTATE

LEVELEDITEM PROPERTY GrimyLItemArmor AUTO
FLOAT arcaneValue = 0.0

FUNCTION doArcaneArmor(FORM akForm)
	IF GSA_ForgeList.HasForm(akForm)
		INT count = PlayerRef.GetItemCount(akForm)
		arcaneValue += count * (0.05 + akForm.GetGoldValue() / 1000.0 )
		PlayerRef.RemoveItem(akForm,count,true)
		GoToState("GiveArmorLoot")
	ELSE
		Notification("This forge requires ingots or leather")
	ENDIF
ENDFUNCTION

STATE GiveArmorLoot
	EVENT OnBeginState()
		WHILE arcaneValue >= 1.0
			arcaneValue -= 1.0
			AdvanceSkill("Smithing",GSA_ArcaneExp.GetValue())
			PlayerRef.Additem(GrimyLItemArmor,1)
		ENDWHILE
		GoToState("")
	ENDEVENT

	EVENT OnKeyDown(int KeyCode)
		Notification("Busy crafting items")
	ENDEVENT
ENDSTATE

LEVELEDITEM PROPERTY GrimyLItemJewelry AUTO
FORMLIST PROPERTY GSA_JewelryForgeList AUTO
FLOAT jewelryValue = 0.0

FUNCTION doArcaneJewelry(FORM akForm)
	IF GSA_JewelryForgeList.HasForm(akForm)
		INT count = PlayerRef.GetItemCount(akForm)
		jewelryValue += count * (0.05 + akForm.GetGoldValue() / 1000.0 )
		PlayerRef.RemoveItem(akForm,count,true)
		GoToState("GiveJewelryLoot")
	ELSE
		Notification("This forge requires gems, silver ingots, or gold ingots")
	ENDIF
ENDFUNCTION

STATE GiveJewelryLoot
	EVENT OnBeginState()
		WHILE jewelryValue >= 1.0
			jewelryValue -= 1.0
			AdvanceSkill("Smithing",GSA_ArcaneExp.GetValue())
			PlayerRef.Additem(GrimyLItemJewelry,1)
		ENDWHILE
		GoToState("")
	ENDEVENT

	EVENT OnKeyDown(int KeyCode)
		Notification("Busy crafting items")
	ENDEVENT
ENDSTATE