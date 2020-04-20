/mob/living/carbon/verb/give()
	set category = "IC"
	set name = "Give"
	set src in view(1)

	if(src == usr)
		to_chat(usr,"<span class='warning'>You feel stupider, suddenly.</span>")
		return

	if(!ismonkey(src)&&!ishuman(src) || isalien(src) || src.stat || usr.stat || !src.client)
		if(client && (client.prefs.chat_toggles & CHAT_LANGUAGE))
			to_chat(usr,"<span class='warning'>[src.name] can't hold anything</span>")
		else
			to_chat(usr,"<span class='warning'>[src.name] �� ����� ����� ���-����</span>")
			return

	var/obj/item/I = usr.get_active_held_item()
	if(!I)
		if(client && (client.prefs.chat_toggles & CHAT_LANGUAGE))
			to_chat(usr,"<span class='warning'>You have nothing for [src].</span>")
		else
			to_chat(usr,"<span class='warning'>� ��� ��� ������ ��� �� �� ����� ���� [src].</span>")
			return

	if(!usr.canUnEquip(I))
		return

	var/list/empty_hands = get_empty_held_indexes()
	if(!empty_hands.len)
		if(client && (client.prefs.chat_toggles & CHAT_LANGUAGE))
			to_chat(usr,"<span class='warning'>Hands of [src] are busy.</span>")
		else
			to_chat(usr,"<span class='warning'>���� [src] �����.</span>")
			return
	if(client && (client.prefs.chat_toggles & CHAT_LANGUAGE))
		switch(alert(src,"[usr] ����� �������� ��� [I]?",,"Yes","No"))
			if("Yes")
				if(!I || !usr)
					return
				if(!Adjacent(usr))
					to_chat(usr,"<span class='warning'>You need to stay in reaching distance while giving an object.</span>")
					to_chat(usr,"<span class='warning'>[usr] moved too far away.</span>")
					return

				if(I != usr.get_active_held_item())
					to_chat(usr,"<span class='warning'>You need to keep the item in your active hand.</span>")
					to_chat(usr,"<span class='warning'>[name] seem to have given up on giving [I] to you.</span>")
					return

				if(src.lying || src.handcuffed)
					to_chat(usr,"<span class='warning'>Handcuffed.</span>")
					return

				empty_hands = get_empty_held_indexes()
				if(!empty_hands.len)
					to_chat(usr,"<span class='warning'>Your hands are full.</span>")
					to_chat(usr,"<span class='warning'>Hands are full.</span>")
					return

				if(!usr.drop_item_v())
					return

				if(!put_in_hands(I))
					to_chat(usr,"<span class='warning'>You can't take [I], so [usr] give up!</span>")
					to_chat(usr,"<span class='warning'>[src] can't take [I]!</span>")
					return

				src.visible_message("<span class='notice'>[usr] gives [I] in hands of [src].</span>")
			if("No")
				src.visible_message("<span class='warning'>[usr] trying to give [I] in hands of [src], but [src] refuses take this.</span>")
	else
		switch(alert(src,"[usr] trying to give you something, take [I]?",,"Yes","No"))
			if("Yes")
				if(!I || !usr)
					return
				if(!Adjacent(usr))
					to_chat(usr,"<span class='warning'>�� ������� ������.</span>")
					to_chat(usr,"<span class='warning'>[usr] ���� ������� ������.</span>")
					return

				if(I != usr.get_active_held_item())
					to_chat(usr,"<span class='warning'>��� ���������� ������� ������� � �������� ����.</span>")
					to_chat(usr,"<span class='warning'>[name] ������, �������, � �������� ��-�� ���� ��� [I].</span>")
					return

				if(src.lying || src.handcuffed)
					to_chat(usr,"<span class='warning'>� ����������.</span>")
					return

				empty_hands = get_empty_held_indexes()
				if(!empty_hands.len)
					to_chat(usr,"<span class='warning'>���� ���� ������.</span>")
					to_chat(usr,"<span class='warning'>���� ������.</span>")
					return

				if(!usr.drop_item_v())
					return

				if(!put_in_hands(I))
					to_chat(usr,"<span class='warning'>�� �� ������ ����� [I], ��� ��� [usr] �������!</span>")
					to_chat(usr,"<span class='warning'>[src] �� ����� ����� [I]!</span>")
					return

				src.visible_message("<span class='notice'>[usr] ������� [I] � ���� [src].</span>")
			if("No")
				src.visible_message("<span class='warning'>[usr] �������� �������� [I] � ���� [src], �� [src] ������������ �����.</span>")