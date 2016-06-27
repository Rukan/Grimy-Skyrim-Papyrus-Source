scriptName GBT_Script_MeleeStaggerProjectile extends activemagiceffect

Spell property GBT_Stagger auto
GrimyMenuMain Property GBT_MainMenu Auto
IMPORT GrimyToolsPluginScript

ACTOR akSelf
WEAPON tempWeapon
Float fStagger

Event OnDying(ACTOR akKiller)
	Dispel()
EndEvent

Event OnUnload()
	Dispel()
EndEvent

Float function getItemWeight(form akItem)
	if akItem == none
		return 0 as Float
	else
		return akItem.GetWeight()
	endIf
endFunction

Event OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	akSelf = akTarget
	GotoState("Neutral")
EndEvent

Float function getArmorWeight()
	return getItemWeight(akSelf.GetWornForm(1)) + getItemWeight(akSelf.GetWornForm(4)) + getItemWeight(akSelf.GetWornForm(8)) + getItemWeight(akSelf.GetWornForm(128)) + getItemWeight(akSelf.GetWornForm(512))
endFunction

state Neutral
	Event OnHit(ObjectReference akAggressor, form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)
		tempWeapon = akSource as WEAPON
		if !abHitBlocked && !abBashAttack && !abPowerAttack
			if tempWeapon.GetWeaponType() < 7
				if tempWeapon
					fStagger = ((GBT_MainMenu.GetGBT_meleeStaggerMult_Float() * tempWeapon.GetStagger() + GBT_MainMenu.GetGBT_meleeStaggerBase_Float()) / (1.00000 + getArmorWeight() / GBT_MainMenu.GetGBT_meleeStaggerWeight_Float()))
				else
					fStagger = (GBT_MainMenu.GetGBT_meleeStaggerBase_Float() / (1.00000 + getArmorWeight() / GBT_MainMenu.GetGBT_meleeStaggerWeight_Float()))
				endIf
				SetSpellNthMagicEffectMagnitude(GBT_Stagger,fStagger,0)
				GBT_Stagger.Cast(akSelf as ObjectReference, none)
				GotoState("Cooldown")
			endIf
		endIf
	EndEvent
endState

state Cooldown
	Event onBeginState()
		RegisterForSingleUpdate(GBT_MainMenu.GetGBT_meleeStaggerCD_Float())
	EndEvent

	Event OnUpdate()
		GotoState("Neutral")
	EndEvent
endState
