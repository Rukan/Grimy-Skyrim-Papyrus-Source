Scriptname GELO_PerkEnchant extends activemagiceffect  

ACTOR PROPERTY PlayerRef AUTO
FORMLIST PROPERTY PerkList AUTO
GLOBALVARIABLE PROPERTY MinGlobal AUTO
GLOBALVARIABLE PROPERTY MaxGlobal AUTO

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	float min = MinGlobal.GetValue()
	float max = MaxGlobal.GetValue()
	IF akTarget == PlayerRef
		IF getMagnitude() < min
			akTarget.AddPerk(PerkList.GetAt(0) AS PERK)
		ELSEIF getMagnitude() > max
			akTarget.AddPerk(perkList.GetAt( -1 + perkList.GetSize() ) AS PERK)
		ELSE
			akTarget.AddPerk(perkList.GetAt((getMagnitude() - min + 0.5) AS INT) AS PERK)
		ENDIF
	ENDIF
ENDEVENT

EVENT OnEffectFinish(Actor akTarget, Actor akCaster)
	IF akTarget == PlayerRef
		INT i = 0
		WHILE i < PerkList.GetSize()
			akTarget.RemovePerk(PerkList.GetAt(i) AS PERK)
			i = i + 1
		ENDWHILE
	ENDIF
ENDEVENT