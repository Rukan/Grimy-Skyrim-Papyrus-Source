Scriptname DLC1WE02Script extends Quest  
{Script attached to DLC1WE02}

quest property DLC1WE02 Auto
referenceAlias Property Actor1 auto
spell Property WerewolfChangeFX auto

int distanceToCheck = 500

Event OnUpdate()
	;Debug.Trace(self + "OnUpdate()")
	if( DLC1WE02.IsRunning() )
		if Game.GetPlayer().GetDistance(Actor1.GetActorRef()) <= distanceToCheck
			changeIntoWerewolf()
		else
			RegisterForSingleUpdate(1)
		endif
	Else
		;Do nothing. This script has no business running if the quest isn't. Modification by UDGP 1.1.2.
	EndIf
EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	changeIntoWerewolf()
EndEvent
	

function changeIntoWerewolf()
	;Debug.Trace(self + "changeIntoWerewolf()")
	Actor ActorRef = Actor1.GetActorReference()
	WerewolfChangeFX.Cast(ActorRef)
	ActorRef.setAv("aggression", 3)

endfunction
