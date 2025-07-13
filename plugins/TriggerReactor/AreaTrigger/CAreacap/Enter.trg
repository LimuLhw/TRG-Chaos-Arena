//C 지역
import org.bukkit.Location
import org.bukkit.Material
import org.bukkit.Bukkit
import java.lang.Math
cScore = 20
IF {?$playername+".isCaptureDied"} == true
	#STOP
ENDIF
IF ({?$playername+".captureTeam"} == 0 || {?$playername+".captureTeam"} == null) || {?$playername+".inCgame"} != true
	#STOP
ENDIF

//게임 시작 했을 때만 발동시키세요.
IF {?"capturebattle.inGame"} == true
	IF {?player.getName()+".CaptureProcess"} == null || {?player.getName()+".CaptureProcess"} !=  currentArea(player)
		{?player.getName()+".CaptureProcess"} = currentArea(player)
	ELSEIF {?player.getName()+".CaptureProcess"} == currentArea(player)
		#STOP
	ENDIF
	trg = plugin("TriggerReactor")
	trgver = trg.getDescription().getVersion().toString()
	//각 지역 트리거를 구할 에리어 메니저
	//IF trgver.contains("3.3") == true || trgver.contains("3.2") == true
	//	import io.github.wysohn.triggerreactor.core.main.TriggerReactorCore
	//	areaManager = TriggerReactorCore.getInstance().getAreaManager();
	//ELSE 
		import io.github.wysohn.triggerreactor.core.manager.trigger.area.AreaTriggerManager
		areaManager = injector.getInstance(AreaTriggerManager)
	//ENDIF 
	area = areaManager.get("CAreacap").getArea();
	
	//포지션 불러오기
	loc1 = area.getLargest();
	loc2 = area.getSmallest();
	
	Y1 = loc1.getY();Z1 = loc1.getZ();X1 = loc1.getX()
	Y2 = loc2.getY();Z2 = loc2.getZ();X2 = loc2.getX()
	
	IF {?$playername+".captureTeam"} == 1 //팀이 블루일 때
		IF {?"capturebattle.TeamBlue.inCArea.Capturerer"} == null || {?"capturebattle.TeamBlue.inCArea.Capturerer"} == "uncaptured"
			{?"capturebattle.TeamBlue.inCArea.Capturerer"} = $playername
		ENDIF
			
	ELSEIF {?$playername+".captureTeam"} == 2 //팀이 레드일 때
		IF {?"capturebattle.TeamRed.inCArea.Capturerer"} == null || {?"capturebattle.TeamRed.inCArea.Capturerer"} == "uncaptured"
			{?"capturebattle.TeamRed.inCArea.Capturerer"} = $playername
		ENDIF
		
	ENDIF
	
ELSE
	#STOP
ENDIF

WHILE {?"capturebattle.inGame"} == true
	IF currentArea(player) == null
		IF {?"capturebattle.TeamBlue.inCArea.Capturerer"} == player.getName()
			{?"capturebattle.TeamBlue.inCArea.Capturerer"} = "uncaptured"
		ELSEIF {?"capturebattle.TeamRed.inCArea.Capturerer"} == player.getName()
			{?"capturebattle.TeamRed.inCArea.Capturerer"} = "uncaptured"
		ENDIF
		{?player.getName()+".CaptureProcess"} = null
		#STOP
	ENDIF

	IF {?"capturebattle.CArea.Team"} == 0 //C지역을 점령한 팀 체크 (중립일 시)
		
		IF  {?"capturebattle.TeamBlue.inCArea.Capturerer"} != "uncaptured" && {?"capturebattle.TeamRed.inCArea.Capturerer"} == "uncaptured" //블루팀이 1명 이상 들어와 있고 레드팀이 없을 때
			
			IF {?"capturebattle.CArea.bluehealth"} >= 25 //캡쳐 체력(블루팀)이 6일 때 점령
				{?"capturebattle.CArea.bluehealth"} = 25
				
				//Blue +Score
				{?"capturebattle.TeamBlue.TotalScore"} = {?"capturebattle.TeamBlue.TotalScore"} + cScore
				{?$playername+".CaptureScore"} = {?$playername+".CaptureScore"} + cScore
				
				//점령시 알림 반복문
				FOR p = getPlayers() //플레이어 리스트 불러오기
					IF {?p.getName()+".captureTeam"} == 1 && p.getWorld().getName() == "CaptureGame"
						p.sendMessage("블루팀 : C 지역을 점령하였습니다. [ +"+cScore+" ]")
					ELSEIF {?p.getName()+".captureTeam"} == 2 && p.getWorld().getName() == "CaptureGame"
						p.sendMessage("레드팀 : C 지역을 빼앗겼습니다!")
					ELSEIF p.getWorld().getName() == "CaptureGame"
						p.sendMessage("블루팀이 C지역을 점령하였습니다! [ +"+cScore+" ]")
					ENDIF
					IF p.getWorld().getName() == "CaptureGame" //인게임에 있는 유저들만 메세지 출력
						p.sendMessage("블루팀 현재 점수: "+{?"capturebattle.TeamBlue.TotalScore"})
					ENDIF
				ENDFOR
				////////////////////////////////
				
				 //SETBLOCK
				 SYNC
					FOR a = Y2:Y1+1
						FOR b = Z2:Z1+1
							FOR c = X2:X1+1
								IF Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "WHITE_CONCRETE"
									Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().setType(Material.BLUE_CONCRETE)
								ENDIF
							ENDFOR
						ENDFOR
					ENDFOR
				 ENDSYNC
				 //

				 {?"capturebattle.CArea.Team"} = 1 //Set CArea Captured Team in Blue
				 //#BREAK
			ELSEIF {?"capturebattle.TeamBlue.inCArea.Capturerer"} != "uncaptured" && {?"capturebattle.TeamRed.inCArea.Capturerer"} == "uncaptured" //블루팀이 1명 이상 들어와 있고 레드팀이 없을 때
				IF  {?$playername+".captureTeam"} == 1 //해당 대사는 반드시 블루만 보이게.
					IF {?"capturebattle.TeamBlue.inCArea.Capturerer"} == "uncaptured"
						{?player.getName()+".CaptureProcess"} = null
						#STOP
					ENDIF
				ENDIF
				
				// 중간에 블루팀 한 플레이어가 밖으로 나갔다면?
				IF {?"capturebattle.TeamBlue.inCArea.Capturerer"} == null || {?"capturebattle.TeamBlue.inCArea.Capturerer"} == "uncaptured"
					{?"capturebattle.TeamBlue.inCArea.Capturerer"} = $playername
				ENDIF
				
				IF {?"capturebattle.CArea.redhealth"} <= 0
					#ACTIONBAR "C 지역 점령 하고 있습니다... : "+{?"capturebattle.CArea.bluehealth"}
				ELSE
					#ACTIONBAR "C 지역 점령을 막고 있습니다... : "+{?"capturebattle.CArea.redhealth"}
				ENDIF

				#WAIT 0.1
				IF {?"capturebattle.CArea.redhealth"} <= 0
					IF{?"capturebattle.TeamBlue.inCArea.Capturerer"} == "uncaptured" 
						{?player.getName()+".CaptureProcess"} = null
						#STOP
					ENDIF
					//블루 점령자 닉네임이 점령중일때만 HP 상승
					IF {?"capturebattle.TeamBlue.inCArea.Capturerer"} == $playername
						{?"capturebattle.CArea.bluehealth"} += 1
					ELSEIF  {?"capturebattle.TeamBlue.inCArea.Capturerer"} != "uncaptured"
						#ACTIONBAR "우리팀 "+{?"capturebattle.TeamBlue.inCArea.Capturerer"}+"이(가) 점령중입니다."
					ENDIF
				ELSE
					IF{?"capturebattle.TeamRed.inCArea.Capturerer"} == "uncaptured" 
					//블루 점령자 닉네임이 점령중일 때만 HP 하락
						IF {?"capturebattle.TeamBlue.inCArea.Capturerer"} == $playername
							{?"capturebattle.CArea.redhealth"} -= 1
						ENDIF
					ELSE
						#ACTIONBAR "!"
					ENDIF
				ENDIF
			ELSE
				#WAIT 0.1
			ENDIF
		ELSE
		
		ENDIF
		ELSEIF {?"capturebattle.CArea.Team"} == 1 //C지역을 점령한 팀 체크 (블루팀 일 시)
			IF  {?$playername+".captureTeam"} == 1 //팀이 블루일 때
				IF {?"capturebattle.CArea.bluehealth"} >= 25
					#WAIT 0.1
				ELSE
					#WAIT 0.1
					IF {?"capturebattle.TeamBlue.inCArea.Capturerer"} != "uncaptured" && {?"capturebattle.TeamRed.inCArea.Capturerer"} == "uncaptured"
						IF {?"capturebattle.TeamBlue.inCArea.Capturerer"} == $playername
							{?"capturebattle.CArea.bluehealth"} += 1
							#ACTIONBAR "이 지역은 C지역이고, 블루팀이 점령하였고, HP는 "+{?"capturebattle.CArea.bluehealth"}+" 이다."
						ENDIF
					ELSE
						
					ENDIF
					
				ENDIF
				
			ELSEIF {?$playername+".captureTeam"} == 2 //팀이 레드팀일 때
				//#ACTIONBAR  "이 지역은 C지역이고, 블루팀이 점령하였다. 깃발을 내려버리자."
				//#ACTIONBAR "Blue:"+{?"capturebattle.TeamBlue.inCArea.isHere"}+" Red:"+{?"capturebattle.TeamRed.inCArea.isHere"}
				IF {?"capturebattle.TeamBlue.inCArea.Capturerer"} != "uncaptured" && {?"capturebattle.TeamRed.inCArea.Capturerer"} != "uncaptured"
					#WAIT 0.1
				ELSEIF {?"capturebattle.TeamBlue.inCArea.Capturerer"} != "uncaptured" && {?"capturebattle.TeamRed.inCArea.Capturerer"} == "uncaptured"
					{?player.getName()+".CaptureProcess"} = null
					#STOP
				ENDIF
			 
				
				IF {?"capturebattle.TeamBlue.inCArea.Capturerer"} == "uncaptured" && {?"capturebattle.TeamRed.inCArea.Capturerer"} != "uncaptured" //블루팀이 1명 이상 들어와 있고 레드팀이 없을 때
					#ACTIONBAR "C 지역을 뺏고 있습니다... : "+{?"capturebattle.CArea.bluehealth"}
					IF {?"capturebattle.CArea.bluehealth"} <= 0 //캡쳐 체력(블루팀)이 6일 때 점령
						{?"capturebattle.CArea.bluehealth"} = 0
						 //#BROADCAST "C지역을 빼앗겼습니다 : 레드팀"
						 
				//SETBLOCK
				 SYNC
					FOR a = Y2:Y1+1
						FOR b = Z2:Z1+1
							FOR c = X2:X1+1
								IF Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "BLUE_CONCRETE"
									Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().setType(Material.WHITE_CONCRETE)
								ENDIF
							ENDFOR
						ENDFOR
					ENDFOR
					
				 ENDSYNC
				 //
						 {?"capturebattle.CArea.Team"} = 0 //Set CArea Captured Team in Normal
						 //#BREAK
						 
					//블루 없음, 레드 있을때
					ELSEIF {?"capturebattle.TeamBlue.inCArea.Capturerer"} == "uncaptured" && {?"capturebattle.TeamRed.inCArea.Capturerer"} != "uncaptured"
					
						#WAIT 0.1
						IF {?"capturebattle.TeamBlue.inCArea.Capturerer"} == "uncaptured" && {?"capturebattle.TeamRed.inCArea.Capturerer"} != "uncaptured" //블루팀이 1명 이상 들어와 있고 레드팀이 없을 때
								//레드 점령자만 발동
								IF {?"capturebattle.TeamRed.inCArea.Capturerer"} == $playername
									{?"capturebattle.CArea.bluehealth"} -= 1
								ELSEIF {?"capturebattle.TeamRed.inCArea.Capturerer"} == "uncaptured"
									{?"capturebattle.TeamRed.inCArea.Capturerer"} = $playername
									{?"capturebattle.CArea.bluehealth"} -= 1
								ENDIF
						ELSEIF {?"capturebattle.TeamBlue.inCArea.Capturerer"} != "uncaptured" && {?"capturebattle.TeamRed.inCArea.Capturerer"} != "uncaptured"//블루팀/레드팀 모두 있을 때
							#WAIT 0.1
						ENDIF
						
					ELSE
						#WAIT 0.1
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ELSE
	
	ENDIF
	
	//END HERE BLUE
	
	//
	//레드 포탈 시나리오
	//
	
IF {?"capturebattle.CArea.Team"} == 0 //C지역을 점령한 팀 체크 (중립일 시)
		IF  {?"capturebattle.TeamRed.inCArea.Capturerer"} != "uncaptured" && {?"capturebattle.TeamBlue.inCArea.Capturerer"} == "uncaptured" //블루팀이 1명 이상 들어와 있고 레드팀이 없을 때
			
			IF {?"capturebattle.CArea.redhealth"} >= 25 //캡쳐 체력(레드팀)이 6일 때 점령
				{?"capturebattle.CArea.redhealth"} = 25
				 
				//Red +Score
				 {?"capturebattle.TeamRed.TotalScore"} = {?"capturebattle.TeamRed.TotalScore"} + cScore
				 {?$playername+".CaptureScore"} = {?$playername+".CaptureScore"} + cScore
				
				 //점령시 알림 반복문
				FOR p = getPlayers() //플레이어 리스트 불러오기
					IF {?p.getName()+".captureTeam"} == 2 && p.getWorld().getName() == "CaptureGame"
						p.sendMessage("레드팀 : C 지역을 점령하였습니다. [ +"+cScore+" ]")
					ELSEIF {?p.getName()+".captureTeam"} == 1 && p.getWorld().getName() == "CaptureGame"
						p.sendMessage("블루팀 : C 지역을 빼앗겼습니다!")
					ELSEIF p.getWorld().getName() == "CaptureGame"
						p.sendMessage("레드팀이 C지역을 점령하였습니다! [ +"+cScore+" ]")
					ENDIF
					IF p.getWorld().getName() == "CaptureGame" //인게임에 있는 유저들만 메세지 출력
						p.sendMessage("레드팀 현재 점수: "+{?"capturebattle.TeamRed.TotalScore"})
					ENDIF
				ENDFOR
				////////////////////////////////
				 
				 
				 //SETBLOCK
				 SYNC
					FOR a = Y2:Y1+1
						FOR b = Z2:Z1+1
							FOR c = X2:X1+1
								IF Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "WHITE_CONCRETE"
									Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().setType(Material.RED_CONCRETE)
								ENDIF
							ENDFOR
						ENDFOR
					ENDFOR
					
				 ENDSYNC
				 //
				
				 {?"capturebattle.CArea.Team"} = 2 //Set CArea Captured Team in Blue
				 //#BREAK
			ELSEIF {?"capturebattle.TeamRed.inCArea.Capturerer"} != "uncaptured" && {?"capturebattle.TeamBlue.inCArea.Capturerer"} == "uncaptured" //블루팀이 1명 이상 들어와 있고 레드팀이 없을 때
				IF  {?$playername+".captureTeam"} == 2 //해당 대사는 반드시 레드만 보이게.
					IF{?"capturebattle.TeamRed.inCArea.Capturerer"} == "uncaptured" 
						{?player.getName()+".CaptureProcess"} = null
						#STOP
					ENDIF
				ENDIF
				
				// 중간에 레드팀 한 플레이어가 밖으로 나갔다면?
				IF {?"capturebattle.TeamRed.inCArea.Capturerer"} == null || {?"capturebattle.TeamRed.inCArea.Capturerer"} == "uncaptured"
					{?"capturebattle.TeamRed.inCArea.Capturerer"} = $playername
				ENDIF
				
				IF {?"capturebattle.CArea.bluehealth"} <= 0
					#ACTIONBAR "C 지역을 점령하고 있습니다... : "+{?"capturebattle.CArea.redhealth"}
				ELSE
					#ACTIONBAR "C 지역 점령을 막고 있습니다... : "+{?"capturebattle.CArea.bluehealth"}
				ENDIF
				#WAIT 0.1
				IF {?"capturebattle.CArea.bluehealth"} <= 0
					IF{?"capturebattle.TeamRed.inCArea.Capturerer"} == "uncaptured" 
						{?player.getName()+".CaptureProcess"} = null
						#STOP
					ELSE
					
						//레드 점령자 닉네임이 점령중일때만 HP 상승
						IF {?"capturebattle.TeamRed.inCArea.Capturerer"} == $playername
							{?"capturebattle.CArea.redhealth"} = {?"capturebattle.CArea.redhealth"} +1
						ELSEIF  {?"capturebattle.TeamRed.inCArea.Capturerer"} != "uncaptured"
							#ACTIONBAR "우리팀 "+{?"capturebattle.TeamRed.inCArea.Capturerer"}+"이(가) 점령중입니다."
						ENDIF
						
					ENDIF
				ELSE
					IF{?"capturebattle.TeamBlue.inCArea.Capturerer"} == "uncaptured" 
						//블루 점령자 닉네임이 점령중일 때만 HP 하락
						IF {?"capturebattle.TeamRed.inCArea.Capturerer"} == $playername
							{?"capturebattle.CArea.bluehealth"} = {?"capturebattle.CArea.bluehealth"} -1
						ENDIF
					ELSE
						#ACTIONBAR "!"
					ENDIF
				ENDIF
			ELSE
				#WAIT 0.1
			ENDIF
			
			
		ELSE
		
		ENDIF
		ELSEIF {?"capturebattle.CArea.Team"} == 2 //C지역을 점령한 팀 체크 (블루팀 일 시)
			IF  {?$playername+".captureTeam"} == 2 //팀이 레드일 때
				IF {?"capturebattle.CArea.redhealth"} >= 25
					#WAIT 0.1
				ELSE
					#WAIT 0.1
					// Red 안에 있고, Blue 없을 때만 회복 가능
					IF {?"capturebattle.TeamRed.inCArea.Capturerer"} != "uncaptured" && {?"capturebattle.TeamBlue.inCArea.Capturerer"} == "uncaptured"
						IF {?"capturebattle.TeamRed.inCArea.Capturerer"} == $playername
							{?"capturebattle.CArea.redhealth"} = {?"capturebattle.CArea.redhealth"} + 1
							#ACTIONBAR "이 지역은 C지역이고, 레드팀이 점령하였고, HP는 "+{?"capturebattle.CArea.redhealth"}+" 이다."
						ENDIF
					ELSE
						
					ENDIF
					
				ENDIF
			ELSEIF {?$playername+".captureTeam"} == 1 //팀이 레드팀일 때
				//#ACTIONBAR  "이 지역은 C지역이고, 블루팀이 점령하였다. 깃발을 내려버리자."
				//#ACTIONBAR "Blue:"+{?"capturebattle.TeamBlue.inCArea.isHere"}+" Red:"+{?"capturebattle.TeamRed.inCArea.isHere"}
				IF {?"capturebattle.TeamRed.inCArea.Capturerer"} != "uncaptured" && {?"capturebattle.TeamBlue.inCArea.Capturerer"} != "uncaptured"
					#WAIT 0.1
				ELSEIF {?"capturebattle.TeamRed.inCArea.Capturerer"} != "uncaptured" && {?"capturebattle.TeamBlue.inCArea.Capturerer"} == "uncaptured"
				{?player.getName()+".CaptureProcess"} = null
					#STOP
				ENDIF
			 
				
				IF {?"capturebattle.TeamRed.inCArea.Capturerer"} == "uncaptured" && {?"capturebattle.TeamBlue.inCArea.Capturerer"} != "uncaptured" //블루팀이 1명 이상 들어와 있고 레드팀이 없을 때
					#ACTIONBAR "C 지역을 뺏고 있습니다... : "+{?"capturebattle.CArea.redhealth"}
					IF {?"capturebattle.CArea.redhealth"} <= 0 //캡쳐 체력(블루팀)이 6일 때 점령
						{?"capturebattle.CArea.redhealth"} = 0
						 
				//SETBLOCK
				 SYNC
					FOR a = Y2:Y1+1
						FOR b = Z2:Z1+1
							FOR c = X2:X1+1
								IF Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "RED_CONCRETE"
									Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().setType(Material.WHITE_CONCRETE)
								ENDIF
							ENDFOR
						ENDFOR
					ENDFOR
					
				 ENDSYNC
				 //
						 {?"capturebattle.CArea.Team"} = 0 //Set CArea Captured Team in Normal
						 
					ELSEIF {?"capturebattle.TeamRed.inCArea.Capturerer"} == "uncaptured" && {?"capturebattle.TeamBlue.inCArea.Capturerer"} != "uncaptured"
						#WAIT 0.1
						IF {?"capturebattle.TeamRed.inCArea.Capturerer"} == "uncaptured" && {?"capturebattle.TeamBlue.inCArea.Capturerer"} != "uncaptured" //블루팀이 1명 이상 들어와 있고 레드팀이 없을 때
						
							//블루 점령자만 발동
							IF {?"capturebattle.TeamBlue.inCArea.Capturerer"} == $playername
								{?"capturebattle.CArea.redhealth"} = {?"capturebattle.CArea.redhealth"} - 1
							ELSEIF {?"capturebattle.TeamBlue.inCArea.Capturerer"} == "uncaptured"
								{?"capturebattle.TeamBlue.inCArea.Capturerer"} = $playername
								{?"capturebattle.CArea.redhealth"} = {?"capturebattle.CArea.redhealth"} - 1
							ENDIF
							
						ELSEIF {?"capturebattle.TeamRed.inCArea.Capturerer"} != "uncaptured" && {?"capturebattle.TeamBlue.inCArea.Capturerer"} != "uncaptured" //블루팀/레드팀 모두 있을 때
							#WAIT 0.1
						ENDIF
						
					ELSE
						#BREAK
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ELSE
	
	ENDIF
	IF currentArea(player) == null
		IF {?"capturebattle.TeamBlue.inCArea.Capturerer"} == player.getName()
			{?"capturebattle.TeamBlue.inCArea.Capturerer"} = "uncaptured"
		ELSEIF {?"capturebattle.TeamRed.inCArea.Capturerer"} == player.getName()
			{?"capturebattle.TeamRed.inCArea.Capturerer"} = "uncaptured"
		ENDIF
		{?player.getName()+".CaptureProcess"} = null
		#STOP
	ENDIF
ENDWHILE