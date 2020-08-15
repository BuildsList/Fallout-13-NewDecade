/mob/living/simple_animal/piggy
	name = "��������"
	desc = "��� ����, ������� �� �������� � �������� ����-������."
	icon_state = "piglet"
	icon_living = "piglet"
	icon_dead = "piglet_dead"
	gender = FEMALE
	speak = list("���.","���?","���-�-�.","���!")
	speak_emote = list("�������")
	emote_hear = list("�������.")
	emote_see = list("�������� ����� � �����.","�������.")
	density = 1
	speak_chance = 2
	turns_per_move = 2
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat/slab = 3)
	response_help  = "������"
	response_disarm = "gently pushes aside"
	response_harm   = "������"
	attacktext = "������"
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
	name = "������"
	desc = "������������ ������� ������, ��, ����� ���� ���� ���..."
	gender = FEMALE
	icon_state = "pig_n"
	icon_living = "pig_n"
	icon_dead = "pig_n_dead"
	speak = list("���!","���-���!!!","���...")
	speak_emote = list("�������")
	emote_hear = list("�������.", "������� ��������� �������� �����.")
	emote_see = list("���� ����� ��������.","����� ������ ��������.")
	density = 0
	speak_chance = 2
	turns_per_move = 3
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat/slab = 2)
	var/egg_type = /mob/living/simple_animal/piggy
	var/food_type = /obj/item/weapon/reagent_containers/food/snacks
	response_help  = "������"
	response_disarm = "gently pushes aside"
	response_harm   = "������"
	attacktext = "������"
	health = 150
	maxHealth = 150
	var/eggsleft = 0
	var/list/feedMessages = list("�������� �������.","�������� ������ ���������.")
	var/list/layMessage = list("������ ������ ��������.","������ ���� ������� � ������ ���������.","������ �������� ������ � ������ ��������.","������ ������� ��������, ����������, � �������� ������ ��������.")
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
			var/feedmsg = "[user] ����������� [O] [name]! [pick(feedMessages)]"
			user.visible_message(feedmsg)
			user.drop_item()
			qdel(O)
			eggsleft += rand(1, 4)
//			to_chat(world, eggsleft)
		else
			to_chat(user, "<span class='warning'>[name] �� �������� ��������!</span>")
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