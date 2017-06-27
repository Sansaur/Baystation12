/*
	Test 1: Trying to put fullscreen overlays in the direction the mob is not looking (Maybe?)
	Test 2: Check dir, if looking to the right, cannot see mobs on an X superior to player, if left cannot see X inferior to player, same for vertical
*/

/mob/living/proc/Tell_Me_Dir_MOBS()
	if(dir == SOUTH)
		for(var/mob/living/VISIBLE in oview())
			if(VISIBLE.y <= src.y && !(VISIBLE.y < src.y - 7))
				to_chat(src, "you can see [VISIBLE] the mob")

	if(dir == NORTH)
		for(var/mob/living/VISIBLE in oview())
			if(VISIBLE.y >= src.y && !(VISIBLE.y > src.y + 7))
				to_chat(src, "you can see [VISIBLE] the mob")

	if(dir == EAST)
		for(var/mob/living/VISIBLE in oview())
			if(VISIBLE.x >= src.x && !(VISIBLE.x > src.x + 7))
				to_chat(src, "you can see [VISIBLE] the mob")

	if(dir == WEST)
		for(var/mob/living/VISIBLE in oview())
			if(VISIBLE.x <= src.x && !(VISIBLE.x < src.x - 7))
				to_chat(src, "you can see [VISIBLE] the mob")

/mob/living/proc/Tell_Me_Dir_TURFS()
	if(dir == SOUTH)
		for(var/turf/VISIBLE in oview())
			if(VISIBLE.y <= src.y && !(VISIBLE.y < src.y - 7))
				//to_chat(src, "you can see [VISIBLE] the mob")

	if(dir == NORTH)
		for(var/turf/VISIBLE in oview())
			if(VISIBLE.y >= src.y && !(VISIBLE.y > src.y + 7))
				//to_chat(src, "you can see [VISIBLE] the mob")

	if(dir == EAST)
		for(var/turf/VISIBLE in oview())
			if(VISIBLE.x >= src.x && !(VISIBLE.x > src.x + 7))
				//to_chat(src, "you can see [VISIBLE] the mob")

	if(dir == WEST)
		for(var/turf/VISIBLE in oview())
			if(VISIBLE.x <= src.x && !(VISIBLE.x < src.x - 7))
				//to_chat(src, "you can see [VISIBLE] the mob")

	// The idea to generate this is via
	// 			5
	// 		2	2
	// 1 	1	1
	//		3	3
	//			4

	/*

	THIS IS ABSOLUTELY OUT OF THE QUESTION

/mob
	var/obj/fov_test/fov_test

/mob/Move()
	. = ..()
	if(fov_test)
		fov_test.update()

/mob/forceMove()
	. = ..()
	if(fov_test)
		fov_test.update()

/mob/Login()
	..()
	if(!fov_test)
		fov_test = new(src)
	src << fov_test.image

/obj/fov_test
	name = "item attached to the back of the person"
	mouse_opacity = 0
	blend_mode = BLEND_MULTIPLY
	plane = FULLSCREEN_PLANE
	invisibility = 101	// Revertir a 101 tras testeos - Sansaur
	anchored = 1
	var/mob/owner
	var/image/image

	New(mob/M)
		owner = M
		owner.fov_test = src
		image = image('Testing.dmi', src, "test")
		image.invisibility = 0
		update()

	proc/update()
		forceMove(get_turf(owner))
		pixel_x = -224
		pixel_y = -224
		dir = owner.dir

		// Este es el correcto.
	proc/debug_2()
		image = image('Testing.dmi', src, "test")
		owner << image
		// Este es el correcto.


	*/





	/*
/mob/living/handle_vision()
	update_sight()

	if(stat == DEAD)
		return

	if(eye_blind)
		overlay_fullscreen("blind", /obj/screen/fullscreen/blind)
	else
		clear_fullscreen("blind")
		set_fullscreen(disabilities & NEARSIGHTED, "impaired", /obj/screen/fullscreen/impaired, 1)
		set_fullscreen(eye_blurry, "blurry", /obj/screen/fullscreen/blurry)
		set_fullscreen(druggy, "high", /obj/screen/fullscreen/high)

	if(machine)
		var/viewflags = machine.check_eye(src)
		if(viewflags < 0)
			reset_view(null, 0)
		else if(viewflags)
			set_sight(viewflags)
	else if(eyeobj)
		if(eyeobj.owner != src)
			reset_view(null)
	else if(!client.adminobs)
		reset_view(null)

/mob/living/update_living_sight()
	set_sight(sight&(~(SEE_TURFS|SEE_MOBS|SEE_OBJS))) // This doesn't work because of this <- SEE_MOBS is hardcoded
	set_see_in_dark(initial(see_in_dark))
	set_see_invisible(initial(see_invisible))

	*/