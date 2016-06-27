Scriptname MagExtend hidden

;Sets the inputted mgef to use a new Magic Effect Archetype. Different Archetypes require different parameters to be sent.
;Parameters are checked internally and the function will abort if any essential data is missing (SEE LIST BELOW).
Function SetMGEFArchetype(MagicEffect mgef, string archetype, string primaryAV = "", form relatedForm = NONE, string secondaryAV = "", float secondAVWeight = 1.0) global native

;Change primary Actor Value data for archetypes that use it (SEE LIST BELOW)
Function SetMGEFPrimaryAV(MagicEffect mgef, string primaryAV) global native

;Secondary Actor Value functions only work with a "DualValueMod" archetype
Function SetMGEFSecondaryAV(MagicEffect mgef, string secondaryAV) global native
Function SetMGEFSecondaryAVWeight(MagicEffect mgef, float secondAVWeight) global native

;Change Form data used by current archetype. Form type passed in must be valid for this archetype (SEE LIST BELOW)
Function SetMGEFRelatedForm(MagicEffect mgef, Form relatedForm) global native

;Retrieve the Magic Effect's current archetype as a string (SEE LIST BELOW)
string Function GetMGEFArchetype(MagicEffect mgef) global native
;Retrieve the Magic Effect's current archetype by its integer value (SEE LIST BELOW)
int Function GetMGEFArchetypeNum(MagicEffect mgef) global native
string Function GetMGEFPrimaryAV(MagicEffect mgef) global native
string Function GetMGEFSecondaryAV(MagicEffect mgef) global native
float Function GetMGEFSecondaryAVWeight(MagicEffect mgef) global native
Form Function GetMGEFRelatedForm(MagicEffect mgef) global native

  ; VALID ARCHETYPES              PARAMETERS ACCEPTED
  ; 0    "ValueMod"                primaryAV
  ; 1    "Script"                  NONE
  ; 2    "Dispel"                  NONE
  ; 3    "CureDisease"             NONE
  ; 4    "Absorb"                  primaryAV
  ; 5    "DualValueMod"            primaryAV, secondaryAV, secondAVWeight
  ; 6    "Calm"                    NONE (primaryAV forced to "Aggression")
  ; 7    "Demoralize"              NONE (primaryAV forced to "Confidence")
  ; 8    "Frenzy"                  NONE (primaryAV forced to "Aggression")
  ; 9    "Disarm"                  NONE
  ; 10   "CommandSummoned"         NONE
  ; 11   "Invisibility"            NONE (primaryAV forced to "Invisibility")
  ; 12   "Light"                   relatedForm (LIGHT)
  ; 15   "Lock"                    NONE
  ; 16   "Open"                    NONE
  ; 17   "BoundWeapon"             relatedForm (WEAPON)
  ; 18   "SummonCreature"          relatedForm (ACTOR - must have "Summonable" flag ticked or will not work)
  ; 19   "DetectLife"              NONE
  ; 20   "Telekinesis"             NONE
  ; 21   "Paralysis"               NONE (primaryAV forced to "Paralysis")
  ; 22   "Reanimate"               NONE
  ; 23   "SoulTrap"                NONE
  ; 24   "TurnUndead"              NONE (primaryAV forced to "Confidence")
  ; 25   "Guide"                   relatedForm (HAZARD)
  ; 26   "WerewolfFeed"            NONE
  ; 27   "CureParalysis"           NONE
  ; 28   "CureAddiction"           NONE
  ; 29   "CurePoison"              NONE
  ; 30   "Concussion"              NONE
  ; 31   "ValueAndParts"           primaryAV
  ; 32   "AccumulateMagnitude"     primaryAV (WardPower recommended, but may work with others)
  ; 33   "Stagger"                 NONE
  ; 34   "PeakValueMod"            primaryAV, relatedForm (KEYWORD) [relatedForm is optional]
  ; 35   "Cloak"                   relatedForm (SPELL - must have types "Concentration" & "Aimed" or will not work)
  ; 36   "Werewolf"                relatedForm (RACE)
  ; 37   "SlowTime"                NONE
  ; 38   "Rally"                   NONE (primaryAV forced to "Confidence")
  ; 39   "EnhanceWeapon"           relatedForm (ENCHANTMENT)
  ; 40   "SpawnHazard"             relatedForm (HAZARD)
  ; 41   "Etherealize"             NONE
  ; 42   "Banish"                  NONE (primaryAV forced to "Confidence")
  ; 43   "SpawnScriptedRef"        NONE
  ; 44   "Disguise"                NONE
  ; 45   "GrabActor"               NONE
  ; 46   "VampireLord"             relatedForm (RACE)


;Set the taper duration/weight/curve for this Magic Effect. Taper values can be changed regardless of archetype.
Function SetMGEFTaperDuration(MagicEffect mgef, float tDuration) global native
Function SetMGEFTaperWeight(MagicEffect mgef, float tWeight) global native
Function SetMGEFTaperCurve(MagicEffect mgef, float tCurve) global native
;Set all three taper values at once.
Function SetMGEFTaperValues(MagicEffect mgef, float tDuration, float tWeight, float tCurve) global native
  
float Function GetMGEFTaperDuration(MagicEffect mgef) global native
float Function GetMGEFTaperWeight(MagicEffect mgef) global native
float Function GetMGEFTaperCurve(MagicEffect mgef) global native


;Version 1.03 beta additions:
Function SetActiveEffectMagnitude(ActiveMagicEffect AME, float newMag) global native
;will fail and return false if (newDur - AME.getTimeElapsed()) is less than 1 second:
bool Function SetActiveEffectDuration(ActiveMagicEffect AME, float newDur) global native