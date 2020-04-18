//Fallout 13 npc ghouls directory

/mob/living/simple_animal/hostile/ghoul
	name = "����� ����"
	desc = "Have you ever seen a living ghoul before?<br>Ghouls are necrotic post-humans - decrepit, rotting, zombie-like mutants."
	icon = 'icons/fallout/mobs/animal.dmi'
	icon_state = "retro_ghoul"
	icon_living = "retro_ghoul"
	icon_dead = "retro_ghoul_d"
	icon_gib = "gib"
	speak_chance = 0
	turns_per_move = 5
	environment_smash = 0
	response_help = "hugs"
	response_disarm = "pushes aside"
	response_harm = "slaps"
	move_to_delay = 4
	respawn_time_of_mob = 500000000
	maxHealth = 150
	health = 150
	self_weight = 45

	faction = list("hostile", "ghoul")

	sound_speak_chance = 5
	sound_speak = list('sound/f13npc/ghoul_charge1.ogg','sound/f13npc/ghoul_charge2.ogg','sound/f13npc/ghoul_charge3.ogg')

	aggro_sound_chance = 50
	aggro_sound = 'sound/f13npc/ghoul_alert.ogg'

	death_sound = 'sound/f13npc/ghoul_death.ogg'

	melee_damage_lower = 10
	armour_penetration = 10
	melee_damage_upper = 35
	aggro_vision_range = 10
	idle_vision_range = 7
	attacktext = "��������"
	attack_sound = "punch"

	XP = 7

/mob/living/simple_animal/hostile/ghoul/death(gibbed)
	if(murder)
		if(istype(murder, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = murder
			if(H.dna.species)
				if(H.dna.species.type == /datum/species/ghoul)
					H.faction -= "ghoul"

	..()

/mob/living/simple_animal/hostile/ghoul/Life()
	. = ..()
	if(!.)
		if(prob(0.1))
			visible_message("<span class='notice'>���� [src] �����������!</span>")
			gib(FALSE, FALSE, FALSE, TRUE)

/mob/living/simple_animal/hostile/ghoul/aggressive
	name = "����� ����"
	desc = "Have you ever seen a hungry ghoul before?<br>Similar to other feral ghouls, it's more aggressive and confident about the fact that you are the best food around.<br>It is missing a left arm."
	icon_state = "angry_ghoul"
	icon_living = "angry_ghoul"
	icon_dead = "angry_ghoul_d"
	icon_gib = "gib"
	maxHealth = 80
	health = 80
	melee_damage_lower = 15
	melee_damage_upper = 25
	aggro_vision_range = 15
	idle_vision_range = 10
	attacktext = "chomps"

/mob/living/simple_animal/hostile/ghoul/glowing
	name = "���������� ����"
	desc = "Have you ever seen a glowing ghoul before?<br>Glowing ghouls are necrotic post-humans - rotting, zombie-like mutants, who are so irradiated they actually glow in the dark."
	icon_state = "retro_glowghoul"
	icon_living = "retro_glowghoul"
	icon_dead = "retro_glowghoul_d"
	icon_gib = "gib"
	maxHealth = 100
	health = 100
	melee_damage_lower = 15
	melee_damage_upper = 25
	light_color = LIGHT_COLOR_GREEN
	light_power = 1
	light_range = 2

/mob/living/simple_animal/hostile/ghoul/glowing/New()
	..()
	SSradiation.processing += src

/mob/living/simple_animal/hostile/ghoul/soldier
	name = "����� ����"
	desc = "Have you ever seen a living ghoul before?<br>Ghouls are necrotic post-humans - decrepit, rotting, zombie-like mutants."
	icon = 'icons/fallout/mobs/animal.dmi'
	icon_state = "soldier_ghoul"
	icon_living = "soldier_ghoul"
	icon_dead = "soldier_ghoul_d"
	icon_gib = "gib"
	maxHealth = 90
	health = 90

/mob/living/simple_animal/hostile/ghoul/soldier/armored
	name = "������������� ����� ����"
	desc = "Have you ever seen a living ghoul before?<br>Ghouls are necrotic post-humans - decrepit, rotting, zombie-like mutants."
	icon = 'icons/fallout/mobs/animal.dmi'
	icon_state = "soldier_ghoul_a"
	icon_living = "soldier_ghoul_a"
	icon_dead = "soldier_ghoul_a_d"
	icon_gib = "gib"
	maxHealth = 100
	health = 100

/mob/living/simple_animal/hostile/ghoul/scorched
	name = "�������"
	desc = "� ���������� � ����������, ���������� ����, �������� ��� �����, ������� �������� �������� �������������� ��������� �� ����� ����, �������������� �� ���� ������������� �������. ������� ����������� � �������������� ���� ������� ����������, ��, �������� ��������������� ������������� �� ������, ���������� ��������������� ������� 76, ������� � ��� ������ ����, ������� ���������� ������ ��������, ���������������� �����������.."
	icon = 'icons/fallout/mobs/animal.dmi'
	icon_state = "scorched_m"
	icon_living = "scorched_m"
	icon_dead = "scorched_m_d"
	icon_gib = "gib"
	speak_chance = 1
	turns_per_move = 5
	environment_smash = 0
	response_help = "hugs"
	response_disarm = "pushes aside"
	response_harm = "�����"
	move_to_delay = 4
	respawn_time_of_mob = 500000000
	maxHealth = 80
	health = 80
	self_weight = 45

	faction = list("scorched", "hostile")

	sound_speak_chance = 1
	sound_speak = list('sound/f13npc/scor_br1.ogg','sound/f13npc/scor_b2.ogg','sound/f13npc/scor_b3.ogg')

	aggro_sound_chance = 50
	aggro_sound = 'sound/f13npc/ghoul_alert.ogg'

	death_sound = list('sound/f13npc/scor_d1.ogg','sound/f13npc/scor_d2.ogg','sound/f13npc/scor_d3.ogg','sound/f13npc/scor_d4.ogg','sound/f13npc/scor_d5.ogg')

	melee_damage_lower = 15
	melee_damage_upper = 20
	aggro_vision_range = 10
	idle_vision_range = 7
	attacktext = "��������"
	attack_sound = "punch"
	XP = 10

/mob/living/simple_animal/hostile/ghoul/scorched/ranged
	name = "�������"
	desc = "� ���������� � ����������, ���������� ����, �������� ��� �����, ������� �������� �������� �������������� ��������� �� ����� ����, �������������� �� ���� ������������� �������. ������� ����������� � �������������� ���� ������� ����������, ��, �������� ��������������� ������������� �� ������, ���������� ��������������� ������� 76, ������� � ��� ������ ����, ������� ���������� ������ ��������, ���������������� �����������.."
	icon = 'icons/fallout/mobs/animal.dmi'
	icon_state = "scorched_r"
	icon_living = "scorched_r"
	icon_dead = "scorched_r_d"
	icon_gib = "gib"
	speak_chance = 1
	turns_per_move = 5
	environment_smash = 0
	response_help = "hugs"
	response_disarm = "pushes aside"
	response_harm = "����"
	move_to_delay = 4
	respawn_time_of_mob = 500000000
	maxHealth = 80
	health = 80
	self_weight = 45
	ranged = 1
	ranged_cooldown_time = 200
	projectiletype = /obj/item/projectile/bullet/F13/c9mmBullet
	projectilesound = 'sound/f13weapons/hunting_rifle.ogg'

	faction = list("scorched", "hostile")

	sound_speak_chance = 1
	sound_speak = list('sound/f13npc/scor_br1.ogg','sound/f13npc/scor_b2.ogg','sound/f13npc/scor_b3.ogg')

	aggro_sound_chance = 50
	aggro_sound = 'sound/f13npc/ghoul_alert.ogg'

	death_sound = list('sound/f13npc/scor_d1.ogg','sound/f13npc/scor_d2.ogg','sound/f13npc/scor_d3.ogg','sound/f13npc/scor_d4.ogg','sound/f13npc/scor_d5.ogg')

	melee_damage_lower = 15
	melee_damage_upper = 20
	aggro_vision_range = 10
	idle_vision_range = 7
	attacktext = "��������"
	attack_sound = "punch"
	XP = 15