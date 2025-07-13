//Capture item namedTrigger
//#MESSAGE random
import org.bukkit.potion.PotionEffectType
import org.bukkit.potion.PotionEffect
random = random(1,8)

IF player.getInventory().firstEmpty() == -1
    #MESSAGE "인벤토리가 꽉찼습니다!"
	#STOP
ENDIF
IF random == 1
	#GIVE {"captureitems.pushsword"}
ELSEIF random == 2
	#GIVE {"captureitems.bowitem"}
	IF player.getInventory().firstEmpty() == -1
		#MESSAGE "인벤토리가 꽉찼습니다!"
		#STOP
	ENDIF
	#GIVE  item("ARROW",4)
ELSEIF random == 3
	#GIVE {"captureitems.shield"}
ELSEIF random == 4
	heal = item("POTION", 1)
	Meta = heal.getItemMeta()
	IF PotionEffectType.getByName("HEAL") == null
		effType = PotionEffectType.INSTANT_HEALTH
	ELSE
		effType = PotionEffectType.HEAL
	ENDIF
	Meta.addCustomEffect(PotionEffect(effType, 10, 1), true)
	Meta.setDisplayName(color("&f치유의 물약"))
	heal.setItemMeta(Meta)
	//{"captureitems.healitem"} = heal <-- 이렇게 하니까 리로드 하면 에러 나서 지역 변수로 하기로 함.
	#GIVE heal
	
ELSEIF random == 5
	damage = item("SPLASH_POTION", 1)
	Meta2 = damage.getItemMeta()
	IF PotionEffectType.getByName("HARM") == null
		effType = PotionEffectType.INSTANT_DAMAGE
	ELSE
		effType = PotionEffectType.HARM
	ENDIF
	Meta2.addCustomEffect(PotionEffect(effType, 10, 1), true)
	Meta2.setDisplayName(color("&f고통의 물약"))
	damage.setItemMeta(Meta2)
	//{"captureitems.damageitem"} = heal <-- 이렇게 하니까 리로드 하면 에러 나서 지역 변수로 하기로 함. 근데 색이 좀 이상한듯 ㅡㅡ;
	#GIVE damage
	
ELSEIF random == 6
	#GIVE {"captureitems.trident"}
ELSEIF random == 7
	//스코어 상자 갯수 체크
	inv = player.getInventory()
	scorebox = {"captureitems.scorebox"}
	boxTotal = 0
	FOR i=inv
		IF i == null
			#CONTINUE
		ELSEIF i.getItemMeta().getDisplayName() ==  scorebox.getItemMeta().getDisplayName() 
			boxTotal += i.getAmount()
		ENDIF
	ENDFOR
	IF boxTotal >= 2
		#CALL "CaptureItems"
	ELSE
		#GIVE {"captureitems.scorebox"}
	ENDIF
ENDIF