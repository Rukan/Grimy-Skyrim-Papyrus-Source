Scriptname GUI_Script_CraftingHotkeys extends activemagiceffect  

IMPORT DienesToolsPluginScript
IMPORT Game
IMPORT UI
IMPORT Math
IMPORT ActorValueInfo
FORMLIST PROPERTY GUI_EmptyList AUTO
GUI_MenuMain PROPERTY MenuMain AUTO
QUEST PROPERTY UILib AUTO

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	RegisterForMenu("Crafting Menu")
ENDEVENT

EVENT OnPlayerLoadGame()
	RegisterForMenu("Crafting Menu")
ENDEVENT

EVENT OnMenuOpen(String MenuName)
	RegisterForKey(MenuMain.GUI_Hotkey_CraftX)
	RegisterForKey(MenuMain.GUI_Hotkey_ForgetEnchantment)
	RegisterForKey(MenuMain.GUI_Hotkey_InspectKey)
ENDEVENT

EVENT OnMenuClose(String MenuName)
	UnregisterForAllKeys()
ENDEVENT

KEYWORD PROPERTY CraftingSmithingForge AUTO
KEYWORD PROPERTY CraftingSmithingSkyForge AUTO
EVENT OnKeyDown(Int KeyCode)
	IF !isMenuOpen("Console") && !isMenuOpen("CustomMenu") && !((UILib as FORM) as UILIB_GRIMY).IsMenuOpen()
		FORM akForm = GetFormEx(GetInt("Crafting Menu", "_root.Menu.InventoryLists.itemList.selectedEntry.formId"))
		IF KeyCode == MenuMain.GUI_Hotkey_CraftX
			GetAllCOBJThatYieldForm(akForm,GUI_EmptyList)
			CONSTRUCTIBLEOBJECT akCobj = getCobj(GUI_EmptyList)
			IF akCobj != None
				INT Result = ((UILib AS FORM) AS UILIB_GRIMY).ShowTextInput("How Many?",1) AS INT
				IF checkMaterials(Result, akCobj)
					PlayerRef.AddItem(akForm,Result * akCobj.GetResultQuantity())
					KEYWORD tempKey = akCobj.GetWorkbenchKeyword()
					IF ( tempKey == CraftingSmithingForge ) ||  ( tempKey == CraftingSmithingSkyForge )
						grantExperience("Smithing",Result,akForm)
					ELSEIF ( tempKey == GetFormFromFile(0x002BDD34,"Grimy_Skill_Expansions.esp") ) || ( tempKey == GetFormFromFile(0x002FFB90,"Grimy_Skill_Expansions.esp") )
						grantExperience("Alchemy",Result,akForm)
					ENDIF
				ELSE
					Debug.Notification("Not Enough Materials")
				ENDIF
			ELSE 
				Debug.Notification("No Recipe Found for " + akForm.GetName())
			ENDIF
			GUI_EmptyList.Revert()
		ELSEIF KeyCode == MenuMain.GUI_Hotkey_ForgetEnchantment
			IF akForm AS ENCHANTMENT
				akForm.SetPlayerKnows(false)
				SetString("Crafting Menu", "_root.Menu.InventoryLists.itemList.selectedEntry.text","Deleted")
				InvokeBool("Crafting Menu", "_root.Menu.UpdateItemList",False)
			ELSE 
				Debug.Notification(akForm.GetName() + " Is not an enchantment.")
			ENDIF
		ELSE
			MenuMain.inspectForm(akForm)
		ENDIF 
	ENDIF
ENDEVENT

KEYWORD PROPERTY CraftingSmithingArmorTable AUTO
KEYWORD PROPERTY CraftingSmithingSharpeningWheel AUTO
CONSTRUCTIBLEOBJECT FUNCTION getCobj(FORMLIST akFormlist)
	;this searches through the list of akCobj records until it 
	KEYWORD tempKey
	int i = 0
	WHILE i < akFormlist.GetSize()
		tempKey = ( akFormList.GetAt(i) AS CONSTRUCTIBLEOBJECT ).GetWorkbenchKeyword()
		IF ( tempKey != CraftingSmithingArmorTable ) && ( tempKey != CraftingSmithingSharpeningWheel )
			RETURN akFormList.GetAt(i) AS CONSTRUCTIBLEOBJECT
		ENDIF
		i += 1
	ENDWHILE
	RETURN None
ENDFUNCTION

ACTOR PROPERTY PlayerRef AUTO
BOOL FUNCTION checkMaterials(INT akCount, CONSTRUCTIBLEOBJECT akCobj)
	IF akCount <= 0
		RETURN false
	ENDIF
	IF akCobj == None
		Debug.Notification("No Recipes Detected")
		RETURN false
	ENDIF
	int i = 0
	WHILE i < akCobj.GetNumIngredients()
		IF PlayerRef.GetItemCount(akCobj.GetNthIngredient(i)) < akCount * akCobj.GetNthIngredientQuantity(i)
			RETURN false
		ENDIF
		i += 1
	ENDWHILE
	i = 0
	WHILE i < akCobj.GetNumIngredients()
		PlayerRef.RemoveItem(akCobj.GetNthIngredient(i),akCount * akCobj.GetNthIngredientQuantity(i))
		i += 1
	ENDWHILE
	RETURN true
ENDFUNCTION

FUNCTION grantExperience(STRING akSkill, INT akCount, FORM akForm)
	;Debug.Notification( GetGamesettingFloat("fConstructibleSkillUseConst") + " " + GetGamesettingFloat("fConstructibleSkillUseMult") + " " + GetGamesettingFloat("fConstructibleSkilluseExp") + " " + akForm.GetGoldValue() )
	FLOAT exp = akCount * ( GetGamesettingFloat("fConstructibleSkillUseConst") + (GetGamesettingFloat("fConstructibleSkillUseMult") * pow(akForm.GetGoldValue(), GetGamesettingFloat("fConstructibleSkilluseExp")) ) )
	IF exp > 0
		AdvanceSkill(akSkill,exp)
	ENDIF
ENDFUNCTION