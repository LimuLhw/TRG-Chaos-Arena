// 소스 참고: Ioloolo

import java.util.ArrayList

IF (event.getBuffer() == null)
    #STOP
ENDIF

//IF (!event.getSender().isOp())
//    #STOP
//ENDIF

rawText    = event.getBuffer().split(" ")
completion = ArrayList()
IF rawText[0].equalsIgnoreCase("/점령전")
IF (rawText.length == 1 && rawText[0].equalsIgnoreCase("/점령전"))
    completion.add("시작")
	completion.add("팀목록")
	completion.add("참여")
	completion.add("퇴장")
	completion.add("관전")
	IF event.getSender().isOp()
		completion.add("중지")
		completion.add("팀설정")
		completion.add("초기화")
		completion.add("목표점수")
		completion.add("시간설정")
		completion.add("활성화")
		completion.add("로비설정")
	ENDIF
ENDIF

IF (rawText.length >= 2 && rawText[0].equalsIgnoreCase("/점령전") && rawText[1].equalsIgnoreCase("팀설정"))
    IF (rawText.length == 2)
		FOR p=getPlayers()
			completion.add(p.getName())
		ENDFOR
	ELSEIF (rawText.length == 3)
		completion.add("0")
		completion.add("1")
		completion.add("2")
	ENDIF
ENDIF
IF (rawText.length >= 2 && rawText[0].equalsIgnoreCase("/점령전") && rawText[1].equalsIgnoreCase("목표점수"))
    IF (rawText.length == 2)
		completion.add("기본값")
	ENDIF
ENDIF
IF (rawText.length >= 2 && rawText[0].equalsIgnoreCase("/점령전") && rawText[1].equalsIgnoreCase("시간설정"))
    IF (rawText.length == 2)
		completion.add("10")
	ELSEIF (rawText.length == 3)
		completion.add("0")
	ENDIF
ENDIF
IF (rawText.length >= 2 && rawText[0].equalsIgnoreCase("/점령전") && rawText[1].equalsIgnoreCase("로비설정"))
    IF (rawText.length == 2)
		completion.add("설정")
		completion.add("해제")
		completion.add("이동")
	ENDIF
ENDIF
event.setCompletions(completion)
ENDIF