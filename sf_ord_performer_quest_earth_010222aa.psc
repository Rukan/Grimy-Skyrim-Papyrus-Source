;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SF_ORD_Performer_Quest_Earth_010222AA Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Sound.StopInstance(SoundID)
Game.SetPlayerAIDriven(false)
Game.GetPlayer().DispelSpell(ORD_Spe_Perform_Spell)
Game.GetPlayer().DispelSpell(ORD_Spe_Perform_Spell_LesserPower)
Game.GetPlayer().PlayIdle(ORD_ResetIdle)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Game.ForceThirdPerson()
Game.SetPlayerAIDriven(true)
Actor ThePlayer = Game.GetPlayer()
Sound SoundToPlay = ORD_Sound[Utility.RandomInt(0,ORD_Sound.Length - 1)]
SoundID = SoundToPlay.Play(ThePlayer)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Int SoundID

Sound[] Property ORD_Sound  Auto  

Idle Property ORD_ResetIdle  Auto  

SPELL Property ORD_Spe_Perform_Spell  Auto  

SPELL Property ORD_Spe_Perform_Spell_LesserPower  Auto  
