/mob/living/carbon/human/gib_animation()
	new /obj/effect/overlay/temp/gib_animation(loc, "gibbed-h")

/mob/living/carbon/human/dust_animation()
	new /obj/effect/overlay/temp/gib_animation(loc, "gibbed-h")

/mob/living/carbon/human/spawn_gibs(with_bodyparts)
	if(with_bodyparts)
		new /obj/effect/gibspawner/human(loc, viruses, dna)
	else
		new /obj/effect/gibspawner/humanbodypartless(loc, viruses, dna)

/mob/living/carbon/human/spawn_dust()
	new /obj/effect/decal/remains/human(loc)

/mob/living/carbon/human/death(gibbed)
	if(stat == DEAD)
		return

	if(murder)
		if(murder != src)
			if(istype(murder, /mob/living/carbon/human))
				murder:karmaAdd(karma * -0.33)

	var/datum/atom_hud/antag/A = huds[ANTAG_HUD_RAIDER]
	A.leave_hud(src)

	if(status == "raider")
		ticker.mode.set_antag_hud(src, null)

	. = ..()

	dizziness = 0
	jitteriness = 0
	heart_attack = 0

	if(istype(loc, /obj/mecha))
		var/obj/mecha/M = loc
		if(M.occupant == src)
			M.go_out()

	dna.species.spec_death(gibbed, src)

	if(ticker && ticker.mode)
		sql_report_death(src)

/mob/living/carbon/human/proc/makeSkeleton()
	status_flags |= DISFIGURED
	set_species(/datum/species/skeleton)
	return 1


/mob/living/carbon/proc/Drain()
	become_husk()
	disabilities |= NOCLONE
	blood_volume = 0
	return 1
