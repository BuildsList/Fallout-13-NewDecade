//Fallout 13 protectron directory

/mob/living/simple_animal/hostile/sentrybot
	name = "Робот-Охранник"
	desc = "Довоенный Робот-Охранник.<br>Очень грозная машина."
	icon = 'icons/fallout/mobs/animal.dmi'
	icon_state = "sentrybot"
	icon_living = "sentrybot"
	icon_dead = "sentrybot_d"
	icon_gib = "sentrybot_d"
	speak_chance = 0
	turns_per_move = 3
	environment_smash = 0
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "бьет"
	move_to_delay = 4
	stat_attack = 1
	robust_searching = 1
	maxHealth = 1000
	health = 1000
	self_weight = 400
	healable = 0

	faction = list("hostile", "robot")

	sound_speak_chance = 5
	sound_speak = list('sound/f13npc/sentrybot/idle_1.ogg','sound/f13npc/sentrybot/idle_2.ogg','sound/f13npc/sentrybot/idle_3.ogg','sound/f13npc/sentrybot/idle_4.ogg')

	aggro_sound_chance = 50
	aggro_sound = list('sound/f13npc/sentrybot/attack_1.ogg', 'sound/f13npc/sentrybot/attack_2.ogg', 'sound/f13npc/sentrybot/attack_3.ogg', 'sound/f13npc/sentrybot/attack_4.ogg', 'sound/f13npc/sentrybot/attack_5.ogg', 'sound/f13npc/sentrybot/attack_6.ogg', 'sound/f13npc/sentrybot/attack_7.ogg', 'sound/f13npc/sentrybot/attack_8.ogg', 'sound/f13npc/sentrybot/attack_9.ogg', 'sound/f13npc/sentrybot/attack_10.ogg', 'sound/f13npc/sentrybot/attack_11.ogg', 'sound/f13npc/sentrybot/attack_12.ogg')

	death_sound = list('sound/f13npc/sentrybot/death_1.ogg', 'sound/f13npc/sentrybot/death_2.ogg', 'sound/f13npc/sentrybot/death_3.ogg', 'sound/f13npc/sentrybot/death_4.ogg', 'sound/f13npc/sentrybot/death_5.ogg', 'sound/f13npc/sentrybot/death_6.ogg')

	harm_intent_damage = 15
	melee_damage_lower = 30
	melee_damage_upper = 35
	minimum_distance = 2
	retreat_distance = 4
	attacktext = "бьет"
	attack_sound = "punch"
	a_intent = "harm"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	status_flags = CANPUSH
	vision_range = 12
	aggro_vision_range = 15
	idle_vision_range = 7
	ranged = 1
	rapid = 1
	projectiletype = /obj/item/projectile/beam/laser/pistol/ultraweak
	projectilesound = 'sound/weapons/resonator_fire.ogg'
	XP = 55
	var/lootable = 0
	var/unscrewed = 0
	var/wire_cut = 0
	var/core_stable = 1
	var/core_lootable = 0
	var/spam_protect_time = 0

/obj/item/projectile/beam/laser/pistol/ultraweak
	damage = 8 //quantity over quality

/mob/living/simple_animal/hostile/sentrybot/proc/do_death_beep()
	playsound(src, 'sound/machines/triple_beep.ogg', 75, TRUE)
	visible_message("<span class='warning'>Вы слышите частый бип-бип из [src]!</span>", "<span class='warning'>Вы слышите частый бип!</span>")

/mob/living/simple_animal/hostile/sentrybot/proc/self_destruct()
	explosion(src,1,2,4,4)
	qdel(src)

/mob/living/simple_animal/hostile/sentrybot/proc/self_destruct_looted()
	explosion(src,1,1,2,2)
	qdel(src)

/mob/living/simple_animal/hostile/sentrybot/death()
	switch(rand(1,15))
		if(5)
			new/obj/effect/particle_effect/sparks
			for(var/i in 1 to 3)
				addtimer(CALLBACK(src, .proc/do_death_beep), i * 1 SECONDS)
			addtimer(CALLBACK(src, .proc/self_destruct), 4 SECONDS)
			return ..()
		else
			new/obj/effect/particle_effect/sparks
			lootable = 1
			desc = "Довоенный робот охранник, некогда грозная машина, теперь лишь груда металла, может из неё удастся что-то получить."
			name = "повреждённый робот охранник"
			return ..()

/mob/living/simple_animal/hostile/sentrybot/attackby(obj/item/I, mob/living/carbon/human/user, params)
	if(istype(I, /obj/item/weapon/screwdriver) && lootable == 1)
		to_chat(user, "Вы начинаете отвинчивать крепления на спинной панели реактора.")
		playsound(src.loc, I.usesound, 100, 1)
		if(do_after(user, 20, target = loc))
			if(user.skills.getPoint("science") <= 4)
				to_chat(user, "Вы отвинтили крепления, и перед вами выпала каша из проводов, достаточно сложно определить, какой из них вам нужен...")
				unscrewed = 1
				lootable = 0
				return
			if(user.skills.getPoint("science") >= 5)
				to_chat(user, "Вы отвинтили крепление с панели реактора, перед вами выпала каша из проводов, однако ваших знаний достаточно чтобы понять что именно вам нужно.")
				unscrewed = 1
				lootable = 0
				return
		return
	if(istype(I, /obj/item/weapon/wirecutters) && unscrewed == 1)
		if(user.skills.getPoint("science") <= 4)
			to_chat(user, "Попытка не пытка, хоть тут и не ясно, какой вам всё-же нужен провод, вы аккуратно начинаете перебирать каждый из них.")
			if(do_after(user, 90, target = loc))
				playsound(src.loc, I.usesound, 100, 1)
				to_chat(user, "Это было достаточно сложно, учитывая количество проводов, но вы всё-же справились с этим, хоть и не уверены, добавит ли это стабильности поврежденной ячейке, осталось отварить защитную крышку ядерного блока.")
				wire_cut = 1
				core_stable = 0
				unscrewed = 0
				return
			return
		if(user.skills.getPoint("science") >= 5)
			to_chat(user, "Вы точно знаете, какие провода вам нужны и принимаетесь ловко обрезать их.")
			if(do_after(user, 25, target = loc))
				playsound(src.loc, I.usesound, 100, 1)
				to_chat(user, "Это было легко, вы смогли обрезать лишь нужные вам провода, что явно добавит стабильности ядерному блоку, который теперь надо изъять, отварив защитную крышку.")
				wire_cut = 1
				unscrewed = 0
				return
			return
	if(istype(I, /obj/item/weapon/weldingtool) && wire_cut == 1)
		var/obj/item/weapon/weldingtool/WT = I
		if(WT.remove_fuel(0,user))
			playsound(src.loc, I.usesound, 100, 1)
			if(user.skills.getPoint("science") >= 5)
				to_chat(user, "Вы начинаете аккуратно отваривать защитную крышку ядерного блока, стараясь не повредить сам блок.")
				if(do_after(user, 30, target = loc))
					if( !WT.isOn() )
						return
					playsound(src.loc, I.usesound, 100, 1)
					to_chat(user, "Вы успешно отвариваете крышку, перед вами предстаёт ядерный блок.")
					new/obj/item/stack/sheet/plasteel(get_turf(src), 1)
					new/obj/effect/particle_effect/sparks
					core_lootable = 1
					wire_cut = 0
					return
				return
			if(user.skills.getPoint("science") <= 4)
				to_chat(user, "Понимая, что ядерная батарея скорее всего теперь нестабильна, вы решаете действовать максимально аккуратно.")
				if(do_after(user, 120, target = loc))
					if( !WT.isOn() )
						return
					playsound(src.loc, I.usesound, 100, 1)
					to_chat(user, "Вы успешно отвариваете крышку, перед вами предстаёт дымящийся ядерный блок.")
					new/obj/item/stack/sheet/plasteel(get_turf(src), 1)
					new/obj/effect/particle_effect/sparks
					core_lootable = 1
					wire_cut = 0
					return
				return
	if(istype(I, /obj/item/weapon/wirecutters) && wire_cut == 1)
		to_chat(user, "Провода уже обрезаны.")
		return
	if(istype(I, /obj/item/weapon/screwdriver) && unscrewed == 0)
		to_chat(user, "Панель уже отвинчена.")
		return
	if(istype(I, /obj/item/weapon/weldingtool) && core_lootable == 1)
		to_chat(user, "Крышка уже отварена")
		return
	return

/mob/living/simple_animal/hostile/sentrybot/attack_hand(mob/living/carbon/human/user)
	if(core_lootable == 1 & core_stable == 1)
		if(do_after(user, 10, target = loc))
			var/obj/item/weapon/stock_parts/cell_pa/high/C = new(get_turf(src))
			core_lootable = 0
			to_chat(user, "Вы вытягиваете ядерный блок из корпуса робота. Теперь у вас есть 15 секунд, прежде чем останки самоуничтожатся")
			user.put_in_hands(C)
			new /obj/effect/particle_effect/sparks
			for(var/i in 1 to 3)
				addtimer(CALLBACK(src, .proc/do_death_beep), i * 1 SECONDS)
			addtimer(CALLBACK(src, .proc/self_destruct_looted), 15 SECONDS)
		return
	if(core_lootable == 1 & core_stable == 0)
		if(do_after(user, 10, target = loc))
			to_chat(user, "Дымящийся ядерный блок выглядит нестабильно... Что это за шум...")
			new /obj/effect/particle_effect/sparks
			for(var/i in 1 to 3)
				addtimer(CALLBACK(src, .proc/do_death_beep), i * 1 SECONDS)
			addtimer(CALLBACK(src, .proc/self_destruct), 4 SECONDS)
		return

/mob/living/simple_animal/hostile/sentrybot/Aggro()
	..()
	summon_backup(10)

/mob/living/simple_animal/hostile/assaultron
	name = "штурмотрон"
	desc = "A deadly close combat robot developed by RobCo.  Their head laser is absolutely devastating."
	icon = 'icons/fallout/mobs/animal.dmi'
	icon_state = "assaultron"
	icon_living = "assaultron"
	icon_dead = "gib7"
	health = 900
	maxHealth = 900
	melee_damage_lower = 20
	melee_damage_upper = 30
	speed = 0
	attacktext = "избивает своими клешнями"
	faction = list("hostile", "robot")
	XP = 35