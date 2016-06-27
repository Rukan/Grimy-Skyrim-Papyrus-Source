;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SF_ORD_ThePowerIsMine_Quest__0102A518 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Game.SetPlayerAIDriven(false)
Game.EnablePlayerControls()
Game.GetPlayer().DispelSpell(ORD_Des_ThePowerIsMine_Spell)
Game.GetPlayer().PlayIdle(ORD_ResetIdle)
Game.GetPlayer().DrawWeapon()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Game.ForceThirdPerson()
Game.SetPlayerAIDriven(true)
Game.DisablePlayerControls(true, true, true, false, true, true, true, false, 0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SPELL Property ORD_Des_ThePowerIsMine_Spell  Auto  

Idle Property ORD_ResetIdle  Auto  
