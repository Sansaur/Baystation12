/datum/job/trader
	title = "Comerciante"
	supervisors = "Cualquiera de la rama administrativa"
	selection_color = "#515151"
	minimal_player_age = 14
	economic_modifier = 7
	ideal_character_age = 21
	total_positions = 1
	spawn_positions = 1
	faction = "Station"
	department_flag = CIV
	announced = 1
	alt_titles = list(
			"Vendedor ambulante",
			"Mercante",
			"Minorista"
		)
	allowed_branches = list(
		/datum/mil_branch/administration,
		/datum/mil_branch/contractuel,
		/datum/mil_branch/ouvrier,
	)
	outfit_type = /decl/hierarchy/outfit/job/dreyfus/trader

/decl/hierarchy/outfit/job/dreyfus/trader
	name = OUTFIT_JOB_NAME("Comerciante")
	l_ear = /obj/item/device/radio/headset
	uniform = /obj/item/clothing/under/rank/internalaffairs/plain
	shoes = /obj/item/clothing/shoes/dress
	l_hand = /obj/item/weapon/storage/briefcase/deployable_briefcase	//Here goes the pad briefcase
	r_hand = /obj/item/device/trader_controller	//Here goes the pad briefcase
	id_type = /obj/item/weapon/card/id
	pda_type = /obj/item/device/pda