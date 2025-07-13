//재접으로 아이템 먹고 바로 클리어 되는 꼼수를 막는다.
IF player == null
	#STOP
ELSEIF $isop == true
	#STOP
ELSEIF player.getWorld().getName() == "CaptureGame"
	IF {?player.getName()+".isCaptureDied"} == true
		#CANCELEVENT
	ENDIF
	IF ({?"capturebattle.inGame"} == false || {?"capturebattle.inGame"} == null)
		#CANCELEVENT
	ENDIF
	IF ({?player.getName()+".captureTeam"} == 0 || {?player.getName()+".captureTeam"} == null) || {?player.getName()+".inCgame"} != true
		#CANCELEVENT
	ENDIF
ENDIF