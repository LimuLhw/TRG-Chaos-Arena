import org.bukkit.util.Vector

//when not blue Team has into here...
IF {?$playername+".isCaptureDied"} == true
	#STOP
ENDIF
IF {?$playername+".captureTeam"} == 2 //팀이 블루일 때
ELSEIF {?$playername+".captureTeam"} == 1 //팀이 레드일 때
	player.setVelocity(Vector(toFloat(0.0), toFloat(0.5), toFloat(-1.2)));
ENDIF
