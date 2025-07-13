//F지역 퇴장
//게임 시작 했을 때만 발동시키세요.
IF {?"capturebattle.inGame"} == true
	IF  {?$playername+".captureTeam"} == 1 //팀이 블루일 때
		IF {?"capturebattle.TeamBlue.inFArea.Capturerer"} == $playername
			{?"capturebattle.TeamBlue.inFArea.Capturerer"} = "uncaptured"
		ENDIF
		
		//버그 체크
		IF {?"capturebattle.TeamRed.inFArea.Capturerer"} == $playername
			{?"capturebattle.TeamRed.inFArea.Capturerer"} = "uncaptured"
		ENDIF
		
	ELSEIF  {?$playername+".captureTeam"} == 2 //팀이 레드일 때
		IF {?"capturebattle.TeamRed.inFArea.Capturerer"} == $playername
			{?"capturebattle.TeamRed.inFArea.Capturerer"} = "uncaptured"
		ENDIF
		//버그 체크
		IF {?"capturebattle.TeamBlue.inFArea.Capturerer"} == $playername
			{?"capturebattle.TeamBlue.inFArea.Capturerer"} = "uncaptured"
		ENDIF
		//
	ENDIF
ENDIF