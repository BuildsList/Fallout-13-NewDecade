/datum/disease/transformation
	name = "Transformation"
	max_stages = 5
	spread_text = "Acute"
	spread_flags = SPECIAL
	cure_text = "A coder's love (theoretical)."
	agent = "Shenanigans"
	viable_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey, /mob/living/carbon/alien)
	severity = HARMFUL
	stage_prob = 10
	visibility_flags = HIDDEN_SCANNER|HIDDEN_PANDEMIC
	disease_flags = CURABLE
	var/list/stage1 = list("You feel unremarkable.")
	var/list/stage2 = list("You feel boring.")
	var/list/stage3 = list("You feel utterly plain.")
	var/list/stage4 = list("You feel white bread.")
	var/list/stage5 = list("Oh the humanity!")
	var/new_form = /mob/living/carbon/human

/datum/disease/transformation/stage_act()
	..()
	switch(stage)
		if(1)
			if (prob(stage_prob) && stage1)
				to_chat(affected_mob, pick(stage1))
		if(2)
			if (prob(stage_prob) && stage2)
				to_chat(affected_mob, pick(stage2))
		if(3)
			if (prob(stage_prob*2) && stage3)
				to_chat(affected_mob, pick(stage3))
		if(4)
			if (prob(stage_prob*2) && stage4)
				to_chat(affected_mob, pick(stage4))
		if(5)
			do_disease_transformation(affected_mob)

/datum/disease/transformation/proc/do_disease_transformation(mob/living/affected_mob)
	if(istype(affected_mob, /mob/living/carbon) && affected_mob.stat != DEAD)
		if(stage5)
			to_chat(affected_mob, pick(stage5))
		if(jobban_isbanned(affected_mob, new_form))
			affected_mob.death(1)
			return
		if(affected_mob.notransform)
			return
		affected_mob.notransform = 1
		for(var/obj/item/W in affected_mob.get_equipped_items())
			affected_mob.unEquip(W)
		for(var/obj/item/I in affected_mob.held_items)
			affected_mob.unEquip(I)
		var/mob/living/new_mob = new new_form(affected_mob.loc)
		if(istype(new_mob))
			new_mob.a_intent = INTENT_HARM
			if(affected_mob.mind)
				affected_mob.mind.transfer_to(new_mob)
			else
				new_mob.key = affected_mob.key

		new_mob.name = affected_mob.real_name
		new_mob.real_name = new_mob.name
		qdel(affected_mob)

/datum/disease/transformation/robot

	name = "Robotic Transformation"
	cure_text = "An injection of copper."
	cures = list("copper")
	cure_chance = 5
	agent = "R2D2 Nanomachines"
	desc = "This disease, actually acute nanomachine infection, converts the victim into a cyborg."
	severity = DANGEROUS
	visibility_flags = 0
	stage1	= null
	stage2	= list("Your joints feel stiff.", "<span class='danger'>Beep...boop..</span>")
	stage3	= list("<span class='danger'>Your joints feel very stiff.</span>", "Your skin feels loose.", "<span class='danger'>You can feel something move...inside.</span>")
	stage4	= list("<span class='danger'>Your skin feels very loose.</span>", "<span class='danger'>You can feel... something...inside you.</span>")
	stage5	= list("<span class='danger'>Your skin feels as if it's about to burst off!</span>")
	new_form = /mob/living/silicon/robot


/datum/disease/transformation/robot/stage_act()
	..()
	switch(stage)
		if(3)
			if (prob(8))
				affected_mob.say(pick("Beep, boop", "beep, beep!", "Boop...bop"))
			if (prob(4))
				to_chat(affected_mob, "<span class='danger'>You feel a stabbing pain in your head.</span>")
				affected_mob.Paralyse(2)
		if(4)
			if (prob(20))
				affected_mob.say(pick("beep, beep!", "Boop bop boop beep.", "kkkiiiill mmme", "I wwwaaannntt tttoo dddiiieeee..."))


/datum/disease/transformation/xeno/stage_act()
	..()
	switch(stage)
		if(3)
			if (prob(4))
				to_chat(affected_mob, "<span class='danger'>You feel a stabbing pain in your head.</span>")
				affected_mob.Paralyse(2)
		if(4)
			if (prob(20))
				affected_mob.say(pick("You look delicious.", "Going to... devour you...", "Hsssshhhhh!"))

/datum/disease/transformation/corgi
	name = "The Barkening"
	cure_text = "Death"
	cures = list("adminordrazine")
	agent = "Fell Doge Majicks"
	desc = "This disease transforms the victim into a corgi."
	visibility_flags = 0
	stage1	= list("BARK.")
	stage2	= list("You feel the need to wear silly hats.")
	stage3	= list("<span class='danger'>Must... eat... chocolate....</span>", "<span class='danger'>YAP</span>")
	stage4	= list("<span class='danger'>Visions of washing machines assail your mind!</span>")
	stage5	= list("<span class='danger'>AUUUUUU!!!</span>")
	new_form = /mob/living/simple_animal/pet/dog/corgi

/datum/disease/transformation/corgi/stage_act()
	..()
	switch(stage)
		if(3)
			if (prob(8))
				affected_mob.say(pick("YAP", "Woof!"))
		if(4)
			if (prob(20))
				affected_mob.say(pick("Bark!", "AUUUUUU"))