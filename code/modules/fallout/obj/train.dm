//�������� ���
//������ ���� �Ѩ ����� �� �� ������� � ����� ����
//Made By SanecMan
//��� �����: code\modules\fallout\areas\area.dm
/*
//������ �� ��������� �������
/turf/closed/indestructible/f13/train
	name = '����� � ���������'
	desc = '��� ����� � ������ �� ���������'
	icon = 'icons/effects/effects.dmi'
	opacity = 10000000

//�������� ���
/turf/closed/indestructible/f13/train/shield
	name = "�������� ����"
	desc = "������������� �������� ����, ������� ��������� ���� �� ����������� ������."
	icon_state = "shieldwall"

//���������� �����
/turf/closed/indestructible/f13/train/openwall
	name = "�����"
	desc = "������ ����������."
	icon_state = "shieldwall"


//���� ���� �� ���������� ��� �������� �������������� ����������� ���� ���
// /turf/closed/indestructible/fakeglass/New()
//	..()
//	icon_state = null //set the icon state to null, so our base state isn't visible
//	var/image/I = image('icons/obj/structures.dmi', loc = src, icon_state = "grille")
//	underlays += I //add a grille underlay
//	I = image('icons/turf/floors.dmi', loc = src, icon_state = "plating")
//	underlays += I //add the plating underlay, below the grille

//������� ���� ����� ��� ����� �������. ��� ����� ���� ����������. ���� ����� �� ������. ��������� ����� ���� ������ �� ���� #poezd
/turf/open/chasm/straight_down/train/New()
	..()
	drop_x = [rand(6,27)]
	drop_y = [rand(99,103)]
	drop_z = 2
	name = '������������������������������������' //��� ��������
	desc = '��ب� ����� � ����� ����'
	icon = 'icons/fallout/turfs/train.dmi'

//���������� ��������
/turf/open/chasm/straight_down/train/openground
	name = '�������� ��������'
	desc = '�� ������!'
	icon_state = "openground"

//���������� ������
/turf/open/chasm/straight_down/train/openrail
	name = '������'
	desc = '�� ������!'
	icon_state = "openwall"
*/

//����� ��� ������ #train
/obj/item/weapon/circuitboard/computer/train
	name = "Metro Train (Computer Board)"
	build_path = "/obj/machinery/computer/shuttle/train"

//������� ��� ���������� ������� #train
/obj/machinery/computer/shuttle/train
	name = "������ ���������� �������"
	desc = "�� ������ ������ � ����� ������. ����������� �� ��� �� �������� ����� ����������, ������� ��������� ��������� ������� � ���������� ��� �� ������ �������."
	icon_screen = "shuttle"
	icon_keyboard = "teleport_key"
	circuit = "/obj/item/weapon/circuitboard/computer/train"
	shuttleId = "poezd"
	possible_destinations = "poezd_kebab;poezd_end"

