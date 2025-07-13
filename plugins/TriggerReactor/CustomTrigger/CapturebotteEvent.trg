//IF...
IF player.getWorld().getName() == "CaptureGame" && {?"capturebattle.inGame"} == true
	IF player.getHealth()+8 > player.getMaxHealth()
		#SETHEALTH player.getMaxHealth()
	ELSE
		#SETHEALTH player.getHealth()+8
	ENDIF
	
	takeItem(player, $helditem, 0)
ENDIF