scriptName GBT_Script_BleedDamage extends activemagiceffect

actor property PlayerRef auto
perk property HackAndSlash90 auto
perk property Overdraw80 auto
perk property Overdraw20 auto
perk property Overdraw00 auto
perk property HackAndSlash60 auto
perk property Armsman80 auto
perk property Armsman00 auto
perk property Overdraw60 auto
perk property Armsman40 auto
perk property Barbarian00 auto
perk property Limbsplitter90 auto
perk property Barbarian40 auto
perk property Limbsplitter60 auto
perk property Armsman60 auto
perk property Barbarian20 auto
perk property Overdraw40 auto
perk property Barbarian60 auto
perk property Armsman20 auto
perk property Barbarian80 auto

Int weaponType = 0
Weapon equippedWeapon
Float outputDamage = 0.000000
Import Utility

Event OnEffectStart(actor akTarget, actor akCaster)
	equippedWeapon = PlayerRef.GetEquippedWeapon(false)
	weaponType = equippedWeapon.GetWeaponType()
	outputDamage = equippedWeapon.GetBaseDamage() as Float
	if weaponType >= 1 && weaponType <= 4
		outputDamage *= 1.00000 + 0.00500000 * PlayerRef.GetActorValue("OneHanded")
		outputDamage *= 1.00000 + 0.0100000 * PlayerRef.GetActorValue("OneHandedMod")
		outputDamage *= 1.00000 + 0.0100000 * PlayerRef.GetActorValue("OneHandedPowerMod")
		if PlayerRef.HasPerk(Armsman80)
			outputDamage *= 2 as Float
		elseIf PlayerRef.HasPerk(Armsman60)
			outputDamage *= 1.80000
		elseIf PlayerRef.HasPerk(Armsman40)
			outputDamage *= 1.60000
		elseIf PlayerRef.HasPerk(Armsman20)
			outputDamage *= 1.40000
		elseIf PlayerRef.HasPerk(Armsman00)
			outputDamage *= 1.20000
		endIf
		if PlayerRef.HasPerk(HackAndSlash90)
			outputDamage = 3 as Float * outputDamage
		elseIf PlayerRef.HasPerk(HackAndSlash60)
			outputDamage = 2 as Float * outputDamage
		endIf
	elseIf weaponType >= 5 || weaponType <= 6
		outputDamage *= 1.00000 + 0.00500000 * PlayerRef.GetActorValue("TwoHanded")
		outputDamage *= 1.00000 + 0.0100000 * PlayerRef.GetActorValue("TwoHandedMod")
		outputDamage *= 1.00000 + 0.0100000 * PlayerRef.GetActorValue("TwoHandedPowerMod")
		if PlayerRef.HasPerk(Barbarian80)
			outputDamage *= 2 as Float
		elseIf PlayerRef.HasPerk(Barbarian60)
			outputDamage *= 1.80000
		elseIf PlayerRef.HasPerk(Barbarian40)
			outputDamage *= 1.60000
		elseIf PlayerRef.HasPerk(Barbarian20)
			outputDamage *= 1.40000
		elseIf PlayerRef.HasPerk(Barbarian00)
			outputDamage *= 1.20000
		endIf
		if PlayerRef.HasPerk(Limbsplitter90)
			outputDamage = 3 as Float * outputDamage
		elseIf PlayerRef.HasPerk(Limbsplitter60)
			outputDamage = 2 as Float * outputDamage
		endIf
	elseIf weaponType == 7 || weaponType == 9
		outputDamage *= 1.00000 + 0.00500000 * PlayerRef.GetActorValue("Marksman")
		outputDamage *= 1.00000 + 0.0100000 * PlayerRef.GetActorValue("MarksmanMod")
		outputDamage *= 1.00000 + 0.0100000 * PlayerRef.GetActorValue("MarksmanPowerMod")
		if PlayerRef.HasPerk(Overdraw80)
			outputDamage *= 2 as Float
		elseIf PlayerRef.HasPerk(Overdraw60)
			outputDamage *= 1.80000
		elseIf PlayerRef.HasPerk(Overdraw40)
			outputDamage *= 1.60000
		elseIf PlayerRef.HasPerk(Overdraw20)
			outputDamage *= 1.40000
		elseIf PlayerRef.HasPerk(Overdraw00)
			outputDamage *= 1.20000
		endIf
	endIf
	outputDamage = 0.0200000 * outputDamage
	Wait(0.600000)
	akTarget.damageActorValue("Health", outputDamage)
	Wait(0.600000)
	akTarget.damageActorValue("Health", outputDamage)
	Wait(0.600000)
	akTarget.damageActorValue("Health", outputDamage)
	Wait(0.600000)
	akTarget.damageActorValue("Health", outputDamage)
	Wait(0.600000)
	akTarget.damageActorValue("Health", outputDamage)
EndEvent