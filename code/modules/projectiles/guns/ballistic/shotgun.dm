/obj/item/weapon/gun/ballistic/shotgun
	name = "shotgun"
	desc = "A traditional shotgun with wood furniture and a four-shell capacity underneath."
	icon_state = "shotgun"
	item_state = "shotgun"
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	flags =  CONDUCT
	slot_flags = SLOT_BACK
	origin_tech = "combat=4;materials=2"
	mag_type = /obj/item/ammo_box/magazine/internal/shot
	casing_ejector = 0
	var/recentpump = 0 // to prevent spammage
	var/pumpsound = 'sound/weapons/shotgunpump.ogg'
	mag_load_sound = 'sound/effects/wep_magazines/insertShotgun.ogg'
	wielded_icon = "shotgun1"
	fire_sound = 'sound/f13weapons/shotgun.ogg'//There is no fucking reason that shotguns should have the same sounds as pistols, TG.
	weapon_weight = WEAPON_MEDIUM

/obj/item/weapon/gun/ballistic/shotgun/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(.)
		return
	var/num_loaded = magazine.attackby(A, user, params, 1)
	if(num_loaded)
		to_chat(user, "<span class='notice'>You load [num_loaded] shell\s into \the [src]!</span>")
		playsound(loc, mag_load_sound, 50)
		A.update_icon()
		update_icon()

/obj/item/weapon/gun/ballistic/shotgun/process_chamber(empty_chamber = 0)
	return ..() //changed argument value

/obj/item/weapon/gun/ballistic/shotgun/chamber_round()
	return

/obj/item/weapon/gun/ballistic/shotgun/can_shoot()
	if(!chambered)
		return 0
	return (chambered.BB ? 1 : 0)

/obj/item/weapon/gun/ballistic/shotgun/attack_self(mob/living/user)
	if(recentpump)
		return
	pump(user)
	recentpump = 1
	spawn(10)
		recentpump = 0
	return

/obj/item/weapon/gun/ballistic/shotgun/blow_up(mob/user)
	. = 0
	if(chambered && chambered.BB)
		process_fire(user, user,0)
		. = 1

/obj/item/weapon/gun/ballistic/shotgun/proc/pump(mob/M)
	playsound(M, pumpsound, 60, 1)
	pump_unload(M)
	pump_reload(M)
	update_icon()	//I.E. fix the desc
	return 1

/obj/item/weapon/gun/ballistic/shotgun/proc/pump_unload(mob/M)
	if(chambered)//We have a shell in the chamber
		chambered.forceMove(get_turf(src))//Eject casing
		chambered.SpinAnimation(5, 1)
		chambered = null

/obj/item/weapon/gun/ballistic/shotgun/proc/pump_reload(mob/M)
	if(!magazine.ammo_count())
		return 0
	var/obj/item/ammo_casing/AC = magazine.get_round() //load next casing.
	chambered = AC


/obj/item/weapon/gun/ballistic/shotgun/examine(mob/user)
	..()
	if(chambered)
		to_chat(user, "A [chambered.BB ? "live" : "spent"] one is in the chamber.")

/obj/item/weapon/gun/ballistic/shotgun/lethal
	small_gun = 1
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lethal

// RIOT SHOTGUN //

/obj/item/weapon/gun/ballistic/shotgun/riot //for spawn in the armory
	name = "riot shotgun"
	desc = "A sturdy shotgun with a longer magazine and a fixed tactical stock designed for non-lethal riot control."
	icon_state = "riotshotgun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/riot
	sawn_desc = "Come with me if you want to live."
	small_gun = 1

/obj/item/weapon/gun/ballistic/shotgun/riot/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/weapon/circular_saw) || istype(A, /obj/item/weapon/gun/energy/plasmacutter))
		sawoff(user)
	if(istype(A, /obj/item/weapon/melee/energy))
		var/obj/item/weapon/melee/energy/W = A
		if(W.active)
			sawoff(user)

///////////////////////
// BOLT ACTION RIFLE //
///////////////////////

/obj/item/weapon/gun/ballistic/shotgun/boltaction
	name = "???????????????? ????????????"
	desc = "?????????????????? ???????????????? ????????????, ???????????? ???? ?????????????????????? ?? ?????????????? ?????????? ??????????????."
	icon_state = "moistnugget"
	item_state = "moistnugget"
	slot_flags = SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction
	var/bolt_open = 0
	wielded_icon = null

/obj/item/weapon/gun/ballistic/shotgun/boltaction/pump(mob/M)
	playsound(M, pumpsound, 60, 1)
	if(bolt_open)
		pump_reload(M)
	else
		pump_unload(M)
	bolt_open = !bolt_open
	update_icon()	//I.E. fix the desc
	return 1

/obj/item/weapon/gun/ballistic/shotgun/boltaction/attackby(obj/item/A, mob/user, params)
	if(!bolt_open)
		to_chat(user, "<span class='notice'>The bolt is closed!</span>")
		return
	. = ..()

/obj/item/weapon/gun/ballistic/shotgun/boltaction/examine(mob/user)
	..()
	to_chat(user, "The bolt is [bolt_open ? "open" : "closed"].")

// Automatic Shotguns//

/obj/item/weapon/gun/ballistic/shotgun/automatic/shoot_live_shot(mob/living/user as mob|obj)
	..()
	src.pump(user)

/obj/item/weapon/gun/ballistic/shotgun/automatic/combat
	name = "combat shotgun"
	desc = "A semi automatic shotgun with tactical furniture and a six-shell capacity underneath."
	icon_state = "cshotgun"
	origin_tech = "combat=6"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/com
	w_class = WEIGHT_CLASS_HUGE
	wielded_icon = "cshotgun1"
	small_gun = 1

//Dual Feed Shotgun

/obj/item/weapon/gun/ballistic/shotgun/automatic/dual_tube
	name = "cycler shotgun"
	desc = "An advanced shotgun with two separate magazine tubes, allowing you to quickly toggle between ammo types."
	icon_state = "cycler"
	origin_tech = "combat=4;materials=2"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube
	w_class = WEIGHT_CLASS_HUGE
	var/toggled = 0
	var/obj/item/ammo_box/magazine/internal/shot/alternate_magazine

/obj/item/weapon/gun/ballistic/shotgun/automatic/dual_tube/New()
	..()
	if (!alternate_magazine)
		alternate_magazine = new mag_type(src)

/obj/item/weapon/gun/ballistic/shotgun/automatic/dual_tube/attack_self(mob/living/user)
	if(!chambered && magazine.contents.len)
		pump()
	else
		toggle_tube(user)

/obj/item/weapon/gun/ballistic/shotgun/automatic/dual_tube/proc/toggle_tube(mob/living/user)
	var/current_mag = magazine
	var/alt_mag = alternate_magazine
	magazine = alt_mag
	alternate_magazine = current_mag
	toggled = !toggled
	if(toggled)
		to_chat(user, "You switch to tube B.")
	else
		to_chat(user, "You switch to tube A.")

/obj/item/weapon/gun/ballistic/shotgun/automatic/dual_tube/AltClick(mob/living/user)
	if(user.incapacitated() || !Adjacent(user) || !istype(user))
		return
	pump()


// DOUBLE BARRELED SHOTGUN and IMPROVISED SHOTGUN are in revolver.dm
