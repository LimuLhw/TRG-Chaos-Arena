//점령전 참여/퇴장시
prefixname = "§c§l│ §f§l점령전 §9§l│§f "
userList = list() //총 유저수
redlist = list() //레드팀 유저수
bluelist = list() //블루팀 유저수
FOR p = getPlayers() 
	IF ({?p.getName()+".captureTeam"} == 1 || {?p.getName()+".captureTeam"} == 2) && p.getWorld().getName() == "CaptureGame" && {?p.getName()+".inCgame"} == true
		userList.add(p.getName())
	ENDIF
	IF {?p.getName()+".captureTeam"} == 1 && p.getWorld().getName() ==  "CaptureGame" && {?p.getName()+".inCgame"} == true
		bluelist.add(p.getName())
	ELSEIF {?p.getName()+".captureTeam"} == 2 && p.getWorld().getName() ==  "CaptureGame" && {?p.getName()+".inCgame"} == true
		redlist.add(p.getName())
	ENDIF
ENDFOR
//onJoin
IF event.getFrom().getName() != "CaptureGame" && player.getWorld().getName() == "CaptureGame" && {?$playername+".inCgame"} == true
	FOR p = getPlayers()
		IF p.getWorld().getName() == "CaptureGame"
			IF p.getName() == $playername
				#MESSAGE "&a"+$playername+"&e님이 참여하였습니다. (&cR : "+redlist.size()+" &f: &9"+bluelist.size()+" : B&f, 총 "+userList.size()+"명&e)"
			ELSE
				p.sendMessage(color("&7"+$playername+"&e님이 참여하였습니다!  (&cR : "+redlist.size()+" &f: &9"+bluelist.size()+" : B&f, 총 "+userList.size()+"명&e)"))
			ENDIF
		ENDIF
	ENDFOR
//onLeave
ELSEIF event.getFrom().getName() == "CaptureGame" && player.getWorld().getName() != "CaptureGame" && {?$playername+".inCgame"} == false
	IF $gamemode != "SURVIVAL"
		#STOP
	ENDIF
	FOR p = getPlayers()
		IF p.getWorld().getName() == "CaptureGame"
			p.sendMessage(color("&7"+$playername+"&c님이 퇴장하였습니다!  (&cR : "+redlist.size()+" &f: &9"+bluelist.size()+" : B&f, 총 "+userList.size()+"명&c)"))
		ENDIF
	ENDFOR
	//방장 체크
	IF {?"CaptureHost"} == "dummy"
		users = list()
		FOR p = getPlayers()
			IF p.getWorld().getName() == "CaptureGame" && ({?p.getName()+".captureTeam"} == 1 || {?p.getName()+".captureTeam"} == 2) && {?p.getName()+".inCgame"} == true
				users.add(p.getName())
			ELSE
			ENDIF
		ENDFOR
		//예외 처리 = 유저가 0일때
		IF users.isEmpty() == true
			#STOP
		ENDIF
		/////
		{?"CaptureHost"} = users.get(random(users.size()))
		FOR p = getPlayers()
			IF p.getWorld().getName() == "CaptureGame" && {?p.getName()+".inCgame"} == true
				p.sendMessage(prefixname+"방장이 "+{?"CaptureHost"}+"으로 변경 되었어요.")
			ENDIF
		ENDFOR
	ENDIF
ENDIF