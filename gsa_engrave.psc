Scriptname GSA_Engrave extends activemagiceffect  

GSA_WeaponAlias PROPERTY BattleaxeAlias AUTO
GSA_WeaponAlias PROPERTY BowAlias AUTO
GSA_WeaponAlias PROPERTY DaggerAlias AUTO
GSA_WeaponAlias PROPERTY GreatswordAlias AUTO
GSA_WeaponAlias PROPERTY MaceAlias AUTO
GSA_WeaponAlias PROPERTY SwordAlias AUTO
GSA_WeaponAlias PROPERTY WarAxeAlias AUTO
GSA_WeaponAlias PROPERTY WarhammerAlias AUTO
GSA_WeaponAlias PROPERTY CrossbowAlias AUTO

GSA_ArmorAlias PROPERTY LightHelmetAlias AUTO
GSA_ArmorAlias PROPERTY LightCuirassAlias AUTO
GSA_ArmorAlias PROPERTY LightGauntletsAlias AUTO
GSA_ArmorAlias PROPERTY LightBootsAlias AUTO
GSA_ArmorAlias PROPERTY LightShieldAlias AUTO

GSA_ArmorAlias PROPERTY HeavyHelmetAlias AUTO
GSA_ArmorAlias PROPERTY HeavyCuirassAlias AUTO
GSA_ArmorAlias PROPERTY HeavyGauntletsAlias AUTO
GSA_ArmorAlias PROPERTY HeavyBootsAlias AUTO
GSA_ArmorAlias PROPERTY HeavyShieldAlias AUTO

KEYWORD PROPERTY WeapTypeSword AUTO
KEYWORD PROPERTY WeapTypeWarAxe AUTO
KEYWORD PROPERTY WeapTypeMace AUTO
KEYWORD PROPERTY WeapTypeBow AUTO
KEYWORD PROPERTY WeapTypeDagger AUTO
KEYWORD PROPERTY WeapTypeGreatsword AUTO
KEYWORD PROPERTY WeapTypeBattleaxe AUTO
KEYWORD PROPERTY WeapTypeWarhammer AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	OBJECTREFERENCE crosshairRef = Game.GetCurrentCrosshairRef()
	FORM tempRef = crosshairRef.getBaseObject()

	IF tempRef AS WEAPON
		IF tempRef.HasKeyword(WeapTypeSword)
			SwordAlias.attachReference(crosshairRef,tempRef AS WEAPON)
		ELSEIF tempRef.HasKeyword(WeapTypeWarAxe)
			WarAxeAlias.attachReference(crosshairRef,tempRef AS WEAPON)
		ELSEIF tempRef.HasKeyword(WeapTypeBow)
			IF (tempRef AS WEAPON).GetWeaponType() == 7
				BowAlias.attachReference(crosshairRef,tempRef AS WEAPON)
			ELSE
				CrossbowAlias.attachReference(crosshairRef,tempRef AS WEAPON)
			ENDIF
		ELSEIF tempRef.HasKeyword(WeapTypeMace)
			MaceAlias.attachReference(crosshairRef,tempRef AS WEAPON)
		ELSEIF tempRef.HasKeyword(WeapTypeDagger)
			DaggerAlias.attachReference(crosshairRef,tempRef AS WEAPON)
		ELSEIF tempRef.HasKeyword(WeapTypeGreatsword)
			GreatswordAlias.attachReference(crosshairRef,tempRef AS WEAPON)
		ELSEIF tempRef.HasKeyword(WeapTypeBattleaxe)
			BattleaxeAlias.attachReference(crosshairRef,tempRef AS WEAPON)
		ELSEIF tempRef.HasKeyword(WeapTypeWarhammer)
			WarhammerAlias.attachReference(crosshairRef,tempRef AS WEAPON)
		ELSE
			Debug.Notification("Unrecognized Weapon Type")
		ENDIF
	ELSEIF tempRef AS ARMOR
		IF ( tempRef AS ARMOR ).GetWeightClass() == 0
			IF ( tempRef AS ARMOR ).IsHelmet()
				lightHelmetAlias.attachReference(crosshairRef)
			ElSEIF ( tempRef AS ARMOR ).IsCuirass()
				lightCuirassAlias.attachReference(crosshairRef)
			ELSEIF ( tempRef AS ARMOR ).IsGauntlets()
				lightGauntletsAlias.attachReference(crosshairRef)
			ELSEIF ( tempRef AS ARMOR ).IsBoots()
				lightBootsAlias.attachReference(crosshairRef)
			ELSEIF ( tempRef AS ARMOR ).IsShield()
				lightShieldAlias.attachReference(crosshairRef)
			ELSE
				Debug.Notification("Unrecognized Armor Weight Class")
			ENDIF
		ELSEIF ( tempRef AS ARMOR ).GetWeightClass() == 1
			IF ( tempRef AS ARMOR ).IsHelmet()
				heavyHelmetAlias.attachReference(crosshairRef)
			ElSEIF ( tempRef AS ARMOR ).IsCuirass()
				heavyCuirassAlias.attachReference(crosshairRef)
			ELSEIF ( tempRef AS ARMOR ).IsGauntlets()
				heavyGauntletsAlias.attachReference(crosshairRef)
			ELSEIF ( tempRef AS ARMOR ).IsBoots()
				heavyBootsAlias.attachReference(crosshairRef)
			ELSEIF ( tempRef AS ARMOR ).IsShield()
				heavyShieldAlias.attachReference(crosshairRef)
			ELSE
				Debug.Notification("Unrecognized Armor Weight Class")
			ENDIF
		ELSE
			Debug.Notification("Unrecognized Armor Weight Class")
		ENDIF
	ELSE
		Debug.Notification("Unrecognized Item Type")
	ENDIF
ENDEVENT