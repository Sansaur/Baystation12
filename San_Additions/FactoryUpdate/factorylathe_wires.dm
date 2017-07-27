/datum/wires/factorylathe
	holder_type = /obj/machinery/factorylathe
	wire_count = 6


/datum/wires/factorylathe/GetInteractWindow()
	var/obj/machinery/factorylathe/A = holder
	. += ..()
	. += "<BR>The red light is [A.disabled ? "off" : "on"]."
	. += "<BR>The green light is [A.shocked ? "off" : "on"]."
	. += "<BR>The blue light is [A.hacked ? "off" : "on"].<BR>"

/datum/wires/factorylathe/CanUse()
	var/obj/machinery/factorylathe/A = holder
	if(A.panel_open)
		return 1
	return 0

/datum/wires/factorylathe/Interact(var/mob/living/user)
	if(CanUse(user))
		var/obj/machinery/factorylathe/V = holder
		V.attack_hand(user)

/datum/wires/factorylathe/UpdateCut(index, mended)
	var/obj/machinery/factorylathe/A = holder
	switch(index)
		if(AUTOLATHE_HACK_WIRE)
			A.hacked = !mended
		if(AUTOLATHE_SHOCK_WIRE)
			A.shocked = !mended
		if(AUTOLATHE_DISABLE_WIRE)
			A.disabled = !mended

/datum/wires/factorylathe/UpdatePulsed(index)
	if(IsIndexCut(index))
		return
	var/obj/machinery/factorylathe/A = holder
	switch(index)
		if(AUTOLATHE_HACK_WIRE)
			A.hacked = !A.hacked
			spawn(50)
				if(A && !IsIndexCut(index))
					A.hacked = 0
					Interact(usr)
		if(AUTOLATHE_SHOCK_WIRE)
			A.shocked = !A.shocked
			spawn(50)
				if(A && !IsIndexCut(index))
					A.shocked = 0
					Interact(usr)
		if(AUTOLATHE_DISABLE_WIRE)
			A.disabled = !A.disabled
			spawn(50)
				if(A && !IsIndexCut(index))
					A.disabled = 0
					Interact(usr)
