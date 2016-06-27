Scriptname GrimyTeleportToMarker extends activemagiceffect  

ObjectReference Property Marker Auto

Event OnEffectFinish(Actor akTarget, Actor akCaster)
        akTarget.MoveTo(Marker)
EndEvent