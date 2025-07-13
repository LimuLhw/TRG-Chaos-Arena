useditem = {"captureitems.scorebox"}
IF useditem == null
	#STOP
ENDIF
IF useditem.getItemMeta().getDisplayName() == $helditemdisplayname
	IF $worldname == "CaptureGame"
		scoreb = 30 //input score (int)
		#CANCELEVENT
		IF {?"capturebattle.inGame"} == true && ({?$playername+".captureTeam"} == 1 || {?$playername+".captureTeam"} == 2) == true
			IF takeItem(player,{"captureitems.scorebox"}, 1)
				{?$playername+".CaptureScore"} += scoreb
				IF {?$playername+".captureTeam"} == 1
					{?"capturebattle.TeamBlue.TotalScore"} += scoreb
				ELSEIF {?$playername+".captureTeam"} == 2
					{?"capturebattle.TeamRed.TotalScore"} += scoreb
				ELSE
					#MESSAGE "&c&l│ &f&l! &c&l│ &f당신은 어떤 팀에도 소속되있지 않습니다!"
				ENDIF
				tmcode = {?$playername+".captureTeam"} 
				IF tmcode == 1
					colorStr = "§9"
				ELSEIF tmcode == 2
					colorStr = "§c"
				ENDIF
				
				FOR p = getPlayers();IF p.getWorld().getName() == "CaptureGame"
					p.sendMessage("§c§l│ §f§l! §c§l│ "+colorStr+"§l"+$playername+"§f§l이(가) §a§l스코어 상자§f§l를 사용하였습니다! §f[ +"+scoreb+" ]")
					IF tmcode == 1
						p.sendMessage("블루팀 현재 점수: "+{?"capturebattle.TeamBlue.TotalScore"})
					ELSEIF tmcode == 2
						p.sendMessage("레드팀 현재 점수: "+{?"capturebattle.TeamRed.TotalScore"})
					ENDIF
				ENDIF;ENDFOR			
				#STOP 
			ENDIF 
		ELSE
			#CANCELEVENT
			#MESSAGE "&c&l│ &f&l! &c&l│ &f점령전에서만 사용 가능한 아이템입니다."
		ENDIF
	ENDIF
ENDIF