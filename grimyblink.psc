Scriptname GrimyBlink extends ObjectReference  

ACTOR PROPERTY PlayerRef AUTO

EVENT OnLoad()
	PlayerRef.TranslateToRef(Self,5000.0)
	Self.Delete()
ENDEVENT