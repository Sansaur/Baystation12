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