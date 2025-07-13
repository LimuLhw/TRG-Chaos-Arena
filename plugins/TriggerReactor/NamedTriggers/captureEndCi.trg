//점령 종료시 아이템 리셋
FOR p = getPlayers() //플레이어 리스트 불러오기
	IF ({?p.getName()+".captureTeam"} == 1  || {?p.getName()+".captureTeam"} == 2) && p.getWorld().getName() == "CaptureGame"
		p.sendMessage("§c§l│ §f§l점령전 §9§l│§f 게임이 종료 되어 인벤토리를 리셋합니다.")
		p.getInventory().clear()
	ENDIF
ENDFOR
////////////////////////////////