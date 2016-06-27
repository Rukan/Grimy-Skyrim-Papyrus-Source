;/ Decompiled by Champollion V1.0.1
Source   : GBT_enableOnHit_NPC.psc
Modified : 2013-05-07 10:46:20
Compiled : 2013-05-07 10:46:21
User     : Rukan
Computer : RUKAN-PC
/;
scriptName GBT_enableOnHit_NPC extends activemagiceffect

;-- Properties --------------------------------------

;-- Variables ---------------------------------------
ACTOR thisActor
Bool canStagger

;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

function OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)

	if !abHitBlocked
		debug.SendAnimationEvent(thisActor as ObjectReference, "StaggerStart")
	endIf
endFunction

function OnEffectStart(ACTOR akTarget, ACTOR akCaster)

	thisActor = akTarget
endFunction
