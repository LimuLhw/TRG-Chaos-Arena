IF {?"capturebattle.inGame"} == false || {?"capturebattle.inGame"} == null
	#STOP
ENDIF
IF $worldname == "CaptureGame"
	#TP -71,78,-136
	SYNC
		player.getInventory().clear()
		#SETGAMEMODE "SPECTATOR"
		{?player.getName()+".isCaptureDied"} = true
	ENDSYNC
	player.sendTitle("§c탈락했습니다!", "잠시후 리스폰 됩니다.", 0, 100, 10)
	{?player.getName()+".CaptureProcess"} = null
	

	IF {?player.getName()+".captureTeam"} == 1
		SYNC
		IF {?player.getName()+".capturefall"} == true 
			{?"capturebattle.TeamRed.TotalScore"} += 10
		ENDIF
		ENDSYNC
		
		FOR p = getPlayers() //플레이어 리스트 불러오기
			IF p.getWorld().getName() == "CaptureGame" //인게임에 있는 유저들만 메세지 출력
				p.sendMessage("§c§l│ §f§lX §c§l│ §9§l"+player.getName()+"§f§l이(가) §c§l아웃 되었습니다!")
				p.sendMessage("레드팀 현재 점수: "+{?"capturebattle.TeamRed.TotalScore"})
			ENDIF
		ENDFOR
		
	ELSEIF {?player.getName()+".captureTeam"} == 2
		SYNC
		//특정 서버의 경우, 데스 메세지가 다를 수 있음
		IF {?player.getName()+".capturefall"} == true
			{?"capturebattle.TeamBlue.TotalScore"} += 10
		ENDIF
		ENDSYNC

		FOR p = getPlayers() //플레이어 리스트 불러오기
			IF p.getWorld().getName() == "CaptureGame" //인게임에 있는 유저들만 메세지 출력
				p.sendMessage("§c§l│ §f§lX §c§l│ §c§l"+player.getName()+"§f§l이(가) §c§l아웃 되었습니다!")
				p.sendMessage("블루팀 현재 점수: "+{?"capturebattle.TeamBlue.TotalScore"})
			ENDIF
		ENDFOR
	ENDIF

	respawntime = 10
	WHILE respawntime > 0
		player.sendTitle("§c탈락했습니다!", "리스폰 까지 "+respawntime+" 초 남았습니다.", 0, 100, 10)
		#WAIT 1
		respawntime--;
		IF respawntime <= 0
		#BREAK	
		ENDIF
	ENDWHILE
	{?player.getName()+".isCaptureDied"} = false //관전 모드 해제 **아래에 하면 커스텀이벤트에 의해 캔슬됨**
	#SETGAMEMODE "SURVIVAL" //ChangeGameMode
	IF {?player.getName()+".captureTeam"} == 1
		
		IF {?"capturebattle.inGame"} == false // 게임 종료하면 리스폰만.
			SYNC
				player.teleport(location("CaptureGame",-71.5, 65, -139.5))
			ENDSYNC
		ELSE
			SYNC
				player.teleport(location("CaptureGame",-71.5, 65, -177.5, -0.9, 20.5)); //BlueBase
				player.getInventory().setItem(39,{"captureitems.TeamBlueH"})
				player.getInventory().setItem(37,{"captureitems.TeamBlueArm1"}) 
				player.getInventory().setItem(36,{"captureitems.TeamBlueArm2"})
				player.getInventory().setItem(0,{"captureitems.defaultsword"})				
			ENDSYNC
		ENDIF
	ELSEIF {?player.getName()+".captureTeam"} == 2
		IF {?"capturebattle.inGame"} == false
			SYNC
				player.teleport(location("CaptureGame", -71.5, 65, -131))
			ENDSYNC
		ELSE
		SYNC
			player.teleport(location("CaptureGame", -71.5, 65, -93.5, -178.5, 14.7)); //RedBase
			player.getInventory().setItem(39,{"captureitems.TeamRedH"})
			player.getInventory().setItem(37,{"captureitems.TeamRedArm1"}) 
			player.getInventory().setItem(36,{"captureitems.TeamRedArm2"})
			player.getInventory().setItem(0,{"captureitems.defaultsword"})
		ENDSYNC
		ENDIF
	ENDIF
	player.sendTitle("§a리스폰!", null, 0, 100, 10)	
	#WAIT 0.3
	
ENDIF
{?player.getName()+".capturefall"} = false