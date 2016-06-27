Scriptname GSA_RecoilEffect extends activemagiceffect  

IMPORT utility
PERK PROPERTY GSA_WPerk_Recoil AUTO
ACTOR PROPERTY PlayerRef AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	GSA_WPerk_Recoil.SetNthEntryValue(0,0,1.0+GetMagnitude()/100.0)
	RegisterForAnimations()
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	GSA_WPerk_Recoil.SetNthEntryValue(0,0,1.0+GetMagnitude()/100.0)
ENDEVENT

EVENT OnInit()
	GSA_WPerk_Recoil.SetNthEntryValue(0,0,1.0+GetMagnitude()/100.0)
ENDEVENT

EVENT OnPlayerLoadGame()
	RegisterForAnimations()
ENDEVENT

FUNCTION RegisterForAnimations()
	RegisterForAnimationEvent(PlayerRef,"arrowRelease")
ENDFUNCTION

EVENT OnAnimationEvent(ObjectReference akSender, String akEvent)
	Game.ShakeCamera(PlayerRef,0.5,0.3)
	;PlayerRef.SetAngle(PlayerRef.GetAngleX() + RandomFloat(-1.0,1.0),PlayerRef.GetAngleY()+ RandomFloat(-1.0,1.0),PlayerRef.GetAngleZ()+ RandomFloat(-1.0,1.0))
ENDEVENT

