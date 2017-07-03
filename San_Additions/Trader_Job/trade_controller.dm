/obj/item/device/trader_controller
	name = "trader controller"
	desc = "The core of good'ol capitalism."
	icon = 'items.dmi'
	icon_state = "controller"
	item_state = "analyzer"
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
		/obj/item/clothing/under/confederacy = 15
	)
	// Embassy Approved Merchandise - Exotic items from the various species
	var/list/items_availible_embassy = list(
		/obj/item/clothing/under/psysuit = 20,
		/obj/item/clothing/suit/tajaran/furs = 30
	)

	// Sterling Manufactures - Mega luxurious shit
	var/list/items_availible_sterling = list(
		/obj/item/clothing/under/scratch = 55,
		/obj/item/clothing/glasses/sunglasses/big = 40
	)

	var/list/items_possible_solgov = list(
		/obj/item/clothing/under/schoolgirl = 10,
		/obj/item/clothing/under/confederacy = 15
	)
	var/list/items_possible_embassy = list(
		/obj/item/clothing/under/psysuit = 20,
		/obj/item/clothing/suit/tajaran/furs = 30
	)
	var/list/items_possible_sterling = list(
		/obj/item/clothing/under/scratch = 55,
		/obj/item/clothing/glasses/sunglasses/big = 40
	)

	// When emagged, it'll show 'exotic' contraband
	var/list/items_availible_emag = list(
		/obj/item/clothing/under/scratch = 55,
		/obj/item/clothing/glasses/sunglasses/big = 40
	)

	var/obj/item/weapon/cell/device/MyCell
	var/is_open = 0
/obj/item/device/trader_controller/New()
	..()
	MyCell = new /obj/item/weapon/cell/device/high (src)
	password = pick("solgov[rand(1000,9999)]","embassy[rand(1000,9999)]","warup[rand(1000,9999)]","donkco[rand(1000,9999)]","trading[rand(1000,9999)]")
	if(ismob(loc))
		if(istype(loc, /mob/living/carbon/human))
			var/mob/living/carbon/human/MyHuman = loc
			if(MyHuman.mind)
				MyHuman.mind.store_memory("Your trader device password is:[password]")
				to_chat(MyHuman,"Your trader device password is:[password]")

/obj/item/device/trader_controller/update_icon()

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

/obj/item/device/trader_controller/attack_hand(mob/user as mob)
	if(ismob(loc))
		if(is_open)
			MyCell.loc = user.loc
			MyCell = null
			playsound(src.loc, 'sound/machines/button.ogg', 50, 1)
			if(istype(user, /mob/living/carbon/human))
				var/mob/living/carbon/human/MY = user
				MY.put_in_hands(MyCell)
			update_icon()
		else
			..()
	else
		..()

/obj/item/device/trader_controller/attackby(obj/item/W, mob/user as mob)
	if(istype(W, /obj/item/weapon/screwdriver))
		var/obj/item/weapon/screwdriver/MM = W
		is_open = !is_open
		playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
		if(is_open)
			to_chat(user, "You open [src] with [MM]")
		else
			to_chat(user, "You close [src] with [MM]")
			icon_state = "controller"
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
					var/chosen_type = pick(items_possible_solgov)
					items_possible_solgov.Remove(chosen_type)
					items_availible_solgov.Add(chosen_type)
					items_availible_solgov[chosen_type] = rand(20,40)
				if("embassy")
					if(!items_possible_embassy.len)
						visible_message("<span class='warning'> [src] beeps, \"That company won't send us any more new items\" </span>")
						return
					var/chosen_type = pick(items_possible_embassy)
					items_possible_embassy.Remove(chosen_type)
					items_availible_embassy.Add(chosen_type)
					items_availible_embassy[chosen_type] = rand(30,50)

				if("sterling")
					if(!items_possible_sterling.len)
						visible_message("<span class='warning'> [src] beeps, \"That company won't send us any more new items\" </span>")
						return
					var/chosen_type = pick(items_possible_sterling)
					items_possible_sterling.Remove(chosen_type)
					items_availible_sterling.Add(chosen_type)
					items_availible_sterling[chosen_type] = rand(60,80)


/obj/item/device/trader_controller/proc/show_list(mob/user as mob)
	if(!MyCell)
		return

	var/datum/browser/BROWSER = new(user, "Trade Control", "Trade Control", 500, 600, src)
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
		BROWSER.add_content("<br>")

		BROWSER.add_content("<h3><b> Solgov Approved Merchandise </b></h3>")
		BROWSER.add_content("<hr>")
		for(var/S in items_availible_solgov)
			var/obj/OBJ = new S
			BROWSER.add_content("<a href='?src=\ref[src];BuySolgov=[S]'>[OBJ] Coste: [items_availible_solgov[S]]</a>")	// We send the type, then, using the type, we create the item at the deployed briefcase and search for it in the list, withdrawing thsoe points
			BROWSER.add_content("<br>")
			qdel(OBJ)

		BROWSER.add_content("<h3><b> Embassy Approved Merchandise </b></h3>")
		BROWSER.add_content("<hr>")
		for(var/S in items_availible_embassy)
			var/obj/OBJ = new S
			BROWSER.add_content("<a href='?src=\ref[src];BuyEmbassy=[S]'>[OBJ] Coste: [items_availible_embassy[S]]</a>")	// We send the type, then, using the type, we create the item at the deployed briefcase and search for it in the list, withdrawing thsoe points
			BROWSER.add_content("<br>")
			qdel(OBJ)

		BROWSER.add_content("<h3><b> Sterling Manufacturers Merchandise </b></h3>")
		BROWSER.add_content("<hr>")
		for(var/S in items_availible_sterling)
			var/obj/OBJ = new S
			BROWSER.add_content("<a href='?src=\ref[src];BuySterling=[S]'>[OBJ] Coste: [items_availible_sterling[S]]</a>")	// We send the type, then, using the type, we create the item at the deployed briefcase and search for it in the list, withdrawing thsoe points
			BROWSER.add_content("<br>")
			qdel(OBJ)

		if(is_emagged)
			BROWSER.add_content("<h3><b> Syndicate Contraband </b></h3>")
			BROWSER.add_content("<hr>")
			for(var/S in items_availible_emag)
				var/obj/OBJ = new S
				BROWSER.add_content("<a href='?src=\ref[src];BuyContraband=[S]'>[OBJ]</a>")	// We send the type, then, using the type, we create the item at the deployed briefcase and search for it in the list, withdrawing thsoe points
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
		var/obj/item/weapon/spacecash/Money = new(usr.loc)
		Money.worth = withdraw
		Money.update_icon()
		stored_money -= withdraw
		. = 1

	if (href_list["SendMoney"])
		points += (stored_money / 25)	// From 500 to 10
		points = round(points)
		stored_money = 0
		. = 1

	if (href_list["BuySolgov"])		// We receive a TEXT that's supposed to be a TYPE
		var/OurType = text2path(href_list["BuySolgov"])
		var/cost = items_availible_solgov[OurType]
		var/obj/structure/deployed_briefcase/DEPLOYED = locate() in view()
		if(points >= cost)
			if(DEPLOYED && isturf(DEPLOYED.loc))
				flick("inuse",DEPLOYED)
				points -= cost
				new OurType (DEPLOYED.loc)
			else
				to_chat(usr, "[src] requires a deployed relay briefcase to work")
		. = 1

	if (href_list["BuyEmbassy"])		// We receive a Type
		var/OurType = text2path(href_list["BuyEmbassy"])
		var/cost = items_availible_embassy[OurType]
		message_admins("Costo debug: [cost]")
		var/obj/structure/deployed_briefcase/DEPLOYED = locate() in view()
		if(points >= cost)
			if(DEPLOYED && isturf(DEPLOYED.loc))
				flick("inuse",DEPLOYED)
				points -= cost
				new OurType (DEPLOYED.loc)
			else
				to_chat(usr, "The [src] requires a deployed relay briefcase to work")

		. = 1

	if (href_list["BuySterling"])		// We receive a Type
		var/OurType = text2path(href_list["BuySterling"])
		var/cost = items_availible_sterling[OurType]
		message_admins("Costo debug: [cost]")
		var/obj/structure/deployed_briefcase/DEPLOYED = locate() in view()
		if(points >= cost)
			if(DEPLOYED && isturf(DEPLOYED.loc))
				flick("inuse",DEPLOYED)
				points -= cost
				new OurType (DEPLOYED.loc)
			else
				to_chat(usr, "The [src] requires a deployed relay briefcase to work")

		. = 1

	if (href_list["BuyContraband"])		// We receive a Type
		var/OurType = text2path(href_list["BuyContraband"])
		var/cost = items_availible_sterling[OurType]
		var/obj/structure/deployed_briefcase/DEPLOYED = locate() in view()
		if(points >= cost)
			if(DEPLOYED && isturf(DEPLOYED.loc))
				flick("inuse",DEPLOYED)
				points -= cost
				new OurType (DEPLOYED.loc)
			else
				to_chat(usr, "The [src] requires a deployed relay briefcase to work")

			. = 1


	if(.)
		show_list(usr)
		return .