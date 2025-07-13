score = 10 //발판 점수
IF {?$playername+".captureTeam"} == 1
	{?"capturebattle.TeamBlue.TotalScore"} += score
ELSEIF {?$playername+".captureTeam"} == 2
	{?"capturebattle.TeamRed.TotalScore"} += score
ENDIF

tmcode ={?$playername+".captureTeam"}
{?$playername+".CaptureScore"} += score
IF tmcode == 1
	colorStr = "§9"
ELSEIF tmcode == 2
	colorStr = "§c"
ENDIF

FOR p = getPlayers() //플레이어 리스트 불러오기
	IF p.getWorld().getName() == "CaptureGame" //인게임에 있는 유저들만 메세지 출력
		p.sendMessage("§c§l│ §f§l! §c§l│ "+colorStr+"§l"+$playername+"§f§l이(가) §a§l스코어 발판§f§l를 밟았습니다! §f[ +"+score+" ]")
		IF tmcode == 1
			p.sendMessage("블루팀 현재 점수: "+{?"capturebattle.TeamBlue.TotalScore"})
		ELSEIF tmcode == 2
			p.sendMessage("레드팀 현재 점수: "+{?"capturebattle.TeamRed.TotalScore"})
		ENDIF
	ENDIF
ENDFOR
