//Fallout 13 Enclave faction roles

/datum/job/colonel
	title = "Полковник Анклава"
	desc = "An actual American patriot.<br>You live by the principle that the Main Goal is more important than the means of achieving it."
	flag = COLONEL
	department_head = list("Enclave command HQ")
	department_flag = MEDSCI
	faction = "enclave"
	status = "colonel"
	total_positions = 1
	spawn_positions = 1
	supervisors = "центральному штабу Анклава"
	selection_color = "#ec9d9d"
	minimal_player_age = 31
	whitelist_on = 1

	allowed_packs = list("starter", "cigarettes", "follower", "bard", "super_ten", "specops", "f76")

	required_items = list(
	/obj/item/clothing/glasses/sunglasses,
	/obj/item/weapon/gun/energy/plasma,
	/obj/item/weapon/lighter/engraved,
	/obj/item/key/vertibird
	)

	denied_items = list(
	/obj/item/clothing/shoes/f13/rag,
	/obj/item/clothing/mask/bandana/f13/headscarf,
	/obj/item/clothing/head/f13/pot,
	/obj/item/clothing/under/pants/f13/ghoul,
	/obj/item/clothing/under/pants/f13/cloth,
	/obj/item/clothing/under/pants/f13/caravan,
	/obj/item/clothing/under/f13/rag,
	/obj/item/clothing/under/f13/tribal,
	/obj/item/clothing/under/f13/settler,
	/obj/item/clothing/under/f13/brahmin,
	/obj/item/clothing/under/f13/worn,
	/obj/item/clothing/suit/f13/mantle_liz
	)

	outfit = /datum/outfit/job/colonel

	access = list(access_medical, access_morgue, access_genetics, access_cloning, access_heads, access_mineral_storeroom,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_maint_tunnels)
	minimal_access = list(access_medical, access_morgue, access_genetics, access_cloning, access_heads, access_mineral_storeroom,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_maint_tunnels)

/datum/outfit/job/colonel
	name = "Colonel"
	backpack = null
	satchel = null
	ears = /obj/item/device/radio/radist_headset/enclave
	gloves = /obj/item/clothing/gloves/f13/military
	uniform = /obj/item/clothing/under/f13/enclave_colonel
	shoes = /obj/item/clothing/shoes/f13/military
	suit = /obj/item/clothing/suit/f13/autumn
	belt = /obj/item/weapon/storage/belt/military/army/enclave
	weapon = /obj/item/weapon/gun/energy/plasma/glock
	belt_contents = list(/obj/item/weapon/reagent_containers/f13stimpack = 2, \
	/obj/item/weapon/kitchen/knife/combat = 1)
	id = /obj/item/weapon/card/id/passport_colonel

//Enclave Sergeant

/datum/job/enclave_sergeant
	title = "Сержант Анклава"
	desc = "A loyal soldier.<br>You trust your commander and orders from above - it's just about time to make America great again!"
	flag = ENCLAVE_SERGEANT
	department_head = list("colonel")
	department_flag = MEDSCI
	faction = "enclave"
	status = "enclave_sergeant"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Полковнику"
	selection_color = "#ec9d9d"
	minimal_player_age = 24
	whitelist_on = 1
	allowed_packs = list("starter", "cigarettes", "follower", "bard", "super_ten", "specops", "f76")

	required_items = list(
	/obj/item/clothing/head/soft/f13/utility/olive,
	/obj/item/clothing/head/soft/f13/utility/tan,
	/obj/item/clothing/under/f13/bdu,
	/obj/item/clothing/under/f13/dbdu,
	/obj/item/clothing/glasses/sunglasses,
	/obj/item/weapon/gun/energy/plasma,
	/obj/item/weapon/lighter/engraved
	)

	denied_items = list(
	/obj/item/clothing/shoes/f13/rag,
	/obj/item/clothing/mask/bandana/f13/headscarf,
	/obj/item/clothing/head/f13/pot,
	/obj/item/clothing/under/pants/f13/ghoul,
	/obj/item/clothing/under/pants/f13/cloth,
	/obj/item/clothing/under/pants/f13/caravan,
	/obj/item/clothing/under/f13/rag,
	/obj/item/clothing/under/f13/tribal,,
	/obj/item/clothing/under/f13/settler,
	/obj/item/clothing/under/f13/brahmin,
	/obj/item/clothing/under/f13/worn,
	/obj/item/clothing/suit/f13/mantle_liz
	)

	outfit = /datum/outfit/job/enclave_sergeant

	access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_cloning, access_mineral_storeroom)
	minimal_access = list(access_medical, access_morgue, access_surgery, access_cloning)

/datum/outfit/job/enclave_sergeant
	name = "Сержант Анклава"
	backpack = /obj/item/device/radio/prc
	satchel = null
	ears = /obj/item/device/radio/radist_headset/enclave
	gloves = /obj/item/clothing/gloves/f13/military
	uniform = /obj/item/clothing/under/f13/enclave_officer
	shoes = /obj/item/clothing/shoes/f13/military
	suit = /obj/item/clothing/suit/armor/f13/power_armor/advanced
	head = /obj/item/clothing/head/helmet/power_armor/advanced
	belt = /obj/item/weapon/storage/belt/military/army/enclave
	weapon = /obj/item/weapon/gun/energy/plasma/pistol
	belt_contents = list(/obj/item/weapon/reagent_containers/f13stimpack = 2, /obj/item/weapon/kitchen/knife/combat = 1)
	id = /obj/item/weapon/card/id/passport

//Enclave Private

/datum/job/enclave_private
	title = "Рядовой Анклава"
	desc = "Enlist today."
	flag = ENCLAVE_PRIVATE
	department_head = list("colonel", "sergeant")
	department_flag = MEDSCI
	faction = "enclave"
	status = "enclave_private"
	total_positions = 3
	spawn_positions = 3
	supervisors = "Полковнику"
	selection_color = "#ec9d9d"
	minimal_player_age = 19
	whitelist_on = 0
	allowed_packs = list("starter", "cigarettes", "follower", "bard", "super_ten", "specops", "f76")

	required_items = list(
	/obj/item/clothing/under/f13/bdu,
	/obj/item/clothing/suit/armor/f13/black_combat_armor,
	/obj/item/clothing/head/soft/f13/utility/olive,
	/obj/item/weapon/gun/energy/plasma/pistol
	)

	denied_items = list(
	/obj/item/clothing/shoes/f13/rag,
	/obj/item/clothing/mask/bandana/f13/headscarf,
	/obj/item/clothing/head/f13/pot,
	/obj/item/clothing/under/pants/f13/ghoul,
	/obj/item/clothing/under/pants/f13/cloth,
	/obj/item/clothing/under/pants/f13/caravan,
	/obj/item/clothing/under/f13/rag,
	/obj/item/clothing/under/f13/tribal,
	/obj/item/clothing/under/f13/settler,
	/obj/item/clothing/under/f13/brahmin,
	/obj/item/clothing/under/f13/worn,
	/obj/item/clothing/suit/f13/mantle_liz
	)

	outfit = /datum/outfit/job/enclave_private

	access = list(access_medical, access_morgue, access_surgery, access_cloning, access_mineral_storeroom)
	minimal_access = list(access_medical, access_morgue, access_surgery, access_cloning)

/datum/outfit/job/enclave_private
	name = "Enclave Private"
	backpack = null
	satchel = null
	ears = /obj/item/device/radio/radist_headset/enclave
	gloves = /obj/item/clothing/gloves/f13/military
	uniform = /obj/item/clothing/under/f13/dbdu
	shoes = /obj/item/clothing/shoes/f13/military
	head = /obj/item/clothing/head/soft/f13/utility/tan
	belt = /obj/item/weapon/storage/belt/military/army/enclave
	weapon = /obj/item/weapon/gun/ballistic/automatic/pistol/n99
	belt_contents = list(/obj/item/weapon/reagent_containers/f13stimpack = 1, /obj/item/weapon/kitchen/knife/combat = 1)
	id = /obj/item/weapon/card/id/passport

/// enclave radist///
/datum/job/enclave_radist
	title = "Радист Анклава"
	desc = "Запишись в добровольцы сегодня!"
	flag = ENCLAVE_RADIST
	department_head = list("colonel", "sergeant")
	department_flag = MEDSCI
	faction = "enclave"
	status = "private_radist"
	total_positions = 2
	spawn_positions = 1
	supervisors = "Полковнику"
	selection_color = "#ec9d9d"
	minimal_player_age = 19
	whitelist_on = 1
	allowed_packs = list("starter", "cigarettes", "follower", "bard", "super_ten", "specops", "f76")

	required_items = list(
	/obj/item/clothing/under/f13/bdu,
	/obj/item/clothing/head/soft/f13/utility/olive,
	/obj/item/device/radio/prc
	)

	denied_items = list(
	/obj/item/clothing/shoes/f13/rag,
	/obj/item/clothing/mask/bandana/f13/headscarf,
	/obj/item/clothing/head/f13/pot,
	/obj/item/clothing/under/pants/f13/ghoul,
	/obj/item/clothing/under/pants/f13/cloth,
	/obj/item/clothing/under/pants/f13/caravan,
	/obj/item/clothing/under/f13/rag,
	/obj/item/clothing/under/f13/tribal,
	/obj/item/clothing/under/f13/settler,
	/obj/item/clothing/under/f13/brahmin,
	/obj/item/clothing/under/f13/worn,
	/obj/item/clothing/suit/f13/mantle_liz
	)

	outfit = /datum/outfit/job/radist_en

	access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_cloning, access_mineral_storeroom)
	minimal_access = list(access_medical, access_morgue, access_surgery, access_cloning)

/datum/outfit/job/radist_en
	name = "Радист Анклава"
	back = /obj/item/device/radio/prc
	ears = /obj/item/device/radio/radist_headset/enclave
	gloves = /obj/item/clothing/gloves/f13/military
	uniform = /obj/item/clothing/under/f13/dbdu
	shoes = /obj/item/clothing/shoes/f13/military
	suit = /obj/item/clothing/suit/armor/f13/radist_armor
	head = /obj/item/clothing/head/soft/f13/utility/tan
	belt = /obj/item/weapon/storage/belt/military/army/enclave
	weapon = /obj/item/weapon/gun/ballistic/automatic/pistol/n99
	belt_contents = list(/obj/item/weapon/reagent_containers/f13stimpack = 1, /obj/item/weapon/kitchen/knife/combat = 1, /obj/item/clothing/head/helmet/f13/radist = 1)
	id = /obj/item/weapon/card/id/passport