Scriptname GVC_Script_ToxicSheathe extends activemagiceffect  

EVENT OnAnimationEvent(ObjectReference akSource, string asEventName)
	PlayerRef.EquipItem(GVC_Hemotoxin02,false,true)
ENDEVENT

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForAnimationEvent(PlayerRef, "WeapEquip")
ENDEVENT

ACTOR PROPERTY PlayerRef AUTO
POTION PROPERTY GVC_Hemotoxin02 AUTO