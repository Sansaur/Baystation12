/*
	Items that go installed in the trade controller and add new features.
	Only one mod at a time.

	1) Discount Mod (Everything is 30% less expensive)
	2) Wormhole Mod (You can spend 50 points and all the battery in the remote to teleport to a single random deployed briefcase in the world)
	3) Lucky Mod (30% chance to get a copy of an item)

	// Syndie mods
	1) Chembomb Mod (You can spend all the battery to make a reagent-smoke come out of a deployed briefcase) NOT DONE
	2) Bomb Mod (You can remotely blow up the deployed briefcase)
*/

/obj/item/device/trade_controller_mod
	name = "trader controller mod"
	desc = "Time to spice things up."
	icon = 'items.dmi'
	icon_state = "mod"
	w_class = 1
	var/has_ability = 0

/obj/item/device/trade_controller_mod/proc/controller_ability()
	return

/obj/item/device/trade_controller_mod/discount
	name = "discount mod"
	desc = "Circus of Values."
	var/discount = 0.7

/obj/item/device/trade_controller_mod/discount/sale
	name = "sale mod"
	desc = "Carnival of Values."
	discount = 0.5

/obj/item/device/trade_controller_mod/discount/black_friday
	name = "black friday mod"
	desc = "Madness of Values."
	discount = 0.2

/obj/item/device/trade_controller_mod/wormhole
	name = "wormhole mod"
	desc = "Into the briefcase. It'll waste all the battery and it'll require some company points to simulate the "
	has_ability = 1

/obj/item/device/trade_controller_mod/wormhole/controller_ability()
	if(istype(loc, /obj/item/device/trader_controller))
		var/obj/item/device/trader_controller/MyController = loc
		if(MyController.MyCell.charge >= 50 && MyController.points >= 50 && ismob(MyController.loc) && isturf(MyController.loc.loc))
			MyController.MyCell.use(MyController.MyCell.charge) 	// Wastes all the cell charge
			MyController.points -= 50						// Wastes 50 points
			var/obj/structure/deployed_briefcase/DEPLOYED = locate() in world
			var/mob/mymob = MyController.loc
			playsound(mymob.loc, 'sound/effects/teleport.ogg', 50, 1)
			mymob.phase_out(mymob.loc)
			mymob.forceMove(DEPLOYED.loc)
			mymob.phase_in(mymob.loc)
			playsound(mymob.loc, 'sound/effects/teleport.ogg', 50, 1)
			mymob.Weaken(4)
	else
		message_admins("Important bug, someone has used the wormhole trader mod ability without it being in a controller")

/obj/item/device/trade_controller_mod/lucky
	name = "lucky mod"
	desc = "Also known as \"fucking up with the company's storage system\" mod."

/obj/item/device/trade_controller_mod/chembomb
	name = "chembomb mod"
	desc = "Load it, cock it, shake it, bomb it."
	has_ability = 1

/obj/item/device/trade_controller_mod/bomb
	name = "bomb mod"
	desc = "BOMB IT."
	has_ability = 1

/obj/item/device/trade_controller_mod/bomb/controller_ability()
	var/obj/structure/deployed_briefcase/DEPLOYED = locate() in view()
	if(DEPLOYED)
		explosion(DEPLOYED, 1, 2, 3, 3)