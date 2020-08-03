///Вуна кринже код. Ну чё народ, погнали нахуй?

/obj/screen/menuf13
	icon = 'navarro/icons/menu/hudmenu.dmi'
	icon_state = "changelog"
	var/mob/new_player/PLAYER

/obj/screen/menuf13/join_game
	name = "Присоедениться"
	icon_state = "joingame"

/obj/screen/menuf13/join_game/Click()
	PLAYER.LateChoices()

/obj/screen/menuf13/setup
	name = "Настройки"
	icon_state = "settings"

/obj/screen/menuf13/setup/Click()