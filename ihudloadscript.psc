Scriptname iHUDLoadScript extends ReferenceAlias  

iHUDMaintainanceScript Property iHUDMaintainance auto
iHUDControlScript Property iHUDControl auto
 
Event OnInit()
	iHUDMaintainance.startUp()
EndEvent

Event OnPlayerLoadGame()
	iHUDMaintainance.startUp()
EndEvent