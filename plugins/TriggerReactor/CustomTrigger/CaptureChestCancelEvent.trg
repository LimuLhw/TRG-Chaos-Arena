IF $worldname == "CaptureGame"
	IF event.getClickedBlock() == null
		#STOP
	ENDIF
	IF event.getClickedBlock().getType().toString() == "CHEST"
		#CANCELEVENT
	ENDIF
ENDIF