//A지역 퇴장
//게임 시작 했을 때만 발동시키세요.
IF {?"capturebattle.inGame"} == true
	IF  {?$playername+".captureTeam"} == 1 //팀이 블루일 때
		IF {?"capturebattle.TeamBlue.inAArea.Capturerer"} == $playername
			{?"capturebattle.TeamBlue.inAArea.Capturerer"} = "uncaptured"
		ENDIF
		
		//버그 체크
		IF {?"capturebattle.TeamRed.inAArea.Capturerer"} == $playername
			{?"capturebattle.TeamRed.inAArea.Capturerer"} = "uncaptured"
			{?"capturebattle.TeamRed.inAArea.Count"} = 0
		ENDIF
		
	ELSEIF  {?$playername+".captureTeam"} == 2 //팀이 레드일 때
		IF {?"capturebattle.TeamRed.inAArea.Capturerer"} == $playername
			{?"capturebattle.TeamRed.inAArea.Capturerer"} = "uncaptured"
		ENDIF
		
		//버그 체크
		IF {?"capturebattle.TeamBlue.inAArea.Capturerer"} == $playername
			{?"capturebattle.TeamBlue.inAArea.Capturerer"} = "uncaptured"
			{?"capturebattle.TeamBlue.inAArea.Count"} = 0
		ENDIF
		//
	ENDIF
ENDIF 