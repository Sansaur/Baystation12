
/obj/machinery/factorylathe
	name = "factorylathe"
	desc = "It endlessly produces items using metal and glass."
	icon_state = "factorylathe"
	density = 1
	anchored = 1
	use_power = 1
	idle_power_usage = 10
	active_power_usage = 2000
	clicksound = "keyboard"
	clickvol = 30

	var/datum/autolathe/recipe/recipe_making	// The recipe we're gonna be making
	var/list/machine_recipes
	var/list/stored_material =  list(DEFAULT_WALL_MATERIAL = 0, "glass" = 0)
	var/list/storage_capacity = list(DEFAULT_WALL_MATERIAL = 0, "glass" = 0)
	var/show_category = "All"

	var/hacked = 0
	var/disabled = 0
	var/shocked = 0
	var/busy = 0

	var/mat_efficiency = 1
	var/max_items_on_queue = 3
	var/build_time = 100		// Double build time as base, can increase with overclocking and with better manipulators
	var/build_time_divisor = 1	// Used by overclocking

	var/overload = 0
	var/overload_multiplier = 1 // The more overclocking, more overload multiplier, better micro_laser, less overload multiplier
	var/overload_divisor = 0 // The more overclocking, more overload multiplier, better micro_laser, less overload multiplier

	var/datum/wires/factorylathe/wires = null


/obj/machinery/factorylathe/New()

	..()
	wires = new(src)
	//Create parts for lathe.
	component_parts = list()
	component_parts += new /obj/item/weapon/circuitboard/factorylathe(src)
	component_parts += new /obj/item/weapon/stock_parts/matter_bin(src)
	component_parts += new /obj/item/weapon/stock_parts/matter_bin(src)
	component_parts += new /obj/item/weapon/stock_parts/matter_bin(src)
	component_parts += new /obj/item/weapon/stock_parts/micro_laser(src)
	component_parts += new /obj/item/weapon/stock_parts/manipulator(src)
	component_parts += new /obj/item/weapon/stock_parts/console_screen(src)
	RefreshParts()

/obj/machinery/factorylathe/Destroy()
	qdel(wires)
	wires = null
	return ..()

/obj/machinery/factorylathe/process()
	if(stat & (BROKEN|NOPOWER))
		return

	if(emagged)
		recipe_making = pick(autolathe_recipes)
		if(!istype(recipe_making, /datum/autolathe/recipe))
			recipe_making = null	// Fucks up the production even more by putting this into stop >:3


	if(recipe_making)
		if(overload > 50 && prob(25))
			visible_message("<span class='warning'> [src] is starting to make weird noises as it works </span>")
		if(overload > 100)
			explode()

		if(round(mat_efficiency) < 1)
			ProduceRecipe(recipe_making, 1)
		else
			ProduceRecipe(recipe_making, round(mat_efficiency))
	else
		if(overload > 0)
			overload--

/obj/machinery/factorylathe/proc/explode()
	explosion(loc, 1, 1, 2, 3)
	// Saca sharpnel
	for(var/direction in GLOB.cardinal)
		var/turf/T = get_step(src, direction)
		if(!(T.density) && prob(50))
			new /obj/item/weapon/material/shard/shrapnel (T)
	qdel(src)

/obj/machinery/factorylathe/proc/update_recipe_list()
	if(!machine_recipes)
		machine_recipes = autolathe_recipes

/obj/machinery/factorylathe/interact(mob/user as mob)

	update_recipe_list()

	if(..() || (disabled && !panel_open))
		to_chat(user, "<span class='danger'>\The [src] is disabled!</span>")
		return

	if(shocked)
		shock(user, 50)

	var/dat = "<center><h1>Factorylathe Control Panel</h1><hr/>"

	if(!disabled)
		dat += "<table width = '100%'>"
		var/material_top = "<tr>"
		var/material_bottom = "<tr>"

		for(var/material in stored_material)
			material_top += "<td width = '25%' align = center><b>[material]</b></td>"
			material_bottom += "<td width = '25%' align = center>[stored_material[material]]<b>/[storage_capacity[material]]</b></td>"

		dat += "[material_top]</tr>[material_bottom]</tr></table><hr>"
		// Now producing this item
		dat += "<h3> Producing: <a href='?src=\ref[src];RFQ=1'>[recipe_making ? recipe_making : "none" ]</a></h3>"
		dat += "<hr>"
		// Overclocking
		dat += "<h3> Overclocking: <a href='?src=\ref[src];SetOverclock=1'>"
		switch(overload_multiplier)
			if(1)
				dat += "Normal speed"
			if(2)
				dat += "Fast speed"
			if(3)
				dat += "Extra speed"
		dat += "</a></h3>"
		dat += "<hr>"
		// End of additions
		dat += "<h2>Printable Designs</h2><h3>Showing: <a href='?src=\ref[src];change_category=1'>[show_category]</a>.</h3></center><table width = '100%'>"

		var/index = 0
		for(var/datum/autolathe/recipe/R in machine_recipes)
			index++
			if(R.hidden && !hacked || (show_category != "All" && show_category != R.category))
				continue
			var/can_make = 1
			var/material_string = ""
			var/multiplier_string = ""
			var/max_sheets
			var/comma
			if(!R.resources || !R.resources.len)
				material_string = "No resources required.</td>"
			else
				//Make sure it's buildable and list requires resources.
				for(var/material in R.resources)
					var/sheets = round(stored_material[material]/round(R.resources[material]*mat_efficiency))
					if(isnull(max_sheets) || max_sheets > sheets)
						max_sheets = sheets
					if(!isnull(stored_material[material]) && stored_material[material] < round(R.resources[material]*mat_efficiency))
						can_make = 0
					if(!comma)
						comma = 1
					else
						material_string += ", "
					material_string += "[round(R.resources[material] * mat_efficiency)] [material]"
				material_string += ".<br></td>"
				//Build list of multipliers for sheets.
				if(R.is_stack)
					if(max_sheets && max_sheets > 0)
						multiplier_string  += "<br>"
						for(var/i = 5;i<max_sheets;i*=2) //5,10,20,40...
							multiplier_string  += "<a href='?src=\ref[src];make=[index];multiplier=[i]'>\[x[i]\]</a>"
						multiplier_string += "<a href='?src=\ref[src];make=[index];multiplier=[max_sheets]'>\[x[max_sheets]\]</a>"

			dat += "<tr><td width = 180>[R.hidden ? "<font color = 'red'>*</font>" : ""]<b>[can_make ? "<a href='?src=\ref[src];make=[index];multiplier=1'>" : ""][R.name][can_make ? "</a>" : ""]</b>[R.hidden ? "<font color = 'red'>*</font>" : ""][multiplier_string]</td><td align = right>[material_string]</tr>"

		dat += "</table><hr>"
	//Hacking.
	if(panel_open)
		dat += "<h2>Maintenance Panel (The overload meter reads: [overload]%)</h2>"
		dat += wires.GetInteractWindow()

		dat += "<hr>"

	var/datum/browser/BROWSER = new(user, "factorylathe", 0, 540, 560)
	BROWSER.add_content(dat)
	BROWSER.open()

//	user << browse(dat, "window=autolathe")
	onclose(user, "factorylathe")

/obj/machinery/factorylathe/attackby(var/obj/item/O as obj, var/mob/user as mob)

	if(busy)
		to_chat(user, "<span class='notice'>\The [src] is busy. Please wait for completion of previous operation.</span>")
		return

	if(default_deconstruction_screwdriver(user, O))
		updateUsrDialog()
		return
	if(default_deconstruction_crowbar(user, O))
		return
	if(default_part_replacement(user, O))
		return

	if(stat)
		return

	if(panel_open)
		//Don't eat multitools or wirecutters used on an open lathe.
		if(istype(O, /obj/item/device/multitool) || istype(O, /obj/item/weapon/wirecutters))
			attack_hand(user)
			return

	if(O.loc != user && !(istype(O,/obj/item/stack)))
		return 0

	if(is_robot_module(O))
		return 0

	//Resources are being loaded.
	var/obj/item/eating = O
	if(!eating.matter)
		to_chat(user, "\The [eating] does not contain significant amounts of useful materials and cannot be accepted.")
		return

	var/filltype = 0       // Used to determine message.
	var/total_used = 0     // Amount of material used.
	var/mass_per_sheet = 0 // Amount of material constituting one sheet.

	for(var/material in eating.matter)

		if(isnull(stored_material[material]) || isnull(storage_capacity[material]))
			continue

		if(stored_material[material] >= storage_capacity[material])
			continue

		var/total_material = eating.matter[material]

		//If it's a stack, we eat multiple sheets.
		if(istype(eating,/obj/item/stack))
			var/obj/item/stack/stack = eating
			total_material *= stack.get_amount()

		if(stored_material[material] + total_material > storage_capacity[material])
			total_material = storage_capacity[material] - stored_material[material]
			filltype = 1
		else
			filltype = 2

		stored_material[material] += total_material
		total_used += total_material
		mass_per_sheet += eating.matter[material]

	if(!filltype)
		to_chat(user, "<span class='notice'>\The [src] is full. Please remove material from the factorylathe in order to insert more.</span>")
		return
	else if(filltype == 1)
		to_chat(user, "You fill \the [src] to capacity with \the [eating].")
	else
		to_chat(user, "You fill \the [src] with \the [eating].")

	flick("factorylathe_o", src) // Plays metal insertion animation. Work out a good way to work out a fitting animation. ~Z

	if(istype(eating,/obj/item/stack))
		var/obj/item/stack/stack = eating
		stack.use(max(1, round(total_used/mass_per_sheet))) // Always use at least 1 to prevent infinite materials.
	else
		user.remove_from_mob(O)
		qdel(O)

	updateUsrDialog()
	return

/obj/machinery/factorylathe/attack_hand(mob/user as mob)
	user.set_machine(src)
	interact(user)

/obj/machinery/factorylathe/Topic(href, href_list)

	if(..())
		return

	usr.set_machine(src)
	add_fingerprint(usr)

	// Exceptions for adding to queue and removing from queue
	if(busy && !href_list["make"] && !href_list["RFQ"])
		to_chat(usr, "<span class='notice'>The factorylathe is busy. Please wait for completion of previous operation.</span>")
		return

	if(href_list["change_category"])

		var/choice = input("Which category do you wish to display?") as null|anything in autolathe_categories+"All"
		if(!choice) return
		show_category = choice

	if(href_list["RFQ"])
		recipe_making = null

	if(href_list["SetOverclock"])
		var/list/choices = list("normal" = 1, "fast" = 2, "very fast" = 3)
		var/choice = input("At which speed should the machin work?") as null|anything in choices
		build_time_divisor = choices[choice]
		overload_multiplier = choices[choice]

	if(href_list["make"] && machine_recipes)

		var/index = text2num(href_list["make"])
		var/multiplier = text2num(href_list["multiplier"])
		var/datum/autolathe/recipe/making

		if(index > 0 && index <= machine_recipes.len)
			making = machine_recipes[index]

		//Exploit detection, not sure if necessary after rewrite.
		if(!making || multiplier < 0 || multiplier > 100)
			var/turf/exploit_loc = get_turf(usr)
			message_admins("[key_name_admin(usr)] tried to exploit an factorylathe to duplicate an item! ([exploit_loc ? "<a href='?_src_=holder;adminplayerobservecoodjump=1;X=[exploit_loc.x];Y=[exploit_loc.y];Z=[exploit_loc.z]'>JMP</a>" : "null"])", 0)
			log_admin("EXPLOIT : [key_name(usr)] tried to exploit an factorylathe to duplicate an item!")
			return

		recipe_making = making


	updateUsrDialog()

/obj/machinery/factorylathe/update_icon()
	icon_state = (panel_open ? "factorylathe_t" : "factorylathe")

//Updates overall lathe storage size.
/obj/machinery/factorylathe/RefreshParts()
	..()
	var/mb_rating = 0
	var/man_rating = 0
	var/over_rating = 0
	for(var/obj/item/weapon/stock_parts/matter_bin/MB in component_parts)
		mb_rating += MB.rating
	for(var/obj/item/weapon/stock_parts/manipulator/M in component_parts)
		man_rating += M.rating
	for(var/obj/item/weapon/stock_parts/micro_laser/ML in component_parts)
		over_rating += ML.rating

	storage_capacity[DEFAULT_WALL_MATERIAL] = mb_rating  * 25000
	storage_capacity["glass"] = mb_rating  * 12500
	build_time = 100 / man_rating
	mat_efficiency = 1.1 - man_rating * 0.1// Normally, price is 1.25 the amount of material, so this shouldn't go higher than 0.8. Maximum rating of parts is 3
	overload_divisor = over_rating		// The better the manipulator, the more queue (+3 per manipulator level)

/obj/machinery/factorylathe/dismantle()

	for(var/mat in stored_material)
		var/material/M = get_material_by_name(mat)
		if(!istype(M))
			continue
		var/obj/item/stack/material/S = new M.stack_type(get_turf(src))
		if(stored_material[mat] > S.perunit)
			S.amount = round(stored_material[mat] / S.perunit)
		else
			qdel(S)
	..()
	return 1

/obj/machinery/factorylathe/proc/ProduceRecipe(var/datum/autolathe/recipe/making, var/multiplier)

	busy = 1
	update_use_power(2)

	//Check if we still have the materials.
	for(var/material in making.resources)
		if(!isnull(stored_material[material]))
			if(stored_material[material] < round(making.resources[material] * mat_efficiency) * multiplier)
				return

		//Consume materials.
	for(var/material in making.resources)
		if(!isnull(stored_material[material]))
			stored_material[material] = max(0, stored_material[material] - round(making.resources[material] * mat_efficiency) * multiplier)

		//Fancy autolathe animation.
	flick("factorylathe_n", src)

	sleep(build_time / build_time_divisor)


	busy = 0
	update_use_power(1)
	overload += 1 * overload_multiplier / overload_divisor	// A super good micro laser lets the machine produce 100 items very fast, a bad micro laser lets the machine produce 33 items very fast

	//Sanity check.
	if(!making || !src) return

	//Create the desired item.
	var/obj/item/I = new making.path(loc)
	if(multiplier > 1 && istype(I, /obj/item/stack))
		var/obj/item/stack/S = I
		S.amount = multiplier

/obj/machinery/factorylathe/emag_act(var/remaining_charges, var/mob/user)
	if (src.emagged <= 0)
		src.emagged = 1
		to_chat(user, "You deactivate the production controllers on [src].")
		var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
		s.set_up(2, 1, src)
		s.start()
		visible_message("<span class='warning'>dunkdunkdunkdunkdunkdunk</span>")
		return 1

/*	*********************

* 	CIRCUIT BOARD AND DESIGN*

	**********************		*/

/obj/item/weapon/circuitboard/factorylathe
	name = T_BOARD("factorylathe")
	build_path = /obj/machinery/factorylathe
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 4, TECH_DATA = 2)
	req_components = list(
							/obj/item/weapon/stock_parts/matter_bin = 3,
							/obj/item/weapon/stock_parts/manipulator = 1,
							/obj/item/weapon/stock_parts/micro_laser = 1,
							/obj/item/weapon/stock_parts/console_screen = 1
							)

/datum/design/circuit/factorylathe
	name = "factorylathe board"
	id = "factorylathe"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 4)
	materials = list("glass" = 2000, "silver" = 2000)
	build_path = /obj/item/weapon/circuitboard/factorylathe
	sort_string = "HABAE"