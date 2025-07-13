//-.-
IF player == null
	#STOP
ENDIF
IF event.getCause().toString() == "FALL" && player.getWorld().getName() ==  "CaptureGame"
	#CANCELEVENT
ENDIF