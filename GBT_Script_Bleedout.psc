scriptName GBT_Script_Bleedout extends activemagiceffect

actor property PlayerRef auto
message property GBT_LivesMessage auto
form property Gold001 auto
GrimyMenuMain Property GBT_MainMenu Auto
Int numLives = 3
Import Game

Int bleedoutPrice
Bool isFirstPerson

Event OnPlayerLoadGame()
	RegisterForSleep()
EndEvent

Event OnSleepStop(Bool abInterrupted)
	if !abInterrupted
		numLives = GBT_MainMenu.GetGBT_bleedoutLivesMax_Int()
		adjustEssential()
	endIf
EndEvent

Event OnEnterBleedout()
	if GetCameraState() == 1 || GetCameraState() == 4
		isFirstPerson = true
	endIf
	bleedoutPrice = (PlayerRef.GetItemCount(Gold001) as Float * GBT_MainMenu.GetGBT_bleedoutBase_Float()) as Int + PlayerRef.GetLevel() * GBT_MainMenu.GetGBT_bleedoutMult_Int()
	if PlayerRef.GetItemCount(Gold001) >= bleedoutPrice && numLives > 0
		PlayerRef.RemoveItem(Gold001, bleedoutPrice, true, none)
		numLives -= 1
		GBT_LivesMessage.Show(numLives as Float, GBT_MainMenu.GetGBT_bleedoutLivesMax_Int() as Float, bleedoutPrice as Float)
		adjustEssential()
		PlayerRef.StopCombatAlarm()
		utility.Wait(5.00000)
		PlayerRef.ResetHealthAndLimbs()
		if isFirstPerson
			ForceFirstPerson()
		endIf
	else
		PlayerRef.KillEssential(none)
	endIf
EndEvent

Event OnEffectFinish(actor akTarget, actor akCaster)
	PlayerRef.GetActorBase().SetEssential(false)
EndEvent

function adjustEssential()
	if numLives > 0
		PlayerRef.GetActorBase().SetEssential(true)
	else
		PlayerRef.GetActorBase().SetEssential(false)
	endIf
endFunction

Event OnEffectStart(actor akTarget, actor akCaster)
	RegisterForSleep()
	adjustEssential()
EndEvent 