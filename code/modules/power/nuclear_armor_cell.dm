/obj/item/weapon/stock_parts/cell_pa
	name = "ядерная батарея"
	desc = "Ядерный источник питания для силовой брони."
	icon = 'icons/obj/power.dmi'
	icon_state = "pa_cell"
	item_state = "cell"
	origin_tech = "powerstorage=3"
	force = 5
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	self_weight = 4
	var/charge = 0	// note %age conveted to actual charge in New
	var/maxcharge = 1000
	materials = list(MAT_METAL=700, MAT_GLASS=500)
	var/rigged = 0		// true if rigged to explode
	var/chargerate = 0.5 //how much power is given every tick in a recharger
	var/ratingdesc = TRUE
	var/bcell = null
	var/self_recharge = 0 //does it self recharge, over time, or not?

/obj/item/weapon/stock_parts/cell_pa/New()
	..()
	bcell = src
	START_PROCESSING(SSobj, src)
	charge = maxcharge
	if(ratingdesc)
		desc += " This one has a power rating of [maxcharge], and you should not swallow it."
	updateicon()

/obj/item/weapon/stock_parts/cell_pa/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/weapon/stock_parts/cell_pa/vv_edit_var(var_name, var_value)
	switch(var_name)
		if("self_recharge")
			if(var_value)
				START_PROCESSING(SSobj, src)
			else
				STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/weapon/stock_parts/cell_pa/process()
	if(self_recharge)
		give(chargerate * 0.25)
	else
		return PROCESS_KILL

/obj/item/weapon/stock_parts/cell_pa/proc/updateicon()
	cut_overlays()
	if(charge < 0.01)
		return
	else if(charge/maxcharge >=0.995)
		add_overlay(image('icons/obj/power.dmi', "cell-o2"))
	else
		add_overlay(image('icons/obj/power.dmi', "cell-o1"))

/obj/item/weapon/stock_parts/cell_pa/proc/percent()		// return % charge of cell
	return 100*charge/maxcharge

// use power from a cell
/obj/item/weapon/stock_parts/cell_pa/proc/use(amount)
	if(rigged && amount > 0)
		explode()
		return 0
	if(charge < amount)
		return 0
	charge = (charge - amount)
	if(!istype(loc, /obj/machinery/power/apc))
		feedback_add_details("cell_used","[src.type]")
	return 1

// recharge the cell
/obj/item/weapon/stock_parts/cell_pa/proc/give(amount)
	if(rigged && amount > 0)
		explode()
		return 0
	if(maxcharge < amount)
		amount = maxcharge
	var/power_used = min(maxcharge-charge,amount)
	charge += power_used
	return power_used

/obj/item/weapon/stock_parts/cell_pa/examine(mob/user)
	..()
	if(rigged)
		to_chat(user, "<span class='danger'>This power cell seems to be faulty!</span>")
	else
		to_chat(user, "Индикатор заряда показывает: [round(src.percent() )]%.")

/obj/item/weapon/stock_parts/cell_pa/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is licking the electrodes of [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (FIRELOSS)

/obj/item/weapon/stock_parts/cell_pa/attackby(obj/item/W, mob/user, params)
	..()
	if(istype(W, /obj/item/weapon/reagent_containers/syringe))
		var/obj/item/weapon/reagent_containers/syringe/S = W
		to_chat(user, "<span class='notice'>You inject the solution into the power cell.</span>")
		if(S.reagents.has_reagent("plasma", 5))
			rigged = 1
		S.reagents.clear_reagents()


/obj/item/weapon/stock_parts/cell_pa/proc/explode()
	var/turf/T = get_turf(src.loc)
/*
 * 1000-cell	explosion(T, -1, 0, 1, 1)
 * 2500-cell	explosion(T, -1, 0, 1, 1)
 * 10000-cell	explosion(T, -1, 1, 3, 3)
 * 15000-cell	explosion(T, -1, 2, 4, 4)
 * */
	if (charge==0)
		return
	var/devastation_range = -1 //round(charge/11000)
	var/heavy_impact_range = round(sqrt(charge)/60)
	var/light_impact_range = round(sqrt(charge)/30)
	var/flash_range = light_impact_range
	if (light_impact_range==0)
		rigged = 0
		corrupt()
		return
	//explosion(T, 0, 1, 2, 2)
	explosion(T, devastation_range, heavy_impact_range, light_impact_range, flash_range)
	qdel(src)

/obj/item/weapon/stock_parts/cell_pa/proc/corrupt()
	charge /= 2
	maxcharge = max(maxcharge/2, chargerate)
	if (prob(10))
		rigged = 1 //broken batterys are dangerous

/obj/item/weapon/stock_parts/cell_pa/emp_act(severity)
	charge -= 1000 / severity
	if (charge < 0)
		charge = 0
	..()

/obj/item/weapon/stock_parts/cell_pa/ex_act(severity, target)
	..()
	if(!qdeleted(src))
		switch(severity)
			if(2)
				if(prob(50))
					corrupt()
			if(3)
				if(prob(25))
					corrupt()


/obj/item/weapon/stock_parts/cell_pa/blob_act(obj/structure/blob/B)
	ex_act(1)

/obj/item/weapon/stock_parts/cell_pa/proc/get_electrocute_damage()
	if(charge >= 1000)
		return Clamp(round(charge/10000), 10, 90) + rand(-5,5)
	else
		return 0

/obj/item/weapon/stock_parts/cell_pa/default
	name = "ядерная батарея"
	origin_tech = "powerstorage=2"
	icon_state = "pa_cell"
	maxcharge = 3500
	materials = list(MAT_GLASS=60)
	rating = 3
	chargerate = 0.5
	price = 200

/obj/item/weapon/stock_parts/cell_pa/high
	name = "ядерная батарея+"
	icon_state = "pa_cell"
	maxcharge = 4500
	chargerate = 0.5

/obj/item/weapon/stock_parts/cell_pa/high/empty/New()
	..()
	charge = 0

/obj/item/weapon/stock_parts/cell_pa/admin
	name = "ядерная батарея+++++"
	origin_tech = "powerstorage=2"
	icon_state = "pa_cell"
	maxcharge = 350000
	materials = list(MAT_GLASS=60)
	rating = 3
	chargerate = 100

/obj/item/weapon/stock_parts/cell_pa/admin/self_recharge
	name = "ядерная батарея+++++"
	origin_tech = "powerstorage=2"
	icon_state = "pa_cell"
	maxcharge = 350000
	materials = list(MAT_GLASS=60)
	rating = 3
	chargerate = 100