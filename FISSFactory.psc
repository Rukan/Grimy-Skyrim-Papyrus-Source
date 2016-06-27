Scriptname FISSFactory

FISSInterface Function getFISS() global
	return Game.GetFormFromFile(0x000012C4, "fiss.esp") as FISSInterface
EndFunction