Scriptname GSA_WeaponAlias extends ReferenceAlias  

ACTOR PROPERTY PlayerRef AUTO
WEAPON PROPERTY GSA_Weapon AUTO
GLOBALVARIABLE PROPERTY GSA_numWeaponSlots AUTO

OBJECTREFERENCE PROPERTY geloCellRef AUTO
OBJECTREFERENCE oldRef
OBJECTREFERENCE myRef

SPELL bladeOil
FLOAT bladeOilMag
INT bladeOilType

FUNCTION attachReference(OBJECTREFERENCE crosshairRef, WEAPON crosshairWeapon)
	IF Self.GetRef() == crosshairRef
		Debug.Notification("that's already a signature weapon")
		RETURN
	ENDIF

	;===Initialize weapon statistics===
	storeStats(crosshairWeapon)
	updateStats()

	;===Teleport the previous signature base item to the player's inventory
	IF Self.GetRef()
		;===Update limbo item with new enchantment and tempering, in case it changed.
		IF Self.GetRef().GetEnchantment()
			oldRef.SetItemHealthPercent(Self.GetRef().GetItemHealthPercent())
			oldRef.SetEnchantment(Self.GetRef().GetEnchantment(), Self.GetRef().GetItemMaxCharge())
		ENDIF
		;===Delete the previous signature item
		Self.GetRef().MoveToIfUnloaded(PlayerRef)
		Self.GetRef().Delete()
	ENDIF
	IF oldRef
		oldRef.SetActorOwner(PlayerRef.GetActorBase())
		oldRef.Activate(PlayerRef)
	ENDIF
	
	;===Send the current signature base item to limbo
	oldRef = crosshairRef		
	oldRef.MoveTo(geloCellRef)

	;===Create new signature item and put it in the player's inventory===
	;===We cant work on it from the inventory. ===
	Self.ForceRefTo(PlayerRef.PlaceAtMe(GSA_Weapon,1))
	myRef = Self.GetRef()
	myRef.SetItemHealthPercent(1.0)
	IF oldRef.GetEnchantment()
		myRef.SetEnchantment(oldRef.GetEnchantment(),oldRef.GetItemMaxCharge())
		myRef.SetItemCharge(oldRef.GetItemCharge())
	ELSEIF (oldRef.GetBaseObject() AS WEAPON).GetEnchantment()
		myRef.SetEnchantment((oldRef.GetBaseObject() AS WEAPON).GetEnchantment(),oldRef.GetItemMaxCharge())
		myRef.SetItemCharge(oldRef.GetItemCharge())
	ENDIF
	myRef.SetDisplayName("Signature " + oldRef.GetDisplayName())
	myRef.SetActorOwner(PlayerRef.GetActorBase())
	myRef.Activate(PlayerRef)
ENDFUNCTION

FUNCTION storeStats(WEAPON akWeapon)
	nameSlots[0] = ""
	nameSlots[1] = ""
	nameSlots[2] = ""
	spellSlots[0] = None
	spellSlots[1] = None
	spellSlots[2] = None
	myBaseDamage = akWeapon.GetBasedamage()
	myCritDamage = akWeapon.GetCritDamage()
	myCritMultiplier = 1.0 ;akWeapon.getCritMultiplier()
	myCritOnDeath = false;
	myReach = akWeapon.GetReach()
	mySpeed = akWeapon.GetSpeed()
	myStagger = akWeapon.GetStagger()
	myWeight = akWeapon.GetWeight()
	myModelPath = akWeapon.GetModelPath()
	;myResist = akWeapon.GetResist()
	myEquippedModel = akWeapon.GetEquippedModel()
	myCritEffect = akWeapon.GetCritEffect()
ENDFUNCTION

FUNCTION resetStats()
	nameSlots[0] = ""
	nameSlots[1] = ""
	nameSlots[2] = ""
	spellSlots[0] = None
	spellSlots[1] = None
	spellSlots[2] = None
	WEAPON oldWeapon = oldRef.GetBaseObject() AS WEAPON
	myBaseDamage = oldWeapon.GetBasedamage()
	myCritDamage = oldWeapon.GetCritDamage()
	myCritMultiplier = oldWeapon.getCritMultiplier()
	myReach = oldWeapon.GetReach()
	mySpeed = oldWeapon.GetSpeed()
	myStagger = oldWeapon.GetStagger()
	myWeight = oldWeapon.GetWeight()
	myModelPath = oldWeapon.GetModelPath()
	;myResist = oldWeapon.GetResist()
	myEquippedModel = oldWeapon.GetEquippedModel()
	myCritEffect = oldWeapon.GetCritEffect()
	
	bladeOil = None
	bladeOilMag = 0.0
	bladeOilType = -1
	updateStats()
ENDFUNCTION

FUNCTION attachBladeOil(SPELL akBladeOil, FLOAT akMagnitude, INT akCreatureType)
	bladeOil = akBladeOil
	bladeOilMag = akMagnitude
	bladeOilType = akCreatureType
ENDFUNCTION


STRING FUNCTION getOilMag()
	IF bladeOilMag == 0.0
		RETURN ""
	ELSE
		RETURN bladeOilMag
	ENDIF
ENDFUNCTION

STRING FUNCTION getOilName()
	IF bladeOil == None
		RETURN "No Blade Oil"
	ELSEIF bladeOilType == 0
		RETURN "Creature Oil"
	ELSEIF bladeOilType == 1
		RETURN "Daedra Oil"
	ELSEIF bladeOilType == 2
		RETURN "Big Game Oil"
	ELSEIF bladeOilType == 3
		RETURN "Caustic Oil"
	ELSEIF bladeOilType == 4
		RETURN "Hangman Oil"
	ELSEIF bladeOilType == 5
		RETURN "Holy Oil"
	ELSE
		RETURN "No Blade Oil"
	ENDIF
ENDFUNCTION

EVENT OnActivate(ObjectReference akActionRef)
	IF akActionRef == PlayerRef
		loadAlias()
	ENDIF
ENDEVENT

EVENT OnEquipped(ACTOR akActor)
	IF bladeOil != None
		bladeOil.SetNthEffectMagnitude(0,bladeOilMag)
		bladeOil.SetNthEffectDuration(0,bladeOilType)
		akActor.AddSpell(bladeOil,false)
	ENDIF
	IF spellSlots[0] != None
		spellSlots[0].SetNthEffectMagnitude(0,magSlots[0])
		spellSlots[0].SetNthEffectDuration(0,durSlots[0])
		akActor.AddSpell(spellSlots[0],false)
	ENDIF
	IF spellSlots[1] != None
		spellSlots[1].SetNthEffectMagnitude(0,magSlots[1])
		spellSlots[1].SetNthEffectDuration(0,durSlots[1])
		akActor.AddSpell(spellSlots[1],false)
	ENDIF
	IF spellSlots[2] != None
		spellSlots[2].SetNthEffectMagnitude(0,magSlots[2])
		spellSlots[2].SetNthEffectDuration(0,durSlots[2])
		akActor.AddSpell(spellSlots[2],false)
	ENDIF
	IF myCritEffect != None
		myCritEffect.SetNthEffectMagnitude(0,CritEffectMag)
		myCritEffect.SetNthEffectMagnitude(1,CritEffectMag * CritEffectMag2Mult)
	ENDIF
ENDEVENT

EVENT OnUnequipped(ACTOR akActor)
	akActor.RemoveSpell(bladeOil)
	
	IF spellSlots[0] != None
		spellSlots[0].SetNthEffectMagnitude(0,magSlots[0])
		spellSlots[0].SetNthEffectDuration(0,durSlots[0])
		akActor.RemoveSpell(spellSlots[0])
	ENDIF
	IF spellSlots[1] != None
		spellSlots[1].SetNthEffectMagnitude(0,magSlots[1])
		spellSlots[1].SetNthEffectDuration(0,durSlots[1])
		akActor.RemoveSpell(spellSlots[1])
	ENDIF
	IF spellSlots[2] != None
		spellSlots[2].SetNthEffectMagnitude(0,magSlots[2])
		spellSlots[2].SetNthEffectDuration(0,durSlots[2])
		akActor.RemoveSpell(spellSlots[2])
	ENDIF
ENDEVENT

STRING FUNCTION getMagSlot(INT akIndex)
	IF magSlots[akIndex] == 0.0
		RETURN ""
	ELSE
		RETURN magSlots[akIndex]
	ENDIF
ENDFUNCTION

STRING FUNCTION getNameSlot(INT akIndex)
	IF nameSlots[akIndex] == ""
		RETURN "~"
	ELSE
		RETURN nameSlots[akIndex]
	ENDIF
ENDFUNCTION

STRING FUNCTION getMyName()
	IF Self.GetRef() == None
		RETURN "None"
	ELSE
		RETURN Self.GetRef().GetDisplayName()
	ENDIF
ENDFUNCTION

FUNCTION setMyName(STRING akString)
	IF Self.GetRef() != None
		Self.GetRef().SetDisplayName(akString)
	ENDIF
ENDFUNCTION

FUNCTION loadAlias()
	IF myRef != None
		ForceRefTo(myRef)
		updateStats()
	ENDIF
ENDFUNCTION

FUNCTION updateStats()
	GSA_Weapon.SetBaseDamage(myBaseDamage)
	GSA_Weapon.SetCritDamage(myCritDamage)
	GSA_Weapon.SetCritMultiplier(myCritMultiplier)
	GSA_Weapon.SetReach(myReach)
	GSA_Weapon.SetSpeed(mySpeed)
	GSA_Weapon.SetStagger(myStagger)
	GSA_Weapon.SetWeight(myWeight)
	GSA_Weapon.SetModelPath(myModelPath)
	;GSA_Weapon.SetResist(myResist)
	GSA_Weapon.SetEquippedModel(myEquippedModel)
	GSA_Weapon.SetCritEffect(myCritEffect)
	GSA_Weapon.SetCritEffectOnDeath(myCritOnDeath)
	
	IF myCritEffect != None
		myCritEffect.SetNthEffectMagnitude(0,CritEffectMag)
		myCritEffect.SetNthEffectMagnitude(1,CritEffectMag * CritEffectMag2Mult)
	ENDIF
ENDFUNCTION

INT FUNCTION addSpellSlot(STRING akName, SPELL akSpell, FLOAT akMag, INT akDur = 0)
	IF akSpell != None && ( ( spellSlots[0] == akSpell ) || ( spellSlots[1] == akSpell ) || ( spellSlots[2] == akSpell ) )
		RETURN -1
	ENDIF
	
	IF nameSlots[0] == "" && GSA_numWeaponSlots.GetValueInt() > 0
		nameSlots[0] = akName
		spellSlots[0] = akSpell
		magSlots[0] = akMag
		durSlots[0] = akDur
		RETURN 1
	ELSEIF nameSlots[1] == "" && GSA_numWeaponSlots.GetValueInt() > 1
		nameSlots[1] = akName
		spellSlots[1] = akSpell
		magSlots[1] = akMag
		durSlots[1] = akDur		
		RETURN 1
	ELSEIF nameSlots[2] == "" && GSA_numWeaponSlots.GetValueInt() > 2
		nameSlots[2] = akName
		spellSlots[2] = akSpell
		magSlots[2] = akMag
		durSlots[2] = akDur		
		RETURN 1
	ELSE
		RETURN 0
	ENDIF
ENDFUNCTION

INT FUNCTION addCritSlot(STRING akName, SPELL akSpell, FLOAT akMag, FLOAT akMag2Mult)
	IF akSpell != None && ( ( spellSlots[0] == akSpell ) || ( spellSlots[1] == akSpell ) || ( spellSlots[2] == akSpell ) )
		RETURN -1
	ENDIF
	
	IF myCritEffect == None
		nameSlots[0] = akName
		myCritEffect = akSpell
		CritEffectMag = akMag
		CritEffectMag2Mult = akMag2Mult
		RETURN 1
	ELSE
		RETURN 0
	ENDIF
ENDFUNCTION

INT PROPERTY myBaseDamage AUTO
INT PROPERTY myCritDamage AUTO
FLOAT PROPERTY myCritMultiplier AUTO
FLOAT PROPERTY myReach AUTO
FLOAT PROPERTY mySpeed AUTO
FLOAT PROPERTY myStagger AUTO
FLOAT PROPERTY myWeight AUTO
STRING PROPERTY myModelPath AUTO
;STRING PROPERTY myResist AUTO
STATIC PROPERTY myEquippedModel AUTO
SPELL PROPERTY myCritEffect AUTO
FLOAT PROPERTY CritEffectMag AUTO
FLOAT PROPERTY CritEffectMag2Mult AUTO
BOOL PROPERTY myCritOnDeath AUTO
STRING[] PROPERTY nameSlots AUTO
SPELL[] PROPERTY spellSlots AUTO
FLOAT[] PROPERTY magSlots AUTO
INT[] PROPERTY durSlots AUTO