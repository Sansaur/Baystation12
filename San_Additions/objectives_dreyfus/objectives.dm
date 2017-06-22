// This will be global, and can be controlled with debugging.dm
var/global/datum/dreyfus_objectives/DreyfusQuotas = new()



/datum/dreyfus_objectives
	var/list/InvestorPhrases = list(
									"Los inversores agradecen mucho su trabajo subiendo los numeros del reporte, se ha enviado puntos de cargo adicionales y se ha depositado dinero extra a la cuenta de la estación <br>",
									"¡Seguid asi! Hemos recibido nuevas inversiones por parte de unos contactos en el sistema de Nyx... Tambien hemos enviado puntos de cargo y un dinerito extra a la cuenta de la estacion <br>",
									"¡Los inversores piden y piden! ¡Que no baje la produccion! Hemos enviado puntos de cargo y dinero adicional a la cuenta de la estacion <br>"
								)
	var/list/sellable_items = 	list(
									/obj/item/weapon/reagent_containers/glass/bucket,
									/obj/item/device/flashlight,
									/obj/item/weapon/extinguisher,
									/obj/item/glass_jar,
									/obj/item/weapon/crowbar,
									/obj/item/device/multitool,
									/obj/item/device/t_scanner,
									/obj/item/weapon/weldingtool,
									/obj/item/weapon/airlock_electronics,
									/obj/item/weapon/reagent_containers/syringe,
									/obj/item/weapon/reagent_containers/glass/beaker,
									/obj/item/device/assembly/timer,
									/obj/item/weapon/light/tube,
									/obj/item/weapon/light/bulb,
									/obj/item/weapon/camera_assembly,
									/obj/item/weapon/stock_parts/console_screen,
								)
	var/list/high_need = list()	// It should be "high demand" but fuck it xD
	var/list/low_need = list()	// It should be "low demand" but fuck it xD
	var/current_quota = 0
	var/required_quota = 0

	var/min_low = 1				// Quota points
	var/max_low = 2				// Quota points
	var/min_high = 4			// Quota points
	var/max_high = 9			// Quota points

	var/min_quota = 200
	var/max_quota = 400

	var/times_quota_reached = 0	// How many times has the quota been reached
	var/times_quota_needed = 1	// Times of quota achieved needed to get green text, it'll increase by 0-3 at world Setup (see round_control.dm)
	var/items_on_high_need = 2	// Minimum of items on high need


// QUOTA POINTS

/datum/dreyfus_objectives/proc/AddQuotaPointsPerItem(var/obj/ItemToSell)
	var/total_quota_points = 0

	if(ItemToSell.type in high_need)
		total_quota_points += rand(min_high, max_high)

	else if(ItemToSell.type in low_need)
		total_quota_points += rand(min_low, max_low)

	current_quota += total_quota_points

/datum/dreyfus_objectives/proc/CheckQuotaReached(var/datum/controller/supply/Controlador)
	if(current_quota > required_quota)
		message_admins("DEBUG: Se ha cumplido una cuota de Dreyfus")
		var/datum/announcement/crew_announcement = new()
		crew_announcement.title = "Avances con la produccion"
		crew_announcement.announcer = "Oficiales de Industrias NanoTrasen"
		crew_announcement.sound = 'sound/misc/notice2.ogg'
		crew_announcement.Announce(pick(InvestorPhrases))
		RewardCargo_AndDirector(Controlador)
		times_quota_reached++
		new_Objective()

/datum/dreyfus_objectives/proc/RewardCargo_AndDirector(var/datum/controller/supply/Controlador)
	var/puntos_a_regalar = required_quota / 4 // 400 se hace 100 || 200 se hace 50 || The more quotas that have passed, the higher the reward
	Controlador.add_points_from_source(puntos_a_regalar, "manifest")	// Pongo manifest porque como que da igual, aunque no me quiero arriesgar a que haya una lista o algo

	//create an entry in the account transaction log for when it was created
	var/addingthis = rand(1000,2000)
	station_account.money += addingthis
	var/datum/transaction/T = new("Oficial de NanoTrasen","Adicion a la cuenta de la estacion",addingthis,"Biesel GalaxyNet Terminal #277")
	T.date = "2nd April, 2540"
	T.time = "[duration2stationtime(TimeOfGame)]"
	//add the account
	station_account.transaction_log.Add(T)


// QUOTA OBJECTIVES

/datum/dreyfus_objectives/proc/new_Objective()
	randomize_required_quota()
	reset_sellable_items()
	randomize_need()
	generate_paper()
	increase_min_max_quota()

/datum/dreyfus_objectives/proc/increase_min_max_quota()
	// Can probably put a config option for "how much" will the quota advance
	min_quota = min_quota * 1.7	//Increments by 70%
	max_quota = max_quota * 1.7	//Increments by 70%

/datum/dreyfus_objectives/proc/randomize_required_quota()
	current_quota = 0
	required_quota = rand(min_quota, max_quota)

// Manual, because initial() is breaking my balls - Sansaur
/datum/dreyfus_objectives/proc/reset_sellable_items()
	sellable_items = list(
							/obj/item/weapon/reagent_containers/glass/bucket,
							/obj/item/device/flashlight,
							/obj/item/weapon/extinguisher,
							/obj/item/glass_jar,
							/obj/item/weapon/crowbar,
							/obj/item/device/multitool,
							/obj/item/device/t_scanner,
							/obj/item/weapon/weldingtool,
							/obj/item/weapon/airlock_electronics,
							/obj/item/weapon/reagent_containers/syringe,
							/obj/item/weapon/reagent_containers/glass/beaker,
							/obj/item/device/assembly/timer,
							/obj/item/weapon/light/tube,
							/obj/item/weapon/light/bulb,
							/obj/item/weapon/camera_assembly,
							/obj/item/weapon/stock_parts/console_screen,
						)

/datum/dreyfus_objectives/proc/randomize_need()
	if(high_need.len)
		high_need.Cut()
	if(low_need.len)
		low_need.Cut()

	items_on_high_need = 2

	var/proba_objectives_high = rand(100)
	if(proba_objectives_high > 30)
		items_on_high_need += 2
	if(proba_objectives_high > 50)
		items_on_high_need++
	if(proba_objectives_high > 80)
		items_on_high_need += 2

	for(var/i = 1; i <= items_on_high_need, i++)
		var/S = pick(sellable_items)
		high_need.Add(S)
		sellable_items.Remove(S)

	// After removing some high need items, the rest are to be added into the low need
	for(var/S in sellable_items)
		low_need.Add(S)
		sellable_items.Remove(S)

/datum/dreyfus_objectives/proc/generate_paper()
	var/textito = "<h2> Objetivos de produccion - <b> [station_name()] </b> </h2>"

	if(DreyfusQuotas.times_quota_needed > DreyfusQuotas.times_quota_reached)

	else
		textito += "<br><H4><font color='green'><B> Hemos alcanzado los objetivos de produccion deseados, esto es ahora trabajo extra.</B></font></H4>"

	textito += "<hr>"
	textito += "<center> Objetos en alta demanda </center>"
	for(var/S in high_need)
		if(!S)
			continue
		var/obj/Holiwi = new S()
		textito += "<b>[Holiwi]</b><br>"
		qdel(Holiwi)

	textito += "<hr>"

	textito += "<center> Objetos en baja demanda </center>"
	for(var/S in low_need)
		if(!S)
			continue
		var/obj/Holiwi = new S()
		textito += "<b>[Holiwi]</b><br>"
		qdel(Holiwi)

	// Damos una pista de como de jodida va a ser la shift
	// Se pueden hacer listas más adelante.
	textito += "<hr>"
	if(DreyfusQuotas.times_quota_needed == 1)
		textito += "<u>No tiene pinta de que vaya a haber mucha demanda este turno</u>"
	if(DreyfusQuotas.times_quota_needed == 2)
		textito += "<u>Se esperan demandas adicionales</u>"
	if(DreyfusQuotas.times_quota_needed >= 3)
		textito += "<u>Tenemos a los inversores en los talones</u>"
	var/obj/item/weapon/paper/NuevoPapel = new()
	NuevoPapel.name = "Requisitos de produccion"
	NuevoPapel.icon_state = "paper_words"
	NuevoPapel.info = textito

	// Ponemos el papel en una máquina de Fax que esté en el área del capitán.
	// Si no hay faxes en el área del capitán, simplemente aparece en el suelo >:C

	var/movio_papel = 0
	var/area/dreyfus/administration/bureaux/executif/AreaCapitan = locate()
	for(var/obj/machinery/photocopier/faxmachine/FAX in AreaCapitan)
		NuevoPapel.loc = FAX.loc
		movio_papel = 1
		break

	if(!movio_papel)
		for(var/turf/simulated/floor/objetivo in AreaCapitan)
			NuevoPapel.loc = objetivo
			break

