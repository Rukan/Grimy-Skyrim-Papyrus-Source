Scriptname KMXFurnitureUtil Hidden
{Utility functions for furniture.  Requires KMX Utility Plugin.}

; Populates a list of all furniture associated with a particular keyword.
Function GetKeyFurniture(FormList akResultList, Keyword akFurnKeyword) global native


; Returns what type of workbench the current furniture is.
;
; Return values are:
;
; 0 - None
; 1 - Create Object
; 2 - Smithing Weapon
; 3 - Enchanting
; 4 - EnchantingExperiment
; 5 - Alchemy
; 6 - AlchemyExperiment
; 7 - Smithing Armor
int Function GetWorkbenchType(Furniture akWorkbench) global native


; Sets the workbench type for a single piece of furniture. 
;
; See above for possible values.
Function SetWorkbenchType(Furniture akWorkbench, int aiType) global native


; Sets the workbench type for several pieces of furniture.
Function BatchSetWorkbenchType(FormList akWBList, int aiType) global native


; Sets the workbench type for a single piece of furniture if the current type is none. 
;
; Use this function when you want to ensure compatibility with other mods.
Function SetWorkbenchTypeIfNone(Furniture akWorkbench, int aiType) global native


; Sets the workbench type for several pieces of furniture if the current type is none.
;
; Use this function when you want to ensure compatibility with other mods.
Function BatchSetWorkbenchTypeIfNone(FormList akWBList, int aiType) global native


; Returns what skill the current workbench uses.
;
; Return values are:
;
; 6 - One-handed
; 7 - Two-handed
; 8 - Archery
; 9 - Blocking
; 10 - Smithing
; 11 - Heavy Armor
; 12 - Light Armor
; 13 - Pickpocket
; 14 - Lockpicking
; 15 - Sneak
; 16 - Alchemy
; 17 - Speech
; 18 - Alteration
; 19 - Conjuration
; 20 - Destruction
; 21 - Illusion
; 22 - Restoration
; 23 - Enchanting
; 255 - None
int Function GetWorkbenchSkill(Furniture akWorkbench) global native


; Sets the use skill for a single workbench.
;
; See above for possible values.
Function SetWorkbenchSkill(Furniture akWorkbench, int aiSkill) global native


; Sets the use skill for several workbenches.
Function BatchSetWorkbenchSkill(FormList akWBList, int aiSkill) global native


; Sets the use skill for a single workbench if the current skill is none.
;
; Use this function when you want to ensure compatibility with other mods.
Function SetWorkbenchSkillIfNone(Furniture akWorkbench, int aiSkill) global native


; Sets the use skill for several workbenches if the current skill is none.
;
; Use this function when you want to ensure compatibility with other mods.
Function BatchSetWorkbenchSkillIfNone(FormList akWBList, int aiSkill) global native


; Returns the spell associated with the current furniture.
Spell Function GetFurnitureSpell(Furniture akWorkbench) global native


; Sets the spell associated with a single piece of furniture.
Function SetFurnitureSpell(Furniture akFurniture, Spell akSpell) global native


; Sets the spell associated with several pieces of furniture.
Function BatchSetFurnitureSpell(FormList akFurnList, Spell akSpell) global native