
//disposal bin and Delivery chute.

#define SEND_PRESSURE 0.05*ONE_ATMOSPHERE

/obj/machinery/disposal
	icon = 'icons/obj/atmospherics/pipes/disposal.dmi'
	anchored = 1
	density = 1
	on_blueprints = TRUE
	armor = list(melee = 25, bullet = 10, laser = 10, energy = 100, bomb = 0, bio = 100, rad = 100, fire = 90, acid = 30)
	obj_integrity = 200
	max_integrity = 200
	resistance_flags = FIRE_PROOF
	var/datum/gas_mixture/air_contents	// internal reservoir
	var/mode = PRESSURE_ON
	var/flush = 0	// true if flush handle is pulled
	var/obj/structure/disposalpipe/trunk/trunk = null // the attached pipe trunk
	var/flushing = 0	// true if flushing in progress
	var/flush_every_ticks = 30 //Every 30 ticks it will look whether it is ready to flush
	var/flush_count = 0 //this var adds 1 once per tick. When it reaches flush_every_ticks it resets and tries to flush.
	var/last_sound = 0
	var/obj/structure/disposalconstruct/stored
	// create a new disposal
	// find the attached trunk (if present) and init gas resvr.

/obj/machinery/disposal/New(loc, var/obj/structure/disposalconstruct/make_from)
	..()

	if(make_from)
		setDir(make_from.dir)
		make_from.forceMove(0)
		stored = make_from
	else
		stored = new /obj/structure/disposalconstruct(0,DISP_END_BIN,dir)

	trunk_check()

	air_contents = new/datum/gas_mixture()
	//gas.volume = 1.05 * CELLSTANDARD
	update_icon()

/obj/machinery/disposal/proc/trunk_check()
	trunk = locate() in loc
	if(!trunk)
		mode = PRESSURE_OFF
		flush = 0
	else
		if(initial(mode))
			mode = PRESSURE_ON
		flush = initial(flush)
		trunk.linked = src // link the pipe trunk to self

/obj/machinery/disposal/Destroy()
	eject()
	if(trunk)
		trunk.linked = null
	return ..()

/obj/machinery/disposal/singularity_pull(S, current_size)
	if(current_size >= STAGE_FIVE)
		deconstruct()

/obj/machinery/disposal/Initialize(mapload)
	. = mapload	//late-initialize, we need turfs to have air
	if(initialized)	//will only be run on late mapload initialization
		//this will get a copy of the air turf and take a SEND PRESSURE amount of air from it
		var/atom/L = loc
		var/datum/gas_mixture/env = new
		env.copy_from(L.return_air())
		var/datum/gas_mixture/removed = env.remove(SEND_PRESSURE + 1)
		air_contents.merge(removed)
		trunk_check()
	else
		..()

/obj/machinery/disposal/attackby(obj/item/I, mob/user, params)
	add_fingerprint(user)
	if(mode != PRESSURE_ON && mode != PRESSURE_MAXED && !flush)
		if(istype(I, /obj/item/weapon/screwdriver))
			if(mode == PRESSURE_OFF)
				mode = SCREWS_OUT
			else
				mode = PRESSURE_OFF
			playsound(src.loc, I.usesound, 50, 1)
			to_chat(user, "<span class='notice'>You [mode == SCREWS_OUT ? "remove":"attach"] the screws around the power connection.</span>")
			return
		else if(istype(I,/obj/item/weapon/weldingtool) && mode == SCREWS_OUT)
			var/obj/item/weapon/weldingtool/W = I
			if(W.remove_fuel(0,user))
				playsound(src.loc, 'sound/items/Welder2.ogg', 100, 1)
				to_chat(user, "<span class='notice'>You start slicing the floorweld off \the [src]...</span>")
				if(do_after(user,20*I.toolspeed, target = src) && mode == SCREWS_OUT)
					if(!W.isOn())
						return
					to_chat(user, "<span class='notice'>You slice the floorweld off \the [src].</span>")
					deconstruct()
			return

	if(user.a_intent != INTENT_HARM)
		if(!user.drop_item() || (I.flags & ABSTRACT))
			return
		place_item_in_disposal(I, user)
		update_icon()
		return 1 //no afterattack
	else
		return ..()

/obj/machinery/disposal/proc/place_item_in_disposal(obj/item/I, mob/user)
	I.forceMove(src)
	user.visible_message("[user.name] places \the [I] into \the [src].", "<span class='notice'>You place \the [I] into \the [src].</span>")

//mouse drop another mob or self
/obj/machinery/disposal/MouseDrop_T(mob/living/target, mob/living/user)
	if(istype(target))
		stuff_mob_in(target, user)

/obj/machinery/disposal/proc/stuff_mob_in(mob/living/target, mob/living/user)
	if(!iscarbon(user) && !user.ventcrawler) //only carbon and ventcrawlers can climb into disposal by themselves.
		return
	if(!isturf(user.loc)) //No magically doing it from inside closets
		return
	if(target.buckled || target.has_buckled_mobs())
		return
	if(target.mob_size > MOB_SIZE_HUMAN)
		to_chat(user, "<span class='warning'>[target] doesn't fit inside [src]!</span>")
		return
	add_fingerprint(user)
	if(user == target)
		user.visible_message("[user] starts climbing into [src].", "<span class='notice'>You start climbing into [src]...</span>")
	else
		target.visible_message("<span class='danger'>[user] starts putting [target] into [src].</span>", "<span class='userdanger'>[user] starts putting you into [src]!</span>")
	if(do_mob(user, target, 20))
		if (!loc)
			return
		target.forceMove(src)
		if(user == target)
			user.visible_message("[user] climbs into [src].", "<span class='notice'>You climb into [src].</span>")
		else
			target.visible_message("<span class='danger'>[user] has placed [target] in [src].</span>", "<span class='userdanger'>[user] has placed [target] in [src].</span>")
			add_logs(user, target, "stuffed", addition="into [src]")
			target.LAssailant = user
		update_icon()

/obj/machinery/disposal/relaymove(mob/user)
	attempt_escape(user)

// resist to escape the bin
/obj/machinery/disposal/container_resist(mob/living/user)
	attempt_escape(user)

/obj/machinery/disposal/proc/attempt_escape(mob/user)
	if(flushing)
		return
	go_out(user)

// leave the disposal
/obj/machinery/disposal/proc/go_out(mob/user)
	user.forceMove(loc)
	update_icon()

// monkeys and xenos can only pull the flush lever
/obj/machinery/disposal/attack_paw(mob/user)
	if(stat & BROKEN)
		return
	flush = !flush
	update_icon()

// ai as human but can't flush
/obj/machinery/disposal/attack_ai(mob/user)
	interact(user, 1)

// human interact with machine
/obj/machinery/disposal/attack_hand(mob/user)
	if(user && user.loc == src)
		to_chat(usr, "<span class='warning'>You cannot reach the controls from inside!</span>")
		return
	interact(user, 0)

// eject the contents of the disposal unit
/obj/machinery/disposal/proc/eject()
	var/turf/T = get_turf(src)
	for(var/atom/movable/AM in src)
		AM.forceMove(T)
		AM.pipe_eject(0)
	update_icon()

// update the icon & overlays to reflect mode & status
/obj/machinery/disposal/update_icon()
	return

/obj/machinery/disposal/proc/flush()
	flushing = 1
	flushAnimation()
	sleep(10)
	if(last_sound < world.time + 1)
		playsound(src, 'sound/machines/disposalflush.ogg', 50, 0, 0)
		last_sound = world.time
	sleep(5)
	if(QDELETED(src))
		return
	var/obj/structure/disposalholder/H = new()
	newHolderDestination(H)
	H.init(src)
	air_contents = new()
	H.start(src)
	flushing = 0
	flush = 0

/obj/machinery/disposal/proc/newHolderDestination(obj/structure/disposalholder/H)
	for(var/obj/item/smallDelivery/O in src)
		H.tomail = 1
		return

/obj/machinery/disposal/proc/flushAnimation()
	flick("[icon_state]-flush", src)

// called when area power changes
/obj/machinery/disposal/power_change()
	..()	// do default setting/reset of stat NOPOWER bit
	update_icon()	// update icon

// called when holder is expelled from a disposal
// should usually only occur if the pipe network is modified
/obj/machinery/disposal/proc/expel(obj/structure/disposalholder/H)
	var/turf/T = get_turf(src)
	var/turf/target
	playsound(src, 'sound/machines/hiss.ogg', 50, 0, 0)
	if(H) // Somehow, someone managed to flush a window which broke mid-transit and caused the disposal to go in an infinite loop trying to expel null, hopefully this fixes it
		for(var/atom/movable/AM in H)
			target = get_offset_target_turf(src.loc, rand(5)-rand(5), rand(5)-rand(5))

			AM.forceMove(T)
			AM.pipe_eject(0)
			AM.throw_at(target, 5, 1)

		H.vent_gas(loc)
		qdel(H)

/obj/machinery/disposal/deconstruct(disassembled = TRUE)
	var/turf/T = loc
	if(!(flags & NODECONSTRUCT))
		if(stored)
			stored.forceMove(T)
			src.transfer_fingerprints_to(stored)
			stored.anchored = 0
			stored.density = 1
			stored.update_icon()
	for(var/atom/movable/AM in src) //out, out, darned crowbar!
		AM.forceMove(T)
	..()

//How disposal handles getting a storage dump from a storage object
/obj/machinery/disposal/storage_contents_dump_act(obj/item/weapon/storage/src_object, mob/user)
	for(var/obj/item/I in src_object)
		if(user.s_active != src_object)
			if(I.on_found(user))
				return
		src_object.remove_from_storage(I, src)
	return 1

// Disposal bin
// Holds items for disposal into pipe system
// Draws air from turf, gradually charges internal reservoir
// Once full (~1 atm), uses air resv to flush items into the pipes
// Automatically recharges air (unless off), will flush when ready if pre-set
// Can hold items and human size things, no other draggables

/obj/machinery/disposal/bin
	name = "disposal unit"
	desc = "A pneumatic waste disposal unit."
	icon_state = "disposal"

// attack by item places it in to disposal
/obj/machinery/disposal/bin/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/storage/bag/trash))
		var/obj/item/weapon/storage/bag/trash/T = I
		to_chat(user, "<span class='warning'>You empty the bag.</span>")
		for(var/obj/item/O in T.contents)
			T.remove_from_storage(O,src)
		T.update_icon()
		update_icon()
	else
		return ..()

// handle machine interaction

/obj/machinery/disposal/bin/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = 0, \
									datum/tgui/master_ui = null, datum/ui_state/state = default_state)
	if(stat & BROKEN)
		return
	if(user.loc == src)
		to_chat(user, "<span class='warning'>You cannot reach the controls from inside!</span>")
		return
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "disposal_unit", name, 300, 200, master_ui, state)
		ui.open()

/obj/machinery/disposal/bin/ui_data(mob/user)
	var/list/data = list()
	data["flush"] = flush
	data["mode"] = mode
	var/per = Clamp(100* air_contents.return_pressure() / (SEND_PRESSURE), 0, 100)
	data["per"] = round(per, 1)
	data["isai"] = isAI(user)
	return data

/obj/machinery/disposal/bin/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("handle-0")
			flush = 0
			update_icon()
			. = TRUE
		if("handle-1")
			if(mode != SCREWS_OUT)
				flush = 1
				update_icon()
			. = TRUE
		if("pump-0")
			if(mode == PRESSURE_ON)
				mode = PRESSURE_OFF
				update_icon()
			. = TRUE
		if("pump-1")
			if(mode == PRESSURE_OFF)
				mode = PRESSURE_ON
				update_icon()
			. = TRUE
		if("eject")
			eject()
			. = TRUE

/obj/machinery/disposal/bin/CanPass(atom/movable/mover, turf/target, height=0)
	if (istype(mover,/obj/item) && mover.throwing)
		var/obj/item/I = mover
		if(istype(I, /obj/item/projectile))
			return
		if(prob(75))
			I.forceMove(src)
			visible_message("<span class='notice'>\the [I] lands in \the [src].</span>")
			update_icon()
		else
			visible_message("<span class='notice'>\the [I] bounces off of \the [src]'s rim!</span>")
		return 0
	else
		return ..(mover, target, height)

/obj/machinery/disposal/bin/flush()
	..()
	if(mode == PRESSURE_MAXED)
		mode = PRESSURE_ON
	update_icon()

/obj/machinery/disposal/bin/update_icon()
	cut_overlays()
	if(stat & BROKEN)
		mode = PRESSURE_OFF
		flush = 0
		return

	//flush handle
	if(flush)
		add_overlay(image('icons/obj/atmospherics/pipes/disposal.dmi', "dispover-handle"))

	//only handle is shown if no power
	if(stat & NOPOWER || mode == SCREWS_OUT)
		return

	//check for items in disposal - occupied light
	if(contents.len > 0)
		add_overlay(image('icons/obj/atmospherics/pipes/disposal.dmi', "dispover-full"))

	//charging and ready light
	if(mode == PRESSURE_ON)
		add_overlay(image('icons/obj/atmospherics/pipes/disposal.dmi', "dispover-charge"))
	else if(mode == PRESSURE_MAXED)
		add_overlay(image('icons/obj/atmospherics/pipes/disposal.dmi', "dispover-ready"))

//timed process
//charge the gas reservoir and perform flush if ready
/obj/machinery/disposal/bin/process()
	if(stat & BROKEN) //nothing can happen if broken
		return

	flush_count++
	if(flush_count >= flush_every_ticks)
		if(contents.len)
			if(mode == PRESSURE_MAXED)
				spawn(0)
					feedback_inc("disposal_auto_flush",1)
					flush()
		flush_count = 0

	updateDialog()

	if(flush && air_contents.return_pressure() >= SEND_PRESSURE) // flush can happen even without power
		addtimer(CALLBACK(src, .proc/flush), 0)

	if(stat & NOPOWER) // won't charge if no power
		return

	use_power(100) // base power usage

	if(mode != PRESSURE_ON) // if off or ready, no need to charge
		return

	// otherwise charge
	use_power(500) // charging power usage

	var/atom/L = loc //recharging from loc turf

	var/datum/gas_mixture/env = L.return_air()
	var/pressure_delta = (SEND_PRESSURE*1.01) - air_contents.return_pressure()

	if(env.temperature > 0)
		var/transfer_moles = 0.1 * pressure_delta*air_contents.volume/(env.temperature * R_IDEAL_GAS_EQUATION)

		//Actually transfer the gas
		var/datum/gas_mixture/removed = env.remove(transfer_moles)
		air_contents.merge(removed)
		air_update_turf()


	//if full enough, switch to ready mode
	if(air_contents.return_pressure() >= SEND_PRESSURE)
		mode = PRESSURE_MAXED
		update_icon()
	return

/obj/machinery/disposal/bin/get_remote_view_fullscreens(mob/user)
	if(user.stat == DEAD || !(user.sight & (SEEOBJS|SEEMOBS)))
		user.overlay_fullscreen("remote_view", /obj/screen/fullscreen/impaired, 2)

//Delivery Chute

/obj/machinery/disposal/deliveryChute
	name = "delivery chute"
	desc = "A chute for big and small packages alike!"
	density = 1
	icon_state = "intake"
	mode = PRESSURE_OFF // the chute doesn't need charging and always works

/obj/machinery/disposal/deliveryChute/New(loc,var/obj/structure/disposalconstruct/make_from)
	..()
	stored.ptype = DISP_END_CHUTE
	spawn(5)
		trunk = locate() in loc
		if(trunk)
			trunk.linked = src	// link the pipe trunk to self

/obj/machinery/disposal/deliveryChute/place_item_in_disposal(obj/item/I, mob/user)
	if(I.disposalEnterTry())
		..()
		flush()

/obj/machinery/disposal/deliveryChute/Bumped(atom/movable/AM) //Go straight into the chute
	if(!AM.disposalEnterTry())
		return
	switch(dir)
		if(NORTH)
			if(AM.loc.y != loc.y+1) return
		if(EAST)
			if(AM.loc.x != loc.x+1) return
		if(SOUTH)
			if(AM.loc.y != loc.y-1) return
		if(WEST)
			if(AM.loc.x != loc.x-1) return

	if(isobj(AM))
		var/obj/O = AM
		O.forceMove(src)
	else if(istype(AM, /mob))
		var/mob/M = AM
		if(prob(2)) // to prevent mobs being stuck in infinite loops
			to_chat(M, "<span class='warning'>You hit the edge of the chute.</span>")
			return
		M.forceMove(src)
	flush()

/atom/movable/proc/disposalEnterTry()
	return 1

/obj/item/projectile/disposalEnterTry()
	return

/obj/effect/disposalEnterTry()
	return

/obj/mecha/disposalEnterTry()
	return

/obj/machinery/disposal/deliveryChute/newHolderDestination(obj/structure/disposalholder/H)
	H.destinationTag = 1
