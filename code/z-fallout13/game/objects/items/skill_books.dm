/obj/item/skill_book
	name = "��������� ������� � ������� �����"
	desc = "����� �� �������� ��� �����, � �������� � �������� ������ ������, � ����� ��� ������. ������� ���� �� �������� �, ��� ����������� � ����."
	icon = 'icons/obj/library.dmi'
	icon_state = "pa_manual"

	var/intelligence_required = 0
	var/spam_protect_time = 0
	var/book_perk = /datum/perk_hidden/powerArmor

/obj/item/skill_book/attack_self(mob/living/carbon/user)
	if(world.time < spam_protect_time)
		return

	if(user.special.getPoint("i") < intelligence_required)
		to_chat(user, "<span class='warning'>�� ������� ����, ����� ������ ���� ����� �� \"[src]\"!</span>")
		return

	spam_protect_time = 15 + world.time
	to_chat(user, "<span class='notice'>�� ������ ������ [src].</span>")
	if(do_after(user, 30, target = user))
		var/datum/perk_hidden/perk = new book_perk()
		if(!user.perks.have(book_perk))
			user.perks.add(book_perk)
			to_chat(user, "<span class='green'>������ �� �������� ������� \"[perk.name]\"!")
		else
			to_chat(user, "<span class='warning'>�� �� ��� �������� ������� \"[perk.name]\"!")
		to_chat(user, "<span class='warning'>[src] ����������� � ���� � ��� �� �����!</span>")

		new /obj/effect/decal/cleanable/ash/large(get_turf(src))
		qdel(perk)
		qdel(src)