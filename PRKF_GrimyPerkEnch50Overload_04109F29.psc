;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 54
Scriptname PRKF_GrimyPerkEnch50Overload_04109F29 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_46
Function Fragment_46(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
FLOAT Result = ((UILib as FORM) as UILIB_GRIMY).ShowList("Adjust # Enchant Effects", OverloadList, GrimyPerkEnchCount.GetNthEntryValue(0,0) AS INT - 1, GrimyPerkEnchCount.GetNthEntryValue(0,0) AS INT - 1) AS FLOAT + 1.0
GrimyPerkEnchMagnitude.SetNthEntryValue(0,0,0.75 / Result + 0.25)
GrimyPerkEnchCount.SetNthEntryValue(0,0,Result)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QUEST PROPERTY UILib AUTO
STRING[] PROPERTY OverloadList AUTO
PERK PROPERTY GrimyPerkEnchCount AUTO
PERK PROPERTY GrimyPerkEnchMagnitude AUTO
