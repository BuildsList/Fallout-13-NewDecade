/obj/structure
	icon = 'icons/obj/structures.dmi'
	pressure_resistance = 8
	obj_integrity = 300
	max_integrity = 300
	var/climb_time = 20
	var/climb_stun = 2
	var/climbable = FALSE
	var/mob/structureclimber
	var/broken = 0 //similar to machinery's stat BROKEN

/obj/structure/New()
	if (!armor)
		armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 50, acid = 50)
	..()
	if(smooth)
		queue_smooth(src)
		queue_smooth_neighbors(src)
		icon_state = ""
	if(ticker)
		cameranet.updateVisibility(src)

/obj/structure/Destroy()
	if(ticker)
		cameranet.updateVisibility(src)
	if(smooth)
		queue_smooth_neighbors(src)
	return ..()

/obj/structure/attack_hand(mob/user)
	. = ..()
	add_fingerprint(user)
	if(structureclimber && structureclimber != user)
		user.changeNext_move(CLICK_CD_MELEE)
		user.do_attack_animation(src)
		structureclimber.Weaken(2)
		structureclimber.visible_message("<span class='warning'>[structureclimber.name] has been knocked off the [src]", "You're knocked off the [src]!", "You see [structureclimber.name] get knocked off the [src]</span>")
	interact(user)

/obj/structure/interact(mob/user)
	ui_interact(user)

/obj/structure/ui_act(action, params)
	..()
	add_fingerprint(usr)

/obj/structure/MouseDrop_T(atom/movable/O, mob/user)
	. = ..()
	if(!climbable)
		return
	if(ismob(O) && user == O && iscarbon(user))
		if(user.canmove)
			climb_structure(user)
			return
	if ((!( istype(O, /obj/item/weapon) ) || user.get_active_held_item() != O))
		return
	if(iscyborg(user))
		return
	if(!user.drop_item())
		return
	if (O.loc != src.loc)
		step(O, get_dir(O, src))
	return

/obj/structure/proc/do_climb(atom/movable/A)
	if(climbable)
		density = 0
		. = step(A,get_dir(A,src.loc))
		density = 1
		return TRUE
	else
		return FALSE

/obj/structure/proc/climb_structure(mob/user)
	src.add_fingerprint(user)
	user.visible_message("<span class='warning'>[user] начинает забираться на [src].</span>", \
								"<span class='notice'>Вы начали забираться на[src]...</span>")
	var/adjusted_climb_time = climb_time
	if(user.restrained()) //climbing takes twice as long when restrained.
		adjusted_climb_time *= 2
	if(isalien(user))
		adjusted_climb_time *= 0.25 //aliens are terrifyingly fast
	structureclimber = user
	if(do_mob(user, user, adjusted_climb_time))
		if(src.loc) //Checking if structure has been destroyed
			if(do_climb(user))
				user.visible_message("<span class='warning'>[user] забирается на [src].</span>", \
									"<span class='notice'>Вы забрались на [src].</span>")
				add_logs(user, src, "climbed onto")
				user.Stun(climb_stun)
				. = 1
			else
				to_chat(user, "<span class='warning'>Вы не смогли забраться на [src].</span>")
	structureclimber = null

/obj/structure/examine(mob/user)
	..()
	if(!(resistance_flags & INDESTRUCTIBLE))
		if(resistance_flags & ON_FIRE)
			to_chat(user, "<span class='warning'>It's on fire!</span>")
		if(broken)
			to_chat(user, "<span class='notice'>It looks broken.</span>")
		var/examine_status = examine_status(user)
		if(examine_status)
			to_chat(user, examine_status)

/obj/structure/proc/examine_status(mob/user) //An overridable proc, mostly for falsewalls.
	var/healthpercent = (obj_integrity/max_integrity) * 100
	switch(healthpercent)
		if(50 to 99)
			return  "Выглядит немного повреждённым."
		if(25 to 50)
			return  "Похоже, оно сильно повреждено."
		if(0 to 25)
			return  "<span class='warning'>Похоже, оно вот-вот развалится!</span>"
