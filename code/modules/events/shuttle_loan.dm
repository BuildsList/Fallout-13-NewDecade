#define HIJACK_SYNDIE 1
#define RUSKY_PARTY 2
#define SPIDER_GIFT 3
#define DEPARTMENT_RESUPPLY 4
#define ANTIDOTE_NEEDED 5
#define PIZZA_DELIVERY 6


/datum/round_event_control/shuttle_loan
	name = "Shuttle loan"
	typepath = /datum/round_event/shuttle_loan
	max_occurrences = 1
	earliest_start = 4000

/datum/round_event/shuttle_loan
	announceWhen = 1
	endWhen = 500
	var/dispatched = 0
	var/dispatch_type = 0
	var/bonus_points = 10000
	var/thanks_msg = "The cargo shuttle should return in five minutes. Have some supply points for your trouble."

/datum/round_event/shuttle_loan/start()
	dispatch_type = pick(HIJACK_SYNDIE, RUSKY_PARTY, SPIDER_GIFT, DEPARTMENT_RESUPPLY, ANTIDOTE_NEEDED, PIZZA_DELIVERY)

/datum/round_event/shuttle_loan/announce()
	SSshuttle.shuttle_loan = src
	switch(dispatch_type)
		if(HIJACK_SYNDIE)
			priority_announce("Cargo: The syndicate are trying to infiltrate your station. If you let them hijack your cargo shuttle, you'll save us a headache.","Centcom Counter Intelligence")
		if(RUSKY_PARTY)
			priority_announce("Cargo: A group of angry russians want to have a party, can you send them your cargo shuttle then make them disappear?","Centcom Russian Outreach Program")
		if(SPIDER_GIFT)
			priority_announce("Cargo: The Spider Clan has sent us a mysterious gift, can we ship it to you to see what's inside?","Centcom Diplomatic Corps")
		if(DEPARTMENT_RESUPPLY)
			priority_announce("Cargo: Seems we've ordered doubles of our department resupply packages this month. Can we send them to you?","Centcom Supply Department")
			thanks_msg = "The cargo shuttle should return in 5 minutes."
			bonus_points = 0
		if(ANTIDOTE_NEEDED)
			priority_announce("Cargo: Your station has been chosen for an epidemiological research project. Send us your cargo shuttle to receive your research samples.", "Centcom Research Initiatives")
		if (PIZZA_DELIVERY)
			priority_announce("Cargo: It looks like a neighbouring station accidentally delivered their pizza to you instead", "Centcom Spacepizza Division")

/datum/round_event/shuttle_loan/proc/loan_shuttle()
	priority_announce(thanks_msg, "Cargo shuttle commandeered by Centcom.")

	dispatched = 1
	SSshuttle.points += bonus_points
	endWhen = activeFor + 1

	SSshuttle.supply.mode = SHUTTLE_CALL
	SSshuttle.supply.destination = SSshuttle.getDock("supply_home")
	SSshuttle.supply.setTimer(3000)

	switch(dispatch_type)
		if(HIJACK_SYNDIE)
			SSshuttle.centcom_message += "Syndicate hijack team incoming."
		if(RUSKY_PARTY)
			SSshuttle.centcom_message += "Partying Russians incoming."
		if(SPIDER_GIFT)
			SSshuttle.centcom_message += "Spider Clan gift incoming."
		if(DEPARTMENT_RESUPPLY)
			SSshuttle.centcom_message += "Department resupply incoming."
		if(ANTIDOTE_NEEDED)
			SSshuttle.centcom_message += "Virus samples incoming."
		if(PIZZA_DELIVERY)
			SSshuttle.centcom_message += "Pizza delivery for [station_name()]"

/datum/round_event/shuttle_loan/tick()
	if(dispatched)
		if(SSshuttle.supply.mode != SHUTTLE_IDLE)
			endWhen = activeFor
		else
			endWhen = activeFor + 1

/datum/round_event/shuttle_loan/end()
	if(SSshuttle.shuttle_loan && SSshuttle.shuttle_loan.dispatched)
		//make sure the shuttle was dispatched in time
		SSshuttle.shuttle_loan = null

		var/list/empty_shuttle_turfs = list()
		for(var/turf/open/floor/T in SSshuttle.supply.areaInstance)
			if(T.density || T.contents.len)
				continue
			empty_shuttle_turfs += T
		if(!empty_shuttle_turfs.len)
			return

		var/list/shuttle_spawns = list()
		switch(dispatch_type)
			if(RUSKY_PARTY)
				var/datum/supply_pack/pack = SSshuttle.supply_packs[/datum/supply_pack/organic/party]
				pack.generate(pick_n_take(empty_shuttle_turfs))

				shuttle_spawns.Add(/mob/living/simple_animal/hostile/russian)
				shuttle_spawns.Add(/mob/living/simple_animal/hostile/russian/ranged)	//drops a mateba
				shuttle_spawns.Add(/mob/living/simple_animal/hostile/bear/russian)
				if(prob(75))
					shuttle_spawns.Add(/mob/living/simple_animal/hostile/russian)
				if(prob(50))
					shuttle_spawns.Add(/mob/living/simple_animal/hostile/bear/russian)

			if(ANTIDOTE_NEEDED)
				var/virus_type = pick(/datum/disease/beesease, /datum/disease/brainrot, /datum/disease/fluspanish)
				var/turf/T
				for(var/i=0, i<10, i++)
					if(prob(15))
						shuttle_spawns.Add(/obj/item/weapon/reagent_containers/glass/bottle)
					else if(prob(15))
						shuttle_spawns.Add(/obj/item/weapon/reagent_containers/syringe)
					else if(prob(25))
						shuttle_spawns.Add(/obj/item/weapon/shard)
					T = pick_n_take(empty_shuttle_turfs)
					var/obj/effect/decal/cleanable/blood/b = new(T)
					var/datum/disease/D = new virus_type()
					D.longevity = 1000
					b.viruses += D
					D.holder = b
				shuttle_spawns.Add(/obj/structure/closet/crate)
				shuttle_spawns.Add(/obj/item/weapon/reagent_containers/glass/bottle/pierrot_throat)
				shuttle_spawns.Add(/obj/item/weapon/reagent_containers/glass/bottle/magnitis)

			if(DEPARTMENT_RESUPPLY)
				var/list/crate_types = list(
					/datum/supply_pack/emergency/equipment,
					/datum/supply_pack/security/supplies,
					/datum/supply_pack/organic/food,
					/datum/supply_pack/emergency/weedcontrol,
					/datum/supply_pack/engineering/tools,
					/datum/supply_pack/engineering/engiequipment,
					/datum/supply_pack/science/robotics,
					/datum/supply_pack/science/plasma,
					/datum/supply_pack/medical/supplies
					)
				for(var/crate in crate_types)
					var/datum/supply_pack/pack = SSshuttle.supply_packs[crate]
					pack.generate(pick_n_take(empty_shuttle_turfs))

				for(var/i in 1 to 5)
					var/decal = pick(/obj/effect/decal/cleanable/flour, /obj/effect/decal/cleanable/robot_debris, /obj/effect/decal/cleanable/oil)
					new decal(pick_n_take(empty_shuttle_turfs))
			if(PIZZA_DELIVERY)
				shuttle_spawns.Add(/obj/item/pizzabox/margherita)
				shuttle_spawns.Add(/obj/item/pizzabox/margherita)
				shuttle_spawns.Add(/obj/item/pizzabox/meat)
				shuttle_spawns.Add(/obj/item/pizzabox/meat)
				shuttle_spawns.Add(/obj/item/pizzabox/vegetable)
				if(prob(10))
					shuttle_spawns.Add(/obj/item/pizzabox/bomb)
				else
					shuttle_spawns.Add(/obj/item/pizzabox/margherita)

		var/false_positive = 0
		while(shuttle_spawns.len && empty_shuttle_turfs.len)
			var/turf/T = pick_n_take(empty_shuttle_turfs)
			if(T.contents.len && false_positive < 5)
				false_positive++
				continue

			var/spawn_type = pick_n_take(shuttle_spawns)
			new spawn_type(T)

#undef HIJACK_SYNDIE
#undef RUSKY_PARTY
#undef SPIDER_GIFT
#undef DEPARTMENT_RESUPPLY
#undef ANTIDOTE_NEEDED
#undef PIZZA_DELIVERY
