/mob/living/simple_animal/hostile/bloatfly
	name = "раздутая муха"
	desc = "Большая, уродливая, летающая штука."
	icon = 'icons/fallout/mobs/animal.dmi'
	icon_state = "bloatfly"
	icon_living = "bloatfly"
	icon_dead = "bloatfly_dead"
	icon_gib = "gib"
	speak_chance = 0
	speak_emote = list("жужжит")
	environment_smash = 1
	turns_per_move = 15
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat/slab/cazador_meat = 1, /obj/item/weapon/reagent_containers/food/snacks/f13/venomgland = 1)
	response_help = "тыкает"
	response_disarm = "толкает"
	response_harm = "бьёт"
	emote_taunt = list("жужжит")
	taunt_chance = 30
	move_to_delay = 2
	maxHealth = 100
	health = 100
	aggro_vision_range = 10
	idle_vision_range = 5
	movement_type = FLYING
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	self_weight = 40

	faction = list("hostile", "cazador")

	sound_speak = list('sound/f13npc/cazador_charge1.ogg','sound/f13npc/cazador_charge2.ogg','sound/f13npc/cazador_charge3.ogg')
	sound_speak_chance = 5

	aggro_sound_chance = 50
	aggro_sound = 'sound/f13npc/cazador_alert.ogg'

	death_sound = 'sound/f13npc/cazador_death.ogg'

	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 0.2, CLONE = 0, STAMINA = 1, OXY = 0)
	harm_intent_damage = 7
	melee_damage_lower = 5
	melee_damage_upper = 10
	attacktext = "жалит"
	attack_sound = 'sound/weapons/bite.ogg'

	XP = 7