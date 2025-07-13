//E지역 나갔을 때
//게임 시작 했을 때만 발동시키세요.
IF {?"capturebattle.inGame"} == true
IF  {?$playername+".captureTeam"} == 1 //팀이 블루일 때
	IF {?"capturebattle.TeamBlue.inEArea.Capturerer"} == $playername
		{?"capturebattle.TeamBlue.inEArea.Capturerer"} = "uncaptured"
	ENDIF
	
	//버그 체크
	IF {?"capturebattle.TeamRed.inEArea.Capturerer"} == $playername
		{?"capturebattle.TeamRed.inEArea.Capturerer"} = "uncaptured"
	ENDIF
	
ELSEIF  {?$playername+".captureTeam"} == 2 //팀이 레드일 때
	IF {?"capturebattle.TeamRed.inEArea.Capturerer"} == $playername
		{?"capturebattle.TeamRed.inEArea.Capturerer"} = "uncaptured"
	ENDIF
	//버그 체크
	IF {?"capturebattle.TeamBlue.inEArea.Capturerer"} == $playername
		{?"capturebattle.TeamBlue.inEArea.Capturerer"} = "uncaptured"
	ENDIF
	//
ENDIF
ENDIF