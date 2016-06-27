Scriptname SWT_Test_ArmorScript extends ObjectReference  

MagicEffect[] Property Effects Auto
Float[] Property Mags Auto
Int[] Property Areas Auto
Int[] Property Durations Auto

Event OnGrab()
	CreateEnchantment(0.0, Effects, Mags, Areas, Durations)
EndEvent