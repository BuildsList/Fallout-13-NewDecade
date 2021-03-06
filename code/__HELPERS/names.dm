
/proc/lizard_name(gender)
	if(gender == MALE)
		return "[pick(lizard_names_male)]-[pick(lizard_names_male)]"
	else
		return "[pick(lizard_names_female)]-[pick(lizard_names_female)]"

/proc/plasmaman_name()
	return "[pick(plasmaman_names)] \Roman[rand(1,99)]"

var/church_name = null
/proc/church_name()
	if (church_name)
		return church_name

	var/name = ""

	name += pick("Holy", "United", "First", "Second", "Last")

	if (prob(20))
		name += " Space"

	name += " " + pick("Church", "Cathedral", "Body", "Worshippers", "Movement", "Witnesses")
	name += " of [religion_name()]"

	return name

var/command_name = null
/proc/command_name()
	if (command_name)
		return command_name

	var/name = "Central Command"

	command_name = name
	return name

/proc/change_command_name(name)

	command_name = name

	return name

var/religion_name = null
/proc/religion_name()
	if (religion_name)
		return religion_name

	var/name = ""

	name += pick("bee", "science", "edu", "captain", "assistant", "monkey", "alien", "space", "unit", "sprocket", "gadget", "bomb", "revolution", "beyond", "station", "goon", "robot", "ivor", "hobnob")
	name += pick("ism", "ia", "ology", "istism", "ites", "ick", "ian", "ity")

	return capitalize(name)

/proc/station_name()
	if(station_name)
		return station_name

	if(config && config.station_name)
		station_name = config.station_name
	else
		station_name = new_station_name()

	if(config && config.server_name)
		world.name = "[config.server_name][config.server_name==station_name ? "" : ": [station_name]"]"
	else
		world.name = station_name

	return station_name

/proc/new_station_name()
	var/random = rand(1,5)
	var/name = ""
	var/new_station_name = ""

	//Rare: Pre-Prefix
	if (prob(10))
		name = pick("Traders of", "Merchants of", "Brotherhood of", "Mutants of", "Ghouls of", "Followers of", "Soldiers of", "Raiders of", "Slavers of", "Slaves of", "Outcasts of", "Guild of", "Squad of", "State of", "Scientists of", "Gun Runners of", "Union of", "Alliance of", "Government of", "Tribe of", "Rangers of", "Remnants of", "Gang of", "Experiment of", "Ultra Quest of", "Secret Knowledge of", "Top Secret of", "Crazy Chronicle of", "Insane Story of", "Mad Tale of", "Psychotic Diary of", "Wild Ballad of")
		new_station_name = name + " "
		name = ""

	// Prefix
	for(var/holiday_name in SSevent.holidays)
		if(holiday_name == "Friday the 13th")
			random = 13
		var/datum/holiday/holiday = SSevent.holidays[holiday_name]
		name = holiday.getStationPrefix()
		//get normal name
	if(!name)
		name = pick("", "Enclave", "Steel", "Ghoul", "Crimson", "Regulator", "Hubologist", "Super Mutant", "The Apocalypse", "Ranger", "Psychic", "Psyker", "Underground", "Conspiracy", "Rogue", "New California Republic", "Vault-Tec", "Nuka Cola", "Sunset Sarsaparilla", "The Vault Dweller", "The Chosen One", "The Lone Wanderer", "The Courier", "The Sole Survivor", "North", "West", "East", "South", "Overseer", "Elder", "President", "Caesar's", "Imperial", "Unidentified", "Deathclaw", "Control", "Brahmin", "Glowing One", "Gecko", "Mole Rat", "Tunnel Snake", "Skeleton", "Deathclaw", "Rad Scorpion", "Fat Man", "Gentleman", "Capitalist", "Communist", "Radroach", "Robot", "Eyebot", "Sentry Bot", "Protectron", "Robobrain", "Mister Handy", "Mister Gutsy", "PDQ-88b Securitron", "Liberty Prime", "Dwarf", "G.E.C.K.", "Terminal", "RobCo", "REPCONN", "Vertibird", "Supply", "Military", "Mirelurk", "GNR", "Science", "Tribesmen", "Minutemen")
	if(name)
		new_station_name += name + " "

	// Suffix
	name = pick("Vault", "Hideout", "Army", "Building", "Museum", "Caravan", "Lab", "Hazard", "Junkyard", "Bunker", "Shack", "Hut", "Cemetery", "Cave", "Cavern", "Department", "Trade Post", "Fort", "Village", "Town", "City", "Radio", "Wasteland", "Complex", "Base", "Facility", "Depot", "Outpost", "Legion", "Necropolis", "Observatory", "Array", "Relay", "Manhole", "Shelter", "Valley", "Hangar", "Prison", "Center", "Port", "Waystation", "Factory", "Hotel", "Stopover", "Hub", "HQ", "Office", "Casino", "Fortification", "Colony", "Camping", "Camp", "Sewer")
	new_station_name += name + " "

	// ID Number
	switch(random)
		if(1)
			new_station_name += "[rand(1, 99)]"
		if(2)
			new_station_name += pick("Alpha", "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta", "Iota", "Kappa", "Lambda", "Mu", "Nu", "Xi", "Omicron", "Pi", "Rho", "Sigma", "Tau", "Upsilon", "Phi", "Chi", "Psi", "Omega")
		if(3)
			new_station_name += pick("II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX")
		if(4)
			new_station_name += pick("Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "India", "Juliet", "Kilo", "Lima", "Mike", "November", "Oscar", "Papa", "Quebec", "Romeo", "Sierra", "Tango", "Uniform", "Victor", "Whiskey", "X-ray", "Yankee", "Zulu")
		if(5)
			new_station_name += pick("One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen")
		if(13)
			new_station_name += pick("13","XIII","Thirteen")
	return new_station_name

var/syndicate_name = null
/proc/syndicate_name()
	if (syndicate_name)
		return syndicate_name

	var/name = ""

	// Prefix
	name += pick("Clandestine", "Prima", "Blue", "Zero-G", "Max", "Blasto", "Waffle", "North", "Omni", "Newton", "Cyber", "Bonk", "Gene", "Gib")

	// Suffix
	if (prob(80))
		name += " "

		// Full
		if (prob(60))
			name += pick("Syndicate", "Consortium", "Collective", "Corporation", "Group", "Holdings", "Biotech", "Industries", "Systems", "Products", "Chemicals", "Enterprises", "Family", "Creations", "International", "Intergalactic", "Interplanetary", "Foundation", "Positronics", "Hive")
		// Broken
		else
			name += pick("Syndi", "Corp", "Bio", "System", "Prod", "Chem", "Inter", "Hive")
			name += pick("", "-")
			name += pick("Tech", "Sun", "Co", "Tek", "X", "Inc", "Code")
	// Small
	else
		name += pick("-", "*", "")
		name += pick("Tech", "Sun", "Co", "Tek", "X", "Inc", "Gen", "Star", "Dyne", "Code", "Hive")

	syndicate_name = name
	return name


//Traitors and traitor silicons will get these. Revs will not.
var/syndicate_code_phrase//Code phrase for traitors.
var/syndicate_code_response//Code response for traitors.

	/*
	Should be expanded.
	How this works:
	Instead of "I'm looking for James Smith," the traitor would say "James Smith" as part of a conversation.
	Another traitor may then respond with: "They enjoy running through the void-filled vacuum of the derelict."
	The phrase should then have the words: James Smith.
	The response should then have the words: run, void, and derelict.
	This way assures that the code is suited to the conversation and is unpredicatable.
	Obviously, some people will be better at this than others but in theory, everyone should be able to do it and it only enhances roleplay.
	Can probably be done through "{ }" but I don't really see the practical benefit.
	One example of an earlier system is commented below.
	/N
	*/

/proc/generate_code_phrase()//Proc is used for phrase and response in master_controller.dm

	var/code_phrase = ""//What is returned when the proc finishes.
	var/words = pick(//How many words there will be. Minimum of two. 2, 4 and 5 have a lesser chance of being selected. 3 is the most likely.
		50; 2,
		200; 3,
		50; 4,
		25; 5
	)

	var/safety[] = list(1,2,3)//Tells the proc which options to remove later on.
	var/nouns[] = list("????????????","??????????????????","????????????","??????","??????????","????????????????","??????????????????","????????????????","??????????????????","????????","????????????","??????????","????????????????","??????????","????????????","????????????","??????????????","??????????????????","????????","????????????????","??????????????????????","??????????","????????????????????","????????????","??????????","??????????????","????????????","??????????????????","????????????????????","????????????????","??????????????","dedication","????????????????","??????????????????????","hospitality","leisure","????????????????","????????????", "??????????")
	var/drinks[] = list("?????????? ?? ??????????","????????","???????????? ????????","??????????????????","???????????? ??????????????","?????????? ????????","????????-????????????","??????????????????","???????????????????? ????????"," ?????????????? ??????????","???????????????????? ????????","?????????????????????? ??????????????","???????????? ????????","???????????? ??????????????","??????","????????????????","???????????????? ????????","?????????? ????????","?????????? ??????????????","?????????? ?? ??????????????","??????????????","???????? ??????????","????????????","??????????","????????","??????????????")
	var/locations[] = teleportlocs.len ? teleportlocs : drinks//if null, defaults to drinks instead.

	var/names[] = list()
	for(var/datum/data/record/t in data_core.general)//Picks from crew manifest.
		names += t.fields["name"]

	var/maxwords = words//Extra var to check for duplicates.

	for(words,words>0,words--)//Randomly picks from one of the choices below.

		if(words==1&&(1 in safety)&&(2 in safety))//If there is only one word remaining and choice 1 or 2 have not been selected.
			safety = list(pick(1,2))//Select choice 1 or 2.
		else if(words==1&&maxwords==2)//Else if there is only one word remaining (and there were two originally), and 1 or 2 were chosen,
			safety = list(3)//Default to list 3

		switch(pick(safety))//Chance based on the safety list.
			if(1)//1 and 2 can only be selected once each to prevent more than two specific names/places/etc.
				switch(rand(1,2))//Mainly to add more options later.
					if(1)
						if(names.len&&prob(70))
							code_phrase += pick(names)
						else
							if(prob(10))
								code_phrase += pick(lizard_name(MALE),lizard_name(FEMALE))
							else
								code_phrase += pick(pick(first_names_male,first_names_female))
								code_phrase += " "
								code_phrase += pick(last_names)
					if(2)
						code_phrase += pick(get_all_jobs())//Returns a job.
				safety -= 1
			if(2)
				switch(rand(1,2))//Places or things.
					if(1)
						code_phrase += pick(drinks)
					if(2)
						code_phrase += pick(locations)
				safety -= 2
			if(3)
				switch(rand(1,3))//Nouns, adjectives, verbs. Can be selected more than once.
					if(1)
						code_phrase += pick(nouns)
					if(2)
						code_phrase += pick(adjectives)
					if(3)
						code_phrase += pick(verbs)
		if(words==1)
			code_phrase += "."
		else
			code_phrase += ", "

	return code_phrase
