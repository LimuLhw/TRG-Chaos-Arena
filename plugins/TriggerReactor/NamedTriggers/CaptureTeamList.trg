//점령 종료시 아이템 리셋
redlist = list()
bluelist = list()
FOR p = getPlayers() 
	IF {?p.getName()+".captureTeam"} == 1 && p.getWorld().getName() ==  "CaptureGame"
		bluelist.add(p.getName())
	ELSEIF {?p.getName()+".captureTeam"} == 2 && p.getWorld().getName() ==  "CaptureGame"
		redlist.add(p.getName())
	ENDIF
ENDFOR



FOR p = getPlayers() 
	IF p.getWorld().getName() == "CaptureGame" //인게임에 있는 유저들만 메세지 출력
		IF redlist.isEmpty() == true
			p.sendMessage("레드 팀 리스트 : 아무도 참여 하지 않습니다!")
		ELSE
			p.sendMessage("레드 팀 리스트 ("+redlist.size()+" 명) : "+redlist)
		ENDIF
		IF bluelist.isEmpty() == true
			p.sendMessage("블루 팀 리스트 : 아무도 참여 하지 않습니다!")
		ELSE
			p.sendMessage("블루 팀 리스트 ("+bluelist.size()+" 명) : "+bluelist)
		ENDIF
	ENDIF
ENDFOR