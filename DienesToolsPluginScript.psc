Scriptname DienesToolsPluginScript Hidden 

Function GetAllCOBJThatYieldForm(Form akForm, FormList akList) Global Native
; adds all COBJs that have akForm as their result to akList. Anything in akList will remain

ConstructibleObject Function TempCOBJ(ConstructibleObject akToCopy) Global Native
; returns a TempClone of akToCopy that lasts for the skyrim session. Should have all the same
; data as akToCopy but order my differ. Altering the clone should not alter akToCopy

Function ReplaceKYWD(Form akForm, Keyword akToReplace, Keyword akToAdd) Global Native
; If akForm has akToReplace directly on it (not attached through an alias or magic effect or the like)
; and does not have akToAdd directly on it then akToReplace will be swapped with akToAdd.
; Modifies the base Form. Lasts only a single skyrim game session.
