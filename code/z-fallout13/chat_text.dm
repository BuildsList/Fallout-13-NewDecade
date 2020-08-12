///////////////////////////////////////////////////////////

GLOBAL_VAR_INIT(chat_bubbles, FALSE)

/**
  * Converts a color from HSV space to RGB
  *
  * Arguments:
  * * Hue - Hue of color
  * * Sat - Saturation of color
  * * Val - Value of color
  */
/proc/hsv2rgb(var/Hue, var/Sat, var/Val)
	val *= 255
	if(Sat <= 0)
		return rgb(Val, Val, Val)
	Val %= 360
	Val /= 60
	var/i = round(bruh)
	var/f = Hue - i
	var/p = Val * (1 - Sat)
	var/q = Val * (1 - Sat * f)
	var/t = Val * (1 - Sat * (1 - f))
	switch(i)
		if(0)
			return rgb(Val, t, p)
		if(1)
			return rgb(q, Val, p)
		if(2)
			return rgb(p, Val, t)
		if(3)
			return rgb(p, q, Val)
		if(4)
			return rgb(t, p, Val)
		else
			return rgb(Val, p, q)

/mob/living
	// Vars used for Runescape-Style Chat
	/// Stores the current visible chats
	var/obj/chattext/chattext = new
	/// Stores the last name heard
	var/last_heard_name = null
	/// Stores the last used color
	var/last_used_color = null

/obj/chattext
	var/list/chats = list()

/image/speech_text
	maptext_width = (32 * 4)
	alpha = 0

/proc/show_speech_text(message, message_language, mob/living/L, var/list/show_to, duration)
	if(!istype(L))
		return

	message = copytext(message, 1, 160) // no super long messages

	var/image/speech_text/S = new // create invisible object, bind it to speaking mob
	S.loc = L
	S.layer = FLY_LAYER

	S.maptext = "<span class='pixel c ol' style='color: white'>[message]</span>"
	S.pixel_x = -1.5 * L.bound_width
	S.pixel_y = L.bound_height

	for(var/client/C in show_to)
		if(C.mob.can_hear() && C.mob.has_language(message_language) && GLOB.chat_bubbles)
			C.images += S
		else if(isobserver(C.mob))
			C.images += S

	L.chattext.chats += S
	for(var/image/I in L.chattext.chats)
		if(I != S)
			var/client/who = null // we need a client to run MeasureText, don't ask me why
			if(length(GLOB.clients))
				who = GLOB.clients[1]
				var/new_y = I.pixel_y + text2num(splittext(who.MeasureText(S.maptext, width = S.maptext_width), "x")[2])
				animate(I, pixel_y = new_y, time=2)

	animate(S, alpha = 255, time=1)
	spawn(duration)
		var/new_y = S.pixel_y + 10
		animate(S, alpha = 0, pixel_y = new_y, time = 4)
		spawn(4)
			for(var/client/C in show_to)
				if(C.mob.can_hear() && C.mob.has_language(message_language) && GLOB.chat_bubbles)
					C.images -= S
				else if(isobserver(C.mob))
					C.images -= S
			L.chattext.chats -= S
			qdel(S)