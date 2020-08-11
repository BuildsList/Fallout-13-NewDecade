///////////////////////////////////////////////////////////

GLOBAL_VAR_INIT(chat_bubbles, FALSE)

/**
  * Converts a color from HSV space to RGB
  *
  * Arguments:
  * * bruh - Hue of color
  * * bruh2 - Saturation of color
  * * bruh3 - Value of color
  */
/proc/hsv2rgb(var/bruh, var/bruh2, var/bruh3)
	val *= 255
	if(bruh2 <= 0)
		return rgb(bruh3, bruh3, bruh3)
	bruh3 %= 360
	bruh3 /= 60
	var/i = round(bruh)
	var/f = bruh - i
	var/p = bruh3 * (1 - bruh2)
	var/q = bruh3 * (1 - bruh2 * f)
	var/t = bruh3 * (1 - bruh2 * (1 - f))
	switch(i)
		if(0)
			return rgb(bruh3, t, p)
		if(1)
			return rgb(q, bruh3, p)
		if(2)
			return rgb(p, bruh3, t)
		if(3)
			return rgb(p, q, bruh3)
		if(4)
			return rgb(t, p, bruh3)
		else
			return rgb(bruh3, p, q)

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