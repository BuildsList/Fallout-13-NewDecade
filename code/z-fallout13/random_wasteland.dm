/obj/effect/landmark/stationroom
	var/list/template_names = list()
	layer = BULLET_HOLE_LAYER

/obj/effect/landmark/stationroom/New()
	..()
	GLOB.stationroom_landmarks += src

/obj/effect/landmark/stationroom/Destroy()
	if(src in GLOB.stationroom_landmarks)
		GLOB.stationroom_landmarks -= src
	return ..()

/obj/effect/landmark/stationroom/proc/load(template_name)
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE
	if(!template_name)
		for(var/t in template_names)
			if(!SSmapping.station_room_templates[t])
				log_world("Station room spawner placed at ([T.x], [T.y], [T.z]) has invalid ruin name of \"[t]\" in its list")
				template_names -= t
		template_name = pick(template_names)
	if(!template_name)
		GLOB.stationroom_landmarks -= src
		qdel(src)
		return FALSE
	var/datum/map_template/template = SSmapping.station_room_templates[template_name]
	if(!template)
		return FALSE
	testing("Ruin \"[template_name]\" placed at ([T.x], [T.y], [T.z])")
	template.load(T, centered = FALSE)
	template.loaded++
	GLOB.stationroom_landmarks -= src
	qdel(src)
	return TRUE

/datum/controller/subsystem/mapping
	var/list/station_room_templates = list()

/datum/controller/subsystem/mapping/proc/seedStation()
	for(var/V in GLOB.stationroom_landmarks)
		var/obj/effect/landmark/stationroom/LM = V
		LM.load()

	if(GLOB.stationroom_landmarks.len)
		seedStation() //I'm sure we can trust everyone not to insert a 1x1 rooms which loads a landmark which loads a landmark which loads a la...