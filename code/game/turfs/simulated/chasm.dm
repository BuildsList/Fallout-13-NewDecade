
//////////////CHASM//////////////////

/turf/open/chasm
	name = "chasm"
	desc = "Watch your step."
	baseturf = /turf/open/chasm
	smooth = SMOOTH_TRUE | SMOOTH_BORDER
	icon = 'icons/turf/floors/Chasms.dmi'
	icon_state = "smooth"
	var/drop_x = 1
	var/drop_y = 1
	var/drop_z = 1

/turf/open/chasm/Entered(atom/movable/AM)
	START_PROCESSING(SSobj, src)
	drop_stuff(AM)

/turf/open/chasm/process()
	if(!drop_stuff())
		STOP_PROCESSING(SSobj, src)

/turf/open/chasm/proc/drop_stuff(AM)
	. = 0
	var/thing_to_check = src
	if(AM)
		thing_to_check = list(AM)
	for(var/thing in thing_to_check)
		if(droppable(thing))
			. = 1
			addtimer(CALLBACK(src, .proc/drop, thing), 0)

/turf/open/chasm/proc/droppable(atom/movable/AM)
	if(!isliving(AM) && !isobj(AM))
		return 0
	if(istype(AM, /obj/singularity) || istype(AM, /obj/item/projectile) || AM.throwing)
		return 0
	if(istype(AM, /obj/effect/portal))
		//Portals aren't affected by gravity. Probably.
		return 0
	//Flies right over the chasm
	if(isliving(AM))
		var/mob/MM = AM
		if(MM.movement_type & FLYING)
			return 0
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(istype(H.belt, /obj/item/device/wormhole_jaunter))
			var/obj/item/device/wormhole_jaunter/J = H.belt
			//To freak out any bystanders
			visible_message("<span class='boldwarning'>[H] falls into [src]!</span>")
			J.chasm_react(H)
			return 0
	return 1

/turf/open/chasm/proc/drop(atom/movable/AM)
	//Make sure the item is still there after our sleep
	if(!AM || QDELETED(AM))
		return

	var/turf/T = locate(drop_x, drop_y, drop_z)
	if(T)
		AM.visible_message("<span class='boldwarning'>[AM] falls into [src]!</span>", "<span class='userdanger'>GAH! Ah... where are you?</span>")
		T.visible_message("<span class='boldwarning'>[AM] falls from above!</span>")
		AM.forceMove(T)
		if(isliving(AM))
			var/mob/living/L = AM
			L.Weaken(5)
			L.adjustBruteLoss(30)


/turf/open/chasm/straight_down/Initialize()
	..()
	drop_x = x
	drop_y = y
	if(z+1 <= world.maxz)
		drop_z = z+1

/turf/open/chasm/straight_down/lava_land_surface
	initial_gas_mix = "o2=14;n2=23;TEMP=300"
	planetary_atmos = TRUE
	baseturf = /turf/open/chasm/straight_down/lava_land_surface

/turf/open/chasm/straight_down/lava_land_surface/drop(atom/movable/AM)
	//Make sure the item is still there after our sleep
	if(!AM || QDELETED(AM))
		return
	AM.visible_message("<span class='boldwarning'>[AM] falls into [src]!</span>", "<span class='userdanger'>You stumble and stare into an abyss before you. It stares back, and you fall \
	into the enveloping dark.</span>")
	if(isliving(AM))
		var/mob/living/L = AM
		L.notransform = TRUE
		L.Stun(10)
		L.resting = TRUE
	animate(AM, transform = matrix() - matrix(), alpha = 0, color = rgb(0, 0, 0), time = 10)
	for(var/i in 1 to 5)
		//Make sure the item is still there after our sleep
		if(!AM || QDELETED(AM))
			return
		AM.pixel_y--
		sleep(2)

	//Make sure the item is still there after our sleep
	if(!AM || QDELETED(AM))
		return

	if(iscyborg(AM))
		var/mob/living/silicon/robot/S = AM
		qdel(S.mmi)

	qdel(AM)

/turf/open/chasm/straight_down/lava_land_surface/normal_air
	initial_gas_mix = "o2=22;n2=82;TEMP=293.15"

//?????? ????????????
//?????????????? ?????????? ????????????
//#poezd

/* /turf/open/chasm/straight_down/train/
	baseturf = /turf/open/chasm/straight_down/train/
	if(1+1 <= world.maxz)
		drop_x = rand(6,27)
			if(z+1 <= world.maxz)
				if(z+1 <= world.maxz)
					drop_y = rand(99,103)
						drop_z = 2

//???????????????????? ????????????????
/turf/open/chasm/straight_down/train/openground
	baseturf = /turf/open/chasm/straight_down/train/openground
	name = '???????????????? ????????????????'
	desc = '???? ????????????!'
	icon = 'icons/fallout/turfs/train.dmi'
	icon_state = "openground"

//???????????????????? ????????????
/turf/open/chasm/straight_down/train/openrail
	baseturf = /turf/open/chasm/straight_down/train/openrail
	name = '????????????'
	desc = '???? ????????????!'
	icon = 'icons/fallout/turfs/train.dmi'
	icon_state = "openwall" */

