IF event.getClickedBlock() == null || player == null
	#STOP
ENDIF
IF player.getWorld().getName() == "CaptureGame"
	IMPORT org.bukkit.Bukkit
	IMPORT org.bukkit.Material
	IMPORT org.bukkit.Location

	IF {?player.getName()+".isCaptureDied"} == true
		#STOP
	ENDIF
	IF {?"capturebattle.inGame"} == false || {?"capturebattle.inGame"} == null
		#STOP
	ENDIF
	IF {?player.getName()+".captureTeam"} == 0 || {?player.getName()+".captureTeam"} == null
		#STOP
	ENDIF
	block = event.getClickedBlock().getLocation().getBlock()
	getB = block.getType().toString()
	
	IF getB == "CHEST"
	//Chest 
	
	IF (currentAreaAt(event.getClickedBlock().getLocation()) == "redprotect" && {?player.getName()+".captureTeam"} == 2) || (currentAreaAt(event.getClickedBlock().getLocation()) == "blueprotect" && {?player.getName()+".captureTeam"} == 1) || currentAreaAt(event.getClickedBlock().getLocation()) == null
		SYNC
			block.setType(Material.AIR)
			#CALL "CaptureItems"
		ENDSYNC
		#WAIT 20

		//월드 로드, 좌표 관련, 블럭 관련 라이브러리 로드
		
		SYNC
		block.setType(Material.CHEST)
		ENDSYNC
		ENDIF
		#STOP
	ENDIF
ENDIF