Scriptname FISSInterface extends Quest

;_____________________________________________________________________________________
;***************************** SAVE OPERATIONS ***************************************

Function beginSave(string filename, string modname) 
	;abstract
	;needs to be called at the start of a block of Save statements
EndFunction

Function saveInt(string name, int i)
	;abstract
	;needs to be called within beginSave EndSave statements
EndFunction

Function saveString(string name, string s)
	;abstract
	;needs to be called within beginSave EndSave statements
EndFunction

Function saveFloat(string name, float f)
	;abstract
	;needs to be called within beginSave EndSave statements
EndFunction

Function saveBool(string name, bool b)
	;abstract
	;needs to be called within beginSave EndSave statements
EndFunction

string Function endSave() 
	;abstract
	;needs to be called after all Save statements
EndFunction


string Function saveTextToTxtFile(string filename, string text)
	;abstract
	;needs NOT be called within beginSave EndSave statements
EndFunction

;_____________________________________________________________________________________
;***************************** LOAD OPERATIONS ***************************************

function beginLoad(string filename)
	;abstract
endfunction

int Function loadInt(string name)
	;abstract
EndFunction

string Function loadString(string name)
	;abstract
EndFunction

float Function loadFloat(string name)
	;abstract
EndFunction

bool Function loadBool(string name)
	;abstract
EndFunction

string function getModName()
	;not supported yet
endfunction

string function endLoad( )
	;abstract
endfunction


;***************************** OTHER FUNCTIONS ***************************************
float function getVersion()
	;abstract
endfunction

float function getInterfaceVersion()
	return 1.0
endfunction

string function getAllFilenamesInFolder(string path)
	;not supported yet
endfunction

;_____________________________________________________________________________________
;***************************** INPUT OPERATIONS **************************************
string Function requestUserInput(string titleMessage)
	;not supported yet
EndFunction
string Function requestFilename()
	;not supported yet
EndFunction
Function setTheme(string fissInputTheme, float fissInputScale, float fissInputAplha)
	;not supported yet
EndFunction
Function blockInput(bool block)
	;not supported yet
EndFunction
Function forceClose()
	;not supported yet
EndFunction
Function setTitle(string title)
	;not supported yet
EndFunction
Function setText(string text)
	;not supported yet
EndFunction
Function setInfoText(string text)
	;not supported yet
EndFunction
Function hideInfoText(bool hide)
	;not supported yet
EndFunction
