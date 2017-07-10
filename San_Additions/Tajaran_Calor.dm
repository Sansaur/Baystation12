/*
	This can be added to any species
*/

/datum/species/proc/handle_clothing_heat(var/mob/living/carbon/human/H)
	// Clothes that can give heat are: Unders, Suits, Gloves, Gas Masks and Helmets (Not hats)
	// There will be some clothing that don't give heat at all, like shorts or the tux vest
	var/list/clothing_gives_no_heat = list(

										)
	// Also, some clothing that doesn't give too much heat but should... like the Hastur, for example
	// Recommended to not go above 1 or 2
	var/list/clothing_additional_heat = list(
										/obj/item/clothing/suit/hastur = 1
										)
	// The clothing that actually GIVES heat will give it based off it's armor stats and w_class
	// We will check one by one since unders and suits should give more heat than other heat sources
	var/adding_heat = 0

	// Uniforms
	var/obj/item/clothing/Checking = H.w_uniform
	if(Checking && !is_type_in_list(Checking, clothing_gives_no_heat) && (Checking.body_parts_covered & UPPER_TORSO))	// Can only get heat from unders if they cover the chest
		adding_heat += get_clothing_heat(Checking)
		if(is_type_in_list(Checking, clothing_additional_heat))
			adding_heat += clothing_additional_heat[Checking.type]

	// Suits
	Checking = H.wear_suit
	if(Checking && !is_type_in_list(Checking, clothing_gives_no_heat))
		adding_heat += get_clothing_heat(Checking)
		if(is_type_in_list(Checking, clothing_additional_heat))
			adding_heat += clothing_additional_heat[Checking.type]


	// Gloves
	Checking = H.gloves
	if(Checking && !is_type_in_list(Checking, clothing_gives_no_heat))
		adding_heat += get_clothing_heat(Checking)
		if(is_type_in_list(Checking, clothing_additional_heat))
			adding_heat += clothing_additional_heat[Checking.type]


	// Masks
	Checking = H.wear_mask
	if(Checking && !is_type_in_list(Checking, clothing_gives_no_heat))
		adding_heat += get_clothing_heat(Checking)
		if(is_type_in_list(Checking, clothing_additional_heat))
			adding_heat += clothing_additional_heat[Checking.type]


	// Helmets
	Checking = H.head
	if(Checking && !is_type_in_list(Checking, clothing_gives_no_heat))
		if(istype(Checking, /obj/item/clothing/head/helmet) || istype(Checking, /obj/item/clothing/head/bio_hood))
			adding_heat += get_clothing_heat(Checking)
		if(is_type_in_list(Checking, clothing_additional_heat))
			adding_heat += clothing_additional_heat[Checking.type]


	message_admins("Adding [(adding_heat / 4)]")
	message_admins("Bodytemp [H.bodytemperature]")
	H.bodytemperature += (adding_heat / 4)


/proc/get_clothing_heat(var/obj/item/clothing/C)
	var/heat = C.w_class / 2
	for(var/nombre in C.armor)
		heat += C.armor[nombre] / 100

	heat = round(heat)
	return heat