#define MEDAL_PREFIX "Hierophant"
/*

The Hierophant

The Hierophant spawns in its arena, which makes fighting it challenging but not impossible.

The text this boss speaks is ROT4, use ROT22 to decode

The Hierophant's attacks are as follows, and INTENSIFY at a random chance based on Hierophant's health;
- Creates a cardinal or diagonal blast(Cross Blast) under its target, exploding after a short time.
	INTENSITY EFFECT: Creates one of the cross blast types under itself instead of under the target.
	INTENSITY EFFECT: The created Cross Blast fires in all directions if below half health.
- If no chasers exist, creates a chaser that will seek its target, leaving a trail of blasts.
	INTENSITY EFFECT: Creates a second, slower chaser.
- Creates an expanding AoE burst.
- INTENSE ATTACKS:
	If target is at least 2 tiles away; Blinks to the target after a very brief delay, damaging everything near the start and end points.
		As above, but does so multiple times if below half health.
	Rapidly creates Cross Blasts under a target.
	If chasers are off cooldown, creates four high-speed chasers.
- IF TARGET WAS STRUCK IN MELEE: Creates a 3x3 square of blasts under the target.

- IF TARGET IS OUTSIDE THE ARENA: Creates an arena around the target for 10 seconds, blinking to it if Hierophant is not in the arena.
	The arena has a 20 second cooldown, giving people a small window to get the fuck out.

Cross Blasts and the AoE burst gain additional range as Hierophant loses health, while Chasers gain additional speed.

When Hierophant dies, it stops trying to murder you and shrinks into a small form, which, while much weaker, is still quite effective.
- The smaller club can place a teleport beacon, allowing the user to teleport themself and their allies to the beacon.

Difficulty: Hard

*/

/mob/living/simple_animal/hostile/megafauna/hierophant
	name = "hierophant"
	desc = "A massive metal club that hangs in the air as though waiting. It'll make you dance to its beat."
	health = 2500
	maxHealth = 2500
	attacktext = "clubs"
	attack_sound = 'sound/weapons/sonic_jackhammer.ogg'
	icon_state = "hierophant"
	icon_living = "hierophant"
	friendly = "stares down"
	icon = 'icons/mob/lavaland/hierophant_new.dmi'
	faction = list("boss") //asteroid mobs? get that shit out of my beautiful square house
	speak_emote = list("preaches")
	armour_penetration = 50
	melee_damage_lower = 15
	melee_damage_upper = 15
	speed = 1
	move_to_delay = 10
	ranged = 1
	ranged_cooldown_time = 40
	aggro_vision_range = 21 //so it can see to one side of the arena to the other
	loot = list(/obj/item/weapon/hierophant_club)
	wander = FALSE
	var/burst_range = 3 //range on burst aoe
	var/beam_range = 5 //range on cross blast beams
	var/chaser_speed = 3 //how fast chasers are currently
	var/chaser_cooldown = 101 //base cooldown/cooldown var between spawning chasers
	var/major_attack_cooldown = 60 //base cooldown for major attacks
	var/arena_cooldown = 200 //base cooldown/cooldown var for creating an arena
	var/blinking = FALSE //if we're doing something that requires us to stand still and not attack
	var/obj/effect/hierophant/spawned_beacon //the beacon we teleport back to
	var/timeout_time = 15 //after this many Life() ticks with no target, we return to our beacon
	var/did_reset = TRUE //if we timed out, returned to our beacon, and healed some
	var/list/kill_phrases = list("Wsyvgi sj irivkc xettih. Vitemvmrk...", "Irivkc wsyvgi jsyrh. Vitemvmrk...", "Jyip jsyrh. Egxmzexmrk vitemv gcgpiw...", "Kix fiex. Liepmrk...")
	var/list/target_phrases = list("Xevkix psgexih.", "Iriqc jsyrh.", "Eguymvih xevkix.")
	medal_type = MEDAL_PREFIX
	score_type = BIRD_SCORE
	del_on_death = TRUE
	death_sound = 'sound/magic/Repulse.ogg'

/mob/living/simple_animal/hostile/megafauna/hierophant/New()
	..()
	internal = new/obj/item/device/gps/internal/hierophant(src)
	spawned_beacon = new(loc)

/mob/living/simple_animal/hostile/megafauna/hierophant/Life()
	. = ..()
	if(. && spawned_beacon && !QDELETED(spawned_beacon) && !client)
		if(target || loc == spawned_beacon.loc)
			timeout_time = initial(timeout_time)
		else
			timeout_time--
		if(timeout_time <= 0 && !did_reset)
			did_reset = TRUE
			visible_message("<span class='hierophant_warning'>\"Vixyvrmrk xs fewi...\"</span>")
			blink(spawned_beacon)
			adjustHealth(min((health - maxHealth) * 0.5, -250)) //heal for 50% of our missing health, minimum 10% of maximum health
			wander = FALSE
			if(health > maxHealth * 0.9)
				visible_message("<span class='hierophant'>\"Vitemvw gsqtpixi. Stivexmrk ex qebmqyq ijjmgmirgc.\"</span>")
			else
				visible_message("<span class='hierophant'>\"Vitemvw gsqtpixi. Stivexmsrep ijjmgmirgc gsqtvsqmwih.\"</span>")

/mob/living/simple_animal/hostile/megafauna/hierophant/death()
	if(health > 0 || stat == DEAD)
		return
	else
		stat = DEAD
		blinking = TRUE //we do a fancy animation, release a huge burst(), and leave our staff.
		burst_range = 10
		visible_message("<span class='hierophant'>\"Mrmxmexmrk wipj-hiwxvygx wiuyirgi...\"</span>")
		visible_message("<span class='hierophant_warning'>[src] shrinks, releasing a massive burst of energy!</span>")
		burst(get_turf(src))
		..()

/mob/living/simple_animal/hostile/megafauna/hierophant/Destroy()
	qdel(spawned_beacon)
	. = ..()

/mob/living/simple_animal/hostile/megafauna/hierophant/devour(mob/living/L)
	for(var/obj/item/W in L)
		if(!L.unEquip(W))
			qdel(W)
	visible_message(
		"<span class='hierophant_warning'>\"[pick(kill_phrases)]\"\n[src] annihilates [L]!</span>",
		"<span class='userdanger'>You annihilate [L], restoring your health!</span>")
	adjustHealth(-L.maxHealth*0.5)
	L.dust()

/mob/living/simple_animal/hostile/megafauna/hierophant/GiveTarget(new_target)
	var/targets_the_same = (new_target == target)
	. = ..()
	if(. && target && !targets_the_same)
		visible_message("<span class='hierophant_warning'>\"[pick(target_phrases)]\"</span>")
		if(spawned_beacon && loc == spawned_beacon.loc && did_reset)
			arena_trap(src)

/mob/living/simple_animal/hostile/megafauna/hierophant/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(src && . > 0 && !blinking)
		wander = TRUE
		did_reset = FALSE

/mob/living/simple_animal/hostile/megafauna/hierophant/AttackingTarget()
	if(!blinking)
		if(target && isliving(target))
			addtimer(CALLBACK(src, .proc/melee_blast, get_turf(target)), 0) //melee attacks on living mobs produce a 3x3 blast
		..()

/mob/living/simple_animal/hostile/megafauna/hierophant/DestroySurroundings()
	if(!blinking)
		..()

/mob/living/simple_animal/hostile/megafauna/hierophant/Move()
	if(!blinking)
		var/prevloc = loc
		. = ..()
		if(!stat && .)
			var/obj/effect/overlay/temp/hierophant/squares/HS = new /obj/effect/overlay/temp/hierophant/squares(prevloc)
			HS.dir = dir
			playsound(loc, 'sound/mecha/mechmove04.ogg', 150, 1, -4)
			if(target)
				arena_trap(target)

/mob/living/simple_animal/hostile/megafauna/hierophant/Goto(target, delay, minimum_distance)
	wander = TRUE
	if(!blinking)
		..()

/mob/living/simple_animal/hostile/megafauna/hierophant/proc/calculate_rage() //how angry we are overall
	did_reset = FALSE //oh hey we're doing SOMETHING, clearly we might need to heal if we recall
	anger_modifier = Clamp(((maxHealth - health) / 42),0,50)
	burst_range = initial(burst_range) + round(anger_modifier * 0.08)
	beam_range = initial(beam_range) + round(anger_modifier * 0.12)

/mob/living/simple_animal/hostile/megafauna/hierophant/OpenFire()
	calculate_rage()
	var/target_is_slow = FALSE
	if(isliving(target))
		var/mob/living/L = target
		if(!blinking && L.stat == DEAD && get_dist(src, L) > 2)
			blink(L)
			return
		if(L.movement_delay() > 1.5)
			target_is_slow = TRUE
	chaser_speed = max(1, (3 - anger_modifier * 0.04) + target_is_slow * 0.5)
	if(blinking)
		return

	arena_trap(target)
	ranged_cooldown = world.time + max(5, ranged_cooldown_time - anger_modifier * 0.75) //scale cooldown lower with high anger.

	if(prob(anger_modifier * 0.75)) //major ranged attack
		var/list/possibilities = list()
		var/cross_counter = 1 + round(anger_modifier * 0.12)
		if(cross_counter > 1)
			possibilities += "cross_blast_spam"
		if(get_dist(src, target) > 2)
			possibilities += "blink_spam"
		if(chaser_cooldown < world.time)
			if(prob(anger_modifier * 2))
				possibilities = list("chaser_swarm")
			else
				possibilities += "chaser_swarm"
		if(possibilities.len)
			ranged_cooldown = world.time + max(5, major_attack_cooldown - anger_modifier * 0.75) //we didn't cancel out of an attack, use the higher cooldown
			var/blink_counter = 1 + round(anger_modifier * 0.08)
			switch(pick(possibilities))
				if("blink_spam") //blink either once or multiple times.
					if(health < maxHealth * 0.5 && !target_is_slow && blink_counter > 1)
						visible_message("<span class='hierophant'>\"Mx ampp rsx iwgeti.\"</span>")
						var/oldcolor = color
						animate(src, color = "#660099", time = 6)
						while(health && target && blink_counter)
							if(loc == target.loc || loc == target) //we're on the same tile as them after about a second we can stop now
								break
							blink_counter--
							blinking = FALSE
							blink(target)
							blinking = TRUE
							sleep(5)
						animate(src, color = oldcolor, time = 8)
						addtimer(CALLBACK(src, /atom/proc/update_atom_colour), 8)
						sleep(8)
						blinking = FALSE
					else
						blink(target)
				if("cross_blast_spam") //fire a lot of cross blasts at a target.
					visible_message("<span class='hierophant'>\"Piezi mx rsalivi xs vyr.\"</span>")
					blinking = TRUE
					var/oldcolor = color
					animate(src, color = "#660099", time = 6)
					while(health && target && cross_counter)
						cross_counter--
						var/delay = 7
						if(prob(60))
							addtimer(CALLBACK(src, .proc/cardinal_blasts, target), 0)
						else
							addtimer(CALLBACK(src, .proc/diagonal_blasts, target), 0)
							delay = 5 //this one isn't so mean, so do the next one faster(if there is one)
						sleep(delay)
					animate(src, color = oldcolor, time = 8)
					addtimer(CALLBACK(src, /atom/proc/update_atom_colour), 8)
					sleep(8)
					blinking = FALSE
				if("chaser_swarm") //fire four fucking chasers at a target and their friends.
					visible_message("<span class='hierophant'>\"Mx gerrsx lmhi.\"</span>")
					blinking = TRUE
					var/oldcolor = color
					animate(src, color = "#660099", time = 10)
					var/list/targets = ListTargets()
					var/list/cardinal_copy = cardinal.Copy()
					while(health && targets.len && cardinal_copy.len)
						var/mob/living/pickedtarget = pick(targets)
						if(targets.len > 4)
							pickedtarget = pick_n_take(targets)
						if(!istype(pickedtarget) || pickedtarget.stat == DEAD)
							pickedtarget = target
						var/obj/effect/overlay/temp/hierophant/chaser/C = new /obj/effect/overlay/temp/hierophant/chaser(loc, src, pickedtarget, chaser_speed, FALSE)
						C.moving = 3
						C.moving_dir = pick_n_take(cardinal_copy)
						sleep(10)
					chaser_cooldown = world.time + initial(chaser_cooldown)
					animate(src, color = oldcolor, time = 8)
					addtimer(CALLBACK(src, /atom/proc/update_atom_colour), 8)
					sleep(8)
					blinking = FALSE
			return

	if(prob(10 + (anger_modifier * 0.5)) && get_dist(src, target) > 2)
		blink(target)

	else if(prob(70 - anger_modifier)) //a cross blast of some type
		if(prob(anger_modifier)) //at us?
			if(prob(anger_modifier * 2) && health < maxHealth * 0.5) //we're super angry do it at all dirs
				addtimer(CALLBACK(src, .proc/alldir_blasts, src), 0)
			else if(prob(60))
				addtimer(CALLBACK(src, .proc/cardinal_blasts, src), 0)
			else
				addtimer(CALLBACK(src, .proc/diagonal_blasts, src), 0)
		else //at them?
			if(prob(anger_modifier * 2) && health < maxHealth * 0.5 && !target_is_slow) //we're super angry do it at all dirs
				addtimer(CALLBACK(src, .proc/alldir_blasts, target), 0)
			else if(prob(60))
				addtimer(CALLBACK(src, .proc/cardinal_blasts, target), 0)
			else
				addtimer(CALLBACK(src, .proc/diagonal_blasts, target), 0)
	else if(chaser_cooldown < world.time) //if chasers are off cooldown, fire some!
		var/obj/effect/overlay/temp/hierophant/chaser/C = new /obj/effect/overlay/temp/hierophant/chaser(loc, src, target, chaser_speed, FALSE)
		chaser_cooldown = world.time + initial(chaser_cooldown)
		if((prob(anger_modifier) || target.Adjacent(src)) && target != src)
			var/obj/effect/overlay/temp/hierophant/chaser/OC = new /obj/effect/overlay/temp/hierophant/chaser(loc, src, target, max(1.5, 5 - anger_modifier * 0.07), FALSE)
			OC.moving = 4
			OC.moving_dir = pick(cardinal - C.moving_dir)
	else //just release a burst of power
		addtimer(CALLBACK(src, .proc/burst, get_turf(src)), 0)

/mob/living/simple_animal/hostile/megafauna/hierophant/proc/diagonal_blasts(mob/victim) //fire diagonal cross blasts with a delay
	var/turf/T = get_turf(victim)
	if(!T)
		return
	new /obj/effect/overlay/temp/hierophant/telegraph/diagonal(T, src)
	playsound(T,'sound/effects/bin_close.ogg', 200, 1)
	sleep(2)
	new /obj/effect/overlay/temp/hierophant/blast(T, src, FALSE)
	for(var/d in diagonals)
		addtimer(CALLBACK(src, .proc/blast_wall, T, d), 0)

/mob/living/simple_animal/hostile/megafauna/hierophant/proc/cardinal_blasts(mob/victim) //fire cardinal cross blasts with a delay
	var/turf/T = get_turf(victim)
	if(!T)
		return
	new /obj/effect/overlay/temp/hierophant/telegraph/cardinal(T, src)
	playsound(T,'sound/effects/bin_close.ogg', 200, 1)
	sleep(2)
	new /obj/effect/overlay/temp/hierophant/blast(T, src, FALSE)
	for(var/d in cardinal)
		addtimer(CALLBACK(src, .proc/blast_wall, T, d), 0)

/mob/living/simple_animal/hostile/megafauna/hierophant/proc/alldir_blasts(mob/victim) //fire alldir cross blasts with a delay
	var/turf/T = get_turf(victim)
	if(!T)
		return
	new /obj/effect/overlay/temp/hierophant/telegraph(T, src)
	playsound(T,'sound/effects/bin_close.ogg', 200, 1)
	sleep(2)
	new /obj/effect/overlay/temp/hierophant/blast(T, src, FALSE)
	for(var/d in alldirs)
		addtimer(CALLBACK(src, .proc/blast_wall, T, d), 0)

/mob/living/simple_animal/hostile/megafauna/hierophant/proc/blast_wall(turf/T, set_dir) //make a wall of blasts beam_range tiles long
	var/range = beam_range
	var/turf/previousturf = T
	var/turf/J = get_step(previousturf, set_dir)
	for(var/i in 1 to range)
		new /obj/effect/overlay/temp/hierophant/blast(J, src, FALSE)
		previousturf = J
		J = get_step(previousturf, set_dir)

/mob/living/simple_animal/hostile/megafauna/hierophant/proc/arena_trap(mob/victim) //trap a target in an arena
	var/turf/T = get_turf(victim)
	if(!istype(victim) || victim.stat == DEAD || !T || arena_cooldown > world.time)
		return
	if((istype(get_area(T), /area/ruin/unpowered/hierophant) || istype(get_area(src), /area/ruin/unpowered/hierophant)) && victim != src)
		return
	arena_cooldown = world.time + initial(arena_cooldown)
	for(var/d in cardinal)
		addtimer(CALLBACK(src, .proc/arena_squares, T, d), 0)
	for(var/t in RANGE_TURFS(11, T))
		if(t && get_dist(t, T) == 11)
			new /obj/effect/overlay/temp/hierophant/wall(t)
			new /obj/effect/overlay/temp/hierophant/blast(t, src, FALSE)
	if(get_dist(src, T) >= 11) //hey you're out of range I need to get closer to you!
		addtimer(CALLBACK(src, .proc/blink, T), 0)

/mob/living/simple_animal/hostile/megafauna/hierophant/proc/arena_squares(turf/T, set_dir) //make a fancy effect extending from the arena target
	var/turf/previousturf = T
	var/turf/J = get_step(previousturf, set_dir)
	for(var/i in 1 to 10)
		var/obj/effect/overlay/temp/hierophant/squares/HS = new /obj/effect/overlay/temp/hierophant/squares(J)
		HS.dir = set_dir
		previousturf = J
		J = get_step(previousturf, set_dir)
		sleep(0.5)

/mob/living/simple_animal/hostile/megafauna/hierophant/proc/blink(mob/victim) //blink to a target
	if(blinking || !victim)
		return
	var/turf/T = get_turf(victim)
	var/turf/source = get_turf(src)
	new /obj/effect/overlay/temp/hierophant/telegraph(T, src)
	new /obj/effect/overlay/temp/hierophant/telegraph(source, src)
	playsound(T,'sound/magic/Wand_Teleport.ogg', 200, 1)
	playsound(source,'sound/machines/AirlockOpen.ogg', 200, 1)
	blinking = TRUE
	sleep(2) //short delay before we start...
	new /obj/effect/overlay/temp/hierophant/telegraph/teleport(T, src)
	new /obj/effect/overlay/temp/hierophant/telegraph/teleport(source, src)
	for(var/t in RANGE_TURFS(1, T))
		var/obj/effect/overlay/temp/hierophant/blast/B = new /obj/effect/overlay/temp/hierophant/blast(t, src, FALSE)
		B.damage = 30
	for(var/t in RANGE_TURFS(1, source))
		var/obj/effect/overlay/temp/hierophant/blast/B = new /obj/effect/overlay/temp/hierophant/blast(t, src, FALSE)
		B.damage = 30
	animate(src, alpha = 0, time = 2, easing = EASE_OUT) //fade out
	sleep(1)
	visible_message("<span class='hierophant_warning'>[src] fades out!</span>")
	density = FALSE
	sleep(2)
	forceMove(T)
	sleep(1)
	animate(src, alpha = 255, time = 2, easing = EASE_IN) //fade IN
	sleep(1)
	density = TRUE
	visible_message("<span class='hierophant_warning'>[src] fades in!</span>")
	sleep(1) //at this point the blasts we made detonate
	blinking = FALSE

/mob/living/simple_animal/hostile/megafauna/hierophant/proc/melee_blast(mob/victim) //make a 3x3 blast around a target
	if(!victim)
		return
	var/turf/T = get_turf(victim)
	if(!T)
		return
	new /obj/effect/overlay/temp/hierophant/telegraph(T, src)
	playsound(T,'sound/effects/bin_close.ogg', 200, 1)
	sleep(2)
	for(var/t in RANGE_TURFS(1, T))
		new /obj/effect/overlay/temp/hierophant/blast(t, src, FALSE)

/mob/living/simple_animal/hostile/megafauna/hierophant/proc/burst(turf/original) //release a wave of blasts
	playsound(original,'sound/machines/AirlockOpen.ogg', 200, 1)
	var/last_dist = 0
	for(var/t in spiral_range_turfs(burst_range, original))
		var/turf/T = t
		if(!T)
			continue
		var/dist = get_dist(original, T)
		if(dist > last_dist)
			last_dist = dist
			sleep(1 + min(burst_range - last_dist, 12) * 0.5) //gets faster as it gets further out
		new /obj/effect/overlay/temp/hierophant/blast(T, src, FALSE)

/mob/living/simple_animal/hostile/megafauna/hierophant/AltClickOn(atom/A) //player control handler(don't give this to a player holy fuck)
	if(!istype(A) || get_dist(A, src) <= 2)
		return
	blink(A)

//Hierophant overlays
/obj/effect/overlay/temp/hierophant
	name = "vortex energy"
	layer = BELOW_MOB_LAYER
	var/mob/living/caster //who made this, anyway

/obj/effect/overlay/temp/hierophant/New(loc, new_caster)
	..()
	if(new_caster)
		caster = new_caster

/obj/effect/overlay/temp/hierophant/squares
	icon_state = "hierophant_squares"
	duration = 3
	light_range = 1
	randomdir = FALSE

/obj/effect/overlay/temp/hierophant/squares/New(loc, new_caster)
	..()
	if(ismineralturf(loc))
		var/turf/closed/mineral/M = loc
		M.gets_drilled(caster)

/obj/effect/overlay/temp/hierophant/wall //smoothing and pooling are not friends. TODO: figure this out
	name = "vortex wall"
	icon = 'icons/turf/walls/hierophant_wall_temp.dmi'
	icon_state = "wall"
	light_range = 1
	duration = 100
	smooth = SMOOTH_TRUE

/obj/effect/overlay/temp/hierophant/wall/New(loc, new_caster)
	..()
	queue_smooth_neighbors(src)
	queue_smooth(src)

/obj/effect/overlay/temp/hierophant/wall/Destroy()
	queue_smooth_neighbors(src)
	..()
	return QDEL_HINT_QUEUE

/obj/effect/overlay/temp/hierophant/wall/CanPass(atom/movable/mover, turf/target, height = 0)
	if(mover == caster)
		return TRUE
	return FALSE

/obj/effect/overlay/temp/hierophant/chaser //a hierophant's chaser. follows target around, moving and producing a blast every speed deciseconds.
	duration = 98
	var/mob/living/target //what it's following
	var/turf/targetturf //what turf the target is actually on
	var/moving_dir //what dir it's moving in
	var/previous_moving_dir //what dir it was moving in before that
	var/more_previouser_moving_dir //what dir it was moving in before THAT
	var/moving = 0 //how many steps to move before recalculating
	var/standard_moving_before_recalc = 4 //how many times we step before recalculating normally
	var/tiles_per_step = 1 //how many tiles we move each step
	var/speed = 3 //how many deciseconds between each step
	var/currently_seeking = FALSE
	var/friendly_fire_check = FALSE //if blasts produced apply friendly fire

/obj/effect/overlay/temp/hierophant/chaser/New(loc, new_caster, new_target, new_speed, is_friendly_fire)
	..()
	target = new_target
	friendly_fire_check = is_friendly_fire
	if(new_speed)
		speed = new_speed
	addtimer(CALLBACK(src, .proc/seek_target), 1)

/obj/effect/overlay/temp/hierophant/chaser/proc/get_target_dir()
	. = get_cardinal_dir(src, targetturf)
	if((. != previous_moving_dir && . == more_previouser_moving_dir) || . == 0) //we're alternating, recalculate
		var/list/cardinal_copy = cardinal.Copy()
		cardinal_copy -= more_previouser_moving_dir
		. = pick(cardinal_copy)

/obj/effect/overlay/temp/hierophant/chaser/proc/seek_target()
	if(!currently_seeking)
		currently_seeking = TRUE
		targetturf = get_turf(target)
		while(target && src && !QDELETED(src) && currently_seeking && x && y && targetturf) //can this target actually be sook out
			if(!moving) //we're out of tiles to move, find more and where the target is!
				more_previouser_moving_dir = previous_moving_dir
				previous_moving_dir = moving_dir
				moving_dir = get_target_dir()
				var/standard_target_dir = get_cardinal_dir(src, targetturf)
				if((standard_target_dir != previous_moving_dir && standard_target_dir == more_previouser_moving_dir) || standard_target_dir == 0)
					moving = 1 //we would be repeating, only move a tile before checking
				else
					moving = standard_moving_before_recalc
			if(moving) //move in the dir we're moving in right now
				var/turf/T = get_turf(src)
				for(var/i in 1 to tiles_per_step)
					var/maybe_new_turf = get_step(T, moving_dir)
					if(maybe_new_turf)
						T = maybe_new_turf
					else
						break
				forceMove(T)
				make_blast() //make a blast, too
				moving--
				sleep(speed)
			targetturf = get_turf(target)

/obj/effect/overlay/temp/hierophant/chaser/proc/make_blast()
	new /obj/effect/overlay/temp/hierophant/blast(loc, caster, friendly_fire_check)

/obj/effect/overlay/temp/hierophant/telegraph
	icon = 'icons/effects/96x96.dmi'
	icon_state = "hierophant_telegraph"
	pixel_x = -32
	pixel_y = -32
	duration = 3

/obj/effect/overlay/temp/hierophant/telegraph/diagonal
	icon_state = "hierophant_telegraph_diagonal"

/obj/effect/overlay/temp/hierophant/telegraph/cardinal
	icon_state = "hierophant_telegraph_cardinal"

/obj/effect/overlay/temp/hierophant/telegraph/teleport
	icon_state = "hierophant_telegraph_teleport"
	duration = 9

/obj/effect/overlay/temp/hierophant/telegraph/edge
	icon_state = "hierophant_telegraph_edge"
	duration = 40

/obj/effect/overlay/temp/hierophant/blast
	icon_state = "hierophant_blast"
	name = "vortex blast"
	light_range = 1
	desc = "Get out of the way!"
	duration = 9
	var/damage = 10 //how much damage do we do?
	var/list/hit_things = list() //we hit these already, ignore them
	var/friendly_fire_check = FALSE
	var/bursting = FALSE //if we're bursting and need to hit anyone crossing us

/obj/effect/overlay/temp/hierophant/blast/New(loc, new_caster, friendly_fire)
	..()
	friendly_fire_check = friendly_fire
	if(new_caster)
		hit_things += new_caster
	if(ismineralturf(loc)) //drill mineral turfs
		var/turf/closed/mineral/M = loc
		M.gets_drilled(caster)
	addtimer(CALLBACK(src, .proc/blast), 0)

/obj/effect/overlay/temp/hierophant/blast/proc/blast()
	var/turf/T = get_turf(src)
	if(!T)
		return
	playsound(T,'sound/magic/Blind.ogg', 125, 1, -5) //make a sound
	sleep(6) //wait a little
	bursting = TRUE
	do_damage(T) //do damage and mark us as bursting
	sleep(1.3) //slightly forgiving; the burst animation is 1.5 deciseconds
	bursting = FALSE //we no longer damage crossers

/obj/effect/overlay/temp/hierophant/blast/Crossed(atom/movable/AM)
	..()
	if(bursting)
		do_damage(get_turf(src))

/obj/effect/overlay/temp/hierophant/blast/proc/do_damage(turf/T)
	for(var/mob/living/L in T.contents - hit_things) //find and damage mobs...
		hit_things += L
		if((friendly_fire_check && caster && caster.faction_check(L)) || L.stat == DEAD)
			continue
		if(L.client)
			flash_color(L.client, "#660099", 1)
		playsound(L,'sound/weapons/sear.ogg', 50, 1, -4)
		to_chat(L, "<span class='userdanger'>You're struck by a [name]!</span>")
		var/limb_to_hit = L.get_bodypart(pick("head", "chest", "r_arm", "l_arm", "r_leg", "l_leg"))
		var/armor = L.run_armor_check(limb_to_hit, "melee", "Your armor absorbs [src]!", "Your armor blocks part of [src]!", 50, "Your armor was penetrated by [src]!")
		L.apply_damage(damage, BURN, limb_to_hit, armor)
		if(ismegafauna(L) || istype(L, /mob/living/simple_animal/hostile/asteroid))
			L.adjustBruteLoss(damage)
		add_logs(caster, L, "struck with a [name]")
	for(var/obj/mecha/M in T.contents - hit_things) //and mechs.
		hit_things += M
		if(M.occupant)
			if(friendly_fire_check && caster && caster.faction_check(M.occupant))
				continue
			to_chat(M.occupant, "<span class='userdanger'>Your [M.name] is struck by a [name]!</span>")
		playsound(M,'sound/weapons/sear.ogg', 50, 1, -4)
		M.take_damage(damage, BURN, 0, 0)

/obj/effect/hierophant
	name = "hierophant beacon"
	desc = "A strange beacon, allowing mass teleportation for those able to use it."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "hierophant_tele_off"
	light_range = 2
	layer = LOW_OBJ_LAYER
	anchored = TRUE

/obj/effect/hierophant/ex_act()
	return

/obj/effect/hierophant/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/hierophant_club))
		var/obj/item/weapon/hierophant_club/H = I
		if(H.timer > world.time)
			return
		if(H.beacon == src)
			to_chat(user, "<span class='notice'>You start removing your hierophant beacon...</span>")
			H.timer = world.time + 51
			addtimer(CALLBACK(H, /obj/item/weapon/hierophant_club.proc/prepare_icon_update), 0)
			if(do_after(user, 50, target = src))
				playsound(src,'sound/magic/Blind.ogg', 200, 1, -4)
				new /obj/effect/overlay/temp/hierophant/telegraph/teleport(get_turf(src), user)
				to_chat(user, "<span class='hierophant_warning'>You collect [src], reattaching it to the club!</span>")
				H.beacon = null
				user.update_action_buttons_icon()
				qdel(src)
			else
				H.timer = world.time
				addtimer(CALLBACK(H, /obj/item/weapon/hierophant_club.proc/prepare_icon_update), 0)
		else
			to_chat(user, "<span class='hierophant_warning'>You touch the beacon with the club, but nothing happens.</span>")
	else
		return ..()

/obj/item/device/gps/internal/hierophant
	icon_state = null
	gpstag = "Zealous Signal"
	desc = "Heed its words."
	invisibility = 100

#undef MEDAL_PREFIX