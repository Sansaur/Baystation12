// Gloves
/datum/gear/gloves
	cost = 2
	slot = slot_gloves
	sort_category = "Gloves and Handwear"
	category = /datum/gear/gloves

/datum/gear/gloves/colored

/datum/gear/gloves/latex
	cost = 3
	allowed_roles = list("Supervisor", "Medico")

/datum/gear/gloves/nitrile
	cost = 3
	allowed_roles = list("Supervisor", "Medico")

/datum/gear/gloves/rainbow

/datum/gear/gloves/botany
	display_name = "gloves, botany"
	path = /obj/item/clothing/gloves/thick/botany
	cost = 3

/datum/gear/gloves/evening
	allowed_roles = ADMINISTRATOR_ROLES

/datum/gear/gloves/duty
	display_name = "gloves, duty"
	path = /obj/item/clothing/gloves/duty
	cost = 3
	allowed_roles = list("Marshall")

/datum/gear/gloves/work
	display_name = "gloves, work"
	path = /obj/item/clothing/gloves/thick
	cost = 3
