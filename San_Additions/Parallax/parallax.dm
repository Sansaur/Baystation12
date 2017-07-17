/obj/parallax
	name = "parallax"
	mouse_opacity = 0
	blend_mode = BLEND_MULTIPLY
	plane = PARALLAX_PLANE
	invisibility = 101	// Revertir a 101 tras testeos - Sansaur
	anchored = 1
	var/mob/owner
	var/image/image

	New(mob/M)
		owner = M
		owner.parallax = src
		//icon = 'parallax.dmi'	// Quitar esto
		//icon_state = "space"	// Quitar esto
		//image(icon,loc,icon_state,layer,dir)
		image = image('parallax.dmi', src, "desat")
		image.invisibility = 0
		update()

	proc/update()
		if(!owner)
			return

		if(isturf(owner.loc))
			forceMove(get_turf(owner))
			pixel_x = -224-owner.x
			pixel_y = -224-owner.y
		else
			if(!owner.loc)
				return

			forceMove(get_turf(owner.loc))
			pixel_x = -224-owner.loc.x
			pixel_y = -224-owner.loc.y


	// Voy a dejar todos estos procs para que se pueda hacer debug en mitad de la partida - Sansaur
	proc/redo_image()
		owner << image

		// Este es el correcto.
	proc/debug_2()
		image = image('parallax.dmi', src, "space")
		owner << image
		// Este es el correcto.


/mob
	var/obj/parallax/parallax

/mob/Move()
	. = ..()
	if(parallax)
		parallax.update()

/mob/forceMove()
	. = ..()
	if(parallax)
		parallax.update()

/obj/Move()
	. = ..()
	for(var/atom/A in contents)
		if(istype(A, /mob))
			var/mob/C = A
			if(C.parallax)
				C.parallax.update()

/mob/Login()
	..()
	if(!parallax)
		parallax = new(src)
	src << parallax.image

/mob/face_atom(var/atom/A)
	. = ..(A)
	if(parallax)
		parallax.update()

/mob/facedir(var/ndir)
	. = ..(ndir)
	if(parallax)
		parallax.update()

/mob/set_dir(new_dir)
	. = ..(new_dir)
	if(parallax)
		parallax.update()

/obj/mecha/Move()
	. = ..()
	if(occupant)
		var/mob/living/S = occupant
		if(S.parallax)
			S.parallax.update()

/obj/mecha/do_move()
	. = ..()
	if(occupant)
		var/mob/living/S = occupant
		if(S.parallax)
			S.parallax.update()

/obj/mecha/mechturn(direction)
	. = ..()
	if(occupant)
		var/mob/living/S = occupant
		if(S.parallax)
			S.parallax.update()

/obj/mecha/mechstep(direction)
	. = ..()
	if(occupant)
		var/mob/living/S = occupant
		if(S.parallax)
			S.parallax.update()

/obj/mecha/mechsteprand()
	. = ..()
	if(occupant)
		var/mob/living/S = occupant
		if(S.parallax)
			S.parallax.update()