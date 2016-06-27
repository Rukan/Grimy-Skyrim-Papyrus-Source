scriptName GBT_Script_ItemLimiter extends activemagiceffect

keyword property VendorItemPotion auto
keyword property VendorItemPoison auto
form property Lockpick auto
keyword property VendorItemArrow auto
actor property PlayerRef auto
GrimyMenuMain Property GBT_MainMenu Auto

Import Debug

Int excess

Event OnItemAdded(form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if akBaseItem == Lockpick
		if akSourceContainer == none
			excess = PlayerRef.getItemCount(Lockpick) - GBT_MainMenu.GetGBT_limitLockpick_Int()
			if excess > 0
				PlayerRef.DropObject(akBaseItem, excess)
				Notification("Lockpick Limit - Removed " + excess as String + " Lockpicks")
			endIf
		else
			excess = PlayerRef.getItemCount(Lockpick) - GBT_MainMenu.GetGBT_limitLockpick_Int()
			if excess > 0
				PlayerRef.RemoveItem(akBaseItem, excess, true, akSourceContainer)
				Notification("Lockpick Limit - Removed " + excess as String + " Lockpicks")
			endIf
		endIf
	elseIf akBaseItem.hasKeyword(VendorItemArrow)
		if akSourceContainer == none
			excess = PlayerRef.getItemCount(VendorItemArrow as form) - GBT_MainMenu.GetGBT_limitArrow_Int()
			if excess > 0
				PlayerRef.DropObject(akBaseItem, excess)
				Notification("Ammo Limit - Removed " + excess as String + " Ammo")
			endIf
		else
			excess = PlayerRef.getItemCount(VendorItemArrow as form) - GBT_MainMenu.GetGBT_limitArrow_Int()
			if excess > 0
				PlayerRef.RemoveItem(akBaseItem, excess, true, akSourceContainer)
				Notification("Ammo Limit - Removed " + excess as String + " Ammo")
			endIf
		endIf
	elseIf akBaseItem.hasKeyword(VendorItemPotion)
		if akSourceContainer == none
			excess = PlayerRef.getItemCount(VendorItemPotion as form) - GBT_MainMenu.GetGBT_limitPotion_Int()
			if excess > 0
				PlayerRef.DropObject(akBaseItem, excess)
				Notification("Potion Limit - Removed " + excess as String + " Potion")
			endIf
		else
			excess = PlayerRef.getItemCount(VendorItemPotion as form) - GBT_MainMenu.GetGBT_limitPotion_Int()
			if excess > 0
				PlayerRef.RemoveItem(akBaseItem, excess, true, akSourceContainer)
				Notification("Potion Limit - Removed " + excess as String + " Potion")
			endIf
		endIf
	elseIf akBaseItem.hasKeyword(VendorItemPoison)
		if akSourceContainer == none
			excess = PlayerRef.getItemCount(VendorItemPoison as form) - GBT_MainMenu.GetGBT_limitPoison_Int()
			if excess > 0
				PlayerRef.DropObject(akBaseItem, excess)
				Notification("Poison Limit - Removed " + excess as String + " Poison")
			endIf
		else
			excess = PlayerRef.getItemCount(VendorItemPoison as form) - GBT_MainMenu.GetGBT_limitPoison_Int()
			if excess > 0
				PlayerRef.RemoveItem(akBaseItem, excess, true, akSourceContainer)
				Notification("Poison Limit - Removed " + excess as String + " Poison")
			endIf
		endIf
	endIf
EndEvent