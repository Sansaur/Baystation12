/obj/item/device/trader_controller
	name = "trader controller"
	desc = "The core of good'ol capitalism."
	icon = 'items.dmi'
	icon_state = "controller"
	item_state = "analyzer"
	w_class = 2
	var/is_emagged = 0
	var/is_investing	= 0			  	// If it's investing, money will go to the other companies, if not, it'll be sent to your own company and they'll give you points.
	var/investing_into = "solgov" 	// "solgov" | "embassy" | "sterling"
	var/list/investments = list(
							"solgov" = 0,
							"embassy" = 0,
							"sterling" = 0
							)
	var/points = 50
	var/stored_money = 0			// Stored money that is not invested
	var/is_locked = 1				// If is set, it needs password
	var/password
	// Solgov Approved Merchandise 	- Regular things
	var/list/items_availible_solgov = list(
		/obj/item/clothing/under/schoolgirl = 10,
		/obj/item/weapon/pack/cardemon = 5,
		/obj/item/weapon/pack/spaceball = 5
	)
	// Embassy Approved Merchandise - Exotic items from the various species
	var/list/items_availible_embassy = list(
		/obj/item/clothing/suit/tajaran/furs = 30,
		/obj/structure/plushie/ian = 20
	)

	// Sterling Manufactures - Mega luxurious shit
	var/list/items_availible_sterling = list(
		/obj/item/clothing/under/scratch = 55,
		/obj/item/clothing/under/wedding/bride_white = 55
	)

	var/list/items_possible_solgov = list(
		/obj/item/clothing/under/confederacy = 10,
		/obj/item/clothing/under/pt = 10,
		/obj/item/weapon/storage/briefcase/paint_kit = 20,
		/obj/item/clothing/under/abaya =10,
		/obj/item/pizzabox/meat = 3,
		/obj/item/inflatable/wall = 5,
		/obj/item/toy/therapy_blue = 4,
		/obj/item/toy/water_balloon = 6,
		/obj/item/toy/plushie/kitten = 3,
		/obj/item/toy/balloon/nanotrasen = 1,
		/obj/item/weapon/beach_ball = 5,
		/obj/item/weapon/cell/high = 10,
		/obj/item/weapon/storage/wallet/poly = 8,
		/obj/item/weapon/storage/firstaid/regular = 5,
		/obj/item/weapon/storage/fancy/crayons = 5,
		/obj/item/weapon/weldingtool/hugetank = 20,
		/obj/item/weapon/extinguisher/mini = 5,
		/obj/item/weapon/inflatable_duck = 5,
		/obj/item/clothing/head/philosopher_wig = 10,
		/obj/item/clothing/head/mailman = 10,
		/obj/item/clothing/under/rank/mailman = 20
	)
	var/list/items_possible_embassy = list(
		/obj/item/clothing/under/psysuit = 20,
		/obj/item/clothing/ears/skrell/chain = 20,
		/obj/item/clothing/ears/skrell/chain/silver = 20,
		/obj/item/clothing/ears/skrell/chain/bluejewels = 30,
		/obj/item/clothing/ears/skrell/chain/redjewels = 40,
		/obj/item/clothing/ears/skrell/chain/ebony = 50,
		/obj/item/clothing/ears/skrell/band/silver = 20,
		/obj/item/clothing/ears/skrell/band/bluejewels = 30,
		/obj/item/clothing/ears/skrell/band/redjewels = 40,
		/obj/item/clothing/ears/skrell/band/ebony = 50,
		/obj/item/clothing/suit/unathi/robe = 15,
		/obj/item/clothing/suit/unathi/mantle = 10,
		/obj/item/clothing/suit/rubber/unathi = 25,
		/obj/item/clothing/mask/rubber/species/unathi = 25,
		/obj/item/clothing/suit/rubber/tajaran = 25,
		/obj/item/clothing/mask/rubber/species/tajaran = 25,
		/obj/item/toy/plushie/nymph = 5,
		/obj/item/weapon/reagent_containers/food/snacks/skrellsnacks = 5,
		/obj/item/stack/material/leather = 20
	)
	var/list/items_possible_sterling = list(
		/obj/item/clothing/glasses/sunglasses/big = 40,
		/obj/item/clothing/glasses/sunglasses = 30,
		/obj/item/weapon/storage/fancy/cigar = 30,
		/obj/item/weapon/soap/deluxe = 10,
		/obj/item/stack/material/diamond = 60,
		/obj/item/clothing/ring/material/silver = 30,
		/obj/item/clothing/ring/material/gold = 40,
		/obj/item/clothing/ring/material/platinum = 50,
		/obj/item/clothing/ring/engagement = 75
	)

	// When emagged, it'll show 'exotic' contraband
	var/list/items_availible_emag = list(
		/obj/item/weapon/gun/projectile/revolver/detective = 30,
		/obj/item/toy/plushie/spider = 1,
		/obj/item/weapon/shield/riot = 40,
		/obj/item/weapon/silencer = 20,
		/obj/item/weapon/gun/projectile/pistol = 30,
		/obj/item/weapon/gun/projectile/automatic/mini_uzi = 50,
		/obj/item/weapon/flamethrower/full = 60
	)

	var/obj/item/weapon/cell/device/MyCell
	var/is_open = 0

	var/obj/item/device/trade_controller_mod/InstalledMod

/obj/item/device/trader_controller/New()
	..()
	MyCell = new /obj/item/weapon/cell/device/high (src)
	password = pick("solgov[rand(1000,9999)]","embassy[rand(1000,9999)]","warup[rand(1000,9999)]","donkco[rand(1000,9999)]","trading[rand(1000,9999)]")
	if(ismob(loc))
		if(istype(loc, /mob/living/carbon/human))
			var/mob/living/carbon/human/MyHuman = loc
			if(MyHuman.mind)
				MyHuman.mind.store_memory("Your trader device password is:[password]")
				to_chat(MyHuman,"<span class='info'> Your trader device password is: <b>[password]</b>. This information has been added to your notes</span> ")
	// Three free random investments at creation, yay
	for(var/i=0,i<6,i++)
		FreeRandomInvestment()

/obj/item/device/trader_controller/update_icon()

	if(InstalledMod)
		var/icon/I = new('items.dmi',"mod_overlay")
		overlays.Add(I)
	else
		overlays.Cut()

	if(is_open)
		if(MyCell)
			icon_state = "open"
		else
			icon_state = "open_nocell"
		..()
		return

	if(!MyCell)
		icon_state = "unpowered"
		..()
		return

	..()

/obj/item/device/trader_controller/verb/remove_mod()
	set name = "Remove installed mod"
	set desc = "Remove mod"
	set category = "Object"
	set src in view(1)

	if(InstalledMod)
		if(isturf(loc))
			InstalledMod.loc = loc
			InstalledMod = null
		if(ismob(loc))
			var/mob/living/AA = loc
			InstalledMod.loc = AA.loc
			AA.put_in_hands(InstalledMod)
			InstalledMod = null

	update_icon()

/obj/item/device/trader_controller/attack_hand(mob/living/carbon/human/user as mob)
	if(ismob(loc))
		if(is_open)
			MyCell.loc = user.loc
			playsound(src.loc, 'sound/machines/button.ogg', 50, 1)
			sleep(1)
			user.put_in_hands(MyCell)
			MyCell = null
			update_icon()
		else
			..()
	else
		..()

/obj/item/device/trader_controller/attackby(obj/item/W, mob/user as mob)
	if(istype(W, /obj/item/device/trade_controller_mod))
		var/obj/item/device/trade_controller_mod/MM = W
		if(InstalledMod)
			to_chat(user, "<span class='warning> You cannot install [MM] into [src] since it already is loaded with [InstalledMod] </span>")
			return
		else
			playsound(src.loc, 'sound/machines/button.ogg', 50, 1)
			to_chat(user, "You install [src] with [MM], adding a new feature")
			user.drop_item()
			InstalledMod = MM
			MM.loc = src

		update_icon()

	if(istype(W, /obj/item/weapon/screwdriver))
		var/obj/item/weapon/screwdriver/MM = W
		is_open = !is_open
		playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
		if(is_open)
			to_chat(user, "You open [src] with [MM]")
		else
			to_chat(user, "You close [src] with [MM]")
			icon_state = "controller"
			if(is_emagged)
				icon_state = "controller_emag"
		update_icon()


	if(istype(W, /obj/item/weapon/cell/device))
		var/obj/item/weapon/cell/device/MM = W
		if(is_open)
			if(!MyCell)
				user.drop_item()
				MyCell = MM
				MM.loc = src
				playsound(src.loc, 'sound/machines/button.ogg', 50, 1)
			else
				to_chat(user, "<span class='warning'> There's already [MyCell] installed!</span>")
		else
			to_chat(user, "<span class='warning'> You have to open [src] first </span>")
		update_icon()
		return

	if(istype(W, /obj/item/weapon/spacecash))
		var/obj/item/weapon/spacecash/MM = W
		insert_money(user, MM)
		return

	if(istype(W, /obj/item/weapon/card/emag))
		var/obj/item/weapon/card/emag/MyEmag = W
		to_chat(user, "<span class='warning'> You've emagged the [src] with [MyEmag], it has triggered it's automatic security scans! </span>")
		icon_state = "controller_emag"
		update_icon()
		is_emagged = 1
		return

/obj/item/device/trader_controller/attack_self(mob/user as mob)
	show_list(user)

/obj/item/device/trader_controller/proc/insert_money(mob/user as mob, var/obj/item/weapon/spacecash/Inserting)
	if(is_investing)
		to_chat(user, "<span class='info'> You've invested [Inserting.worth] to the company identified as '[investing_into]'</span>")
		investments[investing_into] += Inserting.worth
		qdel(Inserting)
		CheckInvestments()
	else
		to_chat(user, "<span class='info'> You've inserted [Inserting.worth] to the [src] private trader account </span>")
		stored_money += Inserting.worth
		qdel(Inserting)

/obj/item/device/trader_controller/proc/CheckInvestments()
	for(var/Investee in investments)
		if(investments[Investee] >= 1000)	// 1000 thalers for a new item!
			investments[Investee] = 0
			switch(Investee)
				if("solgov")
					if(!items_possible_solgov.len)
						visible_message("<span class='warning'> [src] beeps, \"That company won't send us any more new items\" </span>")
						return
					playsound(src.loc, 'sound/machines/chime.ogg', 50, 1)
					var/chosen_type = pick(items_possible_solgov)
					items_availible_solgov.Add(chosen_type)
					items_availible_solgov[chosen_type] = items_possible_solgov[chosen_type]
					items_possible_solgov.Remove(chosen_type)
				if("embassy")
					if(!items_possible_embassy.len)
						visible_message("<span class='warning'> [src] beeps, \"That company won't send us any more new items\" </span>")
						return
					playsound(src.loc, 'sound/machines/chime.ogg', 50, 1)
					var/chosen_type = pick(items_possible_embassy)
					items_availible_embassy.Add(chosen_type)
					items_availible_embassy[chosen_type] = items_possible_embassy[chosen_type]
					items_possible_embassy.Remove(chosen_type)

				if("sterling")
					if(!items_possible_sterling.len)
						visible_message("<span class='warning'> [src] beeps, \"That company won't send us any more new items\" </span>")
						return
					playsound(src.loc, 'sound/machines/chime.ogg', 50, 1)
					var/chosen_type = pick(items_possible_sterling)
					items_availible_sterling.Add(chosen_type)
					items_availible_sterling[chosen_type] = items_possible_sterling[chosen_type]
					items_possible_sterling.Remove(chosen_type)

/obj/item/device/trader_controller/proc/FreeRandomInvestment()
	var/Investee = pick("sterling", "solgov", "embassy")
	switch(Investee)
		if("solgov")
			if(!items_possible_solgov.len)
				return
			var/chosen_type = pick(items_possible_solgov)
			items_availible_solgov.Add(chosen_type)
			items_availible_solgov[chosen_type] = items_possible_solgov[chosen_type]
			items_possible_solgov.Remove(chosen_type)
		if("embassy")
			if(!items_possible_embassy.len)
				return
			var/chosen_type = pick(items_possible_embassy)
			items_availible_embassy.Add(chosen_type)
			items_availible_embassy[chosen_type] = items_possible_embassy[chosen_type]
			items_possible_embassy.Remove(chosen_type)

		if("sterling")
			if(!items_possible_sterling.len)
				return
			var/chosen_type = pick(items_possible_sterling)
			items_availible_sterling.Add(chosen_type)
			items_availible_sterling[chosen_type] = items_possible_sterling[chosen_type]
			items_possible_sterling.Remove(chosen_type)

/obj/item/device/trader_controller/proc/show_list(mob/user as mob)
	if(!MyCell)
		return

	var/datum/browser/BROWSER = new(user, "Trade Control", "Trade Control", 600, 600, src)
	BROWSER.add_content("<h1> Welcome to the Trader Control UI </h1>")
	if(is_locked)
		BROWSER.add_content("<a href='?src=\ref[src];EnterPassword=1'>Enter password</a>")
	else
		BROWSER.add_content("Availible points to purchase: <b>[points]</b>")
		BROWSER.add_content("<br>")
		BROWSER.add_content("<a href='?src=\ref[src];Lock=1'>Lock device</a>")
		BROWSER.add_content("<br>")
		BROWSER.add_content("We are now ")
		if(is_investing)
			BROWSER.add_content("<a href='?src=\ref[src];SwitchInvestment=1'>Investing into other companies</a>")
		else
			BROWSER.add_content("<a href='?src=\ref[src];SwitchInvestment=1'>Storing money in the private account</a>")

		BROWSER.add_content("<br>")
		BROWSER.add_content("We're investing in: <a href='?src=\ref[src];ChangeInvestment=1'>[investing_into]</a>")
		BROWSER.add_content("<br>")
		BROWSER.add_content("Currently, we have <a href='?src=\ref[src];GetMoney=1'>[stored_money]</a> stored in the private trading account.<a href='?src=\ref[src];SendMoney=1'>Send it to HQ</a> ")
		BROWSER.add_content("<hr>")
		BROWSER.add_content("<a href='?src=\ref[src];RemotelyAct=1'>Act on Trade briefcase</a> || <a href='?src=\ref[src];RecallBriefcase=1'>Return briefcase</a>")
		if(InstalledMod)
			BROWSER.add_content(" || Installed Mod: <b> [InstalledMod] </b> ")
			if(InstalledMod.has_ability)
				BROWSER.add_content("<a href='?src=\ref[src];ActivateModAbility=1'>Activate mod ability</a>")
		BROWSER.add_content("<hr>")

		BROWSER.add_content("<h3><b> Solgov Approved Merchandise </b></h3>")
		BROWSER.add_content("<hr>")
		for(var/S in items_availible_solgov)
			var/obj/OBJ = new S
			BROWSER.add_content("<a href='?src=\ref[src];BuySolgov=[S]'>[OBJ]</a> Cost: [items_availible_solgov[S]]")	// We send the type, then, using the type, we create the item at the deployed briefcase and search for it in the list, withdrawing thsoe points
			BROWSER.add_content("<br>")
			qdel(OBJ)

		BROWSER.add_content("<h3><b> Embassy Approved Merchandise </b></h3>")
		BROWSER.add_content("<hr>")
		for(var/S in items_availible_embassy)
			var/obj/OBJ = new S
			BROWSER.add_content("<a href='?src=\ref[src];BuyEmbassy=[S]'>[OBJ]</a> Cost: [items_availible_embassy[S]]")	// We send the type, then, using the type, we create the item at the deployed briefcase and search for it in the list, withdrawing thsoe points
			BROWSER.add_content("<br>")
			qdel(OBJ)

		BROWSER.add_content("<h3><b> Sterling Manufacturers Merchandise </b></h3>")
		BROWSER.add_content("<hr>")
		for(var/S in items_availible_sterling)
			var/obj/OBJ = new S
			BROWSER.add_content("<a href='?src=\ref[src];BuySterling=[S]'>[OBJ]</a> Cost: [items_availible_sterling[S]]")	// We send the type, then, using the type, we create the item at the deployed briefcase and search for it in the list, withdrawing thsoe points
			BROWSER.add_content("<br>")
			qdel(OBJ)

		if(is_emagged)
			BROWSER.add_content("<h3><b> Syndicate Contraband </b></h3>")
			BROWSER.add_content("<hr>")
			for(var/S in items_availible_emag)
				var/obj/OBJ = new S
				BROWSER.add_content("<a href='?src=\ref[src];BuyContraband=[S]'>[OBJ]</a> Cost: [items_availible_emag[S]]")	// We send the type, then, using the type, we create the item at the deployed briefcase and search for it in the list, withdrawing thsoe points
				BROWSER.add_content("<br>")
				qdel(OBJ)


	BROWSER.open()

/obj/item/device/trader_controller/Topic(href, href_list)
	if (..()) return 1
	if (MyCell)
		if(!MyCell.checked_use(1))
			to_chat(usr, "<span class='warning'> [src] doesn't have enough charge to perform a command! </span>")
			return 0
	else
		to_chat(usr, "<span class='warning'> [src] doesn't have a cell! </span>")
		return 0

	if (usr.stat|| usr.restrained())
		return 0
	if (src.loc != usr)
		return 0

//	var/mob/user = usr
//	var/datum/nanoui/ui = nanomanager.get_open_ui(user, src, "main")

//	src.add_fingerprint(user)
	. = 0

	if (href_list["EnterPassword"])
		var/mytext =  input("Write down your password.","Your password","")
		if(mytext == password)
			is_locked = 0
		else
			alert("Contraseña incorrecta","Whoops")
		. = 1

	if (href_list["Lock"])
		is_locked = 1
		. = 1

	if (href_list["SwitchInvestment"])
		is_investing = !is_investing
		. = 1

	if (href_list["ChangeInvestment"])
		var/list/names = list(	"Sol Goverment Approved Merchandise" = "solgov",
								"Nyx Embassy Approved Merchandise" = "embassy",
								"Sterling Mannufacturers" = "sterling"
								)
		var/choice = input("Choose who to invest into", "Investments", null) in names
		investing_into = names[choice]
		. = 1

	if (href_list["GetMoney"])
		if(!isturf(usr.loc))
			to_chat(usr, "You cannot withdraw money here!")
			. = 1

		var/withdraw = input("How much money will you withdraw?", "Withdrawing", stored_money) as num
		if(withdraw > stored_money)
			withdraw = stored_money
		if(!withdraw == 0)
			playsound(src.loc, 'sound/machines/ding.ogg', 50, 1)
			spawn_money(withdraw,usr.loc,usr)
			stored_money -= withdraw
		. = 1

	if (href_list["SendMoney"])
		points += (stored_money / 25)	// From 500 to 10
		points = round(points)
		stored_money = 0
		playsound(src.loc, 'sound/machines/chime.ogg', 50, 1)
		. = 1

	if (href_list["BuySolgov"])		// We receive a TEXT that's supposed to be a TYPE
		var/OurType = text2path(href_list["BuySolgov"])
		var/cost = items_availible_solgov[OurType]
		if(istype(InstalledMod, /obj/item/device/trade_controller_mod/discount))
			var/obj/item/device/trade_controller_mod/discount/MyDiscount = InstalledMod
			cost = cost * MyDiscount.discount
		var/obj/structure/deployed_briefcase/DEPLOYED = locate() in view()
		if(points >= cost)
			if(DEPLOYED && isturf(DEPLOYED.loc))
				flick("inuse",DEPLOYED)
				points -= cost
				sleep(10)
				new OurType (DEPLOYED.loc)
				playsound(src.loc, 'sound/machines/chime.ogg', 50, 1)
				if(istype(InstalledMod, /obj/item/device/trade_controller_mod/lucky))
					if(prob(30))
						new OurType (DEPLOYED.loc)
			else
				to_chat(usr, "[src] requires a deployed relay briefcase to work")
		. = 1

	if (href_list["BuyEmbassy"])		// We receive a Type
		var/OurType = text2path(href_list["BuyEmbassy"])
		var/cost = items_availible_embassy[OurType]
		if(istype(InstalledMod, /obj/item/device/trade_controller_mod/discount))
			var/obj/item/device/trade_controller_mod/discount/MyDiscount = InstalledMod
			cost = cost * MyDiscount.discount
		var/obj/structure/deployed_briefcase/DEPLOYED = locate() in view()
		if(points >= cost)
			if(DEPLOYED && isturf(DEPLOYED.loc))
				flick("inuse",DEPLOYED)
				points -= cost
				sleep(10)
				new OurType (DEPLOYED.loc)
				if(istype(InstalledMod, /obj/item/device/trade_controller_mod/lucky))
					if(prob(30))
						new OurType (DEPLOYED.loc)
			else
				to_chat(usr, "The [src] requires a deployed relay briefcase to work")

		. = 1

	if (href_list["BuySterling"])		// We receive a Type
		var/OurType = text2path(href_list["BuySterling"])
		var/cost = items_availible_sterling[OurType]
		if(istype(InstalledMod, /obj/item/device/trade_controller_mod/discount))
			var/obj/item/device/trade_controller_mod/discount/MyDiscount = InstalledMod
			cost = cost * MyDiscount.discount
		var/obj/structure/deployed_briefcase/DEPLOYED = locate() in view()
		if(points >= cost)
			if(DEPLOYED && isturf(DEPLOYED.loc))
				flick("inuse",DEPLOYED)
				points -= cost
				sleep(10)
				new OurType (DEPLOYED.loc)
				if(istype(InstalledMod, /obj/item/device/trade_controller_mod/lucky))
					if(prob(30))
						new OurType (DEPLOYED.loc)
			else
				to_chat(usr, "The [src] requires a deployed relay briefcase to work")

		. = 1

	if (href_list["BuyContraband"])		// We receive a Type
		var/OurType = text2path(href_list["BuyContraband"])
		var/cost = items_availible_emag[OurType]
		if(istype(InstalledMod, /obj/item/device/trade_controller_mod/discount))
			var/obj/item/device/trade_controller_mod/discount/MyDiscount = InstalledMod
			cost = cost * MyDiscount.discount
		var/obj/structure/deployed_briefcase/DEPLOYED = locate() in view()
		if(points >= cost)
			if(DEPLOYED && isturf(DEPLOYED.loc))
				flick("inuse",DEPLOYED)
				points -= cost
				sleep(10)
				new OurType (DEPLOYED.loc)
				if(istype(InstalledMod, /obj/item/device/trade_controller_mod/lucky))
					if(prob(30))
						new OurType (DEPLOYED.loc)
			else
				to_chat(usr, "The [src] requires a deployed relay briefcase to work")

			. = 1

	if (href_list["RemotelyAct"])		// We receive a Type
		var/obj/structure/deployed_briefcase/DEPLOYED = locate() in view()
		var/obj/item/weapon/storage/briefcase/deployable_briefcase/BRIEFCASE = locate() in view()
		if(DEPLOYED && isturf(DEPLOYED.loc))
			flick("inuse",DEPLOYED)
			sleep(10)
			DEPLOYED.Compact()
		else if(BRIEFCASE && isturf(BRIEFCASE.loc))
			BRIEFCASE.Deploy()
		else
			to_chat(usr, "[src] requires a deployed relay briefcase to work")
//		. = 1

	if (href_list["RecallBriefcase"])		// We receive a Type
		var/mob/living/carbon/human/MYHUMAN
		if(istype(src.loc, /mob/living/carbon/human))
			MYHUMAN = src.loc
		var/obj/item/weapon/storage/briefcase/deployable_briefcase/DEPLOYED = locate() in view()
		if(DEPLOYED && isturf(DEPLOYED.loc) && MYHUMAN)
			DEPLOYED.throw_at(MYHUMAN, 7, 1)
		else
			to_chat(usr, "[src] requires a deployed relay briefcase to work")
//		. = 1

	if (href_list["ActivateModAbility"])
		if(InstalledMod.has_ability)
			InstalledMod.controller_ability()
			. = 1

	if(.)
		show_list(usr)
		return .