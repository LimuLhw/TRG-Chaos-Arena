//게임 진행중 맵 언로드시 발생하는 시나리오
//{?"capturehost"} 변수는 시작한 플레이어를 의미합니다.

IF event.getWorld().getName() == "CaptureGame" && {?"capturebattle.inGame"} == true
	#LOG "[ 점령전 ] §c아름다운 오류입니다."
	#LOG "[ 점령전 ] §c게임 진행중에 맵이 언로드 되었습니다! 게임을 중지합니다."
	IF player({?"capturehost"}) == null
	ELSE
		player({?"capturehost"}).sendMessage("§c아름다운 오류입니다.")
		player({?"capturehost"}).sendMessage("§c게임 진행중에 맵이 언로드 되었습니다! 게임을 중지합니다.")
	ENDIF
	
	{?"capturebattle.inGame"} = false
ENDIF