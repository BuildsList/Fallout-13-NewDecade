
/obj/item/bodypart/proc/can_dismember(obj/item/I)
	if(dismemberable)
		. = (get_damage() >= (max_damage - I.armour_penetration/2))

//Dismember a limb
/obj/item/bodypart/proc/dismember(dam_type = BRUTE)
	if(!owner)
		return 0
	var/mob/living/carbon/C = owner
	if(!dismemberable)
		return 0
	if(C.status_flags & GODMODE)
		return 0
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if(NODISMEMBER in H.dna.species.species_traits) // species don't allow dismemberment
			return 0
	if(ArmorPreventsDismemberment())
		return 0

	var/obj/item/bodypart/affecting = C.get_bodypart("chest")
	affecting.receive_damage(Clamp(brute_dam/2, 15, 50), Clamp(burn_dam/2, 0, 50)) //Damage the chest based on limb's existing damage
	C.visible_message("<span class='danger'><B>[C] [src.name] была жестоко отрублена!</B></span>")
	C.emote("scream")
	drop_limb()

	if(dam_type == BURN)
		burn()
		return 1
	add_mob_blood(C)
	var/turf/location = C.loc
	if(istype(location))
		C.add_splatter_floor(location)
	var/direction = pick(cardinal)
	var/t_range = rand(2,max(throw_range/2, 2))
	var/turf/target_turf = get_turf(src)
	for(var/i in 1 to t_range-1)
		var/turf/new_turf = get_step(target_turf, direction)
		if(!new_turf)
			break
		target_turf = new_turf
		if(new_turf.density)
			break
	throw_at(target_turf, throw_range, throw_speed)
	return 1


/obj/item/bodypart/chest/dismember()
	if(!owner)
		return 0
	var/mob/living/carbon/C = owner
	if(!dismemberable)
		return 0
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if(NODISMEMBER in H.dna.species.species_traits) // species don't allow dismemberment
			return 0
	if(ArmorPreventsDismemberment())
		return 0

	var/organ_spilled = 0
	var/turf/T = get_turf(C)
	C.add_splatter_floor(T)
	playsound(get_turf(C), 'sound/misc/splort.ogg', 80, 1)
	for(var/X in C.internal_organs)
		var/obj/item/organ/O = X
		var/org_zone = check_zone(O.zone)
		if(org_zone != "chest")
			continue
		O.Remove(C)
		O.forceMove(T)
		organ_spilled = 1
	if(cavity_item)
		cavity_item.forceMove(T)
		cavity_item = null
		organ_spilled = 1

	if(organ_spilled)
		C.visible_message("<span class='danger'><B>Органы [C] выпадают из тела!</B></span>")
	return 1

//Check we arent wearing anything that prevents dismemberment, i.e power armor
/obj/item/bodypart/proc/ArmorPreventsDismemberment()
	if(!owner)
		return 0
	var/list/equip_list = null
	var/mob/living/carbon/C = owner
	if(!dismemberable)
		return 0

	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		equip_list = list(H.head, H.wear_mask, H.wear_suit, H.w_uniform, H.back, H.gloves, H.shoes, H.belt, H.s_store, H.glasses, H.ears, H.wear_id)
	else return 0


	for(var/el in equip_list)
		if(!el)
			continue
		if(el && istype(el ,/obj/item/clothing))
			var/obj/item/clothing/Cl = el
			if(!Cl)
				continue
			if(Cl.body_parts_covered & src.body_part)
				/*this equipment overlays this bodypart - check for dismember flag*/
				if(Cl.special_defence & PREVENTDISMEMBER)
					return 1
	return 0

//limb removal. The "special" argument is used for swapping a limb with a new one without the effects of losing a limb kicking in.
/obj/item/bodypart/proc/drop_limb(special)
	if(!owner)
		return
	var/turf/T = get_turf(owner)
	var/mob/living/carbon/C = owner
	update_limb(1)
	C.bodyparts -= src
	if(held_index)
		C.unEquip(owner.get_item_for_held_index(held_index), 1)
		C.hand_bodyparts[held_index] = null

	owner = null

	for(var/X in C.surgeries) //if we had an ongoing surgery on that limb, we stop it.
		var/datum/surgery/S = X
		if(S.operated_bodypart == src)
			C.surgeries -= S
			qdel(S)
			break

	for(var/obj/item/I in embedded_objects)
		embedded_objects -= I
		I.forceMove(src)
	if(!C.has_embedded_objects())
		C.clear_alert("embeddedobject")

	if(!special)
		if(C.dna)
			for(var/X in C.dna.mutations) //some mutations require having specific limbs to be kept.
				var/datum/mutation/human/MT = X
				if(MT.limb_req && MT.limb_req == body_zone)
					MT.force_lose(C)

		for(var/X in C.internal_organs) //internal organs inside the dismembered limb are dropped.
			var/obj/item/organ/O = X
			var/org_zone = check_zone(O.zone)
			if(org_zone != body_zone)
				continue
			O.transfer_to_limb(src, C)

	update_icon_dropped()
	forceMove(T)
	C.update_health_hud() //update the healthdoll
	C.update_body()
	C.update_hair()
	C.update_canmove()


//when a limb is dropped, the internal organs are removed from the mob and put into the limb
/obj/item/organ/proc/transfer_to_limb(obj/item/bodypart/LB, mob/living/carbon/C)
	Remove(C)
	forceMove(LB)

/obj/item/organ/brain/transfer_to_limb(obj/item/bodypart/head/LB, mob/living/carbon/human/C)
	if(C.mind && C.mind.changeling)
		LB.brain = new //changeling doesn't lose its real brain organ, we drop a decoy.
		LB.brain.forceMove(LB)
	else			//if not a changeling, we put the brain organ inside the dropped head
		Remove(C)	//and put the player in control of the brainmob
		forceMove(LB)
		LB.brain = src
		LB.brainmob = brainmob
		brainmob = null
		LB.brainmob.forceMove(LB)
		LB.brainmob.container = LB
		LB.brainmob.stat = DEAD

/obj/item/organ/eyes/transfer_to_limb(obj/item/bodypart/head/LB, mob/living/carbon/human/C)
	LB.eyes = src
	..()

/obj/item/bodypart/chest/drop_limb(special)
	return

/obj/item/bodypart/r_arm/drop_limb(special)
	var/mob/living/carbon/C = owner
	..()
	if(C && !special)
		if(C.handcuffed)
			C.handcuffed.forceMove(C.loc)
			C.handcuffed.dropped(C)
			C.handcuffed = null
			C.update_handcuffed()
		if(C.hud_used)
			var/obj/screen/inventory/hand/R = C.hud_used.hand_slots["[held_index]"]
			if(R)
				R.update_icon()
		if(C.gloves)
			C.unEquip(C.gloves, 1)
		C.update_inv_gloves() //to remove the bloody hands overlay


/obj/item/bodypart/l_arm/drop_limb(special)
	var/mob/living/carbon/C = owner
	..()
	if(C && !special)
		if(C.handcuffed)
			C.handcuffed.forceMove(C.loc)
			C.handcuffed.dropped(C)
			C.handcuffed = null
			C.update_handcuffed()
		if(C.hud_used)
			var/obj/screen/inventory/hand/L = C.hud_used.hand_slots["[held_index]"]
			if(L)
				L.update_icon()
		if(C.gloves)
			C.unEquip(C.gloves, 1)
		C.update_inv_gloves() //to remove the bloody hands overlay


/obj/item/bodypart/r_leg/drop_limb(special)
	if(owner && !special)
		if(owner.legcuffed)
			owner.legcuffed.forceMove(owner.loc)
			owner.legcuffed.dropped(owner)
			owner.legcuffed = null
			owner.update_inv_legcuffed()
		if(owner.shoes)
			owner.unEquip(owner.shoes, 1)
	..()

/obj/item/bodypart/l_leg/drop_limb(special) //copypasta
	if(owner && !special)
		if(owner.legcuffed)
			owner.legcuffed.forceMove(owner.loc)
			owner.legcuffed.dropped(owner)
			owner.legcuffed = null
			owner.update_inv_legcuffed()
		if(owner.shoes)
			owner.unEquip(owner.shoes, 1)
	..()

/obj/item/bodypart/head/drop_limb(special)
	if(!special)
		//Drop all worn head items
		for(var/X in list(owner.glasses, owner.ears, owner.wear_mask, owner.head))
			var/obj/item/I = X
			owner.unEquip(I, 1)
	name = "[owner.real_name]'s head"
	..()






//Attach a limb to a human and drop any existing limb of that type.
/obj/item/bodypart/proc/replace_limb(mob/living/carbon/C, special)
	if(!istype(C))
		return
	var/obj/item/bodypart/O = locate(src.type) in C.bodyparts
	if(O)
		O.drop_limb(1)
	attach_limb(C, special)

/obj/item/bodypart/head/replace_limb(mob/living/carbon/C, special)
	if(!istype(C))
		return
	var/obj/item/bodypart/head/O = locate(src.type) in C.bodyparts
	if(O)
		if(!special)
			return
		else
			O.drop_limb(1)
	attach_limb(C, special)

/obj/item/bodypart/proc/attach_limb(mob/living/carbon/C, special)
	forceMove(null)
	owner = C
	C.bodyparts += src
	if(held_index)
		if(held_index > C.hand_bodyparts.len)
			C.hand_bodyparts.len = held_index
		C.hand_bodyparts[held_index] = src
		if(C.hud_used)
			var/obj/screen/inventory/hand/hand = C.hud_used.hand_slots["[held_index]"]
			if(hand)
				hand.update_icon()
		C.update_inv_gloves()

	if(special) //non conventional limb attachment
		for(var/X in C.surgeries) //if we had an ongoing surgery to attach a new limb, we stop it.
			var/datum/surgery/S = X
			var/surgery_zone = check_zone(S.location)
			if(surgery_zone == body_zone)
				C.surgeries -= S
				qdel(S)
				break

	update_bodypart_damage_state()

	C.updatehealth()
	C.update_body()
	C.update_hair()
	C.update_damage_overlays()
	C.update_canmove()


/obj/item/bodypart/head/attach_limb(mob/living/carbon/C, special)
	//Transfer some head appearance vars over
	if(brain)
		brainmob.container = null //Reset brainmob head var.
		brainmob.forceMove(brain )//Throw mob into brain.
		brain.brainmob = brainmob //Set the brain to use the brainmob
		brainmob = null //Set head brainmob var to null
		brain.Insert(C) //Now insert the brain proper
		brain = null //No more brain in the head

	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		H.hair_color = hair_color
		H.hair_style = hair_style
		H.facial_hair_color = facial_hair_color
		H.facial_hair_style = facial_hair_style
		H.lip_style = lip_style
		H.lip_color = lip_color
	if(real_name)
		C.real_name = real_name
	real_name = ""
	name = initial(name)
	..()


//Regenerates all limbs. Returns amount of limbs regenerated
/mob/living/proc/regenerate_limbs(noheal, excluded_limbs)
	return 0

/mob/living/carbon/regenerate_limbs(noheal, list/excluded_limbs)
	var/list/limb_list = list("head", "chest", "r_arm", "l_arm", "r_leg", "l_leg")
	if(excluded_limbs)
		limb_list -= excluded_limbs
	for(var/Z in limb_list)
		. += regenerate_limb(Z, noheal)

/mob/living/proc/regenerate_limb(limb_zone, noheal)
	return

/mob/living/carbon/regenerate_limb(limb_zone, noheal)
	var/obj/item/bodypart/L
	if(get_bodypart(limb_zone))
		return 0
	L = newBodyPart(limb_zone, 0, 0)
	if(L)
		if(!noheal)
			L.brute_dam = 0
			L.burn_dam = 0
			L.brutestate = 0
			L.burnstate = 0

		L.attach_limb(src, 1)
		return 1
