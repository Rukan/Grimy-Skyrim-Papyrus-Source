scriptName GBT_Script_PlayerStagger extends activemagiceffect

actor property PlayerRef auto
keyword property MagicWard auto
keyword property MagicCloak auto
GrimyMenuMain Property GBT_MainMenu Auto

Int sourceType = 22
Float staggerDuration = 1.00000
Float headingAngle = 0.000000
Import Game
Import Debug

function animateStagger(ObjectReference akAggressor)
	headingAngle = PlayerRef.GetHeadingAngle(akAggressor)
	if headingAngle > 45 as Float
		if headingAngle > 135 as Float
			SendAnimationEvent(PlayerRef, "NPC_BumpedFromBack")
		else
			SendAnimationEvent(PlayerRef, "NPC_BumpedFromRight")
		endIf
	elseIf headingAngle < -45 as Float
		if headingAngle < (-135) as Float
			SendAnimationEvent(PlayerRef, "NPC_BumpedFromBack")
		else
			SendAnimationEvent(PlayerRef, "NPC_BumpedFromLeft")
		endIf
	else
		SendAnimationEvent(PlayerRef, "StaggerStart")
	endIf
endFunction

Event OnEffectFinish(actor akTarget, actor akCaster)
	EnablePlayerControls(true, false, false, false, false, false, false, false, 0)
	GotoState("Dead")
EndEvent

Event OnEffectStart(actor akTarget, actor akCaster)
	EnablePlayerControls(true, false, false, false, false, false, false, false, 0)
	GotoState("Neutral")
EndEvent

Float function getItemWeight(form akItem)

	if akItem == none
		return 0 as Float
	else
		return akItem.GetWeight()
	endIf
endFunction

Float function getArmorWeight()

	return getItemWeight(PlayerRef.GetWornForm(1)) + getItemWeight(PlayerRef.GetWornForm(4)) + getItemWeight(PlayerRef.GetWornForm(8)) + getItemWeight(PlayerRef.GetWornForm(128)) + getItemWeight(PlayerRef.GetWornForm(512))
endFunction

state Dead
endState

state Neutral
	Event OnHit(ObjectReference akAggressor, form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)
		if !abHitBlocked
			staggerDuration = GBT_MainMenu.GetGBT_staggerTaken_Float() / (1 as Float + getArmorWeight() / GBT_MainMenu.GetGBT_staggerArmor_Float())
			sourceType = akSource.GetType()
			if sourceType == 22
				if (akSource as spell).IsHostile() && !(akSource as spell).HasKeyword(MagicCloak) && (!PlayerRef.HasEffectKeyword(MagicWard) || PlayerRef.GetHeadingAngle(akAggressor) > 45 as Float)
					staggerDuration *= (akSource as spell).GetMagickaCost() as Float / GBT_MainMenu.GetGBT_staggerMagicka_Float()
				else
					staggerDuration = 0 as Float
				endIf
			elseIf sourceType == 41
				staggerDuration *= getItemWeight(akSource) / (akSource as weapon).GetSpeed() / 15.0000
			elseIf sourceType == 87
				staggerDuration = 0 as Float
			else
				staggerDuration *= 0.600000
			endIf
			if staggerDuration > GBT_MainMenu.GetGBT_staggerMax_Float()
				staggerDuration = GBT_MainMenu.GetGBT_staggerMax_Float()
			endIf
			if staggerDuration > GBT_MainMenu.GetGBT_staggerMin_Float()
				animateStagger(akAggressor)
			endIf
			GotoState("Staggered")
		endIf
	EndEvent
endState

state immunity
	Event OnUpdate()
		GotoState("Neutral")
	EndEvent

	Event onBeginState()

		EnablePlayerControls(true, false, false, false, false, false, false, false, 0)
		RegisterForSingleUpdate(GBT_MainMenu.GetGBT_staggerImmunity_Float())
	EndEvent
endState

state Staggered
	Event OnUpdate()
		EnablePlayerControls(true, false, false, false, false, false, false, false, 0)
		SendAnimationEvent(PlayerRef, "StaggerStop")
		GotoState("immunity")
	EndEvent

	Event onBeginState()
		DisablePlayerControls(true, false, false, false, false, false, false, false, 0)
		RegisterForSingleUpdate(staggerDuration)
	EndEvent
endState
