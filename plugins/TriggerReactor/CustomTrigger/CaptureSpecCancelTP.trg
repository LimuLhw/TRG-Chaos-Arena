IF event.getCause().toString() == "SPECTATE" && {?"capturebattle.inGame"} == true && $isop == false
	IF event.getTo().getWorld().getName() != "CaptureGame"
		#MESSAGE "&c&l│ &f&l점령전 &9&l│&f 게임중인 유저 외에 유저에게로 텔레포트 할 수 없습니다."
		#CANCELEVENT
	ENDIF
ENDIF