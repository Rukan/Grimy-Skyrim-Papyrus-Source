scriptName GBT_Script_ArrowFamine extends activemagiceffect

GrimyMenuMain property GBT_MainMenu auto
actor property PlayerRef auto

Int arrows

Event OnPlayerBowShot(Weapon akWeapon, Ammo akAmmo, Float afPower, Bool abSunGazing)
	arrows = GBT_MainMenu.GetGBT_arrowFamine_Float() as Int - 1
	if PlayerRef.GetItemCount(akAmmo as form) > arrows
		PlayerRef.RemoveItem(akAmmo as form, arrows, true, none)
	else
		PlayerRef.RemoveItem(akAmmo as form, PlayerRef.GetItemCount(akAmmo as form), true, none)
	endIf
EndEvent
