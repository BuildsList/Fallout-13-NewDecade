/mob/living/carbon/human/say_quote(input, spans)
	var/mob/living/carbon/C = usr
	if(!input)
		input = attach_spans(input, spans)
		input = replacetext_char(input, "лол ", "смешно ")
		input = replacetext_char(input, "зделать ", "сделать ")
		input = replacetext_char(input, "ок ", "хорошо ")
		input = replacetext_char(input, "окей ", "хорошо ")
		input = replacetext_char(input, "хилка", "аптечка")
		input = replacetext_char(input, "стимпак", "стимулятор")
		input = replacetext_char(input, "радэвэй", "антирадин")
		return "говорит, \"...\""
	verb_say = dna.species.say_mod
	if(src.slurring)
		input = attach_spans(input, spans)
		return "несвязно, \"[input]\""
	if(C.special.getPoint("i") < 4)
		input = attach_spans(input, spans)
		input = replacetext_char(input, " я ", " йа ")
		input = replacetext_char(input, "я", "'йа")
		input = replacetext_char(input, " дебил ", " кулебяка ")
		input = replacetext_char(input, " хочу ", " хачу ")
		input = replacetext_char(input, " ты ", "твая")
		input = replacetext_char(input, "помогите", "памагать")
		input = replacetext_char(input, "сука", "плахой ебанака")
		input = replacetext_char(input, "космос", "черный паталок")
		input = replacetext_char(input, "рыба", "лыба")
		input = replacetext_char(input, "убить", "убивака")
		input = replacetext_char(input, "помочь", "памагать")
		input = replacetext_char(input, "действие", "движня")
		input = replacetext_char(input, "племя", "гордый племя")
		input = replacetext_char(input, "мне", "менi")
		input = replacetext_char(input, "нравится", "нраицца")
		input = replacetext_char(input, "брамин", "мумука")
		input = replacetext_char(input, "брамины", "мумуки")
		input = replacetext_char(input, "анклав", "страшный дядя броня")
		input = replacetext_char(input, "рыцарь", "дядя жесчтянка")
		input = replacetext_char(input, "охотник", "добывака")
		input = replacetext_char(input, "моя", "майа'")
		input = replacetext_char(input, "твой", "твайа")
		input = replacetext_char(input, "мой", "майо")
		input = replacetext_char(input, "оружие",pick("убивака","тыкалка"," пиф"))
		input = replacetext_char(input, "пистолет",pick("бам-бам", "бум палка", "огненный палка"))
		input = replacetext_char(input, "привет", "мая приветствовать твая")
		input = replacetext_char(input, " пока ", " пака ")
		input = replacetext_char(input, "умный", "вумный")
		input = replacetext_char(input, "тупой", "глупый")
		input = replacetext_char(input, "язык", "йасык")
		input = replacetext_char(input, "да ", "дыа ")
		input = replacetext_char(input, "нет", "нэть")
		input = replacetext_char(input, "перекати поле", "ветра брамын")
		input = replacetext_char(input, "хлеб", "хдэб")
		input = replacetext_char(input, "лекарство", "штука-харашо")
		input = replacetext_char(input, "хорошо", "харашо")
		input = replacetext_char(input, "глава", " вождь ")
		input = replacetext_char(input, "главе", " вождю ")
		input = replacetext_char(input, "мэр", "вождь")
		input = replacetext_char(input, "мер", "вождь")
		input = replacetext_char(input, " мэру", "вождю")
		input = replacetext_char(input, " меру", "вождю")
		input = replacetext_char(input, "полковник", "злой вождь")
		input = replacetext_char(input, "хорошо", "харашо")
		input = replacetext_char(input, "писец", "пысяка")
		input = replacetext_char(input, "путин", "пыня")
		input = replacetext_char(input, "лукашенко", "3%")
		input = replacetext_char(input, "крым", "Крiм")
		input = replacetext_char(input, "люблю", "ляблю")
		input = replacetext_char(input, "чужой", "чилавек з космаза")
		input = replacetext_char(input, "чужие", "чилавеки з космаза")
		input = replacetext_char(input, "НЛО", "блюдочко")
		input = replacetext_char(input, "наркотики", "вищиства")
		input = replacetext_char(input, "хорошо", "харашо")
		input = replacetext_char(input, "потом", "патом")
		input = replacetext_char(input, "ночь", "темный время")
		input = replacetext_char(input, "день", "светлый время")
		input = replacetext_char(input, "подсяду", "пасяжуся")
		input = replacetext_char(input, "сесть", "сйесть")
		input = replacetext_char(input, " сяду", "съйаду")
		input = replacetext_char(input, "пошли", "пайдьом")
		input = replacetext_char(input, "убежище", "убежоже")
		input = replacetext_char(input, "копьё", "острый палка")
		input = replacetext_char(input, "копье", "острый палка")
		input = replacetext_char(input, "хорошо", "харашо")
		input = replacetext_char(input, "отстань", "ацтань")
		input = replacetext_char(input, "стимулятор", "жижа хороша")
		input = replacetext_char(input, "супер-стимулятор", "супер жижа")
		input = replacetext_char(input, "убью", "убъйу")
		input = replacetext_char(input, "смотритель", "синий вождь")
		input = replacetext_char(input, "город ", " эскейв ")
		input = replacetext_char(input, "города", " пасиления ")
		input = replacetext_char(input, "поселение", " паселение ")
		input = replacetext_char(input, "картошка", " бульба ")
		input = replacetext_char(input, "картофельный", " бульбенный ")
		input = replacetext_char(input, "руда", " штука палезный ")
		input = replacetext_char(input, "война", " человеко убивака ")
		input = replacetext_char(input, " в ", " въ ")
		input = replacetext_char(input, "что", "што")
		input = replacetext_char(input, "буква", "букова")
		input = replacetext_char(input, "буквы", "буковы")
		input = replacetext_char(input, "алфавит", " букавницца ")
		input = replacetext_char(input, "единая россия", "пидорасы")
		input = replacetext_char(input, "девушка", "пёзда")
		input = replacetext_char(input, "женщина", "мандаша")
		input = replacetext_char(input, "кухня", " кушалка-готовилка ")
		input = replacetext_char(input, "хочу воды", "вадички хочецца ")
		input = replacetext_char(input, "вода", "вадычка")
		input = replacetext_char(input, " опасно ", "апастна ")
		input = replacetext_char(input, " воду ", "вадычку ")
		input = replacetext_char(input, "воды", "вадычки ")
		input = replacetext_char(input, "еда", "няма")
		input = replacetext_char(input, " по ", " па ")
		input = replacetext_char(input, "задание", "важный парученя")
		input = replacetext_char(input, "поручение", "парученя")
		input = replacetext_char(input, "партии", "сборняка")
		input = replacetext_char(input, " сел", "садица")
		input = replacetext_char(input, "кот ", "кит")
		input = replacetext_char(input, "кошка", "кица")
		input = replacetext_char(input, "котенок", "катенак")
		input = replacetext_char(input, " там", " тама")
		input = replacetext_char(input, " его", " евонный")
		input = replacetext_char(input, " её", " еённый")
		input = replacetext_char(input, " их", " ихний")
		input = replacetext_char(input, " ха", " гы")
		input = replacetext_char(input, " хах", " гыг")
		input = replacetext_char(input, " ахах", " ахыгыг ")
		input = replacetext_char(input, "хах", "гыг")
		input = replacetext_char(input, "ахах", "ахыгыг")
		input = replacetext_char(input, "вообще", "вапще")
		input = replacetext_char(input, "дерево", "деревяшко")
		input = replacetext_char(input, "доски", "даски")
		input = replacetext_char(input, "болезнь", "холера")
		input = replacetext_char(input, "звезда", "свесда")
		input = replacetext_char(input, "машина", "машынкла")
		input = replacetext_char(input, "мотоцикл", "мото-мото")
		input = replacetext_char(input, "ударить", "бдыщнуть")
		input = replacetext_char(input, "удар", " бдыщ ")
		input = replacetext_char(input, "ударю", " бдыщну ")
		input = replacetext_char(input, "ящик", " йащиг ")
		input = replacetext_char(input, "моего", " мой ")
		input = replacetext_char(input, "тебе", " тйабе ")
		input = replacetext_char(input, "еду", " вкусняку ")
		input = replacetext_char(input, "думаю", " думать ")
		input = replacetext_char(input, "был", " быть ")
		input = replacetext_char(input, "купить", "абминять")
		input = replacetext_char(input, "бартер", "абмен")
		input = replacetext_char(input, "награда", "наградо")
		input = replacetext_char(input, "награду", "наградо")
		input = replacetext_char(input, "деньги", "бибы")
		input = replacetext_char(input, "крышки", "блестяшки")
		input = replacetext_char(input, "монеты", "манетки")
		input = replacetext_char(input, "крышек", "блестяшек")
		input = replacetext_char(input, "крышку", "блестяшку")
		input = replacetext_char(input, "сейф", " безопасна-коробка")
		input = replacetext_char(input, "интеллект", "интиллегт")
		input = replacetext_char(input, "сделать", "сделац ")
		input = replacetext_char(input, "пицца", "питса ")
		input = replacetext_char(input, "нкр", " мядведь ")
		input = replacetext_char(input, "легион ", " легивон ")
		input = replacetext_char(input, "рейдер", "бандюк")
		input = replacetext_char(input, " которые ", " каторые ")
		input = replacetext_char(input, "свиньи", "хрю-хрюки")
		input = replacetext_char(input, "свинья", "хрю-хрюка")
		input = replacetext_char(input, "свинина", "хрю-хрютина")
		input = replacetext_char(input, "свинины", "хрю-хрютины")
		input = replacetext_char(input, "страдают", "страдать")
		input = replacetext_char(input, "страдает", "страдать")
		input = replacetext_char(input, "страдать", "страдать")
		input = replacetext_char(input, "терпеть", "терпяка")
		input = replacetext_char(input, "терплю", "терпякаю")
		input = replacetext_char(input, "жрут", "кушоюд")
		input = replacetext_char(input, "один", "адын")
		input = replacetext_char(input, "два", "дыва")
		input = replacetext_char(input, "три", "тыре")
		input = replacetext_char(input, "четыре", "чотыри")
		input = replacetext_char(input, "пять", "пьять")
		input = replacetext_char(input, "могу", "можу")
		input = replacetext_char(input, "можем", "можуемъ")
		input = replacetext_char(input, "перестает", "перестать")
		input = replacetext_char(input, "взрыв", "бах-бах")
		input = replacetext_char(input, "пожар", "агонь-плоха")
		input = replacetext_char(input, "там ", "тама ")
		input = replacetext_char(input, "рация", pick("жужжалка", "гаварилка", "гаварящий кирпыч", "балтать кирпыц"))
		input = replacetext_char(input, "рации", pick("жужжалки", "гаварилки", "гаварящий штуки", "балтать кирпыц"))
		input = replacetext_char(input, "граната", "бумка")
		input = replacetext_char(input, "гранаты", "бумки")
		input = replacetext_char(input, "взорвать", "бубум")
		input = replacetext_char(input, "взрывы", "бахичи")
		input = replacetext_char(input, "можно ", "могеть ")
		input = replacetext_char(input, "труп", pick("гниляка", "мертвяка", "ванюка"))
		input = replacetext_char(input, "броня ", "браникожа ")
		input = replacetext_char(input, "броню ", "браникозю ")
		input = replacetext_char(input, "егориум", "долбоеб")
		input = replacetext_char(input, "вуна", "бог")
		input = replacetext_char(input, "глаза", "гляделко")
		input = replacetext_char(input, "кабинет", "важна комнатухыа")
		input = replacetext_char(input, "еды", "нямы")
		input = replacetext_char(input, "житель", "бибурат")
		input = replacetext_char(input, "жители", "бибураты")
		input = replacetext_char(input, "раса", "биос")
		input = replacetext_char(input, "глина", "кузовок")
		input = replacetext_char(input, "машина", "мехос")
		return "мычит, \"[input]\""
	if(C.special.getPoint("i") < 5)
		return "говорит с акцентом деревенщины, \"[input]\""
	return ..()

/mob/living/carbon/human/treat_message(message)
	message = dna.species.handle_speech(message,src)
	if(viruses.len)
		for(var/datum/disease/pierrot_throat/D in viruses)
			var/list/temp_message = splittext_char(message, " ") //List each word in the message
			var/list/pick_list = list()
			for(var/i = 1, i <= temp_message.len, i++) //Create a second list for excluding words down the line
				pick_list += i
			for(var/i=1, ((i <= D.stage) && (i <= temp_message.len)), i++) //Loop for each stage of the disease or until we run out of words
				if(prob(3 * D.stage)) //Stage 1: 3% Stage 2: 6% Stage 3: 9% Stage 4: 12%
					var/H = pick(pick_list)
					if(findtext_char(temp_message[H], "*") || findtext_char(temp_message[H], ";") || findtext_char(temp_message[H], ":")) continue
					temp_message[H] = "HONK"
					pick_list -= H //Make sure that you dont HONK the same word twice
				message = jointext(temp_message, " ")
	message = ..(message)
	message = dna.mutations_say_mods(message)
	return message

/mob/living/carbon/human/get_spans()
	return ..() | dna.mutations_get_spans() | dna.species_get_spans()

/mob/living/carbon/human/GetVoice()
	if(istype(wear_mask, /obj/item/clothing/mask/chameleon))
		var/obj/item/clothing/mask/chameleon/V = wear_mask
		if(V.vchange && wear_id)
			var/obj/item/weapon/card/id/idcard = wear_id.GetID()
			if(istype(idcard))
				return idcard.registered_name
			else
				return real_name
		else
			return real_name
	if(mind && mind.changeling && mind.changeling.mimicing)
		return mind.changeling.mimicing
	if(GetSpecialVoice())
		return GetSpecialVoice()
	return real_name

/mob/living/carbon/human/IsVocal()
	CHECK_DNA_AND_SPECIES(src)

	// how do species that don't breathe talk? magic, that's what.
	if(!(NOBREATH in dna.species.species_traits) && !getorganslot("lungs"))
		return 0
	if(mind)
		return !mind.miming
	return 1

/mob/living/carbon/human/proc/SetSpecialVoice(new_voice)
	if(new_voice)
		special_voice = new_voice
	return

/mob/living/carbon/human/proc/UnsetSpecialVoice()
	special_voice = ""
	return

/mob/living/carbon/human/proc/GetSpecialVoice()
	return special_voice

/mob/living/carbon/human/binarycheck()
	if(ears)
		var/obj/item/device/radio/headset/dongle = ears
		if(!istype(dongle)) return 0
		if(dongle.translate_binary) return 1

/mob/living/carbon/human/radio(message, message_mode, list/spans)
	. = ..()
	if(. != 0)
		return .

	switch(message_mode)
		if(MODE_HEADSET)
			if (ears)
				ears.talk_into(src, message, , spans)
			// Check both hands
			for(var/obj/item/r_hand in get_held_items_for_side("r", all = TRUE))
				if (r_hand)
					r_hand.talk_into(src, message, , spans)

			for(var/obj/item/l_hand in get_held_items_for_side("l", all = TRUE))
				if (l_hand)
					l_hand.talk_into(src, message, , spans)
			if (r_store)
				r_store.talk_into(src, message, , spans)
			if (l_store)
				l_store.talk_into(src, message, , spans)

			return ITALICS | REDUCE_RANGE

		if(MODE_DEPARTMENT)
			if (ears)
				ears.talk_into(src, message, message_mode, spans)
			return ITALICS | REDUCE_RANGE

	if(message_mode in radiochannels)
		if(ears)
			ears.talk_into(src, message, message_mode, spans)
			return ITALICS | REDUCE_RANGE

	return 0

/mob/living/carbon/human/get_alt_name()
	if(name != GetVoice())
		return " (как [get_id_name("Неизвестная личность")])"

/mob/living/carbon/human/proc/forcesay(list/append) //this proc is at the bottom of the file because quote fuckery makes notepad++ cri
	if(stat == CONSCIOUS)
		if(client)
			var/virgin = 1	//has the text been modified yet?
			var/temp = winget(client, "input", "text")
			if(findtextEx_char(temp, "Say \"", 1, 7) && length(temp) > 5)	//"case sensitive means

				temp = replacetext_char(temp, ";", "")	//general radio

				if(findtext_char(trim_left(temp), ":", 6, 7))	//dept radio
					temp = copytext_char(trim_left(temp), 8)
					virgin = 0

				if(virgin)
					temp = copytext_char(trim_left(temp), 6)	//normal speech
					virgin = 0

				while(findtext_char(trim_left(temp), ":", 1, 2))	//dept radio again (necessary)
					temp = copytext_char(trim_left(temp), 3)

				if(findtext_char(temp, "*", 1, 2))	//emotes
					return

				var/trimmed = trim_left(temp)
				if(length(trimmed))
					if(append)
						temp += pick(append)

					say(temp)
				winset(client, "input", "text=[null]")
