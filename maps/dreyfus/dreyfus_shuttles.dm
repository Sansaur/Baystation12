/datum/shuttle/multi_shuttle/rescue
	name = "Rescue"
	warmup_time = 0
	origin = /area/shuttle/lavalette/start
	interim = /area/shuttle/lavalette/transit
	start_location = "Espace de Patrouille"
	destinations = list(
		"Proche de la Coupole" = /area/shuttle/lavalette/coupole,
		"Au sas de Xenoarcheologie" = /area/shuttle/lavalette/xeno,
		"Pres de l'acces Residentiel" = /area/shuttle/lavalette/residentiel,
		)
	docking_controller_tag = "rescue_shuttle"
	destination_dock_targets = list(
		"Response Team Base" = "rescue_base",
		"Arrivals dock" = "rescue_shuttle_dock_airlock",
		)
	announcer = "CRV La Valette"

/datum/shuttle/multi_shuttle/rescue/New()
	arrival_message = "Attention, [using_map.station_short], there's a small patrol craft headed your way, it flashed us Asset Protection codes and we let it pass. You've got guests on the way."
	departure_message = "[using_map.station_short], That Asset Protection vessel is headed back the way it came. Hope they were helpful."
	..()

/datum/shuttle/ferry/supply/cargo
	name = "Supply"
	location = 1
	warmup_time = 5
	area_offsite = /area/supply/dock
	area_station = /area/supply/station
	docking_controller_tag = "supply_shuttle"
	dock_target_station = "cargo_bay"

/datum/shuttle/ferry/emergency/centcom
	name = "Escape"
	location = 1
	warmup_time = 10
	area_offsite = /area/shuttle/escape/centcom
	area_station = /area/shuttle/escape/station
	area_transition = /area/shuttle/escape/transit
	docking_controller_tag = "escape_shuttle"
	dock_target_station = "escape_dock"
	dock_target_offsite = "centcom_dock"
	transit_direction = EAST

/datum/shuttle/multi_shuttle/mercenary
	name = "Mercenary"
	warmup_time = 0
	origin = /area/shuttle/merc/start
	interim = /area/shuttle/merc/transit
	start_location = "Base Mercenaire"
	destinations = list(
		"Dock Station" = /area/shuttle/merc/station,
		"Proche de la Coupole" = /area/shuttle/merc/coupole,
		"Au sas de Minage" = /area/shuttle/merc/minage,
		"Pres de l'acces Residentiel" = /area/shuttle/merc/residentiel,
		)
	docking_controller_tag = "ship_merc"
	destination_dock_targets = list(
		"Base Mercenaire" = "dock_merc",
		"Dock Station" = "dock1",
		)
	announcer = "CRV La Valette"

/datum/shuttle/multi_shuttle/mercenary/New()
	arrival_message = "Attention, [using_map.station_short], you have a large signature approaching the station - looks unarmed to surface scans. We're too far out to intercept - brace for visitors."
	departure_message = "Your visitors are on their way out of the system, [using_map.station_short], burning delta-v like it's nothing. Good riddance."
	..()

/datum/shuttle/ferry/escape_pod/escape_pod_one
	name = "Escape Pod 1"
	location = 0
	warmup_time = 0
	area_station = /area/shuttle/escape_pod1/station
	area_offsite = /area/shuttle/escape_pod1/centcom
	area_transition = /area/shuttle/escape_pod1/transit
	docking_controller_tag = "evacpod1"
	dock_target_station = "evacpod1_sas"
	transit_direction = EAST
