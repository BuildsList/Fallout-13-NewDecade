/* Beds... get your mind out of the gutter, they're for sleeping!
 * Contains:
 * 		Beds
 *		Roller beds
 */

/*
 * Beds
 */
/obj/structure/bed
	name = "кровать"
	desc = "This is used to lie in, sleep in or strap on."
	icon_state = "bed"
	icon = 'icons/fallout/objects/structures/furniture.dmi'
	anchored = 1
	can_buckle = 1
	buckle_lying = 1
	resistance_flags = FLAMMABLE
	obj_integrity = 100
	max_integrity = 100
	integrity_failure = 30
	can_crawled = 1
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 2

/obj/structure/bed/deconstruct(disassembled = TRUE)
	if(!(flags & NODECONSTRUCT))
		if(buildstacktype)
			new buildstacktype(loc,buildstackamount)
	..()

/obj/structure/bed/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/bed/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/weapon/wrench) && !(flags&NODECONSTRUCT))
		playsound(src.loc, W.usesound, 50, 1)
		deconstruct(TRUE)
	else
		return ..()

/*
 * Roller beds
 */
/obj/structure/bed/roller
	name = "roller bed"
	icon = 'icons/obj/rollerbed.dmi'
	icon_state = "down"
	anchored = 0
	resistance_flags = 0
	can_crawled = 0
	var/foldabletype = /obj/item/roller

/obj/structure/bed/roller/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W,/obj/item/roller/robo))
		var/obj/item/roller/robo/R = W
		if(R.loaded)
			to_chat(user, "<span class='warning'>You already have a roller bed docked!</span>")
			return

		if(has_buckled_mobs())
			if(buckled_mobs.len > 1)
				unbuckle_all_mobs()
				user.visible_message("<span class='notice'>[user] unbuckles all creatures from [src].</span>")
			else
				user_unbuckle_mob(buckled_mobs[1],user)
		else
			R.loaded = src
			forceMove(R)
			user.visible_message("[user] collects [src].", "<span class='notice'>You collect [src].</span>")
		return 1
	else
		return ..()

/obj/structure/bed/roller/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object == usr && Adjacent(usr))
		if(!ishuman(usr))
			return 0
		if(has_buckled_mobs())
			return 0
		if(usr.incapacitated())
			to_chat(usr, "<span class='warning'>You can't do that right now!</span>")
			return 0
		usr.visible_message("[usr] collapses \the [src.name].", "<span class='notice'>You collapse \the [src.name].</span>")
		var/obj/structure/bed/roller/B = new foldabletype(get_turf(src))
		usr.put_in_hands(B)
		qdel(src)

/obj/structure/bed/roller/post_buckle_mob(mob/living/M)
	if(M in buckled_mobs)
		density = 1
		icon_state = "up"
		M.pixel_y = initial(M.pixel_y)
	else
		density = 0
		icon_state = "down"
		M.pixel_x = M.get_standard_pixel_x_offset(M.lying)
		M.pixel_y = M.get_standard_pixel_y_offset(M.lying)


/obj/item/roller
	name = "roller bed"
	desc = "A collapsed roller bed that can be carried around."
	icon = 'icons/obj/rollerbed.dmi'
	icon_state = "folded"
	w_class = WEIGHT_CLASS_BULKY // Can't be put in backpacks.

/obj/item/roller/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/roller/robo))
		var/obj/item/roller/robo/R = I
		if(R.loaded)
			to_chat(user, "<span class='warning'>[R] already has a roller bed loaded!</span>")
			return
		user.visible_message("<span class='notice'>[user] loads [src].</span>", "<span class='notice'>You load [src] into [R].</span>")
		R.loaded = new/obj/structure/bed/roller(R)
		qdel(src) //"Load"
		return
	else return ..()

/obj/item/roller/attack_self(mob/user)
	deploy_roller(user, user.loc)

/obj/item/roller/afterattack(obj/target, mob/user , proximity)
	if(!proximity)
		return
	if(isopenturf(target))
		deploy_roller(user, target)

/obj/item/roller/proc/deploy_roller(mob/user, atom/location)
	var/obj/structure/bed/roller/R = new /obj/structure/bed/roller(location)
	R.add_fingerprint(user)
	qdel(src)

/obj/item/roller/robo //ROLLER ROBO DA!
	name = "roller bed dock"
	var/loaded = null

/obj/item/roller/robo/New()
	loaded = new /obj/structure/bed/roller(src)
	desc = "A collapsed roller bed that can be ejected for emergency use. Must be collected or replaced after use."
	..()

/obj/item/roller/robo/examine(mob/user)
	..()
	to_chat(user, "The dock is [loaded ? "loaded" : "empty"]")

/obj/item/roller/robo/deploy_roller(mob/user, atom/location)
	if(loaded)
		var/obj/structure/bed/roller/R = loaded
		R.forceMove(location)
		user.visible_message("[user] deploys [loaded].", "<span class='notice'>You deploy [loaded].</span>")
		loaded = null
	else
		to_chat(user, "<span class='warning'>The dock is empty!</span>")

//Dog bed

/obj/structure/bed/dogbed
	name = "dog bed"
	icon_state = "dogbed"
	desc = "A comfy-looking dog bed. You can even strap your pet in, in case the gravity turns off."
	anchored = 0
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 10

/obj/structure/bed/wooden
	name = "деревянная кровать"
	icon_state = "wood_bed"

/obj/structure/bed/bedroll
	name = "походный спальник"
	icon_state = "bedroll"

/obj/structure/bed/bedroll/attack_hand(mob/living/carbon/human/user)
	to_chat(user, "Вы начинаете сворачивать спальное место.")
	if(do_after(user, 25, target = loc))
		new/obj/item/bedroll(get_turf(src))
		qdel(src)

/obj/item/bedroll
	name = "спальник"
	desc = "Простой в использовании спальный мешок."
	icon = 'icons/obj/items.dmi'
	icon_state = "bedroll"

/obj/item/bedroll/attack_self(mob/user)
	to_chat(user, "Вы начинаете разворачивать спальное место.")
	if(do_after(user, 25, target = loc))
		new/obj/structure/bed/bedroll(get_turf(src))
		qdel(src)

/obj/structure/bed/metal
	name = "металлическая кровать"
	icon_state = "metal_bed"

/obj/structure/bed/wire
	name = "металлическая кровать"
	icon_state = "wire_bed"

/obj/structure/bed/wire/rand
	name = "металлическая кровать"
	icon_state = "wire_bed"

/obj/structure/bed/wire/rand/New()
	..()
	icon_state = "wire_bed[rand(1,3)]"

/obj/structure/bed/metal/rand
	name = "металлическая кровать"
	icon_state = "metal_bed"

/obj/structure/bed/metal/rand/New()
	..()
	icon_state = "bed[rand(1,3)]"

/obj/structure/bed/alien
	name = "resting contraption"
	desc = "This looks similar to contraptions from earth. Could aliens be stealing our technology?"
	icon_state = "alienbed"

/obj/structure/bed/mattress
	name = "матрас"
	desc = "A nosy little dummy, are you?<br>A mattress is a large pad for supporting the reclining body, of course most of wasteland dwellers can't afford having a bed, so this is the most common sleeping spot around."
	icon_state = "mattress"

/obj/structure/bed/mattress/pillow
	name = "мягкий матрас"
	desc = "A common soft matress.<br>Most of wasteland dwellers can't afford having a bed, so this is the most common sleeping spot around.<br>Wow, there's a soft pillow on top of it!"
	icon_state = "mattress_pillow"

/obj/structure/bed/mattress/holey
	name = "дырявый матрас"
	desc = "A common, not that soft matress.<br>Someone or something has made a several holes in it."
	icon_state = "mattress_holey"

/obj/structure/bed/mattress/dirty/New()
	..()
	name = "грязный матрас"
	desc = "An awfully smelly, dirty mattress.<br>It has soaked with something foul, so now it smells worse than a ghoul's piss..."
	icon_state = pick("mattress_dirty","mattress_bloody","mattress_dried","mattress_mossy")