 //점령시 알림 반복문
FOR p = getPlayers() //플레이어 리스트 불러오기
IF p.getWorld().getName() == "CaptureGame" //인게임에 있는 유저들만 메세지 출력
	p.sendMessage("§c§l│ §f§l점령전 §9§l│§f§l 스코어 발판이 생성되었습니다!")
ENDIF
ENDFOR
SYNC
IMPORT org.bukkit.Bukkit
IMPORT org.bukkit.Material
IMPORT org.bukkit.Location
scorefoot = random(1,11)
IF scorefoot == 1

Location(Bukkit.getWorld("CaptureGame"),-47,65,-107).getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
ELSEIF scorefoot == 2

Location(Bukkit.getWorld("CaptureGame"), -91,65,-115).getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
ELSEIF scorefoot == 3

Location(Bukkit.getWorld("CaptureGame"),-50,65,-128).getBlock().setType(Material.LIGHT_WEIGHTED_PRESSURE_PLATE)
ELSEIF scorefoot == 4

Location(Bukkit.getWorld("CaptureGame"),-94,65,-127).getBlock().setType(Material.LIGHT_WEIGHTED_PRESSURE_PLATE)
ELSEIF scorefoot == 5

Location(Bukkit.getWorld("CaptureGame"),-60,65,-136).getBlock().setType(Material.LIGHT_WEIGHTED_PRESSURE_PLATE)
ELSEIF scorefoot == 6

Location(Bukkit.getWorld("CaptureGame"),-84,65,-136).getBlock().setType(Material.LIGHT_WEIGHTED_PRESSURE_PLATE)
ELSEIF scorefoot == 7

Location(Bukkit.getWorld("CaptureGame"),-50,65,-145).getBlock().setType(Material.LIGHT_WEIGHTED_PRESSURE_PLATE)
ELSEIF scorefoot == 8

Location(Bukkit.getWorld("CaptureGame"),-94,65,-144).getBlock().setType(Material.LIGHT_WEIGHTED_PRESSURE_PLATE)
ELSEIF scorefoot == 9

Location(Bukkit.getWorld("CaptureGame"),-53,65,-157).getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
ELSEIF scorefoot == 10

Location(Bukkit.getWorld("CaptureGame"),-97,65,-165).getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
ENDIF
ENDSYNC

////////////////////////////////
				