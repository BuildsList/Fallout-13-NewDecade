//Fallout 13 contributor packs directory

/datum/content_pack
	var
		name = "���� �����?"
		id = "shit"
		desc = "Something is wrong! Maybe you already have this content pack?"
		list/items = list()
		list/sorted_items = list()
		list/roles = list()
		list/pets = list()
		price = 99999
	proc
		on_set(client/client)
			return 1
		generate_sorted_list() //
			sorted_items["weapon"] = list()
			sorted_items["misc"] = list()
			sorted_items["head"] = list()
			sorted_items["armor"] = list()
			sorted_items["gloves"] = list()
			sorted_items["shoes"] = list()
			sorted_items["uniform"] = list()
		sort_items()
			for(var/item in items)
				if(get_var_from_type(item, "w_class") < WEIGHT_CLASS_NORMAL)
					sorted_items["misc"] |= item
				sorted_items[slot_name_by_type(item)] |= item
	New()
		. = ..()
		if(!items.len)
			return .
		generate_sorted_list()
		sort_items()


/datum/content_pack/starter
	name = "������� 13: ����� �������"
	id = "starter"
	desc = "<b>�������� ���: ���� �������!</b><br>����� ����� ����� ��� ������ ����, ��������� ���������!<br><i>�����: ����� ����� ������ �� ����� ������, ���������� ���� ��������. ���-��, ��������� ���� ������ ����� ���� ����������, ����� �����-���� �������. ���� ���������(settler) ����� ������ �� ����� ��� ��� ������������.</i>"
	items = list(
		/obj/item/clothing/shoes/f13/rag,
		// Hats
		/obj/item/clothing/head/f13/headscarf,
		/obj/item/clothing/head/f13/pot,
		// Goggles
		/obj/item/clothing/glasses/regular,
		// Uniforms
		/obj/item/clothing/under/pants/f13/ghoul,
		/obj/item/clothing/under/pants/f13/cloth,
		/obj/item/clothing/under/pants/f13/caravan,
		/obj/item/clothing/under/f13/rag,
		/obj/item/clothing/under/f13/tribal,
		/obj/item/clothing/under/f13/female/tribal,
		/obj/item/clothing/under/f13/settler,
		/obj/item/clothing/under/f13/brahmin,
		/obj/item/clothing/under/f13/female/brahmin,
		/obj/item/clothing/under/f13/worn,
		// Suits
		/obj/item/clothing/suit/f13/mantle_liz,
		// Items
		/obj/item/weapon/reagent_containers/food/drinks/flask/survival,
		/obj/item/weapon/dice/d6,
		/obj/item/toy/cards/deck,
		/obj/item/weapon/storage/fancy/cigarettes,
		/obj/item/weapon/storage/fancy/cigarettes/tortoise,
		/obj/item/weapon/storage/box/matches,
		// Weapons
		/obj/item/weapon/pipe,
		/obj/item/weapon/tireiron,
		/obj/item/weapon/pan,
		/obj/item/weapon/kitchen/rollingpin,
		/obj/item/weapon/kitchen/knife,
		/obj/item/weapon/kitchen/knife/butcher,
		/obj/item/weapon/scalpel,
		/obj/item/weapon/shovel,
		/obj/item/weapon/hammer,
		/obj/item/weapon/crowbar,
		/obj/item/weapon/screwdriver,
		/obj/item/weapon/wirecutters,
		/obj/item/weapon/wrench,
		/obj/item/weapon/weldingtool/experimental,
		/obj/item/weapon/restraints/legcuffs/bola
		)
	price = -1

	on_set(client/client)
		client.add_race("human", /datum/species/human)

/datum/content_pack/cigarettes
	name = "��������"
	id = "cigarettes"
	desc = "<b>�������� ���: ���� �������!</b><br><i>�����: ��������� ����������� ��������������� ������������� - ������� ������ ��������. �������� ��������� ���� ����� ����������� �� ����� ��������!</i>"
	items = list(
		/obj/item/weapon/storage/fancy/rollingpapers,
		/obj/item/weapon/storage/fancy/cigarettes/cigpack_myron,
		/obj/item/weapon/storage/fancy/cigarettes/cigpack_joy,
		/obj/item/clothing/mask/cigarette,
		/obj/item/clothing/mask/cigarette/rollie,
		/obj/item/clothing/mask/cigarette/cigar,
		/obj/item/clothing/mask/cigarette/cigar/cohiba,
		/obj/item/clothing/mask/cigarette/cigar/havana,
		/obj/item/weapon/lighter
		)
	price = 1000

/datum/content_pack/team_fortress
	name = "����� �����"
	id = "team_fortress"
	desc = "<b>�������� ���: ���������, ������� � ��������!</b><br>�������� ������������� ���� ���� � ������� 13 � ����� ����� ������� �����.<br>� ���� ����� ������ ����� ���� (���) �������������� �����!"
	items = list(
		/obj/item/clothing/head/soft/f13/baseball,
		/obj/item/clothing/head/soft/f13/utility,
		/obj/item/clothing/head/f13/cowboy,
		/obj/item/clothing/head/f13/bandit,
		/obj/item/clothing/head/f13/stormchaser,
		/obj/item/clothing/head/f13/gambler
		)
	price = 4000

/datum/content_pack/wardrobe
	name = "������ ����"
	id = "wardrobe"
	desc = "<b>�������� ���: ��������� � �������!</b><br>������ �� ���� ��� ��� �������� �������� ��� �����-�� ����?<br>���� ����� ���������� ���������� ��� ���! ����� ���� ������� 2255 ����!<br>������ ����� �������� ��� ���� ����� � ����� ���� ������������� ��������.<br><i>�����: �� ������ ����������� dark red wasteland wanderer jacket.</i>"
	items = list(
		/obj/item/clothing/shoes/f13/explorer,
		// Uniforms
		/obj/item/clothing/under/f13/relaxedwear,
		/obj/item/clothing/under/f13/spring,
		/obj/item/clothing/under/f13/merchant,
		/obj/item/clothing/under/f13/trader,
		/obj/item/clothing/under/f13/caravaneer,
		/obj/item/clothing/under/f13/petrochico,
		/obj/item/clothing/under/f13/mechanic,
		/obj/item/clothing/under/f13/lumberjack,
		/obj/item/clothing/under/f13/machinist,
		// Suits
		/obj/item/clothing/suit/f13/puffer,
		/obj/item/clothing/suit/toggle/labcoat/f13/wanderer
		)
	price = 5000

/datum/content_pack/vault13
	name = "������� 13"
	id = "vault13"
	desc = "<b>�������� ���: ���������, ������� � ��������!</b><br>������� 13 ��������� ���� �����, �� �� ��� ��� ������ ��������� �� ���� �� �����������, �� ��� ������ ������������ �������� �� ������� � ������ ����.</i>"
	items = list(
		/obj/item/clothing/under/f13/vault/v13,
		/obj/item/weapon/reagent_containers/food/drinks/flask/vault13,
		/obj/item/weapon/lighter/vault13
		)
	price = 15000

/datum/content_pack/bard
	name = "����������� �����������"
	id = "bard"
	desc = "<b>�������� ���: ���� �������!</b><br>Russian General says, :<br><i>\"� �� ����� ���-�-����. �� ������� �������! ��� �������� ����, ������, � �������� ������. ������, �����, �� ��� ������!\"</i><br><b>Six String Samurai (1998)</b>"
	items = list(
		/obj/item/device/harmonica,
		/obj/item/device/instrument/guitar
		)
	price = 1000

/datum/content_pack/doom
	name = "Doom"
	id = "doom"
	desc = "<b>Available to: Neutral and Raider factions only!</b><br>Carefully selected items from Doom game.<br><i>Note: Union Aerospace Corporation welcomes you aboard a shuttle leaving Earth on the way to Mars. Please fasten your seatbelts and have a safe flight!</i>"
	items = list(
		/obj/item/clothing/head/helmet/f13/doom,
		/obj/item/clothing/suit/armor/f13/doom,
		/obj/item/clothing/under/pants/f13/doom,
		/obj/item/clothing/gloves/f13/doom,
		/obj/item/clothing/shoes/f13/doom,
		/obj/item/weapon/mounted_chainsaw
		)
	price = 85000

/datum/content_pack/followers
	name = "����� ��������������"
	id = "follower"
	desc = "<b>�������� ���: ���� �������!</b> :���� ��� ������� �� ������� �����, �� ��� ��� ����� ������?"
	items = list(
		/obj/item/clothing/suit/toggle/labcoat/f13/followers,
		/obj/item/clothing/under/f13/doctor,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/gloves/color/latex,
		/obj/item/clothing/glasses/regular,
		///obj/item/clothing/mask/surgical/joy,
		/obj/item/clothing/mask/surgical,
		/obj/item/weapon/storage/backpack/satchel/leather,
		/obj/item/weapon/storage/firstaid
	)
	price = 4000

/datum/content_pack/trooper_armor
	name = "����� ����� ���"
	id = "trooper_armor"
	desc = "<b>�������� ���: ���!</b><br>����������� ����������� ����� �� ������ ��������, � ���� ������� �� ���� �� �������� ����� ���!<br>���� ����� �������� � ���� ����� �������������� �������� ��� �����:<br>White star insignia<br>Red star insignia<br>Holy cross insignia<br>Hear symbol insignia<br>Radiation symbol insignia<br>White skull insignia"
	items = list(
		/obj/item/clothing/suit/armor/f13/ncr/patriot,
		/obj/item/clothing/suit/armor/f13/ncr/commie,
		/obj/item/clothing/suit/armor/f13/ncr/preacher,
		/obj/item/clothing/suit/armor/f13/ncr/lover,
		/obj/item/clothing/suit/armor/f13/ncr/stalker,
		/obj/item/clothing/suit/armor/f13/ncr/punisher
		)
	price = 4000


/datum/content_pack/heavy_trooper
	name = "NCR Heavy Infantry Corps"
	id = "heavy_trooper"
	desc = "<b>Available to: NCR Trooper and NCR Sergeant roles only!</b><br>Become the NCR Heavy Trooper with a set of NCR salvaged power armor and a big gun!"
	items = list(
		/obj/item/clothing/head/helmet/power_armor/ncr,
		/obj/item/clothing/suit/armor/f13/power_armor/ncr,
		/obj/item/weapon/twohanded/largehammer,
		/obj/item/weapon/gun/ballistic/automatic/rifle,
		/obj/item/ammo_box/magazine/F13/m308
		)
	price = 8000


/datum/content_pack/khan
	name = "������� ����"
	id = "khan"
	desc = "<b>�������� ���: �������� � �������!</b><br>������� ������� ����� ����� ������������� � ���� ������������� �������!<br>��� ���������� �� ��� �����, � ������� �������� �� ������ �������� �������� ��������.<br><i>�����: �� ������ ����������� Great Khan jacket .</i>"
	items = list(
		/obj/item/clothing/head/helmet/f13/khan,
		/obj/item/clothing/suit/toggle/labcoat/f13/khan,
		/obj/item/clothing/under/pants/f13/khan,
		/obj/item/clothing/shoes/f13/khan,
		/obj/item/weapon/twohanded/tribal_spear,
		/obj/item/weapon/restraints/legcuffs/bola/tribal
		)
	price = 3000

/datum/content_pack/punk
	name = "����"
	id = "punk"
	desc = "<b>�������� ���: �������� � �������!</b><br>���� ��� ������� ��� � ���� ������������ �������, ���� ����� �� ��������.<br><i>������ ̨���!</i><br>"
	items = list(
		/obj/item/clothing/shoes/f13/military/diesel,
		/obj/item/clothing/shoes/f13/military/female/diesel,
		/obj/item/clothing/suit/armor/f13/punk,
		/obj/item/device/instrument/eguitar,
		/obj/item/key/motorcycle
		)
	price = 5000

/datum/content_pack/off
	name = "����� �����������"
	id = "off"
	desc = "<b>�������� ���: �������� � �������!</b><br>�������� ��������������� ������� � ����� ������� ������ - ������������."
	items = list(
		/obj/item/clothing/head/soft/black,
		/obj/item/clothing/under/f13/batter,
		/obj/item/weapon/twohanded/baseball,
		//obj/item/clothing/gloves/f13/baseball,
		/obj/item/clothing/shoes/f13/fancy
		)
	price = 5000

/datum/content_pack/madmax
	name = "�������� ����"
	id = "madmax"
	desc = "<b>�������� ���: �������� � �������!</b><br>�������� ���������� �������� �� ��������� ��������� �����.<br><i>�����: Steering wheel ������������ ��� ����� �� �����.<br>� ������ � ������������.</i>"
	items = list(
		/obj/item/clothing/suit/f13/mfp,
		/obj/item/clothing/suit/f13/mfp/raider,
		/obj/item/weapon/reagent_containers/food/snacks/f13/dog,
		/obj/item/clothing/head/f13/safari,
		/obj/item/clothing/under/pants/f13/warboy,
		/obj/item/key/buggy/wheel
		)
	price = 15000

/datum/content_pack/trooper_armor
	name = "����� ������������� ���"
	id = "trooper_armor"
	desc = "<b>�������� ���: ������ ��� ������� ��� � ��������!</b><br>����������� ������� ����� ������ �� ������ ��������, ���� ���� �������� ��� �����!<br>� ��� ������ ����� �������� ��� �����:<br>White star insignia<br>Red star insignia<br>Holy cross insignia<br>Hear symbol insignia<br>Radiation symbol insignia<br>White skull insignia"
	items = list(
		/obj/item/clothing/suit/armor/f13/ncr/patriot,
		/obj/item/clothing/suit/armor/f13/ncr/commie,
		/obj/item/clothing/suit/armor/f13/ncr/preacher,
		/obj/item/clothing/suit/armor/f13/ncr/lover,
		/obj/item/clothing/suit/armor/f13/ncr/stalker,
		/obj/item/clothing/suit/armor/f13/ncr/punisher
		)
	price = 7000

/datum/content_pack/glowing_ghoul
	name = "������� ����: ���������� ����"
	id = "glowing_ghoul"
	desc = "<b>�������� ���: ���� ������, ����� �����������!</b><br>������ �����, ��������� ��� ������� ����������� ����!"
	price = 30000

	on_set(client/client)
		client.add_race("glowing ghoul", /datum/species/ghoul/glowing)

/datum/content_pack/ghoul
	name = "������� ����: ����"
	id = "ghoul"
	desc = "<b>�������� ���: ���� ������, ����� �����������!</b><br>������ �����, ��������� ��� ������� ����!"
	price = 10000

	on_set(client/client)
		client.add_race("ghoul", /datum/species/ghoul)

/datum/content_pack/specops
	name = "����� ������������ ����������"
	id = "specops"
	desc = "<b>�������� ���: ��� ������!</b><br>����� 1-1, ��� �����, ��� �������?.<br>."
	items = list(
		/obj/item/clothing/gloves/f13/military,
		/obj/item/clothing/shoes/f13/military,
		/obj/item/clothing/suit/armor/f13/black_combat_armor,
		/obj/item/clothing/under/syndicate/tacticool,
		/obj/item/clothing/glasses/night
		)
	price = 9000

/datum/content_pack/f76
	name = "������������� ������� ������� 13"
	id = "f76"
	desc = "<b>�������� ���: ��� ������ ����� �� 200$!</b><br>��� ������ ��������.<br>."
	items = list(/obj/item/weapon/storage/f76bag/bag)
	price = 2000

/datum/content_pack/leaders
	name = "������ ���� �������� �������"
	id = "leaders"
	desc = "<b>�������� ���: ���� ������!</b><br>� ��� �� �� ����� ���� �������?.<br>."
	roles = list(
		/datum/job/gangleader,
		/datum/job/mayor,
		/datum/job/general,
		/datum/job/legate,
		/datum/job/elder,
		/datum/job/colonel,
	//	/datum/job/overseer
		//datum/job/preacher
		)
	price = 100000


/datum/content_pack/enclave2
	name = "������: ���� ��������"
	id = "enclave_sergeant"
	desc = "<b>��������� ������ � ���� �������� �������!</b><br>�-��-��!<br>."
	roles = list(
	/datum/job/enclave_sergeant
		)
	price = 35000

/datum/content_pack/enclave
	name = "������: ���� ��������"
	id = "enclave_private"
	desc = "<b>��������� ������ � ���� �������� �������!</b><br>��� ���� ������� �����?.<br>."
	roles = list(
	/datum/job/enclave_private
		)
	price = 10000
