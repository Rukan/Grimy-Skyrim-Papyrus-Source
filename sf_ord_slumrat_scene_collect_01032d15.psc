;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SF_ORD_SlumRat_Scene_Collect_01032D15 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
ORD_Pic_TrainedRabbit_Message_Return.Show()
Game.GetPlayer().DispelSpell(ORD_Pic_TrainedRabbit_Spell)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


Message Property ORD_Pic_TrainedRabbit_Message_Return  Auto  

SPELL Property ORD_Pic_TrainedRabbit_Spell  Auto  
