Scriptname GrimyMagicSmeltMenu extends activemagiceffect  

ObjectReference Property CraftingSmelterMarker1 auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

CraftingSmelterMarker1.Activate(akCaster)

EndEvent