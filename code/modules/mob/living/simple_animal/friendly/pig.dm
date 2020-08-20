/mob/living/simple_animal/piggy
	name = "поросёнок"
	desc = "Как мило, однажды он вырастет и накормит кого-нибудь."
	icon_state = "piglet"
	icon_living = "piglet"
	icon_dead = "piglet_dead"
	gender = FEMALE
	speak = list("хрю.","хрю?","хрю-ю-ю.","ХРЮ!")
	speak_emote = list("хрюкает")
	emote_hear = list("хрюкает.")
	emote_see = list("тыкается рылом в землю.","чавкает.")
	density = 1
	speak_chance = 2
	turns_per_move = 2
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat/slab = 3)
	response_help  = "гладит"
	response_disarm = "gently pushes aside"
	response_harm   = "пинает"
	attacktext = "кусает"
	health = 65
	maxHealth = 65
	var/amount_grown = 0
	mob_size = MOB_SIZE_SMALL

/mob/living/simple_animal/piggy/New()
	..()
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)

/mob/living/simple_animal/piggy/Life()
	. =..()
	if(!.)
		return
	if(!stat && !ckey)
		amount_grown += rand(1,2)
		if(amount_grown >= 100)
			new /mob/living/simple_animal/pig_n(src.loc)
			qdel(src)

var/const/MAX_PIGS = 50
var/global/pigs_count = 0

/mob/living/simple_animal/pig_n
	name = "свинья"
	desc = "Мутировавший потомок свиньи, ну, вроде трех глаз нет..."
	gender = FEMALE
	icon_state = "pig_n"
	icon_living = "pig_n"
	icon_dead = "pig_n_dead"
	speak = list("хрю!","хрю-хрю!!!","хрю...")
	speak_emote = list("хрюкает")
	emote_hear = list("хрюкает.", "хрюкает осознавая четность бытия.")
	emote_see = list("роет землю копытцем.","машет своими крыльями.")
	density = 1
	speak_chance = 2
	turns_per_move = 3
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat/slab = 2)
	var/egg_type = /mob/living/simple_animal/piggy
	var/food_type = /obj/item/weapon/reagent_containers/food/snacks/f13/pomoi
	response_help  = "гладит"
	response_disarm = "gently pushes aside"
	response_harm   = "пинает"
	attacktext = "кусает"
	health = 150
	maxHealth = 150
	var/eggsleft = 0
	var/list/feedMessages = list("довольно хрюкает.","довольно виляет хвостиком.")
	var/list/layMessage = list("Свинья рожает поросёнка.","Свинья люто хрюкает и рожает поросенка.","Свинья неистово визжит и рожает поросёнка.","Свинья достает сигарету, закуривает, и спокойно рожает хрюнделя.")
	blood_volume = BLOOD_VOLUME_NORMAL

/mob/living/simple_animal/pig_n/New()
	..()
	pigs_count += 1

/mob/living/simple_animal/pig_n/death(gibbed)
	..(gibbed)
	pigs_count -= 1

/mob/living/simple_animal/pig_n/attackby(obj/item/O, mob/user, params)
	if(istype(O, food_type)) //feedin' dem chickens
		if(!stat && eggsleft < 8)
			var/feedmsg = "[user] скармливает [O] [name]! [pick(feedMessages)]"
			user.visible_message(feedmsg)
			user.drop_item()
			qdel(O)
			eggsleft += rand(1, 4)
//			to_chat(world, eggsleft)
		else
			to_chat(user, "<span class='warning'>[name] не выглядит голодной!</span>")
	else
		..()

/mob/living/simple_animal/pig_n/Life()
	. =..()
	if(!.)
		return
	if((!stat && prob(3) && eggsleft > 0) && egg_type)
		visible_message("[src]  [pick(layMessage)]")
		eggsleft--
		new egg_type(get_turf(src))