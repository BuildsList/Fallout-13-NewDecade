//Fallout 13 brahmin directory

/mob/living/simple_animal/cow/radstag
	name = "���-�����"
	desc = "��������, ������������ ��� ������������ ��������. ��������, ��� � ������, ����� ��� ������. ����� �� ������ ������ ����� ��������� ����, ������ ������ ������� ��, ������� ����������� � ������� ������� ����� ���������. ����� � ������� ������ ������ ��������� � �� ����� �����. �������� �������� ��������� ������� �������. � ������� ������� ������� ���� ������������� �����������. ������� ��� ����������� �� ��������, ���� � ��������������� ����������� �����."
	icon = 'icons/fallout/mobs/animal.dmi'
	icon_state = "radstag"
	icon_living = "radstag"
	icon_dead = "radstag_dead"
	icon_gib = "radstag_dead"
	emote_hear = list("�������.")
	emote_see = list("������ ��������.")
	minimum_distance = 4
	retreat_distance = 7
	speed = 4
	self_weight = 150
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat/slab = 6, /obj/item/stack/sheet/animalhide/generic=2)

	XP = 2