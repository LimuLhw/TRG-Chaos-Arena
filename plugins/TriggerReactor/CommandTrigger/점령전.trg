//테일즈런너 점령전 트리거 리액터 프로젝트.
//원본: 테일즈런너 카오스 점령전
//By. Limu_lhw 이리무

//게임 버전. 개발자 외 수정 금지.
ver = "9.6"

//prefix name. (onCommand)
prefixname = "§c§l│ §f§l점령전 §9§l│§f "
//Error Alert
erralert = "§c아름다운 오류입니다."
//some User seen Error message
errgameerr = "§c미니게임 준비 도중에 문제가 있었습니다. 관리자에게 문의 하여주세요."

//월드 로드, 좌표 관련, 블럭 관련 라이브러리 로드
IMPORT org.bukkit.Bukkit
IMPORT org.bukkit.Material
IMPORT org.bukkit.Location

SYNC
//TRG Version Check
trg = plugin("TriggerReactor")
trgver = trg.getDescription().getVersion().toString()
//IF debug mode has disabled.. TRG Ver bypass.
IF {?"CaptureDebug"} != true
	IF trgver.contains("3.4") || trgver.contains("3.5")==true || trgver.contains("pr")==true
	ELSEIF (args.length == 0 || args[0] != "실험용")
		#MESSAGE erralert
		IF $haspermission : "Capturegame.Admin"
		#MESSAGE "&c해당 트리거 버전에서는 지원하지 않는 컨텐츠입니다."
		#MESSAGE "&c관리자 또는 개발자(디스코드 @limulhw)에게 문의 바랍니다." 
		#MESSAGE "&6점령전 버전: "+ver+", 현재 트리거 버전: "+trgver
		#MESSAGE "&c&l그래도 사용 하려면, 디버그 모드를 활성화 시키세요. (/점령전 실험용 명령어 참조)"
		ELSE
			#MESSAGE errgameerr
		ENDIF
		#STOP
	ENDIF
ENDIF

IF Bukkit.getWorld("CaptureGame") == null
	#MESSAGE erralert
	IF $haspermission : "Capturegame.Admin"
		#MESSAGE "&c점령전 게임에 필요한 맵을 올바르게 로드 되있는 지 확인하고 다시 시도해주세요."
		#MESSAGE "&cMultiWorld 또는 Multiverse 같은 멀티 월드 플러그인으로 로드를 할 수 있습니다."
	ELSE
		#MESSAGE errgameerr
	ENDIF
	#STOP
ENDIF

//만약 초기화가 안된 초기 설치일때
IF {?"capturebattle.inGame"} == null
	#CALL "CaptureVarReset"
ENDIF
/////////

//명령어 사용시 플레이어 전적 신식으로 자동 변환
IF {$playername+".CaptureWin"} != null && $isnumber:{$playername+".CaptureWin"}  == true
	{"CaptureStatistics."+$playername+".CWin"} = {$playername+".CaptureWin"}
	{$playername+".CaptureWin"} = null
ENDIF
IF {$playername+".CaptureLose"} != null && $isnumber:{$playername+".CaptureLose"}  == true
	{"CaptureStatistics."+$playername+".CLose"} = {$playername+".CaptureLose"}
	{$playername+".CaptureLose"} = null
ENDIF
/////////////////////
ENDSYNC
IF args.length == 0 || args[0] == null
	SYNC
	//////
	#MESSAGE "&c&l테일즈&a&l런너 &f&l점령전 Rev. "+ver+" &f&lBy. 이리무"
	IF $haspermission : "Capturegame.Admin"
		#MESSAGE "/점령전 시작 : 게임을 시작합니다." 													//점령시작
		#MESSAGE "/점령전 중지 : 게임을 중지합니다." 													//점령중지
		#MESSAGE "/점령전 팀설정 : 플레이어 팀을 설정합니다." 										//유저팀설정
		#MESSAGE "/점령전 팀목록 : 팀 목록을 표시 합니다." 											//참가자목록
		#MESSAGE "/점령전 초기화 : 변수 리셋. (게임 종료시에만 가능)"							//변수리셋
		#MESSAGE "/점령전 목표점수 : 목표 점수를 설정합니다. (게임 종료시에만 가능)"	//목표스코어
		#MESSAGE "/점령전 시간설정 : 게임 제한 시간을 설정합니다. "								//타이머
		#MESSAGE "/점령전 활성화 : 게임을 활성화/비활성화 시킵니다."								//활성화
		#MESSAGE "/점령전 로비설정 : 게임 종료/퇴장시 이동할 장소를 지정합니다."			//로비설정
	ENDIF
	#MESSAGE "/점령전 참여 : 점령전에 참여를 합니다!" 											//점령참여
	#MESSAGE "/점령전 퇴장 : 점령전에서 나갑니다." 													//점령퇴장
	#MESSAGE "/점령전 관전 : 게임 관전을 진행합니다."												//점령관전
	#MESSAGE "&a&l━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	IF {?"capturebattle.inGame"} == true
		//게임이 디버그 또는 테스트 모드인지 체크를 합니다.
		IF {?"CaptureDebug"} == null || {?"CaptureDebug"} == false
			#MESSAGE "&a&l게임 상태&f&l: &a&l진행중"
		ELSE
		 	#MESSAGE "&a&l게임 상태&f&l: &a&l진행중 &f&l(&e&l테스트 모드&f&l)"
		ENDIF
		
		IF {?"capturebattle.TimeSecleft"} <= 9
			#MESSAGE "&a&l남은 시간 &f&l: "+{?"capturebattle.TimeMinleft"}+" : 0"+{?"capturebattle.TimeSecleft"}
		ELSE
			#MESSAGE "&a&l남은 시간 &f&l: "+{?"capturebattle.TimeMinleft"}+" : "+{?"capturebattle.TimeSecleft"}
		ENDIF
		
		#MESSAGE "&a&l점수 &f&l: &9&l블루 &f&l팀 : "+{?"capturebattle.TeamBlue.TotalScore"} +" &e&lVS &f&l"+{?"capturebattle.TeamRed.TotalScore"}+" : &c&l레드 &f&l팀"
	ELSE
		#MESSAGE "&a&l게임 상태&f&l: &c&l종료됨"
	ENDIF
	
	IF {"CaptureStatistics."+$playername+".CWin"} == null
		{"CaptureStatistics."+$playername+".CWin"} = 0
	ENDIF
	IF {"CaptureStatistics."+$playername+".CLose"} == null
		{"CaptureStatistics."+$playername+".CLose"} = 0
	ENDIF
	
	#MESSAGE "&a&l내 전적&f&l: &r"+{"CaptureStatistics."+$playername+".CWin"} +"&9&l승&r, "+{"CaptureStatistics."+$playername+".CLose"} +"&c&l패"
	import java.lang.String;
	//Convert to Double
	b = 0.0+{"CaptureStatistics."+$playername+".CWin"};
	IF {"CaptureStatistics."+$playername+".CWin"} <= 0 && {"CaptureStatistics."+$playername+".CLose"} <= 0 //안하면 Not a Number (NaN)로 표시됨.
		#MESSAGE "&a&l승률 &f&l: &r아직 한번도 플레이 하지 않았습니다!"
	ELSE
		//승률 (승리횟수(b)/(총 승리+패배 횟수))*100
		#MESSAGE "&a&l승률 &f&l: &r"+String.format("%.2f", (b/({"CaptureStatistics."+$playername+".CWin"}+{"CaptureStatistics."+$playername+".CLose"}))*100)+"%"
	ENDIF

	IF {?$playername+".captureTeam"} == 1
		#MESSAGE "&a&l현재 진영&f&l: &9&l블루 &f&l팀"
	ELSEIF {?$playername+".captureTeam"} == 2
		#MESSAGE "&a&l현재 진영&f&l: &c&l레드 &f&l팀"
	ELSE
		#MESSAGE "&a&l현재 진영&f&l: &7&l참여 안함"
	ENDIF 
	#MESSAGE "&a&l━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	#STOP
	/////
	ENDSYNC
ENDIF
/////////////////////////////
//점령전 참여
//키워드: 점령참여
/////////////////////////////
IF args[0] == "참가" || args[0] == "참여" || args[0] == "입장" || args[0] == "join"
	IF {"CaptureStatistics."+$playername+".CWin"} == null
		{"CaptureStatistics."+$playername+".CWin"} = 0
	ENDIF
	IF {"CaptureStatistics."+$playername+".CLose"} == null
		{"CaptureStatistics."+$playername+".CLose"} = 0
	ENDIF
	IF {?"capturebattle.enable"} == true || $haspermission:"Capturegame.bypass"
		//로비 지정 관련 이슈
		IF {"capturebattle.LobbyLoc"} ==null && (plugin("EssentialsSpawn") !=null || plugin("CMI") != null) == false && {?"CaptureDebug"} != true
			#MESSAGE erralert
			IF $haspermission : "Capturegame.Admin" == false
				#MESSAGE "&c로비가 지정되어 있지 않습니다. 관리자에게 문의 바랍니다."
			ELSE
				#MESSAGE "&c로비가 지정되어 있지 않습니다. /점령전 로비설정 명령어로 로비 지정한 후 재시도 바랍니다."
			ENDIF 
			#STOP
		ENDIF
		#CALL "CaptureLobby" false
		#STOP
	ELSE
		#MESSAGE erralert
		#MESSAGE "&c게임이 비활성화되어 있습니다. 관리자에게 문의 바랍니다."
		#STOP
	ENDIF
ENDIF


/////////////////////////////
// 퇴장
// 키워드: 점령퇴장
/////////////////////////////
IF args[0] == "퇴장" || args[0] == "quit"
	IF $worldname == "CaptureGame"
		IF {?"capturebattle.inGame"} != true
			IF {?"CaptureHost"} == $playername
				{?"CaptureHost"} = "dummy"
			ENDIF
			{?$playername+".inCgame"} = false
			{?$playername+".captureTeam"} = 0
			//Essentials나 CMI등으로 spawn 못보낼때 시나리오 작성 필요
			IF {"capturebattle.LobbyLoc"} !=null
				SYNC
					player.teleport({"capturebattle.LobbyLoc"})
				ENDSYNC
			ELSEIF plugin("EssentialsSpawn") !=null || plugin("CMI") != null
				#CMDCON "spawn "+$playername
			ENDIF
			IF $isop ==false
			SYNC
				player.setGameMode(Bukkit.getDefaultGameMode())
			ENDSYNC
			ENDIF
		ELSE
			IF {?$playername+".inCgame"} == true
				#MESSAGE erralert
				#MESSAGE "&c게임 진행 중에는 퇴장이 불가능합니다."
			ELSE
				import org.bukkit.scoreboard.DisplaySlot
				
				player.getScoreboard().clearSlot(DisplaySlot.SIDEBAR)
				IF {"capturebattle.LobbyLoc"} !=null
				SYNC
					player.teleport({"capturebattle.LobbyLoc"})
				ENDSYNC
				ELSEIF plugin("EssentialsSpawn") !=null || plugin("CMI") != null
					#CMDCON "spawn "+$playername
				ENDIF
				IF $isop ==false
				SYNC
					player.setGameMode(Bukkit.getDefaultGameMode())
				ENDSYNC
				ENDIF
			ENDIF
		ENDIF
	ELSE
		#MESSAGE erralert
		#MESSAGE "&c게임 대기실에서만 사용이 가능합니다."
		IF {?$playername+".inCgame"} == true && player.getWorld().getName().toString() != "CaptureGame"
			SYNC
			random = random(1, 3)
			IF random == 1
				{?player.getName()+".captureTeam"} = 1
				player.teleport(location("CaptureGame", -71.5,65,-139.5))
			ELSEIF random == 2
				{?player.getName()+".captureTeam"} = 2
				player.teleport(location("CaptureGame", -71.5,65,-131))
			ENDIF
			ENDSYNC
		ENDIF
	ENDIF
#STOP
ENDIF

/////////////////////////////
//게임 시작 시나리오
//키워드: 점령시작
/////////////////////////////
IF args[0] == "시작" || args[0]== "start"
	//펄미션 체크.혹은 방장이 아닐때만
	IF $haspermission : "Capturegame.Admin" == true || {?"CaptureHost"} == $playername
	ELSE
		#MESSAGE erralert
		#MESSAGE "&c방장 또는 관리자만 시작 가능합니다!"
		#STOP
	ENDIF
	//게임 월드 아닐때
	IF player.getWorld().getName() != "CaptureGame"
		#MESSAGE prefixname+"점령전 월드에서 시도해주세요."
		#STOP
	ENDIF
	//분/초가 설정 안되어있을때
	IF {?"capturebattle.TimeMin"} == null || {?"capturebattle.TimeSec"} == null
		#MESSAGE prefixname+"타이머 (분, 초)중 하나 이상이 설정이 되지 않아 기본 시간으로 설정합니다."
		{?"capturebattle.TimeMin"} = 10
		{?"capturebattle.TimeSec"} = 0
	ENDIF
	//타이머 이슈
	IF {?"capturebattle.TimeMin"} <= -1 || {?"capturebattle.TimeSec"} <= -1
		#MESSAGE erralert
		#MESSAGE "&c타이머에 문제가 있는 것 같습니다. 타이머 설정을 다시 설정해주세요."
		#STOP
	ENDIF
	//카운팅 씬
	IF {?"CaptureDebug"} != true
		IF {?"capturebattle.lobbyCounting"} != true
			{?"capturebattle.lobbyCounting"} = true
		ELSE
			#MESSAGE erralert
			#MESSAGE "&c게임 시작 카운트 진행 중입니다. 잠시만 기다려주세요."
			#STOP
		ENDIF
		//Ready Scene
		timer = 5	//레디 카운트
		redlist = list()
		bluelist = list()
		FOR p = getPlayers() 
			IF {?p.getName()+".captureTeam"} == 1 && p.getWorld().getName() ==  "CaptureGame"
			bluelist.add(p.getName())
			ELSEIF {?p.getName()+".captureTeam"} == 2 && p.getWorld().getName() ==  "CaptureGame"
			redlist.add(p.getName())
			ENDIF
		ENDFOR
		IF redlist.size() >= 1 && bluelist.size() >= 1
			WHILE timer > 0
			FOR p = getPlayers()
				IF p.getWorld().getName() ==  "CaptureGame"
					p.sendTitle("게임이 시작됩니다", "시작 까지 "+timer+" 초", 5, 20, 0);
				ENDIF
			ENDFOR
			#WAIT 1
			///check Team Status
			redlist = list()
			bluelist = list()
			FOR p = getPlayers() 
				IF {?p.getName()+".captureTeam"} == 1 && p.getWorld().getName() ==  "CaptureGame"
				bluelist.add(p.getName())
				ELSEIF {?p.getName()+".captureTeam"} == 2 && p.getWorld().getName() ==  "CaptureGame"
				redlist.add(p.getName())
				ENDIF
			ENDFOR
			IF redlist.size() >= 1 && bluelist.size() >= 1
			ELSE
				FOR p=getPlayers()
					IF p.getWorld().getName() == "CaptureGame"
						p.sendMessage(erralert)
						p.sendMessage(color("&c팀 인원이 부족합니다. 최소 1명 이상이여야 합니다!"))
					ENDIF
				ENDFOR
				{?"capturebattle.lobbyCounting"} = false
				#STOP
			ENDIF
			///
			timer--
			ENDWHILE
		ELSE
			#MESSAGE erralert
			#MESSAGE "&c팀 인원이 부족합니다. 최소 1명 이상이여야 합니다!"
			{?"capturebattle.lobbyCounting"} = false
			#STOP
		ENDIF
		////
	ENDIF
	#CALL "CaptureGame" false
	{?"capturebattle.lobbyCounting"} = false
	#STOP
ENDIF

/////////////////////////////
//게임 종료 시나리오
//키워드: 점령중지
/////////////////////////////
IF args[0] == "중지" || args[0] == "중단" || args[0] == "stop"
	//펄미션 체크 :(
	IF $haspermission : "Capturegame.Admin" == false
		#MESSAGE "&c액세스 레벨 부족"
		#STOP
	ENDIF
	//
	IF {?"capturebattle.inGame"} == true
		{?"capturebattle.inGame"} = false
		FOR p=getPlayers()
			p.sendMessage(color("&c&l│ &f&l게임 종료! &c&l│ &f&l점령전 경기가 관리자 "+$playername+" 에 의해 중지되었습니다."))
		ENDFOR
		#STOP

	ELSE
		#MESSAGE prefixname+"게임이 이미 중지되어 있습니다."
		#STOP
	ENDIF
ENDIF

/////////////////////////////
//변수 초기화 시나리오
//키워드: 변수리셋
/////////////////////////////
IF args[0] == "초기화"
	//펄미션 체크 :(
	IF $haspermission : "Capturegame.Admin" == false
		#MESSAGE "&c액세스 레벨 부족"
		#STOP
	ENDIF
	//
	IF $worldname != "CaptureGame"
		#MESSAGE prefixname+"블럭 및 변수 조정을 위해 점령전 월드에서 시도해주세요."
		#STOP
	ENDIF
	IF {?"capturebattle.inGame"} == false || {?"capturebattle.inGame"} == null
		#CALL "CaptureVarReset"
		#STOP
	ELSE
		#MESSAGE prefixname+"게임을 중지한 상태에서 진행해주세요."
		#STOP
	ENDIF
ENDIF

/////////////////////////////
//플레이어 팀 설정 시나리오
//키워드: 유저팀설정
/////////////////////////////
IF args[0] == "팀설정" && args.length == 1 && $haspermission : "Capturegame.Admin"
	#MESSAGE prefixname+" 팀을 확인하거나 설정합니다."
	#MESSAGE "/점령전 팀설정 닉네임 팀코드"
	#STOP
ENDIF
IF args[0] == "팀설정" && args[1] != null && args.length == 2 && $haspermission : "Capturegame.Admin"
	IF {?args[0]+".captureTeam"} == null || {?args[1]+".captureTeam"} == 0
		#MESSAGE prefixname+args[1]+"의 팀은 미참여입니다."
	ELSEIF {?args[0]+".captureTeam"} == 1
		#MESSAGE prefixname+args[1]+"의 팀은 블루입니다."
	ELSEIF {?args[0]+".captureTeam"} == 2
		#MESSAGE prefixname+args[1]+"의 팀은 레드입니다."
	ELSE
		#MESSAGE prefixname+args[1]+"의 팀은 &c변수 오류!&r입니다. 팀 코드: "+{?args[1]+".captureTeam"}
	ENDIF
	#MESSAGE "0: 미참여, 1: 블루, 2: 레드"
	#STOP
ENDIF
IF args[0] == "팀설정" && args[1] != null && args[2] == "0" && $haspermission : "Capturegame.Admin"
	IF player(args[1]) == null
		#MESSAGE prefixname+"&e"+args[1]+"&f은(는) &c오프라인 &f입니다!"
		#STOP
	ENDIF
	
	//게임 진행시 변경되어 플레이어의 플레이를 영향주지 않게합니다.
	IF {?"capturebattle.inGame"} == true && {?"CaptureDebug"} != true
		#MESSAGE erralert
		#MESSAGE "&c현재 게임이 진행중입니다! 게임이 끝나면 팀 설정이 가능합니다."
		#STOP
	ENDIF
	
	{?args[1]+".captureTeam"} = 0
	#MESSAGE prefixname+args[1]+"의 팀은 미참여입니다."
	player(args[1]).sendMessage("§c§l│ §f§l점령전 §9§l│ §f§l당신의 팀이 미참여로 설정되었습니다!")
	#STOP
ENDIF
IF args[0] == "팀설정" && args[1] != null && args[2] == "1" && $haspermission : "Capturegame.Admin"
	IF player(args[1]) == null
		#MESSAGE prefixname+"&e"+args[1]+"&f은(는) &c오프라인 &f입니다!"
		#STOP
	ENDIF
	
	//게임 진행시 변경되어 플레이어의 플레이를 영향주지 않게합니다.
	IF {?"capturebattle.inGame"} == true && {?"CaptureDebug"} != true
		#MESSAGE erralert
		#MESSAGE "&c현재 게임이 진행중입니다! 게임이 끝나면 팀 설정이 가능합니다."
		#STOP
	ENDIF
	
	{?args[1]+".captureTeam"} = 1
	#MESSAGE prefixname+args[1]+"의 팀은 블루입니다."
	player(args[1]).sendMessage("§c§l│ §f§l점령전 §9§l│ §f§l당신의 팀이 §9§l블루 §f§l팀으로 설정되었습니다!")
	#STOP
ENDIF
IF args[0] == "팀설정" && args[1] != null && args[2] == "2" && $haspermission : "Capturegame.Admin"
	IF player(args[1]) == null
		#MESSAGE prefixname+args[1]+"&f은(는) &c오프라인 &f입니다!"
		#STOP
	ENDIF
	
	//게임 진행시 변경되어 플레이어의 플레이를 영향주지 않게합니다.
	IF {?"capturebattle.inGame"} == true && {?"CaptureDebug"} != true
		#MESSAGE erralert
		#MESSAGE "&c현재 게임이 진행중입니다! 게임이 끝나면 팀 설정이 가능합니다."
		#STOP
	ENDIF
	
	{?args[1]+".captureTeam"} = 2
	#MESSAGE prefixname+args[1]+"의 팀은 레드입니다."
	player(args[1]).sendMessage("§c§l│ §f§l점령전 §9§l│ §f§l당신의 팀이 §c§l레드 §f§l팀으로 설정되었습니다!")
	#STOP
ENDIF
IF args[0] == "팀설정" && args[1] != null && args[2] != null && $haspermission : "Capturegame.Admin"
	#MESSAGE erralert
	#MESSAGE "&c팀 코드는 반드시 해당 코드로 작성되어야 합니다: 0: 미참여, 1: 블루, 2: 레드"
	#STOP
ENDIF

/////////////////////////////
//목표 점수 설정
//키워드: 목표스코어
/////////////////////////////
IF args[0] == "목표점수" && args.length == 1 && $haspermission : "Capturegame.Admin"
	#MESSAGE prefixname+" 승리에 필요한 목표 점수를 설정합니다."
	#MESSAGE "/점령전 목표점수 정수값"
	#MESSAGE "기본값 설정은 1000점 입니다. 서버가 리부팅되면 초기화됩니다!!"
	#STOP
ENDIF
IF args[0] == "목표점수" && args[1] == "기본값" && $haspermission : "Capturegame.Admin"
	IF {?"capturebattle.inGame"} == true
		#MESSAGE prefixname+"게임 종료시에만 사용이 가능합니다."
		#STOP
	ENDIF
	{?"capture.maxscore"} = 1000
	#MESSAGE prefixname+"점령전 목표 스코어를 1000점으로 설정하였습니다."
	#STOP
ENDIF
IF args[0] == "목표점수" && args[1] != null && $haspermission : "Capturegame.Admin"
	IF {?"capturebattle.inGame"} == true
		#MESSAGE "게임 종료시에만 사용이 가능합니다."
		#STOP
	ENDIF
	IF $isnumber:args[1] == false
		#MESSAGE erralert
		#MESSAGE "&c목표점수 값은 반드시 정수값으로 넣어야합니다!"
		#STOP
	ENDIF
	IF parseInt(args[1]) <= 149
		#MESSAGE erralert
		#MESSAGE "&c목표 점수는 적어도 &6150&c점 이상이여야 합니다!"
		#STOP
	ENDIF
	{?"capture.maxscore"} = parseInt(args[1])
	#MESSAGE prefixname+"점령전 목표 스코어를 "+{?"capture.maxscore"}+"점으로 설정하였습니다."
	#STOP
ENDIF
/////////////////////////////
//타이머 설정 시나리오
//키워드: 타이머
/////////////////////////////
IF args[0] == "시간설정" && args.length == 1
	#MESSAGE prefixname+"점령전 플레이 타임을 설정합니다."
	#MESSAGE "/점령전 시간설정 분(정수), 초(정수)"
	#MESSAGE "기본 제한 시간은 10분 00초 입니다."
	#STOP
ENDIF
IF args[0] == "시간설정" && args[1] != null && args.length == 2
	IF $isnumber:args[1] == false
		#MESSAGE erralert
		#MESSAGE "&c분 값은 반드시 정수값으로 넣어야합니다!"
		#STOP
	ENDIF
	IF parseInt(args[1]) <= 0
		#MESSAGE erralert
		#MESSAGE "&c분 값은 적어도 &61&c분 이상이여야 합니다!"
		#STOP
	ENDIF
	{?"capturebattle.TimeMin"} = parseInt(args[1])
	#MESSAGE prefixname+"점령전 제한시간 분을 "+{?"capturebattle.TimeMin"}+" 분으로 설정했습니다."
	#STOP
ENDIF
IF args[0] == "시간설정" && args[1] != null && args[2] != null
	IF $isnumber:args[1] == false
		#MESSAGE erralert
		#MESSAGE "&c분 값은 반드시 정수값으로 넣어야합니다!"
		#STOP
	ENDIF
	IF parseInt(args[1]) <= 0
		#MESSAGE erralert
		#MESSAGE "&c분 값은 적어도 &61&c분 이상이여야 합니다!"
		#STOP
	ENDIF
	IF $isnumber:args[2] == false
		#MESSAGE erralert
		#MESSAGE "&c초 값은 반드시 정수값으로 넣어야합니다!"
		#STOP
	ENDIF
	IF parseInt(args[2]) <= -1
		#MESSAGE erralert
		#MESSAGE "&c분 값은 적어도 &60&c초 이상이여야 합니다!"
		#STOP
	ENDIF
	{?"capturebattle.TimeMin"} = parseInt(args[1])
	{?"capturebattle.TimeSec"} = parseInt(args[2])
	
	#MESSAGE prefixname+"점령전 제한시간을 "+{?"capturebattle.TimeMin"}+":"+{?"capturebattle.TimeSec"}+ " 으로 설정했습니다."
	IF {?"capturebattle.TimeSec"} >= 60
		#MESSAGE "초 부분이 60을 넘었습니다. 게임 시작시 60초 = 1분으로 변환됩니다."
	ENDIF
	#STOP
ENDIF

/////////////////////////////
//참가자 리스트 시나리오
//키워드: 참가자목록
/////////////////////////////
IF args[0] == "팀목록" || args[0] == "team"
	#CALL "CaptureTeamListonCMD" // 해당 NamedTrigger를 열어 편집 바람.
	#STOP
ENDIF

/////////////////////////////
//For Testing Only
//키워드: 테스트용
/////////////////////////////
IF args[0] == "실험용" && $isop == true
	#MESSAGE "디버그/테스트 모드 : {?CaptureDebug}을 true로 설정해주세요. 현 상태 : "+{?"CaptureDebug"}
	#MESSAGE "&c주의: 개발 또는 버그 체크할 때만 사용하여 주세요."
	#MESSAGE "&c&n미지원 버전에서의 플레이 진행용으로 사용 시, \n코드 오류로 진행이 안될 수 있습니다."
	#STOP
ENDIF

/////////////////////////////
//게임 활성화/비활성화
//키워드: 활성화
/////////////////////////////
IF args[0] == "활성화" || args[0] == "enable"
	IF $haspermission : "Capturegame.Admin" == false
		#MESSAGE "&c액세스 레벨 부족"
		#STOP
	ENDIF
	IF {?"capturebattle.enable"} != true
		{?"capturebattle.enable"} = true
	ELSE
		{?"capturebattle.enable"} = false
	ENDIF
	IF {?"capturebattle.enable"} == true
		status = color("&a활성화")
	ELSE
		status = color("&C비활성화")
	ENDIF
	FOR p=getPlayers()
		p.sendMessage(color(prefixname+"관리자 "+$playername+"에 의해 점령전이 "+status+" &f되었습니다."))
	ENDFOR
	
	#STOP
ENDIF

/////////////////////////////
//로비 설정
//키워드: 로비설정
/////////////////////////////
IF args[0] == "로비설정" && args.length == 1
	IF $haspermission : "Capturegame.Admin" == false
		#MESSAGE "&c액세스 레벨 부족"
		#STOP
	ENDIF
	#MESSAGE prefixname+"게임 종료/퇴장시 스폰 혹은 로비를 지정합니다."
	#MESSAGE "/점령전 로비설정 설정 : 서 있는 장소를 로비로 지정합니다."
	#MESSAGE "/점령전 로비설정 해제 : 로비 지정을 해제 합니다."
	#MESSAGE "/점령전 로비설정 이동 : 지정한 장소로 이동합니다."
	IF plugin("EssentialsSpawn") !=null || plugin("CMI") != null
		#MESSAGE "&6현재 spawn 명령어로 자동 퇴장이 가능합니다. 만약 스폰지점 외 다른 장소로 워프를 원하는 경우, 로비 위치를 지정해주세요."
	ELSEIF {"capturebattle.LobbyLoc"} !=null
		#MESSAGE "&6현재 로비가 설정되어 있습니다."
	ENDIF
	#STOP
ENDIF
IF args[0] == "로비설정" && args[1] == "설정"
	IF $haspermission : "Capturegame.Admin" == false
		#MESSAGE "&c액세스 레벨 부족"
		#STOP
	ENDIF
	IF player.getWorld().getName() == "CaptureGame"
		#MESSAGE prefixname+"반드시 &c미니게임 월드 외 다른 월드&r에서 지정해야합니다."
		#STOP
	ELSE
		{"capturebattle.LobbyLoc"} = player.getLocation()
		#MESSAGE prefixname+"로비를 지정하였습니다."
		#STOP
	ENDIF
	#STOP
ENDIF
IF args[0] == "로비설정" && args[1] == "해제"
	IF $haspermission : "Capturegame.Admin" == false
		#MESSAGE "&c액세스 레벨 부족"
		#STOP
	ENDIF
	{"capturebattle.LobbyLoc"} = null
	#MESSAGE prefixname+" 로비 지점을 초기화 했습니다."
	#STOP
ENDIF
IF args[0] == "로비설정" && args[1] == "이동"
	//IF $haspermission : "Capturegame.Admin" == false
	//	#MESSAGE "&c액세스 레벨 부족"
	//	#STOP
	//ENDIF
	IF {"capturebattle.LobbyLoc"} ==null
		#MESSAGE prefixname+"로비가 지정 되어있지 않았습니다."
		#STOP
	ENDIF
	#MESSAGE prefixname+"로비 지점으로 이동합니다..."
	SYNC
	player.teleport({"capturebattle.LobbyLoc"})
	ENDSYNC
	#STOP
ENDIF

/////////////////////////////
//게임 관전 시나리오
//키워드: 점령관전
/////////////////////////////
IF args[0] == "관전"
	IF {?"CaptureDebug"} == true && $haspermission:"Capturegame.Admin" == true
	ELSE
		IF {?"capturebattle.inGame"} != true
			#MESSAGE erralert
			#MESSAGE "&c현재 게임 진행중이 아닙니다."
			#STOP
		ELSEIF {?$playername+".inCgame"} == true
			#MESSAGE erralert
			#MESSAGE "&c참가자는 관전을 진행 할 수 없습니다."	
			#STOP
		ELSEIF player.getWorld().getName() == "CaptureGame"
			#MESSAGE erralert
			#MESSAGE "&c게임 월드에서 바로 관전 할 수 없습니다."
			#STOP 
		ENDIF
		SYNC
			player.teleport(location("CaptureGame",-71.5, 78, -136.5, -0.9, 20.5)); //BlueBase
			IF $isop == false
			#SETGAMEMODE "SPECTATOR"
			ENDIF 
		ENDSYNC
		#MESSAGE prefixname+" 관전 모드로 진행됩니다...."
	ENDIF
	#STOP
ENDIF
//디버그 전용 명령어 (아래에만 작성부탁)
IF args[0] == "점수설정" && {?"CaptureDebug"} == true && {?player.getName()+".inCgame"} == true && {?player.getName()+".captureTeam"} != null
	IF args.length == 1
		#MESSAGE "점수설정 (디버그용으로만 사용하여주세요.)"
		#MESSAGE "/점령전 점수설정 점수숫자 : 자신이 있는 팀에 대한 점수 설정"
		#MESSAGE "/점령전 점수설정 점수숫자 1/2 : 해당 팀에 대한 점수 설정"
	ELSEIF args[1] != null && args.length == 2
		IF $isnumber:args[1] == false
		#MESSAGE erralert
		#MESSAGE "&c반드시 정수값으로 넣어야합니다!"
		#STOP
		ENDIF
		IF parseInt(args[1]) <= 0
		#MESSAGE erralert
		#MESSAGE "&c적어도 &61&c점 이상이여야 합니다!"
		#STOP
		ENDIF
		#MESSAGE args[1]
		IF {?player.getName()+".captureTeam"} == 1
			{?"capturebattle.TeamBlue.TotalScore"} = parseInt(args[1])
		ELSEIF {?player.getName()+".captureTeam"} == 2
			{?"capturebattle.TeamRed.TotalScore"} = parseInt(args[1])
		ENDIF
	ELSEIF args[1] != null && (args[2] == "1" || args[2] == "2")
		IF $isnumber:args[1] == false
		#MESSAGE erralert
		#MESSAGE "&c반드시 정수값으로 넣어야합니다!"
		#STOP
		ENDIF
		IF parseInt(args[1]) <= 0
		#MESSAGE erralert
		#MESSAGE "&c적어도 &61&c점 이상이여야 합니다!"
		#STOP
		ENDIF
		IF args[2] == "1"
			{?"capturebattle.TeamBlue.TotalScore"} = parseInt(args[1])
		ELSEIF args[2] == "2"
			{?"capturebattle.TeamRed.TotalScore"} = parseInt(args[1])
		ENDIF
		#MESSAGE args[1]+" "+args[2]
		
	ENDIF
	#STOP
ENDIF

/////////////////////////////
IF args[0] != null 
	#MESSAGE "&c알 수 없는 명령어 입니다."
	#MESSAGE "/점령전 &6&n"+$cmdline:1
ENDIF

////////////////////////////////////////////////////////////
// 해당 트리거 컨텐츠를 테스트 및 플레이 해주신 분들 께 감사합니다.
//////////////////////////////////////////////////////////
// 테런인들의 마크 : 진아님, 짜앙구님, 평화님, 주하님, 바람님, 리플라인님,
// 서화님, 옥동님 등.
// 클락워크 프로젝트 : Lusiels(루시)님, 고기님 (일부 PVP 벨런스 관련)
// 리프 서버 : 리사(피드백/맵탈 버그 제보), SlimegameYT, 
// Special Thanks : Map remake by Lusiel_