// DEBUGGING
// This obviously needs more work
proc/DebugDreyfusObjectives()

	if(DreyfusQuotas)
		message_admins("[DreyfusQuotas.required_quota] ESO HACE FALTA")
		message_admins("[DreyfusQuotas.current_quota] ESO LLEVAMOS")
		message_admins("[DreyfusQuotas.times_quota_reached] VECES LLEGADAS A LA CUOTA")
		message_admins("[DreyfusQuotas.times_quota_needed] VECES QUE NECESITAMOS LLEGAR A LA CUOTA")
		for(var/S in DreyfusQuotas.sellable_items)
			message_admins("[S]")
		for(var/S in DreyfusQuotas.high_need)
			message_admins("[S]")
		for(var/S in DreyfusQuotas.low_need)
			message_admins("[S]")

	// OBLIGATORIO poner un return al final de las procs globales
	return 1

// This will need improvement
/obj/item/weapon/stupid_debug_thingie_dreyfus
	name = "package wrapper"
	icon = 'icons/obj/items.dmi'
	icon_state = "deliveryPaper"
	w_class = ITEM_SIZE_NORMAL
	var/amount = 25.0

/obj/item/weapon/stupid_debug_thingie_dreyfus/attack_self()
	var/mob/living/carbon/human/H = loc
	H.client.debug_variables(DreyfusQuotas)
	DebugDreyfusObjectives()