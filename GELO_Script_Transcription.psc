Scriptname GELO_Script_Transcription extends activemagiceffect  

GELO_MenuMain Property GELO_MainMenu AUTO
ACTOR PROPERTY PlayerRef AUTO

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForMenu("Sleep/Wait Menu")
EndEvent

Event OnPlayerLoadGame()
	RegisterForMenu("Sleep/Wait Menu")
EndEvent

Event OnMenuClose(String MenuName)
	INT i = 0
	INT delta
	WHILE i < GELO_MainMenu.SignatureScrollList.Length
		IF GELO_MainMenu.SignatureScrollList[i]
			delta = GELO_MainMenu.ScrollCount - PlayerRef.GetItemCount(GELO_MainMenu.SignatureScrollList[i])
			IF delta > 0
				Refill(GELO_MainMenu.SignatureScrollList[i],delta)
			ENDIF
		ENDIF
		i += 1
	ENDWHILE
	Debug.Notification("Scrolls Restocked")
EndEvent

FORM PROPERTY GrimyArcaneDust AUTO
FORM PROPERTY Charcoal AUTO
FORM PROPERTY PaperRoll AUTO
Function Refill(SCROLL akScroll, INT akNum)
	int akCount = akNum
	
	IF PlayerRef.GetItemCount(GrimyArcaneDust) < akCount
		akCount = PlayerRef.GetItemCount(GrimyArcaneDust)
	ENDIF
	IF PlayerRef.GetItemCount(Charcoal) < akCount
		akCount = PlayerRef.GetItemCount(Charcoal)
	ENDIF
	IF PlayerRef.GetItemCount(PaperRoll) < akCount
		akCount = PlayerRef.GetItemCount(PaperRoll)
	ENDIF

	PlayerRef.RemoveItem(GrimyArcaneDust,akCount,true)
	PlayerRef.RemoveItem(Charcoal,akCount,true)
	PlayerRef.RemoveItem(PaperRoll,akCount,true)
	PlayerRef.AddItem(akScroll,akCount,true)
EndFunction