Scriptname GELO_IdentifyUtil extends Quest  

import utility
QUEST PROPERTY UILib AUTO
STRING[] PROPERTY DisenchantList AUTO
IMPORT GrimyToolsPluginScript

int choice
FUNCTION IdentifyCrosshairRef()
	targetObject = Game.GetCurrentCrosshairRef()
	IF canEnchant()
		IF targetObject.GetEnchantment() == None
			beginEnchanting()
		ELSE
			choice = ((UILib as FORM) as UILIB_GRIMY).ShowList("What would you like to do?", DisenchantList, 0, 0)
			IF choice == 0
				Game.AdvanceSkill("Enchanting",GrimyGlobal_DisenchantingExp.GetValue())
				;Enchantment tempEnch = targetObject.GetEnchantment()
				;Debug.Notification("Before: " + tempEnch AS FORM)
				;DeletePersistentEnch(targetObject.GetEnchantment())
				;Debug.Notification("After: " + tempEnch AS FORM)
				;targetObject.SetEnchantment(None,0.0)
				targetObject.disable(false)
				PlayerRef.AddItem(GrimyArcaneDust,10)
				targetObject.delete()
				targetObject = None						;References need to be deleted before deletion can occur
			ELSEIF choice == 1 
				IF PlayerRef.GetItemCount(GrimyArcaneDust) >= 10
					PlayerRef.RemoveItem(GrimyArcaneDust,10,true)
					beginEnchanting()
				ELSE
					Debug.Notification("You require arcane dust")
				ENDIF
			ELSEIF choice == 2
				socketMenu(socketIndex())
			ENDIF
		ENDIF
	ENDIF
ENDFUNCTION
OBJECTREFERENCE targetObject
GLOBALVARIABLE PROPERTY GrimyGlobal_DisenchantingExp AUTO

FUNCTION QuickIdentifyForm(FORM akForm)
	IF StringUtil.substring(akForm.GetName(),0,13) == "Unidentified "
		IF PlayerRef.GetItemCount(akForm) >= 1
			PlayerRef.RemoveItem(akForm,1,true)
			targetObject = PlayerRef.PlaceAtMe(akForm)
			beginEnchanting()
		ELSE
			Debug.Notification("You no longer have that item")
		ENDIF
	ELSEIF akForm AS ARMOR && (akForm AS ARMOR).GetEnchantment() && GetArmorTemplate(akForm AS ARMOR)
		PlayerRef.RemoveItem(akForm,1,true)
		targetObject = PlayerRef.PlaceAtMe(GetArmorTemplate(akForm AS ARMOR))
		beginEnchanting()
	ELSEIF akForm AS WEAPON && (akForm AS WEAPON).GetEnchantment() && (akForm AS WEAPON).GetTemplate()
		PlayerRef.RemoveItem(akForm,1,true)
		targetObject = PlayerRef.PlaceAtMe((akForm AS WEAPON).GetTemplate())
		beginEnchanting()
	ELSE
		Debug.Notification("Quick-Identify only works on items with generic enchantments.")
	ENDIF
ENDFUNCTION

FORM PROPERTY GrimyArcaneDust AUTO
BOOL FUNCTION canEnchant()
	FORM targetBase = targetObject.GetBaseObject()
	IF targetBase AS ARMOR && (targetBase AS ARMOR).GetEnchantment() && GetArmorTemplate(targetBase AS ARMOR)
		RETURN true
	ELSEIF targetBase AS WEAPON && (targetBase AS WEAPON).GetEnchantment() && (targetBase AS WEAPON).GetTemplate()
		RETURN true
	ENDIF
	
	IF targetObject == None
		RETURN false
	ELSEIF ( StringUtil.substring((targetBase).GetName(),0,13) == "Unidentified " ) || ( StringUtil.substring((targetBase).GetName(),0,23) == "Signature Unidentified " )
		RETURN true
	ELSEIF targetObject.GetEnchantment() == None
		IF ( ( targetBase.GetType() == 26 ) && ( ( targetBase AS ARMOR ).GetEnchantment() == None ) ) || ( ( targetBase.GetType() == 41 ) && ( ( targetBase AS WEAPON ).GetEnchantment() == None ) )
			IF PlayerRef.GetItemCount(GrimyArcaneDust) >= 20
				IF GrimyEnchantAnythingMessage.Show()
					PlayerRef.RemoveItem(GrimyArcaneDust,20,true)
					RETURN True
				Else
					RETURN False
				EndIf
			ELSE
				Debug.Notification("You could enchant this if you had 20 arcane dust")
			ENDIF
		ENDIF
	ELSEIF ( targetBase.GetType() == 26 ) || ( targetBase.GetType() == 41 )
		RETURN True
	ENDIF
	RETURN false
ENDFUNCTION
MESSAGE PROPERTY GrimyEnchantAnythingMessage AUTO

FUNCTION beginEnchanting()
	FORM targetBase = targetObject.GetBaseObject()
	;targetObject.SetEnchantment(None,0.0)
	; replace with template
	IF (targetBase AS ARMOR) && (targetBase AS ARMOR).GetEnchantment()
		targetObject.Delete()
		targetObject = PlayerRef.PlaceAtMe(GetArmorTemplate(targetBase AS ARMOR))
		IF (targetBase AS ARMOR).GetEnchantment().GetBaseEnchantment() && !((targetBase AS ARMOR).GetEnchantment().GetBaseEnchantment().PlayerKnows())
			(targetBase AS ARMOR).GetEnchantment().GetBaseEnchantment().SetPlayerKnows(true)
			Debug.Notification("Learned new enchantment")
		ENDIF
	ELSEIF (targetBase AS WEAPON) && (targetBase AS WEAPON).GetEnchantment()
		targetObject.Delete()
		targetObject = PlayerRef.PlaceAtMe((targetBase AS WEAPON).GetTemplate())
		IF (targetBase AS WEAPON).GetEnchantment().GetBaseEnchantment() && !((targetBase AS WEAPON).GetEnchantment().GetBaseEnchantment().PlayerKnows())
			(targetBase AS WEAPON).GetEnchantment().GetBaseEnchantment().SetPlayerKnows(true)
			Debug.Notification("Learned new enchantment")
		ENDIF
	ENDIF
	
	; Pick the correct enchLists for the given armor type and initalize the data arrays 
	IF targetBase.GetType() == 26
		initEnchantArmor()
		initArmor()
		selectArmorType()
		applyIrregular()
		applyOverload(RandomInt(0,2))
		targetObject.CreateEnchantment(0.0, EnchEffects, EnchMagnitudes, EnchAreas, EnchDurations)
	ELSEIF targetBase.GetType() == 41
		initEnchantWeapon()
		initWeapon()
		selectWeaponype()
		targetObject.CreateEnchantment(EnchCharge, EnchEffects, EnchMagnitudes, EnchAreas, EnchDurations)
	ELSE
		RETURN
	ENDIF	
	
	; Player picks up the item
	IF StringUtil.substring(targetBase.GetName(),0,13) == "Unidentified "
		targetObject.SetDisplayName(StringUtil.substring(targetBase.GetName(),13,-1))
	ELSEIF StringUtil.substring(targetBase.GetName(),0,23) == "Signature Unidentified "
		targetObject.SetDisplayName(StringUtil.substring(targetBase.GetName(),13,-1))
	ENDIF
	targetObject.SetActorOwner(PlayerRef.GetActorBase())
	PlayerRef.AddItem(targetObject,1,true)
	Game.AdvanceSkill("Enchanting",GrimyGlobal_EnchantingExp.GetValue())
ENDFUNCTION
GLOBALVARIABLE PROPERTY GrimyGlobal_EnchantingExp AUTO

FUNCTION initEnchantArmor()
	EnchPower = PlayerRef.GetActorValue("Enchanting")/100
	EnchEffects = new MAGICEFFECT[6]
	EnchMagnitudes = new float[6]
	EnchAreas = new int[6]
	EnchDurations = new int[6]
	enchList = new ENCHANTMENT[6]
	EnchMagnitudes[0] = 0.0
	EnchMagnitudes[1] = 0.0
	EnchMagnitudes[2] = 0.0
	EnchMagnitudes[3] = 0.0
	EnchMagnitudes[4] = 0.0
	EnchMagnitudes[5] = 0.0
	EnchAreas[0] = 0
	EnchAreas[1] = 0
	EnchAreas[2] = 0
	EnchAreas[3] = 0
	EnchAreas[4] = 0
	EnchAreas[5] = 0
	EnchDurations[0] = 0
	EnchDurations[1] = 0
	EnchDurations[2] = 0
	EnchDurations[3] = 0
	EnchDurations[4] = 0
	EnchDurations[5] = 0
ENDFUNCTION

FUNCTION initEnchantWeapon()
	EnchPower = PlayerRef.GetActorValue("Enchanting")/100
	EnchEffects = new MAGICEFFECT[4]
	EnchMagnitudes = new float[4]
	EnchAreas = new int[4]
	EnchDurations = new int[4]
	enchList = new ENCHANTMENT[4]
	EnchMagnitudes[0] = 0.0
	EnchMagnitudes[1] = 0.0
	EnchMagnitudes[2] = 0.0
	EnchMagnitudes[3] = 0.0
	EnchAreas[0] = 0
	EnchAreas[1] = 0
	EnchAreas[2] = 0
	EnchAreas[3] = 0
	EnchDurations[0] = 0
	EnchDurations[1] = 0
	EnchDurations[2] = 0
	EnchDurations[3] = 0
ENDFUNCTION

FUNCTION initArmor()
	EnchEffects[0] = GrimyMagicEnchNull
	EnchEffects[1] = GrimyMagicEnchNull
	EnchEffects[2] = GrimyMagicEnchNull
	EnchEffects[3] = GrimyMagicEnchNull
	EnchEffects[4] = GrimyMagicEnchNull
	EnchEffects[5] = GrimyMagicEnchNull
ENDFUNCTION
MAGICEFFECT PROPERTY GrimyMagicEnchNull AUTO

FUNCTION initWeapon()
	EnchEffects[0] = GrimyMagicEnchNullWeapon
	EnchEffects[1] = GrimyMagicEnchNullWeapon
	EnchEffects[2] = GrimyMagicEnchNullWeapon
	EnchEffects[3] = GrimyMagicEnchNullWeapon
	EnchCharge = RandomRange(GrimyGlobal_ChargeMin.GetValue(),GrimyGlobal_ChargeMax.GetValue(),PlayerRef.GetActorValue("Enchanting")/100.0)
ENDFUNCTION
float EnchCharge
MAGICEFFECT PROPERTY GrimyMagicEnchNullWeapon AUTO

GLOBALVARIABLE PROPERTY GrimyGlobal_ChargeMax AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_ChargeMin AUTO
MAGICEFFECT[] EnchEffects
float[] EnchMagnitudes
int[] EnchAreas
int[] EnchDurations
float EnchPower = 0.0

;=============================================
;============Select Weapon Type===============
;=============================================

FUNCTION selectWeaponype()
	enchList[0] = GrimyEnchList_Weapon1Primary
	enchList[1] = GrimyEnchList_Weapon2Attribute
	enchList[2] = GrimyEnchList_Weapon3Drain
	enchList[3] = GrimyEnchList_Weapon4Amplifier

	IF RandomFloat() > GrimyGlobal_WeaponDamageRoll.GetValue()
		enchList[0] = None
	ENDIF
	IF RandomFloat() > GrimyGlobal_WeaponAttributeRoll.GetValue()
		enchList[1] = None
	ENDIF
	IF RandomFloat() > GrimyGlobal_WeaponDrainRoll.GetValue()
		enchList[2] = None
	ENDIF
	IF RandomFloat() > GrimyGlobal_AmplifierRoll.GetValue()
		enchList[3] = None
	ENDIF

	applySlotWeapon(0,enchList[0],RandomInt(0,-1+GrimyEnchList_Weapon1Primary.GetNumEffects()/2))
	applySlotWeapon(1,enchList[1],RandomInt(0,-1+GrimyEnchList_Weapon2Attribute.GetNumEffects()/2))
	applySlotWeapon(2,enchList[2],RandomInt(0,-1+GrimyEnchList_Weapon3Drain.GetNumEffects()/2))
	applySlotWeapon(3,enchList[3],RandomInt(0,-1+GrimyEnchList_Weapon4Amplifier.GetNumEffects()/2))
	
	; apply modifier for weapon attack speed
	EnchPower = (targetObject.GetbaseObject() AS WEAPON).GetSpeed()
	EnchMagnitudes[0] = EnchMagnitudes[0] / EnchPower
	EnchMagnitudes[1] = EnchMagnitudes[1] / EnchPower
	EnchMagnitudes[2] = EnchMagnitudes[2] / EnchPower
ENDFUNCTION

GLOBALVARIABLE PROPERTY GrimyGlobal_WeaponDamageRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_WeaponAttributeRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_WeaponDrainRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_AmplifierRoll AUTO
ENCHANTMENT PROPERTY GrimyEnchList_Weapon1Primary AUTO
ENCHANTMENT PROPERTY GrimyEnchList_Weapon2Attribute AUTO
ENCHANTMENT PROPERTY GrimyEnchList_Weapon3Drain AUTO
ENCHANTMENT PROPERTY GrimyEnchList_Weapon4Amplifier AUTO

;=============================================
;=============Select Armor Type===============
;=============================================

FUNCTION selectArmorType()
	ARMOR thisArmor = (targetObject.getBaseObject() AS ARMOR)
	IF thisArmor.IsBoots()
		enchList[0] = GrimyEnchListCore1Boots AS ENCHANTMENT
		enchList[1] = GrimyEnchListOffense1Boots AS ENCHANTMENT
		enchList[2] = GrimyEnchListDefense1Boots AS ENCHANTMENT
		enchList[3] = GrimyEnchListUtility1Boots AS ENCHANTMENT
		enchList[4] = GrimyEnchListMisc1Boots AS ENCHANTMENT
		enchList[5] = GrimyEnchListEpic1Boots AS ENCHANTMENT
	ELSEIF thisArmor.IsCuirass()
		enchList[0] = GrimyEnchListCore2Chest AS ENCHANTMENT
		enchList[1] = GrimyEnchListOffense2Chest AS ENCHANTMENT
		enchList[2] = GrimyEnchListDefense2Chest AS ENCHANTMENT
		enchList[3] = GrimyEnchListUtility2Chest AS ENCHANTMENT
		enchList[4] = GrimyEnchListMisc2Chest AS ENCHANTMENT
		enchList[5] = GrimyEnchListEpic2Chest AS ENCHANTMENT
	ELSEIF thisArmor.IsGauntlets()
		enchList[0] = GrimyEnchListCore3Glove AS ENCHANTMENT
		enchList[1] = GrimyEnchListOffense3Glove AS ENCHANTMENT
		enchList[2] = GrimyEnchListDefense3Glove AS ENCHANTMENT
		enchList[3] = GrimyEnchListUtility3Glove AS ENCHANTMENT
		enchList[4] = GrimyEnchListMisc3Glove AS ENCHANTMENT
		enchList[5] = GrimyEnchListEpic3Glove AS ENCHANTMENT
	ELSEIF thisArmor.IsHelmet()
		enchList[0] = GrimyEnchListCore4Helm AS ENCHANTMENT
		enchList[1] = GrimyEnchListOffense4Helm AS ENCHANTMENT
		enchList[2] = GrimyEnchListDefense4Helm AS ENCHANTMENT
		enchList[3] = GrimyEnchListUtility4Helm AS ENCHANTMENT
		enchList[4] = GrimyEnchListMisc4Helm AS ENCHANTMENT
		enchList[5] = GrimyEnchListEpic4Helm AS ENCHANTMENT
	ELSEIF thisArmor.IsShield()
		enchList[0] = GrimyEnchListCore7Shield AS ENCHANTMENT
		enchList[1] = GrimyEnchListOffense7Shield AS ENCHANTMENT
		enchList[2] = GrimyEnchListDefense7Shield AS ENCHANTMENT
		enchList[3] = GrimyEnchListUtility7Shield AS ENCHANTMENT
		enchList[4] = GrimyEnchListMisc7Shield AS ENCHANTMENT
		enchList[5] = GrimyEnchListEpic7Shield AS ENCHANTMENT
	ELSEIF thisArmor.IsClothingRing()
		enchList[0] = GrimyEnchListCore6Ring AS ENCHANTMENT
		enchList[1] = GrimyEnchListOffense6Ring AS ENCHANTMENT
		enchList[2] = GrimyEnchListDefense6Ring AS ENCHANTMENT
		enchList[3] = GrimyEnchListUtility6Ring AS ENCHANTMENT
		enchList[4] = GrimyEnchListMisc6Ring AS ENCHANTMENT
		enchList[5] = GrimyEnchListEpic6Ring AS ENCHANTMENT
	ELSEIF thisArmor.IsClothingBody()
		enchList[0] = GrimyEnchListCore8Robe AS ENCHANTMENT
		enchList[1] = GrimyEnchListOffense8Robe AS ENCHANTMENT
		enchList[2] = GrimyEnchListDefense8Robe AS ENCHANTMENT
		enchList[3] = GrimyEnchListUtility2Chest AS ENCHANTMENT
		enchList[4] = GrimyEnchListMisc2Chest AS ENCHANTMENT
		enchList[5] = GrimyEnchListEpic2Chest AS ENCHANTMENT
	ELSEIF thisArmor.IsJewelry()
		enchList[0] = GrimyEnchListCore5Amulet AS ENCHANTMENT
		enchList[1] = GrimyEnchListOffense5Amulet AS ENCHANTMENT
		enchList[2] = GrimyEnchListDefense5Amulet AS ENCHANTMENT
		enchList[3] = GrimyEnchListUtility5Amulet AS ENCHANTMENT
		enchList[4] = GrimyEnchListMisc5Amulet AS ENCHANTMENT
		enchList[5] = GrimyEnchListEpic5Amulet AS ENCHANTMENT
	ELSE
		Debug.Notification("Unrecognized armor type. Applying generic minor enchantment.")
		enchList[0] = GrimyEnchListCore9Other AS ENCHANTMENT
		enchList[1] = GrimyEnchListOffense9Other AS ENCHANTMENT
		enchList[2] = GrimyEnchListDefense9Other AS ENCHANTMENT
		enchList[3] = GrimyEnchListUtility5Amulet AS ENCHANTMENT
		enchList[4] = GrimyEnchListMisc5Amulet AS ENCHANTMENT
		enchList[5] = GrimyEnchListEpic5Amulet AS ENCHANTMENT
	ENDIF
	
	; Choose a random enchantment for slot # from enchList
	IF RandomFloat() <= GrimyGlobal_CoreRoll.GetValue()
		applySlotArmor(0,enchList[0],RandomInt(0,-1+enchList[0].GetNumEffects()/2))
	ELSE
		enchList[0] = None
	ENDIF
	IF RandomFloat() <= GrimyGlobal_OffenseRoll.GetValue()
		applySlotArmor(1,enchList[1],RandomInt(0,-1+enchList[1].GetNumEffects()/2))
	ELSE
		enchList[0] = None
	ENDIF
	IF RandomFloat() <= GrimyGlobal_DefenseRoll.GetValue()
		applySlotArmor(2,enchList[2],RandomInt(0,-1+enchList[2].GetNumEffects()/2))
	ELSE
		enchList[0] = None
	ENDIF
	IF RandomFloat() <= GrimyGlobal_UtilityRoll.GetValue()
		applySlotArmor(3,enchList[3],RandomInt(0,-1+enchList[3].GetNumEffects()/2))
	ELSE
		enchList[0] = None
	ENDIF
	IF RandomFloat() <= GrimyGlobal_MiscRoll.GetValue()
		applySlotArmor(4,enchList[4],RandomInt(0,-1+enchList[4].GetNumEffects()/2))
	ELSE
		enchList[0] = None
	ENDIF
	IF RandomFloat() <= GrimyGlobal_EpicRoll.GetValue()
		applySlotArmor(5,enchList[5],RandomInt(0,-1+enchList[5].GetNumEffects()/2))
	ELSE
		enchList[0] = None
	ENDIF
	
ENDFUNCTION	
ENCHANTMENT[] enchList
GLOBALVARIABLE PROPERTY GrimyGlobal_CoreRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_OffenseRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_DefenseRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_UtilityRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_MiscRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_EpicRoll AUTO

ENCHANTMENT PROPERTY GrimyEnchListCore1Boots AUTO
ENCHANTMENT PROPERTY GrimyEnchListCore2Chest AUTO
ENCHANTMENT PROPERTY GrimyEnchListCore3Glove AUTO
ENCHANTMENT PROPERTY GrimyEnchListCore4Helm AUTO
ENCHANTMENT PROPERTY GrimyEnchListCore5Amulet AUTO
ENCHANTMENT PROPERTY GrimyEnchListCore6Ring AUTO
ENCHANTMENT PROPERTY GrimyEnchListCore7Shield AUTO
ENCHANTMENT PROPERTY GrimyEnchListCore8Robe AUTO
ENCHANTMENT PROPERTY GrimyEnchListCore9Other AUTO

ENCHANTMENT PROPERTY GrimyEnchListOffense1Boots AUTO
ENCHANTMENT PROPERTY GrimyEnchListOffense2Chest AUTO
ENCHANTMENT PROPERTY GrimyEnchListOffense3Glove AUTO
ENCHANTMENT PROPERTY GrimyEnchListOffense4Helm AUTO
ENCHANTMENT PROPERTY GrimyEnchListOffense5Amulet AUTO
ENCHANTMENT PROPERTY GrimyEnchListOffense6Ring AUTO
ENCHANTMENT PROPERTY GrimyEnchListOffense7Shield AUTO
ENCHANTMENT PROPERTY GrimyEnchListOffense8Robe AUTO
ENCHANTMENT PROPERTY GrimyEnchListOffense9Other AUTO

ENCHANTMENT PROPERTY GrimyEnchListDefense1Boots AUTO
ENCHANTMENT PROPERTY GrimyEnchListDefense2Chest AUTO
ENCHANTMENT PROPERTY GrimyEnchListDefense3Glove AUTO
ENCHANTMENT PROPERTY GrimyEnchListDefense4Helm AUTO
ENCHANTMENT PROPERTY GrimyEnchListDefense5Amulet AUTO
ENCHANTMENT PROPERTY GrimyEnchListDefense6Ring AUTO
ENCHANTMENT PROPERTY GrimyEnchListDefense7Shield AUTO
ENCHANTMENT PROPERTY GrimyEnchListDefense8Robe AUTO
ENCHANTMENT PROPERTY GrimyEnchListDefense9Other AUTO

ENCHANTMENT PROPERTY GrimyEnchListUtility1Boots AUTO
ENCHANTMENT PROPERTY GrimyEnchListUtility2Chest AUTO
ENCHANTMENT PROPERTY GrimyEnchListUtility3Glove AUTO
ENCHANTMENT PROPERTY GrimyEnchListUtility4Helm AUTO
ENCHANTMENT PROPERTY GrimyEnchListUtility5Amulet AUTO
ENCHANTMENT PROPERTY GrimyEnchListUtility6Ring AUTO
ENCHANTMENT PROPERTY GrimyEnchListUtility7Shield AUTO

ENCHANTMENT PROPERTY GrimyEnchListMisc1Boots AUTO
ENCHANTMENT PROPERTY GrimyEnchListMisc2Chest AUTO
ENCHANTMENT PROPERTY GrimyEnchListMisc3Glove AUTO
ENCHANTMENT PROPERTY GrimyEnchListMisc4Helm AUTO
ENCHANTMENT PROPERTY GrimyEnchListMisc5Amulet AUTO
ENCHANTMENT PROPERTY GrimyEnchListMisc6Ring AUTO
ENCHANTMENT PROPERTY GrimyEnchListMisc7Shield AUTO

ENCHANTMENT PROPERTY GrimyEnchListEpic1Boots AUTO
ENCHANTMENT PROPERTY GrimyEnchListEpic2Chest AUTO
ENCHANTMENT PROPERTY GrimyEnchListEpic3Glove AUTO
ENCHANTMENT PROPERTY GrimyEnchListEpic4Helm AUTO
ENCHANTMENT PROPERTY GrimyEnchListEpic5Amulet AUTO
ENCHANTMENT PROPERTY GrimyEnchListEpic6Ring AUTO
ENCHANTMENT PROPERTY GrimyEnchListEpic7Shield AUTO

;=============================================
;===============Apply Slots===================
;=============================================

FUNCTION applySlotWeapon(INT akSlot, ENCHANTMENT akEnchList, INT akEnchSlot)
	IF akEnchList == None
		EnchEffects[akSlot] = GrimyMagicEnchNullWeapon
	ELSE
		EnchEffects[akSlot] = akEnchList.GetNthEffectMagicEffect(akEnchSlot*2) AS MAGICEFFECT
		
		IF RandomFloat() < GrimyGlobal_PerfectRoll.GetValue()
			EnchMagnitudes[akSlot] = akEnchList.GetNthEffectMagnitude(akEnchSlot*2) \
									+ (akEnchList.GetNthEffectMagnitude(akEnchSlot*2+1) - akEnchList.GetNthEffectMagnitude(akEnchSlot*2)) \
									*  EnchPower * GrimyGlobal_MaxRoll.GetValue()
		ELSE
			EnchMagnitudes[akSlot] = RandomRange(akEnchList.GetNthEffectMagnitude(akEnchSlot*2), akEnchList.GetNthEffectMagnitude(akEnchSlot*2+1), EnchPower)
		ENDIF
		
		IF akEnchList.GetNthEffectDuration(akEnchSlot*2)
			EnchDurations[akSlot] = RandomRange(akEnchList.GetNthEffectDuration(akEnchSlot*2), akEnchList.GetNthEffectDuration(akEnchSlot*2+1), EnchPower) AS INT
		ENDIF
	ENDIF
ENDFUNCTION

FUNCTION applySlotArmor(INT akSlot, ENCHANTMENT akEnchList, INT akEnchSlot)
	IF akEnchList == None
		EnchEffects[akSlot] = GrimyMagicEnchNull
	ELSE
		EnchEffects[akSlot] = akEnchList.GetNthEffectMagicEffect(akEnchSlot*2) AS MAGICEFFECT
		
		IF RandomFloat() < GrimyGlobal_PerfectRoll.GetValue()
			EnchMagnitudes[akSlot] = akEnchList.GetNthEffectMagnitude(akEnchSlot*2) \
									+ (akEnchList.GetNthEffectMagnitude(akEnchSlot*2+1) - akEnchList.GetNthEffectMagnitude(akEnchSlot*2)) \
									*  EnchPower * GrimyGlobal_MaxRoll.GetValue()
		ELSE
			EnchMagnitudes[akSlot] = RandomRange(akEnchList.GetNthEffectMagnitude(akEnchSlot*2), akEnchList.GetNthEffectMagnitude(akEnchSlot*2+1), EnchPower)
		ENDIF
	ENDIF
ENDFUNCTION
MAGICEFFECT PROPERTY GrimyMagicEnchAttackSpeed AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_PerfectRoll AUTO

FLOAT FUNCTION RandomRange(FLOAT akMin, FLOAT akMax, FLOAT akScale)
	return RandomFloat(akMin + (akMax - akMin) * akScale * GrimyGlobal_MinRoll.GetValue() * GrimyGlobal_MaxRoll.GetValue(),\
						akMin + (akMax - akMin) * akScale * GrimyGlobal_MaxRoll.GetValue())
ENDFUNCTION
GLOBALVARIABLE PROPERTY GrimyGlobal_MaxRoll AUTO
GLOBALVARIABLE PROPERTY GrimyGlobal_MinRoll AUTO

;=============================================
;=========Irregular & Overload================
;=============================================

FUNCTION applyIrregularSlot(int akSlot)
	IF ( enchList[akSlot] == NONE )
		RETURN
	ENDIF
		
	IF RandomInt(0,1)
		applySlotArmor(akSlot,enchList[modulus(akSlot+1,3)],RandomInt(0,-1+enchList[modulus(akSlot+1,3)].GetNumEffects()/2))
	ELSE
		applySlotArmor(akSlot,enchList[modulus(akSlot+2,3)],RandomInt(0,-1+enchList[modulus(akSlot+2,3)].GetNumEffects()/2))
	ENDIF
	Debug.Notification("You notice an irregularity in this enchantment.")
ENDFUNCTION

INT FUNCTION modulus(int akInt, int akDiv)
	IF akInt >= akDiv
		modulus(akInt - akDiv,akDiv)
	ELSE
		return akInt
	ENDIF
ENDFUNCTION

FUNCTION continueOverload(int akInt)
	enchList[akInt] = GrimyEnchList_Negative
	applySlotArmor(akInt,enchList[akInt],RandomInt(0,-1+enchList[akInt].GetNumEffects()/2))
	Debug.Notification("You overload your enchantment.")
ENDFUNCTION

FUNCTION applyOverload(int akInt)
	IF ( enchList[akInt] == NONE )
		RETURN
	ENDIF
	
	IF RandomFloat() < GrimyGlobal_Overload.GetValue()
		EnchMagnitudes[akInt] = EnchMagnitudes[akInt]*2.0
		continueOverload(modulus(akInt+RandomInt(1,2),3))
	ENDIF
ENDFUNCTION
GLOBALVARIABLE PROPERTY GrimyGlobal_Overload AUTO

FUNCTION applyIrregular()
	IF RandomFloat() < GrimyGlobal_Irregular.GetValue()
		applyIrregularSlot(RandomInt(0,2))
	ENDIF
ENDFUNCTION
GLOBALVARIABLE PROPERTY GrimyGlobal_Irregular AUTO

ACTOR PROPERTY PlayerRef AUTO

ENCHANTMENT PROPERTY GrimyEnchList_Negative AUTO

;=============================================
;===============Sockets=======================
;=============================================

INT FUNCTION socketIndex()
	;No while loop is intentional, I want to minimize variables.
	IF targetObject.GetEnchantment().GetNthEffectMagicEffect(0) == GrimyMagicEnchGemSocket
		RETURN 0
	ELSEIF targetObject.GetEnchantment().GetNthEffectMagicEffect(1) == GrimyMagicEnchGemSocket
		RETURN 1 
	ELSEIF targetObject.GetEnchantment().GetNthEffectMagicEffect(2) == GrimyMagicEnchGemSocket
		RETURN 2
	ELSEIF targetObject.GetEnchantment().GetNthEffectMagicEffect(3) == GrimyMagicEnchGemSocket
		RETURN 3
	ELSEIF targetObject.GetEnchantment().GetNthEffectMagicEffect(4) == GrimyMagicEnchGemSocket
		RETURN 4
	ELSEIF targetObject.GetEnchantment().GetNthEffectMagicEffect(5) == GrimyMagicEnchGemSocket
		RETURN 5
	ELSE
		RETURN -1
	ENDIF
ENDFUNCTION
MAGICEFFECT PROPERTY GrimyMagicEnchGemSocket AUTO

INT FUNCTION getNumSockets(INT index)
	RETURN (targetObject.GetEnchantment().GetNthEffectMagnitude(index) + 0.5) AS INT
ENDFUNCTION

BOOL FUNCTION removeGems(INT gemIndex, INT numGems)
	IF PlayerRef.GetItemCount(GrimyList_Gems.GetAt(gemIndex)) >= numGems
		PlayerRef.RemoveItem(GrimyList_Gems.GetAt(gemIndex), numGems,true)
		RETURN TRUE
	ELSE
		RETURN false
	ENDIF
ENDFUNCTION
FORMLIST PROPERTY GrimyList_Gems AUTO

FUNCTION enchantSocket(INT enchIndex, INT gemIndex, ENCHANTMENT akEnch, INT numSockets)
	IF !removeGems(gemIndex,numSockets)
		Debug.Notification("You do not have enough gems")
		RETURN
	ENDIF
	
	; Reload old enchantments
	EnchEffects = new MAGICEFFECT[6]
	EnchMagnitudes = new float[6]
	EnchAreas = new int[6]
	EnchDurations = new int[6]
	EnchEffects[0] = akEnch.GetNthEffectMagicEffect(0)
	EnchEffects[1] = akEnch.GetNthEffectMagicEffect(1)
	EnchEffects[2] = akEnch.GetNthEffectMagicEffect(2)
	EnchEffects[3] = akEnch.GetNthEffectMagicEffect(3)
	EnchEffects[4] = akEnch.GetNthEffectMagicEffect(4)
	EnchEffects[5] = akEnch.GetNthEffectMagicEffect(5)
	EnchMagnitudes[0] = akEnch.GetNthEffectMagnitude(0)
	EnchMagnitudes[1] = akEnch.GetNthEffectMagnitude(1)
	EnchMagnitudes[2] = akEnch.GetNthEffectMagnitude(2)
	EnchMagnitudes[3] = akEnch.GetNthEffectMagnitude(3)
	EnchMagnitudes[4] = akEnch.GetNthEffectMagnitude(4)
	EnchMagnitudes[5] = akEnch.GetNthEffectMagnitude(5)
	EnchAreas[0] = akEnch.GetNthEffectArea(0)
	EnchAreas[1] = akEnch.GetNthEffectArea(1)
	EnchAreas[2] = akEnch.GetNthEffectArea(2)
	EnchAreas[3] = akEnch.GetNthEffectArea(3)
	EnchAreas[4] = akEnch.GetNthEffectArea(4)
	EnchAreas[5] = akEnch.GetNthEffectArea(5)
	EnchDurations[0] = akEnch.GetNthEffectDuration(0)
	EnchDurations[1] = akEnch.GetNthEffectDuration(1)
	EnchDurations[2] = akEnch.GetNthEffectDuration(2)
	EnchDurations[3] = akEnch.GetNthEffectDuration(3)
	EnchDurations[4] = akEnch.GetNthEffectDuration(4)
	EnchDurations[5] = akEnch.GetNthEffectDuration(5)
	EnchCharge = targetObject.GetItemMaxCharge()
	
	;load new enchantment
	IF targetObject.GetBaseObject().GetType() == 41
			EnchEffects[enchIndex] = GrimyEnchList_GemWeapon.GetNthEffectMagicEffect(gemIndex)
			EnchMagnitudes[enchIndex] = GrimyEnchList_GemWeapon.GetNthEffectMagnitude(gemIndex) * numSockets
			EnchDurations[enchIndex] = GrimyEnchList_GemWeapon.GetNthEffectDuration(gemIndex) * numSockets
			EnchAreas[enchIndex] = GrimyEnchList_GemWeapon.GetNthEffectArea(gemIndex) * numSockets
	ELSEIF targetObject.GetBaseObject().GetType() == 26
		IF (targetObject.getBaseObject() AS ARMOR).IsJewelry()
			EnchEffects[enchIndex] = GrimyEnchList_GemJewelry.GetNthEffectMagicEffect(gemIndex)
			EnchMagnitudes[enchIndex] = GrimyEnchList_GemJewelry.GetNthEffectMagnitude(gemIndex) * numSockets
			EnchDurations[enchIndex] = GrimyEnchList_GemJewelry.GetNthEffectDuration(gemIndex) * numSockets
			EnchAreas[enchIndex] = GrimyEnchList_GemJewelry.GetNthEffectArea(gemIndex) * numSockets
		ELSE
			EnchEffects[enchIndex] = GrimyEnchList_GemArmor.GetNthEffectMagicEffect(gemIndex)
			EnchMagnitudes[enchIndex] = GrimyEnchList_GemArmor.GetNthEffectMagnitude(gemIndex) * numSockets
			EnchDurations[enchIndex] = GrimyEnchList_GemArmor.GetNthEffectDuration(gemIndex) * numSockets
			EnchAreas[enchIndex] = GrimyEnchList_GemArmor.GetNthEffectArea(gemIndex) * numSockets
		ENDIF
	ELSE
		Debug.Notification("Socket: Unrecognized Item Type")
		RETURN
	ENDIF
			
	;apply enchantment
	targetObject.CreateEnchantment(EnchCharge, EnchEffects, EnchMagnitudes, EnchAreas, EnchDurations)
	Game.AdvanceSkill("Enchanting",GrimyGlobal_SocketingExp.GetValue() * numSockets)
	;give item to player
	targetObject.SetActorOwner(PlayerRef.GetActorBase())
	PlayerRef.Additem(targetObject,1,true)
ENDFUNCTION
GLOBALVARIABLE PROPERTY GrimyGlobal_SocketingExp AUTO
ENCHANTMENT PROPERTY GrimyEnchList_GemArmor AUTO
ENCHANTMENT PROPERTY GrimyEnchList_GemWeapon AUTO
ENCHANTMENT PROPERTY GrimyEnchList_GemJewelry AUTO
STRING[] PROPERTY GemList AUTO


FUNCTION socketMenu(INT akIndex)
	IF akIndex >= 0
		INT gemIndex = ((UILib as FORM) as UILIB_GRIMY).ShowList("Select Gem Type", GemList, 0, 0)
		IF ( gemIndex >= 0 ) && ( gemIndex < 12 )
			enchantSocket(akIndex, gemIndex,targetObject.GetEnchantment(),getNumSockets(akIndex))
		ENDIF
	ELSE
		Debug.Notification("This item has no sockets")		
	ENDIF
ENDFUNCTION

; CreateEnchantment does NOT work on non-player enchanted items
; CreateEnchantment will crash the game if passed any "None" enchantments
; floats round down when cast to ints
; Write functionally when possible! Papyrus parallelization sucks dick.