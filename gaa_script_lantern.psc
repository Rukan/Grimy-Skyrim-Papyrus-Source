Scriptname GAA_Script_Lantern extends ObjectReference  

OBJECTREFERENCE PROPERTY GELO_REF AUTO

EVENT OnAttachedToCell()
	RegisterForSingleUpdate(30.0)
ENDEVENT

EVENT OnUpdate()
	MoveTo(GELO_REF)
ENDEVENT