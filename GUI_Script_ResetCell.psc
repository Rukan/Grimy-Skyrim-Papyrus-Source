Scriptname GUI_Script_ResetCell extends activemagiceffect  

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	CELL tempCell = akCaster.GetParentCell()
	IF tempCell
		tempCell.reset()
	ELSE
		Debug.Notification("Error, no parent cell")
	ENDIF
ENDEVENT