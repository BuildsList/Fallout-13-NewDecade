
/obj/item/bodybag
	name = "мешок для тел"
	desc = "A folded bag designed for the storage and transportation of cadavers."
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "bodybag_folded"
	var/unfoldedbag_path = /obj/structure/closet/body_bag
	w_class = WEIGHT_CLASS_SMALL

/obj/item/bodybag/attack_self(mob/user)
	deploy_bodybag(user, user.loc)

/obj/item/bodybag/afterattack(atom/target, mob/user, proximity)
	if(proximity)
		if(isopenturf(target))
			deploy_bodybag(user, target)

/obj/item/bodybag/proc/deploy_bodybag(mob/user, atom/location)
	var/obj/structure/closet/body_bag/R = new unfoldedbag_path(location)
	R.open(user)
	R.add_fingerprint(user)
	qdel(src)

/obj/item/weapon/storage/box/bodybags
	name = "body bags"
	desc = "The label indicates that it contains body bags."
	icon_state = "bodybags"

/obj/item/weapon/storage/box/bodybags/New()
	..()
	for(var/i in 1 to 7)
		new /obj/item/bodybag(src)


// Bluespace bodybag

/obj/item/bodybag/bluespace
	name = "bluespace body bag"
	desc = "A folded bluespace body bag designed for the storage and transportation of cadavers."
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "bluebodybag_folded"
	unfoldedbag_path = /obj/structure/closet/body_bag/bluespace
	w_class = WEIGHT_CLASS_SMALL
	origin_tech = "bluespace=4;materials=4;plasmatech=4"

/obj/item/bodybag/bluespace/examine(mob/user)
	..()
	if(contents.len)
		user << "<span class='notice'>You can make out the shapes of [contents.len] objects through the fabric.</span>"

/obj/item/bodybag/bluespace/Destroy()
	for(var/atom/movable/A in contents)
		A.forceMove(get_turf(src))
		if(isliving(A))
			A << "<span class='notice'>You suddenly feel the space around you torn apart! You're free!</span>"
	return ..()

/obj/item/bodybag/bluespace/deploy_bodybag(mob/user, atom/location)
	var/obj/structure/closet/body_bag/R = new unfoldedbag_path(location)
	for(var/atom/movable/A in contents)
		A.forceMove(R)
		if(isliving(A))
			A << "<span class='notice'>You suddenly feel air around you! You're free!</span>"
	R.open(user)
	R.add_fingerprint(user)
	qdel(src)

/obj/item/bodybag/bluespace/container_resist(mob/living/user)
	if(user.incapacitated())
		user << "<span class='warning'>You can't get out while you're restrained like this!</span>"
		return
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user << "<span class='notice'>You claw at the fabric of [src], trying to tear it open...</span>"
	loc << "<span class='warning'>Someone starts trying to break free of [src]!</span>"
	if(!do_after(user, 200, target = src))
		loc << "<span class='warning'>The pressure subsides. It seems that they've stopped resisting...</span>"
		return
	loc.visible_message("<span class='warning'>[user] suddenly appears in front of [loc]!</span>", "<span class='userdanger'>[user] breaks free of [src]!</span>")
	qdel(src)