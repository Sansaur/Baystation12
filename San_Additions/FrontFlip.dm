
/datum/species/tajaran
	inherent_verbs = list(
		/mob/living/carbon/human/proc/frontflip
		)

/mob/living/carbon/human
	var/is_jumping = 0 // For the FrontFlip

/mob/living/carbon/human/proc/frontflip()
	set category = "Abilities"
	set name = "Front Flip"
	set desc = "Jump baby jump!."

	var/nutrition_limit = 150
	var/Tiempo_CD = 4
	var/casillas_a_avanzar = 3
	var/stuntime = 3	// Cuanto tiempo aturdido

	if(is_jumping)
		return

	// Special cooldown
	if(last_special > world.time)
		to_chat(src, "<span class='warning'> You've jumped too soon ago!.</span>")
		return

	// No podemos saltar desde algo que no sea un suelo. (Nada de saltar desde lockers cerrados)
	if(!isturf(src.loc))
		return

	// No podemos saltar sin un sitio donde poner los pies correctamente
	// O si llevan magboots o zapatos que no le dejen levantar el pie del suelo
	if(!src.check_solid_ground())
		to_chat(src, "<span class='warning'> You cannot jump here!.</span>")
		return
	if(istype(src.shoes, /obj/item/clothing/shoes/magboots))
		var/obj/item/clothing/shoes/magboots/AAA = src.shoes
		if(AAA.magpulse)
			to_chat(src, "<span class='warning'> You cannot jump while wearing activated magboots!.</span>")
			return

	// No podemos saltar si estamos gordos
	if(FAT in src.mutations)
		to_chat(src, "<span class='warning'> You're too fat for that!.</span>")
		return

	// Incapacitated / Buckled
	if(incapacitated(INCAPACITATION_DISABLED) || buckled || pinned.len)
		to_chat(src, "<span class='warning'> You cannot jump like this!.</span>")
		return

	// Hambre o heridas
	if(src.nutrition < nutrition_limit || health < 35)	// Cambiar el 35 por una flag
		to_chat(src, "<span class='warning'> You're too tired to perform a frontflip!.</span>")
		return

	//Añadir tiempo de enfriamiento por armadura
	// +1 segundo por llevar traje
	// +2 segundos si es un traje espacial
	// +1 segundo si es armadura
	// +4 segundos si es armadura Y es armadura pesada. (Comprobado que por muchos 8 segundos que sean, sigue siendo muy trol, subiendo a 10 al menos)
	if(src.wear_suit)
		Tiempo_CD++
		if(istype(src.wear_suit, /obj/item/clothing/suit/space))
			Tiempo_CD += 2
		if(istype(src.wear_suit, /obj/item/clothing/suit/armor))
			Tiempo_CD++
			var/obj/item/clothing/suit/armor/MYARMOR = src.wear_suit
			if(MYARMOR.w_class >= ITEM_SIZE_LARGE)
				Tiempo_CD += 4

	// Efecto
	// Cogemos la dirección en la que miramos, 1 = norte, 2 = sur, 4 = este, 8 = oeste
	// Comprobamos las 3 próximas casillas, una por una, si hay algo denso que no sea una mesa, se guarda la posición del choque
	// Se hace un efecto de girar al personaje y luego este aparece en la casilla objetivo.

	// ¿Qué cosas densas se pueden saltar?
	var/list/JumpableTypes = list(
		/obj/structure/table,
		/obj/machinery/disposal,
		/obj/structure/closet,
		/obj/machinery/microscope,
		/obj/structure/morgue,
		/obj/structure/reagent_dispensers/water_cooler
	)

	// OH MY GOD
	// Si ponemos esto del Spin, el FrontFlip se transforma en una
	// Maniobra evasiva con forma de molinillo
	// Para poner el giro de Goonstation se descomenta aquí
	// Para quitarlo, se comenta, obvs
//	src.spin(2,0.6)
	/*
	if(src.dir == 4)
		animate_spin(src, "R", 1.3) // Flip de Goonstation
	else
		animate_spin(src, "L", 1.3) // Flip de Goonstation
	*/
	is_jumping = 1	// Begin the jump, before each return it'll reset to 0
	playsound(src.loc, 'sound/weapons/towelwipe.ogg', 50, 1)
	var/storey = src.pixel_y

	var/turf/Casilla = src.loc
	for(var/i=0, i<casillas_a_avanzar, i++)
		Casilla = get_step(Casilla, src.dir)
		if(Casilla.density)
			playsound(src.loc, 'sound/weapons/genhit2.ogg', 50, 1)
			to_chat(src, "<span class='warning'> You crash into [Casilla]!.</span>")
			src.Weaken(stuntime)
			last_special = world.time + (Tiempo_CD SECONDS)
			src.do_attack_animation(Casilla)
			adjustHalLoss(4 + Tiempo_CD)
			is_jumping = 0
			src.pixel_y = storey
			return
		else
			for(var/mob/Bloqueando in Casilla)
				if(istype(Bloqueando, /mob/living/carbon/human))
					var/mob/living/carbon/human/Bloqueador = Bloqueando
					// Nosotros mismos no nos podemos bloquear
					if(Bloqueador == src)
						continue
					if(Bloqueador.a_intent != I_HELP)	// Si pasa por un humano que no le quiera dejar pasar (Siguiendo las normas de Bumps en movimiento) le bloqueará
						//playsound(src.loc, 'sound/weapons/genhit2.ogg', 50, 1)
						if(istype(Bloqueador.get_active_hand(), /obj/item/weapon/shield))
							to_chat(src, "<span class='warning'> [Bloqueador] stops you with his shield!.</span>")
							to_chat(Bloqueador, "<span class='warning'> you stop [src] with your shield as it tries to jump over you!.</span>")
							playsound(src.loc, 'sound/weapons/genhit2.ogg', 50, 1)
							src.Weaken(stuntime) 	// Si te paran con el escudo, te aturden
						else
							to_chat(src, "<span class='warning'> [Bloqueador] stops you with his body!.</span>")
							to_chat(Bloqueador, "<span class='warning'> you stop [src] as it tries to jump over you!.</span>")
							playsound(src.loc, 'sound/weapons/genhit2.ogg', 50, 1)
							src.apply_damage(stuntime, BRUTE) 			// Si te paran con su cuerpo, ambos recibís daño.
							Bloqueador.apply_damage(stuntime, BRUTE)

						src.do_attack_animation(Bloqueador)
						last_special = world.time + (Tiempo_CD SECONDS)
						adjustHalLoss(4 + Tiempo_CD)
						is_jumping = 0
						src.pixel_y = storey
						return

				if(istype(Bloqueando, /mob/living/silicon/robot))
					var/mob/living/silicon/robot/Robot = Bloqueando
					if(Robot.a_intent != I_HELP)	// Si el robot está en Harm, se chocan y el robot recibe algo de daño, pero el Tajaran se aturde tambien.
						to_chat(src, "<span class='warning'> [Robot] stops you with his robotic body!.</span>")
						to_chat(Robot, "<span class='warning'> you stop [src] as it tries to jump over you!.</span>")
						playsound(src.loc, 'sound/weapons/genhit2.ogg', 50, 1)
						src.apply_damage(stuntime, BRUTE)
//						Robot.apply_damage(stuntime, BRUTE)
						src.Weaken(1)
						last_special = world.time + (Tiempo_CD SECONDS)
						src.do_attack_animation(Robot)
						adjustHalLoss(4 + Tiempo_CD)
						is_jumping = 0
						src.pixel_y = storey
						return


			for(var/obj/OBJETO in Casilla)
				if(OBJETO.density && !(is_type_in_list(OBJETO, JumpableTypes)))
					playsound(src.loc, 'sound/weapons/genhit2.ogg', 50, 1)
					to_chat(src, "<span class='warning'> You crash into [OBJETO]!.</span>")
					src.Weaken(stuntime)
					src.do_attack_animation(OBJETO)
					last_special = world.time + (Tiempo_CD SECONDS)
					adjustHalLoss(4 + Tiempo_CD)
					is_jumping = 0
					src.pixel_y = storey
					return

				if(i==(casillas_a_avanzar-1)) // cosas especiales que pueden ocurrir en la tercera casilla
					if(istype(OBJETO, /obj/machinery/disposal))	// Caer dentro de un disposal
						var/obj/machinery/disposal/MYDISPOSAL = OBJETO
						to_chat(src, "<span class='warning'> You fall directly into [MYDISPOSAL]!.</span>")
						MYDISPOSAL.FallInto(src)
						adjustHalLoss(4 + Tiempo_CD)
						is_jumping = 0
						src.pixel_y = storey
						return

//		if(i!=(casillas_a_avanzar-1))
//			dejar_rastro(Casilla)
		if(i > casillas_a_avanzar / 2)
			src.pixel_y -= 7
		else
			src.pixel_y += 7
		src.forceMove(Casilla)
		// A sleep of 1.5 is to be used with the pixel_y movement
		// A sleep of 0.5-0.3 is to be used with dejar_rastro(Casilla)
		sleep(1.5)


	if(Tiempo_CD > 4)
		// Mucho  daño por saltar con armadura pesada
		adjustHalLoss(12 + Tiempo_CD)
		to_chat(src, "<span class='warning'> you hardly frontflips towards [Casilla], your legs hurt!.</span>")
	else
		// Muy poco daño por saltar sin armadura pesada y que no te bloqueen
		adjustHalLoss(4 + Tiempo_CD)
		to_chat(src, "<span class='info'> you frontflip towards [Casilla]!.</span>")
	last_special = world.time + (Tiempo_CD SECONDS)
	is_jumping = 0
	src.pixel_y = storey

// ¡Una nueva proc para los disposals para que el Tajaran pueda saltar adentro!
// Básicamente es lo mismo que tirar a alguien adentro, pero instantáneo.
/obj/machinery/disposal/proc/FallInto(mob/user)
	if(user.stat || !user.canmove || !istype(user))
		return

	src.add_fingerprint(user)
	var/msg = "<span class='warning'> [user] falls directly into [src]! </span>"

	if (user.client)
		user.client.perspective = EYE_PERSPECTIVE
		user.client.eye = src
	user.forceMove(src)
	for (var/mob/C in viewers(src))
		if(C == user)
			continue
		C.show_message(msg, 3)
	update_icon()
	return

// PORT DE UNA ANIMACIÓN DE PARADISE
	// NO SE HACE LOOP >:C
/proc/animate_spin(var/atom/A, var/dir = "L", var/T = 1, var/looping = 0)
	if(!istype(A))
		return

	var/matrix/M = A.transform
	var/turn = -90
	if(dir == "R")
		turn = 90

	animate(A, transform = matrix(M, turn, MATRIX_ROTATE | MATRIX_MODIFY), time = T, loop = looping)
	animate(transform = matrix(M, turn, MATRIX_ROTATE | MATRIX_MODIFY), time = T, loop = looping)
	animate(transform = matrix(M, turn, MATRIX_ROTATE | MATRIX_MODIFY), time = T, loop = looping)
	animate(transform = matrix(M, turn, MATRIX_ROTATE | MATRIX_MODIFY), time = T, loop = looping)

// Una nueva animación para los Mobs, permitiéndooles dejar un rastro negro antropomórfico.
// Esto se puede cambiar para que sea un proc general, pero por ahora, como solo lo usan los tajaran, como que no importa mucho.
/mob/proc/dejar_rastro(var/turf/T)
	if(!T)
		return
	anim(T,src,'rastro.dmi',,"rastro",,dir)
