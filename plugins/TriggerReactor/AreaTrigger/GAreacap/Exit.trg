//G지역 퇴장
//게임 시작 했을 때만 발동시키세요.
IF {?"capturebattle.inGame"} == true
	IF  {?$playername+".captureTeam"} == 1 //팀이 블루일 때
		IF {?"capturebattle.TeamBlue.inGArea.Capturerer"} == $playername
			{?"capturebattle.TeamBlue.inGArea.Capturerer"} = "uncaptured"
		ENDIF
		
		//버그 체크
		IF {?"capturebattle.TeamRed.inGArea.Capturerer"} == $playername
			{?"capturebattle.TeamRed.inGArea.Capturerer"} = "uncaptured"
			{?"capturebattle.TeamRed.inGArea.Count"} = 0
		ENDIF
		
	ELSEIF  {?$playername+".captureTeam"} == 2 //팀이 레드일 때
		IF {?"capturebattle.TeamRed.inGArea.Capturerer"} == $playername
			{?"capturebattle.TeamRed.inGArea.Capturerer"} = "uncaptured"
		ENDIF
		//버그 체크
		IF {?"capturebattle.TeamBlue.inGArea.Capturerer"} == $playername
			{?"capturebattle.TeamBlue.inGArea.Capturerer"} = "uncaptured"
			{?"capturebattle.TeamBlue.inGArea.Count"} = 0
		ENDIF
		//
	ENDIF
ENDIF