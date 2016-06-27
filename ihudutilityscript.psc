Scriptname iHUDUtilityScript hidden

bool Function isTargettedSpell(Spell equippedSpell) Global
	return equippedSpell != none
EndFunction

bool Function isRangedWeapon(Weapon equippedWeapon) Global
	return equippedWeapon != none && (equippedWeapon.IsBow() || equippedWeapon.IsStaff())
EndFunction

bool Function isMeleeWeapon(Weapon equippedWeapon) Global
	return equippedWeapon != none && (equippedWeapon.IsMace() || equippedWeapon.IsBattleaxe() || equippedWeapon.IsDagger() || equippedWeapon.IsGreatsword() || equippedWeapon.IsSword() || equippedWeapon.IsWarhammer() || equippedWeapon.IsWarAxe())
EndFunction

float Function getiHUDNumber(String element, String attribute) Global
	return UI.GetNumber("HUD Menu", element + "." + attribute)
EndFunction

Function setiHUDNumber(String element, String attribute, float value) Global
	UI.SetNumber("HUD Menu", element + "." + attribute, value)
EndFunction

Function setiHUDBool(String element, String attribute, bool value) Global
	UI.SetBool("HUD Menu", element + "." + attribute, value)
EndFunction

float Function calculateBaseHUDAlpha(bool visible, float max) Global
	if visible
		return max
	endif
	
	return 0
EndFunction

bool Function meterNotFull(String meter) Global
	return getiHUDNumber("_root.HUDMovieBaseInstance." + meter, "_currentframe") > 1
EndFunction

bool Function hasActivateOption() Global
	return getiHUDNumber("_root.HUDMovieBaseInstance.ActivateButton_tf", "_alpha") > 0.0
EndFunction
