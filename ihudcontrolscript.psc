Scriptname iHUDControlScript extends Quest  

import iHUDUtilityScript

GlobalVariable Property iHUDKeyActionToggle Auto

GlobalVariable Property iHUDEnabled Auto
GlobalVariable Property iHUDCrosshairOnActivate auto
GlobalVariable Property iHUDCrosshairOnSpell auto
GlobalVariable Property iHUDCrosshairOnRanged auto
GlobalVariable Property iHUDCrosshairOnMelee auto
GlobalVariable Property iHUDCrosshairAlwaysVisible Auto

GlobalVariable Property iHUDMagickaFastFade auto
GlobalVariable Property iHUDStaminaFastFade auto
GlobalVariable Property iHUDHealthFastFade auto

GlobalVariable Property iHUDUpdateDelay auto

iHUDCompassScript Property iHUDCompass Auto
iHUDCrosshairScript Property iHUDCrosshair Auto
iHUDWidgetScript Property iHUDWidget Auto

iHUDEnemyHealthScript Property iHUDEnemyHealth Auto
iHUDMagickaBarScript Property iHUDMagickaBar Auto
iHUDHealthBarScript Property iHUDHealthBar Auto
iHUDStaminaBarScript Property iHUDStaminaBar Auto

Actor player

bool bowEquipped
bool meleeEquipped
bool targetSpellEquipped

float verticalOffset = 5000.0

Bool toggleOn
Bool keyHeld 

Bool compassOn
Bool openSettings

bool Function isActive()
	return iHUDEnabled != none && iHUDEnabled.GetValueInt() == 1
EndFunction

Function deactivate()
	UnRegisterForUpdate()
	GoToState("Inactive")
	
	iHUDCompass.show(true)
	
	iHUDCrosshair.show(true)
	iHUDCrosshair.showSneakMeter()
	
	iHUDStaminaBar.show(true)
	iHUDHealthBar.show(true)
	iHUDMagickaBar.show(true)
	
	iHUDEnemyHealth.reset()
EndFunction

Function startUp()
	UnRegisterForUpdate()
	player = Game.GetPlayer()
	
	iHUDEnemyHealth.calibrate()
	
	if !isActive()
		deactivate()
	endif	
	
	if iHUDMagickaFastFade.GetValueInt() > 1 || iHUDMagickaFastFade.GetValueInt() < 0
		iHUDMagickaFastFade.SetValueInt(0)
	endif

	if iHUDHealthFastFade.GetValueInt() > 1 || iHUDHealthFastFade.GetValueInt() < 0
		iHUDHealthFastFade.SetValueInt(0)
	endif
	
	if iHUDStaminaFastFade.GetValueInt() > 1 || iHUDStaminaFastFade.GetValueInt() < 0
		iHUDStaminaFastFade.SetValueInt(0)
	endif
	
	iHUDEnemyHealth.processEnemyHealth()
	
	iHUDMagickaBar.processMagickaBar()
	iHUDHealthBar.processHealthBar()
	iHUDStaminaBar.processStaminaBar()
	
	processEquipment()
	
	iHUDWidget.initialize()

	GoToState("Polling")	
	RegisterForSingleUpdate(0.1)		
EndFunction

bool Function isKeyActivated()
	return toggleOn || keyHeld
EndFunction

Function iHUDKeyPressed()
	if (iHUDKeyActionToggle.GetValueInt())
		toggleOn = !toggleOn
		keyHeld = false
	else
		toggleOn = false
		keyHeld = true
	endif
	processHUD()
EndFunction

Function iHUDKeyReleased(float holdTime)
	keyHeld = false
	processHUD()
EndFunction

Function processEquipment()	
	if (player == none)
		player = Game.GetPlayer()
		return
	endif

	bowEquipped = isRangedWeapon(player.GetEquippedWeapon(true)) || isRangedWeapon(player.GetEquippedWeapon(false)) 
	meleeEquipped = isMeleeWeapon(player.GetEquippedWeapon(true)) || isMeleeWeapon(player.GetEquippedWeapon(false)) 
	targetSpellEquipped = isTargettedSpell(player.GetEquippedSpell(0)) || isTargettedSpell(player.GetEquippedSpell(1))
EndFunction

State Polling
	Event OnUpdate()
		if !isActive()
			deactivate()

			return
		endif

		if !Utility.IsInMenuMode()
			processEquipment()
			processHUD()
		endif
		
		RegisterForSingleUpdate(iHUDUpdateDelay.getValue())
	EndEvent
EndState


Function processHUD()
	if (player == none)
		player = Game.GetPlayer()
		return
	endif
	
	iHUDCompass.show(isKeyActivated())
	iHUDWidget.processWidget(isKeyActivated())
	iHUDCrosshair.show(isCrosshairVisible())
	
	iHUDMagickaBar.processMagickaBar()
	iHUDHealthBar.processHealthBar()
	iHUDStaminaBar.processStaminaBar()
EndFunction

bool Function isCrosshairVisible()
	return !UI.IsMenuOpen("Dialogue Menu") && !UI.IsMenuOpen("Book Menu") && !UI.IsMenuOpen("MapMenu") && !player.IsInKillMove() && (iHUDCrosshairAlwaysVisible.getValueInt() || (player.isWeaponDrawn() && (isSpellActivatingCrosshair() || isRangedActivatingCrosshair() || isMeleeActivatingCrosshair())) || shouldShowActivateCrosshair())
EndFunction

bool Function isSpellActivatingCrosshair()
	return targetSpellEquipped && iHUDCrosshairOnSpell.GetValueInt() == 1
EndFunction

bool Function isRangedActivatingCrosshair()
	return bowEquipped && iHUDCrosshairOnRanged.GetValueInt() == 1
EndFunction

bool Function isMeleeActivatingCrosshair()
	return !bowEquipped && iHUDCrosshairOnMelee.GetValueInt() == 1
EndFunction

bool Function actorValueIsLessThanPercent(String actorValue, float percent)
	return player.GetActorValuePercentage(actorValue) < (percent / 100)
EndFunction

bool Function shouldShowActivateCrosshair()
	return iHUDCrosshairOnActivate.getValueInt() == 1 && hasActivateOption()
EndFunction 

Event OnUpdate()
	
EndEvent


