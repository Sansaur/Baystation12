/obj/item/weapon/storage/briefcase/deployable_briefcase
	name = "deployable briefcase"
	desc = "It's metallic."
	icon = 'items.dmi'
	icon_state = "depl_brief"
	item_state = "briefcase"
	flags = CONDUCT
	force = 8.0
	throw_speed = 1
	throw_range = 4
	w_class = ITEM_SIZE_HUGE
	var/deploying = 0

/obj/item/weapon/storage/briefcase/deployable_briefcase/attack_hand(mob/user as mob)
	if(deploying)
		return
	else
		..()

/obj/item/weapon/storage/briefcase/deployable_briefcase/attack_self(mob/user as mob)
	to_chat(user, "<span class='info'> The [src] will deploy in 3 seconds! </span>")
	Deploy()

/obj/item/weapon/storage/briefcase/deployable_briefcase/proc/Deploy()
	sleep(30)
	if(isturf(loc))
		for(var/obj/S in loc)
			if(S.density)
				visible_message("[src] couldn't deploy correctly!")
				return
		for(var/mob/living/M in loc)
			visible_message("[src] couldn't deploy correctly!")
			return

		deploying = 1
		flick("depl_brief_deploying",src)
		playsound(src.loc, 'sound/machines/windowdoor.ogg', 50, 1)
		sleep(9)
		var/obj/structure/deployed_briefcase/NEW = new /obj/structure/deployed_briefcase (loc)
		NEW.stored_briefcase = src
		src.loc = NEW
		deploying = 0
		return

	visible_message("[src] couldn't deploy correctly!")


/obj/structure/deployed_briefcase
	name = "deployed briefcase"
	desc = "It's metallic."
	icon = 'items.dmi'
	icon_state = "depl_brief_deployed"
	opacity = 0
	density = 1
	anchored = 0
	var/obj/item/weapon/storage/briefcase/deployable_briefcase/stored_briefcase
	var/busy = 0
/obj/structure/deployed_briefcase/attack_hand(mob/user as mob)
	if(busy)
		return

	to_chat(user, "You press the 'compact' button on the [src]")
	Compact()


/obj/structure/deployed_briefcase/proc/Compact()
	busy = 1
	flick("depl_brief_compacting",src)
	playsound(src.loc, 'sound/machines/windowdoor.ogg', 50, 1)
	sleep(10)
	if(stored_briefcase)
		stored_briefcase.loc = src.loc
	for(var/obj/item/W in loc)
		if(stored_briefcase.can_be_inserted(W,null,1))
			W.forceMove(stored_briefcase)
			W.on_enter_storage(stored_briefcase)
	qdel(src)

	// MISC ITEMS

/obj/item/weapon/storage/briefcase/paint_kit
	name = "paint kit"
	desc = "It should contain some closed paint buckets."
	item_state = "briefcase"
	startswith = list(
			/obj/item/weapon/reagent_containers/glass/paint/blue,
			/obj/item/weapon/reagent_containers/glass/paint/red,
			/obj/item/weapon/reagent_containers/glass/paint/yellow,
			/obj/item/weapon/reagent_containers/glass/paint/purple,
			/obj/item/weapon/reagent_containers/glass/paint/black,
			/obj/item/weapon/reagent_containers/glass/paint/white
		)
