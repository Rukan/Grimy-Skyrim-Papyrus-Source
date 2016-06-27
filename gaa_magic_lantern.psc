Scriptname GAA_Magic_Lantern extends activemagiceffect  

OBJECTREFERENCE PROPERTY cellHome AUTO
OBJECTREFERENCE PROPERTY akLantern AUTO
CELL PROPERTY GELO_CELL AUTO
ACTOR PROPERTY PlayerRef AUTO

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	IF GELO_CELL == akLantern.GetParentCell()
		akLantern.SetMotionType(4,false)
		akLantern.MoveTo(PlayerRef)
	ELSE
		PlayerRef.MoveTo(akLantern)
		akLantern.MoveTo(cellHome)
	ENDIF
ENDEVENT