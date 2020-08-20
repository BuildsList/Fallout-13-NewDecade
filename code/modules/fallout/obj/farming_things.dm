/obj/item/farming
	name = "вы не должны это видеть."
	icon = 'icons/fallout/objects/items.dmi'

/obj/item/farming/bucket_stew
	name = "ведро для помоев"
	desc = "Довольно простая вещь, просто скидивыаешь несколько разных видов вкусностей и получаешь со временем похлёбку для животных, неплохо, а?"
	icon_state = "farm_bucket"
	var/food_count = 0
	var/full = 0

/obj/item/farming/bucket_stew/attackby(obj/item/I, mob/living/carbon/human/user, params)
	if(istype(I, /obj/item/weapon/reagent_containers/food/snacks))
		if(!full)
			food_count += 1
			to_chat(user, "Вы добавили еды в ведро, теперь тут [food_count] ед. еды.")
			desc = "Теперь это ведро с помоями, сейчас тут около [food_count] разных видов еды."
			qdel(I)
		else
			to_chat(user, "Ведро уже полное.")
	if(food_count > 2)
		icon_state = "farm_bucket_half"
	if(food_count > 4)
		full = 1
		icon_state = "farm_bucket_full"
		new/obj/item/weapon/reagent_containers/food/snacks/f13/pomoi(get_turf(src), 1)