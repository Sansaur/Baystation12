	/*

	This is the "underwear" solution, but the sprite_accesories are probably TONS better
/datum/category_group/underwear/marking1
	name = "Marking 1"
	sort_order = 3 // Undershirts currently have the highest sort order because they may cover both underwear and socks.
	category_item_type = /datum/category_item/underwear/marking

/datum/category_group/underwear/marking2
	name = "Marking 2"
	sort_order = 3 // Undershirts currently have the highest sort order because they may cover both underwear and socks.
	category_item_type = /datum/category_item/underwear/marking

/datum/category_group/underwear/marking3
	name = "Marking 3"
	sort_order = 3
	category_item_type = /datum/category_item/underwear/marking

/datum/category_group/underwear/marking4
	name = "Marking 4"
	sort_order = 3 // Undershirts currently have the highest sort order because they may cover both underwear and socks.
	category_item_type = /datum/category_item/underwear/marking

/datum/category_group/underwear/marking5
	name = "Marking 5"
	sort_order = 3 // Undershirts currently have the highest sort order because they may cover both underwear and socks.
	category_item_type = /datum/category_item/underwear/marking

/datum/category_item/underwear/marking
	icon = 'San_Additions/BodyMarkings/bodymarkings.dmi' // Which icon to get the underwear from.

/datum/category_item/underwear/marking/none
	is_default = TRUE
	name = "None"
	always_last = TRUE

	*/

/*
////////////////////////////
/  =--------------------=  /
/  ==  Body Markings   ==  /
/  =--------------------=  /
////////////////////////////
*/
/datum/sprite_accessory/marking
	icon = 'bodymarkings.dmi'
	do_colouration = 1 //Almost all of them have it, COLOR_ADD

	// If only this ckey can get this body marking to show on their list of bodymarkings
	// Don't init here
	var/list/ckey_allowed

	//Empty list is unrestricted. Should only restrict the ones that make NO SENSE on other species,
	//like Tajara inner-ear coloring overlay stuff.
	species_allowed = list()

	var/body_parts = list() //A list of bodyparts this covers, in organ_tag defines
	//Reminder: BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_CHEST,BP_GROIN,BP_HEAD

	tat_heart
		name = "Tattoo (Heart, Torso)"
		icon_state = "tat_heart"
		body_parts = list(BP_CHEST)

	tat_hive
		name = "Tattoo (Hive, Back)"
		icon_state = "tat_hive"
		body_parts = list(BP_CHEST)

	tat_nightling
		name = "Tattoo (Nightling, Back)"
		icon_state = "tat_nightling"
		body_parts = list(BP_CHEST)

	tat_campbell
		name = "Tattoo (Campbell, R.Arm)"
		icon_state = "tat_campbell"
		body_parts = list(BP_R_ARM)

	tat_tiger
		name = "Tattoo (Tiger Stripes, Body)"
		icon_state = "tat_campbell"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_CHEST,BP_GROIN)

	taj_paw_socks
		name = "Socks Coloration (Taj)"
		icon_state = "taj_pawsocks"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND)
		species_allowed = list("Tajara")

	una_paw_socks
		name = "Socks Coloration (Una)"
		icon_state = "una_pawsocks"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND)
		species_allowed = list("Unathi")

	paw_socks
		name = "Socks Coloration (Generic)"
		icon_state = "pawsocks"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND)

	paw_socks_belly
		name = "Socks+Belly Coloration (Generic)"
		icon_state = "pawsocksbelly"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_GROIN,BP_CHEST)

	belly_hands_feet
		name = "Hands/Feet/Belly Color (Minor)"
		icon_state = "bellyhandsfeetsmall"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_GROIN,BP_CHEST)

	hands_feet_belly_full
		name = "Hands/Feet/Belly Color (Major)"
		icon_state = "bellyhandsfeet"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_GROIN,BP_CHEST)

	patches
		name = "Color Patches"
		icon_state = "patches"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_CHEST,BP_GROIN)

	patchesface
		name = "Color Patches (Face)"
		icon_state = "patchesface"
		body_parts = list(BP_HEAD)

	bands
		name = "Color Bands"
		icon_state = "bands"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_CHEST,BP_GROIN)

	bandsface
		name = "Color Bands (Face)"
		icon_state = "bandsface"
		body_parts = list(BP_HEAD)

	tiger_stripes
		name = "Tiger Stripes"
		icon_state = "tiger"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_CHEST,BP_GROIN)
		species_allowed = list("Tajara") //There's a tattoo for non-cats

	tigerhead
		name = "Tiger Stripes (Head, Minor)"
		icon_state = "tigerhead"
		body_parts = list(BP_HEAD)

	tigerface
		name = "Tiger Stripes (Head, Major)"
		icon_state = "tigerface"
		body_parts = list(BP_HEAD)
		species_allowed = list("Tajara") //There's a tattoo for non-cats

	backstripe
		name = "Back Stripe"
		icon_state = "backstripe"
		body_parts = list(BP_CHEST)

	//Taj specific stuff
	taj_belly
		name = "Belly Fur (Taj)"
		icon_state = "taj_belly"
		body_parts = list(BP_CHEST)
		species_allowed = list("Tajara")

	taj_bellyfull
		name = "Belly Fur Wide (Taj)"
		icon_state = "taj_bellyfull"
		body_parts = list(BP_CHEST)
		species_allowed = list("Tajara")

	taj_earsout
		name = "Outer Ear (Taj)"
		icon_state = "taj_earsout"
		body_parts = list(BP_HEAD)
		species_allowed = list("Tajara")

	taj_earsin
		name = "Inner Ear (Taj)"
		icon_state = "taj_earsin"
		body_parts = list(BP_HEAD)
		species_allowed = list("Tajara")

	taj_nose
		name = "Nose Color (Taj)"
		icon_state = "taj_nose"
		body_parts = list(BP_HEAD)
		species_allowed = list("Tajara")

	taj_crest
		name = "Chest Fur Crest (Taj)"
		icon_state = "taj_crest"
		body_parts = list(BP_CHEST)
		species_allowed = list("Tajara")

	taj_muzzle
		name = "Muzzle Color (Taj)"
		icon_state = "taj_muzzle"
		body_parts = list(BP_HEAD)
		species_allowed = list("Tajara")

	taj_face
		name = "Cheeks Color (Taj)"
		icon_state = "taj_face"
		body_parts = list(BP_HEAD)
		species_allowed = list("Tajara")

	taj_all
		name = "All Taj Head (Taj)"
		icon_state = "taj_all"
		body_parts = list(BP_HEAD)
		species_allowed = list("Tajara")

	//Una specific stuff
	una_face
		name = "Face Color (Una)"
		icon_state = "una_face"
		body_parts = list(BP_HEAD)
		species_allowed = list("Unathi")

	una_facelow
		name = "Face Color Low (Una)"
		icon_state = "una_facelow"
		body_parts = list(BP_HEAD)
		species_allowed = list("Unathi")

	una_scutes
		name = "Scutes (Una)"
		icon_state = "una_scutes"
		body_parts = list(BP_CHEST)
		species_allowed = list("Unathi")

	vulp_fullbelly
		name = "full belly fur (Vulp)"
		icon_state = "vulp_fullbelly"
		body_parts = list(BP_CHEST)

	vulp_crest
		name = "belly crest (Vulp)"
		icon_state = "vulp_crest"
		body_parts = list(BP_CHEST)

	dragonhorns
		name = "Dragonhorns"
		icon_state = "dragonhorns"
		body_parts = list(BP_HEAD)
		ckey_allowed = list("sansaur", "jglitch")

	glitchhorns
		name = "Glitch Horns"
		icon_state = "glitchhorns"
		body_parts = list(BP_HEAD)
		ckey_allowed = list("sansaur", "jglitch")

	doubleeye
		name = "Double eyes"
		icon_state = "doubleeye"
		body_parts = list(BP_HEAD)
		ckey_allowed = list("sansaur", "jglitch")

	vulp_belly
		name = "belly fur (Vulp)"
		icon_state = "vulp_belly"
		body_parts = list(BP_CHEST)

	vulp_nose
		name = "nose (Vulp)"
		icon_state = "vulp_nose"
		body_parts = list(BP_HEAD)

	vulp_face
		name = "face (Vulp)"
		icon_state = "vulp_face"
		body_parts = list(BP_HEAD)

	vulp_earsface
		name = "ears and face (Vulp)"
		icon_state = "vulp_earsface"
		body_parts = list(BP_HEAD)

	vulp_all
		name = "all head highlights (Vulp)"
		icon_state = "vulp_all"
		body_parts = list(BP_HEAD)

	nevrean_female
		name = "Female Nevrean beak"
		icon_state = "nevrean_f"
		body_parts = list(BP_HEAD)
		gender = FEMALE

	nevrean_male
		name = "Male Nevrean beak"
		icon_state = "nevrean_m"
		body_parts = list(BP_HEAD)
		gender = MALE

	spots
		name = "Spots"
		icon_state = "spots"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_GROIN,BP_CHEST)

	shaggy_mane
		name = "Shaggy mane/feathers"
		icon_state = "shaggy"
		body_parts = list(BP_CHEST)

	jagged_teeth
		name = "Jagged teeth"
		icon_state = "jagged"
		body_parts = list(BP_HEAD)

	saber_teeth
		name = "Saber teeth"
		icon_state = "saber"
		body_parts = list(BP_HEAD)

	fangs
		name = "Fangs"
		icon_state = "fangs"
		body_parts = list(BP_HEAD)

	tusks
		name = "Tusks"
		icon_state = "tusks"
		body_parts = list(BP_HEAD)

