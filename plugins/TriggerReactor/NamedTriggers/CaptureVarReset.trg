//점령전 변수 초기화 NamedTrigger.
import org.bukkit.Location
import org.bukkit.Material
import org.bukkit.Bukkit
import java.lang.Math

IF {?"CaptureDebug"} == true
	#LOG "[점령전] 변수 리셋 진행중.."
ENDIF
IF {?"capturebattle.inGame"} == null
{?"capturebattle.inGame"} = false
ENDIF
//3.0.x
//import io.github.wysohn.triggerreactor.core.main.TriggerReactorCore
import io.github.wysohn.triggerreactor.core.main.TriggerReactorCore

//상자
Location(Bukkit.getWorld("CaptureGame"), -47, 66, -107).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -50, 66, -128).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -50, 66, -145).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -53, 66, -157).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -60, 66, -136).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -61, 65, -126).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -61, 65, -146).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -67, 65, -116).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -67, 65, -166).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -67, 65, -174).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -67, 65, -98).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -72, 65, -102).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -72, 65, -120).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -72, 65, -152).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -72, 65, -170).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -77, 65, -106).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -77, 65, -156).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -77, 65, -174).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -77, 65, -98).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -83, 65, -126).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -83, 65, -146).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -84, 66, -136).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -91, 66, -115).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -94, 66, -127).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -94, 66, -144).getBlock().setType(Material.CHEST)
Location(Bukkit.getWorld("CaptureGame"), -97, 66, -165).getBlock().setType(Material.CHEST)

//스코어 발판
capturecount = random(30,51)

Location(Bukkit.getWorld("CaptureGame"),-47,65,-107).getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
Location(Bukkit.getWorld("CaptureGame"), -91,65,-115).getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
Location(Bukkit.getWorld("CaptureGame"),-50,65,-128).getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
Location(Bukkit.getWorld("CaptureGame"), -94,65,-127).getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
Location(Bukkit.getWorld("CaptureGame"),-60,65,-136).getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
Location(Bukkit.getWorld("CaptureGame"),-84,65,-136).getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
Location(Bukkit.getWorld("CaptureGame"),-50,65,-145).getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
Location(Bukkit.getWorld("CaptureGame"),-94,65,-144).getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
Location(Bukkit.getWorld("CaptureGame"),-53,65,-157).getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
Location(Bukkit.getWorld("CaptureGame"),-97,65,-165).getBlock().setType(Material.HEAVY_WEIGHTED_PRESSURE_PLATE)
				

{?"capturebattle.TeamBlue.TotalScore"} = 0
{?"capturebattle.TeamRed.TotalScore"} = 0

trg = plugin("TriggerReactor")
trgver = trg.getDescription().getVersion().toString()
//각 지역 트리거를 구할 에리어 메니저
//IF trgver.contains("3.3") == true || trgver.contains("3.2") == true
//	areaManager = TriggerReactorCore.getInstance().getAreaManager();
//ELSE
	import io.github.wysohn.triggerreactor.core.manager.trigger.area.AreaTriggerManager
	areaManager = injector.getInstance(AreaTriggerManager)
//ENDIF 

//A 지역
area = areaManager.get("AAreacap").getArea();
	
//포지션 불러오기
loc1 = area.getLargest();
loc2 = area.getSmallest();

Y1 = loc1.getY();Z1 = loc1.getZ();X1 = loc1.getX()
Y2 = loc2.getY();Z2 = loc2.getZ();X2 = loc2.getX()

{?"capturebattle.TeamBlue.inAArea.Capturerer"} = "uncaptured"
{?"capturebattle.TeamRed.inAArea.Capturerer"} = "uncaptured"
{?"capturebattle.AArea.Team"} = 0
{?"capturebattle.AArea.bluehealth"} = 0
{?"capturebattle.AArea.redhealth"} = 0

 SYNC
 	FOR a = Y2:Y1+1
		FOR b = Z2:Z1+1
			FOR c = X2:X1+1
				IF Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "BLUE_CONCRETE" || Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "RED_CONCRETE"
					Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().setType(Material.WHITE_CONCRETE)
				ENDIF
			ENDFOR
		ENDFOR
	ENDFOR
	
ENDSYNC

//B 지역
area = areaManager.get("BAreacap").getArea();
	
//포지션 불러오기
loc1 = area.getLargest();
loc2 = area.getSmallest();

Y1 = loc1.getY();Z1 = loc1.getZ();X1 = loc1.getX()
Y2 = loc2.getY();Z2 = loc2.getZ();X2 = loc2.getX()

{?"capturebattle.TeamBlue.inBArea.Capturerer"} = "uncaptured"
{?"capturebattle.TeamRed.inBArea.Capturerer"} = "uncaptured"
{?"capturebattle.BArea.Team"} = 0
{?"capturebattle.BArea.bluehealth"} = 0
{?"capturebattle.BArea.redhealth"} = 0

 SYNC
	FOR a = Y2:Y1+1
		FOR b = Z2:Z1+1
			FOR c = X2:X1+1
				IF Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "BLUE_CONCRETE" || Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "RED_CONCRETE"
					Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().setType(Material.WHITE_CONCRETE)
				ENDIF
			ENDFOR
		ENDFOR
	ENDFOR
 ENDSYNC

//C 지역
area = areaManager.get("CAreacap").getArea();
	
//포지션 불러오기
loc1 = area.getLargest();
loc2 = area.getSmallest();

Y1 = loc1.getY();Z1 = loc1.getZ();X1 = loc1.getX()
Y2 = loc2.getY();Z2 = loc2.getZ();X2 = loc2.getX()

{?"capturebattle.TeamBlue.inCArea.Capturerer"} = "uncaptured"
{?"capturebattle.TeamRed.inCArea.Capturerer"} = "uncaptured"
{?"capturebattle.CArea.Team"} = 0
{?"capturebattle.CArea.bluehealth"} = 0
{?"capturebattle.CArea.redhealth"} = 0
 SYNC
	FOR a = Y2:Y1+1
		FOR b = Z2:Z1+1
			FOR c = X2:X1+1
				IF Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "BLUE_CONCRETE" || Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "RED_CONCRETE"
					Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().setType(Material.WHITE_CONCRETE)
				ENDIF
			ENDFOR
		ENDFOR
	ENDFOR
 ENDSYNC

//D 지역
area = areaManager.get("DAreacap").getArea();
	
//포지션 불러오기
loc1 = area.getLargest();
loc2 = area.getSmallest();

Y1 = loc1.getY();Z1 = loc1.getZ();X1 = loc1.getX()
Y2 = loc2.getY();Z2 = loc2.getZ();X2 = loc2.getX()

{?"capturebattle.TeamBlue.inDArea.Capturerer"} = "uncaptured"
{?"capturebattle.TeamRed.inDArea.Capturerer"} = "uncaptured"
{?"capturebattle.DArea.Team"} = 0
{?"capturebattle.DArea.bluehealth"} = 0
{?"capturebattle.DArea.redhealth"} = 0

 SYNC
	FOR a = Y2:Y1+1
		FOR b = Z2:Z1+1
			FOR c = X2:X1+1
				IF Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "BLUE_CONCRETE" || Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "RED_CONCRETE"
					Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().setType(Material.WHITE_CONCRETE)
				ENDIF
			ENDFOR
		ENDFOR
	ENDFOR
 ENDSYNC

//E 지역
area = areaManager.get("EAreacap").getArea();
	
//포지션 불러오기
loc1 = area.getLargest();
loc2 = area.getSmallest();

Y1 = loc1.getY();Z1 = loc1.getZ();X1 = loc1.getX()
Y2 = loc2.getY();Z2 = loc2.getZ();X2 = loc2.getX()

{?"capturebattle.TeamBlue.inEArea.Capturerer"} = "uncaptured"
{?"capturebattle.TeamRed.inEArea.Capturerer"} = "uncaptured"
{?"capturebattle.EArea.Team"} = 0
{?"capturebattle.EArea.bluehealth"} = 0
{?"capturebattle.EArea.redhealth"} = 0

SYNC
	FOR a = Y2:Y1+1
		FOR b = Z2:Z1+1
			FOR c = X2:X1+1
				IF Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "BLUE_CONCRETE" || Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "RED_CONCRETE"
					Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().setType(Material.WHITE_CONCRETE)
				ENDIF
			ENDFOR
		ENDFOR
	ENDFOR
ENDSYNC
//F 지역
area = areaManager.get("FAreacap").getArea();
	
//포지션 불러오기
loc1 = area.getLargest();
loc2 = area.getSmallest();

Y1 = loc1.getY();Z1 = loc1.getZ();X1 = loc1.getX()
Y2 = loc2.getY();Z2 = loc2.getZ();X2 = loc2.getX()

{?"capturebattle.TeamBlue.inFArea.Capturerer"} = "uncaptured"
{?"capturebattle.TeamRed.inFArea.Capturerer"} = "uncaptured"
{?"capturebattle.FArea.Team"} = 0
{?"capturebattle.FArea.bluehealth"} = 0
{?"capturebattle.FArea.redhealth"} = 0

SYNC
	FOR a = Y2:Y1+1
		FOR b = Z2:Z1+1
			FOR c = X2:X1+1
				IF Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "BLUE_CONCRETE" || Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "RED_CONCRETE"
					Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().setType(Material.WHITE_CONCRETE)
				ENDIF
			ENDFOR
		ENDFOR
	ENDFOR
ENDSYNC

//G 지역
area = areaManager.get("GAreacap").getArea();
	
//포지션 불러오기
loc1 = area.getLargest();
loc2 = area.getSmallest();

Y1 = loc1.getY();Z1 = loc1.getZ();X1 = loc1.getX()
Y2 = loc2.getY();Z2 = loc2.getZ();X2 = loc2.getX()

{?"capturebattle.TeamBlue.inGArea.Capturerer"} = "uncaptured"
{?"capturebattle.TeamRed.inGArea.Capturerer"} = "uncaptured"
{?"capturebattle.GArea.Team"} = 0
{?"capturebattle.GArea.bluehealth"} = 0
{?"capturebattle.GArea.redhealth"} = 0

SYNC
	FOR a = Y2:Y1+1
		FOR b = Z2:Z1+1
			FOR c = X2:X1+1
				IF Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "BLUE_CONCRETE" || Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().getType().toString() == "RED_CONCRETE"
					Location(Bukkit.getWorld("CaptureGame"), c,a,b).getBlock().setType(Material.WHITE_CONCRETE)
				ENDIF
			ENDFOR
		ENDFOR
	ENDFOR
 ENDSYNC

//////////////////////////////////////////////////////////////
IMPORT org.bukkit.enchantments.Enchantment
IMPORT org.bukkit.Color
IMPORT org.bukkit.potion.PotionEffectType
IMPORT org.bukkit.potion.PotionEffect
//////////////////////////////////////////////////////////////
//기본템
//////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////
//1.20.5 부터 변경된 변수이름으로 인해 구분을 위해 임시 변수 추가

//Damage_All = 날카로움, Replaced to Sharpness
IF Enchantment.getByName("DAMAGE_ALL") == null
	dall = Enchantment.SHARPNESS
ELSE
	dall = Enchantment.DAMAGE_ALL
ENDIF

//PROTECTION_ENVIRONMENTAL = 보호, Replaced to PROTECTION
IF Enchantment.getByName("PROTECTION_ENVIRONMENTAL") == null
	prot = Enchantment.PROTECTION
ELSE
	prot = Enchantment.PROTECTION_ENVIRONMENTAL
ENDIF

//////////////////////////////////////////////////////////////
//기본 칼
dslore =list()
dslore.add(color("&f&l기본으로 지급되는 칼입니다."))
IF Bukkit.getVersion().contains("1.12.2")
	defaultSword = item("WOOD_SWORD", 1)
ELSE
	defaultSword = item("WOODEN_SWORD", 1)
ENDIF
dsMeta = defaultSword.getItemMeta()
dsMeta.setDisplayName(color("&e기본 칼"))
dsMeta.setUnbreakable(true)
dsMeta.setLore(dslore)
defaultSword.setItemMeta(dsMeta);
{"captureitems.defaultsword"} = defaultSword

//피아식별용 모자 - 블루팀
helmet = item("LEATHER_HELMET", 1)
Meta = helmet.getItemMeta()
Meta.setDisplayName(color("&f[ &9&l블루 팀 &f]"))
Meta.setColor(Color.fromRGB(60,68, 170))
Meta.setUnbreakable(true)
helmet.setItemMeta(Meta)
{"captureitems.TeamBlueH"} = helmet

//피아식별용 모자 - 레드팀
helmet = item("LEATHER_HELMET", 1)
Meta = helmet.getItemMeta()
Meta.setDisplayName(color("&f[ &c&l레드 팀 &f]"))
Meta.setColor(Color.fromRGB(176,46, 38))
Meta.setUnbreakable(true)
helmet.setItemMeta(Meta)
{"captureitems.TeamRedH"} = helmet

//바지류 - 블루팀
Leggings= item("LEATHER_LEGGINGS", 1)
LeggingsMeta = Leggings.getItemMeta()
LeggingsMeta.setDisplayName(color("&f[ &9&l블루 팀 &f]"))
LeggingsMeta.addEnchant(Enchantment.BINDING_CURSE, 1, false)
LeggingsMeta.addEnchant(prot, 3, false)
LeggingsMeta.setColor(Color.fromRGB(60,68, 170))
LeggingsMeta.setUnbreakable(true)
Leggings.setItemMeta(LeggingsMeta)
{"captureitems.TeamBlueArm1"} = Leggings

//신발류 - 블루팀
Boots = item("LEATHER_BOOTS", 1)
BootsMeta = Boots.getItemMeta()
BootsMeta.setDisplayName(color("&f[ &9&l블루 팀 &f]"))
BootsMeta.addEnchant(Enchantment.BINDING_CURSE, 1, false)
BootsMeta.addEnchant(prot, 3, false)
BootsMeta.setColor(Color.fromRGB(60,68, 170))
BootsMeta.setUnbreakable(true)
Boots.setItemMeta(BootsMeta)
{"captureitems.TeamBlueArm2"} = Boots

//바지류 - 레드팀
Leggings= item("LEATHER_LEGGINGS", 1)
LeggingsMeta = Leggings.getItemMeta()
LeggingsMeta.setDisplayName(color("&f[ &c&l레드 팀 &f]"))
LeggingsMeta.addEnchant(Enchantment.BINDING_CURSE, 1, false)
LeggingsMeta.addEnchant(prot, 3, false)
LeggingsMeta.setColor(Color.fromRGB(176,46, 38))
LeggingsMeta.setUnbreakable(true)
Leggings.setItemMeta(LeggingsMeta)
{"captureitems.TeamRedArm1"} = Leggings

//신발류 - 레드팀
Boots = item("LEATHER_BOOTS", 1)
BootsMeta = Boots.getItemMeta()
BootsMeta.setDisplayName(color("&f[ &c&l레드 팀 &f]"))
BootsMeta.addEnchant(Enchantment.BINDING_CURSE, 1, false)
BootsMeta.addEnchant(prot, 3,  false)
BootsMeta.setColor(Color.fromRGB(176,46, 38))
BootsMeta.setUnbreakable(true)
Boots.setItemMeta(BootsMeta)
{"captureitems.TeamRedArm2"} = Boots
///////////////////////////////////////////

///////////////////////////////////////////
//아이템들
///////////////////////////////////////////

//밀치기 검
pslore =list()
pslore.add(color("&f&l잘 밀려 나가는 칼!"))
IF Bukkit.getVersion().contains("1.12.2")
	pSword = item("WOOD_SWORD", 1)
ELSE
	pSword = item("WOODEN_SWORD", 1)
ENDIF
psMeta = pSword.getItemMeta()
psMeta.setDisplayName(color("&e밀치기 칼"))
psMeta.setLore(pslore)
psMeta.addEnchant(Enchantment.KNOCKBACK, 1, false)
psMeta.addEnchant(dall, 1,  false)
pSword.setItemMeta(psMeta);
pSword.setDurability(toShort(54))
{"captureitems.pushsword"} = pSword

//활
bow = item("BOW", 1)
bow.setDurability(toShort(380))
{"captureitems.bowitem"} = bow

//활
shield = item("SHIELD", 1)
shield.setDurability(toShort(335))
{"captureitems.shield"} = shield

//힐/데미지 포션은 초기화에 포함 안되고 CaptureItems에서 지역 변수로 포함됨.

//삼지창 (1.12.2에선 스킵)
IF Bukkit.getVersion().contains("1.12.2")
ELSE
trident = item("TRIDENT",1)
trident.setDurability(toShort(248))
{"captureitems.trident"} = trident
ENDIF
//보급상자
sblore = list()
sblore.add(color("&a&l우클릭&f&l시, &a&l우리팀&f&l에 &c&l추가 점수&f&l를 부여합니다."))
scorebox = item("CHEST",1)
Meta = scorebox.getItemMeta()
Meta.setDisplayName(color("&f[ &a&l스코어 상자 &f]"))
Meta.setLore(sblore)
scorebox.setItemMeta(Meta);
{"captureitems.scorebox"} = scorebox

IF {?"CaptureDebug"} == true
	#LOG "[점령전] 리셋 완료!"
ENDIF 