//게임 종료 후 결과를 출력할 때 써줄 import들
import java.util.Arrays
import java.util.ArrayList
import java.util.Map$Entry
import java.util.Collections
import java.lang.System
////////////////////////////////////

//게임 종료후 로비로 복귀 하는 시간 (Except. 디버그 모드)
lobbyWaitSec = 15


IF {?"capturebattle.inGame"} == true  || {?"capturewait"} == true
	#MESSAGE "이미 게임이 시작된 상태입니다."
	#STOP
ENDIF

//스코어보드를 위한 import
import org.bukkit.scoreboard.DisplaySlot
import org.bukkit.Bukkit

//팀 인원을 체크합니다.
//팀 인원은 각 팀에 최소 1명 이상이여야 합니다. (실험 변수 true시 해당 체크를 스킵하고 게임을 시작합니다.)
totallist = list() //총인원 임시 변수 지급을 위함
FOR p=getPlayers()
	//신식 전적으로 변경
	IF {p.getName()+".CaptureWin"} != null && $isnumber:{p.getName()+".CaptureWin"}  == true
		{"CaptureStatistics."+p.getName()+".CWin"} = {p.getName()+".CaptureWin"}
		{p.getName()+".CaptureWin"} = null
	ENDIF
	IF {p.getName()+".CaptureLose"} != null && $isnumber:{p.getName()+".CaptureLose"}  == true
		{"CaptureStatistics."+p.getName()+".CLose"} = {p.getName()+".CaptureLose"}
		{p.getName()+".CaptureLose"} = null
	ENDIF
	///////////////
	
	IF ({?p.getName()+".captureTeam"} == 1 || {?p.getName()+".captureTeam"} == 2) && p.getWorld().getName() ==  "CaptureGame"
		totallist.add(p.getName())
	ENDIF
ENDFOR
IF {?"CaptureDebug"} == null || {?"CaptureDebug"} == false
	redlist = list()
	bluelist = list()
	FOR p = getPlayers() 
		IF {?p.getName()+".captureTeam"} == 1 && p.getWorld().getName() ==  "CaptureGame"
			bluelist.add(p.getName())
		ELSEIF {?p.getName()+".captureTeam"} == 2 && p.getWorld().getName() ==  "CaptureGame"
			redlist.add(p.getName())
		ENDIF
	ENDFOR
	IF redlist.isEmpty() == true || bluelist.isEmpty() == true
		#MESSAGE "&c게임을 시작하지 못했습니다."
		#MESSAGE "&c팀 인원이 부족합니다. 최소 1명 이상이여야 합니다!"
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
		#STOP
	ENDIF
ENDIF
	
IF {?"capture.maxscore"} == null
	{?"capture.maxscore"} = 1000
ENDIF
IF {?"capturebattle.TimeMin"} == null
	{?"capturebattle.TimeMinleft"} = 10
ELSE
	{?"capturebattle.TimeMinleft"} = {?"capturebattle.TimeMin"} 
ENDIF
IF {?"capturebattle.TimeSec"} == null
	{?"capturebattle.TimeSecleft"} = 0
ELSE
	{?"capturebattle.TimeSecleft"} = {?"capturebattle.TimeSec"} 
ENDIF

WHILE {?"capturebattle.TimeSecleft"} >= 60
	//체크용 MESSAGE
	//#MESSAGE "타이머 : "+{?"capturebattle.TimeMin"}+" : "+{?"capturebattle.TimeSec"}
	IF {?"capturebattle.TimeSecleft"} >= 60
		{?"capturebattle.TimeSecleft"} = {?"capturebattle.TimeSecleft"} - 60;
		{?"capturebattle.TimeMinleft"} = {?"capturebattle.TimeMinleft"} + 1;
	ELSE
		#BREAK
	ENDIF
ENDWHILE
/////////////

//디버그용 시간 연장 (분단위가 x2로 됨)
IF {?"CaptureDebug"} != null && {?"CaptureDebug"} == true
	{?"capturebattle.TimeMinleft"} += {?"capturebattle.TimeMinleft"}
ENDIF

	
#CALL "CaptureDefaultKit"
{?"capturehost"} = $playername
SYNC
////
FOR p = getPlayers() //플레이어 리스트 불러오기
	IF {?p.getName()+".captureTeam"} == 1 && p.getWorld().getName() == "CaptureGame"
		p.teleport(location("CaptureGame",-71.5, 65, -177.5, -0.9, 20.5)); //BlueBase
	ELSEIF {?p.getName()+".captureTeam"} == 2 && p.getWorld().getName() == "CaptureGame"
		p.teleport(location("CaptureGame", -71.5, 65, -93.5, -178.5, 14.7)); //RedBase
	ENDIF
	p.sendMessage(color("&c&l│ &f&l점령전 &9&l│&f&l 경기가 시작되었습니다."))
	IF p.getWorld().getName() == "CaptureGame"
		p.setHealth(p.getMaxHealth())
		p.setFoodLevel(20)
		//Description
		p.sendMessage("§a§l━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
		p.sendMessage("                             §f§l점령전")
		p.sendMessage("  ")
		IF {?p.getName()+".captureTeam"} == 1 && p.getWorld().getName() == "CaptureGame"
			p.sendMessage("                    §f§l당신은 §9§l블루 §f§l팀 입니다.")
		ELSEIF {?p.getName()+".captureTeam"} == 2 && p.getWorld().getName() == "CaptureGame"
			p.sendMessage("                    §f§l당신은 §c§l레드 §f§l팀 입니다.")
		ELSEIF {?p.getName()+".captureTeam"} == 0 || {?p.getName()+".captureTeam"} == null && p.getWorld().getName() == "CaptureGame"
			p.sendMessage("                    §f§l당신은 §7§l관전자 §f§l입니다.")
		ENDIF
		p.sendMessage("  ")
		p.sendMessage("                  §e§l먼저 "+{?"capture.maxscore"}+"점 획득시 승리.")
		p.sendMessage("     §e§l탈락시 10초 후 다시 부활 및 상대팀 스코어 증가.")
		p.sendMessage(" §e§l특수 발판을 밟거나, 보급상자 아이템 사용 시 스코어 증가.")
		p.sendMessage("§a§l━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
	ENDIF
	{?p.getName()+".CaptureProcess"} = null
ENDFOR
////
ENDSYNC
#CALL "CaptureTeamList"

//내 점수 변수를 선언하기 위함
FOR l=0:totallist.size()
	{?totallist.get(l)+".CaptureScore"} = 0
ENDFOR

{?"capturebattle.inGame"} = true
capturecount = random(30,51)
scorecount = 10
notifycount = 30


#CALL "CaptureVarReset"
WHILE {?"capturebattle.inGame"} == true
	//ScoreBoardScene
	SYNC
		FOR p = getPlayers();IF p.getWorld().getName() == "CaptureGame"
			scoreboard = Bukkit.getScoreboardManager().getNewScoreboard();
			objective = scoreboard.registerNewObjective("CaptureGame", "dummy", color("&e점령전"));
			
			IF {?p.getName()+".captureTeam"} == 1
				objective.getScore(color("&a&l현재 진영&f&l: &9&l블루 &f&l팀")).setScore(9)
			ELSEIF {?p.getName()+".captureTeam"} == 2
				objective.getScore(color("&a&l현재 진영&f&l: &c&l레드 &f&l팀")).setScore(9)
			ELSE
				objective.getScore(color("&a&l현재 진영&f&l: &7&l관전자")).setScore(9)
			ENDIF 
			
			IF {?"capturebattle.TimeSecleft"} <= 9
				objective.getScore(color("&a&l남은 시간&f: "+{?"capturebattle.TimeMinleft"}+":0"+{?"capturebattle.TimeSecleft"})).setScore(8)
			ELSE
				objective.getScore(color("&a&l남은 시간&f: "+{?"capturebattle.TimeMinleft"}+":"+{?"capturebattle.TimeSecleft"})).setScore(8)
			ENDIF
			
			objective.getScore(color("&f")).setScore(7)
			objective.getScore(color("&c&l레드 팀 : &f"+{?"capturebattle.TeamRed.TotalScore"})).setScore(6)
			objective.getScore(color("&9&l블루 팀 : &f"+{?"capturebattle.TeamBlue.TotalScore"})).setScore(5)
			IF {?p.getName()+".captureTeam"} == 1 || {?p.getName()+".captureTeam"} == 2
				objective.getScore(color("&e&l현재 획득한 스코어 &f: "+{?$playername+".CaptureScore"})).setScore(4)
			ENDIF
			p.setScoreboard(objective.getScoreboard());
			objective.setDisplaySlot("SIDEBAR")
		ENDIF;ENDFOR
	ENDSYNC
	//////////////////
	
	IF {?"capturebattle.inGame"} == false
		#STOP
	ENDIF
	//맵 언로드시 게임 강제 종료는 CustomTrigger -> CaptureMapUnloadEvent를 참조.
	
	//목표 점수 돌파시
	IF {?"capturebattle.TeamBlue.TotalScore"} >= {?"capture.maxscore"} //default 1000
		winTeam = 1
		resultCode = 1
		{?"capturebattle.inGame"} = false
	ELSEIF {?"capturebattle.TeamRed.TotalScore"} >= {?"capture.maxscore"} //default 1000
		winTeam = 2
		resultCode = 1
		{?"capturebattle.inGame"} = false
	ENDIF	
	
	//스코어 발판 카운트. 30초에서 50초 사이에 랜덤으로 생성
	// 디버깅용 : #MESSAGE capturecount
	IF scorecount <= 0
		#CALL "CaptureBScore"
		scorecount = 10
	ENDIF
	
	IF notifycount <= 0
		#CALL "captureScore"
		notifycount = 30
	ENDIF
	
	IF capturecount <= 0
		#CALL "captureScorealert"
		capturecount = random(30,51)
	ENDIF
	#WAIT 1
	capturecount -= 1
	scorecount -= 1
	notifycount -= 1

	//타이머 씬
	IF {?"capturebattle.TimeSecleft"} == 0 && {?"capturebattle.TimeMinleft"} >= 1
		{?"capturebattle.TimeMinleft"} -= 1
		{?"capturebattle.TimeSecleft"} = 59
	ELSE
		{?"capturebattle.TimeSecleft"} -= 1
	ENDIF
	IF {?"capturebattle.TimeMinleft"} == 5 && {?"capturebattle.TimeSecleft"} == 0
		FOR p = getPlayers() 
			IF p.getWorld().getName() == "CaptureGame"
				p.sendMessage("§c§l│ §f§l점령전 §9§l│§f§l 5분이 지났습니다. 앞으로 남은 시간은 5분입니다.")
			ENDIF
		ENDFOR
	ELSEIF {?"capturebattle.TimeMinleft"} == 1 && {?"capturebattle.TimeSecleft"} == 0
		FOR p = getPlayers() 
			IF p.getWorld().getName() == "CaptureGame"
				p.sendMessage("§c§l│ §f§l점령전 §9§l│§f§l 9분이 지났습니다. 앞으로 남은 시간은 1분입니다.")
			ENDIF
		ENDFOR
	ENDIF
	
	//시간 종료시
	IF {?"capturebattle.TimeSecleft"} <= -1 && {?"capturebattle.TimeMinleft"} == 0
		//B > R
		IF {?"capturebattle.TeamBlue.TotalScore"} > {?"capturebattle.TeamRed.TotalScore"}
			winTeam = 1
			resultCode = 2
		//R > B
		ELSEIF {?"capturebattle.TeamRed.TotalScore"} > {?"capturebattle.TeamBlue.TotalScore"}
			winTeam = 2
			resultCode = 2
		ELSE
			winTeam = 0
			resultCode = 2
		ENDIF
		{?"capturebattle.inGame"} = false
	ENDIF
	
	ENDIF
ENDWHILE
/////////////
//Result "
FOR p=getPlayers()
	IF p.getWorld().getName() == "CaptureGame" && {?p.getName()+".inCgame"} == true
		IF winTeam == 1
			p.sendMessage(color("&c&l│ &f&l게임 종료! &c&l│ &f&l점령전 종료! 블루 팀 승리! 점수 : "+{?"capturebattle.TeamBlue.TotalScore"}))
		ELSEIF winTeam == 2
			p.sendMessage(color("&c&l│ &f&l게임 종료! &c&l│ &f&l점령전 종료! 레드 팀 승리! 점수 : "+{?"capturebattle.TeamRed.TotalScore"}))
		ELSEIF winTeam == 0
			p.sendMessage(color("&c&l│ &f&l게임 종료! &c&l│ &f&l경기가 종료되었습니다."))
		ENDIF
	ELSE
	p.sendMessage(color("&c&l│ &f&l점령전 &9&l│&f&l 경기가 종료되었습니다."))
	ENDIF
ENDFOR

FOR p = getPlayers() //플레이어 리스트 불러오기
	IF resultCode != null && winTeam != null
		//패배시
		IF (winTeam == 2 && {?p.getName()+".captureTeam"} == 1) == true || (winTeam == 1 && {?p.getName()+".captureTeam"} == 2) == true
			p.sendMessage("§c§l패배...")
			p.sendTitle("§c§l패배...", "당신의 팀이 패배했습니다...", 20, 100, 10)
			IF {?"CaptureDebug"} != true
				//전적 기록
				IF {?p.getName()+".captureTeam"} == 1 && {"CaptureStatistics."+p.getName()+".CLose"} == null
					{"CaptureStatistics."+p.getName()+".CLose"} = 0
					{"CaptureStatistics."+p.getName()+".CLose"} += 1
				ELSE
				{"CaptureStatistics."+p.getName()+".CLose"} += 1
				ENDIF
				//////////
			ELSE
				p.sendMessage("§c§l│ §f§l게임 종료! §c§l│ §f§l실험 및 테스트 중에는 전적이 기록되지 않습니다.")
			ENDIF
		//승리시
		ELSEIF (winTeam == 1 && {?p.getName()+".captureTeam"} == 1) == true || (winTeam == 2 && {?p.getName()+".captureTeam"} == 2) == true
			p.sendMessage("§9§l승리!")
			p.sendTitle("§9§l승리!", "당신의 팀이 승리했습니다!", 20, 100, 10)
			IF {?"CaptureDebug"} != true
				//전적 기록
				IF {?p.getName()+".captureTeam"} == 2 && {"CaptureStatistics."+p.getName()+".CWin"} == null
					{"CaptureStatistics."+p.getName()+".CWin"} = 0
					{"CaptureStatistics."+p.getName()+".CWin"} += 1
				ELSE
				{"CaptureStatistics."+p.getName()+".CWin"} += 1
				ENDIF
				//////////
			ELSE
				p.sendMessage("§c§l│ §f§l게임 종료! §c§l│ §f§l실험 및 테스트 중에는 전적이 기록되지 않습니다.")
			ENDIF
		ENDIF
	ENDIF
ENDFOR
		
#CALL "captureScore"
#CALL "captureEndCi"

/////////////////////////////
//special thanks : Lusiel_
/////////////////////////////
//jvmver = System.getProperty("java.version").startsWith("16.")
m = map()
FOR l=0:totallist.size()
	m.put({?totallist.get(l)+".CaptureScore"}, totallist.get(l))	//전체유저 점수, 전체유저 이름
ENDFOR
//my code...
val = m.values()
tmp = list()
tmp.addAll(val)
v = array(tmp.size())
FOR av = 0:tmp.size()
	v[av] = tmp.get(av)
ENDFOR
ke = m.keySet()
tmp = list()
tmp.addAll(ke)
k = array(tmp.size())
FOR kv = 0:tmp.size()
	k[kv] = tmp.get(kv)
ENDFOR

//Deprecated in 16 and later. (illegal-access issue)
//v=m.values().toArray()
//k=m.keySet().toArray()

ENDIF
Arrays.sort(k, Collections.reverseOrder())
result = list()
resultmap = array(m.size())
FOR n = 0:m.size()
	a = k[n]
	FOR nr = 0:m.size()
		IF a == k[nr]
			result.add("Name : "+m.get(k[nr])+"/ Score :"+k[nr])
			resultmap[nr] = m.get(k[nr])+", "+ k[nr]
		ENDIF
	ENDFOR
ENDFOR
	FOR p = getPlayers()
		IF p.getWorld().getName() == "CaptureGame"
			p.sendMessage("§a§l━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
			p.sendMessage("                           §6§l게임 결과")
			IF {?p.getName()+".captureTeam"} == 1 || {?p.getName()+".captureTeam"} == 2
				p.sendMessage(color("&e획득한 점수 &f: "+{?p.getName()+".CaptureScore"}+" 점"))
			ENDIF
			IF resultmap.length < 5	//인원 수 n명수 보다 작을때 그냥 돌리면 예외 발생함
				FOR i = 0:resultmap.length
					p.sendMessage(color((i+1)+"위: "+resultmap[i]+" 점"))
				ENDFOR
			ELSE
				FOR i = 0:5
					p.sendMessage(color((i+1)+"위: "+resultmap[i]+" 점"))
				ENDFOR
			ENDIF
			//FOR a = 0:m.size()
			//	p.sendMessage(color((a+1)+"위: "+resultmap[a]))
			//ENDFOR
			p.sendMessage("§a§l━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
		ENDIF
	ENDFOR
ENDIF
///////////////////////////////////////

//게임 종료후 마무리 되는데로 스폰으로 돌려보내
{?"capturewait"} = true
{?"CaptureHost"} = "dummy"


FOR p = getPlayers()
	IF p.getWorld().getName() == "CaptureGame"
		{?p.getName()+".inCgame"} = false
		{?p.getName()+".CaptureScore"} = null
		{?p.getName()+".CaptureProcess"} = null
		p.sendMessage("§c§l│ §f§l점령전 §9§l│§f 게임이 종료 되어 "+lobbyWaitSec+"초 후 스폰으로 돌아갑니다..")
		
		
		p.getScoreboard().clearSlot(DisplaySlot.SIDEBAR)
	ENDIF
ENDFOR
IF {?"CaptureDebug"} != true
	#WAIT lobbyWaitSec
ELSE
	#WAIT 5
ENDIF
FOR p = getPlayers()
	{?p.getName()+".captureTeam"} = null
	IF {?"CaptureDebug"} == true && p.isOp() == true
		p.getScoreboard().clearSlot(DisplaySlot.SIDEBAR)
	ELSEIF p.getWorld().getName() == "CaptureGame"
		p.getScoreboard().clearSlot(DisplaySlot.SIDEBAR)
		p.getInventory().clear()
		IF {"capturebattle.LobbyLoc"} !=null
		SYNC
			p.teleport({"capturebattle.LobbyLoc"})
		ENDSYNC
		ELSEIF plugin("EssentialsSpawn") !=null || plugin("CMI") != null
			#CMDCON "spawn "+p.getName()
		ENDIF
	ENDIF
ENDFOR
{?"capturewait"} = false
{?"capturebattle"} = null
///