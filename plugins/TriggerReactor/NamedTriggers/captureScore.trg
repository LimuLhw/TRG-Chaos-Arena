FOR p = getPlayers() //플레이어 리스트 불러오기
	IF p.getWorld().getName() == "CaptureGame" //인게임에 있는 유저들만 메세지 출력
		p.sendMessage("§9§l│ §f§l현재 기록 §9§l│ §9§l블루 §f§l팀 : "+{?"capturebattle.TeamBlue.TotalScore"} +" §e§lVS §f§l"+{?"capturebattle.TeamRed.TotalScore"}+" : §c§l레드 §f§l팀")
	ENDIF
ENDFOR