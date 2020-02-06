/mob/living/simple_animal/hostile/crow
	name = "crow"
	desc = "A large crow. Caw caw."
	icon = 'icons/mob/animal.dmi'
	icon_state = "crow"
	icon_living = "crow"
	icon_dead = "crow_dead"
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL

	speak = list("���.", "���?", "���!", "���.")
	speak_emote = list("�������")
	emote_hear = list("�������")
	emote_see = list("������ �������")
	response_help  = "������"
	response_disarm = "gently moves aside"
	response_harm   = "�����"
