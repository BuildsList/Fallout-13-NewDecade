/*
������. ���� ��� �� ��������.


/obj/item/weapon/sawdust
	name = "A Sawdust"
	icon = 'icons/fallout/flora/flora.dmi'
	icon_state = "sawdust"
	desc = "This is tree radioactive sawdust. Not a good."
	force = 0
	resistance_flags = FLAMMABLE


//� ����� ������ �� �����?

/obj/item/weapon/sawdust/New()
	icon_state = "sawdust_[rand(1, 4)]"
	..()
*/

/obj/item/weapon/reagent_containers/food/snacks/f13/sawdust
	name = "������"
	desc = "���� ��� �������� ������. �������� ������� ������������..."
	icon = 'icons/fallout/flora/flora.dmi'
	icon_state = "sawdust"
	bonus_reagents = list("radium" = 0.5, "vitamin" = 1)
	list_reagents = list("nutriment" = 2)
	filling_color = "#B22222"

