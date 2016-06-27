scriptName GUI_Script_InventoryHotkeys extends activemagiceffect

IMPORT WornObject
IMPORT Game
ACTOR PROPERTY PlayerRef AUTO
GUI_MenuMain PROPERTY MenuMain AUTO
STRING[] PROPERTY stringList AUTO
QUEST PROPERTY UILib AUTO

FUNCTION OnMenuClose(String MenuName)
	UnregisterForAllKeys()
ENDFUNCTION

FUNCTION OnMenuOpen(String MenuName)
	RegisterForKey(MenuMain.GUI_Hotkey_FavoriteGroup)
	RegisterForKey(MenuMain.GUI_Hotkey_TemperKey)
	RegisterForKey(MenuMain.GUI_Hotkey_InspectKey)
ENDFUNCTION

FUNCTION OnPlayerLoadGame()
	RegisterForMenu("InventoryMenu")
ENDFUNCTION

FUNCTION OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	RegisterForMenu("InventoryMenu")
ENDFUNCTION

FUNCTION OnKeyDown(INT KeyCode)
	IF !UI.isMenuOpen("Console") && !UI.isMenuOpen("CustomMenu") && !((UILib as FORM) as UILIB_GRIMY).IsMenuOpen()
		FORM akForm = GetFormEx(ui.GetInt("InventoryMenu", "_root.Menu_mc.inventoryLists.itemList.selectedEntry.formId"))
		IF akForm
			IF KeyCode == MenuMain.GUI_Hotkey_FavoriteGroup
				INT Result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Add to which Queue?", stringList, 6, 6)
				IF Result == 0
					Result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select Queue Index", MenuMain.getHealthPotionList(), 0, 0)
					MenuMain.insertHealthPotionList(Result, akForm)
				ELSEIF Result == 1
					Result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select Queue Index", MenuMain.getMagickaPotionList(), 0, 0)
					MenuMain.insertMagickaPotionList(Result, akForm)
				ELSEIF Result == 2
					Result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select Queue Index", MenuMain.getStaminaPotionList(), 0, 0)
					MenuMain.insertStaminaPotionList(Result, akForm)
				ELSEIF Result == 3
					Result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select Queue Index", MenuMain.getPoisonList(), 0, 0)
					MenuMain.insertPoisonList(Result, akForm)
				ELSEIF Result == 4
					Result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select Queue Index", MenuMain.getMisc1List(), 0, 0)
					MenuMain.insertMisc1List(Result, akForm)
				ELSEIF Result == 5
					Result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select Queue Index", MenuMain.getMisc2List(), 0, 0)
					MenuMain.insertMisc2List(Result, akForm)
				ENDIF
			ELSEIF KeyCode == MenuMain.GUI_Hotkey_TemperKey
				IF akForm AS WEAPON
					temperWeapon(akForm AS WEAPON)
				ELSEIF akForm AS ARMOR
					temperArmor(akForm AS ARMOR)
				ELSE
					Debug.Notification("You can only temper weapons and armor")
				ENDIF
			ELSE
				MenuMain.inspectForm(akForm)
			ENDIF
		ENDIF
	ENDIF
ENDFUNCTION

FUNCTION temperWeapon(WEAPON akWeapon)
	IF PlayerRef.GetEquippedWeapon(true) == akWeapon && removeWeaponMaterial(akWeapon)
		SetItemHealthPercent(PlayerRef,0,0,calculateWeaponHealth(akWeapon)) ; left
		GrantExperience(akWeapon AS FORM)
	ELSEIF PlayerRef.GetEquippedWeapon() == akWeapon && removeWeaponMaterial(akWeapon)
		SetItemHealthPercent(PlayerRef,1,0,calculateWeaponHealth(akWeapon)) ; right
		GrantExperience(akWeapon AS FORM)
	ELSE
		Debug.Notification("You can only temper equipped weapons")
	ENDIF
ENDFUNCTION

FUNCTION temperArmor(ARMOR akArmor)
	IF PlayerRef.IsEquipped(akArmor) && removeArmorMaterial(akArmor)
		SetItemHealthPercent(PlayerRef,0,akArmor.GetSlotMask() ,calculateArmorHealth(akArmor))
		GrantExperience(akArmor AS FORM)
	ELSE
		Debug.Notification("You can only temper equipped armors")
	ENDIF
ENDFUNCTION

FLOAT FUNCTION calculateWeaponHealth(WEAPON akWeapon)
	RETURN 1.0 + akWeapon.GetBaseDamage() * 0.0006 * MenuMain.GUI_Hotkey_TemperMag * PlayerRef.GetAV("Smithing") * (1.0 + PlayerRef.GetAV("SmithingMod")) * (1.0 + PlayerRef.GetAV("SmithingPowerMod"))
ENDFUNCTION

FLOAT FUNCTION calculateArmorHealth(ARMOR akArmor)
	IF akArmor.IsCuirass()
		RETURN 1.0 + akArmor.GetAR() * 0.0002 * MenuMain.GUI_Hotkey_TemperMag * PlayerRef.GetAV("Smithing") * (1.0 + PlayerRef.GetAV("SmithingMod")) * (1.0 + PlayerRef.GetAV("SmithingPowerMod"))
	ELSE
		RETURN 1.0 + akArmor.GetAR() * 0.0004 * MenuMain.GUI_Hotkey_TemperMag * PlayerRef.GetAV("Smithing") * (1.0 + PlayerRef.GetAV("SmithingMod")) * (1.0 + PlayerRef.GetAV("SmithingPowerMod"))
	ENDIF
ENDFUNCTION

KEYWORD PROPERTY WeapMaterialDaedric AUTO
KEYWORD PROPERTY WeapMaterialDraugr AUTO
KEYWORD PROPERTY WeapMaterialDraugrHoned AUTO
KEYWORD PROPERTY WeapMaterialDwarven AUTO
KEYWORD PROPERTY WeapMaterialEbony AUTO
KEYWORD PROPERTY WeapMaterialElven AUTO
KEYWORD PROPERTY WeapMaterialFalmer AUTO
KEYWORD PROPERTY WeapMaterialFalmerHoned AUTO
KEYWORD PROPERTY WeapMaterialGlass AUTO
KEYWORD PROPERTY WeapMaterialImperial AUTO
KEYWORD PROPERTY WeapMaterialIron AUTO
KEYWORD PROPERTY WeapMaterialOrcish AUTO
KEYWORD PROPERTY WeapMaterialSilver AUTO
KEYWORD PROPERTY WeapMaterialSteel AUTO

BOOL FUNCTION removeWeaponMaterial(WEAPON akWeapon)
	IF akWeapon.HasKeywordString("DLC1WeapMaterialDragonbone")
		RETURN boolRemoveItem(DragonBone)
	ELSEIF akWeapon.HasKeyword(WeapMaterialDaedric) || akWeapon.HasKeyword(WeapMaterialEbony)
		RETURN boolRemoveItem(IngotEbony)
	ELSEIF akWeapon.HasKeyword(WeapMaterialGlass)
		RETURN boolRemoveItem(IngotMalachite)
	ELSEIF akWeapon.HasKeywordString("DLC2WeaponMaterialStalhrim")
		RETURN boolRemoveItem(GetFormFromFile(0x0002B06B,"Dragonborn.esm"))
	ELSEIF akWeapon.HasKeywordString("DLC2WeaponMaterialNordic")
		RETURN boolRemoveItem(IngotQuicksilver)
	ELSEIF akWeapon.HasKeyword(WeapMaterialElven)
		RETURN boolRemoveItem(IngotIMoonstone)
	ELSEIF akWeapon.HasKeyword(WeapMaterialOrcish)
		RETURN boolRemoveItem(IngotOrichalcum)
	ELSEIF akWeapon.HasKeyword(WeapMaterialDwarven)
		RETURN boolRemoveItem(IngotDwarven)
	ELSEIF akWeapon.HasKeyword(WeapMaterialIron)
		RETURN boolRemoveItem(IngotIron)
	;ELSEIF akWeapon.HasKeyword(WeapMaterialDraugr) || akWeapon.HasKeyword(WeapMaterialDraugrHoned) || akWeapon.HasKeyword(WeapMaterialSteel) || akWeapon.HasKeyword(WeapMaterialImperial) || akWeapon.HasKeyword(WeapMaterialSilver)
	;	RETURN boolRemoveItem(IngotSteel)
	ELSEIF akWeapon.HasKeyword(WeapMaterialFalmer) || akWeapon.HasKeyword(WeapMaterialFalmerHoned)
		RETURN boolRemoveItem(ChaurusChitin)
	ELSE
		RETURN boolRemoveItem(IngotSteel)
	ENDIF
	Debug.Notification("No recognized keywords on this weapon")
	RETURN false
ENDFUNCTION

KEYWORD PROPERTY ArmorMaterialBlades AUTO
KEYWORD PROPERTY ArmorMaterialDaedric AUTO
KEYWORD PROPERTY ArmorMaterialDragonplate AUTO
KEYWORD PROPERTY ArmorMaterialDragonscale AUTO
KEYWORD PROPERTY ArmorMaterialDwarven AUTO
KEYWORD PROPERTY ArmorMaterialEbony AUTO
KEYWORD PROPERTY ArmorMaterialElven AUTO
KEYWORD PROPERTY ArmorMaterialFalmer AUTO
KEYWORD PROPERTY ArmorMaterialGlass AUTO
KEYWORD PROPERTY ArmorMaterialImperialHeavy AUTO
KEYWORD PROPERTY ArmorMaterialImperialStudded AUTO
KEYWORD PROPERTY ArmorMaterialIron AUTO
KEYWORD PROPERTY ArmorMaterialIronBanded AUTO
KEYWORD PROPERTY ArmorMaterialOrcish AUTO
KEYWORD PROPERTY ArmorMaterialScaled AUTO
KEYWORD PROPERTY ArmorMaterialSteel AUTO
KEYWORD PROPERTY ArmorMaterialSteelPlate AUTO

;KEYWORD PROPERTY ArmorMaterialPenitus AUTO
;KEYWORD PROPERTY ArmorMaterialBearStormcloak AUTO
;KEYWORD PROPERTY ArmorMaterialForsworn AUTO
;KEYWORD PROPERTY ArmorMaterialHide AUTO
;KEYWORD PROPERTY ArmorMaterialImperialLight AUTO
;KEYWORD PROPERTY ArmorMaterialLeather AUTO
;KEYWORD PROPERTY ArmorMaterialStormcloak AUTO
;KEYWORD PROPERTY ArmorMaterialThievesGuild AUTO
;KEYWORD PROPERTY ArmorMaterialThievesGuildLeader AUTO

FORM PROPERTY Leather01 AUTO
FORM PROPERTY IngotSteel AUTO
FORM PROPERTY IngotEbony AUTO
FORM PROPERTY DragonBone AUTO
FORM PROPERTY DragonScales AUTO
FORM PROPERTY IngotDwarven AUTO
FORM PROPERTY IngotIMoonstone AUTO
FORM PROPERTY ChaurusChitin AUTO
FORM PROPERTY IngotMalachite AUTO
FORM PROPERTY IngotIron AUTO
FORM PROPERTY IngotCorundum AUTO
FORM PROPERTY IngotOrichalcum AUTO
FORM PROPERTY IngotQuicksilver AUTO
FORM PROPERTY Bonemeal AUTO

BOOL FUNCTION removeArmorMaterial(ARMOR akArmor)
	IF akArmor.HasKeyword(ArmorMaterialDragonplate)
		RETURN boolRemoveItem(DragonBone)
	ELSEIF akArmor.HasKeyword(ArmorMaterialDragonscale)
		RETURN boolRemoveItem(DragonScales)
	ELSEIF akArmor.HasKeyword(ArmorMaterialDaedric) || akArmor.HasKeyword(ArmorMaterialEbony)
		RETURN boolRemoveItem(IngotEbony)
	ELSEIF akArmor.HasKeyword(ArmorMaterialGlass)
		RETURN boolRemoveItem(IngotMalachite)
	ELSEIF akArmor.HasKeywordString("DLC2ArmorMaterialStalhrimHeavy") || akArmor.HasKeywordString("DLC2ArmorMaterialStalhrimLight")
		RETURN boolRemoveItem(GetFormFromFile(0x0002B06B,"Dragonborn.esm"))
	ELSEIF akArmor.HasKeywordString("DLC2ArmorMaterialNordicHeavy")
		RETURN boolRemoveItem(IngotQuicksilver)
	ELSEIF akArmor.HasKeyword(ArmorMaterialElven)
		RETURN boolRemoveItem(IngotIMoonstone)
	ELSEIF akArmor.HasKeyword(ArmorMaterialOrcish)
		RETURN boolRemoveItem(IngotOrichalcum)
	ELSEIF akArmor.HasKeyword(ArmorMaterialDwarven)
		RETURN boolRemoveItem(IngotDwarven)
	ELSEIF akArmor.HasKeyword(ArmorMaterialSteelPlate) || akArmor.HasKeyword(ArmorMaterialIronBanded) || akArmor.HasKeyword(ArmorMaterialScaled)
		RETURN boolRemoveItem(IngotCorundum)
	ELSEIF akArmor.HasKeyword(ArmorMaterialImperialStudded) || akArmor.HasKeyword(ArmorMaterialIron)
		RETURN boolRemoveItem(IngotIron)
	;ELSEIF akArmor.HasKeyword(ArmorMaterialBlades) || akArmor.HasKeyword(ArmorMaterialImperialHeavy) || akArmor.HasKeyword(ArmorMaterialSteel) || akArmor.HasKeywordString("DLC1ArmorMaterialDawnguard") || akArmor.HasKeywordString("DLC1ArmorMaterialHunter")
	;	RETURN boolRemoveItem(IngotSteel)
	;ELSEIF akArmor.HasKeyword(ArmorMaterialThievesGuild) || akArmor.HasKeyword(ArmorMaterialThievesGuildLeader) || akArmor.HasKeyword(ArmorMaterialStormcloak) || akArmor.HasKeyword(ArmorMaterialBearStormcloak)
	;		|| akArmor.HasKeyword(ArmorMaterialForsworn) || akArmor.HasKeyword(ArmorMaterialHide) || akArmor.HasKeyword(ArmorMaterialImperialLight) || akArmor.HasKeyword(ArmorMaterialLeather)
	;		|| akArmor.HasKeyword(ArmorMaterialPenitus) || akArmor.HasKeywordString("DLC1ArmorMaterialVampire") || akArmor.HasKeywordString("DLC2ArmorMaterialMoragTong")
	;	RETURN boolRemoveItem(Leather01)
	ELSEIF akArmor.HasKeywordString("DLC2ArmorMaterialBonemoldHeavy") || akArmor.HasKeywordString("DLC2ArmorMaterialBonemoldLight")
		RETURN boolRemoveItem(Bonemeal)
	ELSEIF akArmor.HasKeywordString("DLC2ArmorMaterialChitinHeavy") || akArmor.HasKeywordString("DLC2ArmorMaterialChitinLight")
		RETURN boolRemoveItem(GetFormFromFile(0x0002B04E,"Dragonborn.esm"))
	ELSEIF akArmor.HasKeyword(ArmorMaterialFalmer) || akArmor.HasKeywordString("DLC1ArmorMaterialFalmerHardened") || akArmor.HasKeywordString("DLC1ArmorMaterielFalmerHeavy") || akArmor.HasKeywordString("DLC1ArmorMaterielFalmerHeavyOriginal")
		RETURN boolRemoveItem(ChaurusChitin)
	ELSEIF akArmor.IsHeavyArmor()
		RETURN boolRemoveItem(IngotSteel)
	ELSEIF akArmor.IsLightArmor()
		RETURN boolRemoveItem(Leather01)
	ENDIF
	Debug.Notification("No recognized keywords on this armor")
	RETURN false
ENDFUNCTION

BOOL FUNCTION boolRemoveItem(FORM akItem)
	IF PlayerRef.GetItemCount(akItem) > 0
		PlayerRef.RemoveItem(akItem)
		RETURN true
	ELSE
		Debug.Notification("You need 1 " + akItem.GetName() + " to temper that")
		RETURN false
	ENDIF
ENDFUNCTION

FUNCTION grantExperience(FORM akForm)
	AdvanceSkill("Smithing", GetGamesettingFloat("fTemperingSkillUseItemValConst") + GetGamesettingFloat("fTemperingSkillUseItemValMult") * Math.Pow(akForm.GetGoldValue()*0.5,GetGamesettingFloat("fTemperingSkillUseItemValExp")) )
ENDFUNCTION