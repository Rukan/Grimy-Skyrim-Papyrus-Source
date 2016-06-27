Scriptname GVC_Engine_Alias extends ReferenceAlias  

IMPORT KMXPotionUtil

EVENT OnInit()
	ForceRefTo(PlayerRef)	
ENDEVENT

FUNCTION StartCooldown()
	IF GVC_Base_Cooldown.GetValue() > 0.0
		GoToState("Cooldown")
	ENDIF
ENDFUNCTION

STATE Cooldown
	FUNCTION StartCooldown()
	ENDFUNCTION

	EVENT OnBeginState()
		PlayerRef.AddPerk(GVC_CooldownPerk)
		ForceRefTo(PlayerRef)	
		RegisterForSingleUpdate(GVC_Base_Cooldown.GetValue()*(1.0-PlayerRef.GetActorValue("Alchemy")*GVC_ScaleCooldown.GetValue()))
	ENDEVENT
	
	EVENT OnUpdate()
		PlayerRef.RemovePerk(GVC_CooldownPerk)
		GVC_Cooldown.Show()
		GoToState("")
	ENDEVENT

	EVENT OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		IF akBaseObject.HasKeyword(MagicAlch)
			GVC_RefundMessage.Show()
			; Do NOT use AddItem on player made potions
			IF akBaseObject.GetFormID() >= 0xFF000000
				IncPotionRefCount(akBaseObject AS POTION,1)
			ENDIF
			PlayerRef.AddItem(akBaseObject,1,true)
		ENDIF
	ENDEVENT
ENDSTATE

ACTOR PROPERTY PlayerRef AUTO
GLOBALVARIABLE PROPERTY GVC_Base_Cooldown AUTO
GLOBALVARIABLE PROPERTY GVC_ScaleCooldown AUTO
KEYWORD PROPERTY MagicAlch AUTO
MESSAGE PROPERTY GVC_Cooldown AUTO
MESSAGE PROPERTY GVC_RefundMessage AUTO
PERK PROPERTY GVC_CooldownPerk AUTO