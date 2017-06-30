//Añadiendo al tema de la lanzadera el que se puedan vender cosas para los objetivos de Dreyfus
/datum/controller/supply

	sell()
		// Esto se tiene que hacer antes del original, porque el original borra todos los atoms dentro de la lanzadera
		var/area/area_shuttle = shuttle.get_location_area()
		if(!area_shuttle)	return

		for(var/obj/Objeto in area_shuttle)
			// If they use a closet to transport stuff it should be checked too
			if(istype(Objeto, /obj/structure/closet))
				for(var/obj/OB in Objeto)
					if((OB.type in DreyfusQuotas.high_need) || (OB.type in DreyfusQuotas.low_need))
						DreyfusQuotas.AddQuotaPointsPerItem(OB)
						DreyfusQuotas.CheckQuotaReached(src)
						qdel(OB)	// Risky qdel

			if((Objeto.type in DreyfusQuotas.high_need) || (Objeto.type in DreyfusQuotas.low_need))
				DreyfusQuotas.AddQuotaPointsPerItem(Objeto)
				DreyfusQuotas.CheckQuotaReached(src)
				qdel(Objeto)	// Risky qdel

		..()