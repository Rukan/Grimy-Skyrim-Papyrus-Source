Scriptname GSA_LoadAliasEffect extends activemagiceffect  

GSA_WeaponAlias PROPERTY BattleaxeAlias AUTO
GSA_WeaponAlias PROPERTY BowAlias AUTO
GSA_WeaponAlias PROPERTY CrossbowAlias AUTO
GSA_WeaponAlias PROPERTY DaggerAlias AUTO
GSA_WeaponAlias PROPERTY GreatswordAlias AUTO
GSA_WeaponAlias PROPERTY MaceAlias AUTO
GSA_WeaponAlias PROPERTY SwordAlias AUTO
GSA_WeaponAlias PROPERTY WarAxeAlias AUTO
GSA_WeaponAlias PROPERTY WarhammerAlias AUTO

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

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	lightHelmetAlias.loadAlias()
	lightCuirassAlias.loadAlias()
	lightGauntletsAlias.loadAlias()
	lightBootsAlias.loadAlias()
	lightShieldAlias.loadAlias()

	heavyHelmetAlias.loadAlias()
	heavyCuirassAlias.loadAlias()
	heavyGauntletsAlias.loadAlias()
	heavyBootsAlias.loadAlias()
	heavyShieldAlias.loadAlias()

	BattleaxeAlias.loadAlias()
	BowAlias.loadAlias()
	CrossbowAlias.loadAlias()
	DaggerAlias.loadAlias()
	GreatswordAlias.loadAlias()
	MaceAlias.loadAlias()
	SwordAlias.loadAlias()
	WarAxeAlias.loadAlias()
	WarhammerAlias.loadAlias()
ENDEVENT