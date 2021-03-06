/obj/item/weapon/grenade
	name = "grenade"
	desc = "It has an adjustable timer."
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/grenade.dmi'
	icon_state = "grenade"
	item_state = "flashbang"
	throw_speed = 3
	throw_range = 7
	flags = CONDUCT
	slot_flags = SLOT_BELT
	resistance_flags = FLAMMABLE
	obj_integrity = 40
	max_integrity = 40
	var/active = 0
	var/det_time = 50
	var/display_timer = 1

/obj/item/weapon/grenade/deconstruct(disassembled = TRUE)
	if(!disassembled)
		prime()
	if(!QDELETED(src))
		qdel(src)

/obj/item/weapon/grenade/proc/clown_check(mob/living/carbon/human/user)
	if(user.disabilities & CLUMSY && prob(50))
		to_chat(user, "<span class='warning'>Huh? How does this thing work?</span>")
		active = 1
		icon_state = initial(icon_state) + "_active"
		playsound(loc, 'sound/weapons/armbomb.ogg', 75, 1, -3)
		spawn(5)
			if(user)
				user.drop_item()
			prime()
		return 0
	return 1


/obj/item/weapon/grenade/examine(mob/user)
	..()
	if(display_timer)
		if(det_time > 1)
			to_chat(user, "The timer is set to [det_time/10] second\s.")
		else
			to_chat(user, "\The [src] is set for instant detonation.")


/obj/item/weapon/grenade/attack_self(mob/user)
	if(!active)
		if(clown_check(user))
			//var/mob/living/carbon/human/humanUser = user
			//det_time = det_time / (30 - 2.9 * (humanUser.skills.getPoint("explosives")))
			to_chat(user, "<span class='warning'>You prime the [name]! [det_time/10] seconds!</span>")
			playsound(user.loc, 'sound/weapons/armbomb.ogg', 60, 1)
			active = 1

			/*var/mob/living/carbon/human/humanUser = user
			if(prob(100 - humanUser.skills.getPoint("explosives") * 9 - humanUser.special.getPoint("l")))
				det_time = det_time / (30 - 2.9 * (humanUser.skills.getPoint("explosives")))
			*/
			icon_state = initial(icon_state) + "_active"
			add_fingerprint(user)
			var/turf/bombturf = get_turf(src)
			var/area/A = get_area(bombturf)
			var/message = "[ADMIN_LOOKUPFLW(user)]) активирует детонацию [name] в [ADMIN_COORDJMP(bombturf)]"
			bombers += message
			message_admins(message)
			log_game("[key_name(usr)] has primed a [name] for detonation at [A.name] [COORD(bombturf)].")
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.throw_mode_on()
			spawn(det_time)
				prime()


/obj/item/weapon/grenade/proc/prime()

/obj/item/weapon/grenade/proc/update_mob()
	if(ismob(loc))
		var/mob/M = loc
		M.unEquip(src)


/obj/item/weapon/grenade/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/weapon/screwdriver))
		switch(det_time)
			if ("1")
				det_time = 10
				to_chat(user, "<span class='notice'>You set the [name] for 1 second detonation time.</span>")
			if ("10")
				det_time = 30
				to_chat(user, "<span class='notice'>You set the [name] for 3 second detonation time.</span>")
			if ("30")
				det_time = 50
				to_chat(user, "<span class='notice'>You set the [name] for 5 second detonation time.</span>")
			if ("50")
				det_time = 1
				to_chat(user, "<span class='notice'>You set the [name] for instant detonation.</span>")
		add_fingerprint(user)
	else
		return ..()

/obj/item/weapon/grenade/attack_hand()
	walk(src, null, null)
	..()

/obj/item/weapon/grenade/attack_paw(mob/user)
	return attack_hand(user)

/obj/item/weapon/grenade/hit_reaction(mob/living/carbon/human/owner, attack_text, final_block_chance, damage, attack_type)
	if(damage && attack_type == PROJECTILE_ATTACK && prob(15))
		owner.visible_message("<span class='danger'>[attack_text] hits [owner]'s [src], setting it off! What a shot!</span>")
		prime()
		return 1 //It hit the grenade, not them