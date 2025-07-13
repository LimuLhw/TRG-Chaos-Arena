//Capture TeamKill issue
IF event.getEntity().getLocation().getWorld().getName() == "CaptureGame"
	IF event.isCancelled() == true
		#STOP
	ENDIF
	IF {?"capturebattle.inGame"} == true
		//보호 지역 버그 수정
		IF event.isCancelled() == true || event.getFinalDamage() <= 0
			#STOP
		ENDIF
	
		IF event.getDamager().getType().toString() == "ARROW" || event.getDamager().getType().toString() == "TRIDENT" || event.getDamager().getType().toString() == "SPLASH_POTION" || event.getDamager().getType().toString() == "POTION"
			Attacker = event.getDamager().getShooter().getName()
		ELSE
			Attacker = event.getDamager().getName()
		ENDIF 
		
		//"
		IF ({?Attacker+".captureTeam"} == 0  || {?$playername+".captureTeam"} == 0 )|| {?Attacker+".inCgame"} != true	//관전자 상호작용 방지
			#CANCELEVENT
			#STOP
		ELSEIF {?$playername+".captureTeam"} == 1 && {?Attacker+".captureTeam"} == 1		
			#CANCELEVENT
			#STOP
		ELSEIF {?$playername+".captureTeam"} == 2 && {?Attacker+".captureTeam"} == 2
			#CANCELEVENT
			#STOP
		ENDIF
		IF (currentArea(player(Attacker)) == "redprotect" || currentArea(player) == "redprotect") || (currentArea(player(Attacker)) == "blueprotect" || currentArea(player) == "blueprotect")
			#CANCELEVENT 
			#STOP
		ENDIF
		
	ELSEIF {?"capturebattle.inGame"} != true
		#CANCELEVENT
		#STOP
	ENDIF
	
	//#MESSAGE entity.getHealth()
	//#MESSAGE event.getFinalDamage()
	//#MESSAGE (entity.getHealth() <= event.getFinalDamage())
	IF (entity.getHealth() <= event.getFinalDamage())==true//OnDeath
	
		//사망 시 만약 에리어에 있었다면?
	//#log {?player.getName()+".captureTeam"}+" "+currentArea(player)+" "
		IF {?player.getName()+".captureTeam"} == 1
			IF {?"capturebattle.TeamBlue.inAArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamBlue.inAArea.Capturerer"} = "uncaptured";ENDIF
			IF {?"capturebattle.TeamBlue.inBArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamBlue.inBArea.Capturerer"} = "uncaptured";ENDIF
			IF {?"capturebattle.TeamBlue.inCArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamBlue.inCArea.Capturerer"} = "uncaptured";ENDIF
			IF {?"capturebattle.TeamBlue.inDArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamBlue.inDArea.Capturerer"} = "uncaptured";ENDIF
			IF {?"capturebattle.TeamBlue.inEArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamBlue.inEArea.Capturerer"} = "uncaptured";ENDIF
			IF {?"capturebattle.TeamBlue.inFArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamBlue.inFArea.Capturerer"} = "uncaptured";ENDIF
			IF {?"capturebattle.TeamBlue.inGArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamBlue.inGArea.Capturerer"} = "uncaptured";ENDIF
		ELSEIF {?player.getName()+".captureTeam"} == 2
			IF {?"capturebattle.TeamRed.inAArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamRed.inAArea.Capturerer"} = "uncaptured";ENDIF
			IF {?"capturebattle.TeamRed.inBArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamRed.inBArea.Capturerer"} = "uncaptured";ENDIF
			IF {?"capturebattle.TeamRed.inCArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamRed.inCArea.Capturerer"} = "uncaptured";ENDIF
			IF {?"capturebattle.TeamRed.inDArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamRed.inDArea.Capturerer"} = "uncaptured";ENDIF
			IF {?"capturebattle.TeamRed.inEArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamRed.inEArea.Capturerer"} = "uncaptured";ENDIF
			IF {?"capturebattle.TeamRed.inFArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamRed.inFArea.Capturerer"} = "uncaptured";ENDIF
			IF {?"capturebattle.TeamRed.inGArea.Capturerer"} == player.getName()
				{?"capturebattle.TeamRed.inGArea.Capturerer"} = "uncaptured";ENDIF
		ENDIF
		#CANCELEVENT
		#SETHEALTH 20
		#SETFOOD 20
		#CALL "CaptureDeath" false
		
		IF event.getDamager().getType().toString() != "PLAYER"
			IF {?event.getDamager().getShooter().getName()+".CaptureScore"} !=null		
			{?event.getDamager().getShooter().getName()+".CaptureScore"} += 5
			ENDIF
			IF {?event.getDamager().getShooter().getName()+".captureTeam"} == 1
				{?"capturebattle.TeamBlue.TotalScore"} += 5
			ELSEIF {?event.getDamager().getShooter().getName()+".captureTeam"} == 2
				{?"capturebattle.TeamRed.TotalScore"} += 5
			ENDIF
		ELSE
			{?event.getDamager().getName()+".CaptureScore"} = {?event.getDamager().getName()+".CaptureScore"} + 5
			IF {?event.getDamager().getName()+".captureTeam"} == 1
				{?"capturebattle.TeamBlue.TotalScore"} += 5
			ELSEIF {?event.getDamager().getName()+".captureTeam"} == 2
				{?"capturebattle.TeamRed.TotalScore"} += 5
			ENDIF
		ENDIF
		
	ELSE	//onDamage
		IF event.getDamager().getType().toString() != "PLAYER"
			IF {?event.getDamager().getShooter().getName()+".CaptureScore"} !=null	//자꾸 관전자가 들어가서 상호작용해서 오류남...
				{?event.getDamager().getShooter().getName()+".CaptureScore"} += 1
			ENDIF
			IF {?event.getDamager().getShooter().getName()+".captureTeam"} == 1
				{?"capturebattle.TeamBlue.TotalScore"} += 1
			ELSEIF {?event.getDamager().getShooter().getName()+".captureTeam"} == 2
				{?"capturebattle.TeamRed.TotalScore"} += 1
			ENDIF
		ELSE
			IF {?event.getDamager().getName()+".CaptureScore"} != null
			{?event.getDamager().getName()+".CaptureScore"} += 1
			ENDIF
			IF {?event.getDamager().getName()+".captureTeam"} == 1
				{?"capturebattle.TeamBlue.TotalScore"} += 1
			ELSEIF {?event.getDamager().getName()+".captureTeam"} == 2
				{?"capturebattle.TeamRed.TotalScore"} += 1
			ENDIF
		ENDIF
		
	ENDIF
ENDIF
//엔디티 로케이션 씬 주석 해제 상태로 사용 하지마세요..
//#MESSAGE "엔디티 로케이션: "+event.getEntity().getLocation().getWorld().getName()
//#MESSAGE "타겟 이름: "+event.getDamager().getName()
//#MESSAGE "타겟 팀 코드 : "+{?event.getDamager().getName()+".captureTeam"} 