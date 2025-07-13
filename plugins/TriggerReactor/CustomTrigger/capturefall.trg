// 맵 밑으로 떨어졌을 시 발동하는 시나리오
SYNC
IF player.getWorld().getName() == "CaptureGame"
	IF player.getWorld().getName() == "CaptureGame" && player.getLocation().getY() <= 49 && {?"capturebattle.inGame"} == true && ({?$playername+".isCaptureDied"} != true)
		IF {?$playername+".captureTeam"} == 1 || {?$playername+".captureTeam"} == 2
			#SETHEALTH 20
			#SETFOOD 20
			 {?$playername+".capturefall"}= true
			#TP -71,78,-136
			//#COOLDOWN 1
			IF {?$playername+".capturefall"} == true
				#CALL "CaptureDeath" false
			ENDIF
			
		ENDIF
	ELSEIF (player.getLocation().getY() <= 49 && {?"capturebattle.inGame"} !=true) || (player.getLocation().getY() <= 49 && {?"capturebattle.inGame"} == true && {?$playername+".isCaptureDied"} == true )
		IF {?$playername+".captureTeam"} == 1
			#TP -71.5,65,-139.5
		ELSEIF {?$playername+".captureTeam"} == 2
			#TP -71.5,65,-131
		ELSEIF ({?$playername+".captureTeam"} == 0 || {?$playername+".captureTeam"} == null)
			#TP -71.5,65,-139.5
		ENDIF
	ENDIF
ENDIF
ENDSYNC
//debug: #ACTIONBAR "Fall! it may get game overed Y: "+player.getLocation().getY()

ENDIF