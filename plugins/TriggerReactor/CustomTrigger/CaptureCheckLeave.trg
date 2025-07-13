//Check Leaved
{?player.getName()+".CaptureProcess"} = null

//점령전 도중 나간 상태가 아닐때 무시
IF {$playername+".isCaptureLeaved"} != true
//스펙터 상태에서 게임월드에 있을 때
ELSEIF (player.getGameMode().toString() == "SPECTATOR" && player.getWorld().getName() == "CaptureGame")
	IF ({player.getName()+".isCaptureLeaved"} != true && {?"capturebattle.inGame"} == false) || ($isop == true && {?"CaptureDebug"} == true)
		import org.bukkit.Bukkit
		import org.bukkit.GameMode
		
		SYNC 
			player.setGameMode(Bukkit.getDefaultGameMode())
		ENDSYNC
		IF {"capturebattle.LobbyLoc"} !=null
			SYNC
				player.teleport({"capturebattle.LobbyLoc"})
			ENDSYNC
		ELSEIF plugin("EssentialsSpawn") !=null || plugin("CMI") != null
			#CMDOP "spawn "+$playername
		ENDIF
		
		{?player.getName()+".captureTeam"} = 0
		{$playername+".isCaptureLeaved"} = false
		#STOP
	ENDIF
//나간 상태가 맞을 시
ELSE
	//clear Inv
	player.getInventory().clear()
	
	//메세지 출력후 스폰으로 보낸다.
	player.sendMessage("§c§l│ §f§l점령전 §9§l│§f 게임 도중 중퇴하여 인벤토리를 리셋합니다.")
	IF {"capturebattle.LobbyLoc"} !=null
		SYNC
			player.teleport({"capturebattle.LobbyLoc"})
		ENDSYNC
	ELSEIF plugin("EssentialsSpawn") !=null || plugin("CMI") != null
		#CMDOP "spawn "+$playername
	ENDIF
	
	{?player.getName()+".captureTeam"} = 0
	{$playername+".isCaptureLeaved"} = false
	#STOP
ENDIF

//로비 대기도중에 나갔다 재접속시
IF  {?player.getName()+".inCgame"} == true && player.getWorld().getName() == "CaptureGame"
	{?player.getName()+".inCgame"} = false
	IF {"capturebattle.LobbyLoc"} !=null
		SYNC
			player.teleport({"capturebattle.LobbyLoc"})
		ENDSYNC
	ELSEIF plugin("EssentialsSpawn") !=null || plugin("CMI") != null
		#CMDOP "spawn "+$playername
	ENDIF
	
	{?player.getName()+".captureTeam"} = 0
ENDIF 