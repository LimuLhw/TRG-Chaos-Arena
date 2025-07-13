//Takeitem it!
IMPORT org.bukkit.Material
IF $worldname == "CaptureGame"
	item = event.getItemDrop().getItemStack()
	swordItem = {"captureitems.defaultsword"}
	#CANCELEVENT
	SYNC
		IF item == swordItem
		ELSE
			takeItem(player,item,0)
		ENDIF
	ENDSYNC
ENDIF