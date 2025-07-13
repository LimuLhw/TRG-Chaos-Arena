cmd = event.getMessage()

IF player.getWorld().getName() == "CaptureGame"
	//#MESSAGE cmd
	IF $isop == true
	ELSEIF cmd.startsWith("/tpa") == true || cmd.startsWith("/tpyes") == true || cmd.startsWith("/spawn") == true
		#CANCELEVENT
		#MESSAGE "&c&l│ &f&l점령전 &9&l│&f 게임중에는 해당 명령어 사용이 불가능합니다."
	ELSEIF (cmd.contains("/tell") == false || cmd.contains("/msg") == false || cmd.contains("/점령전") == false ) && {?"capturebattle.inGame"} == true
		#CANCELEVENT
		#MESSAGE "&c&l│ &f&l점령전 &9&l│&f 게임중에는 해당 명령어 사용이 불가능합니다."
	ELSE
	ENDIF
ENDIF