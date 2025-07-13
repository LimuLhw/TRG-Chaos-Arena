p = player.getLocation()
//월드 이름이 점령전 월드 일때
IF p.getWorld().getName() == "CaptureGame"
	
	//게임 진행중일 경우
	IF {?"capturebattle.inGame"} == true && {?player.getName()+".inCgame"} == true
		//중퇴 변수 설정
		{player.getName()+".isCaptureLeaved"} = true
		{?player.getName()+".inCgame"} = false
		
		//패 추가
		IF {player.getName()+".CaptureLose"} == null
			{player.getName()+".CaptureLose"} = 0
		ENDIF
		{player.getName()+".CaptureLose"} = {player.getName()+".CaptureLose"} + 1
		
		{?player.getName()+".CaptureProcess"} = null
		IF {?player.getName()+".captureTeam"} == 1
			IF currentArea(player) == "AAreaCap" && {?"capturebattle.TeamBlue.inAArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamBlue.inAArea.Capturerer"} = "uncaptured"
			ELSEIF currentArea(player) == "BAreaCap" && {?"capturebattle.TeamBlue.inBArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamBlue.inBArea.Capturerer"} = "uncaptured"
			ELSEIF currentArea(player) == "CAreaCap" && {?"capturebattle.TeamBlue.inCArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamBlue.inCArea.Capturerer"} = "uncaptured"
			ELSEIF currentArea(player) == "DAreaCap" && {?"capturebattle.TeamBlue.inDArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamBlue.inDArea.Capturerer"} = "uncaptured"
			ELSEIF currentArea(player) == "EAreaCap" && {?"capturebattle.TeamBlue.inEArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamBlue.inEArea.Capturerer"} = "uncaptured"
			ELSEIF currentArea(player) == "FAreaCap" && {?"capturebattle.TeamBlue.inFArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamBlue.inFArea.Capturerer"} = "uncaptured"
			ELSEIF currentArea(player) == "GAreaCap" && {?"capturebattle.TeamBlue.inGArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamBlue.inGArea.Capturerer"} = "uncaptured"
			ENDIF
		ELSEIF {?player.getName()+".captureTeam"} == 2
			IF currentArea(player) == "AAreaCap" && {?"capturebattle.TeamRed.inAArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamRed.inAArea.Capturerer"} = "uncaptured"
			ELSEIF currentArea(player) == "BAreaCap" && {?"capturebattle.TeamRed.inBArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamRed.inBArea.Capturerer"} = "uncaptured"
			ELSEIF currentArea(player) == "CAreaCap" && {?"capturebattle.TeamRed.inCArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamRed.inCArea.Capturerer"} = "uncaptured"
			ELSEIF currentArea(player) == "DAreaCap" && {?"capturebattle.TeamRed.inDArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamRed.inDArea.Capturerer"} = "uncaptured"
			ELSEIF currentArea(player) == "EAreaCap" && {?"capturebattle.TeamRed.inEArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamRed.inEArea.Capturerer"} = "uncaptured"
			ELSEIF currentArea(player) == "FAreaCap" && {?"capturebattle.TeamRed.inFArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamRed.inFArea.Capturerer"} = "uncaptured"
			ELSEIF currentArea(player) == "GAreaCap" && {?"capturebattle.TeamRed.inGArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamRed.inGArea.Capturerer"} = "uncaptured"
			ENDIF
		ENDIF
		
		//게임 진행중인 플레이어에게 알림
		FOR p2 = getPlayers()
			IF p2.getWorld().getName() == "CaptureGame"
				p2.sendMessage("§c§l│ §f§l점령전 §9§l│§f "+player.getName()+"이 게임 도중 중퇴 했습니다.")
			ENDIF
		ENDFOR
		
	ENDIF
ENDIF