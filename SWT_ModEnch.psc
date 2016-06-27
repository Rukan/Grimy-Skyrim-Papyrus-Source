Scriptname SWT_ModEnch extends activemagiceffect  

Import WornObject
Int Property Slot Auto
Actor akActor
MagicEffect Property akMGEF Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akActor = akCaster
	ModCharge(Slot, 10.0)
EndEvent

Function ModCharge(int akSlot, float akCost)
	MagicEffect[] Effects = new MagicEffect[1]
	Float[] Mags = new Float[1]
	Int[] Durs = new Int[1]
	Int[] Areas = new Int[1]

	Enchantment akEnch = GetEnchantment(akActor, 0, akSlot)
	Effects[0] = akEnch.GetNthEffectMagicEffect(0)
	Mags[0] = akEnch.GetNthEffectMagnitude(0) - akCost
	Durs[0] = akEnch.GetNthEffectDuration(0)
	Areas[0] = akEnch.GetNthEffectArea(0)

	CreateEnchantment(akActor, 0, akSlot, 0.0, Effects, Mags, Areas, Durs)
EndFunction

Float Function GetCharge(int akSlot)
	Enchantment akEnch = GetEnchantment(akActor, 0, akSlot)
	Int i = 0
	Int num = akEnch.GetNumEffects()
	While i < num
		If akEnch.GetNthEffectMagicEffect(i) == akMGEF
			Return akEnch.GetNthEffectMagnitude(i)
		EndIf
		i += 1
	EndWhile
	Return 0.0
EndFunction