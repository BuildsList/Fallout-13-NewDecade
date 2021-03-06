//Fallout 13 syringes by Gargule
/obj/item/weapon/reagent_containers/f13stimpack //(Gargule)
	name = "стимулятор"
	desc = "A stimpak, or stimulation delivery package, is a type of hand-held medication used for healing the body. This item consists of a syringe for containing and delivering the medication and a gauge for measuring the status of the stimpak's contents. When the medicine is injected, it provides immediate healing of the body's minor wounds."
	icon = 'icons/fallout/objects/medicine/syringe.dmi'
	icon_state = "stim"
	item_state = "medipen"
	volume = 8
	amount_per_transfer_from_this = 8
	container_type = 0
	list_reagents = list("stimpackium" = 2)
	flags = null
	price = 150
	var/def_volume = 8
	var/reloadable = 0
	var/ignore_flags = 1

/obj/item/weapon/reagent_containers/f13stimpack/update_icon()
	if(reagents.total_volume > 0)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]0"

/obj/item/weapon/reagent_containers/f13stimpack/attack_paw(mob/user)
	return attack_hand(user)

/obj/item/weapon/reagent_containers/f13stimpack/attack(mob/living/M, mob/user)
	if(!reagents.total_volume)
		to_chat(user, "<span class='warning'>[src] пуст!</span>")
		return
	if(!iscarbon(M))
		return
	if(reloadable)
		to_chat(user, "<span class='warning'>[src] is unscrewed!</span>")
		return

	if(reagents.total_volume && (ignore_flags || M.can_inject(user, 1))) // Ignore flag should be checked first or there will be an error message.
		to_chat(M, "<span class='warning'>Вы чувствуете небольшой укол!</span>")
		to_chat(user, "<span class='notice'>Вы ввели [M] что-то из [src].</span>")

		var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)
		reagents.reaction(M, INJECT, fraction)
		if(M.reagents)
			var/list/injected = list()
			for(var/datum/reagent/R in reagents.reagent_list)
				injected += R.name
			var/trans = 0
			trans = reagents.trans_to(M, amount_per_transfer_from_this)
			update_icon()
			volume = 0
			to_chat(user, "<span class='notice'>[trans] ед. введено.  [reagents.total_volume] осталось в [src].</span>")

			var/contained = english_list(injected)

			add_logs(user, M, "injected", src, "([contained])")

			qdel(src)

/obj/item/weapon/reagent_containers/f13stimpack/attackby(obj/item/weapon/W,mob/user,params)
	if(istype(W,/obj/item/weapon/screwdriver))
		if(!container_type && !volume)
			playsound(get_turf(user), W.usesound, 50, 1)
			container_type = OPENCONTAINER
			icon_state = "[initial(icon_state)]_unscrew"
			volume = src.def_volume
		//	return
		else
			if(container_type == OPENCONTAINER)
				playsound(get_turf(user), W.usesound, 50, 1)
				reloadable = 0
				container_type = 0
				volume = src.reagents.total_volume
				update_icon()
		//	return
	//if(istype(W,/obj/item/weapon/reagent_containers) && W.reagents.total_volume >= volume)

/obj/item/weapon/reagent_containers/f13stimpack/examine()
	..()
	if(reagents && reagents.reagent_list.len)
		to_chat(usr, "<span class='notice'>It is currently loaded.</span>")
	else
		to_chat(usr, "<span class='notice'>It is spent.</span>")


/obj/item/weapon/reagent_containers/f13stimpack/super
	name = "Супер-Стимулятор"
	desc = "The super version of the Stimpak has an additional vial containing more powerful drugs than the basic model, as well as a leather belt to strap the needle to the injured limb."
	icon_state = "superstim"
	volume = 12
	price = 350
	amount_per_transfer_from_this = 12
	list_reagents = list("supstimpackium" = 6)
//end

//Mentats

/obj/item/weapon/storage/pill_bottle/mentats
	name = "Ментаты"
	desc = "Old, torn box with some pills in it."
	icon = 'icons/fallout/objects/medicine/chemical.dmi'
	icon_state = "mentats"
	storage_slots = 8
	price = 250

/obj/item/weapon/storage/pill_bottle/mentats/New()
	..()
	for(var/i in 1 to 8)
		new /obj/item/weapon/reagent_containers/pill/mentats(src)

	//mentats pills
/obj/item/weapon/reagent_containers/pill/mentats
	name = "Ментаты"
	desc = "Поможет вам. Если вы тупой. Наверно..."
	icon_state = "pill10"
	list_reagents = list("mentats" = 20)
	roundstart = 0

//magic_powder
/obj/item/stack/medical/healingpowder
	name = "Healing powder"
	singular_name = "healing powder"
	desc = "A foul-smelling primitive healing medicine.<br>It is widespread in the wasteland due to easy production - all kinds of Wastelanders from Settlers to Mercenaries use it to heal minor injuries.<br>Soldiers of the Legion use healing powder as their primary source of medicine and healing, since the Legion bans the use of other chems, such as stimpaks."
	icon = 'icons/fallout/objects/medicine/chemical.dmi'
	icon_state = "heal_powder"
	item_state = "bandaid"
	amount = 4
	max_amount = 4
	heal_brute = 10
	heal_burn = 5
	self_delay = 20

/*/obj/item/stack/medical/attack(mob/living/M, mob/user) //need MORE hardcode by your moron
	if(iscarbon(M))
		var/mob/living/carbon/human/H = M
		if(!H.bleedsuppress) //so you can't stack bleed suppression
			H.suppress_bloodloss(600)
	..()*/

//magic_powder
/obj/item/stack/medical/fev
	name = "ВРЭ"
	singular_name = "FEV"
	desc = "FEV nears completion. Test on lab animals are at a near 100% success rate. Size and muscle density increase approximately 60%, and the potential intelligence increase by 200%. Effects upon human subjects remain unknown; although they are theoretically promising. The military, wishing to continue further testing, builds a large facility at the Mariposa military installation in central California. At this new facility, testing of the FEV virus continues on volunteer subjects from the military."
	icon = 'icons/fallout/objects/medicine/bloodpack.dmi'
	icon_state = "fev"
	item_state = "bandaid"
	amount = 1
	max_amount = 1
	heal_brute = 30
	heal_burn = 30
	self_delay = 30

/obj/item/stack/medical/attack(mob/living/M, mob/user) //need MORE hardcode by your moron
	if(iscarbon(M))
		var/mob/living/carbon/human/H = M
		if(name == "FEV")
			if(self_delay)
				if(!do_mob(user, M, self_delay))
					return 0
			to_chat(H, "<span class='danger'>Вы ощущаете себя... Странно!Вам бы стоило постоять, перед тем как продолжить движение, ведь всё ваше тело болит!</span>")
			H.set_species(/datum/species/supermutant)
			H.Stun(20)
			H.radiation = 0
			qdel(src)
			/*var/obj/item/weapon/reagent_containers/blood/CC = */new/obj/item/weapon/reagent_containers/blood/empty(user.loc)
		if(!H.bleedsuppress) //so you can't stack bleed suppression
			H.suppress_bloodloss(600)
	..()