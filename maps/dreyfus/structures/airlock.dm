/obj/machinery/door/airlock
	name = "airlock"
	icon = 'maps/dreyfus/icons/doors/Doorint.dmi'

/obj/machinery/door/airlock/command
	name = "Airlock"
	icon = 'maps/dreyfus/icons/doors/Doorcom.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_com

/obj/machinery/door/airlock/security
	name = "Airlock"
	icon = 'maps/dreyfus/icons/doors/Doorsec.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_sec

/obj/machinery/door/airlock/engineering
	name = "Airlock"
	icon = 'maps/dreyfus/icons/doors/Dooreng.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_eng

/obj/machinery/door/airlock/medical
	name = "Airlock"
	icon = 'maps/dreyfus/icons/doors/Doormed.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_med

/obj/machinery/door/airlock/maintenance
	name = "Maintenance Access"
	icon = 'maps/dreyfus/icons/doors/Doormaint.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_mai

/obj/machinery/door/airlock/external
	name = "External Airlock"
	icon = 'maps/dreyfus/icons/doors/Doorext.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_ext

/obj/machinery/door/airlock/glass
	name = "Glass Airlock"
	icon = 'maps/dreyfus/icons/doors/Doorglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'

	open_sound_powered = 'sound/machines/windowdoor.ogg'
	close_sound_powered = 'sound/machines/windowdoor.ogg'

	door_crush_damage = DOOR_CRUSH_DAMAGE*0.75
	maxhealth = 300
	explosion_resistance = 5
	opacity = 0
	glass = 1

/obj/machinery/door/airlock/centcom
	name = "Airlock"
	icon = 'icons/obj/doors/Doorele.dmi'
	opacity = 1

/obj/machinery/door/airlock/vault
	name = "Vault"
	icon = 'maps/dreyfus/icons/doors/vault.dmi'
	explosion_resistance = 20
	opacity = 1
	secured_wires = 1
	assembly_type = /obj/structure/door_assembly/door_assembly_highsecurity //Until somebody makes better sprites.

/obj/machinery/door/airlock/freezer
	name = "Freezer Airlock"
	icon = 'maps/dreyfus/icons/doors/Doorfreezer.dmi'
	opacity = 1
	assembly_type = /obj/structure/door_assembly/door_assembly_fre

/obj/machinery/door/airlock/hatch
	name = "Airtight Hatch"
	icon = 'maps/dreyfus/icons/doors/Doorhatchele.dmi'
	explosion_resistance = 20
	opacity = 1
	assembly_type = /obj/structure/door_assembly/door_assembly_hatch

/obj/machinery/door/airlock/maintenance_hatch
	name = "Maintenance Hatch"
	icon = 'maps/dreyfus/icons/doors/Doorhatchmaint2.dmi'
	explosion_resistance = 20
	opacity = 1
	assembly_type = /obj/structure/door_assembly/door_assembly_mhatch

/obj/machinery/door/airlock/maintenance_hatch/bolted
	locked = 1
	icon_state = "door_locked"

/obj/machinery/door/airlock/glass_command
	name = "Maintenance Hatch"
	icon = 'maps/dreyfus/icons/doors/Doorcomglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxhealth = 300
	explosion_resistance = 5
	opacity = 0
	assembly_type = /obj/structure/door_assembly/door_assembly_com
	glass = 1

/obj/machinery/door/airlock/glass_engineering
	name = "Maintenance Hatch"
	icon = 'maps/dreyfus/icons/doors/Doorengglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxhealth = 300
	explosion_resistance = 5
	opacity = 0
	assembly_type = /obj/structure/door_assembly/door_assembly_eng
	glass = 1

/obj/machinery/door/airlock/glass_security
	name = "Maintenance Hatch"
	icon = 'maps/dreyfus/icons/doors/Doorsecglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxhealth = 300
	explosion_resistance = 5
	opacity = 0
	assembly_type = /obj/structure/door_assembly/door_assembly_sec
	glass = 1

/obj/machinery/door/airlock/glass_medical
	name = "Maintenance Hatch"
	icon = 'maps/dreyfus/icons/doors/Doormedglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxhealth = 300
	explosion_resistance = 5
	opacity = 0
	assembly_type = /obj/structure/door_assembly/door_assembly_med
	glass = 1

/obj/machinery/door/airlock/mining
	name = "Mining Airlock"
	icon = 'maps/dreyfus/icons/doors/Doormining.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_min

/obj/machinery/door/airlock/atmos
	name = "Atmospherics Airlock"
	icon = 'maps/dreyfus/icons/doors/Dooratmo.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_atmo

/obj/machinery/door/airlock/research
	name = "Airlock"
	icon = 'maps/dreyfus/icons/doors/Doorresearch.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_research

/obj/machinery/door/airlock/glass_research
	name = "Maintenance Hatch"
	icon = 'maps/dreyfus/icons/doors/Doorresearchglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxhealth = 300
	explosion_resistance = 5
	opacity = 0
	assembly_type = /obj/structure/door_assembly/door_assembly_research
	glass = 1
	heat_proof = 1

/obj/machinery/door/airlock/glass_mining
	name = "Maintenance Hatch"
	icon = 'maps/dreyfus/icons/doors/Doorminingglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxhealth = 300
	explosion_resistance = 5
	opacity = 0
	assembly_type = /obj/structure/door_assembly/door_assembly_min
	glass = 1

/obj/machinery/door/airlock/glass_atmos
	name = "Maintenance Hatch"
	icon = 'maps/dreyfus/icons/doors/Dooratmoglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxhealth = 300
	explosion_resistance = 5
	opacity = 0
	assembly_type = /obj/structure/door_assembly/door_assembly_atmo
	glass = 1

/obj/machinery/door/airlock/gold
	name = "Gold Airlock"
	icon = 'maps/dreyfus/icons/doors/Doorgold.dmi'
	mineral = "gold"

/obj/machinery/door/airlock/silver
	name = "Silver Airlock"
	icon = 'maps/dreyfus/icons/doors/Doorsilver.dmi'
	mineral = "silver"

/obj/machinery/door/airlock/diamond
	name = "Diamond Airlock"
	icon = 'maps/dreyfus/icons/doors/Doordiamond.dmi'
	mineral = "diamond"

/obj/machinery/door/airlock/multi_tile/glass
	name = "Glass Airlock"
	icon = 'maps/dreyfus/icons/doors/Door2x1glass.dmi'
	opacity = 0
	glass = 1
	assembly_type = /obj/structure/door_assembly/multi_tile

	/* NEW AIRLOCKS BLOCK
Got this from Eris so we can get a good industrial setting - Prometh */

/obj/machinery/door/airlock/multi_tile/metal/mait
	icon = 'maps/dreyfus/icons/doors/Door2x1_Maint.dmi'

/obj/machinery/door/airlock/maintenance_cargo
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_cargo.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_cargo

/obj/machinery/door/airlock/maintenance_command
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_command.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_command

/obj/machinery/door/airlock/maintenance_engineering
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_engi.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_engi

/obj/machinery/door/airlock/maintenance_medical
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_med.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_med

/obj/machinery/door/airlock/maintenance_rnd
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_rnd.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_rnd

/obj/machinery/door/airlock/maintenance_security
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_sec.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_sec

/obj/machinery/door/airlock/maintenance_common
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_common.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_common

/obj/machinery/door/airlock/maintenance_interior
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_int.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_int

		/* NEW AIRLOCKS BLOCK END */