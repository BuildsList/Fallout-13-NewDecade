//Fallout 13 vending machines directory

/obj/machinery/vending/nukacolavend
	name = "������� � ����-�����"
	icon = 'icons/fallout/machines/vending.dmi'
	icon_state = "nuka_vending"
	icon_deny = "nuka_vending-deny"
	product_slogans = "������� � ����� ����... ��������� �������!"
	products = list(/obj/item/weapon/reagent_containers/food/drinks/bottle/nukacola/radioactive = 8)
	contraband = list(/obj/item/weapon/reagent_containers/food/drinks/bottle/quantumcola = 4)
	refill_canister = /obj/item/weapon/vending_refill/nukacolavend
	self_weight = 150
	brightness_on = 2
	light_color = LIGHT_COLOR_RED

/obj/machinery/vending/nukacolavend/initialize()
	desc = pick("�� ����� ��������� ���������� �� ���� ��������...<br>\"��������: �������� ��������� �� ������� ����-����, ������������ �� ������.\"","���� ������� ���������� ��� ��������������� �� �������.<br>� ��� ���� ��� �������� ��� ������� ����?","���� �� ������������ ���-�� � ��������� ������ �����������, �� ��� ����-����.")
	..()

/obj/machinery/vending/nukacolavend/full
	name = "���������� ������� � ����-�����"
	icon_state = "nuka_vending"
	icon_deny = "nuka_vending-deny"
	product_slogans = "������� � ����� ����... ��������� �������!"
//	products = list(/obj/item/weapon/reagent_containers/food/drinks/bottle/nukacola = 20)
	products = list(/obj/item/weapon/reagent_containers/food/drinks/bottle/nukacola = 5)
	contraband = list(/obj/item/weapon/reagent_containers/food/drinks/bottle/quantumcola = 10)
	refill_canister = /obj/item/weapon/vending_refill/nukacolavend/full

/obj/machinery/vending/nukacolavend/full/initialize()
	desc = pick("�� ������ ���������� �� ���� ��������...<br>\"��������: �������� ��������� �� ������� ����-����, ������������ �� ������.\"","���� ������� �������� ����������� �����, �� ��������� � ���� ��� �� ������ �����.<br>� ��� ���� ��� �������� ��� ������� ����?","����. ���� ������� �� ��������.<br>������� ��������� ����� ������ ��� �� ��������� ����-����. ������� ��������� ���� ������� � �������� ��, ����� ����-����.<br>��� ����������� � ������� ����, �� ����, ������� �� ��������.")
	..()

/obj/item/weapon/vending_refill/nukacolavend
	machine_name = "������� � ����-�����"
	icon_state = "refill_cola"
	charges = list(20, 2, 0)//of 60 standard, 6 contraband
	init_charges = list(20, 2, 0)

/obj/item/weapon/vending_refill/nukacolavend/full
	machine_name = "���������� ������� � ����-�����"
	icon_state = "refill_cola"
	charges = list(20, 2, 0)//of 60 standard, 6 contraband
	init_charges = list(20, 2, 0)