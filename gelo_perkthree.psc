Scriptname GELO_PerkThree extends activemagiceffect  

BOOL removePerk1 = true
BOOL removePerk2 = true
BOOL removePerk3 = true
ACTOR PROPERTY PlayerRef AUTO

PERK PROPERTY perk1 AUTO
PERK PROPERTY perk2 AUTO
PERK PROPERTY perk3 AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	IF PlayerRef.HasPerk(perk1)
		removePerk1 = false;
	ELSE
		PlayerRef.AddPerk(perk1)
	ENDIF

	IF PlayerRef.HasPerk(perk2)
		removePerk2 = false;
	ELSE
		PlayerRef.AddPerk(perk2)
	ENDIF

	IF PlayerRef.HasPerk(perk3)
		removePerk3 = false;
	ELSE
		PlayerRef.AddPerk(perk3)
	ENDIF
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	IF removePerk1
		PlayerRef.RemovePerk(perk1)
	ENDIF

	IF removePerk2
		PlayerRef.RemovePerk(perk2)
	ENDIF

	IF removePerk3
		PlayerRef.RemovePerk(perk3)
	ENDIF
ENDEVENT