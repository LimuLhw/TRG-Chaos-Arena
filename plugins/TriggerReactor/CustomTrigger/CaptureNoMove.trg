 IF event.getCurrentItem() == null || event.getCurrentItem().getItemMeta() == null
	#STOP
ENDIF
itemName = event.getCurrentItem().getItemMeta() 

IF itemName.getDisplayName() == color("&f[ &c&l레드 팀 &f]") || itemName.getDisplayName() == color("&f[ &9&l블루 팀 &f]")
	IF $worldname == "CaptureGame"
		#CANCELEVENT
	ENDIF
ENDIF
#STOP