;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SF_ORD_Performer_Quest_Scene_0102077B Extends Scene Hidden

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
Sound SoundToPlay = ORD_Sound[Utility.RandomInt(0,ORD_Sound.Length - 1)]
SoundID = SoundToPlay.Play(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Idle Property ORD_ResetIdle  Auto  

SPELL Property ORD_Spe_Perform_Spell  Auto  

Int SoundID

Sound[] Property ORD_Sound  Auto  

SPELL Property ORD_Spe_Perform_Spell_LesserPower  Auto  
