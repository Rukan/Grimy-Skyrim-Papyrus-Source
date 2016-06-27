Scriptname iHUDWidgetScript extends Quest  

import iHUDUtilityScript

bool widgetsAvailable

bool isVisible
float currentAlpha
string widgetRootActiveEffects

GlobalVariable Property iHUDWidgetActiveEffectsOnKey Auto
GlobalVariable Property iHUDWidgetActiveEffectsOnCombat Auto
GlobalVariable Property iHUDWidgetActiveEffectsOnAlways Auto

GlobalVariable Property iHUDWidgetLinkAll Auto

Actor player

Function initialize()	
		widgetsAvailable = false
		widgetRootActiveEffects = ""

		int skiWidgetManagerFormId = 0x00000824
		if (Game.GetFormFromFile(skiWidgetManagerFormId, "SkyUI.esp") == none)
			return			
		endif
		
		player = Game.GetPlayer()
		if (player==none)
			return
		endif
		
		setiHUDBool("_root.WidgetContainer", "_visible", true)
						
		SKI_WidgetManager skiWidgetManager =  Game.GetFormFromFile(skiWidgetManagerFormId, "SkyUI.esp") as SKI_WidgetManager
		
		if (skiWidgetManager)
			SKI_WidgetBase[] widgets = skiWidgetManager.GetWidgets()
			
			if (widgets == none)
				return
			endif
			
			widgetsAvailable = true
									
			int i = 0
			while (i < widgets.length && widgetRootActiveEffects == "")
				if (widgets[i] == none)

				else
					if (widgets[i].GetWidgetType() == "ski_activeeffectswidget")
						widgetRootActiveEffects = widgets[i].WidgetRoot	
						setiHUDBool(widgetRootActiveEffects, "_visible", true)
					endif
				endif
				i+=1
			endWhile	
		endif
EndFunction

bool Function isWidgetActiveEffectsVisible(bool toggleOn)
	return iHUDWidgetActiveEffectsOnAlways.getValueInt() || (toggleOn && iHUDWidgetActiveEffectsOnKey.getValueInt()) || (player.isInCombat() && iHUDWidgetActiveEffectsOnCombat.getValueInt())
EndFunction


Function processWidget(bool toggleOn)
	if (player==none)
		player = Game.GetPlayer()
		return
	endif
	
	if (widgetsAvailable == false)
		return
	endif

	isVisible = isWidgetActiveEffectsVisible(toggleOn)

	currentAlpha = calculateAlpha(isVisible)

	if (iHUDWidgetLinkAll.GetValueInt())
		setiHUDBool("_root.WidgetContainer", "_visible", isVisible)
	else
		setiHUDBool(widgetRootActiveEffects, "_visible", isVisible)
	endif
EndFunction

float Function calculateAlpha(bool visible)
	return calculateBaseHUDAlpha(visible, 100)
EndFUnction