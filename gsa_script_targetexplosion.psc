Scriptname GSA_Script_TargetExplosion extends activemagiceffect  

ACTOR PROPERTY PlayerRef AUTO
SPELL PROPERTY akSpell AUTO
ENCHANTMENT PROPERTY akEnch AUTO

EVENT OnEffectStart(ACTOR akTarget, ACTOR akCaster)
	FLOAT akFloat = akTarget.GetAV("Magicka")
	Debug.Notification("Cast on " + akTarget.GetDisplayName() + " " + akFloat)
	akEnch.SetNthEffectMagnitude(0,akFloat)
	akTarget.DamageAV("Magicka",akFloat)
	akSpell.Cast(akTarget)
ENDEVENT