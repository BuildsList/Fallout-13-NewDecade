/obj/structure/closet/crate
	name = "ящик"
	desc = "A rectangular steel crate."
	icon = 'icons/obj/crates.dmi'
	icon_state = "crate"
	req_access = null
	can_weld_shut = FALSE
	horizontal = TRUE
	allow_objects = TRUE
	allow_dense = TRUE
	dense_when_open = TRUE
	climbable = TRUE
	self_weight = 10
	climb_time = 10 //real fast, because let's be honest stepping into or onto a crate is easy
	climb_stun = 0 //climbing onto crates isn't hard, guys
	delivery_icon = "deliverycrate"
	open_sound = 'sound/machines/crate_open.ogg'
	close_sound = 'sound/machines/crate_close.ogg'
	open_sound_volume = 35
	close_sound_volume = 50
	var/obj/item/weapon/paper/manifest/manifest

/obj/structure/closet/crate/New()
	..()
	update_icon()

/obj/structure/closet/crate/CanPass(atom/movable/mover, turf/target, height=0)
	if(!istype(mover, /obj/structure/closet))
		var/obj/structure/closet/crate/locatedcrate = locate(/obj/structure/closet/crate) in get_turf(mover)
		if(locatedcrate) //you can walk on it like tables, if you're not in an open crate trying to move to a closed crate
			if(opened) //if we're open, allow entering regardless of located crate openness
				return 1
			if(!locatedcrate.opened) //otherwise, if the located crate is closed, allow entering
				return 1
	return !density

/obj/structure/closet/crate/update_icon()
	icon_state = "[initial(icon_state)][opened ? "open" : ""]"

	cut_overlays()
	if(manifest)
		add_overlay("manifest")

/obj/structure/closet/crate/attack_hand(mob/user)
	if(manifest)
		tear_manifest(user)
		return
	..()

/obj/structure/closet/crate/open(mob/living/user)
	. = ..()
	if(. && manifest)
		to_chat(user, "<span class='notice'>The manifest is torn off [src].</span>")
		playsound(src, 'sound/items/poster_ripped.ogg', 75, 1)
		manifest.forceMove(get_turf(src))
		manifest = null
		update_icon()

/obj/structure/closet/crate/proc/tear_manifest(mob/user)
	to_chat(user, "<span class='notice'>You tear the manifest off of [src].</span>")
	playsound(src, 'sound/items/poster_ripped.ogg', 75, 1)

	manifest.forceMove(loc)
	if(ishuman(user))
		user.put_in_hands(manifest)
	manifest = null
	update_icon()

/obj/structure/closet/crate/cardboxsmall
	name = "картонная коробка"
	desc = "обычная коробка из картона."
	icon = 'icons/fallout/objects/crates.dmi'
	icon_state = "vb_crate"
	density = 1
	self_weight = 50

/obj/structure/closet/crate/cardboxsmall
	name = "картонная коробка"
	desc = "обычная коробка из картона."
	icon = 'icons/fallout/objects/crates.dmi'
	icon_state = "smallbox"
	density = 0
	self_weight = 0.5

/obj/structure/closet/crate/vault_compact
	name = "компактный ящик Волт-Тек"
	desc = "A rectangular blue steel vault crate."
	icon = 'icons/fallout/objects/crates.dmi'
	icon_state = "vault_clean_c"

/obj/structure/closet/crate/vault_compact/rusted
	name = "ржавый компактный ящик Волт-Тек"
	desc = "A rectangular blue steel vault crate."
	icon = 'icons/fallout/objects/crates.dmi'
	icon_state = "vault_rusted_c"

/obj/structure/closet/crate/vault_blue
	name = "ящик Волт-Тек"
	desc = "A rectangular blue steel vault crate."
	icon = 'icons/fallout/objects/crates.dmi'
	icon_state = "vault_blue"

/obj/structure/closet/crate/vault_yellow
	name = "ржавый ящик Волт-Тек"
	desc = "A rectangular yellow steel vault crate."
	icon = 'icons/fallout/objects/crates.dmi'
	icon_state = "vault_yellow"

/obj/structure/closet/crate/orange
	name = "оранжевый ящик"
	desc = "A rectangular orange steel crate."
	icon = 'icons/fallout/objects/crates.dmi'
	icon_state = "orange"

/obj/structure/closet/crate/mil_crate
	name = "полевой контейнер"
	desc = "A rectangular mil steel crate."
	icon = 'icons/fallout/objects/crates.dmi'
	icon_state = "mil_crate"

/obj/structure/closet/crate/blue
	name = "голубой ящик"
	desc = "A rectangular blue steel crate."
	icon = 'icons/fallout/objects/crates.dmi'
	icon_state = "blue"

/obj/structure/closet/crate/handmadecrate
	name = "самодельный ящик"
	desc = "A rectangular handmade steel crate."
	icon = 'icons/fallout/objects/crates.dmi'
	icon_state = "handmadecrate"

/obj/structure/closet/crate/cratebloody
	name = "окровавленный ящик"
	desc = "A rectangular bloody steel crate."
	icon = 'icons/fallout/objects/crates.dmi'
	icon_state = "cratebloody"

/obj/structure/closet/crate/internals
	desc = "A internals crate."
	name = "internals crate"
	icon_state = "o2crate"

/obj/structure/closet/crate/trashcart
	desc = "A heavy, metal trashcart with wheels."
	name = "trash cart"
	icon_state = "trashcart"

/obj/structure/closet/crate/medical
	desc = "медициский ящик."
	name = "medical crate"
	icon_state = "medicalcrate"

/obj/structure/closet/crate/freezer/blood
	name = "холодильник для крови"
	desc = "A freezer containing packs of blood."

/obj/structure/closet/crate/freezer/blood/New()
	. = ..()
	new /obj/item/weapon/reagent_containers/blood/empty(src)
	new /obj/item/weapon/reagent_containers/blood/empty(src)
	new /obj/item/weapon/reagent_containers/blood/AMinus(src)
	new /obj/item/weapon/reagent_containers/blood/BMinus(src)
	new /obj/item/weapon/reagent_containers/blood/BPlus(src)
	new /obj/item/weapon/reagent_containers/blood/OMinus(src)
	new /obj/item/weapon/reagent_containers/blood/OPlus(src)
	new /obj/item/weapon/reagent_containers/blood/lizard(src)
	for(var/i in 1 to 3)
		new /obj/item/weapon/reagent_containers/blood/random(src)

/obj/structure/closet/crate/freezer/surplus_limbs
	name = "surplus prosthetic limbs"
	desc = "A crate containing an assortment of cheap prosthetic limbs."

/obj/structure/closet/crate/freezer/surplus_limbs/New()
	. = ..()
	new /obj/item/bodypart/l_arm/robot/surplus(src)
	new /obj/item/bodypart/l_arm/robot/surplus(src)
	new /obj/item/bodypart/r_arm/robot/surplus(src)
	new /obj/item/bodypart/r_arm/robot/surplus(src)
	new /obj/item/bodypart/l_leg/robot/surplus(src)
	new /obj/item/bodypart/l_leg/robot/surplus(src)
	new /obj/item/bodypart/r_leg/robot/surplus(src)
	new /obj/item/bodypart/r_leg/robot/surplus(src)

/obj/structure/closet/crate/radiation
	desc = "A crate with a radiation sign on it."
	name = "ящик для опасных материалов"
	icon_state = "radiation"

/obj/structure/closet/crate/hydroponics
	name = "hydroponics crate"
	desc = "All you need to destroy those pesky weeds and pests."
	icon_state = "hydrocrate"

/obj/structure/closet/crate/engineering
	name = "инженерный ящик"
	icon_state = "engi_crate"

/obj/structure/closet/crate/engineering/electrical
	icon_state = "engi_e_crate"

/obj/structure/closet/crate/rcd
	desc = "A crate for the storage of an RCD."
	name = "\improper RCD crate"
	icon_state = "engi_crate"

/obj/structure/closet/crate/rcd/New()
	..()
	for(var/i in 1 to 4)
		new /obj/item/weapon/rcd_ammo(src)
	new /obj/item/weapon/rcd(src)
