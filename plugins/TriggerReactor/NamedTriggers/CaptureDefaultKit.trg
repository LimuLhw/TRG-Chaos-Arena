//GIVE Default Item
//신발 36, 바지 37

FOR p = getPlayers() //플레이어 리스트 불러오기
	IF {?p.getName()+".captureTeam"} == 1 && p.getWorld().getName() == "CaptureGame"
		p.getInventory().setItem(37,{"captureitems.TeamBlueArm1"}) 
		p.getInventory().setItem(36,{"captureitems.TeamBlueArm2"})
		p.getInventory().setItem(39,{"captureitems.TeamBlueH"})
		p.getInventory().setItem(0,{"captureitems.defaultsword"})
	ELSEIF {?p.getName()+".captureTeam"} == 2 && p.getWorld().getName() == "CaptureGame"
		p.getInventory().setItem(37,{"captureitems.TeamRedArm1"}) 
		p.getInventory().setItem(36,{"captureitems.TeamRedArm2"}) 
		p.getInventory().setItem(39,{"captureitems.TeamRedH"})
		p.getInventory().setItem(0,{"captureitems.defaultsword"})
	ENDIF
ENDFOR
