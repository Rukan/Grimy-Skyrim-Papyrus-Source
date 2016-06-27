Scriptname GSA_ArmorAlias extends ReferenceAlias  

ACTOR PROPERTY PlayerRef AUTO
OBJECTREFERENCE myRef
GLOBALVARIABLE PROPERTY GSA_numArmorSlots AUTO
SPELL PROPERTY AbilitySpell = None AUTO
FLOAT PROPERTY AbilityMagnitude AUTO
FLOAT PROPERTY AbilityCost AUTO
FLOAT PROPERTY AbilityCooldown AUTO
INT PROPERTY AbilityDuration AUTO
INT PROPERTY AbilityIndex AUTO
SOUND PROPERTY AbilitySound AUTO
GAA_MenuMain PROPERTY GAA_MainMenu AUTO

FUNCTION loadAlias()
	IF myRef != None
		ForceRefTo(myRef)
		IF PlayerRef.IsEquipped(myRef.GetBaseObject()) && AbilitySpell
			AbilitySpell.SetNthEffectMagnitude(0,AbilityMagnitude)
			AbilitySpell.SetNthEffectDuration(0,AbilityDuration)
		ENDIF
	ENDIF
ENDFUNCTION

FUNCTION attachReference(OBJECTREFERENCE crosshairRef)
	IF Self.GetRef() == crosshairRef
		Debug.Notification("that's already a signature armor")
		RETURN
	ENDIF
	
	;=== Reset name of previous ref ===
	IF Self.GetRef() != None
		Self.GetRef().SetDisplayName(Self.GetRef().GetBaseObject().GetName())
	ENDIF
	
	resetStats()
	
	;=== set up new ref ===
	myRef = crosshairRef
	Self.ForceRefTo(myRef)
	myRef.SetDisplayName("Signature " + Self.GetRef().GetDisplayName())
	myRef.SetActorOwner(PlayerRef.GetActorBase())
	myRef.Activate(PlayerRef)
ENDFUNCTION

FUNCTION resetStats()
	nameSlots[0] = ""
	nameSlots[1] = ""
	nameSlots[2] = ""
	spellSlots[0] = None
	spellSlots[1] = None
	spellSlots[2] = None
	AbilitySpell = None
	AbilityDuration = 0
	AbilityMagnitude = 0.0
	AbilityCost = 0.0
	AbilityCooldown = 0.0
ENDFUNCTION
STRING[] PROPERTY nameSlots AUTO
SPELL[] PROPERTY spellSlots AUTO
FLOAT[] PROPERTY magSlots AUTO
INT[] PROPERTY durSlots AUTO

EVENT OnActivate(ObjectReference akActionRef)
	IF akActionRef == PlayerRef
		loadAlias()
	ENDIF
ENDEVENT

EVENT OnEquipped(ACTOR akActor)
	IF spellSlots[0] != None
		spellSlots[0].SetNthEffectMagnitude(0,magSlots[0])
		spellSlots[0].SetNthEffectDuration(0,durSlots[0])
		akActor.AddSpell(spellSlots[0],false)
	ENDIF
	IF spellSlots[1] != None
		spellSlots[1].SetNthEffectMagnitude(0,magSlots[1])
		spellSlots[1].SetNthEffectDuration(0,durSlots[1])
		akActor.AddSpell(spellSlots[1],false)
	ENDIF
	IF spellSlots[2] != None
		spellSlots[2].SetNthEffectMagnitude(0,magSlots[2])
		spellSlots[2].SetNthEffectDuration(0,durSlots[2])
		akActor.AddSpell(spellSlots[2],false)
	ENDIF
	GAA_MainMenu.AbilitySpells[AbilityIndex] = AbilitySpell
	GAA_MainMenu.AbilityCosts[AbilityIndex] = AbilityCost
	GAA_MainMenu.AbilityCooldowns[AbilityIndex] = AbilityCooldown
	GAA_MainMenu.AbilitySounds[AbilityIndex] = AbilitySound
	IF AbilitySpell
		AbilitySpell.SetNthEffectMagnitude(0,AbilityMagnitude)
		AbilitySpell.SetNthEffectDuration(0,AbilityDuration)
	ENDIF
ENDEVENT

EVENT OnUnequipped(ACTOR akActor)
	IF spellSlots[0] != None
		akActor.RemoveSpell(spellSlots[0])
	ENDIF
	IF spellSlots[1] != None
		akActor.RemoveSpell(spellSlots[1])
	ENDIF
	IF spellSlots[2] != None
		akActor.RemoveSpell(spellSlots[2])
	ENDIF
	GAA_MainMenu.AbilitySpells[AbilityIndex] = None
	GAA_MainMenu.AbilityCosts[AbilityIndex] = 0.0
	GAA_MainMenu.AbilityCooldowns[AbilityIndex] = 0.0
	GAA_MainMenu.AbilitySounds = None
ENDEVENT

STRING FUNCTION getMagSlot(INT akIndex)
	IF magSlots[akIndex] == 0.0
		RETURN ""
	ELSE
		RETURN magSlots[akIndex]
	ENDIF
ENDFUNCTION

STRING FUNCTION getNameSlot(INT akIndex)
	IF nameSlots[akIndex] == ""
		RETURN "~"
	ELSE
		RETURN nameSlots[akIndex]
	ENDIF
ENDFUNCTION

STRING FUNCTION getMyName()
	IF Self.GetRef() == None
		RETURN "None"
	ELSE
		RETURN Self.GetRef().GetDisplayName()
	ENDIF
ENDFUNCTION

FUNCTION setMyName(STRING akString)
	IF Self.GetRef() != None
		Self.GetRef().SetDisplayName(akString)
	ENDIF
ENDFUNCTION

INT FUNCTION addSpellSlot(STRING akName, SPELL akSpell, FLOAT akMag, INT akDur = 0)
	IF ( spellSlots[0] == akSpell ) || ( spellSlots[1] == akSpell ) || ( spellSlots[2] == akSpell )
		RETURN -1
	ENDIF
	
	IF nameSlots[0] == "" && GSA_numArmorSlots.GetValueInt() > 0
		nameSlots[0] = akName
		spellSlots[0] = akSpell
		magSlots[0] = akMag
		durSlots[0] = akDur
		RETURN 1
	ELSEIF nameSlots[1] == "" && GSA_numArmorSlots.GetValueInt() > 1
		nameSlots[1] = akName
		spellSlots[1] = akSpell
		magSlots[1] = akMag
		durSlots[1] = akDur		
		RETURN 1
	ELSEIF nameSlots[2] == "" && GSA_numArmorSlots.GetValueInt() > 2
		nameSlots[2] = akName
		spellSlots[2] = akSpell
		magSlots[2] = akMag
		durSlots[2] = akDur		
		RETURN 1
	ELSE
		RETURN 0
	ENDIF
ENDFUNCTION

INT FUNCTION addAbilitySlot(STRING akName, SPELL akSpell, FLOAT akMag, INT akDur = 0, FLOAT akCost, FLOAT akCooldown, SOUND akSound)
	IF AbilitySpell == None
		AbilitySpell = akSpell
		nameSlots[0] = akName
		AbilityMagnitude = akMag
		AbilityDuration = akdur
		AbilityCost = akCost
		AbilityCooldown = akCooldown
		AbilitySound = akSound
		RETURN 1
	ELSE
		RETURN 0
	ENDIF
ENDFUNCTION