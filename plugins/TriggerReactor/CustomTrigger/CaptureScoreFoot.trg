//스코어 발판 이벤트
IMPORT org.bukkit.Material
IMPORT org.bukkit.Location
IF $worldname == "CaptureGame"
IF player.getLocation().getBlock().getType().toString() == "LIGHT_WEIGHTED_PRESSURE_PLATE"
	IF {?"capturebattle.inGame"} == true
		IF {?$playername+".isCaptureDied"} == true
			#STOP
		ENDIF
		IF ({?$playername+".captureTeam"} == 0 || {?$playername+".captureTeam"} == null) || {?$playername+".inCgame"} != true
			#STOP
		ENDIF
		#CALL "capturefoot"
		player.getLocation().getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
	ENDIF
ENDIF
ENDIF