Scriptname GrimyToolsPluginScript Hidden 

Function SetNthLevelItemCount(LeveledItem akList, int index, int count) Global Native
;The SKSE version of this is capped at 255 (incorrectly so), this is capped at 65535.

Int Function GetWeaponEnchCount() Global Native
Int Function GetArmorEnchCount() Global Native
Function DeletePersistent(FORM akForm) Global Native
; unknown effect
Function DeletePersistentEnch(ENCHANTMENT akEnch) Global Native
; unknown effect

Int Function HexString2Int(String akString) Global Native
String Function StringDecimals(String akString, Int decimals) Global Native
; Returns a substring of akString with the specified number of characters after the first decimal.

Armor Function GetArmorTemplate(Armor akArmor) Global Native

;These four light functions do nothing at all if passed a None light source or a newValue that is not greater than 0
Int Function GetLightDuration(Light akLight) Global Native
Function SetLightDuration(Light akLight, Int newValue) Global Native
Int Function GetLightRadius(Light akLight) Global Native
Function SetLightRadius(Light akLight, Int newValue) Global Native

;The following six functions have not been verified.
Float Function GetMovementType(Form akMovement, Int indexOne, int indexTwo) Global Native
Function SetMovementType(Form akMovement, Int indexOne, Int indexTwo, Float newValue) Global Native
Int Function GetLightInt(Light akLight, Int index) Global Native
Function SetLightInt(Light akLight, Int index, Int newValue) Global Native

Int Function GetWeatherInt(Weather akWeather, Int index) Global Native
Function SetWeatherInt(Weather akWeather, Int index, Int newValue) Global Native 
;Index 0: Unk00[0]
;Index 1: Unk00[1]
;Index 2: Unk00[2]
;Index 3: transDelta
;Index 4: sunGlare
;Index 5: sunDamage
;Index 6: pad06 (padding usually means this variable does nothing)
;Index 7: unk08
;Index 8: unk0c
;Index 9: unk10
;Index 10: windDirection
;Index 11: windDirRange
;Index 12: pad13

Int Function GetSpellSound(Spell akSpell, int index) Global Native
; returns the FormID of the sound descriptor of the costliest magic effect in integer Form
; index 0 = Draw/Sheathe
; index 1,2 Unknown
; index 3 = Release
; index 4 = Concentration Cast Loop
; index 5-7 unknown
Function SetSoundDescriptor(Sound akSound, SoundDescriptor akDescriptor) Global Native

Function SetSpellNthMagicEffect(Spell akSpell, MagicEffect akEffect, int index) Global Native 
Function SetSpellNthMagicEffectMagnitude(Spell akSpell, Float mag, int index) Global Native 
Function SetSpellNthMagicEffectDuration(Spell akSpell, Int dur, int index) Global Native 
Function SetSpellNthMagicEffectArea(Spell akSpell, Int area, int index) Global Native 
Function SetSpellNthMagicEffectCost(Spell akSpell, Float cost, int index) Global Native 

Float Function GetSpellNthMagicEffectCost(Spell akSpell, int index) Global Native

Function SetSpellType(Spell akSpell, Int akType ) Global Native 
Function SetSpellCastType(Spell akSpell, Int akType ) Global Native 
Function SetSpellCastTime(Spell akSpell, Float akTime ) Global Native 
Function SetSpellChargeTime(Spell akSpell, Float akTime ) Global Native 
Function SetSpellDelivery(Spell akSpell, Int akType ) Global Native 
Function SetSpellPerk(Spell akSpell, Perk akPerk ) Global Native
Function SetMagickaCost(Spell akSpell, Int akCost ) Global Native 

Int Function GetSpellType(Spell akSpell ) Global Native 
; Returns the type of the spell. IE Spell, Ability, Lesser Power, etc.
; 0 = spell, 2 = power, 3 = lesser power
Int Function GetSpellCastType(Spell akSpell ) Global Native
; Returns the cast type, IE Concentration, fire forget, etc
; 1 = fire and forget, 2 = concentration, 0 = constant effect
Int Function GetSpellDelivery(Spell akSpell ) Global Native
; returns the delivery
; 0 = self, 1 = Contact, 2 = aimed, 3 = Target Actor, 4 = target location
Float Function GetSpellChargeTime(Spell akSpell ) Global Native
;Charge time only works on concentration spells, and it determines the minimum amount of time you must continue casting this spell (unless you run out of mana)
Int Function GetSpellUnk1C(Spell akSpell ) Global Native

Int Function MergeSpells(Spell outputSpell, Spell[] inputSpells, Float[] magMults, Float[] durMults, Float[] costMults, Float timeMult) Global Native
;This is a custom function I built for personal use, and is designed to be optimized to my own spell crafting needs
;The spells in the input spells section are merged into the output Spell
;magMult, durMult, and costmults apply multipliers on the magnitude, duration, and cost of their corresponding spell EffectShader
;If you have fewer input spell effects than in the outputSpell, then the excess magic effects in output spell will be left
;timeMult is a multiplier for the cast time of the spell. it applies a corresponding multiplier to magnitude and cost, but only for effects that are deemed to not be "buff-based" magic effects.
;Returns -1 error if cast types of the input spells did not match DEPRECATED
;Returns -2 error if delivery types of the input spells did not match DEPRECATED
;Returns -3 if there are more magic effects in the input spells combined than in the output spell.
;Returns -4 if the input arrays are not of equal size.
;Returns 1 if a spell was made, BUT the spell has no school.

Float Function GetRayTraceZ(ObjectReference akCaster, ObjectReference akTarget, float targetWidth) Global Native 