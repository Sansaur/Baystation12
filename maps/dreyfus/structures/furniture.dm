//SHELVES

/obj/structure/table/shelf
	name = "shelf"
	desc = "Like racks, but taller."
	icon = 'maps/dreyfus/icons/shelf.dmi'
	icon_state = "rack2"
	can_plate = 0
	can_reinforce = 0
	flipped = -1

	material = DEFAULT_TABLE_MATERIAL

/obj/structure/table/shelf/New()
	..()
	verbs -= /obj/structure/table/verb/do_flip
	verbs -= /obj/structure/table/proc/do_put

/obj/structure/table/shelf/initialize()
	auto_align()
	..()

/obj/structure/table/shelf/update_connections()
	return

/obj/structure/table/shelf/update_desc()
	return

/obj/structure/table/shelf/update_icon()
	return

/obj/structure/table/shelf/can_connect()
	return FALSE

/obj/structure/table/shelf/holorack/dismantle(obj/item/weapon/wrench/W, mob/user)
	to_chat(user, "<span class='warning'>You cannot dismantle \the [src].</span>")
	return

/obj/structure/bed
	icon = 'maps/dreyfus/icons/furniture.dmi'

/obj/structure/bed/chair/shuttle
	name = "passenger seat"
	desc = "Comfortable and sturdy."
	anchored = 0
	color = null
	icon_state = "shuttle_chair"
	base_icon = "shuttle_chair"
	material_alteration = MATERIAL_ALTERATION_NONE

//CHAIR
/obj/structure/bed/chair/white
	color = null
	material_alteration = MATERIAL_ALTERATION_NONE

/obj/item/weapon/stool
	icon = 'maps/dreyfus/icons/furniture.dmi'

/obj/structure/table
	name = "table frame"
	icon = 'maps/dreyfus/icons/tables.dmi'

/obj/structure/bed/chair/office/light
	base_icon = "officechair_white"
	icon_state = "officechair_white"

/obj/structure/bed/chair/office/dark
	base_icon = "officechair_dark"
	icon_state = "officechair_dark"

/obj/structure/bed/chair/wood
	desc = "Old is never too old to not be in fashion."
	base_icon = "wooden_chair"
	icon_state = "wooden_chair"

/obj/structure/bed/update_icon()
	// Prep icon.
	icon_state = ""
	overlays.Cut()
	// Base icon.
	var/cache_key = "[base_icon]-[material.name]"
	if(isnull(stool_cache[cache_key]))
		var/image/I = image('maps/dreyfus/icons/furniture.dmi', base_icon)
		if(material_alteration & MATERIAL_ALTERATION_COLOR)
			I.color = material.icon_colour
		stool_cache[cache_key] = I
	overlays |= stool_cache[cache_key]
	// Padding overlay.
	if(padding_material)
		var/padding_cache_key = "[base_icon]-padding-[padding_material.name]"
		if(isnull(stool_cache[padding_cache_key]))
			var/image/I =  image(icon, "[base_icon]_padding")
			if(material_alteration & MATERIAL_ALTERATION_COLOR)
				I.color = padding_material.icon_colour
			stool_cache[padding_cache_key] = I
		overlays |= stool_cache[padding_cache_key]

	// Strings.
	if(material_alteration & MATERIAL_ALTERATION_NAME)
		name = padding_material ? "[padding_material.adjective_name] [initial(name)]" : "[material.adjective_name] [initial(name)]" //this is not perfect but it will do for now.

	if(material_alteration & MATERIAL_ALTERATION_DESC)
		desc = initial(desc)
		desc += padding_material ? " It's made of [material.use_name] and covered with [padding_material.use_name]." : " It's made of [material.use_name]."

/obj/structure/bed/chair/update_icon()

	var/cache_key = "[base_icon]-[material.name]-over"
	if(isnull(stool_cache[cache_key]))
		var/image/I = image('maps/dreyfus/icons/furniture.dmi', "[base_icon]_over")
		if(material_alteration & MATERIAL_ALTERATION_COLOR)
			I.color = material.icon_colour
		I.plane = ABOVE_HUMAN_PLANE
		I.layer = ABOVE_HUMAN_LAYER
		stool_cache[cache_key] = I
	overlays |= stool_cache[cache_key]
	// Padding overlay.
	if(padding_material)
		var/padding_cache_key = "[base_icon]-padding-[padding_material.name]-over"
		if(isnull(stool_cache[padding_cache_key]))
			var/image/I =  image(icon, "[base_icon]_padding_over")
			if(material_alteration & MATERIAL_ALTERATION_COLOR)
				I.color = padding_material.icon_colour
			I.plane = ABOVE_HUMAN_PLANE
			I.layer = ABOVE_HUMAN_LAYER
			stool_cache[padding_cache_key] = I
		overlays |= stool_cache[padding_cache_key]

	if(buckled_mob && padding_material)
		cache_key = "[base_icon]-armrest-[padding_material.name]"
		if(isnull(stool_cache[cache_key]))
			var/image/I = image(icon, "[base_icon]_armrest")
			I.plane = ABOVE_HUMAN_PLANE
			I.layer = ABOVE_HUMAN_LAYER
			if(material_alteration & MATERIAL_ALTERATION_COLOR)
				I.color = padding_material.icon_colour
			stool_cache[cache_key] = I
		overlays |= stool_cache[cache_key]