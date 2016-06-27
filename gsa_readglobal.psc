Scriptname GSA_ReadGlobal extends ObjectReference  

GLOBALVARIABLE PROPERTY akGlobal AUTO

EVENT OnRead()
	IF akGlobal.GetValueInt() == 0
		Debug.Notification("You have learned a new schematic")
		akGlobal.SetValueInt(1)
	ENDIF
ENDEVENT