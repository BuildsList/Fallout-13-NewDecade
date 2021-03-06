//GUNCASES//
/obj/structure/guncase
	name = "gun locker"
	desc = "A locker that holds guns."
	icon = 'icons/obj/closet.dmi'
	icon_state = "shotguncase"
	anchored = 0
	density = 1
	opacity = 0
	var/case_type = null
	var/gun_category = /obj/item/weapon/gun
	var/open = 1
	var/capacity = 4

/obj/structure/guncase/Initialize(mapload)
	..()
	if(mapload)
		for(var/obj/item/I in loc.contents)
			if(istype(I, gun_category))
				I.loc = src
			if(contents.len >= capacity)
				break
	update_icon()

/obj/structure/guncase/update_icon()
	cut_overlays()
	for(var/i = contents.len, i >= 1, i--)
		add_overlay(image(icon = src.icon, icon_state = "[case_type]", pixel_x = 4 * (i -1) ))
	if(open)
		add_overlay("[icon_state]_open")
	else
		add_overlay("[icon_state]_door")

/obj/structure/guncase/attackby(obj/item/I, mob/user, params)
	if(iscyborg(user) || isalien(user))
		return
	if(istype(I, gun_category))
		if(contents.len < capacity && open)
			if(!user.drop_item())
				return
			contents += I
			to_chat(user, "<span class='notice'>You place [I] in [src].</span>")
			update_icon()
			return

	else if(user.a_intent != INTENT_HARM)
		open = !open
		update_icon()
	else
		return ..()

/obj/structure/guncase/attack_hand(mob/user)
	if(iscyborg(user) || isalien(user))
		return
	if(contents.len && open)
		ShowWindow(user)
	else
		open = !open
		update_icon()

/obj/structure/guncase/proc/ShowWindow(mob/user)
	var/dat = {"<meta charset="UTF-8">"}
	dat += {"<div class='block'>
				<h3>Stored Guns</h3>
				<table align='center'>"}
	for(var/i = contents.len, i >= 1, i--)
		var/obj/item/I = contents[i]
		dat += "<tr><A href='?src=\ref[src];retrieve=\ref[I]'>[I.name]</A><br>"
	dat += "</table></div>"

	var/datum/browser/popup = new(user, "gunlocker", "<div align='center'>[name]</div>", 350, 300)
	popup.set_content(dat)
	popup.open(0)

/obj/structure/guncase/Topic(href, href_list)
	if(href_list["retrieve"])
		var/obj/item/O = locate(href_list["retrieve"]) in contents
		if(!O || !istype(O))
			return
		if(!usr.canUseTopic(src))
			return
		if(ishuman(usr))
			if(!usr.put_in_hands(O))
				O.forceMove(get_turf(src))
			update_icon()

/obj/structure/guncase/handle_atom_del(atom/A)
	update_icon()

/obj/structure/guncase/contents_explosion(severity, target)
	for(var/atom/A in contents)
		A.ex_act(severity++, target)
		CHECK_TICK

/obj/structure/guncase/shotgun
	name = "shotgun locker"
	desc = "A locker that holds shotguns."
	case_type = "shotgun"
	gun_category = /obj/item/weapon/gun/ballistic/shotgun

/obj/structure/guncase/ecase
	name = "energy gun locker"
	desc = "A locker that holds energy guns."
	icon_state = "ecase"
	case_type = "egun"
	gun_category = /obj/item/weapon/gun/energy/e_gun

/obj/structure/new_closet
	name = "locker"
	desc = "A locker that holds things."
	icon = 'icons/obj/closet.dmi'
	icon_state = "shotguncase"
	anchored = 0
	density = 1
	opacity = 0
	var/item_type = null
	var/item_category = /obj/item/weapon/gun
	var/open = 1
	var/capacity = 4

/obj/structure/new_closet/Initialize(mapload)
	..()
	if(mapload)
		for(var/obj/item/I in loc.contents)
			if(istype(I, item_category))
				I.loc = src
			if(contents.len >= capacity)
				break
	update_icon()

/obj/structure/new_closet/update_icon()
	cut_overlays()
	for(var/i = Ceiling(contents.len, 10), i >= 1, i--)
		add_overlay(image(icon = src.icon, icon_state = "[item_type]", pixel_x = 4 * (i -1) ))
	if(open)
		add_overlay("[icon_state]_open")
	else
		add_overlay("[icon_state]_door")

/obj/structure/new_closet/attackby(obj/item/I, mob/user, params)
	if(iscyborg(user) || isalien(user))
		return
	if(istype(I, item_category))
		if(contents.len < capacity && open)
			if(!user.drop_item())
				return
			contents += I
			to_chat(user, "<span class='notice'>You place [I] in [src].</span>")
			update_icon()
			return

	else if(user.a_intent != INTENT_HARM)
		open = !open
		update_icon()
	else
		return ..()

/obj/structure/new_closet/attack_hand(mob/user)
	if(iscyborg(user) || isalien(user))
		return
	if(contents.len && open)
		ShowWindow(user)
	else
		open = !open
		update_icon()

/obj/structure/new_closet/proc/ShowWindow(mob/user)
	var/dat = {"<meta charset="UTF-8">"}
	dat += {"<div class='block'>
				<h3>???????????????? ????????????</h3>
				<table align='center'>"}
	for(var/i = contents.len, i >= 1, i--)
		var/obj/item/I = contents[i]
		dat += "<tr><A href='?src=\ref[src];retrieve=\ref[I]'>[I.name]</A><br>"
	dat += "</table></div>"

	var/datum/browser/popup = new(user, "gunlocker", "<div align='center'>[name]</div>", 350, 300)
	popup.set_content(dat)
	popup.open(0)

/obj/structure/new_closet/Topic(href, href_list)
	if(href_list["retrieve"])
		var/obj/item/O = locate(href_list["retrieve"]) in contents
		if(!O || !istype(O))
			return
		if(!usr.canUseTopic(src))
			return
		if(ishuman(usr))
			if(!usr.put_in_hands(O))
				O.forceMove(get_turf(src))
			update_icon()

/obj/structure/new_closet/handle_atom_del(atom/A)
	update_icon()

/obj/structure/new_closet/contents_explosion(severity, target)
	for(var/atom/A in contents)
		A.ex_act(severity++, target)
		CHECK_TICK

/obj/structure/new_closet/eatotronic3000
	name = "??????-???????? 3000"
	desc = "?????????????? ???????????????????? ?? ???????? ??????????????????."
	icon_state = "eatotronic3000"
	item_type = "eatotronic3000_full"
	item_category = /obj/item/weapon/reagent_containers/food
	anchored = 1
	density = 0
	open = 0

/obj/structure/new_closet/dresser
	name = "??????????"
	desc = "?????????? ?????????????? ?????????? ?????????????????? ????????."
	icon_state = "dresser"
	item_type = "dresser_full"
	item_category = /obj/item
	anchored = 1
	density = 1
	open = 0