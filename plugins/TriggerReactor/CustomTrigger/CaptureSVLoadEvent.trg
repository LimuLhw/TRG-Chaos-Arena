//Trigger Loading Event
IMPORT org.bukkit.Bukkit
#LOG "=================="
#LOG color("&c| &f점령전 &9| &f점령전 미니게임 준비중...")
#LOG color("&f제작자 : 이리무 (디스코드 : @limulhw)")
import org.bukkit.World
import org.bukkit.World$Environment
import org.bukkit.Bukkit
import org.bukkit.Location
import org.bukkit.WorldCreator

//배포판에서는 꼭 꺼주세요.
SYNC
	WorldCreator("CaptureGame").environment(Environment.NORMAL).createWorld()
ENDSYNC
//
loaded = false
WHILE loaded == false
	IF Bukkit.getWorld("CaptureGame") == null
		#LOG color("&c아름다운 오류가 발생했습니다 : CaptureGame이 로드가 안됨.")
		#BREAK
	ENDIF
	trg = plugin("TriggerReactor")
	trgver = trg.getDescription().getVersion().toString()
	IF trgver.contains("3.4") || trgver.contains("3.5")==true || trgver.contains("pr")==true
	ELSE
		#LOG color("&c아름다운 오류가 발생했습니다 : 해당 트리거 버전에서는 지원하지 않는 컨텐츠 입니다.")
		#BREAK
	ENDIF
	loaded = true
	IF loaded == true
		#LOG color("&c| &f점령전 &9| &f점령전 준비 완료!")
		{?"capturebattle.enable"}= true
		#BREAK
	ENDIF
ENDWHILE
	
#LOG "=================="