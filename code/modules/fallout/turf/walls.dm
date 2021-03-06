//Fallout 13 general destructible walls directory

/turf/closed/wall/f13/
	name = "матрица"
	desc = "<font color='#6eaa2c'>You suddenly realize the truth - there is no spoon.<br>Something has caused a glitch in the simulation.</font>"
	icon = 'icons/fallout/turfs/walls.dmi'
	icon_state = "matrix"


/turf/closed/wall/f13/ReplaceWithLattice()
	ChangeTurf(baseturf)

/turf/closed/wall/f13/ruins
	name = "руины"
	desc = "All what has left from the good old days."
	icon = 'icons/fallout/turfs/walls/ruins.dmi'
	icon_state = "ruins0"
	icontype = "ruins"
	hardness = 70
	explosion_block = 2
	smooth = SMOOTH_OLD
	disasemblable = 0
	grider = 0
	plating_type = /turf/open/ruins
	sheet_type = null
	canSmoothWith = list(/turf/closed/wall/f13/ruins, /turf/closed/wall)


/turf/closed/wall/f13/wood
	name = "бревенчатая стена"
	desc = "Традиционная бревенчатая стенка."
	icon = 'icons/fallout/turfs/walls/wood.dmi'
	icon_state = "wood0"
	icontype = "wood"
	hardness = 60
	smooth = SMOOTH_OLD
	disasemblable = 0
	plating_type = /turf/open/floor/plating/wooden
	sheet_type = /obj/item/stack/sheet/mineral/wood
	sheet_amount = 2
	grider = 0
	canSmoothWith = list(/turf/closed/wall/f13/wood, /turf/closed/wall)

/turf/closed/wall/f13/wood/house
	name = "деревянная стена"
	desc = "Довоенная стена из досок."
	icon = 'icons/fallout/turfs/walls/house.dmi'
	icon_state = "house0"
	icontype = "house"
	hardness = 50
	var/broken = 0
	canSmoothWith = list(/turf/closed/wall/f13/wood/house, /turf/closed/wall/f13/wood/house/broken, /turf/closed/wall)

/turf/closed/wall/f13/wood/house/broken
	broken = 1
	damage = 21
	icon_state = "house0-broken"

/turf/closed/wall/f13/wood/house/take_damage(dam)
	if(damage + dam > hardness/2)
		broken = 1
	..()

/turf/closed/wall/f13/wood/house/relative()
	icon_state = "[icontype][junction][broken ? "-broken" : ""]"

/turf/closed/wall/f13/wood/house/update_icon()
	if(broken)
		set_opacity(0)
	..()

/turf/closed/wall/f13/wood/house/update_damage_overlay()
	if(broken)
		return
	..()

/turf/closed/wall/f13/wood/interior
	name = "стена с обоями"
	desc = "Interesting, what kind of material they have used - these wallpapers still look good after all the centuries..."
	icon = 'icons/fallout/turfs/walls/interior.dmi'
	icon_state = "interior0"
	icontype = "interior"
	hardness = 10
	smooth = SMOOTH_OLD
	canSmoothWith = list(/turf/closed/wall/f13/wood/interior, /turf/closed/wall)

/turf/closed/wall/f13/store
	name = "бетонная стена"
	desc = "A pre-War store wall made of solid concrete."
	icon = 'icons/fallout/turfs/walls/store.dmi'
	icon_state = "store0"
	icontype = "store"
	hardness = 800000
	smooth = SMOOTH_OLD
	disasemblable = 0
	grider = 0
	sheet_type = null
	canSmoothWith = list(/turf/closed/wall/f13/store, /turf/closed/wall)

/turf/closed/wall/f13/supermart
	name = "усиленная бетонная стена"
	desc = "A pre-War supermart wall made of reinforced concrete."
	icon = 'icons/fallout/turfs/walls/superstore.dmi'
	icon_state = "supermart0"
	icontype = "supermart"
	hardness = 90
	explosion_block = 2
	smooth = SMOOTH_OLD
	disasemblable = 0
	grider = 0
	sheet_type = null
	canSmoothWith = list(/turf/closed/wall/f13/supermart, /turf/closed/wall)

/turf/closed/wall/f13/window
	name = "усиленная бетонная стена"
	icon = 'icons/fallout/turfs/walls/superstore.dmi'
	icon_state = "sukablyat"
	disasemblable = 0
	grider = 0
	explosion_block = 2
	hardness = 70
	sheet_type = null
	canSmoothWith = null

/turf/closed/wall/f13/window/horizontal
	icon_state = "storeprewindowhorizontal"

/turf/closed/wall/f13/window/vertical
	icon_state = "storeprewindowvertical"

/turf/closed/wall/f13/window/top
	icon_state = "storeprewindowtop"

/turf/closed/wall/f13/window/bottom
	icon_state = "storeprewindowbottom"

/turf/closed/wall/f13/window/left
	icon_state = "storeprewindowleft"

/turf/closed/wall/f13/window/right
	icon_state = "storeprewindowright"

/turf/closed/wall/f13/tunnel
	name = "стена технических коммуникаций"
	desc = "A sturdy metal wall with various pipes and wiring set inside a special groove."
	icon = 'icons/fallout/turfs/walls/tunnel.dmi'
	icon_state = "tunnel0"
	icontype = "tunnel"
	hardness = 100
	smooth = SMOOTH_OLD
	disasemblable = 0
	grider = 0
	sheet_type = null
	canSmoothWith = list(/turf/closed/wall/f13/tunnel, /turf/closed/wall)

/turf/closed/wall/f13/vault
	name = "vault wall"
	desc = "A sturdy and cold metal wall."
	icon = 'icons/fallout/turfs/walls/vault.dmi'
	icon_state = "vault0"
	icontype = "vault"
	hardness = 13000
	explosion_block = 5
	disasemblable = 0
	smooth = SMOOTH_OLD
	canSmoothWith = list(/turf/closed/wall/f13/vault, /turf/closed/wall/r_wall/f13/vault, /turf/closed/wall)

/turf/closed/wall/r_wall/f13
	name = "матрица"
	desc = "<font color='#6eaa2c'>You suddenly realize the truth - there is no spoon.<br>Something has caused a glitch in the simulation.</font>"
	icon = 'icons/fallout/turfs/walls.dmi'
	icon_state = "matrix"

/turf/closed/wall/r_wall/f13/vault
	name = "vault reinforced wall"
	desc = "A wall built to withstand an atomic explosion."
	icon = 'icons/fallout/turfs/walls/vault_reinforced.dmi'
	icon_state = "vaultrwall0"
	icontype = "vaultrwall"
	hardness = 230
	explosion_block = 5
	disasemblable = 0
	smooth = SMOOTH_OLD
	canSmoothWith = list(/turf/closed/wall/f13/vault, /turf/closed/wall/r_wall/f13/vault, /turf/closed/wall)

//Fallout 13 indestructible walls

/turf/closed/indestructible/f13
	name = "матрица"
	desc = "<font color='#6eaa2c'>You suddenly realize the truth - there is no spoon.<br>Something has caused a glitch in the simulation.</font>"
	icon = 'icons/fallout/turfs/walls.dmi'
	icon_state = "matrix"

//ЧАСТЬ КОДА ПОЕЗДА
//ПРОШУ БУДУЩИХ КОДЕРОВ ИСПРАВИТЬ МОЮ ОШИБКУ #poezd

//Начало кода #poezd
//Защита от любителей изучить
/turf/closed/indestructible/f13/train
	icon = 'icons/effects/effects.dmi'
	opacity = 0

//Защитный щит
/turf/closed/indestructible/f13/train/shield
	name = "Защитное поле"
	desc = "Непробиваемое защитное поле, которое ограждает тебя от путешествий вглубь."
	icon_state = "shieldwall"

//Движущеися стены ИХ КОД НЕ ЮЗАТЬ ЕГО В ИГРЕ ПРОСТО БЛЯДЬ ЮЗАЙ TOP И DOWN НАХУЙ.
/turf/closed/indestructible/f13/train/openwall
	name = "Стена"
	desc = "Ничего необычного."
	icon = 'icons/fallout/turfs/train.dmi'


//Движущеися стены вверху
/turf/closed/indestructible/f13/train/openwall/top
	name = "Стена"
	desc = "Ничего необычного."
	icon_state = "topopenwall"

//Движущеися стены внизу
/turf/closed/indestructible/f13/train/openwall/down
	name = "Стена"
	desc = "Ничего необычного."
	icon_state = "downopenwall"
//Конец кода поезда #poezd

/turf/closed/indestructible/f13/subway
	name = "tunnel wall"
	desc = "This wall is made of reinforced concrete.<br>Pre-War engineers knew how to build reliable things."
	icon = 'icons/fallout/turfs/walls/subway.dmi'
	icon_state = "subwaytop"

/turf/closed/indestructible/f13/subway/cornerinner
	name = "tunnel wall"
	desc = "This wall is made of reinforced concrete.<br>Pre-War engineers knew how to build reliable things."
	icon_state = "subway"

/turf/closed/indestructible/f13/matrix //The Chosen One from Arroyo!
	name = "matrix"
	desc = "<font color='#6eaa2c'>You suddenly realize the truth - there is no spoon.<br>Digital simulation ends here.</font>"
	icon_state = "matrix"

/turf/closed/indestructible/f13/tunnel
	name = "utility tunnel wall"
	desc = "A sturdy metal wall with various pipes and wiring set inside a special groove."
	icon = 'icons/fallout/turfs/walls/tunnel.dmi'
	icon_state = "tunnel0"
	icontype = "tunnel"
	smooth = SMOOTH_OLD
	canSmoothWith = list(/turf/closed/wall/f13/tunnel, /turf/closed/wall, /turf/closed/indestructible/f13/tunnel)

/turf/closed/indestructible/f13/vault
	name = "vault reinforced wall"
	desc = "A wall built to withstand an atomic explosion."
	icon = 'icons/fallout/turfs/walls/vault_reinforced.dmi'
	icon_state = "vaultrwall0"
	icontype = "vaultrwall"
	smooth = SMOOTH_OLD
	canSmoothWith = list(/turf/closed/wall/f13/vault, /turf/closed/wall/r_wall/f13/vault, /turf/closed/wall, /turf/closed/indestructible/f13/vault)

/turf/closed/indestructible/f13/obsidian //Just like that one game studio that worked on the original game, or that block in Minecraft!
	name = "obsidian"
	desc = "No matter what you do with this rock, there's not even a scratch left on its surface.<br><font color='#7e0707'>You shall not pass!!!</font>"
	icon = 'icons/fallout/turfs/mining.dmi'
	icon_state = "rock1"

/turf/closed/indestructible/f13/obsidian/New()
	..()
	icon_state = "rock[rand(1,6)]"

//Splashscreen

/turf/closed/indestructible/f13/splashscreen
	var/tickerPeriod = 300 //in deciseconds
	var/atom/movable/fullDark

turf/closed/indestructible/f13/splashscreen/New()
	.=..()
	name = "Fallout 13"
	desc = "The wasteland is calling!"
	icon = 'icons/fallout/misc/lobby.dmi'
	//icon_state = "fo3"
	icon_state = "title[rand(1,13)]"
	layer = 60
	plane = 1
	src.fullDark = new/atom/movable{
		icon = 'icons/fallout/misc/lobby.dmi' //Replace with actual icon
		icon_state = "transition" //Replace with actual darkness state
		layer = 61;
		alpha = 0;
		}(src)
	src.fullDark.plane = 1
	spawn() src.ticker()
	return

turf/closed/indestructible/f13/splashscreen/proc/ticker()
	while(src && istype(src,/turf/closed/indestructible/f13/splashscreen))
		//src.swapImage()
		sleep(src.tickerPeriod)
	to_chat(world, "Администрация-долбоебы, которые удалили экран лобби.<br>ЩИТСПАВНЕРЫ!!!")
	return

//Change the time to determine how short/long the fading animation is.
//Change the easing to determine what interpolation it uses to change the value on a curve: good ones to try are CUBIC, BOUNCE, and ELASTIC as well as CIRCULAR. BOUNCE and ELASTIC both "bounce" or "flicker" a little bit at the end instead of just finishing straight at black.

/turf/closed/indestructible/f13/splashscreen/proc/swapImage()
	animate(src.fullDark,alpha=255,time=10,easing=CUBIC_EASING)
	sleep(12) //buffer of about 1/5 of the time of the animation, since they are not synchronized: the sleep happens on the server, but the animation is played for each client using directX. It's good to leave a buffer, but most of the time the directX will be much faster than the server anyway so you probably wont have any problems.
	src.icon_state = "title[rand(1,13)]"
	animate(src.fullDark,alpha=0,time=10,easing=CUBIC_EASING)
	return