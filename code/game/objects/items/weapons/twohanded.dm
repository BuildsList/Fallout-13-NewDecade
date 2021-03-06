/* Two-handed Weapons
 * Contains:
 * 		Twohanded
 *		Fireaxe
 *		Double-Bladed Energy Swords
 *		Spears
 *		CHAINSAWS
 *		Bone Axe and Spear
 */

/*##################################################################
##################### TWO HANDED WEAPONS BE HERE~ -Agouri :3 ########
####################################################################*/

//Rewrote TwoHanded weapons stuff and put it all here. Just copypasta fireaxe to make new ones ~Carn
//This rewrite means we don't have two variables for EVERY item which are used only by a few weapons.
//It also tidies stuff up elsewhere.


//I rewrote stuff again. Now any weapon can be twohanded by pressing the UI button. - Matt



/*
 * Twohanded
 */
/obj/item/weapon
	var/wielded = 0
	var/force_unwielded = 0
	var/force_wielded = 0
	var/wieldsound = 'sound/weapons/thudswoosh.ogg'//A familiar grab sound.
	var/unwieldsound = null
	var/wielded_icon = null

/obj/item/weapon/proc/unwield(mob/living/carbon/user, show_message = TRUE)
	if(!wielded || !user) return
	wielded = 0
	if(force_unwielded)
		force = force_unwielded
	else
		force = (force / 1.5)
	var/sf = findtext_char(name," (Wielded)")
	if(sf)
		name = copytext_char(name,1,sf)
	else //something wrong
		name = "[initial(name)]"
	update_unwield_icon()
	update_icon()
	if(iscyborg(user))
		to_chat(user, "<span class='notice'>You free up your module.</span>")
	else
		user.visible_message("<span class='warning'>[user] освобождает свою вторую руку.")
	if(unwieldsound)
		playsound(loc, unwieldsound, 50, 1)
	var/obj/item/weapon/twohanded/offhand/O = user.get_inactive_held_item()
	if(O && istype(O))
		O.unwield()
	return

/obj/item/weapon/proc/wield(mob/living/carbon/user)
	if(wielded)
		return

	if(ismonkey(user))
		to_chat(user, "<span class='warning'>It's too heavy for you to wield fully.</span>")
		return
	if(user.get_inactive_held_item())
		to_chat(user, "<span class='warning'>You need your other hand to be empty!</span>")
		return
	if(user.get_num_arms() < 2)
		to_chat(user, "<span class='warning'>You don't have enough hands.</span>")
		return
	wielded = 1
	if(force_wielded)
		force = force_wielded
	else
		force = (force * 1.5)
	name = "wielded [name]"
	update_wield_icon()
	update_icon()//Legacy
	if(iscyborg(user))
		user.visible_message("<span class='warning'>[user] dedicates a module to the [initial(name)]s.")
	else
		user.visible_message("<span class='warning'>[user] хватает [initial(name)] обеими руками.")
	if(wieldsound)
		playsound(loc, wieldsound, 50, 1)
	var/obj/item/weapon/twohanded/offhand/O = new(user) ////Let's reserve his other hand~
	O.name = "[name] - offhand"
	O.desc = "Your second grip on the [name]"
	user.put_in_inactive_hand(O)
	return

/obj/item/weapon/proc/update_wield_icon()
	if((wielded) && wielded_icon)
		item_state = wielded_icon

/obj/item/weapon/proc/update_unwield_icon()//That way it doesn't interupt any other special icon_states.
	if((wielded) && wielded_icon)
		item_state = "[initial(item_state)]"

//For general weapons.
/obj/item/proc/attempt_wield(mob/user)
	if(istype(src,/obj/item/weapon))//Istype hack to stop the proc from crashing if what you try to wield isn't a weapon.
		var/obj/item/weapon/W = src
		if(W.wielded) //Trying to unwield it
			W.unwield(user)
		else //Trying to wield it
			W.wield(user)

/obj/item/weapon/dropped(mob/user)
	..()
	//handles unwielding a twohanded weapon when dropped as well as clearing up the offhand
	if(!wielded)
		return
	if(user)
		var/obj/item/weapon/twohanded/O = user.get_inactive_held_item()
		if(istype(O))
			O.unwield(user, FALSE)
	unwield(user)

/obj/item/weapon/twohanded/update_icon()
	return

//Keeping in the attack_self code for legacy purposes.
/obj/item/weapon/twohanded/attack_self(mob/user)
	..()
	if(wielded) //Trying to unwield it
		unwield(user)
	else //Trying to wield it
		wield(user)

/obj/item/weapon/equip_to_best_slot(mob/M)
	if(..())
		unwield(M)
		return

/obj/item/weapon/equipped(mob/user, slot)
	..()
	if(!user.is_holding(src) && wielded && !istype(src, /obj/item/weapon/twohanded/required))
		unwield(user)

///////////OFFHAND///////////////
/obj/item/weapon/twohanded/offhand
	name = "занятая рука"
	icon_state = "offhand"
	self_weight = 0
	flags = ABSTRACT | NODROP
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/item/weapon/twohanded/offhand/unwield()
	//if(wielded)//Only delete if we're wielded
	wielded = FALSE
	qdel(src)

/obj/item/weapon/twohanded/offhand/wield()
	if(wielded)//Only delete if we're wielded
		wielded = FALSE
		qdel(src)

/obj/item/weapon/twohanded/offhand/attack_self(mob/living/carbon/user)		//You should never be able to do this in standard use of two handed items. This is a backup for lingering offhands.
	var/obj/item/weapon/twohanded/O = user.get_inactive_held_item()
	if (istype(O) && !istype(O, /obj/item/weapon/twohanded/offhand/))		//If you have a proper item in your other hand that the offhand is for, do nothing. This should never happen.
		return
	if (QDELETED(src))
		return
	qdel(src)																//If it's another offhand, or literally anything else, qdel. If I knew how to add logging messages I'd put one here.

///////////Two hand required objects///////////////
//This is for objects that require two hands to even pick up
/obj/item/weapon/twohanded/required
	w_class = WEIGHT_CLASS_HUGE

/obj/item/weapon/twohanded/required/attack_self()
	return

/obj/item/weapon/twohanded/required/mob_can_equip(mob/M, mob/equipper, slot, disable_warning = 0)
	if(wielded && !slot_flags)
		to_chat(M, "<span class='warning'>[src] is too cumbersome to carry with anything but your hands!</span>")
		return 0
	return ..()

/obj/item/weapon/twohanded/required/attack_hand(mob/user)//Can't even pick it up without both hands empty
	var/obj/item/weapon/twohanded/required/H = user.get_inactive_held_item()
	if(get_dist(src,user) > 1)
		return
	if(H != null)
		to_chat(user, "<span class='notice'>[src] is too cumbersome to carry in one hand!</span>")
		return
	if(src.loc != user)
		wield(user)
	..()

/obj/item/weapon/twohanded/required/equipped(mob/user, slot)
	..()
	var/slotbit = slotdefine2slotbit(slot)
	if(slot_flags & slotbit)
		var/datum/O = user.is_holding_item_of_type(/obj/item/weapon/twohanded/offhand)
		if(!O || QDELETED(O))
			return
		qdel(O)
		return
	if(slot == slot_hands)
		wield(user)
	else
		unwield(user)

/obj/item/weapon/twohanded/required/wield(mob/living/carbon/user)
	..()
	if(!wielded)
		user.unEquip(src)

/obj/item/weapon/twohanded/required/unwield(mob/living/carbon/user, show_message = TRUE)
	if(show_message)
		to_chat(user, "<span class='notice'>You drop [src].</span>")
	..(user, FALSE)
	user.unEquip(src)

/*
 * Fireaxe
 */
/obj/item/weapon/twohanded/fireaxe  // DEM AXES MAN, marker -Agouri
	icon_state = "fireaxe0"
	name = "пожарный топор"
	desc = "Truly, the weapon of a madman. Who would think to fight fire with an axe?"
	force = 5
	throwforce = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = SLOT_BACK
	force_unwielded = 5
	force_wielded = 24
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = IS_SHARP
	obj_integrity = 200
	max_integrity = 200
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 100, acid = 30)
	resistance_flags = FIRE_PROOF

/obj/item/weapon/twohanded/fireaxe/update_icon()  //Currently only here to fuck with the on-mob icons.
	icon_state = "fireaxe[wielded]"
	return

/obj/item/weapon/twohanded/fireaxe/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] axes [user.p_them()]self from head to toe! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (BRUTELOSS)

/obj/item/weapon/twohanded/fireaxe/afterattack(atom/A, mob/user, proximity)
	if(!proximity)
		return
	if(wielded) //destroys windows and grilles in one hit
		if(istype(A,/obj/structure/window))
			var/obj/structure/window/W = A
			W.take_damage(200, BRUTE, "melee", 0)
		else if(istype(A,/obj/structure/grille))
			var/obj/structure/grille/G = A
			G.take_damage(40, BRUTE, "melee", 0)

/obj/item/weapon/twohanded/lumberaxe  // DEM AXES MAN, marker -Agouri
	icon_state = "lumberjack"
	name = "lumber axe"
	flags = CONDUCT
	desc = "An axe for chopping wood, or heads. This one appears to be leaning more towards heads."
	force = 32
	throwforce = 15
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = SLOT_BELT | SLOT_BACK
	attack_verb = list("attacked", "slashed", "bashed", "sliced", "torn", "ripped", "chopped")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = IS_SHARP
	obj_integrity = 200
	max_integrity = 200
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 100, acid = 30)
	resistance_flags = FIRE_PROOF

/obj/item/weapon/twohanded/lumberaxe/update_icon()  //Currently only here to fuck with the on-mob icons.
	icon_state = "lumberjack"
	return

/obj/item/weapon/twohanded/lumberaxe/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] axes [user.p_them()]self from head to toe! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (BRUTELOSS)

/obj/item/weapon/twohanded/lumberaxe/afterattack(atom/A, mob/user, proximity)
	if(!proximity)
		return
	if(wielded) //destroys windows and grilles in one hit
		if(istype(A,/obj/structure/window))
			var/obj/structure/window/W = A
			W.take_damage(200, BRUTE, "melee", 0)
		else if(istype(A,/obj/structure/grille))
			var/obj/structure/grille/G = A
			G.take_damage(40, BRUTE, "melee", 0)

/*
 * Double-Bladed Energy Swords - Cheridan
 */
/obj/item/weapon/twohanded/dualsaber
	icon_state = "dualsaber0"
	name = "double-bladed energy sword"
	desc = "Handle with care."
	force = 3
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	var/w_class_on = WEIGHT_CLASS_BULKY
	force_unwielded = 3
	force_wielded = 34
	wieldsound = 'sound/weapons/saberon.ogg'
	unwieldsound = 'sound/weapons/saberoff.ogg'
	hitsound = "swing_hit"
	armour_penetration = 35
	origin_tech = "magnets=4;syndicate=5"
	item_color = "green"
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	block_chance = 75
	obj_integrity = 200
	max_integrity = 200
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 100, acid = 70)
	resistance_flags = FIRE_PROOF
	var/hacked = 0

/obj/item/weapon/twohanded/dualsaber/New()
	..()
	item_color = pick("red", "blue", "green", "purple")

/obj/item/weapon/twohanded/dualsaber/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/weapon/twohanded/dualsaber/update_icon()
	if(wielded)
		icon_state = "dualsaber[item_color][wielded]"
	else
		icon_state = "dualsaber0"
	clean_blood()//blood overlays get weird otherwise, because the sprite changes.

/obj/item/weapon/twohanded/dualsaber/attack(mob/target, mob/living/carbon/human/user)
	if(user.has_dna())
		if(user.dna.check_mutation(HULK))
			to_chat(user, "<span class='warning'>You grip the blade too hard and accidentally close it!</span>")
			unwield()
			return
	..()
	if(user.disabilities & CLUMSY && (wielded) && prob(40))
		impale(user)
		return
	if((wielded) && prob(50))
		addtimer(CALLBACK(src, .proc/jedi_spin, user), 0, TIMER_UNIQUE)

/obj/item/weapon/twohanded/dualsaber/proc/jedi_spin(mob/living/user)
	for(var/i in list(1,2,4,8,4,2,1,2,4,8,4,2))
		user.setDir(i)
		if(i == 8)
			user.emote("flip")
		sleep(1)

/obj/item/weapon/twohanded/dualsaber/proc/impale(mob/living/user)
	to_chat(user, "<span class='warning'>You twirl around a bit before losing your balance and impaling yourself on [src].</span>")
	if (force_wielded)
		user.take_bodypart_damage(20,25)
	else
		user.adjustStaminaLoss(25)

/obj/item/weapon/twohanded/dualsaber/hit_reaction(mob/living/carbon/human/owner, attack_text, final_block_chance)
	if(wielded)
		return ..()
	return 0

/obj/item/weapon/twohanded/dualsaber/attack_hulk(mob/living/carbon/human/user, does_attack_animation = 0)  //In case thats just so happens that it is still activated on the groud, prevents hulk from picking it up
	if(wielded)
		to_chat(user, "<span class='warning'>You can't pick up such dangerous item with your meaty hands without losing fingers, better not to!</span>")
		return 1

/obj/item/weapon/twohanded/dualsaber/wield(mob/living/carbon/M) //Specific wield () hulk checks due to reflection chance for balance issues and switches hitsounds.
	if(M.has_dna())
		if(M.dna.check_mutation(HULK))
			to_chat(M, "<span class='warning'>You lack the grace to wield this!</span>")
			return
	..()
	if(wielded)
		sharpness = IS_SHARP
		w_class = w_class_on
		hitsound = 'sound/weapons/blade1.ogg'
		START_PROCESSING(SSobj, src)

/obj/item/weapon/twohanded/dualsaber/unwield() //Specific unwield () to switch hitsounds.
	sharpness = initial(sharpness)
	w_class = initial(w_class)
	..()
	hitsound = "swing_hit"
	STOP_PROCESSING(SSobj, src)

/obj/item/weapon/twohanded/dualsaber/process()
	if(wielded)
		open_flame()
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/weapon/twohanded/dualsaber/IsReflect()
	if(wielded)
		return 1

/obj/item/weapon/twohanded/dualsaber/ignition_effect(atom/A, mob/user)
	// same as /obj/item/weapon/melee/energy, mostly
	if(!wielded)
		return ""
	var/in_mouth = ""
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.wear_mask == src)
			in_mouth = ", barely missing their nose"
	. = "<span class='warning'>[user] swings [user.p_their()] [src][in_mouth]. [user.p_they()] light[user.p_s()] [A] in the process.</span>"
	playsound(loc, hitsound, get_clamped_volume(), 1, -1)
	add_fingerprint(user)
	// Light your candles while spinning around the room
	addtimer(CALLBACK(src, .proc/jedi_spin, user), 0, TIMER_UNIQUE)

/obj/item/weapon/twohanded/dualsaber/green/New()
	item_color = "green"

/obj/item/weapon/twohanded/dualsaber/red/New()
	item_color = "red"

/obj/item/weapon/twohanded/dualsaber/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/device/multitool))
		if(hacked == 0)
			hacked = 1
			to_chat(user, "<span class='warning'>2XRNBW_ENGAGE</span>")
			item_color = "rainbow"
			update_icon()
		else
			to_chat(user, "<span class='warning'>It's starting to look like a triple rainbow - no, nevermind.</span>")
	else
		return ..()

// CHAINSAW
/obj/item/weapon/twohanded/required/chainsaw
	name = "chainsaw"
	desc = "A versatile power tool. Useful for limbing trees and delimbing both humans and demons."
	icon_state = "chainsaw_off"
	flags = CONDUCT
	force = 13
	var/force_on = 21
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 13
	throw_speed = 2
	throw_range = 4
	materials = list(MAT_METAL=13000)
	origin_tech = "materials=3;engineering=4;combat=2"
	attack_verb = list("sawed", "torn", "cut", "chopped", "diced")
	hitsound = "swing_hit"
	sharpness = IS_SHARP
	actions_types = list(/datum/action/item_action/startchainsaw)
	var/on = 0

/obj/item/weapon/twohanded/required/chainsaw/attack_self(mob/user)
	on = !on
	to_chat(user, "As you pull the starting cord dangling from [src], [on ? "it begins to whirr." : "the chain stops moving."]")
	force = on ? force_on : initial(force)
	throwforce = on ? force_on : initial(force)
	icon_state = "chainsaw_[on ? "on" : "off"]"

	if(hitsound == "swing_hit")
		hitsound = 'sound/weapons/chainsawhit.ogg'
	else
		hitsound = "swing_hit"

	if(src == user.get_active_held_item()) //update inhands
		user.update_inv_hands()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/weapon/twohanded/required/chainsaw/get_dismemberment_chance()
	if(wielded)
		. = ..()

/obj/item/weapon/twohanded/required/chainsaw/doomslayer
	name = "THE GREAT COMMUNICATOR"
	desc = "<span class='warning'>VRRRRRRR!!!</span>"
	armour_penetration = 40
	force_on = 30

/obj/item/weapon/twohanded/required/chainsaw/doomslayer/hit_reaction(mob/living/carbon/human/owner, attack_text, final_block_chance, damage, attack_type)
	if(attack_type == PROJECTILE_ATTACK)
		owner.visible_message("<span class='danger'>Ranged attacks just make [owner] angrier!</span>")
		playsound(src, pick('sound/weapons/bulletflyby.ogg','sound/weapons/bulletflyby2.ogg','sound/weapons/bulletflyby3.ogg'), 75, 1)
		return 1
	return 0

//GREY TIDE
/obj/item/weapon/twohanded/spear/grey_tide
	icon_state = "spearglass0"
	name = "\improper Grey Tide"
	desc = "Recovered from the aftermath of a revolt aboard Defense Outpost Theta Aegis, in which a seemingly endless tide of Assistants caused heavy casualities among Nanotrasen military forces."
	force_unwielded = 15
	force_wielded = 25
	throwforce = 20
	throw_speed = 4
	attack_verb = list("gored")

/obj/item/weapon/twohanded/spear/grey_tide/afterattack(atom/movable/AM, mob/living/user, proximity)
	..()
	if(!proximity)
		return
	user.faction |= "greytide(\ref[user])"
	if(isliving(AM))
		var/mob/living/L = AM
		if(istype (L, /mob/living/simple_animal/hostile/illusion))
			return
		if(!L.stat && prob(50))
			var/mob/living/simple_animal/hostile/illusion/M = new(user.loc)
			M.faction = user.faction.Copy()
			M.Copy_Parent(user, 100, user.health/2.5, 12, 30)
			M.GiveTarget(L)

//HF blade

/obj/item/weapon/twohanded/vibro_weapon
	icon_state = "hfrequency0"
	name = "vibro sword"
	desc = "A potent weapon capable of cutting through nearly anything. Wielding it in two hands will allow you to deflect gunfire."
	force_unwielded = 20
	force_wielded = 40
	armour_penetration = 100
	block_chance = 40
	throwforce = 20
	throw_speed = 4
	sharpness = IS_SHARP
	attack_verb = list("cut", "sliced", "diced")
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = SLOT_BACK
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/weapon/twohanded/vibro_weapon/hit_reaction(mob/living/carbon/human/owner, attack_text, final_block_chance, damage, attack_type)
	if(wielded)
		final_block_chance *= 2
	if(wielded || attack_type != PROJECTILE_ATTACK)
		if(prob(final_block_chance))
			if(attack_type == PROJECTILE_ATTACK)
				owner.visible_message("<span class='danger'>[owner] deflects [attack_text] with [src]!</span>")
				playsound(src, pick('sound/weapons/bulletflyby.ogg','sound/weapons/bulletflyby2.ogg','sound/weapons/bulletflyby3.ogg'), 75, 1)
				return 1
			else
				owner.visible_message("<span class='danger'>[owner] parries [attack_text] with [src]!</span>")
				return 1
	return 0

/obj/item/weapon/twohanded/vibro_weapon/update_icon()
	icon_state = "hfrequency[wielded]"

/*
 * Bone Axe
 */
/obj/item/weapon/twohanded/fireaxe/boneaxe  // Blatant imitation of the fireaxe, but made out of bone.
	icon_state = "bone_axe0"
	name = "bone axe"
	desc = "A large, vicious axe crafted out of several sharpened bone plates and crudely tied together. Made of monsters, by killing monsters, for killing monsters."
	force_wielded = 23

/obj/item/weapon/twohanded/fireaxe/boneaxe/update_icon()
	icon_state = "bone_axe[wielded]"

/*
 * Bone Spear
 */
/obj/item/weapon/twohanded/bonespear	//Blatant imitation of spear, but made out of bone. Not valid for explosive modification.
	icon_state = "bone_spear0"
	name = "bone spear"
	desc = "A haphazardly-constructed yet still deadly weapon. The pinnacle of modern technology."
	force = 11
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = SLOT_BACK
	force_unwielded = 11
	force_wielded = 20					//I have no idea how to balance
	throwforce = 22
	throw_speed = 4
	embedded_impact_pain_multiplier = 3
	armour_penetration = 15				//Enhanced armor piercing
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "poked", "jabbed", "torn", "gored")
	sharpness = IS_SHARP

/obj/item/weapon/twohanded/bonespear/update_icon()
	icon_state = "bone_spear[wielded]"

/*
 * Sky Bulge (Gae Bolg, tradtional dragoon lance from many FF games.)
 */
/obj/item/weapon/twohanded/skybulge	//Copy+paste job from bonespear because no explosions.
	icon_state = "sky_bulge0"
	name = "Sky Bulge"
	desc = "A legendary stick with a very pointy tip. Looks to be used for throwing. And jumping. Can be stubborn if you throw too much." //TODO: Be funnier.
	force = 10 //This thing aint for robusting.
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = SLOT_BACK
	force_unwielded = 10
	force_wielded = 18					//Same as regular spear. This is a utility weapon.
	throwforce = 24						//And that utility is throwing. 24 so it takes 5 hits instead of 4.
	throw_speed = 4
	embedded_impact_pain_multiplier = 0	//If you somehow embed this, it's not going to hurt.
	armour_penetration = 15				//Same as Bone Spear
	embed_chance = 0					//Would ruin the whole theme of the thing.
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "poked", "jabbed", "torn", "gored", "lanced") //Added lanced for flavour.
	sharpness = IS_SHARP
	var/maxdist = 16
	var/throw_cooldown = 0				//Should equate to half a second. Not supposed to be varedited.

/obj/item/weapon/twohanded/skybulge/update_icon()
	icon_state = "sky_bulge[wielded]"

/obj/item/weapon/twohanded/skybulge/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback)  //Throw cooldown and offhand-proofing.
	if(throw_cooldown > world.time)
		var/mob/user = thrownby
		user.put_in_hands(src)
		return
	unwield(src)
	..()

/obj/item/weapon/twohanded/skybulge/throw_impact(atom/target) //Praise be the ratvar spear for showing me how to use this proc.
	var/turf/turfhit = get_turf(target)
	var/mob/user = thrownby
	var/turf/source = get_turf(thrownby)

	if(source.z == ZLEVEL_STATION && get_dist(turfhit, source) < maxdist || source.z != ZLEVEL_STATION)
		..()
		if(do_after_mob(user, src, 5, uninterruptible = 1, progress = 0))
			if(QDELETED(src))
				return
			var/turf/landing = get_turf(src)
			if (loc != landing)
				return
			user.forceMove(landing)
	throw_cooldown = world.time + 5				//Half a second between throws.
	user.put_in_hands(src)
	playsound(src, 'sound/weapons/laser2.ogg', 20, 1)

/obj/item/weapon/bumpersword
	name = "bumper sword"
	desc = "The bumper sword, as the name suggests, consists of a rusty car bumper that has been flattened and sharpened into a thick, heavy blade. The license plate is still attached, and an exhaust pipe strapped to the unsharpened end serves as a makeshift handle. Typically favored by Caesar's Legion due to it's immense cutting power."
	icon = 'icons/fallout/objects/melee.dmi'
	icon_state = "bumpersword"
	item_state = "bumpersword"
	flags = CONDUCT
	slot_flags = SLOT_BACK
	force_unwielded = 50
	force_wielded = 70
	block_chance = 30
	throwforce = 35
	w_class = 3
	armour_penetration = 30
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = IS_SHARP
	obj_integrity = 100
	max_integrity = 100
	w_class = WEIGHT_CLASS_BULKY
	self_weight = 35

/obj/item/weapon/twohanded/bumpersword/hit_reaction(mob/living/carbon/human/owner, attack_text, final_block_chance, damage, attack_type)
	if(wielded)
		final_block_chance *= 2
	if(wielded || attack_type != PROJECTILE_ATTACK)
		if(prob(final_block_chance))
			if(attack_type == PROJECTILE_ATTACK)
				owner.visible_message("<span class='danger'>[owner] blocks [attack_text] with [src]!</span>")
				playsound(src, pick("sound/weapons/bulletflyby.ogg","sound/weapons/bulletflyby2.ogg","sound/weapons/bulletflyby3.ogg"), 75, 1)
				return 1
			else
				owner.visible_message("<span class='danger'>[owner] parries [attack_text] with [src]!</span>")
				return 1
	return 0

/obj/item/weapon/twohanded/fireaxe/eastblade
	name = "blade of the East"
	desc = "A great Blade of the East. With that weapon you can dismembering NCR rangers for whole battle. Ave Caesar!"
	icon_state = "eastblade0"
	force_unwielded = 15
	force_wielded = 30
	block_chance = 20
	throwforce = 10
	armour_penetration = 10
	hitsound = "eastbladeslice"
	self_weight = 20

/obj/item/weapon/twohanded/fireaxe/eastblade/update_icon()
	icon_state = "eastblade[wielded]"