/obj/item/weapon/grenade/mine
	name = "мина"
	desc = "Better stay away from that thing."
	icon = 'icons/fallout/objects/items.dmi'
	icon_state = "landmine"
	var/triggered = 0
	det_time = 0																										//Г‚Г§Г°Г»ГўГ ГҐГІГ±Гї Г¬Г®Г¬ГҐГ­ГІГ Г«ГјГ­Г®


/obj/item/weapon/grenade/mine/attack_self(mob/user)
	if(!active)
		to_chat(user, "<span class='warning'>Вы устанавливаете [name]!</span>")											//Г‘Г®Г®ГЎГ№ГҐГ­ГЁГҐ, ГЄГ®ГІГ®Г°Г®ГҐ ГўГ»ГўГ®Г¤ГЁГІГ±Гї ГЁГЈГ°Г®ГЄГі ГЇГ°ГЁ ГіГ±ГІГ Г­Г®ГўГЄГҐ.
		visible_message("<span class='danger'>[user] устанавливает [src]!</span>")										//Г‘Г®Г®ГЎГ№ГҐГ­ГЁГҐ ГўГ±ГҐГ¬ ГЇГ°ГЁГ±ГіГІГ±ГІГўГіГѕГ№ГЁГ¬
		playsound(user.loc, 'sound/weapons/armbomb.ogg', 60, 1)
		active = 1
		icon_state = initial(icon_state) + "_active"																//Г…Г±Г«ГЁ ГЎГіГ¤ГҐГёГј Г¬ГҐГ­ГїГІГј Г±ГЇГ°Г Г©ГІ Гі Г ГЄГІГЁГўГ­Г®Г© - ГЁГ§Г¬ГҐГ­ГЁ ГЅГІГі Г±ГІГ°Г®ГЄГі.
		add_fingerprint(user)																						//ГЋГ±ГІГ ГўГ«ГїГҐГ¬ Г®ГІГЇГҐГ·Г ГІГЄГЁ Г¬Г®ГЎГ  Г­Г  Г¬ГЁГ­ГҐ

		var/turf/bombturf = get_turf(src)																			//Г‘Г«ГҐГ¤ГіГѕГ№ГЁГҐ ГёГҐГ±ГІГј Г±ГІГ°Г®ГЄ ГўГ®Г®ГЎГ№ГҐ Г­ГҐ Г®ГЎГїГ§Г ГІГҐГ«ГјГ­Г», Г«ГЁГёГј ГЇГЁГёГіГІ Гў Г«Г®ГЈГЁ, Г·ГІГ® ГЄГІГ®-ГІГ® ГЇГ®Г±ГІГ ГўГЁГ« Г¬ГЁГ­Гі.
		var/area/A = get_area(bombturf)
		var/message = "[ADMIN_LOOKUPFLW(user)]) активирует детонацию [name] в [ADMIN_COORDJMP(bombturf)]"
		bombers += message
		message_admins(message)
		log_game("[key_name(usr)] has primed a [name] for detonation at [A.name] [COORD(bombturf)].")

		if(user)
			user.drop_item()																						//ГђГ®Г­ГїГҐГ¬ Г¬ГЁГ­Гі Г­Г  ГЇГ®Г«
			anchored = 1																							//Г€ ГЄГ°ГҐГЇГЁГ¬ ГҐВё ГЄ ГЇГ®Г«Гі



/obj/item/weapon/grenade/mine/proc/mineEffect(mob/victim)																//Г‘ГѕГ¤Г  ГЇГЁГёГҐГ¬ ГЅГґГґГҐГЄГІ Г®ГІ Г¬ГЁГ­Г». ГЏГ®-ГµГ®Г°Г®ГёГҐГ¬Гі, Г­ГіГ¦Г­Г® ГЇГҐГ°ГҐГЇГЁГ±Г ГІГј, Г·ГІГ®ГЎ ГѕГ§Г Г«Г±Гї ГЇГ°Г®ГЄ prime()
	to_chat(victim, "<span class='danger'>*дзынь*</span>")

/obj/item/weapon/grenade/mine/Crossed(AM as mob|obj)
	if(active)
		if(ispath(AM, /obj/effect/))
			return

		if(ismob(AM))
			var/mob/MM = AM
			var/mob/living/user = AM

			if(user.perks.have(/datum/perk/lightstep))
				if(prob(50))
					user.visible_message("<font color='green'>[user] аккуратно обходит мину!</font>")
					return

			if(!(MM.movement_type & FLYING))
				triggermine(AM)
		else
			if(istype(AM, /obj/item/))
				triggermine(AM)

/obj/item/weapon/grenade/mine/proc/triggermine(mob/victim)
	if(triggered)
		return
	visible_message("<span class='danger'>[victim] активирует [bicon(src)] [src]!</span>")
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	mineEffect(victim)
	triggered = 1
	qdel(src)



/obj/item/weapon/grenade/mine/explosive
	name = "мина"
	desc = "Мина. Маленькое блюдце начиненное взрывчаткой."
	var/range_devastation = 0
	var/range_heavy = 1
	var/range_light = 2
	var/range_flash = 3
	var/press_bolted = 1
	var/hidden = 0
	icon_state = "landmine"
	price = 350

/obj/item/weapon/grenade/mine/explosive/mineEffect(mob/victim)
	explosion(loc, range_devastation, range_heavy, range_light, range_flash)


/obj/item/weapon/grenade/mine/explosive/planted
	active = 1
	anchored = 1
	icon_state = "landmine_active"

/obj/item/weapon/grenade/mine/caps_mine
	name = "caps mine"
	var/range_devastation = 1
	var/range_heavy = 2
	var/range_light = 4
	var/range_flash = 4
	icon = 'icons/fallout/objects/crafting.dmi'
	icon_state = "capmine"

/obj/item/weapon/grenade/mine/caps_mine/mineEffect(mob/victim)
	explosion(loc, range_devastation, range_heavy, range_light, range_flash)


/obj/item/weapon/grenade/mine/caps_mine/planted
	active = 1
	anchored = 1
	icon_state = "capmine_active"

/obj/item/weapon/grenade/mine/explosive/attackby(obj/item/I, mob/living/carbon/human/user, params)
	if(istype(I, /obj/item/weapon/shovel) && active == 1)
		if(do_after(user, 20, target = loc))
			to_chat(user, "Вы прикапываете мину песком, маскируя её.")
			icon_state = initial(icon_state) + "_hidden"
			hidden = 1
			return
	if(istype(I, /obj/item/weapon/shovel) && hidden == 1)
		if(do_after(user, 20, target = loc))
			to_chat(user, "Вы раскапываете мину.")
			icon_state = initial(icon_state) - "_hidden"
			hidden = 0
	if(istype(I, /obj/item/weapon/screwdriver) && active == 1)
		to_chat(user, "Вы аккуратно начинаете развинчивать болты на мине.")
		playsound(src.loc, I.usesound, 100, 1)
		if(do_after(user, 15, target = loc))
			to_chat(user, "Вы очень аккуратно убираете болтики с нажимной пластины.")
			press_bolted = 0
	if(istype(I, /obj/item/weapon/wirecutters) && press_bolted == 0)
		if(user.skills.getPoint("explosives") <= 2)
			playsound(src.loc, I.usesound, 100, 1)
			if(do_after(user, 15, target = loc))
				to_chat(user, "Вы перерезали не тот провод. Мина ничинает пищать...")
				playsound(get_turf(src),'sound/f13weapons/mine_five.ogg',50)
				sleep(5)
				icon_state = initial(icon_state) - "_detonate"
				triggermine()
		if(user.skills.getPoint("explosives") >= 6)
			playsound(src.loc, I.usesound, 100, 1)
			if(do_after(user, 15, target = loc))
				to_chat(user, "Вы успешно обрезали провода и обезвредели бомбу.")
				icon_state = initial(icon_state) - "_active"
				new /obj/item/weapon/grenade/mine/explosive
				active = 0
				qdel(src)
		if(user.skills.getPoint("explosives") >= 3 !=6 !=7 !=8 !=9 !=10)
			playsound(src.loc, I.usesound, 100, 1)
			if(do_after(user, 15, target = loc))
				to_chat(user, "Вы успешно обрезали провода, но мина всё-ещё может взорваться. Вы можете попробовать разобрать мину на компоненты...")
				active = 0
	if(istype(I, /obj/item/weapon/wrench) && active == 0)
		to_chat(user, "Вы начинаете скручивать оставшиеся детали мины.")
		playsound(src.loc, I.usesound, 100, 1)
		if(do_after(user, 15, target = loc))
			to_chat(user, "К сожалению, вы повредили корпус и вы не смогли достать ничего полезного.")
			qdel(src)