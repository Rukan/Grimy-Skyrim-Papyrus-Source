Scriptname GSA_AddSmithingPerks extends activemagiceffect  

PERK PROPERTY ArcaneBlacksmith AUTO
PERK PROPERTY DaedricSmithing AUTO
PERK PROPERTY DwarvenSmithing AUTO
PERK PROPERTY EbonySmithing AUTO
PERK PROPERTY ElvenSmithing AUTO

PERK PROPERTY GlassSmithing AUTO
PERK PROPERTY OrcishSmithing AUTO
PERK PROPERTY SteelSmithing AUTO
PERK PROPERTY AdvancedArmors AUTO
PERK PROPERTY DragonArmor AUTO

ACTOR PROPERTY PlayerRef AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	PlayerRef.AddPerk(SteelSmithing)
	RegisterForMenu("Crafting Menu")
	IF PlayerRef.GetBaseAV("Smithing") >= 30.0
		GoToState("Level30")
	ENDIF
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	RemovePerks()
ENDEVENT

EVENT OnPlayerLoadGame()
	RegisterForMenu("Crafting Menu")
ENDEVENT

EVENT OnMenuOpen(String MenuName)
	IF PlayerRef.GetBaseAV("Smithing") >= 30.0
		GoToState("Level30")
	ENDIF
ENDEVENT

STATE Level30
	EVENT OnBeginState()
		PlayerRef.AddPerk(DwarvenSmithing)
		PlayerRef.AddPerk(ElvenSmithing)	
		RegisterForMenu("Crafting Menu")
		IF PlayerRef.GetBaseAV("Smithing") >= 50.0
			GoToState("Level50")
		ENDIF
	ENDEVENT

	EVENT OnPlayerLoadGame()
		RegisterForMenu("Crafting Menu")
	ENDEVENT
	
	EVENT OnMenuOpen(String MenuName)
		IF PlayerRef.GetBaseAV("Smithing") >= 50.0
			GoToState("Level50")
		ENDIF
	ENDEVENT

	EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
		RemovePerks()
	ENDEVENT
ENDSTATE

STATE Level50
	EVENT OnBeginState()
		PlayerRef.AddPerk(OrcishSmithing)
		PlayerRef.AddPerk(AdvancedArmors)
		RegisterForMenu("Crafting Menu")
		IF PlayerRef.GetBaseAV("Smithing") >= 60.0
			GoToState("Level60")
		ENDIF
	ENDEVENT

	EVENT OnPlayerLoadGame()
		RegisterForMenu("Crafting Menu")
	ENDEVENT
	
	EVENT OnMenuOpen(String MenuName)
		IF PlayerRef.GetBaseAV("Smithing") >= 60.0
			GoToState("Level60")
		ENDIF
	ENDEVENT

	EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
		RemovePerks()
	ENDEVENT
ENDSTATE

STATE Level60
	EVENT OnBeginState()
		PlayerRef.AddPerk(ArcaneBlacksmith)
		RegisterForMenu("Crafting Menu")
		IF PlayerRef.GetBaseAV("Smithing") >= 70.0
			GoToState("Level70")
		ENDIF
	ENDEVENT

	EVENT OnPlayerLoadGame()
		RegisterForMenu("Crafting Menu")
	ENDEVENT
	
	EVENT OnMenuOpen(String MenuName)
		IF PlayerRef.GetBaseAV("Smithing") >= 70.0
			GoToState("Level70")
		ENDIF
	ENDEVENT

	EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
		RemovePerks()
	ENDEVENT
ENDSTATE

STATE Level70
	EVENT OnBeginState()
		PlayerRef.AddPerk(GlassSmithing)
		RegisterForMenu("Crafting Menu")
		IF PlayerRef.GetBaseAV("Smithing") >= 80.0
			GoToState("Level80")
		ENDIF
	ENDEVENT

	EVENT OnPlayerLoadGame()
		RegisterForMenu("Crafting Menu")
	ENDEVENT
	
	EVENT OnMenuOpen(String MenuName)
		IF PlayerRef.GetBaseAV("Smithing") >= 80.0
			GoToState("Level80")
		ENDIF
	ENDEVENT

	EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
		RemovePerks()
	ENDEVENT
ENDSTATE

STATE Level80
	EVENT OnBeginState()
		PlayerRef.AddPerk(EbonySmithing)
		RegisterForMenu("Crafting Menu")
		IF PlayerRef.GetBaseAV("Smithing") >= 90.0
			GoToState("Level90")
		ENDIF
	ENDEVENT

	EVENT OnPlayerLoadGame()
		RegisterForMenu("Crafting Menu")
	ENDEVENT
	
	EVENT OnMenuOpen(String MenuName)
		IF PlayerRef.GetBaseAV("Smithing") >= 90.0
			GoToState("Level90")
		ENDIF
	ENDEVENT

	EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
		RemovePerks()
	ENDEVENT
ENDSTATE

STATE Level90
	EVENT OnBeginState()
		PlayerRef.AddPerk(DaedricSmithing)
		RegisterForMenu("Crafting Menu")
		IF PlayerRef.GetBaseAV("Smithing") >= 100.0
			GoToState("Level100")
		ENDIF
	ENDEVENT

	EVENT OnPlayerLoadGame()
		RegisterForMenu("Crafting Menu")
	ENDEVENT
	
	EVENT OnMenuOpen(String MenuName)
		IF PlayerRef.GetBaseAV("Smithing") >= 100.0
			GoToState("Level100")
		ENDIF
	ENDEVENT
		
	EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
		RemovePerks()
	ENDEVENT
ENDSTATE

STATE Level100
	EVENT OnBeginState()
		PlayerRef.AddPerk(DragonArmor)
	ENDEVENT
	
	EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
		RemovePerks()
	ENDEVENT
ENDSTATE

FUNCTION RemovePerks()
	PlayerRef.RemovePerk(ArcaneBlacksmith)
	PlayerRef.RemovePerk(DaedricSmithing)
	PlayerRef.RemovePerk(DwarvenSmithing)
	PlayerRef.RemovePerk(EbonySmithing)
	PlayerRef.RemovePerk(ElvenSmithing)

	PlayerRef.RemovePerk(GlassSmithing)
	PlayerRef.RemovePerk(OrcishSmithing)
	PlayerRef.RemovePerk(SteelSmithing)
	PlayerRef.RemovePerk(AdvancedArmors)
	PlayerRef.RemovePerk(DragonArmor)
ENDFUNCTION