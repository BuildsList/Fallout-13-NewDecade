/datum/game_mode/traitor/changeling
	name = "traitor+changeling"
	config_tag = "traitorchan"
	restricted_jobs = list("AI", "Cyborg")
	required_players = 25
	required_enemies = 1	// how many of each type are required
	recommended_enemies = 3
	reroll_friendly = 1

	var/list/possible_changelings = list()
	var/const/changeling_amount = 1 //hard limit on changelings if scaling is turned off

/datum/game_mode/traitor/changeling/announce()
	to_chat(world, "<B>The current game mode is - Traitor+Changeling!</B>")
	to_chat(world, "<B>There are alien creatures on the station along with some syndicate operatives out for their own gain! Do not let the changelings or the traitors succeed!</B>")

/datum/game_mode/traitor/changeling/can_start()
	if(!..())
		return 0
	possible_changelings = get_players_for_role(ROLE_CHANGELING)
	if(possible_changelings.len < required_enemies)
		return 0
	return 1

/datum/game_mode/traitor/changeling/pre_setup()
	if(config.protect_roles_from_antagonist)
		restricted_jobs += protected_jobs

	if(config.protect_assistant_from_antagonist)
		restricted_jobs += "Assistant"

	var/list/datum/mind/possible_changelings = get_players_for_role(ROLE_CHANGELING)

	var/num_changelings = 1

	if(config.changeling_scaling_coeff)
		num_changelings = max(1, min( round(num_players()/(config.changeling_scaling_coeff*4))+2, round(num_players()/(config.changeling_scaling_coeff*2)) ))
	else
		num_changelings = max(1, min(num_players(), changeling_amount/2))

	if(possible_changelings.len>0)
		for(var/j = 0, j < num_changelings, j++)
			if(!possible_changelings.len) break
			var/datum/mind/changeling = pick(possible_changelings)
			antag_candidates -= changeling
			possible_changelings -= changeling
			changeling.special_role = "Changeling"
			changelings += changeling
			changeling.restricted_roles = restricted_jobs
		return ..()
	else
		return 0

/datum/game_mode/traitor/changeling/post_setup()
	modePlayer += changelings
	for(var/datum/mind/changeling in changelings)
		changeling.current.make_changeling()
		forge_changeling_objectives(changeling)
		greet_changeling(changeling)
		ticker.mode.update_changeling_icons_added(changeling)
	..()
	return

/datum/game_mode/traitor/changeling/make_antag_chance(mob/living/carbon/human/character) //Assigns changeling to latejoiners
	var/changelingcap = min( round(joined_player_list.len/(config.changeling_scaling_coeff*4))+2, round(joined_player_list.len/(config.changeling_scaling_coeff*2)) )
	if(ticker.mode.changelings.len >= changelingcap) //Caps number of latejoin antagonists
		..()
		return
	if(ticker.mode.changelings.len <= (changelingcap - 2) || prob(100 / (config.changeling_scaling_coeff * 4)))
		if(ROLE_CHANGELING in character.client.prefs.be_special)
			if(!jobban_isbanned(character, ROLE_CHANGELING) && !jobban_isbanned(character, "Syndicate"))
				if(age_check(character.client))
					if(!(character.job in restricted_jobs))
						character.mind.make_Changling()
	..()
