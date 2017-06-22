/*
I cannot put this in the debug verbs list!

/datum/admins/proc/DreyfusObjectiveDebug()
	if(DreyfusQuotas)
		var/datum/browser/BROWSER = new(usr, "DreyfusDebug", 0, 440, 560)
		BROWSER.add_content("Quota required - current objective: [DreyfusQuotas.required_quota]")
		BROWSER.add_content("<br>")
		BROWSER.add_content("Quota advanced - current objective: [DreyfusQuotas.current_quota]")
		BROWSER.add_content("<br>")
		BROWSER.add_content("Times reached the quota: [DreyfusQuotas.times_quota_reached]")
		BROWSER.add_content("<br>")
		BROWSER.add_content("Times needed to reach the quota: [DreyfusQuotas.times_quota_needed] <a href='?src=\ref[src];addQuota=1'>+</a><a href='?src=\ref[src];removeQuota=1'>-</a>")
		BROWSER.add_content("<br>")
		BROWSER.add_content("<a href='?src=\ref[src];DreyfusObjectiveVariables=1'>Variables</a>")
		BROWSER.add_content("<br>")
		BROWSER.add_content("<a href='?src=\ref[src];NewObjective=1'>New objective (Complete current quota)</a>")
		BROWSER.add_content("<br>")
		BROWSER.add_content("<a href='?src=\ref[src];NewObjectiveNoQuota=1'>New objective (Resetting quota)</a>")
		BROWSER.add_content("<br>")
		BROWSER.add_content("<br>")

		BROWSER.add_content("High demand")
		BROWSER.add_content("<hr>")
		for(var/S in DreyfusQuotas.high_need)
			var/obj/OBJ = new S
			BROWSER.add_content("[OBJ]")
			BROWSER.add_content("<br>")
			qdel(OBJ)

		BROWSER.add_content("Low demand")
		BROWSER.add_content("<hr>")
		for(var/S in DreyfusQuotas.low_need)
			var/obj/OBJ = new S
			BROWSER.add_content("[OBJ]")
			BROWSER.add_content("<br>")
			qdel(OBJ)

		BROWSER.open()

/datum/admins/Topic(href, href_list)
	..()

	if(href_list["addQuota"])
		message_admins("Added one quota to the station objectives")
		DreyfusQuotas.times_quota_needed++

	else if(href_list["removeQuota"])
		message_admins("Added one quota to the station objectives")
		DreyfusQuotas.times_quota_needed--

	else if(href_list["NewObjective"])
		DreyfusQuotas.new_Objective_Admin_Quota()

	else if(href_list["NewObjectiveNoQuota"])
		DreyfusQuotas.new_Objective_Admin_NoQuota()

/client/proc/DreyfusObjectivesDebug() // -- The VERB
	set category = "Debug"
	set name = "Dreyfus Objectives Debug"
	set desc = "Objectives of the Station Dreyfus"

	if(holder)
		holder.DreyfusObjectiveDebug()
		holder.client.debug_variables(DreyfusQuotas)
	return

	*/


// This will need improvement
/obj/item/weapon/stupid_debug_thingie_dreyfus
	name = "ADMIN ONLY ITEM"
	icon = 'icons/obj/items.dmi'
	icon_state = "portable_analyzer"
	w_class = ITEM_SIZE_NORMAL
	var/amount = 25.0

/obj/item/weapon/stupid_debug_thingie_dreyfus/attack_self()
	var/mob/living/carbon/human/H = loc
	if(!check_rights(R_DEBUG))	return
//	if(!H.mind.check_rights(R_ADMIN))
//		return

//	H.client.debug_variables(DreyfusQuotas)
//	DebugDreyfusObjectives()
	if(DreyfusQuotas)
		var/datum/browser/BROWSER = new(H, "DreyfusDebug", 0, 440, 560)
		BROWSER.add_content("Quota required - current objective: [DreyfusQuotas.required_quota]")
		BROWSER.add_content("<br>")
		BROWSER.add_content("Quota advanced - current objective: [DreyfusQuotas.current_quota]")
		BROWSER.add_content("<br>")
		BROWSER.add_content("Times reached the quota: [DreyfusQuotas.times_quota_reached]")
		BROWSER.add_content("<br>")
		BROWSER.add_content("Times needed to reach the quota: [DreyfusQuotas.times_quota_needed] <a href='?src=\ref[src];addQuota=1'>+</a><a href='?src=\ref[src];removeQuota=1'>-</a>")
		BROWSER.add_content("<br>")
		BROWSER.add_content("<a href='?src=\ref[src];Variables=1'>Variables</a>")
		BROWSER.add_content("<br>")
		BROWSER.add_content("<a href='?src=\ref[src];NewObjective=1'>New objective (Complete current quota)</a>")
		BROWSER.add_content("<br>")
		BROWSER.add_content("<a href='?src=\ref[src];NewObjectiveNoQuota=1'>New objective (Resetting quota)</a>")
		BROWSER.add_content("<br>")
		BROWSER.add_content("<br>")

		BROWSER.add_content("High demand")
		BROWSER.add_content("<hr>")
		for(var/S in DreyfusQuotas.high_need)
			var/obj/OBJ = new S
			BROWSER.add_content("[OBJ]")
			BROWSER.add_content("<br>")
			qdel(OBJ)

		BROWSER.add_content("<br>")
		BROWSER.add_content("<br>")

		BROWSER.add_content("Low demand")
		BROWSER.add_content("<hr>")
		for(var/S in DreyfusQuotas.low_need)
			var/obj/OBJ = new S
			BROWSER.add_content("[OBJ]")
			BROWSER.add_content("<br>")
			qdel(OBJ)

		BROWSER.open()

/obj/item/weapon/stupid_debug_thingie_dreyfus/Topic(href, href_list)
	var/mob/living/carbon/human/H = loc

	if(href_list["addQuota"])
		message_admins("Added one quota to the station objectives")
		DreyfusQuotas.times_quota_needed++

	else if(href_list["removeQuota"])
		message_admins("Substracted one quota to the station objectives")
		DreyfusQuotas.times_quota_needed--

	else if(href_list["Variables"])
		if(H)
			H.client.debug_variables(DreyfusQuotas)

	else if(href_list["NewObjective"])
		if(H)
			DreyfusQuotas.new_Objective_Admin_Quota()

	else if(href_list["NewObjectiveNoQuota"])
		if(H)
			DreyfusQuotas.new_Objective_Admin_NoQuota()

	updateDialog()