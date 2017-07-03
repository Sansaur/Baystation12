/obj/item/weapon/deployable_briefcase
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

/obj/item/weapon/deployable_briefcase/attack_hand(mob/user as mob)
	if(deploying)
		return
	else
		..()

/obj/item/weapon/deployable_briefcase/attack_self(mob/user as mob)
	to_chat(user, "<span class='info'> The [src] will deploy in 3 seconds! </span>")
	Deploy(user)

/obj/item/weapon/deployable_briefcase/proc/Deploy(mob/user as mob)
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
		sleep(9)
		new /obj/structure/deployed_briefcase (loc)
		qdel(src)
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

/obj/structure/deployed_briefcase/attack_hand(mob/user as mob)
	to_chat(user, "You press the 'compact' button on the [src]")
	flick("depl_brief_compacting",src)
	sleep(10)
	new /obj/item/weapon/deployable_briefcase (loc)
	qdel(src)
