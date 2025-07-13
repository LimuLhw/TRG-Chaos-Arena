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
