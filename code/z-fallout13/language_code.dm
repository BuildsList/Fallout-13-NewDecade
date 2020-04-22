/client/proc/select_lang(var/rus_msg, var/eng_msg)
	if(mob.client)
		switch(language)
			if("Russian")
				return rus_msg
			if("English")
				return eng_msg
	else
		return eng_msg

/client/verb/change_lang()
	set name = "Change Language"
	set category = "OOC"
	set desc = "Changes game language."

	if(usr.client.language == "English")
		usr.client.language = "Russian"
		to_chat(src, "<span class='notice'>������ ��� ���� �������</span>")
	else if(usr.client.language == "Russian")
		usr.client.language = "English"
		to_chat(src, "<span class='notice'>Now your language is English</span>")