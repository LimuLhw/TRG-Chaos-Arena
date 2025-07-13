prefixname = "§c§l│ §f§l점령전 §9§l│§f "
erralart = "&c아름다운 오류입니다."

IF $emptyslots >= 41
	ELSE
		//#SOUND player.getLocation(), "block.note.harp", 1.0, 1.0 // Disabled since 1.19 Problem
		#MESSAGE "&c게임을 참여 하려면, 인벤토리를 비우고 참여해주세요."
		#STOP
	ENDIF
	
	IF {?"capturebattle.inGame"} != true && {?"capturewait"} != true
		IF {?"CaptureHost"} == null ||player({?"CaptureHost"}) == null
			{?"CaptureHost"} = player.getName()
		ENDIF
		IF {?"CaptureHost"} == "dummy" || player({?"CaptureHost"}).getWorld().getName() != "CaptureGame"
			{?"CaptureHost"} = player.getName()
		ENDIF
		//게임 로비에 접속 안되있을때
		IF {?player.getName()+".inCgame"} !=true
			{?player.getName()+".inCgame"} = true
		ELSE
			#MESSAGE erralart
			#MESSAGE "&c이미 게임 로비에 있습니다. 퇴장 하려면 /점령전 퇴장을 입력해주세요!"
			#STOP
		ENDIF
		//////////////////////////////
		redlist = list()
		bluelist = list()
		FOR p = getPlayers() 
			IF {?p.getName()+".captureTeam"} == 1 && p.getWorld().getName() ==  "CaptureGame"
				bluelist.add(p.getName())
			ELSEIF {?p.getName()+".captureTeam"} == 2 && p.getWorld().getName() ==  "CaptureGame"
				redlist.add(p.getName())
			ENDIF
		ENDFOR
		
		//랜덤 설정. :(
		SYNC
			IF redlist.isEmpty() == true && bluelist.isEmpty() == true || redlist.size() == bluelist.size()
				random = random(1, 3)
				IF random == 1
					bluelist.add(player.getName())
					{?player.getName()+".captureTeam"} = 1
					player.teleport(location("CaptureGame", -71.5,65,-139.5))
				ELSEIF random == 2
					redlist.add(player.getName())
					{?player.getName()+".captureTeam"} = 2
					player.teleport(location("CaptureGame", -71.5,65,-131))
				ENDIF
			ELSEIF redlist.size() > bluelist.size()
				bluelist.add(player.getName())
				{?player.getName()+".captureTeam"} = 1
				player.teleport(location("CaptureGame", -71.5,65,-139.5))
			ELSEIF bluelist.size() > redlist.size()
				redlist.add(player.getName())
				{?player.getName()+".captureTeam"} = 2
				player.teleport(location("CaptureGame", -71.5,65,-131))
			ENDIF
		ENDSYNC
		listcount = 10 //리스트를 보여줄 카운트
		
		//방장 체크
		IF {?"CaptureHost"} == player.getName()
			#MESSAGE prefixname+"당신은 방장입니다. 인원 모두 준비가 완료되면 /점령전 시작을 쳐주세요!"
		ELSE
			#MESSAGE prefixname+"상대 접속을 대기하고 있습니다. 현재 방장은 "+{?"CaptureHost"}+" 입니다."
		ENDIF
		#MESSAGE "점령전에서 나갈려면, /점령전 퇴장"
		
		//게임 대기
		WHILE {?"capturebattle.inGame"} == false
			// 게임 대기/게임에 들어간 경우
			IF {?player.getName()+".inCgame"} == true
				FOR p = getPlayers() 
					IF {?p.getName()+".captureTeam"} == 1 && p.getWorld().getName() ==  "CaptureGame" && bluelist.contains(p.getName()) == false
						bluelist.add(p.getName())
					ELSEIF {?p.getName()+".captureTeam"} == 2 && p.getWorld().getName() ==  "CaptureGame" && redlist.contains(p.getName()) == false
						redlist.add(p.getName())
					ELSEIF {?p.getName()+".captureTeam"} == 0 || {?p.getName()+".captureTeam"} == null && {?player.getName()+".inCgame"} == false || {?player.getName()+".inCgame"} == null
						bluelist.remove(p.getName())
						redlist.remove(p.getName())
						
					ENDIF
					//목록에 있는 팀과 다를경우
					IF redlist.contains(p.getName()) && {?p.getName()+".captureTeam"} != 2
						redlist.remove(p.getName())
					ELSEIF bluelist.contains(p.getName()) && {?p.getName()+".captureTeam"} != 1
						bluelist.remove(p.getName())
					ENDIF
					
					
				ENDFOR
				#WAIT 1
				//방장 체크
				IF {?"CaptureHost"} == "dummy"
					users = list()
					FOR p = getPlayers()
						IF p.getWorld().getName() == "CaptureGame" && ({?p.getName()+".captureTeam"} == 1 && {?p.getName()+".captureTeam"} == 2)
							users.add(p.getName())
						ENDIF
					ENDFOR
					//예외 처리 = 유저가 0일때
					IF users.isEmpty() == true
						#STOP
					ENDIF
					/////
					{?"CaptureHost"} = users.get(random(users.size()))
					FOR p = getPlayers()
						IF p.getWorld().getName() == "CaptureGame"
							p.sendMessage(prefixname+"방장이 "+{?"CaptureHost"}+"으로 변경 되었어요.")
						ENDIF
					ENDFOR
				ENDIF
				
				listcount -= 1
				IF listcount <= 0
					FOR r = redlist
						IF r.isEmpty() == true
							#BREAK
						ENDIF
						IF redlist.contains(r) && oplayer(r).isOnline() == false
							redlist.remove(r)
							#BREAK
						ENDIF
					ENDFOR
					FOR b = bluelist
						IF b.isEmpty() == true
							#BREAK
						ENDIF
						IF bluelist.contains(b) && oplayer(b).isOnline() == false
							bluelist.remove(b)
							#BREAK
						ENDIF
					ENDFOR
					IF redlist.isEmpty() == true
						#MESSAGE "레드 팀 리스트 : 아무도 참여 하지 않습니다!"
					ELSE
						#MESSAGE "레드 팀 리스트 ("+redlist.size()+" 명) : "+redlist
					ENDIF
					IF bluelist.isEmpty() == true
						#MESSAGE "블루 팀 리스트 : 아무도 참여 하지 않습니다!"
					ELSE
						#MESSAGE "블루 팀 리스트 ("+bluelist.size()+" 명) : "+bluelist
					ENDIF
					listcount = 10
				ENDIF
			ELSE
				#BREAK
			ENDIF
		ENDWHILE
	ELSE
		#MESSAGE erralart
		#MESSAGE "&c이미 게임이 시작되었습니다."
		#STOP
	ENDIF
	#STOP