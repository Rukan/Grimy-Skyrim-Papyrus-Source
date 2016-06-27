scriptName GBT_Script_TimedBlock extends activemagiceffect

perk property GBT_Invincibility_Block auto
actor property PlayerRef auto
keyword property MagicWard auto
GrimyMenuMain Property GBT_MainMenu Auto
Import Game
Import Debug

Event OnEffectFinish(actor akTarget, actor akCaster)
	UnregisterForAnimationEvent(PlayerRef, "blockStartOut")
	UnregisterForAnimationEvent(PlayerRef, "blockStop")
	GotoState("Dead")
EndEvent

Event OnEffectStart(actor akTarget, actor akCaster)
	RegisterForAnimationEvent(PlayerRef, "blockStartOut")
	RegisterForAnimationEvent(PlayerRef, "blockStop")
	GotoState("Neutral")
EndEvent

Event OnPlayerLoadGame()
	RegisterForAnimationEvent(PlayerRef, "blockStartOut")
	RegisterForAnimationEvent(PlayerRef, "blockStop")
EndEvent

;-- State -------------------------------------------
state Blocking
	Event OnUpdate()
		GotoState("Neutral")
	EndEvent

	Event OnAnimationEvent(objectreference akSource, String asEventName)
		if asEventName == "blockStop"
			UnregisterForUpdate()
			GotoState("Neutral")
		endIf
	EndEvent

	Event onBeginState()
		if PlayerRef.GetEquippedShield() == none
			RegisterForSingleUpdate(GBT_MainMenu.GetGBT_timeBlockWeapon_Float())
		else
			RegisterForSingleUpdate(GBT_MainMenu.GetGBT_timeBlockShield_Float())
		endIf
	EndEvent
endState

state Dead
endState

state Neutral
	Event OnSpellCast(Form akSpell)
		if akSpell.HasKeyword(MagicWard)
			GotoState("Warding")
		endIf
	EndEvent

	Event OnAnimationEvent(objectreference akSource, String asEventName)
		if asEventName == "blockStartOut"
			PlayerRef.AddPerk(GBT_Invincibility_Block)
			if GBT_MainMenu.GetGBT_timeBlockReflect_Float() == 0.000000
				GotoState("Blocking")
			else
				GotoState("Reflecting")
			endIf
		endIf
	EndEvent

	Event onBeginState()
		PlayerRef.RemovePerk(GBT_Invincibility_Block)
	EndEvent
endState

state Warding
	Event OnWardHit(objectreference akCaster, Spell akSpell, Int aiStatus)
		if akSpell.isHostile()
			akSpell.Cast(PlayerRef, akCaster)
			UnregisterForUpdate()
			GotoState("Neutral")
		endIf
	EndEvent

	Event OnUpdate()
		GotoState("Neutral")
	EndEvent

	Event onBeginState()
		RegisterForSingleUpdate(GBT_MainMenu.GetGBT_timeBlockWard_Float())
	EndEvent
endState

state Reflecting
	Event OnUpdate()
		GotoState("Blocking")
	EndEvent

	Event OnAnimationEvent(objectreference akSource, String asEventName)
		if asEventName == "blockStop"
			UnregisterForUpdate()
			GotoState("Neutral")
		endIf
	EndEvent

	Event OnHit(objectreference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)
		if abHitBlocked
			AdvanceSkill("Block", GBT_MainMenu.GetGBT_timeBlockXP_Float())
			SendAnimationEvent(akAggressor, "staggerStart")
			(akAggressor as actor).DamageActorValue("Stamina", GBT_MainMenu.GetGBT_timeBlockDamage_Float() * (1 as Float + 0.00500000 * PlayerRef.GetActorValue("Block")) * (1 as Float + 0.0100000 * PlayerRef.GetActorValue("BlockMod")) * (1 as Float + 0.0100000 * PlayerRef.GetActorValue("BlockPowerMod")))
		endIf
	EndEvent

	Event onBeginState()
		RegisterForSingleUpdate(GBT_MainMenu.GetGBT_timeBlockReflect_Float())
	EndEvent
endState
