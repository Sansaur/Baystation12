
/datum/map/dreyfus
	name = "Dreyfus"
	full_name = "SSNI Dreyfus"
	path = "dreyfus"

	lobby_icon = 'maps/dreyfus/icons/lobby.dmi'

	station_levels = list(1,2,3,4,5,6)
	contact_levels = list(1,2,3,4,5,6)
	player_levels = list(1,2,3,4,5,6)
	accessible_z_levels = list("1"=1,"2"=1,"3"=1,"4"=1,"5"=1,"6"=1)

	station_name  = "SSNI Dreyfus"
	station_short = "Dreyfus"
	dock_name     = "Avant-Poste Carthage" // sur Charnay-4
	boss_name     = "Direction Centrale"
	boss_short    = "DIRCEN"
	company_name  = "NanoTrasen Industries & Co"
	company_short = "NTI"
	system_name = "Iota-Pavonis"

	shuttle_docked_message = "La navette de roulement arrivée de %Dock_name% s'est amarée à la station. Départ dans %ETD%"
	shuttle_leaving_dock = "La navette de roulement d'équipage s'est désamarée. Arrivé estimée dans %ETA%."
	shuttle_called_message = "Un roulement d'équipage vers %Dock_name% viens d'être planifié. Une navette de transfert a été appelée. Elle arrivera dans approximativement %ETA%"
	shuttle_recall_message = "Le roulement de l'équipage a été annulé."
	emergency_shuttle_docked_message = "La navette d'évacuation s'est amarrée à la station. Vous êtes prié d'évacuer d'ici %ETD%."
	emergency_shuttle_leaving_dock = "La navette d'évacuation s'est désamarée. Arrivé estimée dans %ETA%."
	emergency_shuttle_called_message = "La navette d'évacuation a été appelée. Elle arrivera dans approximativement %ETA%"
	emergency_shuttle_recall_message = "La navette d'évacuation a été rappelée. Le coût de cette manoevre sera déduit directement de vos salaires."

	evac_controller_type = /datum/evacuation_controller/shuttle