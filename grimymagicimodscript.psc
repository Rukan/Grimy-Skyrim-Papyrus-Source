scriptName GrimyMagicImodScript extends ActiveMagicEffect
{Scripted effect for the using Image Space Mods on Magic Effects}

Spell property GrimySpellPerkAuraWhisper auto

Event OnEffectStart(Actor Target, Actor Caster)
	GrimySpellPerkAuraWhisper.Cast(Target,Target)

EndEvent
