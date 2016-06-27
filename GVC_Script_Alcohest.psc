Scriptname GVC_Script_Alcohest extends activemagiceffect  

GVC_MenuMain Property GVC_MainMenu AUTO
ACTOR PROPERTY PlayerRef AUTO
IMPORT KMXPotionUtil

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForMenu("Sleep/Wait Menu")
EndEvent

Event OnPlayerLoadGame()
	RegisterForMenu("Sleep/Wait Menu")
EndEvent

Event OnMenuClose(String MenuName)
	INT i = 0
	INT delta
	WHILE i < GVC_MainMenu.SignaturePotionList.Length
		IF GVC_MainMenu.SignaturePotionList[i]
			IF GVC_MainMenu.SignaturePotionList[i] == None
				Debug.Notification("You can't refill a signature potion if you run out!")
				GVC_MainMenu.SignaturePotionList[i] = None
			ELSE
				delta = GVC_MainMenu.AlcohestCount - PlayerRef.GetItemCount(GVC_MainMenu.SignaturePotionList[i])
				IF delta > 0
					Refill(GVC_MainMenu.SignaturePotionList[i],delta)
				ENDIF
			ENDIF
		ENDIF
		i += 1
	ENDWHILE
	Debug.Notification("Potions Refilled, " + PlayerRef.GetItemCount(GVCAlcohest) + " Alcohest Remaining")
EndEvent

FORM PROPERTY GVCAlcohest AUTO
Function Refill(POTION akPotion, INT akNum)
	int akCount
	
	IF PlayerRef.GetItemCount(GVCAlcohest) < akNum
		akCount = PlayerRef.GetItemCount(GVCAlcohest)
	ELSE
		akCount = akNum
	ENDIF	

	PlayerRef.RemoveItem(GVCAlcohest,akCount,true)
	IF akPotion.GetFormID() >= 0xFF000000
		IncPotionRefCount(akPotion,akCount)
	ENDIF
	PlayerRef.AddItem(akPotion,akCount,true)
EndFunction