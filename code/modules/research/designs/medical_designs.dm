/////////////////////////////////////////
////////////Medical Tools////////////////
/////////////////////////////////////////


/datum/design/mass_spectrometer
	name = "Mass-Spectrometer"
	desc = "A device for analyzing chemicals in the blood."
	id = "mass_spectrometer"
	req_tech = list("magnets" = 2, "prewar" = 1)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 300, MAT_GLASS = 100)
	build_path = /obj/item/device/mass_spectrometer
	category = list("Medical Designs")

/datum/design/adv_mass_spectrometer
	name = "Advanced Mass-Spectrometer"
	desc = "A device for analyzing chemicals in the blood and their quantities."
	id = "adv_mass_spectrometer"
	req_tech = list("biotech" = 3, "magnets" = 4, "prewar" = 2)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 500, MAT_GLASS = 200)
	build_path = /obj/item/device/mass_spectrometer/adv
	category = list("Medical Designs")

/datum/design/mmi
	name = "Man-Machine Interface"
	desc = "The Warrior's bland acronym, MMI, obscures the true horror of this monstrosity."
	id = "mmi"
	req_tech = list("programming" = 3, "biotech" = 2, "engineering" = 2)
	build_type = PROTOLATHE | MECHFAB
	materials = list(MAT_METAL = 1000, MAT_GLASS = 500)
	construction_time = 75
	build_path = /obj/item/device/mmi
	category = list("Misc","Medical Designs")

/datum/design/posibrain
	name = "Positronic Brain"
	desc = "The latest in Artificial Intelligences."
	id = "mmi_posi"
	req_tech = list("programming" = 5, "biotech" = 4, "prewar" = 3)
	build_type = PROTOLATHE | MECHFAB
	materials = list(MAT_METAL = 1700, MAT_GLASS = 1350, MAT_GOLD = 500, MAT_COOPER = 500) //Gold, because SWAG.
	construction_time = 75
	build_path = /obj/item/device/mmi/posibrain
	category = list("Misc", "Medical Designs")

/datum/design/bluespacebeaker
	name = "Bluespace Beaker"
	desc = "A bluespace beaker, powered by experimental bluespace technology and Element Cuban combined with the Compound Pete. Can hold up to 300 units."
	id = "bluespacebeaker"
	req_tech = list("bluespace" = 6, "materials" = 5, "prewar" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_GLASS = 3000, MAT_COOPER = 1000, MAT_DIAMOND = 500)
	build_path = /obj/item/weapon/reagent_containers/glass/beaker/bluespace
	category = list("Medical Designs")

/datum/design/noreactbeaker
	name = "Cryostasis Beaker"
	desc = "A cryostasis beaker that allows for chemical storage without reactions. Can hold up to 50 units."
	id = "splitbeaker"
	req_tech = list("materials" = 3, "engineering" = 3, "prewar" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 3000)
	build_path = /obj/item/weapon/reagent_containers/glass/beaker/noreact
	category = list("Medical Designs")

/datum/design/bluespacesyringe
	name = "Bluespace Syringe"
	desc = "An advanced syringe that can hold 60 units of chemicals"
	id = "bluespacesyringe"
	req_tech = list("bluespace" = 4, "materials" = 4, "biotech" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_GLASS = 4000, MAT_DIAMOND = 2000)
	build_path = /obj/item/weapon/reagent_containers/syringe/bluespace
	category = list("Medical Designs")

/datum/design/noreactsyringe
	name = "Cryo Syringe"
	desc = "An advanced syringe that stops reagents inside from reacting. It can hold up to 20 units."
	id = "noreactsyringe"
	req_tech = list("materials" = 3, "engineering" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_GLASS = 4000, MAT_GOLD = 1000)
	build_path = /obj/item/weapon/reagent_containers/syringe/noreact
	category = list("Medical Designs")

/datum/design/piercesyringe
	name = "Piercing Syringe"
	desc = "A diamond-tipped syringe that pierces armor when launched at high velocity. It can hold up to 10 units."
	id = "piercesyringe"
	req_tech = list("materials" = 6, "combat" = 3, "engineering" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_GLASS = 4000, MAT_DIAMOND = 1500)
	build_path = /obj/item/weapon/reagent_containers/syringe/piercing
	category = list("Medical Designs")

/datum/design/bluespacebodybag
	name = "Bluespace body bag"
	desc = "A bluespace body bag, powered by experimental bluespace technology. It can hold loads of bodies and the largest of creatures."
	id = "bluespacebodybag"
	req_tech = list("bluespace" = 5, "materials" = 4, "prewar" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 3000, MAT_COOPER = 1000, MAT_DIAMOND = 500)
	build_path = /obj/item/bodybag/bluespace
	category = list("Medical Designs")
/*
/datum/design/plasmarefiller
	name = "Plasma-man jumpsuit refill"
	desc = "A refill pack for the auto-extinguisher on Plasma-man suits."
	id = "plasmarefiller"
	req_tech = list("materials" = 2, "plasmatech" = 3) //Why did this have no plasmatech
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 4000, MAT_PLASMA = 1000)
	build_path = /obj/item/device/extinguisher_refill
	category = list("Medical Designs")
*/
/datum/design/alienscalpel
	name = "Alien Scalpel"
	desc = "An advanced scalpel obtained through Abductor technology."
	id = "alien_scalpel"
	req_tech = list("bio" = 4, "materials" = 4, "abductor" = 3)
	build_path = /obj/item/weapon/scalpel/alien
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_SILVER = 1500, MAT_COOPER = 500, MAT_TITANIUM = 1500)
	category = list("Medical Designs")

/datum/design/alienhemostat
	name = "Alien Hemostat"
	desc = "An advanced hemostat obtained through Abductor technology."
	id = "alien_hemostat"
	req_tech = list("bio" = 4, "materials" = 4, "abductor" = 3)
	build_path = /obj/item/weapon/hemostat/alien
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_SILVER = 1500, MAT_COOPER = 500, MAT_TITANIUM = 1500)
	category = list("Medical Designs")

/datum/design/alienretractor
	name = "Alien Retractor"
	desc = "An advanced retractor obtained through Abductor technology."
	id = "alien_retractor"
	req_tech = list("bio" = 4, "materials" = 4, "abductor" = 3)
	build_path = /obj/item/weapon/retractor/alien
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_SILVER = 1500, MAT_COOPER = 500, MAT_TITANIUM = 1500)
	category = list("Medical Designs")

/datum/design/aliensaw
	name = "Alien Circular Saw"
	desc = "An advanced surgical saw obtained through Abductor technology."
	id = "alien_saw"
	req_tech = list("bio" = 4, "materials" = 4, "abductor" = 3)
	build_path = /obj/item/weapon/circular_saw/alien
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 10000, MAT_SILVER = 2500, MAT_COOPER = 1000, MAT_TITANIUM = 1500)
	category = list("Medical Designs")

/datum/design/aliendrill
	name = "Alien Drill"
	desc = "An advanced drill obtained through Abductor technology."
	id = "alien_drill"
	req_tech = list("bio" = 4, "materials" = 4, "abductor" = 3)
	build_path = /obj/item/weapon/surgicaldrill/alien
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 10000, MAT_SILVER = 2500, MAT_COOPER = 1000, MAT_TITANIUM = 1500)
	category = list("Medical Designs")

/datum/design/aliencautery
	name = "Alien Cautery"
	desc = "An advanced cautery obtained through Abductor technology."
	id = "alien_cautery"
	req_tech = list("bio" = 4, "materials" = 4, "abductor" = 3)
	build_path = /obj/item/weapon/cautery/alien
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_SILVER = 1500, MAT_COOPER = 500, MAT_TITANIUM = 1500)
	category = list("Medical Designs")

/////////////////////////////////////////
//////////Cybernetic Implants////////////
/////////////////////////////////////////

/datum/design/cyberimp_welding
	name = "Welding Shield implant"
	desc = "These reactive micro-shields will protect you from welders and flashes without obscuring your vision."
	id = "ci-welding"
	req_tech = list("materials" = 4, "biotech" = 4, "engineering" = 5, "prewar" = 3)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 40
	materials = list(MAT_METAL = 600, MAT_GLASS = 400)
	build_path = /obj/item/organ/eyes/robotic/shield
	category = list("Misc", "Medical Designs")

/datum/design/cyberimp_breather
	name = "Breathing Tube implant"
	desc = "This simple implant adds an internals connector to your back, allowing you to use internals without a mask and protecting you from being choked."
	id = "ci-breather"
	req_tech = list("materials" = 2, "biotech" = 3)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 35
	materials = list(MAT_METAL = 600, MAT_GLASS = 250)
	build_path = /obj/item/organ/cyberimp/mouth/breathing_tube
	category = list("Misc", "Medical Designs")

/datum/design/cyberimp_toolset
	name = "Toolset Arm implant"
	desc = "A stripped-down version of engineering cyborg toolset, designed to be installed on subject's arm."
	id = "ci-toolset"
	req_tech = list("materials" = 3, "engineering" = 4, "biotech" = 4, "powerstorage" = 4)
	build_type = PROTOLATHE | MECHFAB
	materials = list (MAT_METAL = 2500, MAT_GLASS = 1500, MAT_SILVER = 1500)
	construction_time = 200
	build_path = /obj/item/organ/cyberimp/arm/toolset
	category = list("Misc", "Medical Designs")

/datum/design/cyberimp_medical_hud
	name = "Medical HUD implant"
	desc = "These cybernetic eyes will display a medical HUD over everything you see. Wiggle eyes to control."
	id = "ci-medhud"
	req_tech = list("materials" = 5, "programming" = 4, "biotech" = 4)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 50
	materials = list(MAT_METAL = 600, MAT_GLASS = 600, MAT_SILVER = 500, MAT_COOPER = 500)
	build_path = /obj/item/organ/cyberimp/eyes/hud/medical
	category = list("Misc", "Medical Designs")

/datum/design/cyberimp_security_hud
	name = "Security HUD implant"
	desc = "These cybernetic eyes will display a security HUD over everything you see. Wiggle eyes to control."
	id = "ci-sechud"
	req_tech = list("materials" = 5, "programming" = 4, "biotech" = 4, "combat" = 3)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 50
	materials = list(MAT_METAL = 600, MAT_GLASS = 600, MAT_SILVER = 750, MAT_COOPER = 750)
	build_path = /obj/item/organ/cyberimp/eyes/hud/security
	category = list("Misc", "Medical Designs")

/datum/design/cyberimp_xray
	name = "X-Ray implant"
	desc = "These cybernetic eyes will give you X-ray vision. Blinking is futile."
	id = "ci-xray"
	req_tech = list("materials" = 6, "programming" = 5, "biotech" = 6, "magnets" = 5, "prewar" = 6)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 60
	materials = list(MAT_METAL = 600, MAT_GLASS = 600, MAT_SILVER = 600, MAT_GOLD = 600, MAT_COOPER = 1000, MAT_URANIUM = 1000, MAT_DIAMOND = 2000)
	build_path = /obj/item/organ/eyes/robotic/xray
	category = list("Misc", "Medical Designs")

/datum/design/cyberimp_thermals
	name = "Thermals implant"
	desc = "These cybernetic eyes will give you Thermal vision. Vertical slit pupil included."
	id = "ci-thermals"
	req_tech = list("materials" = 6, "programming" = 4, "biotech" = 6, "magnets" = 5,"prewar" = 4)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 60
	materials = list(MAT_METAL = 600, MAT_GLASS = 600, MAT_SILVER = 600, MAT_GOLD = 600, MAT_COOPER = 1000, MAT_DIAMOND = 2000)
	build_path = /obj/item/organ/eyes/robotic/thermals
	category = list("Misc", "Medical Designs")

/datum/design/cyberimp_antidrop
	name = "Anti-Drop implant"
	desc = "This cybernetic brain implant will allow you to force your hand muscles to contract, preventing item dropping. Twitch ear to toggle."
	id = "ci-antidrop"
	req_tech = list("materials" = 5, "programming" = 5, "biotech" = 5)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 60
	materials = list(MAT_METAL = 600, MAT_GLASS = 600, MAT_SILVER = 400, MAT_GOLD = 400)
	build_path = /obj/item/organ/cyberimp/brain/anti_drop
	category = list("Misc", "Medical Designs")

/datum/design/cyberimp_antistun
	name = "CNS Rebooter implant"
	desc = "This implant will automatically give you back control over your central nervous system, reducing downtime when stunned."
	id = "ci-antistun"
	req_tech = list("materials" = 6, "programming" = 5, "biotech" = 6)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 60
	materials = list(MAT_METAL = 600, MAT_GLASS = 600, MAT_SILVER = 500, MAT_GOLD = 1000)
	build_path = /obj/item/organ/cyberimp/brain/anti_stun
	category = list("Misc", "Medical Designs")

/datum/design/cyberimp_nutriment
	name = "Nutriment pump implant"
	desc = "This implant with synthesize and pump into your bloodstream a small amount of nutriment when you are starving."
	id = "ci-nutriment"
	req_tech = list("materials" = 3, "powerstorage" = 4, "biotech" = 3)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 40
	materials = list(MAT_METAL = 500, MAT_GLASS = 500, MAT_GOLD = 500)
	build_path = /obj/item/organ/cyberimp/chest/nutriment
	category = list("Misc", "Medical Designs")

/datum/design/cyberimp_nutriment_plus
	name = "Nutriment pump implant PLUS"
	desc = "This implant with synthesize and pump into your bloodstream a small amount of nutriment when you are hungry."
	id = "ci-nutrimentplus"
	req_tech = list("materials" = 5, "powerstorage" = 4, "biotech" = 4)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 50
	materials = list(MAT_METAL = 600, MAT_GLASS = 600, MAT_GOLD = 500, MAT_URANIUM = 750)
	build_path = /obj/item/organ/cyberimp/chest/nutriment/plus
	category = list("Misc", "Medical Designs")

/datum/design/cyberimp_reviver
	name = "Reviver implant"
	desc = "This implant will attempt to revive you if you lose consciousness. For the faint of heart!"
	id = "ci-reviver"
	req_tech = list("materials" = 5, "programming" = 4, "biotech" = 5)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 60
	materials = list(MAT_METAL = 800, MAT_GLASS = 800, MAT_GOLD = 300, MAT_URANIUM = 500)
	build_path = /obj/item/organ/cyberimp/chest/reviver
	category = list("Misc", "Medical Designs")

/*datum/design/combat
	name = "combat cybernetics implant"
	desc = "A powerful cybernetic implant that contains combat modules built into the user's arm"
	id = "combat"
	req_tech = list("materials" = 6, "programming" = 4, "biotech" = 6, "combat" = 5, "prewar" = 3)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 60
	materials = list(MAT_METAL = 2000, MAT_GLASS = 800, MAT_GOLD = 300, MAT_URANIUM = 500, MAT_COOPER = 1000)
	build_path = /obj/item/organ/cyberimp/arm/combat
	category = list("Misc", "Medical Designs") */

/datum/design/medibeam
	name = "integrated medical beamgun"
	desc = "A cybernetic implant that allows the user to project a healing beam from their hand."
	id = "medibeam"
	req_tech = list("materials" = 5, "programming" = 5, "biotech" = 6, "combat" = 2, "prewar" = 3)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 60
	materials = list(MAT_METAL = 1000, MAT_GLASS = 1800, MAT_GOLD = 500, MAT_URANIUM = 200, MAT_COOPER = 1000)
	build_path = /obj/item/organ/cyberimp/arm/medibeam
	category = list("Misc", "Medical Designs")

/datum/design/mounted
	name = "arm-mounted laser implant"
	desc = "A variant of the arm cannon implant that fires lethal laser beams. The cannon emerges from the subject's arm and remains inside when not in use."
	id = "mounted"
	req_tech = list("materials" = 5, "programming" = 5, "biotech" = 6, "combat" = 6, "prewar" = 5)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 60
	materials = list(MAT_METAL = 2000, MAT_GLASS = 1800, MAT_GOLD = 500, MAT_URANIUM = 1000, MAT_COOPER = 2000)
	build_path = /obj/item/weapon/gun/energy/laser/mounted
	category = list("Misc", "Medical Designs")
/*
/datum/design/cyberimp_thrusters
	name = "Thrusters set implant"
	desc = "This implant will allow you to use gas from environment or your internals for propulsion in zero-gravity areas."
	id = "ci-thrusters"
	req_tech = list("materials" = 5, "biotech" = 5, "magnets" = 4, "engineering" = 7)
	build_type = PROTOLATHE | MECHFAB
	construction_time = 80
	materials = list(MAT_METAL = 4000, MAT_GLASS = 2000, MAT_SILVER = 1000, MAT_DIAMOND = 1000)
	build_path = /obj/item/organ/cyberimp/chest/thrusters
	category = list("Misc", "Medical Designs")
*/

/////////////////////////////////////////
////////////Regular Implants/////////////
/////////////////////////////////////////

/datum/design/implanter
	name = "Implanter"
	desc = "A sterile automatic implant injector."
	id = "implanter"
	req_tech = list("materials" = 2, "biotech" = 3, "programming" = 2)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 600, MAT_GLASS = 200)
	build_path = /obj/item/weapon/implanter
	category = list("Medical Designs")

/datum/design/implantcase
	name = "Implant Case"
	desc = "A glass case for containing an implant."
	id = "implantcase"
	req_tech = list("biotech" = 2)
	build_type = PROTOLATHE
	materials = list(MAT_GLASS = 500)
	build_path = /obj/item/weapon/implantcase
	category = list("Medical Designs")
/*
/datum/design/implant_sadtrombone
	name = "Sad Trombone Implant Case"
	desc = "Makes death amusing."
	id = "implant_trombone"
	req_tech = list("materials" = 2, "biotech" = 3, "programming" = 2)
	build_type = PROTOLATHE
	materials = list(MAT_GLASS = 500, MAT_BANANIUM = 500)
	build_path = /obj/item/weapon/implantcase/sad_trombone
	category = list("Medical Designs")
*/
/datum/design/implant_freedom
	name = "Freedom Implant Case"
	desc = "A glass case containing an implant."
	id = "implant_freedom"
	req_tech = list("combat" = 6, "biotech" = 5, "magnets" = 3, "prewar" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 800, MAT_GLASS = 500, MAT_GOLD = 500)
	build_path = /obj/item/weapon/implantcase/freedom
	category = list("Medical Designs")

/datum/design/implant_adrenalin
	name = "Adrenalin Implant Case"
	desc = "A glass case containing an implant."
	id = "implant_adrenalin"
	req_tech = list("biotech" = 6, "combat" = 6, "prewar" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 1000, MAT_GLASS = 500, MAT_GOLD = 500, MAT_URANIUM = 600, MAT_DIAMOND = 600)
	build_path = /obj/item/weapon/implantcase/adrenaline
	category = list("Medical Designs")
