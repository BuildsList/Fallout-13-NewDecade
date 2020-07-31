//Clown PDA is slippery.
/obj/item/clothing/gloves/pda/clown
	name = "clown PDA"
	default_cartridge = /obj/item/weapon/cartridge/clown
	icon_state = "pda-clown"
	desco = "A portable microcomputer by Thinktronic Systems, LTD. The surface is coated with polytetrafluoroethylene and banana drippings."
	ttone = "honk"

/obj/item/clothing/gloves/pda/clown/Crossed(AM as mob|obj)
	if (istype(AM, /mob/living/carbon))
		var/mob/living/carbon/M = AM
		if(M.slip(0, 6, src, NO_SLIP_WHEN_WALKING))
			if (ishuman(M) && (M.real_name != src.owner))
				if (istype(src.cartridge, /obj/item/weapon/cartridge/clown))
					var/obj/item/weapon/cartridge/clown/cart = src.cartridge
					if(cart.honk_charges < 5)
						cart.honk_charges++


// Special AI/pAI PDAs that cannot explode.
/obj/item/clothing/gloves/pda/ai
	icon_state = "NONE"
	ttone = "data"
	fon = 0
	detonate = 0

/obj/item/clothing/gloves/pda/ai/attack_self(mob/user)
	if ((honkamt > 0) && (prob(60)))//For clown virus.
		honkamt--
		playsound(loc, 'sound/items/bikehorn.ogg', 30, 1)
	return

/obj/item/clothing/gloves/pda/ai/pai
	ttone = "assist"



/obj/item/clothing/gloves/pda/medical
	name = "medical PDA"
	default_cartridge = /obj/item/weapon/cartridge/medical
	icon_state = "pda-medical"

/obj/item/clothing/gloves/pda/viro
	name = "virology PDA"
	default_cartridge = /obj/item/weapon/cartridge/medical
	icon_state = "pda-virology"

/obj/item/clothing/gloves/pda/engineering
	name = "engineering PDA"
	default_cartridge = /obj/item/weapon/cartridge/engineering
	icon_state = "pda-engineer"

/obj/item/clothing/gloves/pda/security
	name = "security PDA"
	default_cartridge = /obj/item/weapon/cartridge/security
	icon_state = "pda-security"

/obj/item/clothing/gloves/pda/detective
	name = "detective PDA"
	default_cartridge = /obj/item/weapon/cartridge/detective
	icon_state = "pda-detective"

/obj/item/clothing/gloves/pda/warden
	name = "warden PDA"
	default_cartridge = /obj/item/weapon/cartridge/security
	icon_state = "pda-warden"

/obj/item/clothing/gloves/pda/janitor
	name = "janitor PDA"
	default_cartridge = /obj/item/weapon/cartridge/janitor
	icon_state = "pda-janitor"
	ttone = "slip"

/obj/item/clothing/gloves/pda/toxins
	name = "scientist PDA"
	default_cartridge = /obj/item/weapon/cartridge/signal/toxins
	icon_state = "pda-science"
	ttone = "boom"

/obj/item/clothing/gloves/pda/mime
	name = "mime PDA"
	default_cartridge = /obj/item/weapon/cartridge/mime
	icon_state = "pda-mime"
	silent = 1
	ttone = "silence"

/obj/item/clothing/gloves/pda/heads
	default_cartridge = /obj/item/weapon/cartridge/head
	icon_state = "pda-hop"

/obj/item/clothing/gloves/pda/heads/hop
	name = "head of personnel PDA"
	default_cartridge = /obj/item/weapon/cartridge/hop
	icon_state = "pda-hop"

/obj/item/clothing/gloves/pda/heads/hos
	name = "head of security PDA"
	default_cartridge = /obj/item/weapon/cartridge/hos
	icon_state = "pda-hos"

/obj/item/clothing/gloves/pda/heads/ce
	name = "chief engineer PDA"
	default_cartridge = /obj/item/weapon/cartridge/ce
	icon_state = "pda-ce"

/obj/item/clothing/gloves/pda/heads/cmo
	name = "chief medical officer PDA"
	default_cartridge = /obj/item/weapon/cartridge/cmo
	icon_state = "pda-cmo"

/obj/item/clothing/gloves/pda/heads/rd
	name = "research director PDA"
	default_cartridge = /obj/item/weapon/cartridge/rd
	icon_state = "pda-rd"

/obj/item/clothing/gloves/pda/captain
	name = "captain PDA"
	default_cartridge = /obj/item/weapon/cartridge/captain
	icon_state = "pda-captain"
	detonate = 0

/obj/item/clothing/gloves/pda/cargo
	name = "cargo technician PDA"
	default_cartridge = /obj/item/weapon/cartridge/quartermaster
	icon_state = "pda-cargo"

/obj/item/clothing/gloves/pda/quartermaster
	name = "quartermaster PDA"
	default_cartridge = /obj/item/weapon/cartridge/quartermaster
	icon_state = "pda-qm"

/obj/item/clothing/gloves/pda/shaftminer
	name = "shaft miner PDA"
	icon_state = "pda-miner"

/obj/item/clothing/gloves/pda/syndicate
	default_cartridge = /obj/item/weapon/cartridge/syndicate
	icon_state = "pda-syndi"
	name = "military PDA"
	owner = "John Doe"
	hidden = 1

/obj/item/clothing/gloves/pda/chaplain
	name = "chaplain PDA"
	icon_state = "pda-chaplain"
	ttone = "holy"

/obj/item/clothing/gloves/pda/lawyer
	name = "lawyer PDA"
	default_cartridge = /obj/item/weapon/cartridge/lawyer
	icon_state = "pda-lawyer"
	ttone = "objection"

/obj/item/clothing/gloves/pda/botanist
	name = "botanist PDA"
	//default_cartridge = /obj/item/weapon/cartridge/botanist
	icon_state = "pda-hydro"

/obj/item/clothing/gloves/pda/roboticist
	name = "roboticist PDA"
	icon_state = "pda-roboticist"
	default_cartridge = /obj/item/weapon/cartridge/roboticist

/obj/item/clothing/gloves/pda/librarian
	name = "librarian PDA"
	icon_state = "pda-library"
	icon_alert = "pda-r-library"
	default_cartridge = /obj/item/weapon/cartridge/librarian
	desco = "A portable microcomputer by Thinktronic Systems, LTD. This model is a WGW-11 series e-reader."
	note = "Congratulations, your station has chosen the Thinktronic 5290 WGW-11 Series E-reader and Personal Data Assistant!"
	silent = 1 //Quiet in the library!
	overlays_x_offset = -3

/obj/item/clothing/gloves/pda/clear
	name = "clear PDA"
	icon_state = "pda-clear"
	desco = "A portable microcomputer by Thinktronic Systems, LTD. This model is a special edition with a transparent case."
	note = "Congratulations, you have chosen the Thinktronic 5230 Personal Data Assistant Deluxe Special Max Turbo Limited Edition!"

/obj/item/clothing/gloves/pda/cook
	name = "cook PDA"
	icon_state = "pda-cook"

/obj/item/clothing/gloves/pda/bar
	name = "bartender PDA"
	icon_state = "pda-bartender"

/obj/item/clothing/gloves/pda/atmos
	name = "atmospherics PDA"
	default_cartridge = /obj/item/weapon/cartridge/atmos
	icon_state = "pda-atmos"

/obj/item/clothing/gloves/pda/chemist
	name = "chemist PDA"
	default_cartridge = /obj/item/weapon/cartridge/chemistry
	icon_state = "pda-chemistry"

/obj/item/clothing/gloves/pda/geneticist
	name = "geneticist PDA"
	default_cartridge = /obj/item/weapon/cartridge/medical
	icon_state = "pda-genetics"
