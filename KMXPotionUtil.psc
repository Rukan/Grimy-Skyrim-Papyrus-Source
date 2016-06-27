Scriptname KMXPotionUtil Hidden
{Utility functions for potions.  Requires KMX Utility Plugin.}

; Populates a list of potions associated with a particular workbench.
Function GetWorkbenchPotions(FormList akResultList, Keyword akWBKeyword) global native


; Scales the effect strength of a single potion.
Function ScalePotionStrength(Potion akPotion, float afStrengthMult) global native


; Scales the effect strength of several potions.
Function BatchScalePotionStrength(FormList akPotionList, float afStrengthMult) global native


; Scales the gold value of a single potion.
;
; Does not affect potions which have their value calculated automatically.
Function ScalePotionGoldValue(Potion akPotion, float afValueMult) global native


; Scales the gold value of several potions.
;
; Does not affect potions which have their value calculated automatically.
Function BatchScalePotionGoldValue(FormList akPotionList, float afValueMult) global native


; Returns true when two potions have the same effects as each other.
bool Function SamePotionEffects(Potion akPotion1, Potion akPotion2) global native


; Creates a persistent potion with the same magic effects as the one passed.
;
; If two potions have the same effects, the same clone will be generated.
;
; Also, cloned potions require a maintenance function to keep up appearances.  See CopyPotionNED(). 
Potion Function ImpClonePotion(Potion akPotion) global native


; A working version of Form.TempClone() for potions.
;
; The same rules apply here and you should probably call ImpClonePotion() instead.
Potion Function TempClonePotion(Potion akPotion) global native


; Changes one potion to match another sans magic effects.
Function CopyPotionNED(Potion akSource, Potion akDestination) global native


; Sets flags on a single potion.
;
; Possible values are:
;
; Manual Potion Value	0x00000001
; Food			0x00000002
; Medicine		0x00010000
; Poison		0x00020000
Function SetPotionFlag(Potion akPotion, int aiFlag) global native


; Sets flags on several potions.
Function BatchSetPotionFlag(FormList akPotionList, int aiFlag) global native


; Clears flags on a single potion.
Function ClearPotionFlag(Potion akPotion, int aiFlag) global native


; Clears flags on several potions.
Function BatchClearPotionFlag(FormList akPotionList, int aiFlag) global native


; Sets the use sound for a single potion.
Function SetPotionUseSound(Potion akPotion, SoundDescriptor akUseSound) global native


; Sets the use sound for several potions.
Function BatchSetPotionUseSound(FormList akPotionList, SoundDescriptor akUseSound) global native


; Returns the total effect cost for the current potion.
int Function GetPotionCost(Potion akPotion) global native


;Functions added in v1.2.


; Returns the total number of potions that exist in the game.
int Function GetGamePotionCount() global native


; Adds a dummy effect to prevent the same clone from being generated for two different potions with the same effects.
;
; The dummy effect is loaded with metadata to assist with maintaining aesthetics.
;
; Magnitude	Stores source potion's weight.
; Area		Stores source potion's form ID.
; Duration	Stores source potion's gold value.
;
; It is best to use a custom magic effect that ignores the above stats.
Potion Function ImpClonePotionEx(Potion akPotion, MagicEffect akDummyEffect) global native


; Restores non-magic-effect-data for a potion created by ImpClonePotionEx().
Function RestoreImpCloneNED(Potion akClonePotion) global native


; Restores non-magic-effect-data for several potions created by ImpClonePotionEX().
Function BatchRestoreImpCloneNED(FormList akCloneList) global native


; Prevents CTD's caused by consuming crafted potions added through script.
;
; Must be called whenever a crafted potion is added via ObjectReference.AddItem().
Function IncPotionRefCount(Potion akPotion, int aiCount = 1) global native